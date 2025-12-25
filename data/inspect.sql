--Lista över alla tabeller i databasen + antal rader
SELECT
    t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables t
JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY t.name
ORDER BY row_count DESC;


--Visa alla kolumner för en tabell 
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SalesTerritory'
ORDER BY ORDINAL_POSITION;


--Lista över alla tabeller i databasen med antalet kolumner och rader per tabell 
SELECT
    t.name AS table_name,
    COUNT(c.column_id) AS column_count,
    SUM(p.rows) AS row_count
FROM sys.tables t
JOIN sys.columns c ON t.object_id = c.object_id
JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY t.name
ORDER BY row_count DESC;

--Antal foreign keys per tabell
SELECT
    t.name AS table_name,
    COUNT(fk.parent_object_id) AS foreign_keys
FROM sys.tables t
LEFT JOIN sys.foreign_keys fk
    ON t.object_id = fk.parent_object_id
GROUP BY t.name
ORDER BY foreign_keys DESC;


--Top 15 största tabellerna:
SELECT TOP 15
    s.name + '.' + t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY s.name, t.name
ORDER BY row_count DESC;

--Top 15 tabeller med flest foreign keys:
SELECT TOP 15
    s.name + '.' + t.name AS table_name,
    COUNT(fk.object_id) AS fk_count
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
LEFT JOIN sys.foreign_keys fk ON fk.parent_object_id = t.object_id
GROUP BY s.name, t.name
ORDER BY fk_count DESC;


-- Visa alla fk för en tabell (med kolumnmappning)
SELECT
    fk.name AS foreign_key_name,
    col.name AS column_name,
    ref_tab.name AS referenced_table,
    ref_col.name AS referenced_column
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc 
    ON fk.object_id = fkc.constraint_object_id
JOIN sys.tables tab 
    ON fkc.parent_object_id = tab.object_id
JOIN sys.columns col 
    ON col.object_id = tab.object_id 
   AND col.column_id = fkc.parent_column_id
JOIN sys.tables ref_tab 
    ON ref_tab.object_id = fkc.referenced_object_id
JOIN sys.columns ref_col 
    ON ref_col.object_id = ref_tab.object_id 
   AND ref_col.column_id = fkc.referenced_column_id
WHERE tab.name = 'ProductSubcategory';


-- Visa alla fk för en tabell (utan kolumnmappning)
SELECT
    fk.name,
    OBJECT_NAME(fk.parent_object_id) AS table_name
FROM sys.foreign_keys fk
WHERE OBJECT_NAME(fk.parent_object_id) = 'ProductSubcategory';