page 50200 "IC Recharge Setup List"
{
    PageType = List;
    SourceTable = "IC Recharge Setup";
    Caption = 'IC Recharge Setup';
    ApplicationArea = All;
    UsageCategory = Administration;
    CardPageId = "IC Recharge Setup Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.") { ApplicationArea = All; ToolTip = 'Entry number'; }
                field("Source Company"; Rec."Source Company") { ApplicationArea = All; ToolTip = 'Source company for the recharge'; }
                field("IC Partner Code"; Rec."IC Partner Code") { ApplicationArea = All; ToolTip = 'Intercompany partner code'; }
                field("Recharge Type"; Rec."Recharge Type") { ApplicationArea = All; ToolTip = 'Type of recharge'; }
                field("Allocation Basis"; Rec."Allocation Basis") { ApplicationArea = All; ToolTip = 'Basis for allocation calculation'; }
                field(Blocked; Rec.Blocked) { ApplicationArea = All; ToolTip = 'Indicates if this setup is blocked'; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewSetup)
            {
                Caption = 'New';
                Image = New;
                ApplicationArea = All;
                ToolTip = 'Create a new IC recharge setup entry';
                trigger OnAction()
                begin
                    Page.Run(Page::"IC Recharge Setup Card");
                end;
            }
        }
    }
}
