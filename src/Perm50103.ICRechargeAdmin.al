permissionset 50203 "IC Recharge Admin"
{
    Assignable = true;
    Caption = 'IC Recharge Administrator';

    Permissions =
        tabledata "IC Recharge Header" = RIMD,
        tabledata "IC Recharge Line" = RIMD,
        tabledata "IC Recharge Setup" = RIMD,
        tabledata "IC Recharge Config" = RIMD,
        tabledata "IC Recharge Posted Header" = RIMD,
        tabledata "IC Recharge Posted Line" = RIMD,
        tabledata "IC Recharge Audit Log" = RIMD,
        tabledata "IC Dimension Mapping" = RIMD,
        table "IC Recharge Header" = X,
        table "IC Recharge Line" = X,
        table "IC Recharge Setup" = X,
        table "IC Recharge Config" = X,
        table "IC Recharge Posted Header" = X,
        table "IC Recharge Posted Line" = X,
        table "IC Recharge Audit Log" = X,
        table "IC Dimension Mapping" = X,
        codeunit "IC Recharge Management" = X,
        codeunit "IC Recharge Posting" = X,
        codeunit "IC Recharge Batch Proc" = X,
        page "IC Recharge Requests" = X,
        page "IC Recharge Request Card" = X,
        page "IC Recharge Subform" = X,
        page "IC Recharge Setup List" = X,
        page "IC Recharge Setup Card" = X,
        page "Posted IC Recharge List" = X,
        page "Posted IC Recharge Card" = X,
        page "Posted IC Recharge Subform" = X,
        page "IC Recharge Config" = X,
        page "IC Recharge Audit Log" = X,
        page "IC Dimension Mapping" = X,
        page "IC Recharge Monitor" = X;
}
