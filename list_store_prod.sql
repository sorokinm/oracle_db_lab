CREATE OR REPLACE FUNCTION list_st_prod(l_store_id in NUMBER)
	RETURN SYS_REFCURSOR
AS
l_rc SYS_REFCURSOR;
BEGIN
	OPEN l_rc FOR
		SELECT  stock.product_id, product.product_name, product.price, stock.amount
			FROM stock
			JOIN product
			ON stock.product_id = product.product_id AND stock.store_id = l_store_id;			
	RETURN l_rc;
END;
/