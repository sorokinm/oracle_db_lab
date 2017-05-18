CREATE TABLE product (
	product_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	product_name NVARCHAR2(110) NOT NULL,
	description nclob,
	price NUMBER(15) NOT NULL
);
ALTER  TABLE product ADD (CONSTRAINT prod_pk PRIMARY KEY(product_id));

CREATE TABLE store(
	store_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	store_name NVARCHAR2(110) NOT NULL
);
ALTER  TABLE store ADD (CONSTRAINT store_pk PRIMARY KEY(store_id));

CREATE TABLE stock (
	store_id NUMBER(15) NOT NULL,
	product_id NUMBER(15) NOT NULL,
	amount NUMBER(15),
	CONSTRAINT store_fk FOREIGN KEY (store_id) REFERENCES store(store_id),
	CONSTRAINT prodstoc_fk FOREIGN KEY (product_id) REFERENCES product(product_id),
	CONSTRAINT stock_pk PRIMARY KEY (store_id, product_id)
);

CREATE TABLE review (
	review_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	text nclob NOT NULL,
	product_id NUMBER(15) NOT NULL,
	CONSTRAINT prodreview_fk FOREIGN KEY (product_id) REFERENCES product(product_id)
);
ALTER  TABLE review ADD (CONSTRAINT review_pk PRIMARY KEY(review_id));

CREATE TABLE address (
	address_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	country NVARCHAR2(100) NOT NULL,
	city NVARCHAR2(100) NOT NULL,
	street NVARCHAR2(100) NOT NULL,
	building NVARCHAR2(110) NOT NULL,
	zip NVARCHAR2(140) NOT NULL
);
ALTER  TABLE address ADD (CONSTRAINT address_pk PRIMARY KEY(address_id));

CREATE TABLE client (
	client_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	nickname NVARCHAR2(140) NOT NULL,
	address_id NUMBER(15),
	CONSTRAINT client_addr_fk FOREIGN KEY (address_id) REFERENCES address(address_id),
	first_name NVARCHAR2(140) NOT NULL,
	last_name NVARCHAR2(140) NOT NULL
);
ALTER  TABLE client ADD (CONSTRAINT client_pk PRIMARY KEY(client_id));

CREATE TABLE credit_card (
	credit_card_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	number_c VARCHAR(125) NOT NULL,
	owner NVARCHAR2(140) NOT NULL,
	expiration_date DATE NOT NULL,
	client_id NUMBER(15) NOT NULL,
	CONSTRAINT credit_client_fk FOREIGN KEY (client_id) REFERENCES client(client_id)
);
ALTER  TABLE credit_card ADD (CONSTRAINT credit_card_pk PRIMARY KEY(credit_card_id));

CREATE TABLE orders(
	order_id NUMBER(15) 
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	date_order DATE NOT NULL,
	status NVARCHAR2(110) NOT NULL,
	total_price NUMBER(6) NOT NULL,
	client_id NUMBER(15) NOT NULL,
	CONSTRAINT orderclient_fk FOREIGN KEY (client_id) REFERENCES client(client_id)
);
ALTER  TABLE orders ADD (CONSTRAINT orders_pk PRIMARY KEY(order_id));

CREATE TABLE orderitem (
        order_id NUMBER(15) NOT NULL,
        product_id NUMBER(15) NOT NULL,
		store_id NUMBER NOT NULL,
		amount NUMBER NOT NULL,
        CONSTRAINT orderitem_fk FOREIGN KEY (order_id) REFERENCES orders(order_id),
        CONSTRAINT prod_orderitem_fk FOREIGN KEY (product_id) REFERENCES product(product_id),
        CONSTRAINT orderitem_pk PRIMARY KEY (order_id, product_id)
);

CREATE TABLE contacts (
	contact_id  NUMBER(15)
                GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	email NVARCHAR2(120),
	phone_number NVARCHAR2(130) NOT NULL,
	fax NVARCHAR2(120)
);
ALTER  TABLE contacts ADD (CONSTRAINT contacts_pk PRIMARY KEY(contact_id));

CREATE TABLE supplier (
	supplier_id NUMBER(15)
		GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
	name NVARCHAR2(130) NOT NULL,
	contact_id NUMBER(15),
	CONSTRAINT supp_cont_fk FOREIGN KEY(contact_id) REFERENCES contacts(contact_id),
	address_id NUMBER(15),
	CONSTRAINT supp_addr_fk FOREIGN KEY(address_id) REFERENCES address(address_id)
);
ALTER  TABLE supplier ADD (CONSTRAINT supplier_pk PRIMARY KEY(supplier_id));

CREATE TABLE product_supply (
        supplier_id NUMBER(15) NOT NULL,
        product_id NUMBER(15) NOT NULL,
        amount NUMBER(15) NOT NULL,
        CONSTRAINT supplier_fk FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
        CONSTRAINT prodsuppl_fk FOREIGN KEY (product_id) REFERENCES product(product_id),
        CONSTRAINT prod_supp_pk PRIMARY KEY (supplier_id, product_id)
);


ALTER TABLE store ADD address_id NUMBER(15);
ALTER TABLE store ADD(CONSTRAINT store_address_fk FOREIGN KEY(address_id) REFERENCES address(address_id));

ALTER TABLE stock ADD address_id NUMBER(15);
ALTER TABLE stock ADD(CONSTRAINT stock_address_fk FOREIGN KEY(address_id) REFERENCES address(address_id));

SET serveroutput on;




