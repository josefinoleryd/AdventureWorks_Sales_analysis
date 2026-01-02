SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.Customer
SELECT * FROM Sales.Store
SELECT * FROM Person.BusinessEntityContact

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%PersonID%'


SELECT 
    CustomerID,
    MAX(OrderDate) AS LastOrderDate,
    CASE
        WHEN MAX(OrderDate) < DATEADD(MONTH, -12, '2025-06-01')
        THEN 'Churned'
        ELSE 'Active'
    END AS CustomerStatus
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY LastOrderDate ASC

SELECT
    ChurnYear,
    COUNT(*) AS NumberOfChurnedCustomers
FROM (
    SELECT
        CustomerID,
        YEAR(MAX(OrderDate)) AS ChurnYear
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
    HAVING MAX(OrderDate) < '2024-06-01'
) AS CustomerChurn
GROUP BY ChurnYear
ORDER BY ChurnYear

SELECT MAX(OrderDate) AS MaxOrderDate
FROM Sales.SalesOrderHeader

-- Per månad
SELECT
    DATEFROMPARTS(YEAR(LastOrderDate), MONTH(LastOrderDate), 1) AS ChurnMonth,
    COUNT(*) AS NumberOfChurnedCustomers
FROM (
    SELECT
        CustomerID,
        MAX(OrderDate) AS LastOrderDate
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
    HAVING MAX(OrderDate) < '2024-06-01'
) AS ChurnedCustomers
GROUP BY DATEFROMPARTS(YEAR(LastOrderDate), MONTH(LastOrderDate), 1)
ORDER BY ChurnMonth



SELECT
    DATEFROMPARTS(YEAR(LastOrderDate), MONTH(LastOrderDate), 1) AS ChurnMonth,
    COUNT(*) AS NumberOfChurnedCustomers
FROM (
    SELECT
        CustomerID,
        MAX(OrderDate) AS LastOrderDate
    FROM Sales.SalesOrderHeader
    GROUP BY CustomerID
    HAVING MAX(OrderDate) < '2024-06-01'
) AS ChurnedCustomers
GROUP BY DATEFROMPARTS(YEAR(LastOrderDate), MONTH(LastOrderDate), 1)
ORDER BY ChurnMonth