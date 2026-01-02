SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.Customer
SELECT * FROM Sales.Store

SELECT TOP 10
    s.Name AS CompanyName,
    c.CustomerID,
    SUM(soh.SubTotal) AS TotalRevenue,
    MAX(soh.OrderDate) AS LastOrderDate
FROM Sales.Store s
INNER JOIN Sales.Customer c ON c.StoreID = s.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
GROUP BY s.Name, c.CustomerID
HAVING MAX(soh.OrderDate) > '2024-06-01'
ORDER BY TotalRevenue DESC

-- Dubbelkolla resultatet
SELECT
    SalesOrderID,
    OrderDate,
    SubTotal,
    TotalDue
FROM Sales.SalesOrderHeader
WHERE CustomerID = 29818
ORDER BY OrderDate

-- Dubbelkolla att ingen privatperson har handlat för mer (extremt EXTREMT osannolikt)
SELECT TOP 1
    CONCAT(p.FirstName, ' ', p.LastName) AS CustomerName,
    c.CustomerID,
    SUM(soh.SubTotal) AS TotalRevenue,
    COUNT(DISTINCT soh.SalesOrderID) AS OrderCount,
    MAX(soh.OrderDate) AS LastOrderDate
FROM Sales.Customer c
INNER JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
WHERE c.StoreID IS NULL
GROUP BY 
    p.FirstName,
    p.LastName,
    c.CustomerID
HAVING MAX(soh.OrderDate) > '2024-06-01'
ORDER BY TotalRevenue DESC