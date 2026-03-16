USE p2__us_household_income;

SELECT *
FROM household_income;

SELECT *
FROM household_income_statistics;

----------------------------------------------------------------------------

-- Data Cleaning

----------------------------------------------------------------------------

----------------------------------------------------------------------------
-- Removing duplicates records
----------------------------------------------------------------------------

-- Finding the duplicate records
--For 'household_income' table
SELECT id, COUNT(id)
FROM household_income
GROUP BY id
HAVING COUNT(id) >= 2 ;

--For 'household_income_statistics' table
SELECT id, COUNT(id)
FROM household_income_statistics
GROUP BY id
HAVING COUNT(id) >= 2 ;

-- Identifying the duplicates and removing them from 'household_income' table
WITH 
CTE1 AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY id) AS rn
    FROM household_income
) ,
CTE2 AS (
    SELECT row_id, id, rn
    FROM CTE1
    WHERE rn >= 2
)
DELETE
FROM household_income
WHERE row_id IN (
    SELECT row_id
    FROM CTE2
) ;


----------------------------------------------------------------------------
-- Fixing data quality issues
----------------------------------------------------------------------------

SELECT *
FROM household_income;

-- Data cleaning for 'State_Name' column
SELECT DISTINCT State_Name
FROM household_income ;

UPDATE household_income
SET State_Name = CONCAT(
    UPPER(LEFT(State_Name, 1)),
    LOWER(SUBSTRING(State_Name, 2))
) ;

UPDATE household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'Georia' ;

-- Data cleaning for 'State_ab' column
SELECT DISTINCT State_ab
FROM household_income ;

UPDATE household_income
SET State_ab = UPPER(State_ab) ;

-- Data cleaning for 'County' column
SELECT DISTINCT County
FROM household_income ;

