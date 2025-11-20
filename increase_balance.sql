SET SERVEROUTPUT ON;
BEGIN
    FOR rec IN (SELECT Account_No, Balance FROM Account) LOOP
        IF rec.Balance < 10000 THEN
            UPDATE Account SET Balance = Balance + 1000 WHERE Account_No = rec.Account_No;
            DBMS_OUTPUT.PUT_LINE('Account ' || rec.Account_No || ' updated by +1000');
        ELSE
            UPDATE Account SET Balance = Balance + 500 WHERE Account_No = rec.Account_No;
            DBMS_OUTPUT.PUT_LINE('Account ' || rec.Account_No || ' updated by +500');
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Balances updated successfully!');
END;
/
