SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';



-- Drop existing database if it exists
DROP DATABASE IF EXISTS Medicom;

-- Create a new database
CREATE DATABASE Medicom;

-- Use the newly created database
USE Medicom;

-- Drop existing tables if they exist

DROP TABLE IF EXISTS InvoiceItem;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Order_Med;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS PaymentMethod;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS CategoryBelonging;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS DeliveryBroker;
DROP TABLE IF EXISTS DeliveryStatus;
DROP TABLE IF EXISTS ProductSupplier;
DROP TABLE IF EXISTS SupplyInfo;
DROP TABLE IF EXISTS User_MedProfile;
DROP TABLE IF EXISTS User_MedPreferences;
DROP TABLE IF EXISTS User_MedRole;
DROP TABLE IF EXISTS User_Med;
DROP TABLE IF EXISTS Promotion;

-- Create tables
-- Create tables
CREATE TABLE InvoiceItem (
  quantity INT,
  unitPrice DOUBLE,
  subtotal DOUBLE,
  PRIMARY KEY (quantity, unitPrice, subtotal)
);

CREATE TABLE Invoice (
  invoiceId INT AUTO_INCREMENT PRIMARY KEY,
  order_MedId INT,
  totalAmount DOUBLE,
  issueDate DATETIME,
  FOREIGN KEY (order_MedId) REFERENCES Order_Med(order_MedId)
);

CREATE TABLE Order_Med (
  order_MedId INT AUTO_INCREMENT PRIMARY KEY,
  cartId INT,
  paymentMethod VARCHAR(255),
  order_Medstatus VARCHAR(255),
  timestamp DATETIME
);

CREATE TABLE Payment (
  paymentId INT AUTO_INCREMENT PRIMARY KEY,
  order_MedId INT,
  paymentMethod VARCHAR(255),
  amount DOUBLE,
  paymentstatus VARCHAR(255),
  timestamp DATETIME,
  FOREIGN KEY (order_MedId) REFERENCES Order_Med(order_MedId)
);

CREATE TABLE PaymentMethod (
  methodId INT AUTO_INCREMENT PRIMARY KEY,
  methodName VARCHAR(255)
);

CREATE TABLE Product (
  productId INT AUTO_INCREMENT PRIMARY KEY,
  productName VARCHAR(255),
  description TEXT,
  price DOUBLE,
  availability INT
);

CREATE TABLE Category (
  categoryId INT AUTO_INCREMENT PRIMARY KEY,
  categoryName VARCHAR(255),
  description TEXT
);

CREATE TABLE CategoryBelonging (
  productId INT ,
  categoryId INT,
  PRIMARY KEY (productId,categoryId),
  FOREIGN KEY (productId) REFERENCES Product(productId),
  FOREIGN KEY (categoryId) REFERENCES Category(categoryId)
);


CREATE TABLE Review (
  reviewId INT AUTO_INCREMENT PRIMARY KEY,
  user_MedId INT,
  productId INT,
  rating INT,
  comment TEXT,
  timestamp DATETIME,
  FOREIGN KEY (user_MedId) REFERENCES User_Med(user_MedId),
  FOREIGN KEY (productId) REFERENCES Product(productId)
);

CREATE TABLE DeliveryBroker (
  brokerId INT AUTO_INCREMENT PRIMARY KEY,
  brokerName VARCHAR(255)
);

CREATE TABLE DeliveryStatus (
  statusId INT AUTO_INCREMENT PRIMARY KEY,
  status VARCHAR(255),
  timestamp DATETIME
);

CREATE TABLE ProductSupplier (
  supplierId INT AUTO_INCREMENT PRIMARY KEY,
  supplierName VARCHAR(255)
);

CREATE TABLE SupplyInfo (
  supplierId INT,
  productId INT,
  PRIMARY KEY (supplierId,productId),
  FOREIGN KEY (supplierId) REFERENCES ProductSupplier(supplierId),
  FOREIGN KEY (productId) REFERENCES Product(productId)
);


CREATE TABLE User_MedProfile (
  user_MedId INT AUTO_INCREMENT PRIMARY KEY,
  fullName VARCHAR(255),
  address VARCHAR(255)
);

CREATE TABLE User_MedPreferences (
  user_MedId INT AUTO_INCREMENT PRIMARY KEY,
  preferences JSON
);

CREATE TABLE User_MedRole (
  user_MedId INT AUTO_INCREMENT PRIMARY KEY,
  role VARCHAR(255)
);

CREATE TABLE User_Med (
  user_MedId INT AUTO_INCREMENT PRIMARY KEY,
  user_Medname VARCHAR(255),
  email VARCHAR(255),
  password VARCHAR(255)
);

CREATE TABLE Promotion (
  promotionId INT AUTO_INCREMENT PRIMARY KEY,
  productsupplierId INT,
  deliverybrokerId INT,
  discount DOUBLE,
  FOREIGN KEY (productsupplierId) REFERENCES ProductSupplier(supplierId),
  FOREIGN KEY (deliverybrokerId) REFERENCES DeliveryBroker(brokerId)
);

-- CREATE USER_Med 'dev_user_Med'@'%' IDENTIFIED BY 'dev_password';
-- GRANT ALL PRIVILEGES ON *.* TO 'dev_user_Med'@'%';
-- FLUSH PRIVILEGES;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
