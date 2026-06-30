page 50202 "IC Recharge Requests"
{
    PageType = List;
    SourceTable = "IC Recharge Header";
    Caption = 'IC Recharge Requests';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "IC Recharge Request Card";
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
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
                field("Approval Required"; Rec."Approval Required")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if approval is required.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the document is posted.';
                }
                field("Exception Flag"; Rec."Exception Flag")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if there is an exception.';
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
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                ToolTip = 'Reject the recharge request.';

                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                    Reason: Text[100];
                begin
                    if Reason = '' then
                        Error('Rejection reason is required');
                    ICRechargeMgt.RejectRechargeRequest(Rec, Reason);
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
