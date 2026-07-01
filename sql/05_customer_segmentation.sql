/* Top Customers by Revenue - VIP Customers */
select user_id, sum(price) as total_revenue from dec_cleaned_dataset 
where event_type='purchase' group by user_id order by total_revenue desc;

select user_id, count(*) as total_purchases, sum(price) as total_revenue from dec_cleaned_dataset 
where event_type='purchase' group by user_id order by total_revenue desc;

/* Customer Segments - Customers with High Value / Medium Value / Low Value */
select user_id, sum(price) as customer_revenue from dec_cleaned_dataset
where event_type='purchase' group by user_id;

select min(customer_revenue) as min_revenue, avg(customer_revenue) as avg_revenue, max(customer_revenue) as max_revenue from(
select user_id, sum(price) as customer_revenue from dec_cleaned_dataset
where event_type='purchase' group by user_id) t;

/* The average is only 42, but the top customer is 1526. That means a small number of customers contribute a large amount of revenue. */

select user_id, sum(price) as customer_revenue from dec_cleaned_dataset
where event_type='purchase' group by user_id;

select case
when customer_revenue < 10 then "0-10"
when customer_revenue < 25 then "10-25"
when customer_revenue < 50 then '25-50'
when customer_revenue < 100 then '50-100'
when customer_revenue < 250 then '100-250'
when customer_revenue < 500 then '250-500'
when customer_revenue < 1000 then '500-1000'
else '1000+' end as revenue_band, count(*) as customers from (
    select user_id, sum(price) as customer_revenue from dec_cleaned_dataset
    where event_type='purchase' group by user_id) t
group by revenue_band order by customers desc;
/* The vast majority of customers spend less than $100. Total ≈ 25,613 customers.
254 customers spent more than $250.
254 / 25613 = 0.99%
Only the top 1% are spending more than $250. */

select user_id, count(*) as total_purchases, sum(price) as total_revenue,
case when sum(price)>=250 then "High Value"
	when sum(price)>=100 then "Medium Value"
else "Low Value" end as Customer_segment
from dec_cleaned_dataset 
where event_type='purchase' group by user_id order by total_revenue desc;

/* Segment Summary - How many customers belong to each segment */
select user_id,
case when sum(price)>=250 then "High Value"
	when sum(price)>=100 then "Medium Value"
else "Low Value" end as Customer_segment
from dec_cleaned_dataset 
where event_type='purchase' group by user_id;

select customer_segment, count(*) as customers from (
select user_id,
case when sum(price)>=250 then "High Value"
	when sum(price)>=100 then "Medium Value"
else "Low Value" end as Customer_segment
from dec_cleaned_dataset 
where event_type='purchase' group by user_id) t
group by customer_segment order by customers desc;

/* Revenue contributed by each Segment */
select user_id, sum(price) as customer_revenue,
case when sum(price) >= 250 then "High Value"
	when sum(price) >=100 then "Medium Value"
	else "Low Value" 
end as customer_segment
from dec_cleaned_dataset where event_type='purchase' group by user_id;

select customer_segment, count(*) as customers, sum(customer_revenue) as total_revenue, avg(customer_revenue) as avg_revenue
from (
select user_id, sum(price) as customer_revenue,
case when sum(price) >= 250 then "High Value"
	when sum(price) >=100 then "Medium Value"
	else "Low Value" 
end as customer_segment
from dec_cleaned_dataset where event_type='purchase' group by user_id) t
group by customer_segment;

/* Average Revenue per Customer - How much does an average customer spend? */
select user_id, sum(price) as customer_revenue from dec_cleaned_dataset
where event_type='purchase' group by user_id;

select round(avg(customer_revenue),2) as avg_cust_revenue from (
select user_id, sum(price) as customer_revenue from dec_cleaned_dataset
where event_type='purchase' group by user_id) t;
/* Approximately 94% of customers are low spenders, around 6% are medium-value customers, and only 1% belong to the high-value segment. */

/* Repeat Customer Rate */
select count(*) as repeat_customers from (
select user_id, count(*) from dec_cleaned_dataset
where event_type='purchase' group by user_id having count(*)>1) t;

/* Total Purchasing Customers */
select count(distinct user_id) as total_customers
from dec_cleaned_dataset where event_type='purchase';

/* What percentage of customers came back and bought again? */
select (
select count(*) as repeat_customers from (
select user_id, count(*) from dec_cleaned_dataset
where event_type='purchase' group by user_id having count(*)>1) t
) / (
select count(distinct user_id) as total_customers
from dec_cleaned_dataset where event_type='purchase'
) * 100 as repeat_customer_rate

