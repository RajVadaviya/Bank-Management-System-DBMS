-- 1) Calculate and display 5% interest for each account
SET SERVEROUTPUT ON;
DECLARE
    v_acc_no   Account.Account_No%TYPE;
    v_balance  Account.Balance%TYPE;
    v_interest NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Account_No | Balance | Interest(5%)');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    
    FOR rec IN (SELECT Account_No, Balance FROM Account) LOOP
        v_acc_no := rec.Account_No;
        v_balance := rec.Balance;
        v_interest := v_balance * 0.05;
        
        DBMS_OUTPUT.PUT_LINE(v_acc_no || ' | ' || v_balance || ' | ' || v_interest);
    END LOOP;
END;
/
