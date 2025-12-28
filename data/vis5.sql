SELECT * FROM Production.Product
SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory

-- Bara med produktnamn
SELECT
    TOP 10
    p.Name AS ProduktNamn,
    SUM(sod.LineTotal) AS TotalFörsäljning
FROM Production.Product AS p
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.Name
ORDER BY TotalFörsäljning DESC

-- Produktnamn med tillhörande kategori och underkategori
SELECT TOP 10
    p.Name AS ProduktNamn,
    pc.Name AS Kategori,
    psc.Name AS Underkategori, 
    SUM(sod.LineTotal) AS TotalFörsäljning
FROM Production.Product AS p
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
LEFT JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY p.Name, pc.Name, psc.Name 
ORDER BY TotalFörsäljning DESC

