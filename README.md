# Customer Acquisition & Revenue Analysis

## Project Overview
This project analyzes customer acquisition channels, payment methods, and repeat purchase behavior for a sample e-commerce dataset using SQL and SQLite.
The goal is to understand which channels and payment methods bring the largest customer volume, the highest revenue, stronger repeat purchase behavior, and better revenue per customer — and whether geography, order status, or cancellations vary meaningfully across segments.

**Note:** the dataset does not include marketing spend, so this project does not calculate real CAC. Revenue per customer is used as a simple LTV proxy.

## Business Question
Which acquisition channels and payment methods bring the most valuable and loyal customers?

Additional questions:
- From which acquisition channel do female customers generate the most revenue?
- Which payment method generates the highest revenue and average order value?
- What share of customers make repeat purchases?
- Are revenue and order counts distributed evenly across cities, or only across broader settlement types (city/town/village)?
- How do monthly acquisition and revenue trends evolve over the year?
- Does payment method affect the order cancellation rate?

## Tools
- SQL
- SQLite
- DBeaver
- CSV data import
- GitHub for project publication

## Dataset
The project uses two CSV files:

| File | Description |
|---|---|
| `customers.csv` | Customer profile data: user ID, gender, age, city, acquisition channel, registration date |
| `orders.csv` | Order data: order ID, order date, purchase amount, order channel, payment method, delivery days, order status |

The SQLite database contains two main tables: `customers` and `orders`, linked by `user_id` (Primary Key / Foreign Key).

## Repository Structure

customer-acquisition-sql-analysis/
│
├── README.md
├── data/
│ ├── customers.csv
│ └── orders.csv
│
├── database/
│ └── store_database
│
└── sql/
└── query_result.sql

## Analysis Steps
1. Checked data volume, date range, and revenue totals.
2. Created a SQLite database with `customers` and `orders` tables (Primary Key / Foreign Key), imported CSV data, and verified the relationship via View Diagram.
3. Joined customer and order data by `user_id` to analyze acquisition channel performance among female customers.
4. Calculated revenue, order count, and average order value (AOV) by payment method.
5. Segmented customers into one-time vs. repeat buyers and calculated the overall repeat purchase share.
6. Analyzed revenue by city (top-5) and by settlement type (city/town/village/hamlet) to check whether granular geography is a reliable signal.
7. Calculated monthly acquisition and revenue trends.
8. Compared cancellation rate across payment methods.

## Key SQL Topics Used
- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, `LIMIT`
- `JOIN`
- `CASE WHEN`
- Aggregations: `COUNT`, `COUNT(DISTINCT)`, `SUM`, `AVG`, `ROUND`
- Subqueries
- Window functions: `SUM(...) OVER ()`
- Date functions: `strftime`
- Type casting: `CAST(... AS REAL)` to avoid integer division

## Key Insights
Based on the current dataset:
- Instagram generated the highest revenue among female customers (190,547 UAH from 368 customers), followed by Facebook.
- Average order value (AOV) is broadly similar across payment methods (~129-135 UAH) — payment method affects repeat purchase frequency, not order size.
- Credit Card customers show the highest repeat purchase rate (1.82 orders per customer) vs. 1.05 for Cash on Delivery.
- 91.9% of customers (2,757 of 3,000) make more than one purchase over the observed period.
- Top-5 cities by revenue are based on very small samples (5-7 customers each) and should be treated as descriptive only, not a reliable pattern; revenue by settlement type is far more evenly distributed (~750 customers per category) and more informative.
- August is the peak month for both revenue (179,603 UAH) and order count (1,409); AOV stays stable (127-136 UAH) throughout the year.
- Cancellation rate is close across all payment methods (0.69%-1.21%) — at a descriptive level, no meaningful difference is visible.

## Recommendations / Next Steps
- Investigate why the repeat purchase rate differs so strongly by payment method (Credit Card vs. Cash on Delivery) and whether encouraging saved-card checkout could improve retention.
- Extend the acquisition channel analysis beyond the female segment to the full customer base for comparison.
- Add marketing spend data to calculate real CAC and LTV/CAC ratio.
- Extend the analysis with cohort retention by acquisition channel and payment method.
- Investigate whether delivery days for non-delivered statuses reflect planned vs. actual timelines, to enable a fairer comparison with delivered orders.
