SELECT * FROM Sales.SalesOrderHeader

-- Kolla om SubTotal ger samma resultat som LineTotal
SELECT
    SUM(soh.SubTotal) AS TotalRevenue
FROM Sales.SalesOrderHeader AS soh

-- Mellan vilka datum sträcker sig datan? 
SELECT
    MIN(soh.OrderDate) AS från,
    MAX(soh.OrderDate) AS till
FROM Sales.SalesOrderHeader AS soh

--2022
SELECT
    MONTH(soh.OrderDate) AS OrderMonth,
    SUM(soh.SubTotal) AS TotalRevenue    
FROM Sales.SalesOrderHeader AS soh
WHERE soh.OrderDate >= '2022-01-01'
    AND soh.OrderDate < '2023-01-01'
GROUP BY 
    MONTH(soh.OrderDate)
ORDER BY 
    OrderMonth

--2023
SELECT
    MONTH(soh.OrderDate) AS OrderMonth,
    SUM(soh.SubTotal) AS TotalRevenue    
FROM Sales.SalesOrderHeader AS soh
WHERE soh.OrderDate >= '2023-01-01'
    AND soh.OrderDate < '2024-01-01'
GROUP BY 
    MONTH(soh.OrderDate)
ORDER BY 
    OrderMonth

--2024
SELECT
    MONTH(soh.OrderDate) AS OrderMonth,
    SUM(soh.SubTotal) AS TotalRevenue    
FROM Sales.SalesOrderHeader AS soh
WHERE soh.OrderDate >= '2024-01-01'
    AND soh.OrderDate < '2025-01-01'
GROUP BY 
    MONTH(soh.OrderDate)
ORDER BY 
    OrderMonth

--2025
SELECT
    MONTH(soh.OrderDate) AS OrderMonth,
    SUM(soh.SubTotal) AS TotalRevenue    
FROM Sales.SalesOrderHeader AS soh
WHERE soh.OrderDate >= '2025-01-01'
    AND soh.OrderDate < '2026-01-01'
GROUP BY 
    MONTH(soh.OrderDate)
ORDER BY 
    OrderMonth

-- Visa alla ordrar från juni 2025
-- Sortera på DESC för att se om det har lagts ordrar även i slutet av månaden
SELECT * FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2025-06-01' AND OrderDate < '2025-07-01'
ORDER BY OrderDate DESC

-- Räkna antalet ordrar från juni 2025
SELECT
    COUNT(*) AS AntalOrdrar
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2025-06-01' AND OrderDate < '2025-07-01'

-- Totalt antal ordrar 
SELECT
    COUNT(*) AS AntalOrdrar
FROM Sales.SalesOrderHeader

-- Antal ordrar per månad
SELECT
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth


