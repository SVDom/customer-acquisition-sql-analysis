# Customer Acquisition & Revenue Analysis

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
