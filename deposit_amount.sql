-- ===== 1) Deposit procedure =====
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE deposit_amount(
    p_account_no IN NUMBER,
    p_amount     IN NUMBER
) AS
BEGIN
    UPDATE Account
    SET Balance = Balance + p_amount
    WHERE Account_No = p_account_no;

    DBMS_OUTPUT.PUT_LINE('Amount ' || p_amount || ' deposited to Account ' || p_account_no);
END;
/
