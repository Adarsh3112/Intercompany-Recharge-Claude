page 50210 "IC Dimension Mapping"
{
    PageType = List;
    SourceTable = "IC Dimension Mapping";
    Caption = 'IC Dimension Mapping';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                    Editable = false;
                }
                field("Source Dimension Code"; Rec."Source Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source dimension code.';
                }
                field("Source Dimension Value"; Rec."Source Dimension Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source dimension value.';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the IC partner code.';
                }
                field("Target IC Dimension Code"; Rec."Target IC Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target IC dimension code.';
                }
                field("Target IC Dimension Value"; Rec."Target IC Dimension Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target IC dimension value.';
                }
                field("Mapping Rule Code"; Rec."Mapping Rule Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the mapping rule code.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the mapping is blocked.';
                }
            }
        }
    }
}
