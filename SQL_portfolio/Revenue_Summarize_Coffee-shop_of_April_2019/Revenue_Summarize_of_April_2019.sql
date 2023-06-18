USE [Coffee-shop-sample-data]
GO

SELECT*
FROM [dbo].[201904-sales-reciepts]
GO
-- OBSERVATION:
--	[line_item_id] = [unit_price]*[quantity]
-- => income = [line_item_id]*[order]


DROP VIEW sales_data_Apr
GO
CREATE VIEW sales_data_Apr as
SELECT
		[transaction_date],
		[sales_outlet_id],
		[staff_id],
      	[customer_id],
		CAST([order] as float) * [line_item_amount] as income,
		[product_id]
  FROM [dbo].[201904-sales-reciepts]
GO



DROP VIEW KPI_STAFFS
GO

CREATE VIEW KPI_STAFFS AS
WITH kpi_calculator AS (
    SELECT staff_id, SUM(income) AS kpi
    FROM sales_data_Apr
    GROUP BY staff_id
)
SELECT A.staff_id, kpi, CONCAT(B.first_name, ' ', B.last_name) AS staff_name
FROM kpi_calculator AS A
LEFT JOIN [dbo].[staff] AS B ON A.staff_id = B.staff_id
GO


DROP VIEW KPI_STORES
GO

CREATE VIEW KPI_STORES AS
WITH kpi_calculator AS (
    SELECT sales_outlet_id, SUM(income) AS kpi
    FROM sales_data_Apr
    GROUP BY sales_outlet_id
	)
SELECT A.sales_outlet_id, kpi, B.store_address
FROM kpi_calculator AS A
LEFT JOIN [dbo].sales_outlet AS B 
ON A.sales_outlet_id = B.sales_outlet_id
GO

DROP VIEW BEST_SALER
GO

CREATE VIEW BEST_SALER AS
WITH kpi_calculator AS (
    SELECT product_id, SUM(income) AS kpi
    FROM sales_data_Apr
    GROUP BY product_id
	)
SELECT A.product_id, kpi, B.[product], B.[product_group]
FROM kpi_calculator AS A
LEFT JOIN [dbo].[product] AS B 
ON A.product_id = B.product_id
GO

DROP VIEW TOP_CUSTOMER
GO

CREATE VIEW TOP_CUSTOMER AS
WITH kpi_calculator AS (
    SELECT customer_id, SUM(income) AS kpi
    FROM sales_data_Apr
    GROUP BY customer_id
	)
SELECT A.customer_id, kpi, B.customer_first_name
FROM kpi_calculator AS A
LEFT JOIN [dbo].customer AS B 
ON A.customer_id = B.customer_id
GO

-------  -------

SELECT*
FROM [dbo].[sales_data_Apr]

SELECT TOP 3*
FROM KPI_STAFFS
ORDER BY kpi DESC;

SELECT*
FROM KPI_STORES
ORDER BY kpi DESC;

SELECT*
FROM BEST_SALER
ORDER BY product_group,kpi DESC;

SELECT TOP 1 *
FROM TOP_CUSTOMER
WHERE customer_first_name IS NOT NULL
ORDER BY kpi DESC;