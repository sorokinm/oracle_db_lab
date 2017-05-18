SET serveroutput on;
CREATE OR REPLACE PROCEDURE procc
IS
ss  NUMBER;
BEGIN
select (2 + 4) into ss from dual;
  DBMS_OUTPUT.PUT_LINE('Hello World!' || ss);

END;
/
