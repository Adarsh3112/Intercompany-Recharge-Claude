page 50104 "IC Recharge Subform"
{
    PageType = ListPart;
    SourceTable = "IC Recharge Line";
    Caption = 'Lines';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the IC partner code.';
                }
                field("Target Company"; Rec."Target Company")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target company.';
                }
                field("Source G/L Account No."; Rec."Source G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source G/L account number.';
                }
                field("Target IC G/L Account No."; Rec."Target IC G/L Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target IC G/L account number.';
                }
                field("Source Amount"; Rec."Source Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source amount.';
                }
                field("Allocation %"; Rec."Allocation %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation percentage.';
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocated amount.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the currency code.';
                }
                field("Allocation Basis"; Rec."Allocation Basis")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the allocation basis.';
                }
                field("Manual Override"; Rec."Manual Override")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if manual override is used.';
                }
                field("Override Reason"; Rec."Override Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the override reason.';
                }
                field("Validation Status"; Rec."Validation Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the validation status.';
                    Editable = false;
                }
                field("Validation Message"; Rec."Validation Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the validation message.';
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CalculateAllocation)
            {
                ApplicationArea = All;
                Caption = 'Calculate Allocation';
                Image = Calculate;
                ToolTip = 'Calculate the allocation for this line.';

                trigger OnAction()
                var
                    ICRechargeMgt: Codeunit "IC Recharge Management";
                begin
                    ICRechargeMgt.CalculateAllocation(Rec);
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action(ValidateLine)
            {
                ApplicationArea = All;
                Caption = 'Validate Line';
                Image = Approve;
                ToolTip = 'Validate this line.';

                trigger OnAction()
                begin
                    Rec.ValidateLine();
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
        }
    }
}
