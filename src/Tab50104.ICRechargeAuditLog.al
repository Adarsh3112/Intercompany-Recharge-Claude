table 50206 "IC Recharge Audit Log"
{
    DataClassification = CustomerContent;
    Caption = 'IC Recharge Audit Log';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "Entry Timestamp"; DateTime)
        {
            Caption = 'Entry Timestamp';
            DataClassification = CustomerContent;
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(5; "Action Type"; Option)
        {
            Caption = 'Action Type';
            OptionMembers = Created,Modified,Validated,Approved,Rejected,Posted,Reversed,Corrected,Deleted,"Status Changed","Calculation Run","IC Sent","IC Received";
            OptionCaption = 'Created,Modified,Validated,Approved,Rejected,Posted,Reversed,Corrected,Deleted,Status Changed,Calculation Run,IC Sent,IC Received';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; "Old Value"; Text[250])
        {
            Caption = 'Old Value';
            DataClassification = CustomerContent;
        }
        field(8; "New Value"; Text[250])
        {
            Caption = 'New Value';
            DataClassification = CustomerContent;
        }
        field(9; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            DataClassification = CustomerContent;
        }
        field(10; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 2;
        }
        field(11; "System Action"; Boolean)
        {
            Caption = 'System Action';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Entry Timestamp")
        {
        }
        key(Key3; "User ID", "Entry Timestamp")
        {
        }
    }

    procedure LogAction(DocumentNo: Code[20]; ActionType: Option; Desc: Text[250])
    begin
        Init();
        "Document No." := DocumentNo;
        "Entry Timestamp" := CurrentDateTime();
        "User ID" := CopyStr(UserId(), 1, 50);
        "Action Type" := ActionType;
        Description := Desc;
        "System Action" := false;
        Insert(true);
    end;

    procedure LogActionWithValues(DocumentNo: Code[20]; ActionType: Option; Desc: Text[250]; OldVal: Text[250]; NewVal: Text[250])
    begin
        Init();
        "Document No." := DocumentNo;
        "Entry Timestamp" := CurrentDateTime();
        "User ID" := CopyStr(UserId(), 1, 50);
        "Action Type" := ActionType;
        Description := Desc;
        "Old Value" := OldVal;
        "New Value" := NewVal;
        "System Action" := false;
        Insert(true);
    end;
}
