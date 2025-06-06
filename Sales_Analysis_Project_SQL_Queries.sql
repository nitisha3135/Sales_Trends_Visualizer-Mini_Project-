CREATE TABLE Products(
    ProductID INT PRIMARY KEY,
	ProductName VARCHAR(50),
	Category VARCHAR(50),
	Price DECIMAL
);

CREATE TABLE Salespersons (
    SalespersonID INT PRIMARY KEY,
    SalespersonName VARCHAR(50),
    Region VARCHAR(50)
);

CREATE TABLE Sales(
    SaleID INT PRIMARY KEY,
	ProductID INT,
	QuantitySold INT,
	SaleDate DATE,
	SalespersonID INT,
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SalespersonID) REFERENCES Salespersons(SalespersonID)
);


COPY Products FROM 'D:\Sales Analysis Project\products.csv' DELIMITER ',' CSV HEADER;


COPY Salespersons FROM 'D:\Sales Analysis Project\salespersons.csv' DELIMITER ',' CSV HEADER;


COPY Sales FROM 'D:\Sales Analysis Project\sales.csv' DELIMITER ',' CSV HEADER;


SELECT * FROM Products;


SELECT * FROM Salespersons;


SELECT * FROM Sales;

-- Total sales per product
SELECT P.ProductName, SUM(S.QuantitySold * P.Price) AS TotalSales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.ProductName;

-- Total sales by region
SELECT SP.Region, SUM(S.QuantitySold * P.Price) AS RegionSales
FROM Sales S
JOIN Salespersons SP ON S.SalespersonID = SP.SalespersonID
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY SP.Region;

-- Average sales per salesperson
SELECT SP.SalespersonName, AVG(S.QuantitySold * P.Price) AS AvgSales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
JOIN Salespersons SP ON S.SalespersonID = SP.SalespersonID
GROUP BY SP.SalespersonName;

-- Top 5 products by total revenue
SELECT P.ProductName, SUM(S.QuantitySold * P.Price) AS Revenue
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY Revenue DESC
LIMIT 5;

-- Sales by product category
SELECT P.Category, SUM(S.QuantitySold * P.Price) AS CategorySales
FROM Sales S
JOIN Products P ON S.ProductID = P.ProductID
GROUP BY P.Category
ORDER BY CategorySales DESC;


