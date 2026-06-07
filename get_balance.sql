-- ===== 3) get_balance function =====
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION get_balance(p_account_no IN NUMBER)
RETURN NUMBER IS
    v_balance NUMBER;
BEGIN
    SELECT Balance INTO v_balance FROM Account WHERE Account_No = p_account_no;
    RETURN v_balance;
END;
/
