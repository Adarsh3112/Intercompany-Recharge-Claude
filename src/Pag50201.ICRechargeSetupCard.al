page 50201 "IC Recharge Setup Card"
{
    PageType = Card;
    SourceTable = "IC Recharge Setup";
    Caption = 'IC Recharge Setup Card';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Source Company"; Rec."Source Company") { ApplicationArea = All; ToolTip = 'Source company for the recharge'; }
                field("IC Partner Code"; Rec."IC Partner Code") { ApplicationArea = All; ToolTip = 'Intercompany partner code'; }
                field("Recharge Type"; Rec."Recharge Type") { ApplicationArea = All; ToolTip = 'Type of recharge'; }
                field("Allocation Basis"; Rec."Allocation Basis") { ApplicationArea = All; ToolTip = 'Basis for allocation calculation'; }
                field("Source G/L Account No."; Rec."Source G/L Account No.") { ApplicationArea = All; ToolTip = 'Source G/L Account'; }
                field("Target IC G/L Account No."; Rec."Target IC G/L Account No.") { ApplicationArea = All; ToolTip = 'Target IC G/L Account'; }
                field("Default Allocation %"; Rec."Default Allocation %") { ApplicationArea = All; ToolTip = 'Default allocation percentage'; }
                field("Currency Handling Rule"; Rec."Currency Handling Rule") { ApplicationArea = All; ToolTip = 'How currency is handled'; }
                field("Approval Threshold"; Rec."Approval Threshold") { ApplicationArea = All; ToolTip = 'Amount above which approval is required'; }
                field("Auto-Send"; Rec."Auto-Send") { ApplicationArea = All; ToolTip = 'Automatically send to IC partner'; }
                field("Auto-Accept"; Rec."Auto-Accept") { ApplicationArea = All; ToolTip = 'Automatically accept from IC partner'; }
                field("Manual Review Required"; Rec."Manual Review Required") { ApplicationArea = All; ToolTip = 'Manual review is required before posting'; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; ToolTip = 'Block this setup entry'; }
            }
        }
    }
}
