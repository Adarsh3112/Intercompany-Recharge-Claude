permissionset 50200 "IC Recharge Analyst"
{
    Assignable = true;
    Caption = 'IC Recharge Analyst';

    Permissions =
        tabledata "IC Recharge Header" = RIMD,
        tabledata "IC Recharge Line" = RIMD,
        tabledata "IC Recharge Setup" = R,
        tabledata "IC Recharge Config" = R,
        tabledata "IC Recharge Posted Header" = R,
        tabledata "IC Recharge Posted Line" = R,
        tabledata "IC Recharge Audit Log" = R,
        tabledata "IC Dimension Mapping" = R,
        table "IC Recharge Header" = X,
        table "IC Recharge Line" = X,
        table "IC Recharge Setup" = X,
        table "IC Recharge Config" = X,
        table "IC Recharge Posted Header" = X,
        table "IC Recharge Posted Line" = X,
        table "IC Recharge Audit Log" = X,
        table "IC Dimension Mapping" = X,
        codeunit "IC Recharge Management" = X,
        page "IC Recharge Requests" = X,
        page "IC Recharge Request Card" = X,
        page "IC Recharge Subform" = X,
        page "IC Recharge Setup List" = X,
        page "Posted IC Recharge List" = X,
        page "Posted IC Recharge Card" = X,
        page "IC Recharge Audit Log" = X,
        page "IC Recharge Monitor" = X;
}
