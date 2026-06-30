table 50202 "IC Recharge Line"
{
    DataClassification = CustomerContent;
    Caption = 'IC Recharge Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "IC Recharge Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
            DataClassification = CustomerContent;
        }
        field(4; "Target Company"; Text[30])
        {
            Caption = 'Target Company';
            DataClassification = CustomerContent;
        }
        field(5; "Source G/L Account No."; Code[20])
        {
            Caption = 'Source G/L Account No.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(6; "Target IC G/L Account No."; Code[20])
        {
            Caption = 'Target IC G/L Account No.';
            TableRelation = "IC G/L Account";
            DataClassification = CustomerContent;
        }
        field(7; "Source Amount"; Decimal)
        {
            Caption = 'Source Amount';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(8; "Allocation %"; Decimal)
        {
            Caption = 'Allocation %';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            MinValue = 0;
            MaxValue = 100;

            trigger OnValidate()
            begin
                CalculateAllocatedAmount();
            end;
        }
        field(9; "Allocated Amount"; Decimal)
        {
            Caption = 'Allocated Amount';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
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
        field(12; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;
        }
        field(13; "Manual Override"; Boolean)
        {
            Caption = 'Manual Override';
            DataClassification = CustomerContent;
        }
        field(14; "Override Reason"; Text[100])
        {
            Caption = 'Override Reason';
            DataClassification = CustomerContent;
        }
        field(15; "Allocation Basis"; Option)
        {
            Caption = 'Allocation Basis';
            OptionMembers = "Fixed Percentage","Amount Based","Dimension Driven","Headcount","Manual";
            OptionCaption = 'Fixed Percentage,Amount Based,Dimension Driven,Headcount,Manual';
            DataClassification = CustomerContent;
        }
        field(16; "Posted"; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "IC Transaction No."; Integer)
        {
            Caption = 'IC Transaction No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Validation Status"; Option)
        {
            Caption = 'Validation Status';
            OptionMembers = " ","Not Validated",Validated,Failed;
            OptionCaption = ' ,Not Validated,Validated,Failed';
            DataClassification = CustomerContent;
        }
        field(19; "Validation Message"; Text[250])
        {
            Caption = 'Validation Message';
            DataClassification = CustomerContent;
        }
        field(20; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(21; "Target Dimension Set ID"; Integer)
        {
            Caption = 'Target Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;
        }
        field(30; "Rounding Adjustment"; Decimal)
        {
            Caption = 'Rounding Adjustment';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "IC Partner Code", "Posted")
        {
        }
    }

    trigger OnInsert()
    begin
        GetICRechargeHeader();
    end;

    trigger OnModify()
    begin
        GetICRechargeHeader();
    end;

    trigger OnDelete()
    begin
        GetICRechargeHeader();
    end;

    var
        ICRechargeHeader: Record "IC Recharge Header";

    local procedure GetICRechargeHeader()
    begin
        if ICRechargeHeader."No." <> "Document No." then
            ICRechargeHeader.Get("Document No.");
    end;

    local procedure CalculateAllocatedAmount()
    begin
        if "Source Amount" <> 0 then
            "Allocated Amount" := Round("Source Amount" * "Allocation %" / 100, 0.01);
    end;

    procedure ValidateLine(): Boolean
    var
        ICPartner: Record "IC Partner";
        ICGLAccount: Record "IC G/L Account";
    begin
        "Validation Status" := "Validation Status"::Validated;
        "Validation Message" := '';

        if "IC Partner Code" = '' then begin
            "Validation Status" := "Validation Status"::Failed;
            "Validation Message" := 'IC Partner Code must be specified';
            exit(false);
        end;

        if not ICPartner.Get("IC Partner Code") then begin
            "Validation Status" := "Validation Status"::Failed;
            "Validation Message" := 'IC Partner does not exist';
            exit(false);
        end;

        if "Target IC G/L Account No." = '' then begin
            "Validation Status" := "Validation Status"::Failed;
            "Validation Message" := 'Target IC G/L Account must be specified';
            exit(false);
        end;

        if not ICGLAccount.Get("Target IC G/L Account No.") then begin
            "Validation Status" := "Validation Status"::Failed;
            "Validation Message" := 'Target IC G/L Account does not exist';
            exit(false);
        end;

        if "Allocated Amount" = 0 then begin
            "Validation Status" := "Validation Status"::Failed;
            "Validation Message" := 'Allocated Amount must be non-zero';
            exit(false);
        end;

        exit(true);
    end;
}
