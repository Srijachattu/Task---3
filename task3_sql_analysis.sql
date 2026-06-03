-- Create Database

CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Create Tables

-- Customers

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

-- Products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

-- Orders

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Sample Data
-- Customers

INSERT INTO customers VALUES
(1,'Rahul','Hyderabad'),
(2,'Priya','Bangalore'),
(3,'Amit','Chennai');

-- Products
INSERT INTO products VALUES
(101,'Laptop',50000),
(102,'Mobile',20000),
(103,'Headphones',2000);

-- Orders
INSERT INTO orders VALUES
(1,1,101,1,'2025-01-10'),
(2,2,102,2,'2025-01-12'),
(3,1,103,3,'2025-01-15'),
(4,3,101,1,'2025-01-20');

-- Run Required Queries
-- SELECT
SELECT * FROM customers;

-- WHERE
SELECT * FROM products
WHERE price > 10000;

-- ORDER BY
SELECT * FROM products
ORDER BY price DESC;

-- GROUP BY
SELECT customer_id,
SUM(quantity) AS total_quantity
FROM orders
GROUP BY customer_id;


-- INNER JOIN
SELECT c.customer_name,
p.product_name,
o.quantity
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN products p
ON o.product_id = p.product_id;

-- LEFT JOIN
SELECT c.customer_name,
o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- RIGHT JOIN
SELECT c.customer_name,
o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- Aggregate Functions
-- SUM

SELECT SUM(quantity) AS total_orders
FROM orders;

-- AVG
SELECT AVG(price) AS avg_price
FROM products;

-- Subquery
SELECT product_name
FROM products
WHERE price >
(
SELECT AVG(price)
FROM products
);

-- Create View
CREATE VIEW sales_view AS
SELECT c.customer_name,
p.product_name,
o.quantity
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN products p
ON o.product_id = p.product_id;

SELECT * FROM sales_view;

-- Create Index
CREATE INDEX idx_customer
ON orders(customer_id);