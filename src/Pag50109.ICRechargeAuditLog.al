page 50209 "IC Recharge Audit Log"
{
    PageType = List;
    SourceTable = "IC Recharge Audit Log";
    Caption = 'IC Recharge Audit Log';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number.';
                }
                field("Entry Timestamp"; Rec."Entry Timestamp")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the timestamp.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user ID.';
                }
                field("Action Type"; Rec."Action Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the action type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }
                field("Old Value"; Rec."Old Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the old value.';
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the new value.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the IC partner code.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount.';
                }
                field("System Action"; Rec."System Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this was a system action.';
                }
            }
        }
    }
}
