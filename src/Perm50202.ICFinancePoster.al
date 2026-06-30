permissionset 50202 "IC Finance Poster"
{
    Assignable = true;
    Caption = 'IC Finance Poster';

    Permissions =
        tabledata "IC Recharge Header" = RM,
        tabledata "IC Recharge Line" = RM,
        tabledata "IC Recharge Audit Log" = RI,
        tabledata "IC Recharge Posted Header" = RI,
        tabledata "IC Recharge Posted Line" = RI,
        page "IC Recharge Requests" = X,
        page "IC Recharge Request Card" = X,
        page "Posted IC Recharge List" = X,
        codeunit "IC Recharge Management" = X,
        codeunit "IC Recharge Posting" = X;
}
