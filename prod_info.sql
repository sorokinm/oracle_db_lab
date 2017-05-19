CREATE OR REPLACE FUNCTION product_info(l_product_id in NUMBER)
	RETURN SYS_REFCURSOR
AS
l_rc SYS_REFCURSOR;
BEGIN
	OPEN l_rc FOR
			SELECT  *
				FROM stock
				JOIN product 
				ON stock.product_id = product.product_id AND product.product_id = l_product_id;
	RETURN l_rc;
END;
/