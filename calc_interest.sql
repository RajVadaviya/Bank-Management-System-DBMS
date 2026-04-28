-- ===== 4) calc_interest function (simple) =====
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION calc_interest(p_amount NUMBER)
RETURN NUMBER IS
BEGIN
    RETURN p_amount * 0.05; -- 5% interest
END;
/
