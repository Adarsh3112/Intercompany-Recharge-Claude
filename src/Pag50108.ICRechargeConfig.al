page 50108 "IC Recharge Config"
{
    PageType = Card;
    SourceTable = "IC Recharge Config";
    Caption = 'IC Recharge Configuration';
    ApplicationArea = All;
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(NumberSeries)
            {
                Caption = 'Number Series';
                field("Recharge Nos."; Rec."Recharge Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for recharge documents.';
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                field("Require Approval"; Rec."Require Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if approval is required for all recharge requests.';
                }
                field("Default Approval Threshold"; Rec."Default Approval Threshold")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default approval threshold amount.';
                }
            }
            group(Automation)
            {
                Caption = 'Automation';
                field("Enable Auto-Send"; Rec."Enable Auto-Send")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if auto-send to IC partners is enabled.';
                }
                field("Enable Auto-Accept"; Rec."Enable Auto-Accept")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if auto-accept from IC partners is enabled.';
                }
                field("Enable Batch Processing"; Rec."Enable Batch Processing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if batch processing is enabled.';
                }
                field("Batch Size"; Rec."Batch Size")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the batch size for processing.';
                }
            }
            group(Features)
            {
                Caption = 'Features';
                field("Enable Dimension Mapping"; Rec."Enable Dimension Mapping")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if dimension mapping is enabled.';
                }
                field("Enable Multi-Currency"; Rec."Enable Multi-Currency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if multi-currency is enabled.';
                }
                field("Default Currency Code"; Rec."Default Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default currency code.';
                }
            }
            group(Settings)
            {
                Caption = 'Settings';
                field("Audit Log Retention Days"; Rec."Audit Log Retention Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the audit log retention period in days.';
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the rounding precision.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
