DROP TABLE #input;
CREATE TABLE #input (i VARCHAR(500));
BULK INSERT #input
    FROM 'C:\Temp\input.txt'
    WITH
    (
    FIRSTROW = 1,
    ROWTERMINATOR = '\n\n',   --Use to shift the control to next row + include blank line
    TABLOCK
    );


	WITH CTE_valid (i) AS (
		SELECT LOWER(i + ' ' )
		FROM #input
		WHERE i LIKE '%byr:%'
		AND i LIKE '%iyr:%'
		AND i LIKE '%eyr:%'
		AND i LIKE '%hgt:%'
		AND i LIKE '%hcl:%'
		AND i LIKE '%ecl:%'
		AND i LIKE '%pid:%'
	),
	CTE_split (i,byr,iyr,eyr,hgt,hcl,ecl,pid) AS (
		SELECT i,
		SUBSTRING(i,CHARINDEX('byr:',i)+4,5) byr, --fixed 4
		SUBSTRING(i,CHARINDEX('iyr:',i)+4,5) iyr, --fixed 4
		SUBSTRING(i,CHARINDEX('eyr:',i)+4,5) eyr, --fixed 4
		CASE
			WHEN SUBSTRING(i,CHARINDEX('hgt:',i)+4,6) LIKE '%cm%' THEN SUBSTRING(i,CHARINDEX('hgt:',i)+4,6)
			WHEN SUBSTRING(i,CHARINDEX('hgt:',i)+4,6) LIKE '%in%' THEN SUBSTRING(i,CHARINDEX('hgt:',i)+4,5)
			ELSE ''
		END hgt,
		SUBSTRING(i,CHARINDEX('hcl:',i)+4,8) hcl, --fixed 7
		SUBSTRING(i,CHARINDEX('ecl:',i)+4,4) ecl, --fixed 3
		SUBSTRING(i,CHARINDEX('pid:',i)+4,10) pid  --fixed 9
		FROM CTE_valid
	),
	CTE_clean (i,byr,iyr,eyr,hgt,hcl,ecl,pid) AS (
		SELECT i,
		CAST(LEFT(byr,4) AS INT),
		CAST(LEFT(iyr,4) AS INT),
		CAST(LEFT(eyr,4) AS INT),
		CASE
			WHEN hgt LIKE '%cm%' THEN LEFT(hgt,5)
			WHEN hgt LIKE '%in%' THEN LEFT(hgt,4)
			ELSE ''
		END hgt,
		LEFT(hcl,7),
		LEFT(ecl,3),
		LEFT(pid,9)
		FROM CTE_split
		WHERE
		RIGHT(byr,1) NOT LIKE '[0-9A-z!@#$.,;_]%'
		AND RIGHT(iyr,1) NOT LIKE '[0-9A-z!@#$.,;_]%'
		AND RIGHT(eyr,1) NOT LIKE '[0-9A-z!@#$.,;_]%'
		AND RIGHT(hgt,1) NOT LIKE '[0-9A-z!@#$.,;_]%'
		AND RIGHT(hcl,1) NOT LIKE '[0-9A-z!@#$.,;_]%'
		AND RIGHT(ecl,1) NOT LIKE '[0-9A-z!@#$.,;_]%'
		AND RIGHT(pid,1) NOT LIKE '[0-9A-z!@#$.,;_]%'
	)

	SELECT '1' AS Part, COUNT(*) AS Result FROM CTE_valid
	UNION all
	SELECT '2', COUNT(*) FROM CTE_clean
	WHERE
	byr BETWEEN 1920 AND 2002
	AND iyr BETWEEN 2010 AND 2020
	AND eyr BETWEEN 2020 AND 2030
	AND hcl LIKE '#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
	AND (RIGHT(hgt,2) = 'cm' AND CAST(LEFT(hgt,3) AS INT) BETWEEN 150 AND 193
		OR RIGHT(hgt,2) = 'in' AND CAST(LEFT(hgt,2) AS INT) BETWEEN 59 AND 76
		)
	AND ecl IN ('amb','blu','brn','gry','grn','hzl','oth')
	AND pid LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';