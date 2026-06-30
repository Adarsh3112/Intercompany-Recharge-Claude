codeunit 50100 "IC Recharge Management"
{
    procedure ValidateRechargeRequest(var ICRechargeHeader: Record "IC Recharge Header"): Boolean
    var
        ICRechargeLine: Record "IC Recharge Line";
        TotalAllocated: Decimal;
        AllLinesValid: Boolean;
    begin
        ICRechargeHeader.TestField("No.");
        ICRechargeHeader.TestField("Posting Date");
        ICRechargeHeader.TestField("Source Company");

        AllLinesValid := true;
        TotalAllocated := 0;

        ICRechargeLine.SetRange("Document No.", ICRechargeHeader."No.");
        if not ICRechargeLine.FindSet() then
            Error('No lines exist for recharge document %1', ICRechargeHeader."No.");

        repeat
            if not ICRechargeLine.ValidateLine() then
                AllLinesValid := false;
            ICRechargeLine.Modify();
            TotalAllocated += ICRechargeLine."Allocated Amount";
        until ICRechargeLine.Next() = 0;

        if not AllLinesValid then
            Error('One or more lines failed validation');

        ICRechargeHeader.CalcFields("Total Amount", "Total Allocated Amount");

        if ICRechargeHeader."Total Allocated Amount" > ICRechargeHeader."Total Amount" then
            Error('Total allocated amount %1 exceeds source amount %2',
                ICRechargeHeader."Total Allocated Amount", ICRechargeHeader."Total Amount");

        ICRechargeHeader.Status := ICRechargeHeader.Status::Validated;
        ICRechargeHeader.Modify();

        LogAudit(ICRechargeHeader."No.", 0, 'Document validated');

        exit(true);
    end;

    procedure SubmitForApproval(var ICRechargeHeader: Record "IC Recharge Header")
    var
        ICRechargeConfig: Record "IC Recharge Config";
    begin
        if ICRechargeHeader.Status <> ICRechargeHeader.Status::Validated then
            Error('Document must be validated before submission');

        ICRechargeConfig.GetInstance();
        ICRechargeHeader.CalcFields("Total Allocated Amount");

        if ICRechargeConfig."Require Approval" or
           (ICRechargeHeader."Total Allocated Amount" > ICRechargeConfig."Default Approval Threshold")
        then begin
            ICRechargeHeader."Approval Required" := true;
            ICRechargeHeader.Status := ICRechargeHeader.Status::"Pending Approval";
        end else begin
            ICRechargeHeader."Approval Required" := false;
            ICRechargeHeader.Status := ICRechargeHeader.Status::Approved;
            ICRechargeHeader."Approved By" := CopyStr(UserId(), 1, 50);
            ICRechargeHeader."Approval Date" := CurrentDateTime();
        end;

        ICRechargeHeader.Modify();
        LogAudit(ICRechargeHeader."No.", 0, 'Document submitted for approval');
    end;

    procedure ApproveRechargeRequest(var ICRechargeHeader: Record "IC Recharge Header")
    begin
        if ICRechargeHeader.Status <> ICRechargeHeader.Status::"Pending Approval" then
            Error('Document is not pending approval');

        ICRechargeHeader.Status := ICRechargeHeader.Status::Approved;
        ICRechargeHeader."Approved By" := CopyStr(UserId(), 1, 50);
        ICRechargeHeader."Approval Date" := CurrentDateTime();
        ICRechargeHeader.Modify();

        LogAudit(ICRechargeHeader."No.", 0, 'Document approved');
    end;

    procedure RejectRechargeRequest(var ICRechargeHeader: Record "IC Recharge Header"; Reason: Text[100])
    begin
        if ICRechargeHeader.Status <> ICRechargeHeader.Status::"Pending Approval" then
            Error('Document is not pending approval');

        ICRechargeHeader.Status := ICRechargeHeader.Status::Rejected;
        ICRechargeHeader."Exception Flag" := true;
        ICRechargeHeader."Exception Message" := CopyStr(Reason, 1, 250);
        ICRechargeHeader.Modify();

        LogAudit(ICRechargeHeader."No.", 0, StrSubstNo('Document rejected: %1', Reason));
    end;

    procedure PostRechargeRequest(var ICRechargeHeader: Record "IC Recharge Header")
    var
        ICRechargeLine: Record "IC Recharge Line";
        PostedHeader: Record "IC Recharge Posted Header";
        PostedLine: Record "IC Recharge Posted Line";
        LineNo: Integer;
    begin
        if ICRechargeHeader.Status <> ICRechargeHeader.Status::Approved then
            Error('Document must be approved before posting');

        if ICRechargeHeader.Posted then
            Error('Document %1 has already been posted', ICRechargeHeader."No.");

        ICRechargeHeader.CalcFields("Total Amount", "Total Allocated Amount");

        PostedHeader.Init();
        PostedHeader.TransferFields(ICRechargeHeader);
        PostedHeader."Pre-Assigned No." := ICRechargeHeader."No.";
        PostedHeader."Total Amount" := ICRechargeHeader."Total Amount";
        PostedHeader."Total Allocated Amount" := ICRechargeHeader."Total Allocated Amount";
        PostedHeader."Posted Date" := CurrentDateTime();
        PostedHeader."Posted By" := CopyStr(UserId(), 1, 50);
        PostedHeader.Insert(true);

        ICRechargeLine.SetRange("Document No.", ICRechargeHeader."No.");
        if ICRechargeLine.FindSet() then
            repeat
                PostedLine.Init();
                PostedLine.TransferFields(ICRechargeLine);
                PostedLine."Document No." := PostedHeader."No.";
                PostedLine.Insert(true);

                ICRechargeLine.Posted := true;
                ICRechargeLine.Modify();
            until ICRechargeLine.Next() = 0;

        ICRechargeHeader.Posted := true;
        ICRechargeHeader."Posted Date" := CurrentDateTime();
        ICRechargeHeader."Posted By" := CopyStr(UserId(), 1, 50);
        ICRechargeHeader.Status := ICRechargeHeader.Status::Posted;
        ICRechargeHeader.Modify();

        LogAudit(ICRechargeHeader."No.", 0, StrSubstNo('Document posted as %1', PostedHeader."No."));
    end;

    procedure ReversePostedRecharge(var PostedHeader: Record "IC Recharge Posted Header"; ReversalReason: Text[100])
    var
        ICRechargeHeader: Record "IC Recharge Header";
        NewHeader: Record "IC Recharge Header";
        PostedLine: Record "IC Recharge Posted Line";
        NewLine: Record "IC Recharge Line";
        NextLineNo: Integer;
    begin
        if PostedHeader.Reversed then
            Error('Document %1 has already been reversed', PostedHeader."No.");

        if PostedHeader."Pre-Assigned No." <> '' then begin
            if ICRechargeHeader.Get(PostedHeader."Pre-Assigned No.") then begin
                if ICRechargeHeader.Reversed then
                    Error('Original document has already been reversed');
                ICRechargeHeader.Reversed := true;
                ICRechargeHeader."Reversal Date" := CurrentDateTime();
                ICRechargeHeader."Reversal Reason" := ReversalReason;
                ICRechargeHeader.Modify();
            end;
        end;

        NewHeader.Init();
        NewHeader."Source Company" := PostedHeader."Source Company";
        NewHeader."Recharge Type" := PostedHeader."Recharge Type";
        NewHeader.Description := CopyStr(StrSubstNo('Reversal of %1', PostedHeader."No."), 1, 100);
        NewHeader."Posting Date" := WorkDate();
        NewHeader."Document Date" := WorkDate();
        NewHeader."Currency Code" := PostedHeader."Currency Code";
        NewHeader."Exchange Rate" := PostedHeader."Exchange Rate";
        NewHeader."Original Document No." := PostedHeader."No.";
        NewHeader."Reversal Reason" := ReversalReason;
        NewHeader.Insert(true);

        NextLineNo := 10000;
        PostedLine.SetRange("Document No.", PostedHeader."No.");
        if PostedLine.FindSet() then
            repeat
                NewLine.Init();
                NewLine."Document No." := NewHeader."No.";
                NewLine."Line No." := NextLineNo;
                NewLine."IC Partner Code" := PostedLine."IC Partner Code";
                NewLine."Target Company" := PostedLine."Target Company";
                NewLine."Source G/L Account No." := PostedLine."Source G/L Account No.";
                NewLine."Target IC G/L Account No." := PostedLine."Target IC G/L Account No.";
                NewLine."Source Amount" := -PostedLine."Source Amount";
                NewLine."Allocation %" := PostedLine."Allocation %";
                NewLine."Allocated Amount" := -PostedLine."Allocated Amount";
                NewLine."Currency Code" := PostedLine."Currency Code";
                NewLine."Exchange Rate" := PostedLine."Exchange Rate";
                NewLine."Dimension Set ID" := PostedLine."Dimension Set ID";
                NewLine."Target Dimension Set ID" := PostedLine."Target Dimension Set ID";
                NewLine.Description := CopyStr(StrSubstNo('Reversal: %1', PostedLine.Description), 1, 100);
                NewLine.Insert(true);
                NextLineNo += 10000;
            until PostedLine.Next() = 0;

        PostedHeader.Reversed := true;
        PostedHeader."Reversal Date" := CurrentDateTime();
        PostedHeader."Reversal Reason" := ReversalReason;
        PostedHeader.Modify();

        LogAudit(PostedHeader."No.", 0, StrSubstNo('Document reversed, new document %1 created', NewHeader."No."));
    end;

    procedure CalculateAllocation(var ICRechargeLine: Record "IC Recharge Line")
    var
        ICRechargeSetup: Record "IC Recharge Setup";
    begin
        ICRechargeSetup.SetRange("IC Partner Code", ICRechargeLine."IC Partner Code");
        if ICRechargeSetup.FindFirst() then begin
            case ICRechargeSetup."Allocation Basis" of
                ICRechargeSetup."Allocation Basis"::"Fixed Percentage":
                    begin
                        ICRechargeLine."Allocation %" := ICRechargeSetup."Default Allocation %";
                        ICRechargeLine."Allocated Amount" :=
                            Round(ICRechargeLine."Source Amount" * ICRechargeLine."Allocation %" / 100, 0.01);
                    end;
                ICRechargeSetup."Allocation Basis"::"Amount Based":
                    begin
                        ICRechargeLine."Allocated Amount" := ICRechargeLine."Source Amount";
                        ICRechargeLine."Allocation %" := 100;
                    end;
            end;
            ICRechargeLine."Allocation Basis" := ICRechargeSetup."Allocation Basis";
        end;
    end;

    procedure CheckDuplicatePosting(DocumentNo: Code[20]): Boolean
    var
        ICRechargeHeader: Record "IC Recharge Header";
    begin
        if ICRechargeHeader.Get(DocumentNo) then
            exit(ICRechargeHeader.Posted);
        exit(false);
    end;

    procedure BalanceAllocations(var ICRechargeHeader: Record "IC Recharge Header")
    var
        ICRechargeLine: Record "IC Recharge Line";
        TotalSource: Decimal;
        TotalAllocated: Decimal;
        RoundingDiff: Decimal;
        LastLine: Record "IC Recharge Line";
    begin
        ICRechargeLine.SetRange("Document No.", ICRechargeHeader."No.");
        if ICRechargeLine.FindSet() then begin
            repeat
                TotalSource += ICRechargeLine."Source Amount";
                TotalAllocated += ICRechargeLine."Allocated Amount";
                LastLine := ICRechargeLine;
            until ICRechargeLine.Next() = 0;

            RoundingDiff := TotalSource - TotalAllocated;
            if RoundingDiff <> 0 then begin
                LastLine."Rounding Adjustment" := RoundingDiff;
                LastLine."Allocated Amount" += RoundingDiff;
                LastLine.Modify();
            end;
        end;
    end;

    local procedure LogAudit(DocumentNo: Code[20]; ActionType: Integer; Desc: Text[250])
    var
        AuditLog: Record "IC Recharge Audit Log";
    begin
        AuditLog.LogAction(DocumentNo, ActionType, Desc);
    end;

    procedure ValidateDimensionMapping(SourceDimSetID: Integer; ICPartnerCode: Code[20]): Integer
    var
        DimSetEntry: Record "Dimension Set Entry";
        ICDimMapping: Record "IC Dimension Mapping";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimMgt: Codeunit DimensionManagement;
        TargetDimSetID: Integer;
    begin
        DimSetEntry.SetRange("Dimension Set ID", SourceDimSetID);
        if DimSetEntry.FindSet() then
            repeat
                ICDimMapping.Reset();
                ICDimMapping.SetRange("Source Dimension Code", DimSetEntry."Dimension Code");
                ICDimMapping.SetRange("Source Dimension Value", DimSetEntry."Dimension Value Code");
                ICDimMapping.SetRange("IC Partner Code", ICPartnerCode);
                if ICDimMapping.FindFirst() and not ICDimMapping.Blocked then begin
                    TempDimSetEntry.Init();
                    TempDimSetEntry."Dimension Set ID" := 0;
                    TempDimSetEntry."Dimension Code" := ICDimMapping."Target IC Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := ICDimMapping."Target IC Dimension Value";
                    if TempDimSetEntry.Insert() then;
                end;
            until DimSetEntry.Next() = 0;

        TargetDimSetID := DimMgt.GetDimensionSetID(TempDimSetEntry);
        exit(TargetDimSetID);
    end;
}
