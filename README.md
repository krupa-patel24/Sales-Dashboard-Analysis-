# 📊 Superstore Sales Dashboard — End-to-End Data Analytics Project

![Dashboard Preview](dashboard/screenshots/page1_overview.png)

## 🔍 Project Overview

This is a complete end-to-end data analytics project built on the popular **Superstore Sales Dataset** containing **9,994 sales transactions from 2014 to 2017** across the United States.

The goal of this project is to analyze business performance across sales, profit, regions, customer segments, and products — and present the findings through an interactive Power BI dashboard.

This project covers the **full data analytics workflow:**
> Raw Data → Python EDA → SQL Analysis → Power BI Dashboard

---

## 🛠️ Tools & Technologies Used

| Tool | Purpose |
|---|---|
| **Python** | Exploratory Data Analysis (EDA) |
| **Pandas** | Data cleaning & manipulation |
| **Matplotlib & Seaborn** | Data visualization (14 charts) |
| **MySQL** | Business SQL queries & analysis |
| **Power BI Desktop** | Interactive dashboard (4 pages) |
| **Jupyter Notebook** | EDA documentation |
| **GitHub** | Version control & portfolio |

---

## 📂 Project Structure

```
Sales-Dashboard-Analysis/
│
├── data/
│   └── superstore_clean.csv          ← Cleaned dataset (9,994 rows)
│
├── notebooks/
│   └── sales_eda.ipynb               ← Complete Python EDA (14 charts)
│
├── sql/
│   └── superstore_analysis.sql       ← 15 business SQL queries
│
├── dashboard/
│   ├── superstore_dashboard.pbix     ← Power BI Dashboard file
│   └── screenshots/
│       ├── page1_overview.png
│       ├── page2_sales_trends.png
│       ├── page3_regional.png
│       └── page4_products.png
│
└── README.md
```

---

## 📊 Dashboard Pages

### 🖥️ Page 1 — Overview
![Overview](dashboard/screenshots/page1_overview.png)

**Visuals:**
- KPI Cards — Total Revenue, Total Profit, Total Orders, Profit Margin %
- Regional Sales Performance (Bar Chart)
- Sales Split by Category (Donut Chart)
- Customer Segment Distribution (Donut Chart)
- Slicers — Year, Region, Category, Segment

---

### 📈 Page 2 — Sales Trends
![Sales Trends](dashboard/screenshots/page2_sales_trends.png)

**Visuals:**
- Monthly Sales Trend 2014–2017 (Line Chart)
- Yearly Sales vs Profit Growth (Column Chart)
- Sales Performance by Quarter (Bar Chart)
- Monthly Sales by Category & Profit Trend (Line + Stacked Column)

---

### 🗺️ Page 3 — Regional Analysis
![Regional Analysis](dashboard/screenshots/page3_regional.png)

**Visuals:**
- Sales & Profit by Region (Column Chart)
- Top 10 States by Revenue (Bar Chart)
- Profit Margin % by Region (Bar Chart)
- Category Sales Breakdown by Region (Stacked Bar)
- Does More Discount = Less Profit? (Scatter Plot)

---

### 📦 Page 4 — Product Analysis
![Product Analysis](dashboard/screenshots/page4_products.png)

**Visuals:**
- Top 10 Products by Revenue (Bar Chart)
- Bottom 10 Loss Making Products (Bar Chart)
- Sub-Category Profit Analysis — Red = Loss, Green = Profit (Bar Chart)
- Discount vs Profit by Sub-Category (Scatter Plot)
- Sales Matrix: Category × Region (Matrix Visual)

---

## 🐍 Phase 1 — Python EDA

Complete exploratory data analysis done in Jupyter Notebook covering:

| Analysis | Description |
|---|---|
| Data Cleaning | Fixed dates, removed duplicates, handled nulls |
| Business KPIs | Total Sales, Profit, Orders, Customers, Margin |
| Sales Trends | Monthly, Yearly and Quarterly trends |
| Category Analysis | Sales & Profit by Category and Sub-Category |
| Regional Analysis | Performance across 4 regions and Top 10 States |
| Segment Analysis | Consumer vs Corporate vs Home Office |
| Discount Impact | How discounts affect profit (scatter + buckets) |
| Shipping Analysis | Ship mode usage and delivery days |
| Product Analysis | Top sellers and biggest loss makers |
| Correlation Heatmap | Relationships between key numeric columns |

**14 charts generated and saved as PNG files.**

---

## 🗄️ Phase 2 — SQL Analysis

**15 business-focused SQL queries** written in MySQL covering:

| # | Query | Business Question |
|---|---|---|
| 1 | Business KPIs | What are our headline numbers? |
| 2 | Yearly Growth | Are we growing year over year? |
| 3 | Monthly Trend | Which months have peak sales? |
| 4 | Category Performance | Which category is most profitable? |
| 5 | Sub-Category Loss Makers | Which sub-categories lose money? |
| 6 | Regional Performance | Which region performs best? |
| 7 | Top 10 States | Which states generate most revenue? |
| 8 | Customer Segments | Who buys the most — Consumer or Corporate? |
| 9 | Top 10 Customers | Who are our most valuable customers? |
| 10 | Discount Impact | Does giving more discount hurt profit? |
| 11 | Shipping Analysis | Which shipping mode is most preferred? |
| 12 | Top Products | Which products sell the most? |
| 13 | Loss Making Products | Which products should we discontinue? |
| 14 | Quarterly Performance | Which quarter is best every year? |
| 15 | Customer Loyalty | How many customers come back? |

**Advanced SQL skills used:** Window Functions (LAG, OVER), CASE WHEN, Subqueries, DATEDIFF, Top-N filtering, Conditional aggregations.

---

## 💡 Key Business Insights

1. **West region** leads with the highest total sales — contributing ~32% of total revenue.
2. **Tables and Bookcases** sub-categories are loss-making despite high sales volume — discount policy needs revision.
3. Orders with **discounts above 30%** consistently result in **negative profit** across all categories.
4. **Q4 (October–December)** shows peak sales every year — strong seasonal pattern ideal for inventory planning.
5. **Technology** is the most profitable category with the highest profit margin.
6. **Consumer segment** drives 51% of total orders but Corporate has higher average order value.
7. **Central region** gives the highest average discount (24%) and has the lowest profit margin — a direct correlation.
8. **Standard Class** shipping is used in 60%+ of orders — fastest modes are heavily underutilized.

---

## 🚀 How to Run This Project

### Python EDA
```bash
# Install required libraries
pip install pandas numpy matplotlib seaborn jupyter

# Open notebook
jupyter notebook notebooks/sales_eda.ipynb
```

### SQL Analysis
```sql
-- Run in MySQL Workbench
-- 1. Create database
CREATE DATABASE superstore_db;
USE superstore_db;

-- 2. Import superstore_clean.csv using Table Data Import Wizard
-- 3. Open and run sql/superstore_analysis.sql
```

### Power BI Dashboard
```
1. Download Power BI Desktop (free) from microsoft.com
2. Open dashboard/superstore_dashboard.pbix
3. Update data source to your local MySQL connection
4. Refresh data and explore!
```

---

## 📈 Dataset Information

| Detail | Info |
|---|---|
| **Source** | Kaggle — Superstore Sales Dataset |
| **Records** | 9,994 rows |
| **Columns** | 21 columns |
| **Time Period** | January 2014 — December 2017 |
| **Geography** | United States (49 states, 4 regions) |
| **Categories** | Furniture, Office Supplies, Technology |

---

## 💡 Key Business Insights

1. **West region** leads with the highest total sales — contributing ~32% of total revenue.
2. **Tables and Bookcases** sub-categories are loss-making despite high sales volume — discount policy needs revision.
3. Orders with **discounts above 30%** consistently result in **negative profit** across all categories.
4. **Q4 (October–December)** shows peak sales every year — strong seasonal pattern ideal for inventory planning.
5. **Technology** is the most profitable category with the highest profit margin.
6. **Consumer segment** drives 51% of total orders but Corporate has higher average order value.
7. **Central region** gives the highest average discount (24%) and has the lowest profit margin — a direct correlation.
8. **Standard Class** shipping is used in 60%+ of orders — fastest modes are heavily underutilized.

---

## 👩‍💻 About Me

**Krupa Patel** — Data Analyst

I specialize in turning raw data into actionable business insights using Python, SQL, and Power BI. This project demonstrates my ability to handle the complete analytics pipeline — from data cleaning and exploratory analysis to SQL querying and interactive dashboard creation.

📧 **Email:** your.email@gmail.com  
🔗 **LinkedIn:** linkedin.com/in/yourprofile  
💼 **Upwork:** upwork.com/freelancers/yourprofile  
🐙 **GitHub:** github.com/krupa-patel24  

---

## 📌 Other Projects

- 🛒 [Amazon Product Analysis](https://github.com/krupa-patel24/Amazon-Product-Analysis)
- 📉 [Customer Churn Analysis](https://github.com/krupa-patel24/Customer-Churn-Analysis-)

---

*⭐ If you found this project helpful, please give it a star on GitHub!*
