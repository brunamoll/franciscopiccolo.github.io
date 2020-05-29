-- query_1_begin
SELECT
	  fk_company
	, first_name
	, last_name
	, billet_unpaid_rate
	, avg_days_btw_billet_generation
	, total_billets_unpaid
	, total_billet_unpaid_gtv
FROM business_layer.dim_customer as d 
WHERE 1 = 1
AND fk_company = 1 
AND first_name = 'Francisco'
AND last_name = 'Piccolo'
LIMIT 10
;
-- query_1_end

-- query_2_begin
SELECT 
	  sale_order_store_date::date
	, gtv
	, avg(gtv) over (partition by 1 order by sale_order_store_date rows between 5 preceding and 0 following) as avg_gtv
FROM (
	SELECT
		  s.sale_order_store_date::date
		, sum(s.gross_total_value) as gtv
	FROM integration_layer.int_sale_item as s 
	WHERE 1 = 1
	AND s.fk_company_seller = 1
	AND s.sale_order_store_date::date >= dateadd(DAY, -90, sysdate)
	GROUP BY s.sale_order_store_date::date
	)
;
-- query_2_end
