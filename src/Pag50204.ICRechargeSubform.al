page 50204 "IC Recharge Subform"
{
    PageType = ListPart;
    SourceTable = "IC Recharge Line";
    Caption = 'IC Recharge Lines';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("IC Partner Code"; Rec."IC Partner Code") { ApplicationArea = All; ToolTip = 'IC Partner Code'; }
                field("Target Company"; Rec."Target Company") { ApplicationArea = All; ToolTip = 'Target company'; }
                field("Source G/L Account No."; Rec."Source G/L Account No.") { ApplicationArea = All; ToolTip = 'Source G/L Account'; }
                field("Target IC G/L Account No."; Rec."Target IC G/L Account No.") { ApplicationArea = All; ToolTip = 'Target IC G/L Account'; }
                field("Source Amount"; Rec."Source Amount") { ApplicationArea = All; ToolTip = 'Source amount'; }
                field("Allocation %"; Rec."Allocation %") { ApplicationArea = All; ToolTip = 'Allocation percentage'; }
                field("Allocated Amount"; Rec."Allocated Amount") { ApplicationArea = All; ToolTip = 'Allocated amount'; }
                field("Allocation Basis"; Rec."Allocation Basis") { ApplicationArea = All; ToolTip = 'Allocation basis'; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; ToolTip = 'Currency'; }
                field("Validation Status"; Rec."Validation Status") { ApplicationArea = All; ToolTip = 'Validation status'; Editable = false; }
            }
        }
    }
}
