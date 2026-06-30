page 50111 "IC Recharge Monitor"
{
    PageType = List;
    SourceTable = "IC Recharge Header";
    Caption = 'IC Recharge Monitor';
    ApplicationArea = All;
    UsageCategory = Tasks;
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status.';
                }
                field("Processing Status"; Rec."Processing Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the processing status.';
                }
                field("Exception Flag"; Rec."Exception Flag")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if there is an exception.';
                }
                field("Total Allocated Amount"; Rec."Total Allocated Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total allocated amount.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the document is posted.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewDraft)
            {
                ApplicationArea = All;
                Caption = 'View Draft';
                Image = ViewFilter;
                ToolTip = 'View draft documents.';

                trigger OnAction()
                var
                    ICRechargeHeader: Record "IC Recharge Header";
                begin
                    ICRechargeHeader.SetRange(Status, ICRechargeHeader.Status::Draft);
                    Page.Run(Page::"IC Recharge Requests", ICRechargeHeader);
                end;
            }
            action(ViewPendingApproval)
            {
                ApplicationArea = All;
                Caption = 'View Pending Approval';
                Image = ViewFilter;
                ToolTip = 'View documents pending approval.';

                trigger OnAction()
                var
                    ICRechargeHeader: Record "IC Recharge Header";
                begin
                    ICRechargeHeader.SetRange(Status, ICRechargeHeader.Status::"Pending Approval");
                    Page.Run(Page::"IC Recharge Requests", ICRechargeHeader);
                end;
            }
            action(ViewFailed)
            {
                ApplicationArea = All;
                Caption = 'View Failed';
                Image = ErrorLog;
                ToolTip = 'View failed documents.';

                trigger OnAction()
                var
                    ICRechargeHeader: Record "IC Recharge Header";
                begin
                    ICRechargeHeader.SetRange("Processing Status", ICRechargeHeader."Processing Status"::Failed);
                    Page.Run(Page::"IC Recharge Requests", ICRechargeHeader);
                end;
            }
            action(ViewExceptions)
            {
                ApplicationArea = All;
                Caption = 'View Exceptions';
                Image = Warning;
                ToolTip = 'View exception documents.';

                trigger OnAction()
                var
                    ICRechargeHeader: Record "IC Recharge Header";
                begin
                    ICRechargeHeader.SetRange("Exception Flag", true);
                    Page.Run(Page::"IC Recharge Requests", ICRechargeHeader);
                end;
            }
            action(RetryFailed)
            {
                ApplicationArea = All;
                Caption = 'Retry Failed';
                Image = Refresh;
                ToolTip = 'Retry processing failed documents.';

                trigger OnAction()
                var
                    ICRechargeBatch: Codeunit "IC Recharge Batch Proc";
                begin
                    ICRechargeBatch.RetryFailedDocuments();
                    CurrPage.Update();
                end;
            }
            action(ProcessBatch)
            {
                ApplicationArea = All;
                Caption = 'Process Batch';
                Image = PostBatch;
                ToolTip = 'Process approved documents in batch.';

                trigger OnAction()
                var
                    ICRechargeHeader: Record "IC Recharge Header";
                    ICRechargeBatch: Codeunit "IC Recharge Batch Proc";
                begin
                    ICRechargeBatch.ProcessBatch(ICRechargeHeader);
                    CurrPage.Update();
                end;
            }
        }
    }
}
