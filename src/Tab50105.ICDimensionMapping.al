table 50105 "IC Dimension Mapping"
{
    DataClassification = CustomerContent;
    Caption = 'IC Dimension Mapping';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "Source Dimension Code"; Code[20])
        {
            Caption = 'Source Dimension Code';
            TableRelation = Dimension;
            DataClassification = CustomerContent;
        }
        field(3; "Source Dimension Value"; Code[20])
        {
            Caption = 'Source Dimension Value';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Source Dimension Code"));
            DataClassification = CustomerContent;
        }
        field(4; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
            DataClassification = CustomerContent;
        }
        field(5; "Target IC Dimension Code"; Code[20])
        {
            Caption = 'Target IC Dimension Code';
            TableRelation = "IC Dimension";
            DataClassification = CustomerContent;
        }
        field(6; "Target IC Dimension Value"; Code[20])
        {
            Caption = 'Target IC Dimension Value';
            TableRelation = "IC Dimension Value".Code where("Dimension Code" = field("Target IC Dimension Code"));
            DataClassification = CustomerContent;
        }
        field(7; "Mapping Rule Code"; Code[20])
        {
            Caption = 'Mapping Rule Code';
            DataClassification = CustomerContent;
        }
        field(8; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Source Dimension Code", "Source Dimension Value", "IC Partner Code")
        {
        }
    }
}
