CREATE TABLE #input (i VARCHAR(100));

BULK INSERT #input
    FROM 'C:\Temp\AdventOfCode\2020\05\input.txt'
    WITH
    (
    FIRSTROW = 1,
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    );

WITH CTE_binary (bin) AS (
SELECT REPLACE(REPLACE(REPLACE(REPLACE(i,'F',0),'B',1),'L',0),'R',1)
FROM #input
),
CTE_decimal (a,b,c,d,e,f,g,h,i,j) AS (
select 
CAST(SUBSTRING (bin,1,1) AS BIT) * 64,
CAST(SUBSTRING (bin,2,1) AS BIT) * 32,
CAST(SUBSTRING (bin,3,1) AS BIT) * 16,
CAST(SUBSTRING (bin,4,1) AS BIT) * 8,
CAST(SUBSTRING (bin,5,1) AS BIT) * 4,
CAST(SUBSTRING (bin,6,1) AS BIT) * 2,
CAST(SUBSTRING (bin,7,1) AS BIT) * 1,
CAST(SUBSTRING (bin,8,1) AS BIT) * 4,
CAST(SUBSTRING (bin,9,1) AS BIT) * 2,
CAST(SUBSTRING (bin,10,1) AS BIT) * 1
from CTE_binary
)
, CTE_seats (row,col) AS (
select 
a+b+c+d+e+f+g,
h+i+j
FROM CTE_decimal
),
CTE_MissingSeat(seat,nextSeat,diff) AS (
SELECT
row*8+col,
LEAD(row*8+col,1,0) OVER (ORDER BY row*8+col DESC),
row*8+col-LEAD(row*8+col,1,0) OVER (ORDER BY row*8+col DESC)
FROM CTE_seats
)

SELECT TOP 1 '1' AS Part, row*8+col AS Result FROM CTE_seats
UNION ALL
SELECT '2', (seat+nextSeat)/2
FROM CTE_MissingSeat
WHERE diff = 2;