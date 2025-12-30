SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.Customer
SELECT * FROM Sales.Store

-- I Sales.Store finns namnet på företagskunderna (?)

-- I Sales.Customer finns PersonID och StoreID
-- kan en customer både ha ett värde på PersonID och StoreID? 
SELECT 
    CASE
        WHEN PersonID IS NOT NULL AND StoreID IS NOT NULL THEN 'Båda'
        WHEN PersonID IS NOT NULL AND StoreID IS NULL THEN 'Endast PersonID'
        WHEN StoreID IS NOT NULL AND PersonID IS NULL THEN 'Endast StoreID'
        ELSE 'NULL på båda'
    END AS PersonOrStore,
    COUNT(*) AS AntalKunder
FROM Sales.Customer
GROUP BY
    CASE
        WHEN PersonID IS NOT NULL AND StoreID IS NOT NULL THEN 'Båda'
        WHEN PersonID IS NOT NULL AND StoreID IS NULL THEN 'Endast PersonID'
        WHEN StoreID IS NOT NULL AND PersonID IS NULL THEN 'Endast StoreID'
        ELSE 'NULL på båda'
    END

-- StoreID = företagskund (alltså en butik som handlar av AdventureWorks)
-- PersonID = privatperson?

-- båda -> räknas som företag eftersom det finns ett värde på StoreID?

SELECT
    st.Name AS Region,
    CASE 
        When c.StoreID IS NOT NULL THEN 'Företagskund'
        ELSE 'PrivatPerson'
    END AS Kundtyp,
    SUM(soh.SubTotal) AS TotalFörsäljning,
    COUNT(DISTINCT soh.SalesOrderID) AS AntalOrdrar,
    SUM(soh.SubTotal) / COUNT(DISTINCT soh.SalesOrderID) AS AOV
FROM Sales.SalesTerritory AS st
INNER JOIN Sales.Customer c ON st.TerritoryID = c.TerritoryID
INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY 
    st.Name,
    CASE WHEN c.StoreID IS NOT NULL THEN 'Företagskund' ELSE 'PrivatPerson' END
ORDER BY Region, Kundtyp

SELECT
    st.Name AS Region,
    CASE 
        When c.StoreID IS NOT NULL THEN 'Företagskund'
        ELSE 'PrivatPerson'
    END AS Kundtyp,
    SUM(soh.SubTotal) AS TotalFörsäljning,
    COUNT(DISTINCT soh.SalesOrderID) AS AntalOrdrar,
    SUM(soh.SubTotal) / COUNT(DISTINCT soh.SalesOrderID) AS AOV
FROM Sales.SalesTerritory AS st
INNER JOIN Sales.Customer c ON st.TerritoryID = c.TerritoryID
INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY 
    st.Name,
    CASE WHEN c.StoreID IS NOT NULL THEN 'Företagskund' ELSE 'PrivatPerson' END
ORDER BY
    SUM(SUM(soh.SubTotal)) OVER(PARTITION BY st.Name) / 
    SUM(COUNT(DISTINCT soh.SalesOrderID)) OVER(PARTITION BY st.Name) DESC,
    st.Name,
    Kundtyp