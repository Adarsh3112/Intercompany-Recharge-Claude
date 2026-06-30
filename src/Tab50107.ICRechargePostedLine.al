table 50210 "IC Recharge Posted Line"
{
    DataClassification = CustomerContent;
    Caption = 'IC Recharge Posted Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "IC Recharge Posted Header";
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
            DataClassification = CustomerContent;
        }
        field(6; "Target IC G/L Account No."; Code[20])
        {
            Caption = 'Target IC G/L Account No.';
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
        field(13; "Target Dimension Set ID"; Integer)
        {
            Caption = 'Target Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;
        }
        field(14; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(15; "IC Transaction No."; Integer)
        {
            Caption = 'IC Transaction No.';
            DataClassification = CustomerContent;
        }
        field(16; "Allocation Basis"; Option)
        {
            Caption = 'Allocation Basis';
            OptionMembers = "Fixed Percentage","Amount Based","Dimension Driven","Headcount","Manual";
            OptionCaption = 'Fixed Percentage,Amount Based,Dimension Driven,Headcount,Manual';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "IC Partner Code")
        {
        }
    }
}
