CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE book(
book_id INT PRIMARY KEY NOT NULL,
title VARCHAR(100) NOT NULL,
publisher_id INT,
language_id INT,
book_price INT,
year_published YEAR,
FOREIGN KEY(publisher_id) REFERENCES publisher(publisher_id),
FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

CREATE TABLE book_author(
book_id INT NOT NULL,
author_id INT NOT NULL,
CONSTRAINT pk_book_author PRIMARY KEY (book_id, author_id),
FOREIGN KEY(book_id) REFERENCES book(book_id),
FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE author(
author_id INT PRIMARY KEY NOT NULL,
author_name VARCHAR(250)
);

CREATE TABLE book_language(
language_id INT PRIMARY KEY NOT NULL,
language_name VARCHAR(250) NOT NULL
);

CREATE TABLE publisher(
publisher_id INT PRIMARY KEY NOT NULL ,
publisher_name VARCHAR(250) NOT NULL
);

CREATE TABLE customer(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(100),
last_name VARCHAR(100),
customer_email VARCHAR(100)
);

CREATE TABLE country(
country_id INT PRIMARY KEY AUTO_INCREMENT,
country_name VARCHAR(30)
);

CREATE TABLE address(
address_status INT PRIMARY KEY AUTO_INCREMENT,
street VARCHAR(30),
city VARCHAR(30),
postal_code VARCHAR(20),
country_id INT,
FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address_status(
address_status_id INT PRIMARY KEY AUTO_INCREMENT,
status_name VARCHAR(20)
);

CREATE TABLE customer_address(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
address_id INT,
address_status_id INT,
FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);


CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    order_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
);

CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    method_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
);

CREATE TABLE order_history (
    order_history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    history VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id)
);

CREATE TABLE order_status (
    order_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);


CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminPass123';
GRANT ALL PRIVILEGES ON bookstoredb.* TO 'admin_user'@'localhost';

CREATE USER 'book_reader'@'localhost' IDENTIFIED BY 'bookReader123';
GRANT SELECT ON bookstoredb.* TO 'book_reader'@'localhost';

CREATE USER 'store_cashier'@'localhost' IDENTIFIED BY 'cashierPass123';
GRANT SELECT, INSERT, UPDATE ON bookstoredb.* TO 'store_cashier'@'localhost';
