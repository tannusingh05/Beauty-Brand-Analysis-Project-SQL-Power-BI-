SELECT DB_NAME() AS CurrentDatabase;


-- View first 10 rows
SELECT TOP 10 *
FROM dbo.Beauty_Brands;

-- Total rows in dataset
SELECT COUNT(*) AS TotalRows
FROM dbo.Beauty_Brands;

-- Distinct brands
SELECT DISTINCT Brand_Name
FROM dbo.Beauty_Brands;

-- Count of products per brand
SELECT Brand_Name, COUNT(*) AS ProductCount
FROM dbo.Beauty_Brands
GROUP BY Brand_Name
ORDER BY ProductCount DESC;

--Revenue & Sales Analysis. This will directly tie to the business problem — 
--figuring out which products and brands are actually performing well.

--a) Total Revenue by Brand
SELECT 
    Brand_Name,
    SUM(Total_Revenue_INR) AS TotalRevenue,
    SUM(Total_Units_Sold) AS TotalUnits,
    COUNT(Product_ID) AS ProductCount
FROM dbo.Beauty_Brands
GROUP BY Brand_Name
ORDER BY TotalRevenue DESC;
--Rank Products by Revenue within each Brand
WITH RankedProducts AS (
    SELECT 
        Brand_Name,
        Product_Name,
        Total_Revenue_INR,
        RANK() OVER (PARTITION BY Brand_Name ORDER BY Total_Revenue_INR DESC) AS RevenueRank
    FROM dbo.Beauty_Brands
)
SELECT *
FROM RankedProducts
WHERE RevenueRank <= 5
ORDER BY Brand_Name, RevenueRank;

--Running Total of Revenue by Launch Year per brand

SELECT 
    Brand_Name,
    Launch_Year,
    SUM(Total_Revenue_INR) AS YearlyRevenue,
    SUM(SUM(Total_Revenue_INR)) OVER (PARTITION BY Brand_Name ORDER BY Launch_Year) AS RunningTotalRevenue
FROM dbo.Beauty_Brands
GROUP BY Brand_Name, Launch_Year
ORDER BY Brand_Name, Launch_Year;

--Each Product’s Contribution % to Total Revenue
SELECT 
    Product_Name,
    Brand_Name,
    Total_Revenue_INR,
    ROUND(
        100.0 * Total_Revenue_INR / SUM(Total_Revenue_INR) OVER (), 2
    ) AS RevenuePercent
FROM dbo.Beauty_Brands
ORDER BY RevenuePercent DESC;




--Total Campaign Spend and Revenue by Campaign Channel
SELECT 
    Campaign_Channel,
    SUM(Campaign_Spend_INR) AS TotalSpend,
    SUM(Total_Revenue_INR) AS TotalRevenue,
    ROUND(100.0 * SUM(Total_Revenue_INR) / SUM(Campaign_Spend_INR), 2) AS ROI_Percent
FROM dbo.Beauty_Brands
GROUP BY Campaign_Channel
ORDER BY ROI_Percent DESC;

--Top Campaign per Brand (using Subquery)
SELECT 
    Brand_Name,
    Top_Campaign,
    SUM(Total_Revenue_INR) AS CampaignRevenue
FROM dbo.Beauty_Brands b
WHERE Top_Campaign IN (
    SELECT TOP 1 Top_Campaign
    FROM dbo.Beauty_Brands
    WHERE Brand_Name = b.Brand_Name
    GROUP BY Top_Campaign
    ORDER BY SUM(Total_Revenue_INR) DESC
)
GROUP BY Brand_Name, Top_Campaign
ORDER BY Brand_Name;
--Campaign Performance with Conversion Rate Ranking (using CTE + Window Function)
WITH CampaignRank AS (
    SELECT 
        Brand_Name,
        Top_Campaign,
        Campaign_Channel,
        [Conversion_Rate_%] AS ConversionRate,
        RANK() OVER (PARTITION BY Brand_Name ORDER BY [Conversion_Rate_%] DESC) AS RankByConversion
    FROM dbo.Beauty_Brands
)
SELECT *
FROM CampaignRank
WHERE RankByConversion = 1
ORDER BY Brand_Name;







