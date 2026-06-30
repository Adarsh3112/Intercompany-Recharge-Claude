permissionset 50203 "IC Recharge Admin"
{
    Assignable = true;
    Caption = 'IC Recharge Admin';

    Permissions =
        tabledata "IC Recharge Setup" = RIMD,
        tabledata "IC Recharge Header" = RIMD,
        tabledata "IC Recharge Line" = RIMD,
        tabledata "IC Recharge Config" = RIMD,
        tabledata "IC Recharge Audit Log" = RIMD,
        tabledata "IC Dimension Mapping" = RIMD,
        tabledata "IC Recharge Posted Header" = RIMD,
        tabledata "IC Recharge Posted Line" = RIMD,
        page "IC Recharge Setup List" = X,
        page "IC Recharge Setup Card" = X,
        page "IC Recharge Requests" = X,
        page "IC Recharge Request Card" = X,
        page "IC Recharge Subform" = X,
        page "Posted IC Recharge List" = X,
        page "Posted IC Recharge Card" = X,
        page "IC Recharge Monitor" = X,
        page "IC Recharge Audit Log" = X,
        page "IC Dimension Mapping" = X,
        codeunit "IC Recharge Management" = X,
        codeunit "IC Recharge Posting" = X,
        codeunit "IC Recharge Batch Processor" = X;
}
