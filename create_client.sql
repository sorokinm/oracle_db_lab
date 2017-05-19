CREATE OR REPLACE PROCEDURE create_client (
	l_nick in client.nickname%TYPE,
	l_first_name in client.first_name%TYPE,
	l_last_name in client.last_name%TYPE,
	l_country in address.country%TYPE,
	l_city in address.city%TYPE,
	l_street in address.street%TYPE,
	l_building in address.building%TYPE,
	l_zip in address.zip%TYPE
	)
IS
l_is_exist VARCHAR(10);
tmp_addr_id NUMBER;
BEGIN
	tmp_addr_id := NULL;
	IF l_nick IS NULL 
		OR l_first_name IS NULL 
		OR l_last_name IS NULL 
	THEN 
		DBMS_OUTPUT.PUT_LINE('Invalid input!');
		RETURN;
	END IF;
	-- check existing nickname
	SELECT  CASE
				WHEN EXISTS ( SELECT * 
							 	FROM client
						 		WHERE nickname = l_nick)
				THEN 'Y'
				ELSE 'N'
			END INTO l_is_exist
	FROM dual;
	
	
	IF l_is_exist = 'Y' THEN
		DBMS_OUTPUT.PUT_LINE('Client exists!');
		RETURN;
	END IF;
	
	IF l_country IS NOT NULL 
		AND l_city IS NOT NULL 
		AND l_street IS NOT NULL 
		AND l_building IS NOT NULL
	THEN 
		INSERT INTO address ( country, city, street, building, zip) 
			VALUES (l_country, l_city, l_street, l_building, l_zip)
			RETURNING address_id INTO tmp_addr_id;
	ELSE
		DBMS_OUTPUT.PUT_LINE('Invalid address!');
	END IF;
	
	INSERT INTO client ( nickname, first_name, last_name, address_id, status) 
		VALUES (l_nick, l_first_name, l_last_name,tmp_addr_id, 'active');
END;
/