SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- Drop existing tables if they exist

-- Create a new database
CREATE DATABASE Medicom;

-- Use the newly created database
USE Medicom;



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


CREATE TABLE User_MedPreferences (
  user_preferencesId INT AUTO_INCREMENT PRIMARY KEY,
  preferences JSON
);

CREATE TABLE User_MedRole (
  user_RoleId INT AUTO_INCREMENT PRIMARY KEY,
  user_role VARCHAR(255)
);

CREATE TABLE User_Med (
  user_MedId INT AUTO_INCREMENT PRIMARY KEY,
  user_Medname VARCHAR(255),
  email VARCHAR(255),
  password VARCHAR(255),
  fullName VARCHAR(255),
  address VARCHAR(255),
  user_RoleId INT,
  user_preferencesId INT,
  FOREIGN KEY (user_RoleId) REFERENCES User_MedRole(user_RoleId),
  FOREIGN KEY (user_preferencesId) REFERENCES User_MedPreferences(user_preferencesId)
);

CREATE TABLE DeliveryPromotion (
  DeliverypromotionId INT AUTO_INCREMENT PRIMARY KEY,
  productsupplierId INT,
  deliverybrokerId INT,
  discount DOUBLE,
  FOREIGN KEY (productsupplierId) REFERENCES ProductSupplier(supplierId),
  FOREIGN KEY (deliverybrokerId) REFERENCES DeliveryBroker(brokerId)
);

INSERT INTO User_MedRole (user_role) VALUES ('Administrator');
INSERT INTO User_MedRole (user_role) VALUES ('Manager');
INSERT INTO User_MedRole (user_role) VALUES ('Customer');
INSERT INTO User_MedRole (user_role) VALUES ('Guest');
INSERT INTO User_MedRole (user_role) VALUES ('Support Representative');
INSERT INTO User_MedRole (user_role) VALUES ('Content Moderator');
INSERT INTO User_MedRole (user_role) VALUES ('Marketing Manager');
INSERT INTO User_MedRole (user_role) VALUES ('Warehouse Manager');
INSERT INTO User_MedRole (user_role) VALUES ('Finance Manager');
INSERT INTO User_MedRole (user_role) VALUES ('System Administrator');

INSERT INTO PaymentMethod (methodName) VALUES ('Visa');
INSERT INTO PaymentMethod (methodName) VALUES ('Mastercard');
INSERT INTO PaymentMethod (methodName) VALUES ('American Express');
INSERT INTO PaymentMethod (methodName) VALUES ('Cash on Delivery');
INSERT INTO PaymentMethod (methodName) VALUES ('Bank Transfer');

INSERT INTO Category (categoryName, description) VALUES ('Diagnostic Equipment', 'Tools used for diagnosing medical conditions.');
INSERT INTO Category (categoryName, description) VALUES ('Surgical Instruments', 'Instruments used during surgical procedures.');
INSERT INTO Category (categoryName, description) VALUES ('Medical Imaging Devices', 'Devices for visualizing internal body structures.');
INSERT INTO Category (categoryName, description) VALUES ('Monitoring Devices', 'Devices for monitoring vital signs and health parameters.');
INSERT INTO Category (categoryName, description) VALUES ('Dental Equipment', 'Equipment used in dental clinics and practices.');
INSERT INTO Category (categoryName, description) VALUES ('Orthopedic Supplies', 'Supplies related to orthopedic procedures and treatments.');
INSERT INTO Category (categoryName, description) VALUES ('Mobility Aids', 'Aids to assist with mobility, such as wheelchairs and walkers.');
INSERT INTO Category (categoryName, description) VALUES ('Respiratory Equipment', 'Equipment for respiratory therapy and treatment.');
INSERT INTO Category (categoryName, description) VALUES ('Infusion and Injection Supplies', 'Supplies for administering medications via infusion or injection.');
INSERT INTO Category (categoryName, description) VALUES ('Wound Care Products', 'Products for treating and managing wounds and injuries.');
INSERT INTO Category (categoryName, description) VALUES ('Patient Care Supplies', 'Supplies for patient care and comfort, including bedding and toiletries.');
INSERT INTO Category (categoryName, description) VALUES ('Rehabilitation Equipment', 'Equipment used in physical and occupational therapy.');
INSERT INTO Category (categoryName, description) VALUES ('Laboratory Equipment', 'Equipment used in medical and scientific laboratories.');
INSERT INTO Category (categoryName, description) VALUES ('Medical Furniture', 'Furniture designed for use in medical facilities and clinics.');
INSERT INTO Category (categoryName, description) VALUES ('Emergency Medical Supplies', 'Supplies for emergency medical care and response.');
INSERT INTO Category (categoryName, description) VALUES ('Home Health Care Products', 'Products for home-based medical care and assistance.');
INSERT INTO Category (categoryName, description) VALUES ('Medical Apparel', 'Clothing and attire worn by medical professionals.');
INSERT INTO Category (categoryName, description) VALUES ('First Aid Kits and Supplies', 'Kits and supplies for basic first aid and emergency treatment.');
INSERT INTO Category (categoryName, description) VALUES ('Medical Consumables', 'Consumable supplies used in medical procedures and treatments.');
INSERT INTO Category (categoryName, description) VALUES ('Pharmaceutical Products', 'Medications and drugs used for medical treatment.');
INSERT INTO Category (categoryName, description) VALUES ('Veterinary Equipment', 'Equipment used in veterinary medicine and animal care.');
INSERT INTO Category (categoryName, description) VALUES ('Optometry Equipment', 'Equipment used in eye care and vision testing.');
INSERT INTO Category (categoryName, description) VALUES ('Physical Therapy Equipment', 'Equipment used in physical therapy and rehabilitation.');
INSERT INTO Category (categoryName, description) VALUES ('Hearing Aids and Accessories', 'Devices for hearing assistance and correction.');
INSERT INTO Category (categoryName, description) VALUES ('Blood Collection Supplies', 'Supplies for collecting blood samples and specimens.');
INSERT INTO Category (categoryName, description) VALUES ('Medical Training and Education Tools', 'Tools used in medical training and education programs.');
INSERT INTO Category (categoryName, description) VALUES ('Medical Software and Apps', 'Software applications for medical purposes.');
INSERT INTO Category (categoryName, description) VALUES ('Telemedicine Devices', 'Devices for remote medical consultations and telehealth services.');
INSERT INTO Category (categoryName, description) VALUES ('Assisted Living Devices', 'Devices to assist with activities of daily living for seniors and individuals with disabilities.');
INSERT INTO Category (categoryName, description) VALUES ('Biohazard and Infection Control Products', 'Products for handling biohazardous materials and infection control measures.');
INSERT INTO Category (categoryName, description) VALUES ('Clinical Laboratory Instruments', 'Instruments used in clinical laboratory testing and analysis.');
INSERT INTO Category (categoryName, description) VALUES ('Obstetrics and Gynecology Equipment', 'Equipment used in obstetrics and gynecology practices.');
INSERT INTO Category (categoryName, description) VALUES ('Ophthalmic Instruments', 'Instruments used in ophthalmology and eye care.');
INSERT INTO Category (categoryName, description) VALUES ('Podiatry Equipment', 'Equipment used in podiatry and foot care.');
INSERT INTO Category (categoryName, description) VALUES ('Radiology Equipment', 'Equipment used in radiology and medical imaging.');
INSERT INTO Category (categoryName, description) VALUES ('Medical Waste Management Products', 'Products for the safe disposal and management of medical waste.');
INSERT INTO Category (categoryName, description) VALUES ('Hospital Bedside Equipment', 'Equipment and accessories for patient care at the bedside.');
INSERT INTO Category (categoryName, description) VALUES ('Neurology Devices', 'Devices for diagnosing and treating neurological disorders.');
INSERT INTO Category (categoryName, description) VALUES ('Dermatology Instruments', 'Instruments used in dermatology and skin care.');
INSERT INTO Category (categoryName, description) VALUES ('Cardiology Equipment', 'Equipment used in cardiology and heart care.');

-- CREATE USER_Med 'dev_user_Med'@'%' IDENTIFIED BY 'dev_password';
-- GRANT ALL PRIVILEGES ON *.* TO 'dev_user_Med'@'%';
-- FLUSH PRIVILEGES;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
