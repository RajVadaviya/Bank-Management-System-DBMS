-- ===== 10) Exception handling sample (use an account that exists or not) =====
SET SERVEROUTPUT ON;
DECLARE
    v_balance NUMBER;
BEGIN
    SELECT Balance INTO v_balance FROM Account WHERE Account_No = 9999; -- no data expected
    DBMS_OUTPUT.PUT_LINE('Balance: ' || v_balance);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Account not found!');
END;
/
