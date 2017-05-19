CREATE OR REPLACE PROCEDURE delete_order (l_order_id in NUMBER)
AS
l_is_exist VARCHAR(10);
l_status orders.status%TYPE;

CURSOR items IS SELECT * 
					FROM orderitem
					WHERE order_id = l_order_id;
l_item_row items%ROWTYPE;
BEGIN
-- check existing order
	SELECT  CASE
				WHEN EXISTS ( SELECT * 
							 	FROM orders
						 		WHERE order_id = l_order_id)
				THEN 'Y'
				ELSE 'N'
			END INTO l_is_exist
	FROM dual;
	
	IF l_is_exist = 'N' THEN
		DBMS_OUTPUT.PUT_LINE('Order does not exist!');
		RETURN;
	END IF;
	
	SELECT status INTO l_status
		FROM orders
		WHERE order_id = l_order_id;
	--DBMS_OUTPUT.PUT_LINE(l_status);
	IF l_status = 'deleted' THEN
		DBMS_OUTPUT.PUT_LINE('Order has been deleted!');
		RETURN;
	END IF;
	
	UPDATE orders
		SET status = 'deleted'
		WHERE order_id = l_order_id;
	OPEN items;
	LOOP
		FETCH items INTO l_item_row;
		EXIT WHEN items%NOTFOUND;
		UPDATE stock
			SET amount = amount + l_item_row.amount
			WHERE store_id = l_item_row.store_id 
				AND product_id = l_item_row.product_id;

		UPDATE orderitem
			SET amount = 0
			WHERE store_id = l_item_row.store_id 
				AND product_id = l_item_row.product_id 
				AND order_id = l_item_row.order_id;
	END LOOP;
	CLOSE items;
END;
/