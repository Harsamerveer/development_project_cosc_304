-- Bookstore DDL created by ChatGPT for user (December 2024)


CREATE DATABASE bookstore;
go

USE bookstore;
go



-- Create table for customers
CREATE TABLE customer (
    customerId          INT IDENTITY PRIMARY KEY,
    firstName           VARCHAR(40) NOT NULL,
    lastName            VARCHAR(40) NOT NULL,
    email               VARCHAR(50) UNIQUE NOT NULL,
    phonenum            VARCHAR(20),
    address             VARCHAR(100),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20) UNIQUE NOT NULL,
    password            VARCHAR(30) NOT NULL,
    isAdmin             BIT NOT NULL DEFAULT 0 -- 0 for customers, 1 for admins
);

-- Create table for payment methods
CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY PRIMARY KEY,
    paymentType         VARCHAR(20) NOT NULL,
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT NOT NULL,
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create table for order summaries
CREATE TABLE ordersummary (
    orderId             INT IDENTITY PRIMARY KEY,
    orderDate           DATETIME NOT NULL DEFAULT GETDATE(),
    totalAmount         DECIMAL(10,2) NOT NULL,
    shiptoAddress       VARCHAR(100),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT NOT NULL,
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create table for categories
CREATE TABLE category (
    categoryId          INT IDENTITY PRIMARY KEY,
    categoryName        VARCHAR(50) NOT NULL UNIQUE
);

-- Create table for products
CREATE TABLE product (
    productId           INT IDENTITY PRIMARY KEY,
    productName         VARCHAR(40) NOT NULL,
    productPrice        DECIMAL(10,2) NOT NULL,
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT NOT NULL,
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

-- Create table for products in orders
CREATE TABLE orderproduct (
    orderId             INT NOT NULL,
    productId           INT NOT NULL,
    quantity            INT NOT NULL,
    price               DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create table for items in the cart
CREATE TABLE incart (
    orderId             INT NOT NULL,
    productId           INT NOT NULL,
    quantity            INT NOT NULL,
    price               DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create table for warehouses
CREATE TABLE warehouse (
    warehouseId         INT IDENTITY PRIMARY KEY,
    warehouseName       VARCHAR(30) NOT NULL
);

-- Create table for shipments
CREATE TABLE shipment (
    shipmentId          INT IDENTITY PRIMARY KEY,
    shipmentDate        DATETIME NOT NULL DEFAULT GETDATE(),
    shipmentDesc        VARCHAR(100),
    warehouseId         INT NOT NULL,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create table for product inventory
CREATE TABLE productinventory (
    productId           INT NOT NULL,
    warehouseId         INT NOT NULL,
    quantity            INT NOT NULL,
    price               DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (productId, warehouseId),
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create table for reviews
CREATE TABLE review (
    reviewId            INT IDENTITY PRIMARY KEY,
    reviewRating        INT NOT NULL CHECK (reviewRating BETWEEN 1 AND 5),
    reviewDate          DATETIME NOT NULL DEFAULT GETDATE(),
    customerId          INT NOT NULL,
    productId           INT NOT NULL,
    reviewComment       VARCHAR(1000),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Insert sample data for customers (Admins and regular customers)
-- Admin users
INSERT INTO customer (firstName, lastName, email, phonenum, userid, password, isAdmin)
VALUES ('Admin1', 'Superuser', 'admin1@bookstore.com', '111-222-3333', 'admin1', 'Admin@123', 1);
INSERT INTO customer (firstName, lastName, email, phonenum, userid, password, isAdmin)
VALUES ('Admin2', 'Manager', 'admin2@bookstore.com', '444-555-6666', 'admin2', 'Admin@456', 1);
INSERT INTO customer (firstName, lastName, email, phonenum, userid, password, isAdmin)
VALUES ('Admin3', 'Support', 'admin3@bookstore.com', '777-888-9999', 'admin3', 'Admin@789', 1);

-- Regular customers
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, isAdmin)
VALUES ('Charles', 'Brown', 'charles.brown@example.com', '555-123-4567', '303 Literature Lane', 'San Francisco', 'CA', '94101', 'USA', 'charles', 'Charles@123', 0);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, isAdmin)
VALUES ('Diana', 'Prince', 'diana.prince@example.com', '666-789-1234', '404 Fiction Street', 'Los Angeles', 'CA', '90001', 'USA', 'diana', 'Diana@123', 0);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, isAdmin)
VALUES ('Edward', 'Norton', 'edward.norton@example.com', '777-456-7890', '505 Biography Blvd', 'Chicago', 'IL', '60601', 'USA', 'edward', 'Edward@123', 0);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, isAdmin)
VALUES ('Fiona', 'Green', 'fiona.green@example.com', '888-123-7894', '606 Mystery Court', 'Boston', 'MA', '02101', 'USA', 'fiona', 'Fiona@123', 0);
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password, isAdmin)
VALUES ('George', 'White', 'george.white@example.com', '999-456-1234', '707 Science Drive', 'Houston', 'TX', '77001', 'USA', 'george', 'George@123', 0);

-- Insert sample data for categories
INSERT INTO category (categoryName) VALUES ('Fiction');
INSERT INTO category (categoryName) VALUES ('Non-Fiction');
INSERT INTO category (categoryName) VALUES ('Children');
INSERT INTO category (categoryName) VALUES ('Science');
INSERT INTO category (categoryName) VALUES ('History');

-- Insert sample data for products
INSERT INTO product (productName, productPrice, productDesc, categoryId) VALUES ('The Great Gatsby', 15.00, 'Classic novel by F. Scott Fitzgerald', 1);
INSERT INTO product (productName, productPrice, productDesc, categoryId) VALUES ('A Brief History of Time', 25.00, 'Science book by Stephen Hawking', 4);
INSERT INTO product (productName, productPrice, productDesc, categoryId) VALUES ('Harry Potter and the Sorcerer\'s Stone', 20.00, 'Fantasy novel by J.K. Rowling', 3);

-- Insert sample data for warehouses
INSERT INTO warehouse (warehouseName) VALUES ('Main Warehouse');
INSERT INTO warehouse (warehouseName) VALUES ('Secondary Warehouse');

-- Insert sample data for product inventory
INSERT INTO productinventory (productId, warehouseId, quantity, price) VALUES (1, 1, 100, 15.00);
INSERT INTO productinventory (productId, warehouseId, quantity, price) VALUES (2, 1, 50, 25.00);
INSERT INTO productinventory (productId, warehouseId, quantity, price) VALUES (3, 2, 30, 20.00);

-- Insert sample data for orders
INSERT INTO ordersummary (customerId, orderDate, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry)
VALUES (1, '2024-12-01', 45.00, '303 Literature Lane', 'San Francisco', 'CA', '94101', 'USA');
INSERT INTO ordersummary (customerId, orderDate, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry)
VALUES (2, '2024-12-02', 60.00, '404 Fiction Street', 'Los Angeles', 'CA', '90001', 'USA');
INSERT INTO ordersummary (customerId, orderDate, totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry)
VALUES (3, '2024-12-03', 55.00, '505 Biography Blvd', 'Chicago', 'IL', '60601', 'USA');

-- Insert sample data for order products (Items in orders)
INSERT INTO orderproduct (orderId, productId, quantity, price)
VALUES (1, 1, 2, 15.00); -- 2 copies of The Great Gatsby
INSERT INTO orderproduct (orderId, productId, quantity, price)
VALUES (2, 2, 2, 25.00); -- 2 copies of A Brief History of Time
INSERT INTO orderproduct (orderId, productId, quantity, price)
VALUES (3, 3, 2, 20.00); -- 2 copies of Harry Potter and the Sorcerer's Stone

-- Insert sample data for items in the cart (for pending orders)
INSERT INTO incart (orderId, productId, quantity, price)
VALUES (1, 3, 1, 20.00); -- 1 copy of Harry Potter in cart
INSERT INTO incart (orderId, productId, quantity, price)
VALUES (2, 1, 1, 15.00); -- 1 copy of The Great Gatsby in cart

-- Insert sample data for shipments
INSERT INTO shipment (shipmentDate, shipmentDesc, warehouseId)
VALUES ('2024-12-02', 'Shipped from Main Warehouse', 1);
INSERT INTO shipment (shipmentDate, shipmentDesc, warehouseId)
VALUES ('2024-12-03', 'Shipped from Secondary Warehouse', 2);

-- Insert sample data for reviews
INSERT INTO review (reviewRating, customerId, productId, reviewComment)
VALUES (5, 1, 1, 'Amazing novel! A must-read.');
INSERT INTO review (reviewRating, customerId, productId, reviewComment)
VALUES (4, 2, 2, 'Great book, very informative.');
INSERT INTO review (reviewRating, customerId, productId, reviewComment)
VALUES (3, 3, 3, 'Good story, but a bit predictable.');

-- Insert sample data for payments
INSERT INTO paymentmethod (paymentType, paymentNumber, paymentExpiryDate, customerId)
VALUES ('Credit Card', '1234-5678-9876-5432', '2025-12-01', 1);
INSERT INTO paymentmethod (paymentType, paymentNumber, paymentExpiryDate, customerId)
VALUES ('Debit Card', '4321-8765-6789-1234', '2026-05-01', 2);
INSERT INTO paymentmethod (paymentType, paymentNumber, paymentExpiryDate, customerId)
VALUES ('PayPal', 'user@paypal.com', NULL, 3);

-- Insert sample data for product inventory
INSERT INTO productinventory (productId, warehouseId, quantity, price)
VALUES (1, 1, 100, 15.00); -- The Great Gatsby in Main Warehouse
INSERT INTO productinventory (productId, warehouseId, quantity, price)
VALUES (2, 1, 50, 25.00); -- A Brief History of Time in Main Warehouse
INSERT INTO productinventory (productId, warehouseId, quantity, price)
VALUES (3, 2, 30, 20.00); -- Harry Potter and the Sorcerer's Stone in Secondary Warehouse;

-- Insert sample data for product categories
INSERT INTO category (categoryName) VALUES ('Fiction');
INSERT INTO category (categoryName) VALUES ('Non-Fiction');
INSERT INTO category (categoryName) VALUES ('Children');
INSERT INTO category (categoryName) VALUES ('Science');
INSERT INTO category (categoryName) VALUES ('History');
