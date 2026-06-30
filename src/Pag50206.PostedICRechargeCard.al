page 50206 "Posted IC Recharge Card"
{
    PageType = Document;
    SourceTable = "IC Recharge Posted Header";
    Caption = 'Posted IC Recharge';
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.") { ApplicationArea = All; ToolTip = 'Document number'; }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.") { ApplicationArea = All; ToolTip = 'Original request number'; }
                field("Source Company"; Rec."Source Company") { ApplicationArea = All; ToolTip = 'Source company'; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; ToolTip = 'Posting date'; }
                field("Total Amount"; Rec."Total Amount") { ApplicationArea = All; ToolTip = 'Total source amount'; }
                field("Total Allocated Amount"; Rec."Total Allocated Amount") { ApplicationArea = All; ToolTip = 'Total allocated amount'; }
                field("Posted By"; Rec."Posted By") { ApplicationArea = All; ToolTip = 'Posted by user'; }
                field("Posted Date"; Rec."Posted Date") { ApplicationArea = All; ToolTip = 'Date posted'; }
                field(Reversed; Rec.Reversed) { ApplicationArea = All; ToolTip = 'Reversed flag'; }
                field("Reversal Date"; Rec."Reversal Date") { ApplicationArea = All; ToolTip = 'Reversal date'; }
            }
            part(Lines; "Posted IC Recharge Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Reverse)
            {
                Caption = 'Reverse';
                Image = ReverseRegister;
                ApplicationArea = All;
                ToolTip = 'Reverse this posted recharge';
                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                    ReversalReason: Text[100];
                begin
                    ReversalReason := 'Manual reversal';
                    ICRechargeMgt.ReversePostedRecharge(Rec, ReversalReason);
                    Message('Document reversed successfully');
                end;
            }
        }
    }
}
