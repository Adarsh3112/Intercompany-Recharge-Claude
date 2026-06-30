table 50103 "IC Recharge Config"
{
    DataClassification = CustomerContent;
    Caption = 'IC Recharge Config';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Recharge Nos."; Code[20])
        {
            Caption = 'Recharge Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(3; "Default Approval Threshold"; Decimal)
        {
            Caption = 'Default Approval Threshold';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(4; "Enable Auto-Send"; Boolean)
        {
            Caption = 'Enable Auto-Send';
            DataClassification = CustomerContent;
        }
        field(5; "Enable Auto-Accept"; Boolean)
        {
            Caption = 'Enable Auto-Accept';
            DataClassification = CustomerContent;
        }
        field(6; "Audit Log Retention Days"; Integer)
        {
            Caption = 'Audit Log Retention Days';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(7; "Rounding Precision"; Decimal)
        {
            Caption = 'Rounding Precision';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            InitValue = 0.01;
        }
        field(8; "Require Approval"; Boolean)
        {
            Caption = 'Require Approval';
            DataClassification = CustomerContent;
        }
        field(9; "Enable Batch Processing"; Boolean)
        {
            Caption = 'Enable Batch Processing';
            DataClassification = CustomerContent;
        }
        field(10; "Batch Size"; Integer)
        {
            Caption = 'Batch Size';
            DataClassification = CustomerContent;
            MinValue = 1;
            InitValue = 50;
        }
        field(11; "Enable Dimension Mapping"; Boolean)
        {
            Caption = 'Enable Dimension Mapping';
            DataClassification = CustomerContent;
        }
        field(12; "Enable Multi-Currency"; Boolean)
        {
            Caption = 'Enable Multi-Currency';
            DataClassification = CustomerContent;
        }
        field(13; "Default Currency Code"; Code[10])
        {
            Caption = 'Default Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetInstance(): Record "IC Recharge Config"
    begin
        if not Get() then begin
            Init();
            Insert();
        end;
        exit(Rec);
    end;
}
