CREATE DATABASE bookstore;
USE bookstore;

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
