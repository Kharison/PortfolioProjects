-- DATA CLEANING AND PROCESSING
SELECT * FROM sales_canada;
DESC sales_canada;

-- changing date column from string to date data_type
#SALES IN CANADA
SELECT Date, STR_TO_DATE(Date, '%m/%d/%Y')
FROM sales_canada;

UPDATE sales_canada
SET Date = STR_TO_DATE(Date, '%m/%d/%Y');

ALTER TABLE sales_canada
MODIFY COLUMN Date Date;

#SALES IN CHINA
SELECT Date, STR_TO_DATE(Date, '%m/%d/%Y')
FROM sales_china;

UPDATE sales_china
SET Date = STR_TO_DATE(Date, '%m/%d/%Y');

ALTER TABLE sales_china
MODIFY COLUMN Date Date;

#SALES IN US
SELECT Date, STR_TO_DATE(Date, '%m/%d/%Y')
FROM sales_us;

UPDATE sales_us
SET Date = STR_TO_DATE(Date, '%m/%d/%Y');

ALTER TABLE sales_us
MODIFY COLUMN Date Date;

#SALES IN UK
SELECT Date, STR_TO_DATE(Date, '%m/%d/%Y')
FROM sales_uk;

UPDATE sales_uk
SET Date = STR_TO_DATE(Date, '%m/%d/%Y');

ALTER TABLE sales_uk
MODIFY COLUMN Date Date;

#SALES IN INDIA
SELECT Date, STR_TO_DATE(Date, '%m/%d/%Y')
FROM sales_india;

UPDATE sales_india
SET Date = STR_TO_DATE(Date, '%m/%d/%Y');

ALTER TABLE sales_india
MODIFY COLUMN Date Date;

#SALES IN NIGERIA
SELECT Date, STR_TO_DATE(Date, '%m/%d/%Y')
FROM sales_nigeria;

UPDATE sales_nigeria
SET Date = STR_TO_DATE(Date, '%m/%d/%Y');

ALTER TABLE sales_nigeria
MODIFY COLUMN Date Date;

-- Combining all the tables in one table
CREATE TABLE sales_branch
SELECT * FROM sales_canada
UNION ALL
SELECT * FROM sales_china
UNION ALL
SELECT * FROM sales_uk
UNION ALL
SELECT * FROM sales_us
UNION ALL
SELECT * FROM sales_india
UNION ALL
SELECT * FROM sales_nigeria;

SELECT * FROM sales_branch;

-- Checking for null data
SELECT 
    *
FROM
    sales_branch
WHERE
    Transaction_ID IS NULL OR Date IS NULL
        OR Country IS NULL
        OR Product_ID IS NULL
        OR Product_Name IS NULL
        OR Category IS NULL
        OR Price_per_Unit IS NULL
        OR Quantity_Purchased IS NULL
        OR Cost_Price IS NULL
        OR Discount_Applied IS NULL
        OR Payment_Method IS NULL
        OR Customer_Age_Group IS NULL
        OR Customer_Gender IS NULL
        OR Store_Location IS NULL
        OR Sales_Rep IS NULL;

-- Checking for duplicate values
SELECT Transaction_ID, COUNT(*) AS ID_Counts
FROM sales_branch
GROUP BY Transaction_ID
HAVING ID_Counts > 1;

-- Adding new columns
ALTER TABLE sales_branch
ADD COLUMN Total_Amount Numeric(10, 2);

ALTER TABLE sales_branch
ADD COLUMN Profit Numeric(10, 2);

UPDATE sales_branch
SET Total_Amount = (Price_per_Unit * Quantity_Purchased) - Discount_Applied;

UPDATE sales_branch
SET Profit = Total_Amount - (Cost_Price + Quantity_Purchased);


-- EDA
-- 1. Sales Revenue & Profit by Country (Combined Query)
SELECT
	Country,
    SUM(Total_Amount) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM sales_branch
WHERE Date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY Country
ORDER BY Total_Revenue DESC;


-- 2. Top 5 Best-Selling Products (During the Period)
SELECT
	Product_Name,
    SUM(Quantity_Purchased) AS Total_unit_sold
FROM sales_branch
WHERE Date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY Product_Name
ORDER BY Total_unit_sold DESC
LIMIT 5;

-- 3. Best Sales Representatives (During the Period)
SELECT
	sales_Rep,
    SUM(Total_Amount) AS Total_Sales
FROM sales_branch
WHERE Date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY Sales_Rep
ORDER BY Total_Sales DESC;


-- 4. Which store locations generated the highest sales?
SELECT
	Store_Location,
    SUM(Total_Amount) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM sales_branch
WHERE Date BETWEEN '2025-02-10' AND '2025-02-14'
GROUP BY Store_Location
ORDER BY Total_Sales DESC
LIMIT 5;


-- 5. What are the key sales and profit insights for the selected period?
SELECT
    MIN(Total_Amount) AS "Min Sales Value",
    MAX(Total_Amount) AS "Max Sales Value",
    AVG(Total_Amount) AS "Avg Sales Value",
    SUM(Total_Amount) AS "Total Sales Value",
    MIN(Profit) AS "Min Profit",
    MAX(Profit) AS "Max Profit",
    AVG(Profit) AS "Avg Profit",
    SUM(Profit) AS "Total Profit"
FROM sales_branch
WHERE Date BETWEEN '2025-02-10' AND '2025-02-14';



















