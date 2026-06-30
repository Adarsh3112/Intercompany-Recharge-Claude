page 50202 "IC Recharge Requests"
{
    PageType = List;
    SourceTable = "IC Recharge Header";
    Caption = 'IC Recharge Requests';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "IC Recharge Request Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; ToolTip = 'Document number'; }
                field(Description; Rec.Description) { ApplicationArea = All; ToolTip = 'Description of the recharge'; }
                field("Source Company"; Rec."Source Company") { ApplicationArea = All; ToolTip = 'Source company'; }
                field("Recharge Type"; Rec."Recharge Type") { ApplicationArea = All; ToolTip = 'Type of recharge'; }
                field("Posting Date"; Rec."Posting Date") { ApplicationArea = All; ToolTip = 'Posting date'; }
                field(Status; Rec.Status) { ApplicationArea = All; ToolTip = 'Current status of the request'; }
                field("Total Amount"; Rec."Total Amount") { ApplicationArea = All; ToolTip = 'Total source amount'; }
                field("Total Allocated Amount"; Rec."Total Allocated Amount") { ApplicationArea = All; ToolTip = 'Total allocated amount'; }
                field("Exception Flag"; Rec."Exception Flag") { ApplicationArea = All; ToolTip = 'Indicates an exception exists'; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewRequest)
            {
                Caption = 'New';
                Image = New;
                ApplicationArea = All;
                ToolTip = 'Create a new recharge request';
                trigger OnAction()
                var
                    ICRechargeHeader: Record "IC Recharge Header";
                begin
                    ICRechargeHeader.Init();
                    ICRechargeHeader.Insert(true);
                    Page.Run(Page::"IC Recharge Request Card", ICRechargeHeader);
                end;
            }
        }
    }
}
