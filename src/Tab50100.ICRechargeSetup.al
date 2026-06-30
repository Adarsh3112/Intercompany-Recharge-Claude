table 50100 "IC Recharge Setup"
{
    DataClassification = CustomerContent;
    Caption = 'IC Recharge Setup';
    LookupPageId = "IC Recharge Setup List";
    DrillDownPageId = "IC Recharge Setup List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "Source Company"; Text[30])
        {
            Caption = 'Source Company';
            DataClassification = CustomerContent;
        }
        field(3; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
            DataClassification = CustomerContent;
        }
        field(4; "Recharge Type"; Code[20])
        {
            Caption = 'Recharge Type';
            DataClassification = CustomerContent;
        }
        field(5; "Allocation Basis"; Option)
        {
            Caption = 'Allocation Basis';
            OptionMembers = "Fixed Percentage","Amount Based","Dimension Driven","Headcount","Manual";
            OptionCaption = 'Fixed Percentage,Amount Based,Dimension Driven,Headcount,Manual';
            DataClassification = CustomerContent;
        }
        field(6; "Source G/L Account No."; Code[20])
        {
            Caption = 'Source G/L Account No.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(7; "Target IC G/L Account No."; Code[20])
        {
            Caption = 'Target IC G/L Account No.';
            TableRelation = "IC G/L Account";
            DataClassification = CustomerContent;
        }
        field(8; "Dimension Mapping Rule"; Code[20])
        {
            Caption = 'Dimension Mapping Rule';
            DataClassification = CustomerContent;
        }
        field(9; "Currency Handling Rule"; Option)
        {
            Caption = 'Currency Handling Rule';
            OptionMembers = "Source Currency","Target Currency","LCY";
            OptionCaption = 'Source Currency,Target Currency,LCY';
            DataClassification = CustomerContent;
        }
        field(10; "Approval Threshold"; Decimal)
        {
            Caption = 'Approval Threshold';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(11; "Auto-Send"; Boolean)
        {
            Caption = 'Auto-Send';
            DataClassification = CustomerContent;
        }
        field(12; "Auto-Accept"; Boolean)
        {
            Caption = 'Auto-Accept';
            DataClassification = CustomerContent;
        }
        field(13; "Default Allocation %"; Decimal)
        {
            Caption = 'Default Allocation %';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            MinValue = 0;
            MaxValue = 100;
        }
        field(14; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(15; "Manual Review Required"; Boolean)
        {
            Caption = 'Manual Review Required';
            DataClassification = CustomerContent;
        }
        field(20; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Modified Date"; DateTime)
        {
            Caption = 'Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Source Company", "IC Partner Code", "Recharge Type")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created By" := CopyStr(UserId(), 1, 50);
        "Created Date" := CurrentDateTime();
        "Modified By" := CopyStr(UserId(), 1, 50);
        "Modified Date" := CurrentDateTime();
    end;

    trigger OnModify()
    begin
        "Modified By" := CopyStr(UserId(), 1, 50);
        "Modified Date" := CurrentDateTime();
    end;
}
