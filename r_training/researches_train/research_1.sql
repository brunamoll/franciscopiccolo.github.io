-- query_1_begin
SELECT 
	  sale_date
	, uf
	, ontime_delivery_status
	, count(1) AS qty
FROM (
	SELECT 
		  s.sale_order_store_date::date AS sale_date
		, a.state_code AS uf
		, s.delivery_date_agreed_with_customer
		, s.delivered_date
		, datediff(DAY, s.delivery_date_agreed_with_customer, s.delivered_date) AS ontime_delivery
		, CASE 
			WHEN ontime_delivery < 0 THEN 'before_date'
			WHEN ontime_delivery = 0 THEN 'ontime'
			WHEN ontime_delivery > 0 THEN 'after_date'
	  	  END AS ontime_delivery_status
	FROM integration_layer.int_sale_item AS s
	LEFT JOIN business_layer.dim_delivery_type AS d
		ON d.pk_delivery_type = s.fk_delivery_type
	LEFT JOIN business_layer.dim_address AS a
		ON a.fk_company = s.fk_company_seller
		AND a.pk_address = s.fk_address_shipping
	WHERE 1 = 1
	AND s.fk_company_seller = 1
	AND s.is_invalid = 0
	AND s.is_canceled = 0
	AND s.sale_order_store_date::date >= dateadd(YEAR, -4, sysdate)
	AND s.delivered_date IS NOT NULL
	AND s.delivery_date_agreed_with_customer IS NOT NULL
	AND d.shipping_condition = 'NORMAL'
	AND a.state_code IS NOT NULL
	)
GROUP BY 
	  sale_date
	, uf
	, ontime_delivery_status
;
-- query_1_end

-- query_2_begin
SELECT  
	  s.sale_order_store_date::date
	, s.is_warehouse_transference
	, ROUND(SUM(s.total_net_revenue_without_transference_icms_benefits_and_pis_cofins_benefits),0) as net_rev_wo_bnf
	, ROUND(SUM(s.product_net_cost_without_transference_icms_benefits),0) as net_cost_wo_bnf
	, round(1-(ROUND(SUM(s.product_net_cost_without_transference_icms_benefits),0)::float/ROUND(SUM(s.total_net_revenue_without_transference_icms_benefits_and_pis_cofins_benefits),0)::float),3) AS pc1_wo_bnf
	, ROUND(SUM(s.total_net_revenue),0) as net_rev
	, ROUND(SUM(s.product_net_cost),0) as net_cost
	, round(1-(ROUND(SUM(s.product_net_cost),0)::float/ROUND(SUM(s.total_net_revenue),0)::float),3) AS pc1
FROM integration_layer.int_sale_item AS s
WHERE 1 = 1
AND s.fk_company_seller = 1
AND s.is_invalid = 0
AND s.is_canceled = 0
AND s.is_marketplace_in = 0
AND s.sale_order_store_date::date >= dateadd(DAY, -90, sysdate)
AND s.sale_order_store_date::date < sysdate::date
GROUP BY 
	  s.sale_order_store_date::date
	, s.is_warehouse_transference
;
-- query_2_end







