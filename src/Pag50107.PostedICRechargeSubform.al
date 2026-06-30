page 50207 "Posted IC Recharge Subform"
{
    PageType = ListPart;
    SourceTable = "IC Recharge Posted Line";
    Caption = 'Lines';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the IC partner code.';
                }
                field("Target Company"; Rec."Target Company")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target company.';
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
                field("Source Amount"; Rec."Source Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source amount.';
                }
                field("Allocation %"; Rec."Allocation %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation percentage.';
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocated amount.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the currency code.';
                }
                field("Allocation Basis"; Rec."Allocation Basis")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation basis.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }
                field("IC Transaction No."; Rec."IC Transaction No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the IC transaction number.';
                }
            }
        }
    }
}
