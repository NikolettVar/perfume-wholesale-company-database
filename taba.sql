/*DATA DEFINITION LANGUAGE(DDL)*/
/*show existing databases*/
SHOW DATABASES;
/*in case sweetsmellsdb already exist, we delete it*/
DROP DATABASE IF EXISTS SWEETSMELLSDB;
/*create our database*/
CREATE DATABASE SWEETSMELLSDB;            
/*check successful creation of db*/
SHOW DATABASES;
/*pick db we wish to work with*/
USE SWEETSMELLSDB;          
/*ensure db is empty*/
SHOW TABLES;

/*create our tables with attributes, data types, PK, INDEX, FK*/

CREATE TABLE SUPPLIER(
	SUPPLIER_ID int(10) PRIMARY KEY NOT NULL,
	SUPPLIER_NAME varchar(30) NOT NULL,
	ADDRESS varchar (30),
	CITY varchar(10),
	COUNTRY varchar(20),
	INDEX(SUPPLIER_ID)
);

/*To check the structure of the table we created, we can use:*/
DESCRIBE SUPPLIER;

CREATE TABLE STAFF(
	STAFF_ID INT(10) PRIMARY KEY NOT NULL, 
	FIRST_NAME varchar(30) NOT NULL,
	LAST_NAME varchar(30) NOT NULL,
	DATE_OF_BIRTH date NOT NULL,
	ADDRESS varchar (30) NOT NULL,
	CITY varchar(10) NOT NULL,
	COUNTRY varchar(20) NOT NULL,
	PHONE_NO VARCHAR(12),
	WEEKLY_WAGE INT(4) NOT NULL,
	INDEX(STAFF_ID)
);

CREATE TABLE CUSTOMER(
	CUSTOMER_ID INT(10) PRIMARY KEY NOT NULL, 
	CUSTOMER_NAME VARCHAR(30) NOT NULL,
	ADDRESS VARCHAR (30) NOT NULL,
	CITY VARCHAR(20) NOT NULL,
	COUNTRY VARCHAR(20) NOT NULL,
	STAFF_ID INT(10),
	INDEX(CUSTOMER_ID),
	INDEX(STAFF_ID),
	CONSTRAINT S_ID FOREIGN KEY(STAFF_ID) REFERENCES STAFF(STAFF_ID)ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PRODUCT(
	PRODUCT_ID INT(10) PRIMARY KEY NOT NULL, 
	PRODUCT_NAME VARCHAR(20) NOT NULL,
	SUPPLIER_ID INT(10) NOT NULL,
	IN_STOCK_QUANTITY INT(5) NOT NULL,
	UNIT_PRICE INT(5) NOT NULL,
	INDEX(PRODUCT_ID),
	INDEX(SUPPLIER_ID),
	CONSTRAINT SUPP_ID FOREIGN KEY(SUPPLIER_ID) REFERENCES SUPPLIER(SUPPLIER_ID)ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE CUSTOMER_ORDER(
	CUSTOMER_ORDER_ID INT(10) PRIMARY KEY NOT NULL,
	CUSTOMER_ID INT(10),
	ORDER_DATE DATE,
	INDEX(CUSTOMER_ORDER_ID),
	INDEX(CUSTOMER_ID),
	CONSTRAINT CUS_ID FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE CUSTOMER_ORDER_DETAIL(
	CUSTOMER_ORDER_DETAIL_ID INT(10) PRIMARY KEY NOT NULL,	
	PRODUCT_ID INT(10) NOT NULL,
	CUSTOMER_ORDER_ID INT(10) NOT NULL,
	ORDER_QUANTITY INT(5) NOT NULL,
	ORDER_VALUE INT(10),
	ORDER_STATUS VARCHAR(20),
	ORDER_DATE DATE,
	INDEX(CUSTOMER_ORDER_DETAIL_ID),
	INDEX(PRODUCT_ID),
	INDEX(CUSTOMER_ORDER_ID),
	CONSTRAINT PROD_ID FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID)ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT ORD_ID FOREIGN KEY(CUSTOMER_ORDER_ID) REFERENCES CUSTOMER_ORDER(CUSTOMER_ORDER_ID)ON UPDATE CASCADE ON DELETE CASCADE
);
SHOW TABLES;


INSERT INTO SUPPLIER VALUES(1, 'Armani', 'Via Borgonuovo', 'Milan', 'Italy');
INSERT INTO SUPPLIER VALUES(2, 'Dior', '30 Montaigne Avenue', 'Paris', 'France');
INSERT INTO SUPPLIER VALUES(3, 'Lancome', '52 Avenue des Champs-Elys??es', 'Paris', 'France');
INSERT INTO SUPPLIER VALUES(4, 'Tom Ford', '672 Madison Avenue', 'New York', 'USA');
INSERT INTO SUPPLIER VALUES(5, 'Inis', 'Jamesons Corner', 'Kimacanoge', 'Ireland');
SELECT * FROM SUPPLIER;

INSERT INTO STAFF VALUES(1, 'John', 'McCabe', STR_TO_DATE('05-01-1986', '%m-%d-%Y'), '94 McDonagh Road', 'Waterford', 'Ireland', '0865681445', 455);
INSERT INTO STAFF VALUES(2, 'Mary', 'Malone', STR_TO_DATE('06-04-1982', '%m-%d-%Y'), '25 Ashe Road', 'Waterford', 'Ireland', '0875782435', 440);
INSERT INTO STAFF VALUES(3, 'Orla', 'Kennedy', STR_TO_DATE('12-22-1988', '%m-%d-%Y'), '66 Devil Road', 'New Ross', 'Ireland', '0865652666', 400);
INSERT INTO STAFF VALUES(4, 'Patrick', 'Connor', STR_TO_DATE('11-08-1976', '%m-%d-%Y'), '10 Drunken Terrace', 'Tramore', 'Ireland', '0855652446', 390);
INSERT INTO STAFF VALUES(5, 'Stacy', 'Fitzpatrick', STR_TO_DATE('08-26-1990', '%m-%d-%Y'), '44 Cork Road', 'Waterfod', 'Ireland', '0835652433', 410);
SELECT * FROM STAFF;

INSERT INTO CUSTOMER VALUES(1, 'Heavenly Scents', '35 Main Street', 'Tramore', 'Ireland', 2);
INSERT INTO CUSTOMER VALUES(2, 'Perfume Parlor', '10 Arundel Square', 'Waterford', 'Ireland', 3);
INSERT INTO CUSTOMER VALUES(3, 'Perfume World', '25 Poppy Lane', 'New Ross', 'Ireland', 5);
INSERT INTO CUSTOMER VALUES(4, 'Scented Dreams', '66 Cork Road', 'Waterford', 'Ireland', 1);
INSERT INTO CUSTOMER VALUES(5, 'World of Fragrances', '50 Morrissons Road', 'Waterford', 'Ireland', 4);
SELECT * FROM CUSTOMER;

INSERT INTO PRODUCT VALUES(1, 'Acqua di Gio', 1, 156, 110);
INSERT INTO PRODUCT VALUES(2, 'Miss Dior', 2, 610, 90);
INSERT INTO PRODUCT VALUES(3, 'Tresor', 3, 720, 130);
INSERT INTO PRODUCT VALUES(4, 'Black Orchid', 4, 613, 150);
INSERT INTO PRODUCT VALUES(5, 'Inis Cologne', 5, 215, 85);
SELECT * FROM PRODUCT;

INSERT INTO CUSTOMER_ORDER VALUES(1, 2, STR_TO_DATE('05-08-21', '%m-%d-%Y'));
INSERT INTO CUSTOMER_ORDER VALUES(2, 1, STR_TO_DATE('04-30-21', '%m-%d-%Y'));
INSERT INTO CUSTOMER_ORDER VALUES(3, 4, STR_TO_DATE('01-31-21', '%m-%d-%Y'));
INSERT INTO CUSTOMER_ORDER VALUES(4, 5, STR_TO_DATE('02-12-21', '%m-%d-%Y'));
INSERT INTO CUSTOMER_ORDER VALUES(5, 3, STR_TO_DATE('04-09-21', '%m-%d-%Y'));
SELECT * FROM CUSTOMER_ORDER;

INSERT INTO CUSTOMER_ORDER_DETAIL VALUES(1, 2, 3, 3, 270, 'UNPAID', STR_TO_DATE('01-31-21', '%m-%d-%Y'));
INSERT INTO CUSTOMER_ORDER_DETAIL VALUES(2, 1, 1, 5, 550, 'PAID', STR_TO_DATE('05-08-21', '%m-%d-%Y'));
INSERT INTO CUSTOMER_ORDER_DETAIL VALUES(3, 4, 2, 4, 600, 'PAID', STR_TO_DATE('04-30-21', '%m-%d-%Y'));
INSERT INTO CUSTOMER_ORDER_DETAIL VALUES(4, 5, 4, 2, 170, 'UNPAID', STR_TO_DATE('02-12-21', '%m-%d-%Y'));
INSERT INTO CUSTOMER_ORDER_DETAIL VALUES(5, 3, 5, 7, 910, 'PAID',  STR_TO_DATE('04-09-21', '%m-%d-%Y'));
SELECT * FROM CUSTOMER_ORDER_DETAIL;

/*DML, QUERY THE DATASET*/

/*1. A query which returns a view containing the total value of all sales within the last 30 days.*/
SELECT * FROM CUSTOMER_ORDER_DETAIL;
CREATE VIEW RECENT_SALES AS
SELECT SUM(ORDER_VALUE) FROM CUSTOMER_ORDER_DETAIL WHERE ORDER_DATE > DATE_SUB(NOW() , INTERVAL 1 MONTH);
SELECT * FROM RECENT_SALES;

/*2. A view that shows all items which have a current stock quantity of 200 or fewer.*/
SELECT * FROM PRODUCT; 
CREATE VIEW CURRENT_QUANTITY_LOW AS
SELECT PRODUCT_NAME, IN_STOCK_QUANTITY FROM PRODUCT WHERE IN_STOCK_QUANTITY <= 200;
SELECT * FROM CURRENT_QUANTITY_LOW;

/*3. A query that returns a view for suppliers based outside Ireland.*/
SELECT * FROM SUPPLIER;
CREATE VIEW NON_IRISH_SUPPLIERS AS
SELECT SUPPLIER_NAME, CITY, COUNTRY FROM SUPPLIER WHERE COUNTRY != 'Ireland';
SELECT * FROM NON_IRISH_SUPPLIERS; 

/*4. A query that comprises of a two table join.*/
/*This join will return a table so that we can see which product item appears in which customer order.*/
/*The join uses the column PRODUCT_ID that is present in both PRODUCT AND CUSTOMER_ORDER_DETAIL tables. */
SELECT PRODUCT.PRODUCT_NAME, CUSTOMER_ORDER_DETAIL.CUSTOMER_ORDER_ID
FROM PRODUCT
INNER JOIN CUSTOMER_ORDER_DETAIL
ON PRODUCT.PRODUCT_ID = CUSTOMER_ORDER_DETAIL.PRODUCT_ID;

/*5. A query that will return a view showing item purchase quantity sorting by lowest to 
highest.*/
/*This query joins PRODUCT and CUSTOMER_ORDER_DETAIL tables. The result will clearly show the quantity sold of each product item.*/
CREATE VIEW ITEM_PURCHASE_QUANTITY AS
SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME, CUSTOMER_ORDER_DETAIL.ORDER_QUANTITY
FROM PRODUCT, CUSTOMER_ORDER_DETAIL
WHERE PRODUCT.PRODUCT_ID = CUSTOMER_ORDER_DETAIL.PRODUCT_ID
ORDER BY ORDER_QUANTITY ASC;
SELECT * FROM ITEM_PURCHASE_QUANTITY;

/* 6. A query that returns all stock items which have a quantity of 600 and above sorting 
by item title in alphabetical order.*/
SELECT * FROM PRODUCT;
SELECT * FROM PRODUCT WHERE IN_STOCK_QUANTITY >= 600 ORDER BY PRODUCT_NAME ASC;

/*7. Create a view which will display all orders which are not paid*/
SELECT * FROM CUSTOMER_ORDER_DETAIL;
CREATE VIEW UNPAID_ORDERS AS
SELECT CUSTOMER_ORDER_ID, ORDER_DATE FROM CUSTOMER_ORDER_DETAIL WHERE ORDER_STATUS = 'UNPAID';
SELECT * FROM UNPAID_ORDERS;

/*8. A query that shows all items ordered by any one customer for one order. So show 
for example what customer no 1 ordered in order no 1.*/
/*Here we need data from 4 different tables; we will create 2 views from 2 tables each and then join these views.*/
CREATE VIEW CUSTOMERS_AND_IDS AS
SELECT CUSTOMER.CUSTOMER_NAME, CUSTOMER.CUSTOMER_ID, CUSTOMER_ORDER.CUSTOMER_ORDER_ID
FROM CUSTOMER, CUSTOMER_ORDER
WHERE CUSTOMER.CUSTOMER_ID = CUSTOMER_ORDER.CUSTOMER_ID;
SELECT * FROM CUSTOMERS_AND_IDS;

CREATE VIEW PRODUCTS_IN_ORDER AS
SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME, CUSTOMER_ORDER_DETAIL.CUSTOMER_ORDER_ID
FROM PRODUCT, CUSTOMER_ORDER_DETAIL
WHERE PRODUCT.PRODUCT_ID = CUSTOMER_ORDER_DETAIL.PRODUCT_ID;
SELECT * FROM PRODUCTS_IN_ORDER;

SELECT CUSTOMERS_AND_IDS.CUSTOMER_NAME, CUSTOMERS_AND_IDS.CUSTOMER_ORDER_ID, PRODUCTS_IN_ORDER.PRODUCT_NAME
FROM CUSTOMERS_AND_IDS
INNER JOIN PRODUCTS_IN_ORDER
ON CUSTOMERS_AND_IDS.CUSTOMER_ORDER_ID = PRODUCTS_IN_ORDER.CUSTOMER_ORDER_ID;

/*9a. Update the price of one product throughout the whole products table*/
SELECT * FROM PRODUCT;
UPDATE PRODUCT SET UNIT_PRICE = 120 WHERE PRODUCT_NAME = 'Miss Dior';
SELECT * FROM PRODUCT;

/*9b. Increase all staff wages by 5%*/
SELECT * FROM STAFF;
UPDATE STAFF SET WEEKLY_WAGE = WEEKLY_WAGE + WEEKLY_WAGE * 0.05 WHERE STAFF_ID BETWEEN 1 AND 5;
SELECT * FROM STAFF;

/*9c. Delete all orders which have not been paid and that are older than 60 days.*/
SELECT * FROM CUSTOMER_ORDER_DETAIL;
DELETE FROM CUSTOMER_ORDER_DETAIL WHERE ORDER_DATE < DATE_SUB(NOW() , INTERVAL 2 MONTH) AND ORDER_STATUS = 'UNPAID';
SELECT * FROM CUSTOMER_ORDER_DETAIL;

/*9d. Set all orders that are paid to have a status of dispatched.*/
SELECT * FROM CUSTOMER_ORDER_DETAIL;
UPDATE CUSTOMER_ORDER_DETAIL SET ORDER_STATUS = 'DISPATCHED' WHERE ORDER_STATUS = 'PAID';
SELECT * FROM CUSTOMER_ORDER_DETAIL;

