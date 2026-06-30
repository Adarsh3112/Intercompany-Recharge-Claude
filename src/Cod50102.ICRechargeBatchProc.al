codeunit 50202 "IC Recharge Batch Proc"
{
    TableNo = "IC Recharge Header";

    trigger OnRun()
    begin
        ProcessBatch(Rec);
    end;

    procedure ProcessBatch(var ICRechargeHeader: Record "IC Recharge Header")
    var
        ICRechargeConfig: Record "IC Recharge Config";
        ProcessedCount: Integer;
        FailedCount: Integer;
    begin
        ICRechargeConfig.GetInstance();
        if not ICRechargeConfig."Enable Batch Processing" then
            Error('Batch processing is not enabled');

        ICRechargeHeader.SetRange(Status, ICRechargeHeader.Status::Approved);
        ICRechargeHeader.SetRange(Posted, false);
        if ICRechargeHeader.FindSet() then
            repeat
                if ProcessSingleDocument(ICRechargeHeader) then
                    ProcessedCount += 1
                else
                    FailedCount += 1;

                if ICRechargeConfig."Batch Size" > 0 then
                    if ProcessedCount >= ICRechargeConfig."Batch Size" then
                        break;
            until ICRechargeHeader.Next() = 0;

        Message('Batch processing completed. Processed: %1, Failed: %2', ProcessedCount, FailedCount);
    end;

    local procedure ProcessSingleDocument(var ICRechargeHeader: Record "IC Recharge Header"): Boolean
    var
        ICRechargePosting: Codeunit "IC Recharge Posting";
    begin
        ICRechargeHeader."Processing Status" := ICRechargeHeader."Processing Status"::"In Progress";
        ICRechargeHeader.Modify();
        Commit();

        if not Codeunit.Run(Codeunit::"IC Recharge Posting", ICRechargeHeader) then begin
            ICRechargeHeader."Processing Status" := ICRechargeHeader."Processing Status"::Failed;
            ICRechargeHeader."Exception Flag" := true;
            ICRechargeHeader."Exception Message" := CopyStr(GetLastErrorText(), 1, 250);
            ICRechargeHeader.Modify();
            Commit();
            ClearLastError();
            exit(false);
        end;

        ICRechargeHeader.Get(ICRechargeHeader."No.");
        ICRechargeHeader."Processing Status" := ICRechargeHeader."Processing Status"::Completed;
        ICRechargeHeader.Modify();
        Commit();
        exit(true);
    end;

    procedure RetryFailedDocuments()
    var
        ICRechargeHeader: Record "IC Recharge Header";
        RetryCount: Integer;
    begin
        ICRechargeHeader.SetRange("Processing Status", ICRechargeHeader."Processing Status"::Failed);
        ICRechargeHeader.SetRange(Posted, false);
        if ICRechargeHeader.FindSet() then
            repeat
                ICRechargeHeader."Exception Flag" := false;
                ICRechargeHeader."Exception Message" := '';
                ICRechargeHeader."Processing Status" := ICRechargeHeader."Processing Status"::Pending;
                ICRechargeHeader.Modify();
                RetryCount += 1;
            until ICRechargeHeader.Next() = 0;

        Message('Reset %1 failed documents for retry', RetryCount);
    end;

    procedure ScheduleBackgroundProcessing()
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"IC Recharge Batch Proc";
        JobQueueEntry."Job Queue Category Code" := 'ICRECHARGE';
        JobQueueEntry."Maximum No. of Attempts to Run" := 3;
        JobQueueEntry."Rerun Delay (sec.)" := 60;
        JobQueueEntry.Status := JobQueueEntry.Status::Ready;
        JobQueueEntry.Insert(true);
    end;
}
