table 50106 "IC Recharge Posted Header"
{
    DataClassification = CustomerContent;
    Caption = 'IC Recharge Posted Header';
    LookupPageId = "Posted IC Recharge List";
    DrillDownPageId = "Posted IC Recharge List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
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
        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(8; "Total Allocated Amount"; Decimal)
        {
            Caption = 'Total Allocated Amount';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(9; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(10; "Exchange Rate"; Decimal)
        {
            Caption = 'Exchange Rate';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
        }
        field(11; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        field(12; "Approval Date"; DateTime)
        {
            Caption = 'Approval Date';
            DataClassification = CustomerContent;
        }
        field(13; "Posted Date"; DateTime)
        {
            Caption = 'Posted Date';
            DataClassification = CustomerContent;
        }
        field(14; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            DataClassification = CustomerContent;
        }
        field(15; "Reversed"; Boolean)
        {
            Caption = 'Reversed';
            DataClassification = CustomerContent;
        }
        field(16; "Reversal Date"; DateTime)
        {
            Caption = 'Reversal Date';
            DataClassification = CustomerContent;
        }
        field(17; "Reversal Reason"; Text[100])
        {
            Caption = 'Reversal Reason';
            DataClassification = CustomerContent;
        }
        field(18; "Original Document No."; Code[20])
        {
            Caption = 'Original Document No.';
            DataClassification = CustomerContent;
        }
        field(19; "Correction"; Boolean)
        {
            Caption = 'Correction';
            DataClassification = CustomerContent;
        }
        field(20; "Pre-Assigned No."; Code[20])
        {
            Caption = 'Pre-Assigned No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date", "Source Company")
        {
        }
    }
}
