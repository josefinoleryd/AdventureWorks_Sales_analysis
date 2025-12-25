SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.Product
SELECT * FROM Sales.SalesOrderDetail

-- Kod att använda i rapporten:
SELECT
    pc.Name AS CategoryName,
    SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail AS sod
INNER JOIN Production.Product AS p ON sod.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name
ORDER BY TotalRevenue ASC

SELECT
    SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail AS sod

-- Testa att det ovan stämmer:
SELECT SUM(sod.LineTotal) AS BikeRevenue
FROM Sales.SalesOrderDetail AS sod
INNER JOIN Production.Product AS p ON sod.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory AS ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Bikes'


-- Men vilken valuta är det som gäller? 
-- Står inte i SalesOrderDetail
-- Utan finns "högre upp" -> SalesOrderHeader
SELECT * FROM Sales.SalesOrderHeader

-- Hittade kolum CurrencyRateID
-- Många NULL, men hur många?
SELECT
    COUNT(*) AS Totalt,
    SUM(CASE WHEN CurrencyRateID IS NULL THEN 1 ELSE 0 END) AS AntalNULL,
    ROUND(
        100.0 * SUM(CASE WHEN CurrencyRateID IS NULL THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS AndelNULLProcent
FROM Sales.SalesOrderHeader
-- NULL = ingen valutaväxling har skett

-- Vilka tabller finns det som heter något med Currency?
SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME LIKE '%Currency%'

SELECT * FROM Sales.CurrencyRate

-- Vad händer på de rader där CurrencyRateID inte är NULL?
SELECT
    cr.FromCurrencyCode,
    cr.ToCurrencyCode,
    COUNT (*) AS AntalOrdrar
FROM Sales.SalesOrderHeader soh
JOIN Sales.CurrencyRate cr ON soh.CurrencyRateID = cr.CurrencyRateID
GROUP BY cr.FromCurrencyCode, cr.ToCurrencyCode
ORDER BY AntalOrdrar DESC
-- Valutan går från USD till kundens valuta, alltså är intäkterna i SalesOrderDetail USD



