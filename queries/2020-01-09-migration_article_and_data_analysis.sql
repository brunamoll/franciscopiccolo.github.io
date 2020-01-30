-- query_1_begin
-- Amostra dos dados tratados
SELECT
	  date
	, country
	, remitances_over_gdp
	, last_remitances_over_gdp
	, round((remitances_over_gdp/last_remitances_over_gdp)-1,4) as delta_remitances_over_gdp
FROM (
	SELECT
		  rem.date
		, rem.country
		, round(rem.value/100,4) as remitances_over_gdp
		, lag(round(rem.value/100,4)) over (partition by rem.country order by rem.date asc) as last_remitances_over_gdp
	FROM remitances_over_gdp AS rem
	WHERE 1 = 1
	ORDER BY 
		  rem.date asc
	)
-- query_1_end

-- query_2_begin
SELECT
	  country
FROM
	(SELECT
		  date
		, Region
		, country
		, value
		, country_total_migration
		, row_number() over (partition by date,Region order by country_total_migration desc) as rn
	FROM
		(SELECT
			  date
			, Region 
			, country
			, value
			, sum(value) over (partition by country) as country_total_migration
		FROM migrants_pop_region
		)
	)
WHERE 1 = 1
and rn <= 5
and Region != 'Unknown'
;
-- query_2_end


