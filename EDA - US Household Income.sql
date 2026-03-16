USE p2__us_household_income;

-- Creating a temporary table by joing the two table & getting the relevant columns
CREATE TEMPORARY TABLE h_income
SELECT
        t1.State_Name,
        t1.State_ab,
        t1.County,
        t1.City,
        t1.Place,
        t1.Type,
        t1.Zip_Code,
        t1.Area_Code,
        t2.Mean,
        t2.Median,
        t2.Stdev
FROM household_income t1 INNER JOIN household_income_statistics t2
    ON t1.id = t2.id
WHERE t2.Mean != 0 ;

-- hecking the table
SELECT *
FROM h_income ;

-- Adding a primary key
ALTER TABLE h_income
ADD COLUMN row_id INT AUTO_INCREMENT PRIMARY KEY ;

-- Bring the primary key column to 1st column position
ALTER TABLE h_income
MODIFY COLUMN row_id INT FIRST ;

----------------------------------------------------------------------------
-- Finding some insights
----------------------------------------------------------------------------

-- Top 10 states with highest avg mean income
SELECT State_Name, AVG(Mean) AS avg_mean_income
FROM h_income
GROUP BY State_Name
ORDER BY AVG(Mean) DESC 
LIMIT 10 ;

-- Top 10 States with most income inequality
SELECT State_Name, AVG(Mean), AVG(Stdev)
FROM h_income
GROUP BY State_Name
ORDER BY AVG(Stdev) DESC
LIMIT 10 ;