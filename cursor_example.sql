-- ===== 9) Example cursor program (unchanged but uses correct account numbers) =====
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_high IS SELECT Account_No, Balance FROM Account WHERE Balance > 50000;
    v_acc Account.Account_No%TYPE;
    v_bal Account.Balance%TYPE;
BEGIN
    OPEN c_high;
    LOOP
        FETCH c_high INTO v_acc, v_bal;
        EXIT WHEN c_high%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Account: ' || v_acc || ' | Balance: ' || v_bal);
    END LOOP;
    CLOSE c_high;
END;
/
