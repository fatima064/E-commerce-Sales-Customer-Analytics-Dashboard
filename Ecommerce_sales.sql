CREATE DATABASE ecommerce_analytics;
USE ecommerce_analytics;
CREATE TABLE ecommerce_sales (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Sales DECIMAL(12,2),
    Region VARCHAR(30),
    Payment_Method VARCHAR(50)
);
SELECT COUNT(*) AS total_orders
FROM ecommerce_sales;
SELECT
    COUNT(*) AS total_rows,
    SUM(Order_ID IS NULL) AS missing_order_id,
    SUM(Order_Date IS NULL) AS missing_date,
    SUM(Customer_ID IS NULL) AS missing_customer_id,
    SUM(Product IS NULL) AS missing_product,
    SUM(Sales IS NULL) AS missing_sales
FROM ecommerce_sales;
SELECT
    Order_ID,
    COUNT(*) AS order_count
FROM ecommerce_sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;
SELECT COUNT(*) AS incorrect_sales
FROM ecommerce_sales
WHERE Sales <> Quantity * Unit_Price;
SELECT COUNT(*) AS invalid_values
FROM ecommerce_sales
WHERE Quantity <= 0
   OR Unit_Price <= 0
   OR Sales <= 0;
   
SELECT
    SUM(Sales) AS Total_Revenue,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Average_Order_Value
FROM ecommerce_sales;
SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM ecommerce_sales
GROUP BY Category
ORDER BY Total_Sales DESC;
SELECT
    Customer_ID,
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM ecommerce_sales
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;
SELECT
    Customer_Type,
    COUNT(*) AS Customer_Count
FROM (
    SELECT
        Customer_ID,
        CASE
            WHEN COUNT(Order_ID) > 1 THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS Customer_Type
    FROM ecommerce_sales
    GROUP BY Customer_ID
) AS customer_summary
GROUP BY Customer_Type;
SELECT
    Product,
    SUM(Quantity) AS Units_Sold,
    SUM(Sales) AS Total_Sales
FROM ecommerce_sales
GROUP BY Product
ORDER BY Total_Sales DESC
LIMIT 10;