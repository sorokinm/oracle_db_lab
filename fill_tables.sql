INSERT INTO product ( product_name, description, price) 
	VALUES ('Гематоген', 'Шоколадный батончик', 15);
	
INSERT INTO product ( product_name, description, price) 
	VALUES ('Витаминки', 'Драже', 10);
	
INSERT INTO product ( product_name, description, price) 
	VALUES ('Гексорал', 'Спрей', 100);

INSERT INTO address( country, city, street, building, zip) 
	VALUES ('РФ', 'Тверь', 'Моковская', '23', '123432');
	
INSERT INTO address( country, city, street, building, zip) 
	VALUES ('РФ', 'Москва', 'Каширское шоссе', '3', '1234562');
	
INSERT INTO address( country, city, street, building, zip) 
	VALUES ('РФ', 'Тула', 'Погожая', '7', '1234567');
	
INSERT INTO review( text, product_id) 
	VALUES ('Все ок!', 1);
	
INSERT INTO review( text, product_id) 
	VALUES ('ничего не скажу!', 2);

INSERT INTO store (store_name, address_id)
	VALUES ('Аптека№1', 1);
	
INSERT INTO store (store_name, address_id)
	VALUES ('Аптека№2', 1);
	
INSERT INTO stock (amount, store_id, product_id)
	VALUES (55, 1, 1);
	
INSERT INTO stock (amount, store_id, product_id)
	VALUES (45, 2, 2);

INSERT INTO contacts(email, phone_number, fax)
	VALUES ('s@rr.ru', '34565','6543');
	
INSERT INTO contacts(email, phone_number, fax)
	VALUES ('hgfd@rr.ru', '87654','5453');

INSERT INTO contacts(email, phone_number, fax)
	VALUES ('ffe@rr.ru', '8343454','544453');
	
INSERT INTO supplier(name)
	VALUES ('Нижфарм');
INSERT INTO supplier(name)
	VALUES ('Мосфарм');

INSERT INTO product_supply(supplier_id, product_id, amount)
	VALUES(1,1,50);
INSERT INTO product_supply(supplier_id, product_id, amount)
	VALUES(2,2,30);
	
	
	

