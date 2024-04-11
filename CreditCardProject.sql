CREATE DATABASE IF NOT EXISTS CChabits;
USE CChabits;
SET SQL_SAFE_UPDATES = 0 ;




------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ccspending(
sno INT UNIQUE NOT NULL,
city VARCHAR(50) NOT NULL,
date DATE NOT NULL,
card_type VARCHAR(50) NOT NULL,
expense_type VARCHAR(50) NOT NULL,
gender CHAR(1) NOT NULL,
amount FLOAT NOT NULL);



--- Adding monthname column ---
------------------------------------------------------------------------------------------------------
ALTER TABLE ccspending
ADD COLUMN month VARCHAR(50) NOT NULL;

UPDATE ccspending
SET month = MONTHNAME(date);
------------------------------------------------------------------------------------------------------




--- Adding Dayname column ---
------------------------------------------------------------------------------------------------------
ALTER TABLE ccspending
ADD COLUMN day VARCHAR(50) NOT NULL;

UPDATE ccspending
SET day = DAYNAME(date);
------------------------------------------------------------------------------------------------------




--- Adding Month Date column ---
------------------------------------------------------------------------------------------------------
ALTER TABLE ccspending
ADD COLUMN month_date VARCHAR(50) NOT NULL;

UPDATE ccspending
SET month_date = DAY(date);
------------------------------------------------------------------------------------------------------




--- Number of rows in Table---


SELECT COUNT(*)
FROM ccspending;
------------------------------------------------------------------------------------------------------




--- Table for analysis ---


SELECT *
FROM ccspending;
------------------------------------------------------------------------------------------------------




--- 1) Which city has the most credit card transactions? ---


SELECT city,
count(city) as Transactions
FROM ccspending
GROUP BY city
ORDER BY count(city) DESC
LIMIT 1;
-- Bengaluru has the most credit card transactions
-- Fazlika has the least credit card transactions which is just 1
------------------------------------------------------------------------------------------------------




--- 2) Which gender is making more Credit Card transactions? ---


SELECT gender,
count(gender) as Transactions
FROM ccspending
GROUP BY gender
ORDER BY count(gender) DESC
;
-- Females are making more Credit Card transactions
------------------------------------------------------------------------------------------------------




--- 3) Which city has the largest total credit card transaction amount? ---


SELECT city,
SUM(amount) as Total_Transaction
FROM ccspending
GROUP BY city
ORDER BY SUM(amount) DESC
; 
-- Greater Mumbai has the most total transaction amount 
-- Fazlika has the least total transaction amount
------------------------------------------------------------------------------------------------------

 

 
 --- 4) Which type of Credit Card is the most used? ---
 
 
 SELECT card_type,
 count(card_type) as No_of_Cards
 FROM ccspending
 GROUP BY card_type
 ORDER BY NO_of_Cards DESC
 ;
 -- Silver Credit Card is the most used
------------------------------------------------------------------------------------------------------

 

 
 --- 5) For what kind of expense is the Credit Card mostly being used? ---
 
 
 SELECT expense_type as Expense,
 count(expense_type) as No_of_Transactions
 FROM ccspending
 GROUP BY Expense
 ORDER BY No_of_Transactions DESC;
 -- Most used for food
 -- Least used for travel
 -----------------------------------------------------------------------------------------------------

 
 
 
--- 6) What kind of expense has the most total transactional value? ---
  
  
   SELECT expense_type as EXPENSE,
   sum(amount) AS AMOUNT
   FROM ccspending
   GROUP BY EXPENSE
   ORDER BY AMOUNT DESC
   ;
   -- Bill payments have the most total value 
  ----------------------------------------------------------------------------------------------------
  

  
  
--- 7) How many transactions are made each month? ---
  
  
  SELECT month AS MONTH,
  COUNT(month) AS TRANSACTIONS
  FROM ccspending
  GROUP BY MONTH
  ORDER BY TRANSACTIONS DESC
  ;
  -- January has the most amount of transactions made
  -- June has the least amount of transactions made
  ----------------------------------------------------------------------------------------------------
  
  
  
--- 8) On what day people are spending the most on food via Credit card? ---
  
  
  SELECT day,
  COUNT(expense_type) AS TRANSACTIONS,
  expense_type
  FROM ccspending
  GROUP by day,expense_type
  ORDER BY TRANSACTIONS DESC
  ;
  -- People spend the most on food on Sunday
  -- People spend the least on food on Friday
  ----------------------------------------------------------------------------------------------------
  
  
  
  
--- 9) On which date the most transactions are being made? ---
  
  
  SELECT month_date as DATE,
  COUNT(month_date) as TRANSACTIONS
  FROM ccspending
  GROUP BY month_date
  ORDER BY TRANSACTIONS DESC
  LIMIT 3
  ;
  -- Most amount of transactions are made on 6
  -- Least amount of transactions are made on 31
  ----------------------------------------------------------------------------------------------------
  
  
  
  
--- 10) How many Distinct cities are in the data? ---
  
  
  SELECT COUNT(city)
  FROM (SELECT DISTINCT CITY FROM ccspending) AS CC;
  -- There are 986 distinct cities in the data
  ----------------------------------------------------------------------------------------------------
  
  
  
  
--- 11) Top spender of each expense type ---
  
  SELECT city,
  COUNT(expense_type) AS TRANSACTIONS,
  expense_type
  FROM ccspending
  GROUP BY city,expense_type
  ORDER BY TRANSACTIONS DESC
  ;
  -- Bengaluru has the most FOOD type transactions
  -- Delhi has the most FUEL type transactions
  -- Bengaluru has the most BILL type transactions
  -- Greater Mumbai has the most GROCERY type transacations
  -- Bengaluru hast the most ENTERTAINMENT type transactions
  -- Jaipur has the most TRAVEL type transactions
  ----------------------------------------------------------------------------------------------------
  