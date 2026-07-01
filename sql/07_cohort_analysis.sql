/* 1. First Purchase Date */
select user_id, min(date(event_time)) as first_purchase
from dec_cleaned_dataset where event_type='purchase' group by user_id;

/* 2. Purchase Days per Customer */
select user_id, count(distinct date(event_time)) as active_purchase_days
from dec_cleaned_dataset where event_type='purchase' group by user_id order by active_purchase_days desc;

/* 3. Customers Purchasing on Multiple Days */
select count(*) as repeat_day_customers from (
select user_id, count(distinct date(event_time)) as active_purchase_days
from dec_cleaned_dataset where event_type='purchase' group by user_id having active_purchase_days>1) t;

/* 4. Distribution of Purchase Days */
select active_purchase_days, count(*) as customers from (
select user_id, count(distinct date(event_time)) as active_purchase_days
from dec_cleaned_dataset where event_type='purchase'
group by user_id)t
group by active_purchase_days;