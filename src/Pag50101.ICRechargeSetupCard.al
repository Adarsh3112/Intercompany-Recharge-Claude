page 50201 "IC Recharge Setup Card"
{
    PageType = Card;
    SourceTable = "IC Recharge Setup";
    Caption = 'IC Recharge Setup Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                    Editable = false;
                }
                field("Source Company"; Rec."Source Company")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source company.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the IC partner code.';
                }
                field("Recharge Type"; Rec."Recharge Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the recharge type.';
                }
                field("Allocation Basis"; Rec."Allocation Basis")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation basis.';
                }
            }
            group(Accounts)
            {
                Caption = 'Accounts';
                field("Source G/L Account No."; Rec."Source G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source G/L account number.';
                }
                field("Target IC G/L Account No."; Rec."Target IC G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target IC G/L account number.';
                }
            }
            group(Allocation)
            {
                Caption = 'Allocation';
                field("Default Allocation %"; Rec."Default Allocation %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default allocation percentage.';
                }
                field("Dimension Mapping Rule"; Rec."Dimension Mapping Rule")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension mapping rule.';
                }
            }
            group(Settings)
            {
                Caption = 'Settings';
                field("Currency Handling Rule"; Rec."Currency Handling Rule")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the currency handling rule.';
                }
                field("Approval Threshold"; Rec."Approval Threshold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval threshold.';
                }
                field("Auto-Send"; Rec."Auto-Send")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if auto-send is enabled.';
                }
                field("Auto-Accept"; Rec."Auto-Accept")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if auto-accept is enabled.';
                }
                field("Manual Review Required"; Rec."Manual Review Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if manual review is required.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the setup is blocked.';
                }
            }
            group(Info)
            {
                Caption = 'Information';
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the record.';
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                    Editable = false;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who last modified the record.';
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was last modified.';
                    Editable = false;
                }
            }
        }
    }
}
