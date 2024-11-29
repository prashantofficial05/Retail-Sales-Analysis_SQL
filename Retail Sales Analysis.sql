CREATE TABLE retail_sales (
    transaction_id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    sale_time TIME NOT NULL,
    customer_id INT NOT NULL,
    gender VARCHAR(10),
    age INT,
    product_category VARCHAR(50),
    quantity_sold INT,
    price_per_unit NUMERIC(10, 2),
    cogs NUMERIC(10, 2),
    total_sale_amount NUMERIC(10, 2)
);

--insert sample data
INSERT INTO retail_sales (sale_date, sale_time, customer_id, gender, age, product_category, quantity_sold, price_per_unit, cogs, total_sale_amount)
VALUES
('2024-11-01', '10:15:00', 101, 'Male', 34, 'Clothing', 2, 50.00, 30.00, 100.00),
('2024-11-02', '14:30:00', 102, 'Female', 28, 'Beauty', 1, 75.00, 40.00, 75.00),
('2024-11-03', '09:45:00', 103, 'Male', 40, 'Electronics', 1, 1200.00, 800.00, 1200.00),
('2024-11-03', '18:20:00', 104, 'Female', 25, 'Clothing', 3, 45.00, 25.00, 135.00),
('2024-11-04', '11:00:00', 105, 'Male', 38, 'Beauty', 2, 70.00, 50.00, 140.00);

-- data cleaning 
SELECT * 
FROM retail_sales
WHERE gender IS NULL OR age IS NULL OR product_category IS NULL;

-- EDA
--total sales and transaction 
select count(*) as total_transaction,
       sum(total_sale_amount) as total_sales
from retail_sales;

--average Sales by product category 
select product_category,
       Avg(total_sale_amount) as avg_sales
from retail_sales
group by product_category
order by avg_sales desc;

-- Monthly sales trends 
select  date_trunc('month', sale_date) as month,
        sum(total_sale_amount) as monthly_sales
from retail_sales
group by date_trunc('month', sale_date)
order by month;


-- age Distribution of customer 
select age, count(*) as customer_count
from retail_sales
group by age 
order by customer_count desc;

-- Business Analysis
-- high value transaction (sales > 1000)
select * 
from retail_sales
where total_sale_amount > 1000
order by total_sale_amount desc;

-- Top spending customers
select customer_id,
       sum(total_sale_amount) as total_spent
from retail_sales
group by customer_id
order by total_spent desc
limit 5;

-- Most popular product categories
select product_category,
       sum(quantity_sold) as total_quantity
from retail_sales
group by product_category
order by total_quantity desc;

-- unique customer counts by category 
SELECT product_category, 
       COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY product_category
ORDER BY unique_customers DESC;

-- Report
-- sale summary
SELECT 
    COUNT(*) AS total_transactions,
    SUM(total_sale_amount) AS total_sales,
    AVG(total_sale_amount) AS avg_transaction_value
FROM retail_sales;

-- Trend analysis 
SELECT DATE_TRUNC('month', sale_date) AS sales_month, 
       COUNT(*) AS total_transactions,
       SUM(total_sale_amount) AS total_sales
FROM retail_sales
GROUP BY sales_month
ORDER BY sales_month;

-- customer insights
select customer_id,
       count(*) as purchase_frequency,
	   sum(total_sale_amount) as total_spent
from retail_sales
group by customer_id
order by total_spent desc
limit 10;

-- Concluding Queries
--Peak sales hours
select extract(hour from sale_time) as hour,
       sum(total_sale_amount) as sales
from retail_sales
group by hour
order by sales desc;

-- profit by product category 

select product_category,
       sum(total_sale_amount - cogs) as profit
from retail_sales
group by product_category
order by profit desc;





















