page 50205 "Posted IC Recharge List"
{
    PageType = List;
    SourceTable = "IC Recharge Posted Header";
    Caption = 'Posted IC Recharges';
    ApplicationArea = All;
    UsageCategory = History;
    Editable = false;
    CardPageId = "Posted IC Recharge Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; ToolTip = 'Document number'; }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.") { ApplicationArea = All; ToolTip = 'Original document number'; }
                field("Source Company"; Rec."Source Company") { ApplicationArea = All; ToolTip = 'Source company'; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; ToolTip = 'Posting date'; }
                field("Total Amount"; Rec."Total Amount") { ApplicationArea = All; ToolTip = 'Total amount'; }
                field("Total Allocated Amount"; Rec."Total Allocated Amount") { ApplicationArea = All; ToolTip = 'Total allocated amount'; }
                field(Reversed; Rec.Reversed) { ApplicationArea = All; ToolTip = 'Indicates if reversed'; }
            }
        }
    }
}
