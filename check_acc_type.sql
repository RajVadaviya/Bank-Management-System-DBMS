-- ✅ check_acc_type.sql
SET SERVEROUTPUT ON;
DECLARE
    v_acc_no    Account.Account_No%TYPE := &Enter_Account_No;
    v_acc_type  Account.Account_Type%TYPE;
BEGIN
    SELECT Account_Type INTO v_acc_type
    FROM Account
    WHERE Account_No = v_acc_no;

    IF UPPER(v_acc_type) = 'SAVINGS' THEN
        DBMS_OUTPUT.PUT_LINE('Account ' || v_acc_no || ' is a Savings Account.');
    ELSIF UPPER(v_acc_type) = 'CURRENT' THEN
        DBMS_OUTPUT.PUT_LINE('Account ' || v_acc_no || ' is a Current Account.');
    ELSIF UPPER(v_acc_type) = 'FIXED DEPOSIT' THEN
        DBMS_OUTPUT.PUT_LINE('Account ' || v_acc_no || ' is a Fixed Deposit Account.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account ' || v_acc_no || ' has an Unknown Type.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Account number ' || v_acc_no || ' does not exist.');
END;
/
