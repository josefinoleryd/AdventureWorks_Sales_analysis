SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';



SELECT
    t1.name AS parent_table,
    c1.name AS parent_column,
    t2.name AS referenced_table,
    c2.name AS referenced_column
FROM sys.foreign_key_columns fkc
JOIN sys.tables t1 ON fkc.parent_object_id = t1.object_id
JOIN sys.columns c1 ON fkc.parent_object_id = c1.object_id
                    AND fkc.parent_column_id = c1.column_id
JOIN sys.tables t2 ON fkc.referenced_object_id = t2.object_id
JOIN sys.columns c2 ON fkc.referenced_object_id = c2.object_id
                    AND fkc.referenced_column_id = c2.column_id
ORDER BY t1.name, c1.name;