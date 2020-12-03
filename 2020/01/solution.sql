use Mikey;

CREATE TABLE AoC01 (i VARCHAR(100));
BULK INSERT AoC01
    FROM 'C:\Temp\input.txt'
    WITH
    (
    FIRSTROW = 1,
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
    );

SELECT DISTINCT '1' AS Part, r1.value*r2.value [multiplication]
FROM AoC01 r1,AoC01 r2
WHERE r1.value+r2.value = 2020
UNION ALL
SELECT DISTINCT '2', r1.value*r2.value*r3.value
FROM AoC01 r1,AoC01 r2,AoC01 r3
WHERE r1.value+r2.value+r3.value = 2020;
