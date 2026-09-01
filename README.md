# customer-acquisition-sql-analysis

## Project Overview
SQL-based analysis of an e-commerce customer database, exploring acquisition channels, payment methods, repeat purchase behavior, geography, monthly sales dynamics, and order cancellations.

## Business Question
Which acquisition channels and payment methods bring the most valuable and loyal customers, and what factors influence revenue and order cancellations?

## Tools
SQL, SQLite, DBeaver

## Analysis Steps
- Created a SQLite database (`store_database`) in DBeaver with `customers` and `orders` tables (Primary Key / Foreign Key relationship)
- Imported CSV data (`customers.csv`, `orders.csv`) into the corresponding tables
- Verified the relationship between tables via View Diagram
- Wrote and executed SQL queries covering acquisition channels, payment methods, customer retention, geography, monthly trends, and cancellation rates

## Key Insights
- Instagram generates the highest revenue among female customers (190,547 UAH from 368 customers), followed by Facebook.
- Average order value (AOV) is broadly similar across acquisition channels (~131-133 UAH) — channel affects volume, not order size.
- Credit Card users show the highest repeat purchase frequency (1.82 orders per customer) vs. 1.05 for Cash on Delivery.
- 91.9% of customers (2,757 of 3,000) make more than one purchase over the observed period.
- Top-5 cities by revenue are based on very small samples (5-7 customers each) and should be treated as descriptive only, not a reliable pattern; revenue by settlement type (city/town/village) is far more evenly distributed and more informative.
- August is the peak month for both revenue (179,603 UAH) and order count (1,409); AOV stays stable (127-136 UAH) throughout the year.
- Cancellation rate is close across all payment methods (0.69%-1.21%) — at a descriptive level, no meaningful difference is visible.

## Files
- `sql/query_result.sql` — SQL queries and findings (7 analytical queries with comments)
- `database/store_database` — SQLite database file
- `data/customers.csv` — customer dataset (user_id, demographics, acquisition_channel)
- `data/orders.csv` — order dataset (order_id, purchase_amount, order_channel, payment_method, order_status, etc.)
