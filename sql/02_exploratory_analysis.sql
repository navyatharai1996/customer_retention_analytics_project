use customer_retention_db;
select count(*) from dec_cleaned_dataset;

/* Total Rows */
select * from dec_cleaned_dataset;
select * from dec_cleaned_dataset limit 10;
select count(*) as total_rows from dec_cleaned_dataset;

/* Unique Users */
select user_id from dec_cleaned_dataset;
select count(user_id) from dec_cleaned_dataset;
select count(distinct user_id) from dec_cleaned_dataset;
select count(distinct user_id) as unique_users from dec_cleaned_dataset;

/* Total Event Types */
select event_type from dec_cleaned_dataset;
select event_type, count(*) from dec_cleaned_dataset group by event_type; 
select event_type, count(*) from dec_cleaned_dataset group by event_type order by count(*) desc;
select event_type, count(*) as total_events from dec_cleaned_dataset group by event_type order by total_events desc;
