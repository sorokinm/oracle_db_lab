CREATE OR REPLACE FUNCTION order_inf(l_order_id in NUMBER)
	RETURN SYS_REFCURSOR
AS
l_rc SYS_REFCURSOR;
BEGIN
	OPEN l_rc FOR
		SELECT  *
			FROM orderitem
			JOIN orders 
				ON orderitem.order_id = orders.order_id
			WHERE orders.order_id = l_order_id;
	RETURN l_rc;
END;
/