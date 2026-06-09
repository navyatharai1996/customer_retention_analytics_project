/* How many unique users:
1. Viewed products?
2. Added products to cart?
3. Purchased products? */

select count(distinct user_id) from dec_cleaned_dataset;

select count(distinct case when event_type='view' then user_id end) as unique_viewers,
count(distinct case when event_type='cart' then user_id end) as unique_cart,
count(distinct case when event_type='purchase' then user_id end) as unique_purchase from dec_cleaned_dataset;

/* View → Cart Conversion = Cart/View*100 | Cart → Purchase Conversion | View → Purchase Conversion */
select count(distinct case when event_type='cart' then user_id end)/count(distinct case when event_type='view' then user_id end)*100
as view_to_cart_pct from dec_cleaned_dataset;

select round(count(distinct case when event_type='cart' then user_id end)/count(distinct case when event_type='view' then user_id end)*100
,2) as view_to_cart_pct,
round(count(distinct case when event_type='purchase' then user_id end)/count(distinct case when event_type='cart' then user_id end)*100
,2) as cart_to_purch_pct,
round(count(distinct case when event_type='purchase' then user_id end)/count(distinct case when event_type='view' then user_id end)*100
,2) as view_to_purch_pct
from dec_cleaned_dataset;

/* Top Brands by Purchases */

/* ********* select brand, count(event_type='purchase') as purchases from dec_cleaned_dataset 
group by brand order by count(event_type='purchase') desc; *************** */ 
/* event_type='purchase' gives TRUE OR FALSE which is a NON NULL value and count() counts it all, so not the correct code. */

/* To prove the code is wrong */
/* select count(*) as total_rows, count(event_type='purchase') as wrong_pur_count from dec_cleaned_dataset; -- gives same result */

select brand, count(*) as purchases from dec_cleaned_dataset where event_type='purchase' group by brand order by count(*) desc;


/* Top Brands by REVENUE */
select brand, sum(price) as revenue from dec_cleaned_dataset group by brand order by revenue desc;

select brand, sum(price) as revenue from dec_cleaned_dataset where event_type='purchase' 
group by brand order by revenue desc;

/* Average Purchase Value by Brand */
select brand, round(avg(price), 2) as avg_pur_value from dec_cleaned_dataset 
where event_type='purchase' group by brand order by avg_pur_value desc;

select brand, count(*) as total_purchases, round(avg(price), 2) as avg_pur_value from dec_cleaned_dataset 
where event_type='purchase' group by brand order by avg_pur_value desc;

select brand, count(*) as total_purchases, round(sum(price), 2) as revenue, round(avg(price), 2) as avg_pur_value from dec_cleaned_dataset 
where event_type='purchase' group by brand having count(*)>50 order by revenue desc;

/* Revenue Percentage */
select brand, count(*) as total_purchases, round(sum(price), 2) as revenue, round(avg(price), 2) as avg_pur_value, 
round(sum(price)/sum(sum(price)) over()*100, 2) as revenue_pct from dec_cleaned_dataset 
where event_type='purchase' group by brand having count(*)>50 order by revenue desc;

