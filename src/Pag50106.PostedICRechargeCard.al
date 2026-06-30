page 50106 "Posted IC Recharge Card"
{
    PageType = Document;
    SourceTable = "IC Recharge Posted Header";
    Caption = 'Posted IC Recharge';
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document date.';
                }
            }
            part(Lines; "Posted IC Recharge Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
            group(Amounts)
            {
                Caption = 'Amounts';
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
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the exchange rate.';
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
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
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who approved the document.';
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the document was approved.';
                }
            }
            group(Reversal)
            {
                Caption = 'Reversal';
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the document is reversed.';
                }
                field("Reversal Date"; Rec."Reversal Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the document was reversed.';
                }
                field("Reversal Reason"; Rec."Reversal Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reversal reason.';
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
