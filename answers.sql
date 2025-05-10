Question 1
-- Create normalized table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert normalized data
-- (for SQL Server)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT 
    OrderID,
    CustomerName,
    TRIM(value) AS Product
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');


Question 2
-- Step 1: Create CustomerInfo table
CREATE TABLE CustomerInfo (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO CustomerInfo (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Step 2: Create OrderProducts table (now fully dependent on OrderID + Product)
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES CustomerInfo(OrderID)
);

INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
