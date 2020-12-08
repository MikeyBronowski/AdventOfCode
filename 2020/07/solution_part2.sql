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
	),
	CTE_split (rl,rr) AS (
        SELECT RTRIM(LEFT(r,CHARINDEX('contain',r)-1)),RIGHT(r,LEN(r)-CHARINDEX('contain',r)-6)
        FROM CTE_rules
	), CTE_split2 (rl,bg,color) AS (
        SELECT rl,
        CAST(replace(LEFT(trim(value),CHARINDEX(' ',trim(value))-1),'no',0) AS INT),
        RIGHT(trim(value),LEN(trim(value))-CHARINDEX(' ',trim(value)))
        FROM CTE_split CROSS APPLY STRING_SPLIT(rr, ',')
	)
	select sum(sa) from (
		select a.color,sum(a.bg) sa
		from cte_split2 a
		where a.rl like '%shiny gold%'
		group by a.color
	union all
		select a.color,sum(a.bg*b.bg) sa
		from cte_split2 a
		join cte_split2 b on b.rl = a.color
		where a.rl like '%shiny gold%'
		group by a.color
	union all
		select a.color,sum(a.bg*b.bg*c.bg) sa
		from cte_split2 a
		join cte_split2 b on b.rl = a.color
		join cte_split2 c on c.rl = b.color
		where a.rl like '%shiny gold%'
		group by a.color
	union all
		select a.color,sum(a.bg*b.bg*c.bg*d.bg) sa
		from cte_split2 a
		join cte_split2 b on b.rl = a.color
		join cte_split2 c on c.rl = b.color
		join cte_split2 d on d.rl = c.color
		where a.rl like '%shiny gold%'
		group by a.color
	union all
		select a.color,sum(a.bg*b.bg*c.bg*d.bg*e.bg) sa
		from cte_split2 a
		join cte_split2 b on b.rl = a.color
		join cte_split2 c on c.rl = b.color
		join cte_split2 d on d.rl = c.color
		join cte_split2 e on e.rl = d.color
		where a.rl like '%shiny gold%'
		group by a.color
	union all
		select a.color,sum(a.bg*b.bg*c.bg*d.bg*e.bg*f.bg) sa
		from cte_split2 a
		join cte_split2 b on b.rl = a.color
		join cte_split2 c on c.rl = b.color
		join cte_split2 d on d.rl = c.color
		join cte_split2 e on e.rl = d.color
		join cte_split2 f on f.rl = e.color
		where a.rl like '%shiny gold%'
		group by a.color
	union all
		select a.color,sum(a.bg*b.bg*c.bg*d.bg*e.bg*f.bg*g.bg) sa
		from cte_split2 a
		join cte_split2 b on b.rl = a.color
		join cte_split2 c on c.rl = b.color
		join cte_split2 d on d.rl = c.color
		join cte_split2 e on e.rl = d.color
		join cte_split2 f on f.rl = e.color
		join cte_split2 g on g.rl = f.color
		where a.rl like '%shiny gold%'
		group by a.color
	union all
		select a.color,sum(a.bg*b.bg*c.bg*d.bg*e.bg*f.bg*g.bg*h.bg) sa
		from cte_split2 a
		join cte_split2 b on b.rl = a.color
		join cte_split2 c on c.rl = b.color
		join cte_split2 d on d.rl = c.color
		join cte_split2 e on e.rl = d.color
		join cte_split2 f on f.rl = e.color
		join cte_split2 g on g.rl = f.color
		join cte_split2 h on h.rl = g.color
		where a.rl like '%shiny gold%'
		group by a.color
	union all
		select a.color,sum(a.bg*b.bg*c.bg*d.bg*e.bg*f.bg*g.bg*h.bg*i.bg) sa
		from cte_split2 a
		join cte_split2 b on b.rl = a.color
		join cte_split2 c on c.rl = b.color
		join cte_split2 d on d.rl = c.color
		join cte_split2 e on e.rl = d.color
		join cte_split2 f on f.rl = e.color
		join cte_split2 g on g.rl = f.color
		join cte_split2 h on h.rl = g.color
		join cte_split2 i on i.rl = h.color
		where a.rl like '%shiny gold%'
		group by a.color
	)suuuum
