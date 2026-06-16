-- ============================================================
--   SUPERSTORE SALES — SQL ANALYSIS
--   Tool     : MySQL 8.0
--   Database : superstore_db
--   Author   : Krupa Patel
--   Purpose  : End-to-end business analysis using SQL to
--              uncover sales trends, profit drivers, customer
--              behaviour and operational inefficiencies.
-- ============================================================

USE superstore_db;


-- ============================================================
--  1 — TOTAL BUSINESS KPIs
-- ------------------------------------------------------------
-- WHAT  : Calculates the most important headline numbers for
--         the entire business in a single query.
-- WHY   : Every business owner wants to see Total Sales,
--         Total Profit, Number of Orders and Average Order
--         Value at a glance before diving deeper. This is
--         the first slide in any executive dashboard.
-- SKILL : Aggregate functions (SUM, COUNT, AVG), ROUND,
--         DISTINCT, calculated KPI columns.
-- ============================================================

SELECT
    COUNT(DISTINCT Order_ID)                            AS Total_Orders,
    COUNT(DISTINCT Customer_ID)                         AS Total_Customers,
    ROUND(SUM(Sales), 2)                                AS Total_Sales,
    ROUND(SUM(Profit), 2)                               AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)            AS Profit_Margin_Pct,
    ROUND(AVG(Discount) * 100, 2)                       AS Avg_Discount_Pct,
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2)     AS Avg_Order_Value
FROM superstore;


-- ============================================================
--  2 — YEARLY SALES & PROFIT GROWTH
-- ------------------------------------------------------------
-- WHAT  : Shows total sales and profit for each year, plus
--         the Year-over-Year (YoY) growth percentage.
-- WHY   : Clients need to know if their business is growing
--         or shrinking year by year. YoY growth % is a key
--         metric used in every business review meeting.
--         A negative YoY growth is a red flag that needs
--         immediate attention.
-- SKILL : Window functions (LAG), GROUP BY, YEAR(),
--         percentage change calculation, ORDER BY.
-- ============================================================

SELECT
    YEAR(Order_Date)                                            AS Year,
    ROUND(SUM(Sales), 2)                                        AS Total_Sales,
    ROUND(SUM(Profit), 2)                                       AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)                    AS Profit_Margin_Pct,
    ROUND(
        (SUM(Sales) - LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date)))
        / LAG(SUM(Sales)) OVER (ORDER BY YEAR(Order_Date)) * 100
    , 2)                                                         AS YoY_Growth_Pct
FROM superstore
GROUP BY YEAR(Order_Date)
ORDER BY Year;


-- ============================================================
--  3 — MONTHLY SALES TREND
-- ------------------------------------------------------------
-- WHAT  : Breaks down sales and profit for every single
--         month across all years.
-- WHY   : Monthly trends reveal seasonal patterns — for
--         example, which months have peak sales and which
--         are slow. Businesses use this to plan inventory,
--         marketing campaigns and staffing. If sales always
--         spike in November, the client knows to prepare
--         stock in October.
-- SKILL : YEAR(), MONTH(), MONTHNAME(), multi-column
--         GROUP BY, chronological ORDER BY.
-- ============================================================

SELECT
    YEAR(Order_Date)             AS Year,
    MONTH(Order_Date)            AS Month_Num,
    MONTHNAME(Order_Date)        AS Month_Name,
    ROUND(SUM(Sales), 2)         AS Total_Sales,
    ROUND(SUM(Profit), 2)        AS Total_Profit,
    COUNT(DISTINCT Order_ID)     AS Total_Orders
FROM superstore
GROUP BY YEAR(Order_Date), MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY Year, Month_Num;


-- ============================================================
--  4 — CATEGORY PERFORMANCE
-- ------------------------------------------------------------
-- WHAT  : Compares the three product categories —
--         Furniture, Office Supplies and Technology —
--         on Sales, Profit, Orders and Profit Margin.
-- WHY   : Not every product category is equally profitable.
--         A category can have high sales but low or even
--         negative profit. This query helps the business
--         decide where to invest more and where to cut back.
--         For example, if Furniture has low margin, the
--         client might reduce its discount or discontinue
--         certain products.
-- SKILL : GROUP BY, aggregate functions, profit margin
--         formula, ORDER BY DESC.
-- ============================================================

SELECT
    Category,
    ROUND(SUM(Sales), 2)                        AS Total_Sales,
    ROUND(SUM(Profit), 2)                        AS Total_Profit,
    COUNT(DISTINCT Order_ID)                     AS Total_Orders,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)     AS Profit_Margin_Pct,
    ROUND(AVG(Discount) * 100, 2)                AS Avg_Discount_Pct
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;


-- ============================================================
--  5 — SUB-CATEGORY DEEP DIVE (LOSS MAKERS!)
-- ------------------------------------------------------------
-- WHAT  : Drills deeper than categories to show performance
--         at sub-category level. Flags each sub-category as
--         LOSS, LOW or GOOD using a performance label.
-- WHY   : A category can look profitable overall but hide
--         loss-making sub-categories inside it. For example,
--         Furniture looks average but Tables sub-category
--         is deeply in loss. This query exposes those hidden
--         problems. The CASE flag makes it very easy for a
--         non-technical manager to spot problems instantly.
-- SKILL : Nested GROUP BY, CASE WHEN conditional logic,
--         performance flagging, ASC sort to show losses
--         at the top.
-- ============================================================

SELECT
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2)                        AS Total_Sales,
    ROUND(SUM(Profit), 2)                        AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)     AS Profit_Margin_Pct,
    COUNT(DISTINCT Order_ID)                     AS Total_Orders,
    CASE
        WHEN SUM(Profit) < 0     THEN 'LOSS'
        WHEN SUM(Profit) < 5000  THEN 'LOW'
        ELSE                          'GOOD'
    END                                          AS Performance_Flag
FROM superstore
GROUP BY Category, Sub_Category
ORDER BY Total_Profit ASC;


-- ============================================================
--  6 — REGIONAL PERFORMANCE
-- ------------------------------------------------------------
-- WHAT  : Compares all 4 regions — West, East, Central
--         and South — across Sales, Profit, Orders,
--         Customers and Average Order Value.
-- WHY   : Regional analysis helps a business understand
--         which geography is driving growth and which is
--         underperforming. If the West region has the
--         highest sales but Central has the best margin,
--         the client can focus marketing spend differently
--         in each region. This is critical for companies
--         planning regional expansion.
-- SKILL : GROUP BY Region, multiple aggregations, average
--         order value calculation, ORDER BY.
-- ============================================================

SELECT
    Region,
    ROUND(SUM(Sales), 2)                            AS Total_Sales,
    ROUND(SUM(Profit), 2)                            AS Total_Profit,
    COUNT(DISTINCT Order_ID)                         AS Total_Orders,
    COUNT(DISTINCT Customer_ID)                      AS Total_Customers,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)         AS Profit_Margin_Pct,
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2)  AS Avg_Order_Value
FROM superstore
GROUP BY Region
ORDER BY Total_Sales DESC;


-- ============================================================
--  7 — TOP 10 STATES BY SALES
-- ------------------------------------------------------------
-- WHAT  : Ranks the top 10 best-performing states by
--         total sales revenue.
-- WHY   : State-level data is more actionable than regional
--         data. A client running ads or planning a warehouse
--         needs to know exactly which states bring the most
--         revenue. For example, if California contributes
--         20% of total sales, it deserves more marketing
--         budget than a low-performing state.
-- SKILL : GROUP BY State, ORDER BY DESC, LIMIT for
--         top-N analysis, profit margin formula.
-- ============================================================

SELECT
    State,
    Region,
    ROUND(SUM(Sales), 2)                        AS Total_Sales,
    ROUND(SUM(Profit), 2)                        AS Total_Profit,
    COUNT(DISTINCT Order_ID)                     AS Total_Orders,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)     AS Profit_Margin_Pct
FROM superstore
GROUP BY State, Region
ORDER BY Total_Sales DESC
LIMIT 10;


-- ============================================================
--  8 — CUSTOMER SEGMENT ANALYSIS
-- ------------------------------------------------------------
-- WHAT  : Compares three customer types — Consumer,
--         Corporate and Home Office — on revenue, profit
--         and average order value.
-- WHY   : Different customer segments have different buying
--         habits and profitability. Corporate clients might
--         order less frequently but spend more per order.
--         Consumer segment might have the most orders but
--         lowest margins due to higher discounts. This
--         insight helps the business decide which segment
--         to target in its next marketing campaign.
-- SKILL : GROUP BY Segment, DISTINCT counts, average
--         order value, profit margin, ORDER BY.
-- ============================================================

SELECT
    Segment,
    COUNT(DISTINCT Customer_ID)                      AS Total_Customers,
    COUNT(DISTINCT Order_ID)                         AS Total_Orders,
    ROUND(SUM(Sales), 2)                             AS Total_Sales,
    ROUND(SUM(Profit), 2)                            AS Total_Profit,
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2)  AS Avg_Order_Value,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)         AS Profit_Margin_Pct
FROM superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;


-- ============================================================
--  9 — TOP 10 CUSTOMERS BY REVENUE
-- ------------------------------------------------------------
-- WHAT  : Identifies the top 10 highest-spending customers
--         with their total sales, profit and order count.
-- WHY   : In most businesses, 20% of customers generate
--         80% of revenue (Pareto Principle). Knowing who
--         your top customers are allows the business to
--         give them special treatment — loyalty rewards,
--         personal account managers or early access to
--         new products — to ensure they never leave.
-- SKILL : GROUP BY multiple columns, ORDER BY revenue
--         DESC, LIMIT for top-N, customer-level
--         aggregation.
-- ============================================================

SELECT
    Customer_ID,
    Customer_Name,
    Segment,
    Region,
    COUNT(DISTINCT Order_ID)                        AS Total_Orders,
    ROUND(SUM(Sales), 2)                            AS Total_Sales,
    ROUND(SUM(Profit), 2)                           AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)        AS Profit_Margin_Pct
FROM superstore
GROUP BY Customer_ID, Customer_Name, Segment, Region
ORDER BY Total_Sales DESC
LIMIT 10;


-- ============================================================
--  10 — DISCOUNT IMPACT ANALYSIS
-- ------------------------------------------------------------
-- WHAT  : Groups all orders into discount ranges (0%, 1-10%,
--         11-20% etc.) and shows the average profit for
--         each range.
-- WHY   : This is one of the most important business
--         insights — does giving more discount actually
--         hurt profit? The answer is almost always YES.
--         This query proves it with data. If orders with
--         30%+ discount are consistently losing money, the
--         business must immediately change its discount
--         policy. Clients love this analysis because it
--         directly impacts their bottom line.
-- SKILL : CASE WHEN for bucketing/binning, GROUP BY
--         calculated column, MIN() for sort order,
--         profit margin formula.
-- ============================================================

SELECT
    CASE
        WHEN Discount = 0       THEN '0% - No Discount'
        WHEN Discount <= 0.10   THEN '1% - 10%'
        WHEN Discount <= 0.20   THEN '11% - 20%'
        WHEN Discount <= 0.30   THEN '21% - 30%'
        WHEN Discount <= 0.40   THEN '31% - 40%'
        WHEN Discount <= 0.50   THEN '41% - 50%'
        ELSE                         'Above 50%'
    END                                             AS Discount_Range,
    COUNT(*)                                        AS Total_Orders,
    ROUND(SUM(Sales), 2)                            AS Total_Sales,
    ROUND(SUM(Profit), 2)                           AS Total_Profit,
    ROUND(AVG(Profit), 2)                           AS Avg_Profit_Per_Order,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)        AS Profit_Margin_Pct
FROM superstore
GROUP BY Discount_Range
ORDER BY MIN(Discount);


-- ============================================================
--  11 — SHIPPING MODE ANALYSIS
-- ------------------------------------------------------------
-- WHAT  : Compares all 4 shipping modes on number of orders,
--         revenue, profit and average delivery days.
-- WHY   : Shipping cost is one of the biggest operational
--         expenses for any retail business. This query helps
--         the business understand which shipping mode
--         customers prefer and how delivery speed affects
--         sales. If Same Day shipping has very few orders,
--         maybe the business is charging too much for it.
--         If Standard Class takes 5+ days, customers might
--         be leaving for faster competitors.
-- SKILL : DATEDIFF() for date calculation, AVG of date
--         difference, GROUP BY, ORDER BY.
-- ============================================================

SELECT
    Ship_Mode,
    COUNT(DISTINCT Order_ID)                         AS Total_Orders,
    ROUND(SUM(Sales), 2)                             AS Total_Sales,
    ROUND(SUM(Profit), 2)                            AS Total_Profit,
    ROUND(AVG(DATEDIFF(Ship_Date, Order_Date)), 1)   AS Avg_Ship_Days,
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2)  AS Avg_Order_Value
FROM superstore
GROUP BY Ship_Mode
ORDER BY Total_Orders DESC;


-- ============================================================
--  12 — TOP 10 PRODUCTS BY SALES
-- ------------------------------------------------------------
-- WHAT  : Finds the 10 best-selling products by total
--         revenue along with their profit and units sold.
-- WHY   : Knowing your best-selling products helps the
--         business make sure these products are always in
--         stock, featured in marketing, and priced
--         correctly. If a top-selling product has low
--         profit margin, pricing strategy needs a review.
--         This is basic but critical product management.
-- SKILL : GROUP BY Product columns, SUM for revenue and
--         units, LIMIT for top-N, ORDER BY DESC.
-- ============================================================

SELECT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2)     AS Total_Sales,
    ROUND(SUM(Profit), 2)    AS Total_Profit,
    SUM(Quantity)            AS Units_Sold
FROM superstore
GROUP BY Product_ID, Product_Name, Category, Sub_Category
ORDER BY Total_Sales DESC
LIMIT 10;


-- ============================================================
--  13 — TOP 10 LOSS MAKING PRODUCTS
-- ------------------------------------------------------------
-- WHAT  : Finds the 10 products that are losing the most
--         money, along with their discount rate.
-- WHY   : Every product that loses money is costing the
--         business directly. This query is an action item —
--         the client should either stop selling these
--         products, reduce their discount, or renegotiate
--         supplier cost. Notice we also show Avg Discount
--         because in most cases, excessive discounting is
--         the root cause of product-level losses.
-- SKILL : ORDER BY profit ASC to surface biggest losses
--         first, AVG discount analysis, LIMIT, GROUP BY.
-- ============================================================

SELECT
    Product_Name,
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2)         AS Total_Sales,
    ROUND(SUM(Profit), 2)        AS Total_Profit,
    SUM(Quantity)                AS Units_Sold,
    ROUND(AVG(Discount) * 100, 1) AS Avg_Discount_Pct
FROM superstore
GROUP BY Product_Name, Category, Sub_Category
ORDER BY Total_Profit ASC
LIMIT 10;


-- ============================================================
--  14 — QUARTERLY PERFORMANCE
-- ------------------------------------------------------------
-- WHAT  : Shows sales, profit and orders for every quarter
--         (Q1, Q2, Q3, Q4) across all years.
-- WHY   : Quarterly reporting is the standard in business.
--         Every company reports earnings quarterly. This
--         query shows whether Q4 (Oct-Dec holiday season)
--         is consistently the best quarter, and whether
--         Q1 is always the slowest. With this insight,
--         the business can plan promotions in slow quarters
--         and maximise inventory in peak quarters.
-- SKILL : QUARTER() function, CONCAT for readable labels,
--         GROUP BY year and quarter, chronological ORDER BY.
-- ============================================================

SELECT
    YEAR(Order_Date)                             AS Year,
    QUARTER(Order_Date)                          AS Quarter,
    CONCAT('Q', QUARTER(Order_Date),
           '-', YEAR(Order_Date))                AS Quarter_Label,
    ROUND(SUM(Sales), 2)                         AS Total_Sales,
    ROUND(SUM(Profit), 2)                        AS Total_Profit,
    COUNT(DISTINCT Order_ID)                     AS Total_Orders,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2)     AS Profit_Margin_Pct
FROM superstore
GROUP BY YEAR(Order_Date), QUARTER(Order_Date)
ORDER BY Year, Quarter;


-- ============================================================
--  15 — REPEAT vs NEW CUSTOMER ANALYSIS
-- ------------------------------------------------------------
-- WHAT  : Segments all customers into 4 loyalty groups —
--         One-Time, Occasional, Regular and Loyal —
--         based on how many orders they have placed.
-- WHY   : Acquiring a new customer costs 5x more than
--         retaining an existing one. If 70% of customers
--         only bought once and never returned, that is a
--         serious retention problem. This query gives the
--         business a clear picture of customer loyalty so
--         they can invest in retention strategies like
--         loyalty programmes, email campaigns and
--         personalised offers for repeat buyers.
-- SKILL : Subquery, CASE WHEN bucketing on COUNT,
--         Window function SUM OVER() for percentage,
--         two-level aggregation (customer then segment).
-- ============================================================

SELECT
    Customer_Segment,
    COUNT(*)                                                    AS Customer_Count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2)         AS Percentage
FROM (
    SELECT
        Customer_ID,
        CASE
            WHEN COUNT(DISTINCT Order_ID) = 1  THEN 'One-Time Customer'
            WHEN COUNT(DISTINCT Order_ID) <= 3 THEN 'Occasional (2-3 orders)'
            WHEN COUNT(DISTINCT Order_ID) <= 6 THEN 'Regular (4-6 orders)'
            ELSE                                    'Loyal (7+ orders)'
        END AS Customer_Segment
    FROM superstore
    GROUP BY Customer_ID
) AS customer_segments
GROUP BY Customer_Segment
ORDER BY Customer_Count DESC;


-- ============================================================
-- END OF ANALYSIS
-- Author  : Krupa Patel
-- Dataset : Superstore Sales (9,994 records, 2014-2017)
-- Queries : 15 business-focused SQL queries
-- Skills  : Aggregations, Window Functions, CASE WHEN,
--           Subqueries, Date Functions, Top-N Analysis,
--           KPI Calculation, Customer Segmentation
-- ============================================================