page 50211 "IC Recharge Monitor"
{
    PageType = List;
    SourceTable = "IC Recharge Header";
    Caption = 'IC Recharge Monitor';
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.") { ApplicationArea = All; ToolTip = 'Document number'; }
                field(Description; Rec.Description) { ApplicationArea = All; ToolTip = 'Description'; }
                field(Status; Rec.Status) { ApplicationArea = All; ToolTip = 'Status'; }
                field("Processing Status"; Rec."Processing Status") { ApplicationArea = All; ToolTip = 'Processing status'; }
                field("Exception Flag"; Rec."Exception Flag") { ApplicationArea = All; ToolTip = 'Exception flag'; }
                field("Total Allocated Amount"; Rec."Total Allocated Amount") { ApplicationArea = All; ToolTip = 'Total allocated'; }
                field(Posted; Rec.Posted) { ApplicationArea = All; ToolTip = 'Posted flag'; }
            }
        }
    }
}
