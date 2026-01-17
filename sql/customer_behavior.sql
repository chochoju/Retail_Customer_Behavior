-- Core Business Analysis
-- Create a base view
CREATE OR REPLACE VIEW retail.v_base_orders AS
SELECT
    o.order_id,
    o.customer_id,
    o.product_id,
    o.quantity,
    o.price,
    (o.quantity * o.price) AS revenue,
    o.discount_percent,
    o.shipping_method,
    o.order_date,
    o.order_time,
    o.delivery_status,
    o.coupon_code,
    o.is_gift,

	c.gender,
    c.membership_tier,
    c.birth_year,
    c.state,

    p.product_name,
    p.category_id,
    cat.category_name
FROM retail.orders o
JOIN retail.customers c ON o.customer_id = c.customer_id
JOIN retail.products p ON o.product_id = p.product_id
JOIN retail.categories cat ON p.category_id = cat.category_id
WHERE o.price IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON retail.orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_orders_product_id  ON retail.orders(product_id);
CREATE INDEX IF NOT EXISTS idx_orders_order_date  ON retail.orders(order_date);
CREATE INDEX IF NOT EXISTS idx_products_category_id ON retail.products(category_id);


-- Section 1: Who are our customers? (Customer Profile & Demographics)
-- Q1. Customer composition & Revenue contribution by age group
WITH with_age AS(
	SELECT *, (EXTRACT(YEAR FROM CURRENT_DATE)::int - birth_year) AS age
	FROM retail.v_base_orders
),
age_grouped AS (
	SELECT *,
		CASE
			WHEN age <= 29 THEN 'Young Adults'
			WHEN age BETWEEN 30 AND 49 THEN 'Adults'
			ELSE 'Senior'
		END AS age_group
	FROM with_age
)
SELECT
	age_group,
	SUM(revenue) AS total_revenue,
	ROUND(AVG(revenue),2) AS avg_order_value,
	COUNT (DISTINCT customer_id) AS customers
FROM age_grouped
GROUP BY age_group
ORDER BY total_revenue DESC;


-- Q2. Revenue split by gender
SELECT gender, SUM(revenue) AS total_revenue
FROM retail.v_base_orders
GROUP BY gender
ORDER BY total_revenue DESC;

-- Q3. Top 3 categories by gender
WITH ranked_categories AS (
	SELECT
		gender, 
		category_name,
		SUM(revenue) AS total_revenue,
		RANK() OVER (
		PARTITION BY gender ORDER BY SUM(revenue) DESC
		) AS rnk
	FROM retail.v_base_orders
	GROUP BY gender, category_name
)
SELECT
	gender, category_name, ROUND(total_revenue,2) AS total_revenue, rnk
FROM ranked_categories
WHERE rnk <= 3
ORDER BY gender, rnk ASC;


-- Section 2: How do customers shop? (Purchase Behavior)
-- Q4. Average purchase value by shipping method
SELECT shipping_method, ROUND(AVG(revenue),2) AS avg_purchase_amount
FROM retail.v_base_orders
WHERE shipping_method IN ('Standard', 'Express')
GROUP BY shipping_method
ORDER BY avg_purchase_amount DESC;


-- Q5. Discount behavior vs spending power
-- Which customers placed discounted high-value orders?
WITH avg_order AS (
	SELECT AVG(revenue) AS avg_rev
	FROM retail.v_base_orders
),
qualified_orders AS (
	SELECT b.customer_id, b.revenue
	FROM retail.v_base_orders b
	CROSS JOIN avg_order a
	WHERE b.discount_percent > 0 AND b.revenue > a.avg_rev
)
SELECT 
	customer_id, COUNT(*) AS qualifying_orders,
	ROUND(AVG(revenue),2) AS avg_qualifying_order_value,
	ROUND(SUM(revenue),2) AS total_qualifying_revenue
FROM qualified_orders
GROUP BY customer_id
ORDER BY total_qualifying_revenue DESC;


-- Q6. Discount dependency by product (pricing elasticity)
SELECT 
	product_id, 
	product_name, 
	ROUND(100 * COUNT(*) FILTER (WHERE discount_percent > 0)/ COUNT(*),2) AS discounted_purchase_pct,
	COUNT(*) AS total_orders
FROM retail.v_base_orders
GROUP BY product_id, product_name
HAVING COUNT(*) >= 50
ORDER BY discounted_purchase_pct DESC
LIMIT 5;


-- Section 3: What drives sales? (Products & Categories)
-- Q7. Top-performing products overall (revenue & number of orders)
SELECT product_id, product_name, SUM(revenue) AS total_revenue
FROM retail.v_base_orders
GROUP BY product_id, product_name
ORDER BY total_revenue DESC
LIMIT 5;

SELECT product_id, product_name, COUNT(DISTINCT order_id) AS order_count
FROM retail.v_base_orders
GROUP BY product_id, product_name
ORDER BY order_count DESC
LIMIT 5;

-- Q8. Top products within each category
WITH ranked AS (
	SELECT
		category_name, product_id, product_name,
		SUM(quantity) AS units_sold,
		RANK() OVER(
			PARTITION BY category_name 
			ORDER BY SUM(quantity) DESC
		) AS rnk
	FROM retail.v_base_orders
	GROUP BY category_name, product_id, product_name
)
SELECT category_name, product_id, product_name, units_sold, rnk
FROM ranked
WHERE rnk <= 3
ORDER BY category_name, rnk ASC;


-- Section 4: Customer loyalty & segmentation (Customer behavior insight)
-- Q9. Customer segmentation by purchase frequency (New, Returning, Loyal)
WITH customer_order_counts AS (
	SELECT customer_id, COUNT(DISTINCT order_id) AS total_orders
	FROM retail.v_base_orders
	GROUP BY customer_id
)
SELECT
	CASE
		WHEN total_orders = 1 THEN 'New'
		WHEN total_orders BETWEEN 2 AND 10 THEN 'Returning'
		ELSE 'Loyal'
	END AS customer_segment,
	COUNT(*) AS customer_count
FROM customer_order_counts
GROUP BY customer_segment
ORDER BY customer_count DESC;


-- Q10. Do higher-tier members spend more?
SELECT
	CASE 
		WHEN membership_tier IN ('Platinum', 'Gold') THEN 'Platinum & Gold'
		WHEN membership_tier IN ('Silver', 'Bronze') THEN 'Silver & Bronze'
		ELSE 'Other/Unknown'
	END AS tier_group,
	COUNT(DISTINCT customer_id) AS customers,
	ROUND(AVG(revenue),2) AS avg_order_value,
	SUM(revenue) AS total_revenue
FROM retail.v_base_orders
GROUP BY tier_group
ORDER BY total_revenue DESC;


-- Q11. Are loyal customers less dependent on discounts?
WITH customer_order_counts AS (
	SELECT customer_id, COUNT(DISTINCT order_id) AS total_orders
	FROM retail.v_base_orders
	GROUP BY customer_id
),
seg AS (
	SELECT
		customer_id,
		CASE
			WHEN total_orders = 1 THEN 'New'
			WHEN total_orders BETWEEN 2 AND 10 THEN 'Returning'
			ELSE 'Loyal'
		END AS customer_segment
	FROM customer_order_counts
)
SELECT 
	s.customer_segment, 
	ROUND(
		100 * COUNT(*) FILTER (WHERE b.discount_percent > 0)/COUNT(*),2
	) AS discount_usage_pct,
	COUNT(*) AS orders
FROM retail.v_base_orders b
JOIN seg s ON b.customer_id = s.customer_id
GROUP BY s.customer_segment
ORDER BY orders DESC;












