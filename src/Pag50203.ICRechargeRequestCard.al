page 50203 "IC Recharge Request Card"
{
    PageType = Document;
    SourceTable = "IC Recharge Header";
    Caption = 'IC Recharge Request';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.") { ApplicationArea = All; ToolTip = 'Document number'; Importance = Promoted; }
                field(Description; Rec.Description) { ApplicationArea = All; ToolTip = 'Description'; }
                field("Source Company"; Rec."Source Company") { ApplicationArea = All; ToolTip = 'Source company'; }
                field("Recharge Type"; Rec."Recharge Type") { ApplicationArea = All; ToolTip = 'Recharge type'; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; ToolTip = 'Posting date'; }
                field("Document Date"; Rec."Document Date") { ApplicationArea = All; ToolTip = 'Document date'; }
                field(Status; Rec.Status) { ApplicationArea = All; ToolTip = 'Status'; Editable = false; }
                field("Currency Code"; Rec."Currency Code") { ApplicationArea = All; ToolTip = 'Currency'; }
                field("Exchange Rate"; Rec."Exchange Rate") { ApplicationArea = All; ToolTip = 'Exchange rate'; }
                field("Total Amount"; Rec."Total Amount") { ApplicationArea = All; ToolTip = 'Total source amount'; Editable = false; }
                field("Total Allocated Amount"; Rec."Total Allocated Amount") { ApplicationArea = All; ToolTip = 'Total allocated amount'; Editable = false; }
            }
            group(Approval)
            {
                Caption = 'Approval';
                field("Approval Required"; Rec."Approval Required") { ApplicationArea = All; ToolTip = 'Approval required flag'; }
                field("Approved By"; Rec."Approved By") { ApplicationArea = All; ToolTip = 'Approved by user'; }
                field("Approval Date"; Rec."Approval Date") { ApplicationArea = All; ToolTip = 'Approval date and time'; }
            }
            part(Lines; "IC Recharge Subform")
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
            action(Validate)
            {
                Caption = 'Validate';
                Image = Approve;
                ApplicationArea = All;
                ToolTip = 'Validate the recharge request';
                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                begin
                    ICRechargeMgt.ValidateRechargeRequest(Rec);
                    Message('Document validated successfully');
                end;
            }
            action(SubmitApproval)
            {
                Caption = 'Submit for Approval';
                Image = SendApprovalRequest;
                ApplicationArea = All;
                ToolTip = 'Submit request for approval';
                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                begin
                    ICRechargeMgt.SubmitForApproval(Rec);
                    Message('Document submitted for approval');
                end;
            }
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                ApplicationArea = All;
                ToolTip = 'Approve the recharge request';
                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                begin
                    ICRechargeMgt.ApproveRechargeRequest(Rec);
                    Message('Document approved');
                end;
            }
            action(Post)
            {
                Caption = 'Post';
                Image = Post;
                ApplicationArea = All;
                ToolTip = 'Post the recharge request';
                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"IC Recharge Posting", Rec);
                    Message('Document posted successfully');
                end;
            }
        }
    }
}
