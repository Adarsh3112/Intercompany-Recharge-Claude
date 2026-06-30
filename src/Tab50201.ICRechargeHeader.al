table 50201 "IC Recharge Header"
{
    DataClassification = CustomerContent;
    Caption = 'IC Recharge Header';
    LookupPageId = "IC Recharge Requests";
    DrillDownPageId = "IC Recharge Requests";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    TestField("No. Series", '');
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Source Company"; Text[30])
        {
            Caption = 'Source Company';
            DataClassification = CustomerContent;
        }
        field(4; "Recharge Type"; Code[20])
        {
            Caption = 'Recharge Type';
            DataClassification = CustomerContent;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(6; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Draft,Validated,"Pending Approval",Approved,Rejected,Posted,Reversed,Closed;
            OptionCaption = 'Draft,Validated,Pending Approval,Approved,Rejected,Posted,Reversed,Closed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;
            CalcFormula = sum("IC Recharge Line"."Source Amount" where("Document No." = field("No.")));
            Editable = false;
        }
        field(9; "Total Allocated Amount"; Decimal)
        {
            Caption = 'Total Allocated Amount';
            FieldClass = FlowField;
            CalcFormula = sum("IC Recharge Line"."Allocated Amount" where("Document No." = field("No.")));
            Editable = false;
        }
        field(10; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(11; "Exchange Rate"; Decimal)
        {
            Caption = 'Exchange Rate';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(12; "Approval Required"; Boolean)
        {
            Caption = 'Approval Required';
            DataClassification = CustomerContent;
        }
        field(13; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Approval Date"; DateTime)
        {
            Caption = 'Approval Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Posted"; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Posted Date"; DateTime)
        {
            Caption = 'Posted Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Reversed"; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Reversal Date"; DateTime)
        {
            Caption = 'Reversal Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Reversal Reason"; Text[100])
        {
            Caption = 'Reversal Reason';
            DataClassification = CustomerContent;
        }
        field(21; "Original Document No."; Code[20])
        {
            Caption = 'Original Document No.';
            DataClassification = CustomerContent;
        }
        field(22; "Correction"; Boolean)
        {
            Caption = 'Correction';
            DataClassification = CustomerContent;
        }
        field(23; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(31; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(32; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(40; "Exception Flag"; Boolean)
        {
            Caption = 'Exception Flag';
            DataClassification = CustomerContent;
        }
        field(41; "Exception Message"; Text[250])
        {
            Caption = 'Exception Message';
            DataClassification = CustomerContent;
        }
        field(42; "Processing Status"; Option)
        {
            Caption = 'Processing Status';
            OptionMembers = " ",Pending,"In Progress",Completed,Failed;
            OptionCaption = ' ,Pending,In Progress,Completed,Failed';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key2; Status, "Posting Date")
        {
        }
        key(Key3; "Source Company", "Recharge Type")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            "No." := GetNextNo();
        end;
        "Created By" := CopyStr(UserId(), 1, 50);
        "Created Date" := CurrentDateTime();
        "Modified By" := CopyStr(UserId(), 1, 50);
        "Modified Date" := CurrentDateTime();
        Status := Status::Draft;
        "Document Date" := WorkDate();
        "Posting Date" := WorkDate();
    end;

    trigger OnModify()
    begin
        TestStatusOpen();
        "Modified By" := CopyStr(UserId(), 1, 50);
        "Modified Date" := CurrentDateTime();
    end;

    trigger OnDelete()
    begin
        TestStatusOpen();
        DeleteLines();
    end;

    local procedure TestStatusOpen()
    begin
        if Status in [Status::Posted, Status::Reversed, Status::Closed] then
            Error('Cannot modify document with status %1', Status);
    end;

    local procedure DeleteLines()
    var
        ICRechargeLine: Record "IC Recharge Line";
    begin
        ICRechargeLine.SetRange("Document No.", "No.");
        ICRechargeLine.DeleteAll(true);
    end;

    local procedure GetNextNo(): Code[20]
    var
        ICRechargeHeader: Record "IC Recharge Header";
        NextNo: Integer;
    begin
        if ICRechargeHeader.FindLast() then begin
            if Evaluate(NextNo, CopyStr(ICRechargeHeader."No.", 5)) then
                exit('ICR-' + Format(NextNo + 1, 0, '<Integer,6><Filler Character,0>'))
            else
                exit('ICR-000001');
        end else
            exit('ICR-000001');
    end;

    procedure AssistEdit(OldICRechargeHeader: Record "IC Recharge Header"): Boolean
    begin
        "No." := GetNextNo();
        exit(true);
    end;
}
