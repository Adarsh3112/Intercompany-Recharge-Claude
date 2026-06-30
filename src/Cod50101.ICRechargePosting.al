codeunit 50201 "IC Recharge Posting"
{
    TableNo = "IC Recharge Header";

    trigger OnRun()
    begin
        PostRecharge(Rec);
    end;

    procedure PostRecharge(var ICRechargeHeader: Record "IC Recharge Header")
    var
        ICRechargeMgt: Codeunit "IC Recharge Management";
    begin
        if ICRechargeMgt.CheckDuplicatePosting(ICRechargeHeader."No.") then
            Error('Document %1 has already been posted', ICRechargeHeader."No.");

        ICRechargeMgt.PostRechargeRequest(ICRechargeHeader);
        CreateICOutboxTransactions(ICRechargeHeader);
        Commit();
    end;

    local procedure CreateICOutboxTransactions(var ICRechargeHeader: Record "IC Recharge Header")
    var
        ICRechargeLine: Record "IC Recharge Line";
        ICOutboxTransaction: Record "IC Outbox Transaction";
        ICOutboxJnlLine: Record "IC Outbox Jnl. Line";
        TransactionNo: Integer;
        LineNo: Integer;
    begin
        ICRechargeLine.SetRange("Document No.", ICRechargeHeader."No.");
        if not ICRechargeLine.FindSet() then
            exit;

        repeat
            TransactionNo := GetNextICTransactionNo();
            LineNo := 10000;

            ICOutboxTransaction.Init();
            ICOutboxTransaction."Transaction No." := TransactionNo;
            ICOutboxTransaction."IC Partner Code" := ICRechargeLine."IC Partner Code";
            ICOutboxTransaction."Source Type" := ICOutboxTransaction."Source Type"::"Journal Line";
            ICOutboxTransaction."Document Type" := ICOutboxTransaction."Document Type"::" ";
            ICOutboxTransaction."Document No." := ICRechargeHeader."No.";
            ICOutboxTransaction."Posting Date" := ICRechargeHeader."Posting Date";
            ICOutboxTransaction."Document Date" := ICRechargeHeader."Document Date";
            if ICOutboxTransaction.Insert() then;

            ICOutboxJnlLine.Init();
            ICOutboxJnlLine."Transaction No." := TransactionNo;
            ICOutboxJnlLine."IC Partner Code" := ICRechargeLine."IC Partner Code";
            ICOutboxJnlLine."Line No." := LineNo;
            ICOutboxJnlLine."Account Type" := ICOutboxJnlLine."Account Type"::"G/L Account";
            ICOutboxJnlLine."Account No." := ICRechargeLine."Target IC G/L Account No.";
            ICOutboxJnlLine.Amount := ICRechargeLine."Allocated Amount";
            ICOutboxJnlLine.Description := CopyStr(ICRechargeLine.Description, 1, 100);
            ICOutboxJnlLine."Currency Code" := ICRechargeLine."Currency Code";
            ICOutboxJnlLine."Document No." := ICRechargeHeader."No.";
            if ICOutboxJnlLine.Insert() then;

            ICRechargeLine."IC Transaction No." := TransactionNo;
            ICRechargeLine.Modify();
        until ICRechargeLine.Next() = 0;
    end;

    local procedure GetNextICTransactionNo(): Integer
    var
        ICOutboxTransaction: Record "IC Outbox Transaction";
    begin
        if ICOutboxTransaction.FindLast() then
            exit(ICOutboxTransaction."Transaction No." + 1)
        else
            exit(1);
    end;

    procedure ProcessICInbox(var ICInboxTransaction: Record "IC Inbox Transaction")
    var
        ICInboxJnlLine: Record "IC Inbox Jnl. Line";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        LineNo: Integer;
    begin
        ICInboxJnlLine.SetRange("Transaction No.", ICInboxTransaction."Transaction No.");
        if not ICInboxJnlLine.FindSet() then
            exit;

        if not FindICGenJnlBatch(GenJnlBatch, GenJnlTemplate) then
            Error('IC General Journal Batch not found');

        GenJnlLine.SetRange("Journal Template Name", GenJnlTemplate.Name);
        GenJnlLine.SetRange("Journal Batch Name", GenJnlBatch.Name);
        if GenJnlLine.FindLast() then
            LineNo := GenJnlLine."Line No." + 10000
        else
            LineNo := 10000;

        repeat
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := GenJnlTemplate.Name;
            GenJnlLine."Journal Batch Name" := GenJnlBatch.Name;
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := ICInboxTransaction."Posting Date";
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
            GenJnlLine."Document No." := ICInboxTransaction."Document No.";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
            GenJnlLine."IC Partner Code" := ICInboxTransaction."IC Partner Code";
            GenJnlLine.Amount := ICInboxJnlLine.Amount;
            GenJnlLine.Description := ICInboxJnlLine.Description;
            GenJnlLine.Insert(true);
            LineNo += 10000;
        until ICInboxJnlLine.Next() = 0;
    end;

    local procedure FindICGenJnlBatch(var GenJnlBatch: Record "Gen. Journal Batch"; var GenJnlTemplate: Record "Gen. Journal Template"): Boolean
    begin
        GenJnlTemplate.SetRange(Type, GenJnlTemplate.Type::Intercompany);
        if GenJnlTemplate.FindFirst() then begin
            GenJnlBatch.SetRange("Journal Template Name", GenJnlTemplate.Name);
            if GenJnlBatch.FindFirst() then
                exit(true);
        end;
        exit(false);
    end;
}
