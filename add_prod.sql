CREATE OR REPLACE PROCEDURE add_product
( 	
	l_prod_name in product.product_name%TYPE, 
	l_amount in NUMBER, 
	l_descr in product.description%TYPE, 
	l_store_name in store.store_name%TYPE,
	l_price in NUMBER,
	l_supplier_name in  supplier.name%TYPE
)
IS
l_prod_id product.product_id%TYPE;
l_supp_id supplier.supplier_id%TYPE;
l_store_id store.store_id%TYPE;
l_tamount NUMBER;
l_is_exist VARCHAR(10);
BEGIN
	
	-- check existing store
	SELECT  CASE
				WHEN EXISTS ( SELECT * 
							 	FROM store
						 		WHERE store_name = l_store_name)
				THEN 'Y'
				ELSE 'N'
			END INTO l_is_exist
	FROM dual;
	
	IF l_is_exist = 'N' THEN
		DBMS_OUTPUT.PUT_LINE('Store does not exist!');
		RETURN;
	END IF;
	SELECT store_id INTO l_store_id
		FROM store
		WHERE store_name = l_store_name;
	
	-- check existing supplier
	SELECT  CASE
				WHEN EXISTS ( SELECT * 
							 	FROM supplier
						 		WHERE name = l_supplier_name)
				THEN 'Y'
				ELSE 'N'
			END INTO l_is_exist
	FROM dual;	
	IF l_is_exist = 'N' THEN
		DBMS_OUTPUT.PUT_LINE('Supplier does not exist!');
		RETURN;
	END IF;
	
	SELECT supplier_id INTO l_supp_id
		FROM supplier
		WHERE name = l_supplier_name;
		
	-- check existing product
	SELECT  CASE
				WHEN EXISTS ( SELECT * 
							 	FROM product
						 		WHERE product_name = l_prod_name AND price = l_price)
				THEN 'Y'
				ELSE 'N'
			END INTO l_is_exist
	FROM dual;
	
	IF l_is_exist = 'N' THEN
		INSERT INTO product ( product_name, description, price) 
			VALUES (l_prod_name, l_descr, l_price);
		-- here l_prod_id is not null for shure
	END IF;
	
	SELECT product_id INTO l_prod_id
		FROM product
		WHERE product_name = l_prod_name AND price = l_price;
	
	
	SELECT  CASE
				WHEN EXISTS ( SELECT * 
							 	FROM stock
						 		WHERE store_id = l_store_id AND product_id = l_prod_id)
				THEN 'Y'
				ELSE 'N'
			END INTO l_is_exist
	FROM dual;
	
	IF l_is_exist = 'N' THEN
		INSERT INTO stock (amount, store_id, product_id)
			VALUES (l_amount, l_store_id, l_prod_id);
	ELSE
		SELECT amount INTO l_tamount
			FROM stock
			WHERE store_id = l_store_id AND product_id = l_prod_id;
		l_tamount:= l_tamount + l_amount;
		UPDATE stock
		SET amount = l_tamount
		WHERE store_id = l_store_id AND product_id = l_prod_id;
	END IF;

	DBMS_OUTPUT.PUT_LINE('Product added!');
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			begin
				DBMS_OUTPUT.PUT_LINE('Ups!');
				RETURN;
			end;
END;
/