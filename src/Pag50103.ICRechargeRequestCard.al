page 50203 "IC Recharge Request Card"
{
    PageType = Document;
    SourceTable = "IC Recharge Header";
    Caption = 'IC Recharge Request';

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

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                    Editable = false;
                }
            }
            part(Lines; "IC Recharge Subform")
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
                    Editable = false;
                }
                field("Total Allocated Amount"; Rec."Total Allocated Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total allocated amount.';
                    Editable = false;
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
            group(Approval)
            {
                Caption = 'Approval';
                field("Approval Required"; Rec."Approval Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if approval is required.';
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who approved the document.';
                    Editable = false;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the document was approved.';
                    Editable = false;
                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the document is posted.';
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who posted the document.';
                    Editable = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the document was posted.';
                    Editable = false;
                }
            }
            group(Exception)
            {
                Caption = 'Exception';
                field("Exception Flag"; Rec."Exception Flag")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if there is an exception.';
                    Editable = false;
                }
                field("Exception Message"; Rec."Exception Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the exception message.';
                    Editable = false;
                    MultiLine = true;
                }
                field("Processing Status"; Rec."Processing Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the processing status.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Validate)
            {
                ApplicationArea = All;
                Caption = 'Validate';
                Image = Approve;
                ToolTip = 'Validate the recharge request.';

                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                begin
                    ICRechargeMgt.ValidateRechargeRequest(Rec);
                    CurrPage.Update();
                end;
            }
            action(SubmitForApproval)
            {
                ApplicationArea = All;
                Caption = 'Submit for Approval';
                Image = SendApprovalRequest;
                ToolTip = 'Submit the recharge request for approval.';

                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                begin
                    ICRechargeMgt.SubmitForApproval(Rec);
                    CurrPage.Update();
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                ToolTip = 'Approve the recharge request.';

                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                begin
                    ICRechargeMgt.ApproveRechargeRequest(Rec);
                    CurrPage.Update();
                end;
            }
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = Post;
                ToolTip = 'Post the recharge request.';

                trigger OnAction()
                var
                    ICRechargePosting: Codeunit "IC Recharge Posting";
                begin
                    ICRechargePosting.PostRecharge(Rec);
                    CurrPage.Update();
                end;
            }
            action(BalanceAllocations)
            {
                ApplicationArea = All;
                Caption = 'Balance Allocations';
                Image = Balance;
                ToolTip = 'Balance the allocations to match source amounts.';

                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                begin
                    ICRechargeMgt.BalanceAllocations(Rec);
                    CurrPage.Update();
                end;
            }
        }
        area(Navigation)
        {
            action(AuditLog)
            {
                ApplicationArea = All;
                Caption = 'Audit Log';
                Image = Log;
                ToolTip = 'View the audit log.';
                RunObject = page "IC Recharge Audit Log";
                RunPageLink = "Document No." = field("No.");
            }
        }
    }
}
