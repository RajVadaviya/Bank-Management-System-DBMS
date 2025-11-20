-- ===== 7 + 8) bank_pkg spec + body (added calc_emi & account_age) =====
SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE bank_pkg AS
    PROCEDURE deposit(p_acc_no NUMBER, p_amount NUMBER);
    PROCEDURE withdraw(p_acc_no NUMBER, p_amount NUMBER);
    FUNCTION calc_emi(p_principal NUMBER, p_rate_per_year NUMBER, p_months NUMBER) RETURN NUMBER;
    FUNCTION account_age(p_acc_no NUMBER) RETURN NUMBER; -- months active
END bank_pkg;
/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE BODY bank_pkg AS

    PROCEDURE deposit(p_acc_no NUMBER, p_amount NUMBER) IS
    BEGIN
        UPDATE Account SET Balance = Balance + p_amount WHERE Account_No = p_acc_no;
        DBMS_OUTPUT.PUT_LINE('Deposited ' || p_amount || ' to ' || p_acc_no);
    END deposit;

    PROCEDURE withdraw(p_acc_no NUMBER, p_amount NUMBER) IS
        v_bal NUMBER;
    BEGIN
        SELECT Balance INTO v_bal FROM Account WHERE Account_No = p_acc_no;
        IF v_bal >= p_amount THEN
            UPDATE Account SET Balance = Balance - p_amount WHERE Account_No = p_acc_no;
            DBMS_OUTPUT.PUT_LINE('Withdrawn ' || p_amount || ' from ' || p_acc_no);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Insufficient balance!');
        END IF;
    END withdraw;

    FUNCTION calc_emi(p_principal NUMBER, p_rate_per_year NUMBER, p_months NUMBER) RETURN NUMBER IS
        v_monthly_rate NUMBER;
        v_emi NUMBER;
    BEGIN
        IF p_months <= 0 THEN
            RETURN NULL;
        END IF;
        v_monthly_rate := (p_rate_per_year / 100) / 12;
        IF v_monthly_rate = 0 THEN
            v_emi := p_principal / p_months;
        ELSE
            v_emi := (p_principal * v_monthly_rate) / (1 - POWER(1 + v_monthly_rate, -p_months));
        END IF;
        RETURN ROUND(v_emi,2);
    END calc_emi;

    FUNCTION account_age(p_acc_no NUMBER) RETURN NUMBER IS
        v_open DATE;
    BEGIN
        SELECT Opening_Date INTO v_open FROM Account WHERE Account_No = p_acc_no;
        RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, v_open));
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END account_age;

END bank_pkg;
/
