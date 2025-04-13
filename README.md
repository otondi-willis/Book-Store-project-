# Book-Store-project-
Database Design &amp; Programming with SQL

```md
# 📚 Bookstore Database Schema

This project defines the SQL schema for a **Bookstore Management System**. The database structure supports tracking books, authors, publishers, customers, orders, and shipping—everything needed for an online or physical bookstore.

---

## 📦 Database Initialization

```sql
-- Create the Bookstore database
CREATE DATABASE Bookstore;

-- Select the Bookstore database
USE Bookstore;
```

---

## 📄 Schema Overview

Below is a breakdown of each table along with its purpose and constraints.

---

### 1. `book_language`

Stores the supported languages for books.

```sql
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT, -- Unique ID for each language
    name VARCHAR(50) NOT NULL                   -- Name of the language (e.g., English, French)
);
```

---

### 2. `publisher`

Holds publisher information.

```sql
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT, -- Unique ID for publisher
    name VARCHAR(100) NOT NULL,                  -- Publisher name
    website VARCHAR(100)                         -- Optional website URL
);
```

---

### 3. `author`

Stores basic author details.

```sql
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
```

---

### 4. `book`

Main table containing book information.

```sql
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150),                            -- Book title
    isbn VARCHAR(20),                              -- International Standard Book Number
    Genre VARCHAR(50),                             -- Book genre (e.g., Fiction, History)
    price DECIMAL(10, 2),                          -- Price of the book
    stock INT,                                     -- Available stock
    language_id INT,                               -- Foreign key to book_language
    publisher_id INT,                              -- Foreign key to publisher
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);
```

---

### 5. `book_author`

Many-to-many relationship between books and authors.

```sql
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);
```

---

### 6. `country`

Reference table for country names.

```sql
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)                             
```

---

### 7. `address`

Stores customer address data.

```sql
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(150),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);
```

---

### 8. `address_status`

Defines status of an address (e.g., shipping, billing, default).

```sql
CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50)
);
```

---

### 9. `customer`

Holds customer account information.

```sql
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20)
);
```

---

### 10. `customer_address`

Associates customers with addresses and their types (billing, shipping, etc.).

```sql
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);
```

---

### 11. `shipping_method`

Available delivery/shipping options.

```sql
CREATE TABLE shipping_method (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100),                     -- e.g., Standard, Express
    cost DECIMAL(10, 2)                           -- Shipping cost
);
```

---

### 12. `order_status`

Order progress states (e.g., pending, shipped, delivered).

```sql
CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50)
);
```

---

### 13. `cust_order`

Main order table containing metadata for each order.

```sql
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,                              -- Date when the order was placed
    shipping_id INT,                              -- Chosen shipping method
    total DECIMAL(10, 2),                         -- Total order cost
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_id) REFERENCES shipping_method(shipping_id)
);
```

---

### 14. `order_line`

Each book included in an order with quantity and price.

```sql
CREATE TABLE order_line (
    order_line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10, 2),                         -- Price per book at the time of order
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
```

---

### 15. `order_history`

Tracks status changes for each order over time.

```sql
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    status_id INT,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Automatically logs status change time
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
```

---

## ✅ Notes

- All `FOREIGN KEY` constraints ensure data integrity between related tables.
- Composite keys are used where many-to-many relationships exist (e.g., `book_author`, `customer_address`).
- Timestamps and auto-incrementing IDs provide trackable and scalable data modeling.
- All monetary fields use `DECIMAL(10,2)` to handle prices and totals accurately.

---


