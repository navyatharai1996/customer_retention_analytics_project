/* Analysis 1: Repeat Customers - Find customers who purchased more than once */
select user_id, count(*) as total_purchases from dec_cleaned_dataset 
where event_type='purchase' group by user_id having count(*)>1 order by total_purchases desc;

/* Analysis 2: Purchase Frequency Distribution */
select purchases as no_of_purchases, count(*) as no_of_customers from
(select user_id, count(*) as purchases from dec_cleaned_dataset 
where event_type='purchase' group by user_id order by count(*) desc) t
group by no_of_purchases order by no_of_purchases desc;


/* Analysis 3: Top Categories by Revenue */
select category_code, sum(price) as revenue from dec_cleaned_dataset where event_type='purchase' group by category_code order by revenue desc;

/* Analysis 4: Top Categories by Purchases */
select category_code, count(*) as purchases from dec_cleaned_dataset 
where event_type='purchase' group by category_code order by purchases desc;

/* Analysis 5: Revenue by Month */
select date(event_time) as order_date, sum(price) as revenue from dec_cleaned_dataset
where event_type='purchase' group by date(event_time) order by order_date desc;

/* Analysis 6: Peak Purchase Hours */
select hour(event_time) as purchase_hour, sum(price) as revenue from dec_cleaned_dataset
where event_type='purchase' group by hour(event_time) order by purchase_hour desc;
