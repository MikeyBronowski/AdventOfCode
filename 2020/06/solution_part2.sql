DROP TABLE #input;
DROP TABLE #input_sorted;
CREATE TABLE #input (i VARCHAR(500));
CREATE TABLE #input_sorted (id INT IDENTITY(1,1),i VARCHAR(100));
BULK INSERT #input
    FROM 'C:\Temp\input.txt'
	WITH
    (
    FIRSTROW = 1,
    ROWTERMINATOR = '\n',   --Use to shift the control to next row + include blank line
    TABLOCK
    );
INSERT INTO #input_sorted
SELECT * FROM #input

select * from #input_sorted

WITH CTE_AZ (id,i,az) AS (
select id,i,LOWER('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
from #input_sorted 
),
CTE_AZExists (id,input, A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z) AS (
SELECT 
id,i,
CASE WHEN i LIKE '%'+SUBSTRING(az,1,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,2,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,3,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,4,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,5,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,6,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,7,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,8,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,9,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,10,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,11,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,12,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,13,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,14,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,15,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,16,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,17,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,18,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,19,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,20,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,21,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,22,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,23,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,24,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,25,1)+'%' THEN 1 ELSE 0 END,
CASE WHEN i LIKE '%'+SUBSTRING(az,26,1)+'%' THEN 1 ELSE 0 END
FROM CTE_AZ),
CTE_Groups (A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z, groupNo) AS (
SELECT A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,SUM([group]) OVER(ORDER BY id ROWS UNBOUNDED PRECEDING) AS [groupNo] 
FROM (
SELECT *,CASE    WHEN LAG(input) OVER(ORDER BY id asc) IS NULL 
                THEN 1 
                ELSE 0 
        END AS [group] 
FROM CTE_AZExists
) a WHERE input IS NOT NULL
),
CTE_LastOneIPromise (QCount) AS (
SELECT 
CASE WHEN SUM(A) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(B) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(C) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(D) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(E) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(F) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(G) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(H) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(I) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(J) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(K) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(L) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(M) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(N) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(O) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(P) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(Q) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(R) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(S) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(T) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(U) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(V) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(W) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(X) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(Y) = COUNT(*) THEN 1 ELSE 0 END+
CASE WHEN SUM(Z) = COUNT(*) THEN 1 ELSE 0 END
FROM CTE_Groups
GROUP By groupNo 
)

SELECT '2', SUM(QCount) FROM CTE_LastOneIPromise
