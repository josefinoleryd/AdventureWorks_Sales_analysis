SELECT * FROM Sales.SalesOrderHeader

-- Totalt antal ordrar och total försäljning per år (2023 och 2024, pga hela år)
SELECT
    YEAR(soh.OrderDate) AS OrderYear,
    COUNT(*) AS OrderCount,
    SUM(soh.SubTotal) AS TotalRevenue
FROM Sales.SalesOrderHeader AS soh
WHERE OrderDate >= '2023-01-01' AND OrderDate < '2025-01-01'
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear