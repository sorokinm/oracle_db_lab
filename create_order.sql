CREATE TYPE order_items AS TABLE OF NUMBER(7);
/
CREATE OR REPLACE PROCEDURE create_order (
	l_client_id in NUMBER,
	l_items in order_items
	)
IS
l_is_exist VARCHAR(10);
cnt NUMBER;
l_amount stock.amount%TYPE;
t_prod_id product.product_id%TYPE;
t_amount NUMBER;
t_store_id store.store_id%TYPE;
l_order_id orders.order_id%TYPE;
l_total_price NUMBER;
l_prod_price product.price%TYPE;
sysdt DATE;
BEGIN

	SELECT  CASE
				WHEN EXISTS ( SELECT client_id
							 	FROM client
						 		WHERE client_id =  l_client_id)
				THEN 'Y'
				ELSE 'N'
			END INTO l_is_exist
	FROM dual;
	
	IF l_is_exist = 'N' 
		THEN
			DBMS_OUTPUT.PUT_LINE('The client with the ID is not found!');
			RETURN;
	END IF;
	
	IF MOD(l_items.count, 3) != 0 
	THEN
		DBMS_OUTPUT.PUT_LINE('Invalid input!');
		RETURN;
	END IF;
	cnt:=l_items.count / 3;
	FOR i in 1..cnt
	LOOP
		t_prod_id:= l_items(3*(i - 1) + 1);
		t_amount:=l_items(3*(i - 1) + 2);
		t_store_id := l_items(3*(i - 1) + 3);
		-- check existing store
		SELECT  CASE
				WHEN EXISTS ( SELECT amount
							 	FROM stock
						 		WHERE store_id = t_store_id AND product_id = t_prod_id)
				THEN 'Y'
				ELSE 'N'
			END INTO l_is_exist
		FROM dual;
		IF l_is_exist = 'N' 
		THEN
			DBMS_OUTPUT.PUT_LINE('Such stock not found!');
			RETURN;
		END IF;
		
		SELECT amount INTO l_amount
			FROM stock
			WHERE store_id = t_store_id AND product_id = t_prod_id;
		
		IF l_amount < t_amount
		THEN
			DBMS_OUTPUT.PUT_LINE('There is not enough product with id ' || t_prod_id);
			RETURN;
		END IF;
		
		SELECT price INTO l_prod_price
			FROM product
			WHERE product_id = t_prod_id;
		l_total_price := l_total_price + l_prod_price;
	END LOOP;
	
	sysdt := SYSDATE;
	INSERT INTO orders (client_id, status, date_order, total_price)
		VALUES (l_client_id,'moderating',sysdt,l_total_price);
	SELECT order_id INTO l_order_id
		FROM orders
		WHERE client_id=l_client_id 
			AND status='moderating' 
			AND date_order = sysdt 
			AND total_price = l_total_price;
	FOR i in 1..cnt
	LOOP
		t_prod_id:= l_items(3*(i - 1) + 1);
		t_amount:=l_items(3*(i - 1) + 2);
		t_store_id := l_items(3*(i - 1) + 3);
		
		INSERT INTO orderitem(amount, order_id, product_id, store_id)
			VALUES (t_amount, l_order_id, t_prod_id, t_store_id);
			
		SELECT amount INTO l_amount
			FROM stock
			WHERE store_id = t_store_id AND product_id = t_prod_id;
		
		l_amount := l_amount - t_amount;
		
		UPDATE stock
			SET amount = l_amount
			WHERE store_id = t_store_id AND product_id = t_prod_id;
		
	END LOOP;
END;
/