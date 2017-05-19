CREATE OR REPLACE FUNCTION client_inf(l_client_id in NUMBER)
	RETURN SYS_REFCURSOR
AS
l_rc SYS_REFCURSOR;
l_address_id NUMBER;
BEGIN

	SELECT address_id INTO l_address_id
		FROM client
		WHERE client_id = l_client_id;
	
	OPEN l_rc FOR
		SELECT  *
			FROM client
			LEFT JOIN credit_card
				ON credit_card.client_id = client.client_id
			LEFT JOIN address
				ON address.address_id = l_address_id
			LEFT JOIN (SELECT client_id, COUNT(order_id) 
				  FROM orders
				  WHERE client_id = l_client_id
				  GROUP BY client_id) s2
				ON s2.client_id = client.client_id
			WHERE client.client_id = l_client_id;
	RETURN l_rc;
END;
/