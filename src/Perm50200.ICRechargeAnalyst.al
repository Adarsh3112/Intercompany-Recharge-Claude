permissionset 50200 "IC Recharge Analyst"
{
    Assignable = true;
    Caption = 'IC Recharge Analyst';

    Permissions =
        tabledata "IC Recharge Setup" = R,
        tabledata "IC Recharge Header" = RIMD,
        tabledata "IC Recharge Line" = RIMD,
        tabledata "IC Recharge Config" = R,
        tabledata "IC Recharge Audit Log" = R,
        tabledata "IC Dimension Mapping" = R,
        tabledata "IC Recharge Posted Header" = R,
        tabledata "IC Recharge Posted Line" = R,
        page "IC Recharge Requests" = X,
        page "IC Recharge Request Card" = X,
        page "IC Recharge Subform" = X,
        page "Posted IC Recharge List" = X,
        page "IC Recharge Audit Log" = X,
        codeunit "IC Recharge Management" = X;
}
