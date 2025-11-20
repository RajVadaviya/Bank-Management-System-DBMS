-- ===== 2) Withdraw procedure =====
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE withdraw_amount(
    p_account_no IN NUMBER,
    p_amount     IN NUMBER
) AS
    v_balance NUMBER;
BEGIN
    SELECT Balance INTO v_balance FROM Account WHERE Account_No = p_account_no;

    IF v_balance >= p_amount THEN
        UPDATE Account
        SET Balance = Balance - p_amount
        WHERE Account_No = p_account_no;
        DBMS_OUTPUT.PUT_LINE('Withdrawn ' || p_amount || ' from Account ' || p_account_no);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient balance!');
    END IF;
END;
/
