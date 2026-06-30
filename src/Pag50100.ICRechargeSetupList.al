page 50100 "IC Recharge Setup List"
{
    PageType = List;
    SourceTable = "IC Recharge Setup";
    Caption = 'IC Recharge Setup List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "IC Recharge Setup Card";

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
                field("Default Allocation %"; Rec."Default Allocation %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default allocation percentage.';
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
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the setup is blocked.';
                }
            }
        }
    }
}
