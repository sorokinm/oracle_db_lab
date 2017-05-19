CREATE OR REPLACE PROCEDURE block_client (l_client_id NUMBER)
IS
l_is_exist VARCHAR(10);
CURSOR orders IS SELECT * 
					FROM orders
					WHERE client_id = l_client_id;
l_order_row orders%ROWTYPE;
BEGIN
	SELECT  CASE
				WHEN EXISTS ( SELECT * 
							 	FROM client
						 		WHERE client_id = l_client_id)
				THEN 'Y'
				ELSE 'N'
			END INTO l_is_exist
	FROM dual;
	
	IF l_is_exist = 'N' THEN
		DBMS_OUTPUT.PUT_LINE('Client does not exist!');
		RETURN;
	END IF;
	
	UPDATE client
		SET status = 'blocked'
		WHERE client_id = l_client_id;
	OPEN orders;
	LOOP
		FETCH orders INTO l_order_row;
		EXIT WHEN orders%NOTFOUND;
		
		delete_order(l_order_row.order_id);
		
	END LOOP;
	CLOSE orders;
END;
/