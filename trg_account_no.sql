-- ===== 5) Account number BEFORE INSERT trigger (uses seq_account) =====
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER trg_account_no
BEFORE INSERT ON Account
FOR EACH ROW
WHEN (NEW.Account_No IS NULL)
BEGIN
    SELECT seq_account.NEXTVAL INTO :NEW.Account_No FROM dual;
END;
/
