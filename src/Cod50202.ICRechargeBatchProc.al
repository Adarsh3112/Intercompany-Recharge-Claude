codeunit 50202 "IC Recharge Batch Processor"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        ProcessPendingRecharges();
    end;

    procedure ProcessPendingRecharges()
    var
        ICRechargeHeader: Record "IC Recharge Header";
        ICRechargeMgt: Codeunit "IC Recharge Management";
        ICRechargeConfig: Record "IC Recharge Config";
        ProcessedCount: Integer;
        ChunkSize: Integer;
    begin
        ICRechargeConfig.GetInstance();
        ChunkSize := ICRechargeConfig."Batch Size";
        if ChunkSize = 0 then
            ChunkSize := 100;

        ICRechargeHeader.SetRange(Status, ICRechargeHeader.Status::Approved);
        ICRechargeHeader.SetRange(Posted, false);
        if not ICRechargeHeader.FindSet() then
            exit;

        repeat
            if ProcessedCount >= ChunkSize then
                exit;

            if ICRechargeHeader."Exception Flag" then begin
                ICRechargeHeader."Processing Status" := ICRechargeHeader."Processing Status"::Failed;
                ICRechargeHeader.Modify();
            end else begin
                ICRechargeHeader."Processing Status" := ICRechargeHeader."Processing Status"::"In Progress";
                ICRechargeHeader.Modify();

                if ICRechargeMgt.ValidateRechargeRequest(ICRechargeHeader) then begin
                    Codeunit.Run(Codeunit::"IC Recharge Posting", ICRechargeHeader);
                    ICRechargeHeader."Processing Status" := ICRechargeHeader."Processing Status"::Completed;
                end else begin
                    ICRechargeHeader."Processing Status" := ICRechargeHeader."Processing Status"::Failed;
                    ICRechargeHeader."Exception Flag" := true;
                end;
                ICRechargeHeader.Modify();
            end;

            ProcessedCount += 1;
        until ICRechargeHeader.Next() = 0;
    end;

    procedure RetryFailedRecharges()
    var
        ICRechargeHeader: Record "IC Recharge Header";
        ICRechargeMgt: Codeunit "IC Recharge Management";
    begin
        ICRechargeHeader.SetRange("Processing Status", ICRechargeHeader."Processing Status"::Failed);
        ICRechargeHeader.SetRange(Posted, false);
        if not ICRechargeHeader.FindSet() then
            exit;

        repeat
            ICRechargeHeader."Exception Flag" := false;
            ICRechargeHeader."Exception Message" := '';
            ICRechargeHeader."Processing Status" := ICRechargeHeader."Processing Status"::Pending;
            ICRechargeHeader.Modify();
        until ICRechargeHeader.Next() = 0;
    end;
}
