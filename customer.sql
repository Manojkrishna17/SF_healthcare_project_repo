CREATE OR REPLACE TABLE CUSTOMER (
    CUSTOMER_ID NUMBER,
    CUSTOMER_NAME STRING,
    CITY STRING,
    AGE NUMBER
);

INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_NAME, CITY, AGE)
VALUES
(1, 'John', 'New York', 25),
(2, 'Emma', 'Chicago', 30),
(3, 'Michael', 'Dallas', 28),
(4, 'Sophia', 'Seattle', 32),
(5, 'William', 'Miami', 27);

INSERT INTO CUSTOMER
VALUES (6, 'Sara', 'Miami', 23);

select * from customer;
