/*
Customer Acquisition & Revenue Analysis — SQL Portfolio Project
Database: SQLite
Tool: DBeaver

Бізнес-питання:
Які канали залучення клієнтів приводять найцінніших клієнтів?

Важливе зауваження:
Цей набір даних не містить маркетингових витрат, тому ми не можемо розрахувати реальний CAC.
Натомість ми аналізуємо обсяг клієнтів, дохід, середню вартість замовлення, повторні покупки
та простий показник LTV: загальний дохід на одного клієнта.
*/

--1. З якого каналу залучення жінки приносять найбільшу виручку
SELECT 
    c.acquisition_channel,
    COUNT(DISTINCT c.user_id) AS female_users,
    COUNT(o.order_id) AS female_orders,
    ROUND(SUM(o.purchase_amount), 2) AS female_revenue,
    ROUND(SUM(o.purchase_amount) / COUNT(o.order_id), 2) AS avg_check
FROM customers c
JOIN orders o ON c.user_id = o.user_id
WHERE c.gender = 'Female'
GROUP BY c.acquisition_channel
ORDER BY female_revenue DESC
LIMIT 5;

-- 2.Виручка та середній чек за методом оплати
SELECT 
    o.payment_method,
    COUNT(*) AS total_orders,
    COUNT(DISTINCT o.user_id) AS total_users,
    ROUND(SUM(o.purchase_amount), 2) AS total_revenue,
    ROUND(AVG(o.purchase_amount), 2) AS avg_check,
    ROUND(CAST(COUNT(*) AS REAL) / COUNT(DISTINCT o.user_id), 2) AS orders_per_user
FROM orders o
GROUP BY o.payment_method
ORDER BY total_revenue DESC;

-- 3. Сегментація клієнтів на одноразових і повторних покупців
SELECT 
    customer_type,
    COUNT(*) AS total_customers,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS percent_of_total
FROM (
    SELECT 
        o.user_id,
        CASE 
            WHEN COUNT(*) = 1 THEN 'Одноразовий'
            ELSE 'Повторний'
        END AS customer_type
    FROM orders o
    GROUP BY o.user_id
) AS customer_orders
GROUP BY customer_type;


--4. Топ-5 міст за виручкою
SELECT 
    c.city,
    COUNT(DISTINCT c.user_id) AS total_users,
    COUNT(*) AS total_orders,
    ROUND(SUM(o.purchase_amount), 0) AS total_revenue,
    ROUND(AVG(o.purchase_amount), 2) AS avg_check
FROM orders o
JOIN customers c ON o.user_id = c.user_id
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 5;

--5. Виручка за типом населеного пункту
SELECT 
    SUBSTR(c.city, 1, INSTR(c.city, ' ') - 1) AS settlement_type,
    COUNT(DISTINCT c.user_id) AS total_users,
    COUNT(*) AS total_orders,
    ROUND(SUM(o.purchase_amount), 0) AS total_revenue,
    ROUND(AVG(o.purchase_amount), 2) AS avg_check
FROM orders o
JOIN customers c ON o.user_id = c.user_id
GROUP BY settlement_type
ORDER BY total_revenue DESC;

-- 6. Динаміка продажів по місяцях
SELECT 
    strftime('%Y-%m', o.order_date) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(o.purchase_amount), 0) AS total_revenue,
    ROUND(AVG(o.purchase_amount), 2) AS avg_check
FROM orders o
GROUP BY order_month
ORDER BY order_month ASC;

-- 7. Частка скасованих замовлень за методом оплати
SELECT 
    o.payment_method,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN o.order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(100.0 * SUM(CASE WHEN o.order_status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancel_rate_pct
FROM orders o
GROUP BY o.payment_method
ORDER BY cancel_rate_pct DESC;

