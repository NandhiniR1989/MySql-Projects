use ecomm;

select * from customer_churn;

SET SQL_SAFE_UPDATES = 0;

-- DATA CLEANING

-- Handling Missing Values and Outliers:
/*Impute mean for the following columns, and round off to the nearest integer if required: 
WarehouseToHome, HourSpendOnApp, OrderAmountHikeFromlastYear, DaySinceLastOrder.*/

-- IMPUTE MEAN FOR WarehouseToHome
UPDATE customer_churn
SET WarehouseToHome = 
( 
	SELECT ROUND(AVG(WarehouseToHome))
	FROM (SELECT * FROM customer_churn) AS customerchurn
) 
WHERE WarehouseToHome IS NULL;

-- IMPUTE MEAN FOR HourSpendOnApp
UPDATE customer_churn
SET HourSpendOnApp = 
(
    SELECT ROUND(AVG(HourSpendOnApp))
    FROM (SELECT * FROM customer_churn) as customerchurn
)
WHERE HourSpendOnApp IS NULL;

-- IMPUTE MEAN FOR OrderAmountHikeFromlastYear
UPDATE customer_churn
SET OrderAmountHikeFromlastYear = 
( 
	SELECT ROUND(AVG(OrderAmountHikeFromlastYear))
	FROM (SELECT * FROM customer_churn) AS customerchurn
) 
WHERE OrderAmountHikeFromlastYear IS NULL;

-- IMPUTE MEAN FOR DaySinceLastOrder.
UPDATE customer_churn
SET DaySinceLastOrder = 
( 
	SELECT ROUND(AVG(DaySinceLastOrder))
	FROM (SELECT * FROM customer_churn) AS customerchurn
) 
WHERE DaySinceLastOrder IS NULL;

-- Impute mode for the following columns: Tenure,CouponUsed, OrderCount.
-- IMPUTE MODE FOR Tenure
UPDATE customer_churn
SET Tenure = (
	SELECT Tenure FROM 
    (
        SELECT Tenure FROM customer_churn
        GROUP BY Tenure
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS customerchurn
)
WHERE Tenure IS NULL;

-- IMPUTE MODE FOR CouponUsed
UPDATE customer_churn
SET CouponUsed = (
	SELECT CouponUsed FROM 
    (
        SELECT CouponUsed FROM customer_churn
        GROUP BY CouponUsed
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS customerchurn
)
WHERE CouponUsed IS NULL;

-- IMPUTE MODE FOR OrderCount
UPDATE customer_churn
SET OrderCount = (
	SELECT OrderCount FROM 
    (
        SELECT OrderCount FROM customer_churn
        GROUP BY OrderCount
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS customerchurn
)
WHERE OrderCount IS NULL;

/*Handle outliers in the 'WarehouseToHome' column by deleting rows where the
values are greater than 100.*/

DELETE from customer_churn WHERE WarehouseToHome > 100;

-- Dealing with Inconsistencies:
/*Replace occurrences of “Phone” in the 'PreferredLoginDevice' column and
“Mobile” in the 'PreferedOrderCat' column with “Mobile Phone” to ensure
uniformity*/

UPDATE customer_churn SET PreferredLoginDevice = 'Mobile Phone' WHERE PreferredLoginDevice = 'Phone';
UPDATE customer_churn SET PreferedOrderCat = 'Mobile Phone' WHERE PreferedOrderCat = 'Mobile';

/*Standardize payment mode values: Replace "COD" with "Cash on Delivery" and
"CC" with "Credit Card" in the PreferredPaymentMode column.*/

UPDATE customer_churn SET PreferredPaymentMode = 'Cash On Delivery' WHERE PreferredPaymentMode = 'COD';
UPDATE customer_churn SET PreferredPaymentMode = 'Credit Card' WHERE PreferredPaymentMode = 'CC';

-- DATA TRANSFORMATION
-- Column Renaming
-- Rename the column "PreferedOrderCat" to "PreferredOrderCat".
ALTER TABLE customer_churn RENAME COLUMN PreferedOrderCat to PreferredOrderCat;

-- Rename the column "HourSpendOnApp" to "HoursSpentOnApp".
ALTER TABLE customer_churn RENAME COLUMN HourSpendOnApp to HoursSpentOnApp;

-- Creating New Columns
/*Create a new column named ‘ComplaintReceived’ with values "Yes" if the
corresponding value in the ‘Complain’ is 1, and "No" otherwise.*/

ALTER TABLE customer_churn ADD COLUMN ComplaintReceived ENUM('Yes', 'No');
UPDATE customer_churn SET ComplaintReceived = 'Yes' WHERE Complain = 1;
UPDATE customer_churn SET ComplaintReceived = 'No' WHERE Complain = 0;

/*Create a new column named 'ChurnStatus'. Set its value to “Churned” if the
corresponding value in the 'Churn' column is 1, else assign “Active”.*/

ALTER TABLE customer_churn ADD COLUMN ChurnStatus ENUM('Churned', 'Active');
UPDATE customer_churn SET ChurnStatus = 'Churned' WHERE Churn = 1;
UPDATE customer_churn SET ChurnStatus = 'Active' WHERE Churn = 0;

-- Column Dropping:
-- Drop the columns "Churn" and "Complain" from the table.
ALTER TABLE customer_churn DROP COLUMN churn;
ALTER TABLE customer_churn DROP COLUMN Complain;

-- DATA EXPLORATION AND ANALYSIS
-- Retrieve the count of churned and active customers from the dataset.
SELECT COUNT(*) as Customer_Status FROM customer_churn GROUP BY ChurnStatus;

-- Display the average tenure of customers who churned.
SELECT AVG(Tenure) as Avg_ChurnedTenure FROM customer_churn WHERE ChurnStatus = 'Churned';

-- Calculate the total cashback amount earned by customers who churned.

SELECT SUM(CashbackAmount) AS TotalCashback FROM customer_churn
	WHERE ChurnStatus = 'Churned';
    
-- Determine the percentage of churned customers who complained.
SELECT 
    COUNT(*) AS total_churned_customers,
    SUM(ComplaintReceived) AS churnedcustomers_with_complaint,
    (SUM(ComplaintReceived) / COUNT(*)) * 100 AS percentage_of_churned_customers_with_complaint
FROM customer_churn
WHERE ChurnStatus = 'Churned';

-- Find the gender distribution of customers who complained.
SELECT gender, COUNT(ComplaintReceived) as Complains FROM customer_churn
	WHERE ComplaintReceived = 'Yes'
    GROUP BY gender;

-- Identify the city tier with the highest number of churned customers whose preferred order category is Laptop & Accessory.
SELECT 
	CityTier, ChurnStatus, PreferredOrderCat, COUNT(ChurnStatus) AS ChurnedCount 
    FROM customer_churn 
 	WHERE PreferredOrderCat = 'Laptop & Accessory'AND ChurnStatus = 'Churned'
	GROUP BY CityTier 
    ORDER BY ChurnedCount DESC
    LIMIT 1;

-- Identify the most preferred payment mode among active customers.
SELECT 
	PreferredPaymentMode, COUNT(ChurnStatus) AS ActiveCustomer
    FROM customer_churn 
	WHERE ChurnStatus = 'Active'
    GROUP BY PreferredPaymentMode
    ORDER BY ActiveCustomer DESC
    LIMIT 1;

-- List the preferred login device(s) among customers who took more than 10 days since their last order.
SELECT 
	PreferredLoginDevice, COUNT(*) AS DeviceCount
	FROM customer_churn 
	WHERE DaySinceLastOrder > 10
    GROUP BY PreferredLoginDevice
    ORDER BY DeviceCount;

-- List the number of active customers who spent more than 3 hours on the app.
SELECT 
    ChurnStatus,HoursSpentOnApp, COUNT(*) AS ActiveCustomerCount
	FROM customer_churn
	WHERE ChurnStatus = 'Active' AND HoursSpentOnApp > 3
    GROUP BY HoursSpentOnApp;

-- Find the average cashback amount received by customers who spent at least 2 hours on the app.
SELECT 
	TRUNCATE(AVG(CashbackAmount),2) AS Average_CashBackAmount
    FROM customer_churn
	WHERE HoursSpentOnApp >=2;

-- Display the maximum hours spent on the app by customers in each preferred order category.
SELECT 
	PreferredOrderCat, MAX(HoursSpentOnApp) AS Max_hour_Spent
    FROM customer_churn
    GROUP BY PreferredOrderCat;

-- Find the average order amount hike from last year for customers in each marital status category.
SELECT
	MaritalStatus, TRUNCATE(AVG(OrderAmountHikeFromlastYear),2) AS Avg_OrderAmntHike_LastYear
    FROM customer_churn
    GROUP BY MaritalStatus;

-- Calculate the total order amount hike from last year for customers who are single and prefer mobile phones for ordering.
SELECT
	SUM(OrderAmountHikeFromlastYear) AS TotalOrderAmountHike
    FROM customer_churn
    WHERE MaritalStatus = 'Single' AND PreferredLoginDevice = 'Mobile Phone';
    
-- Find the average number of devices registered among customers who used UPI as their preferred payment mode.
SELECT
	PreferredPaymentMode, AVG(NumberOfDeviceRegistered) AS Avg_NoOf_DevRegistered
    FROM customer_churn
    WHERE PreferredPaymentMode = 'UPI';

--  Determine the city tier with the highest number of customers.
SELECT
	CityTier, COUNT(*) AS CustomerCount
    FROM customer_churn
    GROUP BY CityTier
    ORDER BY CustomerCount DESC
    LIMIT 1;

-- Find the marital status of customers with the highest number of addresses.
SELECT
	MaritalStatus, MAX(NumberOfAddress) AS Max_NoOfAddress
    FROM customer_churn
    GROUP BY MaritalStatus
    ORDER BY Max_NoOfAddress DESC 
    LIMIT 1;
    
-- Identify the gender that utilized the highest number of coupons.
SELECT
	gender, SUM(CouponUsed) AS HighestNo_of_coupons
    FROM customer_churn
    GROUP BY gender
    ORDER BY HighestNo_of_coupons DESC
    LIMIT 1;
    
-- List the average satisfaction score in each of the preferred order categories.
SELECT
	PreferredOrderCat, AVG(SatisfactionScore) AS Avg_SatisfactionScore
    FROM customer_churn
    GROUP BY PreferredOrderCat;

-- Calculate the total order count for customers who prefer using credit cards and have the maximum satisfaction score.
SELECT 
    SUM(OrderCount) AS TotalOrderCount
	FROM customer_churn
	WHERE PreferredPaymentMode = 'Credit Card' 
	AND SatisfactionScore = (SELECT MAX(SatisfactionScore) FROM customer_churn);

-- How many customers are there who spent only one hour on the app and days since their last order was more than 5?
SELECT 
    COUNT(*) AS CustomerCount
	FROM customer_churn
	WHERE HoursSpentOnApp = 1 AND DaySinceLastOrder > 5;

-- What is the average satisfaction score of customers who have complained?
SELECT 
	ComplaintReceived, AVG(SatisfactionScore) AS Avg_SatisfactionScore
    FROM customer_churn
    WHERE ComplaintReceived = 'Yes';

-- How many customers are there in each preferred order category?
SELECT
	PreferredOrderCat, COUNT(*) AS No_Of_Customers
    FROM customer_churn
    GROUP BY PreferredOrderCat;
    
-- What is the average cashback amount received by married customers?
SELECT
	MaritalStatus, AVG(CashbackAmount) AS Avg_CashBackAmount
	FROM customer_churn
    WHERE MaritalStatus = 'Married';
    
--  What is the average number of devices registered by customers who are not using Mobile Phone as their preferred login device?
SELECT
	PreferredLoginDevice, AVG(NumberOfDeviceRegistered) AS Avg_NoOfDeviceRegistered
    FROM customer_churn
    WHERE PreferredLoginDevice != 'Mobile Phone' 
    GROUP BY PreferredLoginDevice;

-- List the preferred order category among customers who used more than 5 coupons.
SELECT 
    PreferredOrderCat, COUNT(*) AS CustomerCount
    FROM customer_churn
    WHERE CouponUsed > 5
    GROUP BY PreferredOrderCat
    ORDER BY CustomerCount DESC;

-- List the top 3 preferred order categories with the highest average cashback amount.
SELECT
	PreferredOrderCat, TRUNCATE(AVG(CashbackAmount),2) AS Avg_CashBack
    FROM customer_churn
    GROUP BY PreferredOrderCat
    ORDER BY Avg_CashBack DESC
    LIMIT 3;

-- Find the preferred payment modes of customers whose average tenure is 10 months and have placed more than 500 orders.
SELECT 
	PreferredPaymentMode
	FROM customer_churn
	WHERE OrderCount > 500
	GROUP BY PreferredPaymentMode
	HAVING AVG(Tenure) = 10;

/*Categorize customers based on their distance from the warehouse to home such
as 'Very Close Distance' for distances <=5km, 'Close Distance' for <=10km,
'Moderate Distance' for <=15km, and 'Far Distance' for >15km. Then, display the
churn status breakdown for each distance category.*/

SELECT 
    CASE
        WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
        WHEN WarehouseToHome <= 10 THEN 'Close Distance'
        WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
        ELSE 'Far Distance'
    END AS DistanceCategory, ChurnStatus, COUNT(*) AS CustomerCount
FROM customer_churn
GROUP BY DistanceCategory, ChurnStatus
ORDER BY DistanceCategory, ChurnStatus;

/*List the customer’s order details who are married, live in City Tier-1, and their
order counts are more than the average number of orders placed by all
customers.*/
SELECT *
	FROM customer_churn
WHERE 
	MaritalStatus = 'Married' 
    AND CityTier = 1 AND 
    OrderCount > (SELECT AVG(OrderCount) FROM customer_churn);

-- Create the customer_returns table
CREATE TABLE ecomm.customer_returns (
    ReturnID INT PRIMARY KEY,
    CustomerID INT,
    ReturnDate DATE,
    RefundAmount DECIMAL(10, 2)
);

-- Insert the data into the customer_returns table
INSERT INTO ecomm.customer_returns (ReturnID, CustomerID, ReturnDate, RefundAmount) VALUES
(1001, 50022, '2023-01-01', 2130),
(1002, 50316, '2023-01-23', 2000),
(1003, 51099, '2023-02-14', 2290),
(1004, 52321, '2023-03-08', 2510),
(1005, 52928, '2023-03-20', 3000),
(1006, 53749, '2023-04-17', 1740),
(1007, 54206, '2023-04-21', 3250),
(1008, 54838, '2023-04-30', 1990);

SELECT cr.* , c.*
FROM customer_returns AS cr
JOIN customer_churn c ON cr.CustomerID = c.CustomerID
WHERE c.ChurnStatus = 'Churned'AND c.ComplaintReceived = 'Yes';

