--Lista över alla tabeller i databasen + antal rader (AI-genererad kod)
SELECT
    t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables t
JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY t.name
ORDER BY row_count DESC;


--Visa alla kolumner för en tabell (AI-genererad kod)
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SalesTerritory'
ORDER BY ORDINAL_POSITION;


--Lista över alla tabeller i databasen med antalet kolumner och rader per tabell (AI-genererad kod)
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

--Antal foreign keys per tabell (AI-genererad kod)
SELECT
    t.name AS table_name,
    COUNT(fk.parent_object_id) AS foreign_keys
FROM sys.tables t
LEFT JOIN sys.foreign_keys fk
    ON t.object_id = fk.parent_object_id
GROUP BY t.name
ORDER BY foreign_keys DESC;


--Top 15 största tabellerna: (AI-genererad kod)
SELECT TOP 15
    s.name + '.' + t.name AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.partitions p ON t.object_id = p.object_id
WHERE p.index_id IN (0,1)
GROUP BY s.name, t.name
ORDER BY row_count DESC;

--Top 15 tabeller med flest foreign keys: (AI-genererad kod)
SELECT TOP 15
    s.name + '.' + t.name AS table_name,
    COUNT(fk.object_id) AS fk_count
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
LEFT JOIN sys.foreign_keys fk ON fk.parent_object_id = t.object_id
GROUP BY s.name, t.name
ORDER BY fk_count DESC;