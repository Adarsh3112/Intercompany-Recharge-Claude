page 50105 "Posted IC Recharge List"
{
    PageType = List;
    SourceTable = "IC Recharge Posted Header";
    Caption = 'Posted IC Recharge List';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Posted IC Recharge Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }
                field("Source Company"; Rec."Source Company")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source company.';
                }
                field("Recharge Type"; Rec."Recharge Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the recharge type.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total amount.';
                }
                field("Total Allocated Amount"; Rec."Total Allocated Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total allocated amount.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the currency code.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who posted the document.';
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the document was posted.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the document is reversed.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Reverse)
            {
                ApplicationArea = All;
                Caption = 'Reverse';
                Image = Undo;
                ToolTip = 'Reverse the posted recharge.';

                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                    ReversalReason: Text[100];
                begin
                    if ReversalReason = '' then
                        Error('Reversal reason is required');
                    ICRechargeMgt.ReversePostedRecharge(Rec, ReversalReason);
                    CurrPage.Update();
                end;
            }
        }
    }
}
