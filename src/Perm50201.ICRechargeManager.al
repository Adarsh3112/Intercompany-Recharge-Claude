permissionset 50201 "IC Recharge Manager"
{
    Assignable = true;
    Caption = 'IC Recharge Manager';

    Permissions =
        tabledata "IC Recharge Setup" = RIMD,
        tabledata "IC Recharge Header" = RIMD,
        tabledata "IC Recharge Line" = RIMD,
        tabledata "IC Recharge Config" = RIMD,
        tabledata "IC Recharge Audit Log" = R,
        tabledata "IC Dimension Mapping" = RIMD,
        tabledata "IC Recharge Posted Header" = R,
        tabledata "IC Recharge Posted Line" = R,
        page "IC Recharge Setup List" = X,
        page "IC Recharge Setup Card" = X,
        page "IC Recharge Requests" = X,
        page "IC Recharge Request Card" = X,
        page "IC Recharge Subform" = X,
        page "Posted IC Recharge List" = X,
        page "IC Recharge Monitor" = X,
        codeunit "IC Recharge Management" = X,
        codeunit "IC Recharge Posting" = X;
}
