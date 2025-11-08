# 💄 Beauty Brand Sales & Marketing Analysis – SQL + Power BI Project
An end-to-end data analysis project combining SQL and Power BI to analyze brand performance, revenue growth, and campaign ROI across multiple beauty brands.

---

## 📊 Overview
This project provides insights into beauty brand sales and marketing performance by integrating **SQL-based data analysis** and **Power BI visualization**.  
It answers business questions like:
- Which brands and campaigns drive the highest revenue?  
- How ROI and conversion rates vary across channels?  
- Which products perform best within each brand?  
- How revenue has changed year-over-year?

---

## 🧰 Tools & Technologies
- **SQL Server** – Data extraction, transformation, and KPI calculations  
- **Power BI Desktop** – Dashboard visualization and storytelling  
- **Excel** – Raw dataset and data cleaning  
- **GitHub** – Project documentation and version control  

---

---

## 🧾 Dataset Information
The dataset (`Beauty_Brands.xlsx`) includes:
- Brand name, product name, and launch year  
- Campaign spend, total revenue, and ROI%  
- Campaign channel (E-commerce, Retail, Marketplace, etc.)  
- Conversion rate and ratings per product  

---

## 🧠 SQL Features & Logic
Key SQL operations used:
- `GROUP BY` and `SUM()` for brand-wise KPIs  
- `CTE` and `RANK()` for top-performing campaigns  
- `WINDOW FUNCTIONS` for running totals and revenue rank  
- `Subqueries` for brand-level campaign performance  

**Example Query**
```sql
SELECT Brand_Name,
       SUM(Total_Revenue_INR) AS TotalRevenue,
       SUM(Total_Units_Sold) AS TotalUnits,
       COUNT(Product_ID) AS ProductCount
FROM dbo.Beauty_Brands
GROUP BY Brand_Name
ORDER BY TotalRevenue DESC;

### 🌐 Dashboard Preview
You can explore this project on my GitHub:  
👉 [Beauty Brand Analysis Project – SQL & Power BI](https://github.com/tannusingh05/Beauty-Brand-Analysis-Project-SQL-Power-BI-)


🎯 Key Insights

Kay Beauty leads in total revenue (~₹0.4bn)

Forest Essentials and Nykaa show consistent growth since 2020

E-commerce campaigns deliver the highest ROI

Top-performing years: 2023–2025

Average product rating: 4.29 / 5
