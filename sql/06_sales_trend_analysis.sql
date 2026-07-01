/* 1. Daily Revenue Trend - How did Revenue change day by day */
select date(event_time) as sales_date, count(*) as purchases, sum(price) as revenue
from dec_cleaned_dataset where event_type='purchase'
group by date(event_time) order by sales_date;

/* 2. Hourly Sales Trend */
select hour(event_time) as hour_of_day, count(*) as purchases, sum(price) as revenue
from dec_cleaned_dataset where event_type='purchase' 
group by hour(event_time) order by hour_of_day;

/* 3. Weekday Analysis - Which day performs the best? */
select dayname(event_time) as weekday, count(*) as purchases, sum(price) as revenue
from dec_cleaned_dataset where event_type='purchase' 
group by dayname(event_time);

/* 4. Weekend vs Weekday */
select event_time, dayname(event_time) as day_name, dayofweek(event_time) as day_number from dec_cleaned_dataset 
order by event_time desc;

select case when dayofweek(event_time) in (1,7)
then "Weekend"
else "Weekday" end as day_type,
count(*) as purchases, sum(price) as revenue
from dec_cleaned_dataset where event_type='purchase'
group by day_type;

/* 5. Peak Shopping Hours */
select hour(event_time) as purchase_hour, count(*) as purchases, sum(price) as tot_revenue, avg(price) as avg_revenue
from dec_cleaned_dataset where event_type='purchase' 
group by purchase_hour order by purchase_hour;