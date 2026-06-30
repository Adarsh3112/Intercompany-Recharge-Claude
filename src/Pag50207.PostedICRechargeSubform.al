page 50207 "Posted IC Recharge Subform"
{
    PageType = ListPart;
    SourceTable = "IC Recharge Posted Line";
    Caption = 'Posted IC Recharge Lines';
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("IC Partner Code"; Rec."IC Partner Code") { ApplicationArea = All; ToolTip = 'IC Partner Code'; }
                field("Target Company"; Rec."Target Company") { ApplicationArea = All; ToolTip = 'Target company'; }
                field("Source Amount"; Rec."Source Amount") { ApplicationArea = All; ToolTip = 'Source amount'; }
                field("Allocated Amount"; Rec."Allocated Amount") { ApplicationArea = All; ToolTip = 'Allocated amount'; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; ToolTip = 'Currency'; }
            }
        }
    }
}
