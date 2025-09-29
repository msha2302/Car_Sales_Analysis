# Car_Sales_Analysis
Data analysis project on car sales using SQL and Power BI  

![SQL](https://img.shields.io/badge/SQL-Data%20Cleaning-blue?logo=postgresql)
![Power BI](https://img.shields.io/badge/PowerBI-Dashboard-yellow?logo=powerbi)
![Excel](https://img.shields.io/badge/Excel-Data%20Source-green?logo=microsoft-excel)
![ETL](https://img.shields.io/badge/ETL-Process-orange)
![Analytics](https://img.shields.io/badge/Data-Analytics-purple)

---

## 📑 Table of Contents
- [Problem Statement](#problem-statement)  
- [Business Objective](#business-objective)  
- [ETL Procedure](#etl-procedure)  
- [SQL Data Modelling](#sql-data-modelling)  
- [Power BI Dashboard](#power-bi-dashboard)
- [Screenshots](#screenshots)   
- [Outcomes & Insights](#outcomes--insights)  
- [Business Recommendations](#business-recommendations)  
- [Key Takeaways](#key-takeaways)  

---

## Problem Statement
The automobile industry is highly competitive, with multiple brands and models competing for market share. Business leaders need to understand which brands and models drive sales, how performance varies across regions, and how sales evolve over time. While the dataset provides a record of historical sales, it does not directly reveal which brands and models dominate the market, how sales vary by region, or how trends evolve year-over-year.

---

## Business Objective
The objective of this project is to leverage the car sales dataset to deliver actionable insights that help business leaders make informed decisions. Specifically, the decision-makers need insights into:

1. **Identifying Top Performers** → Best-selling brands and models  
2. **Analyzing Regional Trends** → Strong vs. underperforming markets  
3. **Tracking Sales Over Time** → Yearly and seasonal performance  
4. **Understanding Revenue Drivers** → Contribution of premium vs. entry-level models  
5. **Enabling Data-Driven Decisions** → Creating an interactive dashboard for stakeholders  

---

## ETL Procedure
**1. Extract**  
- Dataset sourced in Excel/CSV format  

**2. Transform (via SQL):**  
- Removed nulls and duplicates  
- Standardized dates, derived Year, Quarter, and Month  
- Cleaned brand and region values  
- Aggregated sales metrics for analysis  

**3. Load**  
- Final structured dataset loaded into Power BI for reporting and dashboard creation  

---

## SQL Data Modelling
SQL was used to clean, structure, and prepare the dataset. Key techniques included:

1. **Joins** – merged tables for consolidated reporting  
2. **CTEs (Common Table Expressions)** – modular, step-wise transformations  
3. **Window Functions** – `RANK()`, `ROW_NUMBER()` for ranking top brands/models  
4. **Aggregations** – `SUM`, `AVG`, `COUNT` to compute sales metrics  
5. **Date Dimension** – enabled time-series reporting in Power BI  

---

## Power BI Dashboard
The dashboard highlights business-critical insights using:

1. **Slicers & Filters** → Year, brand, region  
2. **KPI Cards** → Revenue, units sold, average price  
3. **Bar & Column Charts** → Brand/model performance  
4. **Line Charts** → Yearly and seasonal sales trends  
5. **Maps** → Regional sales performance  
6. **Drill-through Pages** → Brand/model-level deep dive  

---
## Screenshots

### 📊 Dashboard Overview
![Dashboard Overview](Snapshots/Dashboard_overview.PNG)

### 📈 Brand & Model Performance
![Brand Performance](Snapshots/Brand_rep.PNG)

### 🌍 Regional Sales
![Regional Sales](Snapshots/dealer_rep.PNG)

### 📆 Sales Trends
![Sales Trends](Snapshots/Sales_rep.PNG)

---

## Outcomes & Insights

### 1. Top Brands & Models
- Chevrolet, Ford, and Dodge remain the biggest drivers of revenue.
- A handful of brands dominate market share  
- Flagship models generate most revenue, while entry-level models drive volume  

### 2. Sales Trends
- Year-over-year growth with clear seasonal peaks in certain quarters  
- Market dips align with broader economic cycles
- Growth of 23.6% YoY → Market expansion or improved dealership performance.

### 3. Regional Performance
- Sales are concentrated in specific regions (Austin & Janesville dominate)
- High sales concentration in urban/high-income regions  
- Untapped opportunities in emerging regions  

### 4. Revenue Drivers
- Premium models deliver higher margins despite lower unit sales  
- Entry-level models act as customer acquisition drivers  

---

## Business Recommendations

### 1. Brand Strategy
- Increase marketing for the top 3 brands to consolidate leadership  
- Reassess underperforming models for redesign or discontinuation  

### 2. Regional Strategy
- Expand dealer networks in emerging regions with high growth potential  
- Customize offerings based on local preferences (SUVs vs. compact cars)  

### 3. Revenue Optimization
- Prioritize premium models for profitability  
- Use entry-level models as market entry points, with cross-selling opportunities  

### 4. Operational Strategy
- Align production with seasonal demand peaks  
- Explore predictive modeling for future sales forecasting  


---

## Key Takeaways

1. Built a complete **ETL pipeline**: raw dataset → SQL transformations → Power BI dashboards  
2. Applied **advanced SQL** (CTEs, joins, window functions, date dimensioning)  
3. Designed **interactive dashboards** for business stakeholders  
4. Translated raw data into **strategic recommendations** for growth  
