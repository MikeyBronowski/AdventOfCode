DROP TABLE #input
CREATE TABLE #input (i VARCHAR(500));
BULK INSERT #input
    FROM '/var/opt/mssql/data/input.txt'
    WITH
    (
    FIRSTROW = 1,
    ROWTERMINATOR = '\n',   --Use to shift the control to next row + include blank line
    TABLOCK
    );



	WITH CTE_rules (r) AS (
        SELECT REPLACE(REPLACE(REPLACE(i,'bags',''),'bag',''),'.','') FROM #input
        WHERE i not like '%no other%'
	),
	CTE_split (rl,rr) AS (
        SELECT RTRIM(LEFT(r,CHARINDEX('contain',r)-1)),RIGHT(r,LEN(r)-CHARINDEX('contain',r)-6)
        FROM CTE_rules
	), CTE_split2 (rl,color) AS (
        SELECT rl,
        RIGHT(trim(value),LEN(trim(value))-CHARINDEX(' ',trim(value)))
        FROM CTE_split CROSS APPLY STRING_SPLIT(rr, ',')
	)
	select rl from CTE_split2 where color like '%shiny gold%'
	    UNION
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color like '%shiny gold%')
	    UNION
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color like '%shiny gold%'))
	    UNION
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color like '%shiny gold%')))
	    UNION
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color like '%shiny gold%'))))
		UNION
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color like '%shiny gold%')))))
		UNION
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color like '%shiny gold%'))))))
		UNION
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color like '%shiny gold%')))))))
		UNION
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color in (
	select rl from CTE_split2 where color like '%shiny gold%'))))))));