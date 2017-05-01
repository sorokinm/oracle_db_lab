CREATE TABLE product (
	product_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	product_name VARCHAR(15) NOT NULL,
	description VARCHAR(100),
	price NUMBER(15) NOT NULL
);
ALTER  TABLE product ADD (CONSTRAINT prod_pk PRIMARY KEY(product_id));

CREATE TABLE store(
	store_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	store_name VARCHAR(15) NOT NULL
);
ALTER  TABLE store ADD (CONSTRAINT store_pk PRIMARY KEY(store_id));

CREATE TABLE stock (
	store_id NUMBER(15) NOT NULL,
	product_id NUMBER(15) NOT NULL,
	amount NUMBER(15),
	CONSTRAINT store_fk FOREIGN KEY (store_id) REFERENCES store(store_id),
	CONSTRAINT prod_fk FOREIGN KEY (product_id) REFERENCES product(product_id),
	CONSTRAINT stock_pk PRIMARY KEY (store_id, product_id)
);

CREATE TABLE review (
	review_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	text VARCHAR(100) NOT NULL,
	product_id NUMBER(15) NUT NULL,
	CONSTRAINT prod_fk FOREIGN KEY (product_id) REFERENCES product(product_id)
);
ALTER  TABLE review ADD (CONSTRAINT review_pk PRIMARY KEY(review_id));

CREATE TABLE address (
	address_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	country VARCHAR(40) NOT NULL,
	street VARCHAR(40) NOT NULL,
	building VARCHAR(40) NOT NULL,
	zip VARCHAR(40) NOT NULL
);
ALTER  TABLE address ADD (CONSTRAINT address_pk PRIMARY KEY(address_id));


