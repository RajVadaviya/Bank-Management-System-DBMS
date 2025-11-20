-- ===== 6) AFTER UPDATE trigger to log transactions and audit =====
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER trg_transaction_log
AFTER UPDATE OF Balance ON Account
FOR EACH ROW
DECLARE
    v_type VARCHAR2(10);
    v_amount NUMBER;
    v_trans_id NUMBER;
BEGIN
    v_amount := NVL(:NEW.Balance,0) - NVL(:OLD.Balance,0);
    IF v_amount = 0 THEN
        RETURN; -- nothing changed
    ELSIF v_amount > 0 THEN
        v_type := 'Deposit';
    ELSE
        v_type := 'Withdraw';
        v_amount := ABS(v_amount);
    END IF;

    -- insert into Transactions
    v_trans_id := seq_trans.NEXTVAL;
    INSERT INTO Transactions(Trans_ID, Account_No, Trans_Type, Amount, Trans_Date)
    VALUES (v_trans_id, :NEW.Account_No, v_type, v_amount, SYSDATE);

    -- insert into audit table
    INSERT INTO Transaction_Audit(Audit_ID, Trans_ID, Account_No, Action, Old_Balance, New_Balance, Action_Date)
    VALUES (seq_audit.NEXTVAL, v_trans_id, :NEW.Account_No, v_type, :OLD.Balance, :NEW.Balance, SYSDATE);
END;
/
