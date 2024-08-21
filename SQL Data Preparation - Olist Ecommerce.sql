----------------#1 DATASET OVERVIEW-----------------------------------------------------------------------------------------------------------------------


--FACT tables

SELECT * FROM olist_orders 
SELECT * FROM olist_order_items 
SELECT * FROM olist_order_payments 
SELECT * FROM olist_order_reviews
	
	
--DIM tables
	
SELECT * FROM olist_customers
SELECT * FROM olist_geolocation 
SELECT * FROM olist_products 
SELECT * FROM olist_sellers 
SELECT * FROM product_category_name_translation 



	
----------------#2 DATA CLEANING: DETECT DUPLICATES AND REMOVE DUPLICATES----------------------------------------------------------------------------

	
--Detect duplicates from olist_orders >>> no duplicates

SELECT count(*)
FROM
(
	SELECT order_id, count(*) as records
	FROM olist_orders
	GROUP BY 1
) a
WHERE records > 1


--Detect duplicates from olist_order_items >>> no duplicates
	
SELECT count(*)
FROM
(
	SELECT order_id,order_item_id, count(*) as records
	FROM olist_order_items
	GROUP BY 1,2
) a
WHERE records > 1
	

--Detect duplicates from olist_order_payments >>> no duplicates

SELECT count(*)
FROM
(
	SELECT order_id, payment_sequential, count(*) as records
	FROM olist_order_payments
	GROUP BY 1,2
) a
WHERE records > 1


--Detect duplicates from olist_customers >>> no duplicates

SELECT count(*)
FROM
(
	SELECT customer_id, count(*) as records
	FROM olist_customers
	GROUP BY 1
) a
WHERE records > 1


--Detect duplicates from olist_products >>> no duplicates

SELECT count(*)
FROM
(
	SELECT product_id, count(*) as records
	FROM olist_products
	GROUP BY 1
) a
WHERE records > 1


--Detect duplicates from olist_sellers  >>> no duplicates

SELECT count(*)
FROM
(
	SELECT seller_id, count(*) as records
	FROM olist_sellers 
	GROUP BY 1
) a
WHERE records > 1


--Detect duplicates from product_category_name_translation >>> no duplicates

SELECT count(*)
FROM
(
	SELECT product_category_name, count(*) as records
	FROM product_category_name_translation 
	GROUP BY 1
) a
WHERE records > 1
 
	
--Detect duplicates from olist_order_reviews >>> no duplicates

SELECT count(*)
FROM
(
	SELECT review_id, order_id, count(*) as records
	FROM olist_order_reviews 
	GROUP BY 1,2
) a
WHERE records > 1


--Detect duplicates from olist_geolocation table >>> 128174 duplicate records
	
SELECT count(*)
FROM
(
	SELECT geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city,  geolocation_state, count(*) as records
	FROM olist_geolocation 
	GROUP BY 1,2,3,4,5
) a
WHERE records > 1

	
--Remove duplicates from olist_geolocation table 

CREATE temporary table new_olist_geolocation
AS
(
	SELECT distinct *
	FROM olist_geolocation
	ORDER BY 1
)

	

----------------#3 DATA CLEANING: DETECT AND HANDLE MISSING VALUE-------------------------------------------------------------------------------

	
--Detect missing value in FACT table 
--Remove missing value in olist_order_items table from 3 remaining tables

SELECT distinct order_id FROM olist_orders --> 99441 unique order_id
SELECT distinct order_id FROM olist_order_items --> 98666 unique order_id 
SELECT distinct order_id FROM olist_order_payments --> 99440 unique order_id
SELECT distinct order_id FROM olist_order_reviews --> 98673 unique order_id

	
--Create new_olist_order_items table (temporary table) >>> 98665 unique order_id 

CREATE temporary table new_olist_order_items 
as
(
	SELECT order_id, order_item_id, product_id
	,seller_id, shipping_limit_date, price, freight_value
	FROM
 	(
		SELECT a.order_id, a.order_item_id, a.product_id
		,a.seller_id, a.shipping_limit_date, a.price, a.freight_value, count (*)
		FROM olist_order_items a
		LEFT JOIN olist_order_payments b on a.order_id = b.order_id
		WHERE b.order_id is not null
		GROUP BY 1,2,3,4,5,6,7
	)
)

	
--Create new_olist_orders table (tempaorary table) >>> 98665 unique order_id 

CREATE temporary table new_olist_orders 
as
(
	SELECT order_id, customer_id, order_status, order_purchase_timestamp
	,order_approved_at, order_delivered_carrier_date
	,order_delivered_customer_date, order_estimated_delivery_date
	FROM
		(
		SELECT a.order_id, a.customer_id, a.order_status, a.order_purchase_timestamp
		,a.order_approved_at, a.order_delivered_carrier_date
		,a.order_delivered_customer_date, a.order_estimated_delivery_date, count(*)
		FROM olist_orders a
		LEFT JOIN new_olist_order_items b on a.order_id = b.order_id
		WHERE b.order_id is not null
		GROUP BY 1,2,3,4,5,6,7,8
		)
)

	
--Create new_olist_order_payments table (temporary table) >>> 98665 unique order_id 

CREATE temporary table new_olist_order_payments
as
( 
	SELECT order_id, payment_sequential, payment_type
	, payment_installments, payment_value
	FROM
	(
		SELECT a.order_id, a.payment_sequential, a.payment_type
		, a.payment_installments, a.payment_value, count(*)
		FROM olist_order_payments a
		LEFT JOIN new_olist_order_items b on a.order_id = b.order_id
		WHERE b.order_id is not null
		GROUP BY 1,2,3,4,5
	)
)

	
--Create new_olist_order_reviews table (temporary table) >>> 97916 unique order_id

CREATE temporary table new_olist_order_reviews
as
(
	SELECT review_id, order_id, review_score, review_comment_title
	,review_comment_message, review_creation_date, review_answer_timestamp
	FROM
	(
		SELECT a.review_id, a.order_id, a.review_score, a.review_comment_title
		,a.review_comment_message, a.review_creation_date, a.review_answer_timestamp, count(*)
		FROM olist_order_reviews a
		LEFT JOIN new_olist_order_items b on a.order_id = b.order_id
		WHERE b.order_id is not null
		GROUP BY 1,2,3,4,5,6,7
	)
)
	
SELECT distinct order_id from new_olist_order_reviews

	
--Create new_olist_customers table (temporary table) >>> 98665 unique customer_id (order_id)

CREATE temporary table new_olist_customers
as
(
	SELECT customer_id, customer_unique_id, customer_zip_code_prefix
	, customer_city, customer_state
	FROM
	(
		SELECT a.customer_id, a.customer_unique_id, a.customer_zip_code_prefix
		, a.customer_city, a.customer_state, count(*) as records
		FROM olist_customers a
		LEFT JOIN new_olist_orders b on a.customer_id = b.customer_id
		WHERE b.customer_id is not null
		GROUP BY 1,2,3,4,5
	)
)


	
	
----------------#4 CALCULATE KEY METRICS---------------------------------------------------------------------------------------------------------------

 
--Caculate order_value_of_item (temporary table)

CREATE temporary table final_olist_order_items
as
(
	SELECT *, (price + freight_value) as order_value_of_item
	FROM new_olist_order_items
)

	
--Define type_of_customer (one-time customer and repeat customer) (temporary table)
	
CREATE temporary table final_olist_customers
as
(	
	SELECT *, count (customer_id) over (partition by customer_unique_id) as number_of_orders
	, case when count (customer_id) over (partition by customer_unique_id) = 1 then 'one time customer' 
	  else 'repeat customer' end as type_of_customer
	FROM new_olist_customers
)

	
--Calculate delivery_time 
--Define delivery_status (on-time delivery,late delivery and non-delivered)

CREATE temporary table 	final_olist_orders
as
(
	SELECT *
	,(order_delivered_customer_date - order_purchase_timestamp) as delivery_time
	, case when order_delivered_customer_date <= order_estimated_delivery_date and order_status = 'delivered' then 'on-time delivery' 
		   when order_delivered_customer_date > order_estimated_delivery_date and order_status = 'delivered' then 'late delivery'
	       else 'non-delivered' end as delivery_status    
	FROM new_olist_orders
)



	
----------------#5 EDA-------------------------------------------------------------------------------------------------------------------------------------

	
--Cancellation rate

SELECT count (order_id) as total_orders
, count (case when delivery_status <> 'non-delivered' then order_id end)
,count (case when delivery_status <> 'non-delivered' then order_id end)*100.0/count (order_id) as cancellation_rate
FROM final_olist_orders


--Product_category 

SELECT b.product_category_name_english, c.order_id, d.order_status
FROM olist_products a
JOIN product_category_name_translation b on a.product_category_name = b.product_category_name
JOIN final_olist_order_items c on a.product_id = c.product_id
JOIN final_olist_orders d on c.order_id = d.order_id
WHERE b.product_category_name_english = 'fashion_childrens_clothes'

	
--First payment type

SELECT payment_type, count (order_id) as first_payment_type
FROM new_olist_order_payments
WHERE payment_sequential = 1
GROUP BY 1

	
--Second payment type
	
SELECT payment_type, count (order_id) as first_payment_type
FROM new_olist_order_payments
WHERE payment_sequential = 2
GROUP BY 1

	
--Payment type
	
SELECT *
FROM
(
	SELECT distinct order_id, min (payment_sequential) over (partition by order_id ) as first_pay
	FROM new_olist_order_payments
	) 
JOIN new_olist_order_payments b on a.order_id = b.order_id
WHERE first_pay <> 1


SELECT * 
FROM olist_order_payments
WHERE order_id in ('00ac05fe0fc047c54418098eb64e3aaa', '056c68d093c100017aab1f00f260705c')


--Product by customers

SELECT sum (customers) 
FROM
	(
SELECT product_category_name_english, count (distinct customer_unique_id) as customers
FROM product_category_name_translation a
JOIN olist_products b on a.product_category_name = b.product_category_name
JOIN final_olist_order_items c on b.product_id = c.product_id
JOIN final_olist_orders d on c.order_id = d.order_id
JOIN final_olist_customers e on d.customer_id = e. customer_id
--WHERE date_part('year',order_purchase_timestamp) = 2017 and date_part('month',order_purchase_timestamp) = 02
GROUP BY 1)

	


----------------#6 CREATE TEMPORARY TABLE FOR DATA VISUALIZATION------------------------------------------------------------------------------------------- 

--Remove duplicates from olist_geolocation table 

CREATE temporary table new_olist_geolocation
AS
(
	SELECT distinct *
	FROM olist_geolocation
	ORDER BY 1
)


--Create new_olist_order_items table (temporary table) >>> 98665 unique order_id 

CREATE temporary table new_olist_order_items 
as
(
	SELECT order_id, order_item_id, product_id
	,seller_id, shipping_limit_date, price, freight_value
	FROM
 	(
		SELECT a.order_id, a.order_item_id, a.product_id
		,a.seller_id, a.shipping_limit_date, a.price, a.freight_value, count (*)
		FROM olist_order_items a
		LEFT JOIN olist_order_payments b on a.order_id = b.order_id
		WHERE b.order_id is not null
		GROUP BY 1,2,3,4,5,6,7
	)
)

	
--Create new_olist_orders table (tempaorary table) >>> 98665 unique order_id 

CREATE temporary table new_olist_orders 
as
(
	SELECT order_id, customer_id, order_status, order_purchase_timestamp
	,order_approved_at, order_delivered_carrier_date
	,order_delivered_customer_date, order_estimated_delivery_date
	FROM
		(
		SELECT a.order_id, a.customer_id, a.order_status, a.order_purchase_timestamp
		,a.order_approved_at, a.order_delivered_carrier_date
		,a.order_delivered_customer_date, a.order_estimated_delivery_date, count(*)
		FROM olist_orders a
		LEFT JOIN new_olist_order_items b on a.order_id = b.order_id
		WHERE b.order_id is not null
		GROUP BY 1,2,3,4,5,6,7,8
		)
)

	
--Create new_olist_order_payments table (temporary table) >>> 98665 unique order_id 

CREATE temporary table new_olist_order_payments
as
( 
	SELECT order_id, payment_sequential, payment_type
	, payment_installments, payment_value
	FROM
	(
		SELECT a.order_id, a.payment_sequential, a.payment_type
		, a.payment_installments, a.payment_value, count(*)
		FROM olist_order_payments a
		LEFT JOIN new_olist_order_items b on a.order_id = b.order_id
		WHERE b.order_id is not null
		GROUP BY 1,2,3,4,5
	)
)

	
--Create new_olist_order_reviews table (temporary table) >>> 97916 unique order_id

CREATE temporary table new_olist_order_reviews
as
(
	SELECT review_id, order_id, review_score, review_comment_title
	,review_comment_message, review_creation_date, review_answer_timestamp
	FROM
	(
		SELECT a.review_id, a.order_id, a.review_score, a.review_comment_title
		,a.review_comment_message, a.review_creation_date, a.review_answer_timestamp, count(*)
		FROM olist_order_reviews a
		LEFT JOIN new_olist_order_items b on a.order_id = b.order_id
		WHERE b.order_id is not null
		GROUP BY 1,2,3,4,5,6,7
	)
)
	

	
--Create new_olist_customers table (temporary table) >>> 98665 unique customer_id (order_id)

CREATE temporary table new_olist_customers
as
(
	SELECT customer_id, customer_unique_id, customer_zip_code_prefix
	, customer_city, customer_state
	FROM
	(
		SELECT a.customer_id, a.customer_unique_id, a.customer_zip_code_prefix
		, a.customer_city, a.customer_state, count(*) as records
		FROM olist_customers a
		LEFT JOIN new_olist_orders b on a.customer_id = b.customer_id
		WHERE b.customer_id is not null
		GROUP BY 1,2,3,4,5
	)
)

 
--Caculate order_value_of_item (temporary table)

CREATE temporary table final_olist_order_items
as
(
	SELECT *, (price + freight_value) as order_value_of_item
	FROM new_olist_order_items
)

	
--Define type_of_customer (one-time customer and repeat customer) (temporary table)
	
CREATE temporary table final_olist_customers
as
(	
	SELECT *, count (customer_id) over (partition by customer_unique_id) as number_of_orders
	, case when count (customer_id) over (partition by customer_unique_id) = 1 then 'one time customer' 
	  else 'repeat customer' end as type_of_customer
	FROM new_olist_customers
)

	
--Calculate delivery_time 
--Define delivery_status (on-time delivery,late delivery and non-delivered)

CREATE temporary table 	final_olist_orders
as
(
	SELECT *
	,(order_delivered_customer_date - order_purchase_timestamp) as delivery_time
	, case when order_delivered_customer_date <= order_estimated_delivery_date and order_status = 'delivered' then 'on-time delivery' 
		   when order_delivered_customer_date > order_estimated_delivery_date and order_status = 'delivered' then 'late delivery'
	       else 'non-delivered' end as delivery_status    
	FROM new_olist_orders
)


--New tables
	
SELECT * FROM final_olist_orders
SELECT * FROM final_olist_order_items
SELECT * FROM final_olist_customers
SELECT * FROM new_olist_order_payments
SELECT * FROM new_olist_order_reviews
SELECT * FROM new_olist_geolocation

