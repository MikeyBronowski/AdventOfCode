CREATE TABLE #input (i VARCHAR(100));
CREATE TABLE #input_sorted (id INT IDENTITY(1,1),i VARCHAR(100));

BULK INSERT #input
    FROM 'C:\Temp\AdventOfCode\2020\03\input.txt'
    WITH
    (
    FIRSTROW = 1,
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    );

-- add the id column to keep the order
INSERT INTO #input_sorted
SELECT * FROM #input


WITH CTE_place (isTree,p1,p3,p5,p7,p12)
AS (
SELECT REPLACE(REPLACE(i,'#' ,1),'.',0) AS isTree,
	CASE WHEN ((id-1)*1+1) % LEN(i) = 0 THEN LEN(i) ELSE ((id-1)*1+1) % LEN(i)	END AS p1,
	CASE WHEN ((id-1)*3+1) % LEN(i) = 0 THEN LEN(i) ELSE ((id-1)*3+1) % LEN(i)	END AS p3,
	CASE WHEN ((id-1)*5+1) % LEN(i) = 0 THEN LEN(i) ELSE ((id-1)*5+1) % LEN(i)	END AS p5,
	CASE WHEN ((id-1)*7+1) % LEN(i) = 0 THEN LEN(i) ELSE ((id-1)*7+1) % LEN(i)	END AS p12,
	CASE WHEN (CASE WHEN id % 2 = 0 THEN -1 ELSE id-id/2 END ) % LEN(i) = 0 THEN LEN(i) ELSE
	(CASE WHEN id % 2 = 0 THEN -1 ELSE id-id/2 END ) % LEN(i) END s12
FROM #input_sorted
),

CTE_results (p1,p3,p5,p7,p12)
AS (
SELECT SUM(CAST(SUBSTRING(isTree,p1,1) AS BIGINT)) ,
SUM(CAST(SUBSTRING(isTree,p3,1) AS BIGINT)) ,
SUM(CAST(SUBSTRING(isTree,p5,1) AS BIGINT)) ,
SUM(CAST(SUBSTRING(isTree,p7,1) AS BIGINT)) ,
SUM(CAST(SUBSTRING(isTree,p12,1) AS BIGINT))
FROM CTE_place
)
SELECT DISTINCT '1' AS Part, p3 AS Solution FROM CTE_results
UNION ALL
SELECT  DISTINCT '2',p1*p3*p5*p7*p12 FROM CTE_results;