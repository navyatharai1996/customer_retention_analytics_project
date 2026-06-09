create database customer_retention_db;
use customer_retention_db;
select count(*) from dec_cleaned_dataset;

# Data is not imported fully: 3,31,961 is the imported data but I need full data which is 33,49,409 
drop table dec_cleaned_dataset;

use customer_retention_db;
select count(*) from dec_cleaned_dataset;
drop table dec_cleaned_dataset;

# Import using Method 2:

SHOW VARIABLES LIKE 'local_infile';
SELECT VERSION();
SHOW VARIABLES LIKE 'secure_file_priv';

USE customer_retention_db;

create	table dec_cleaned_dataset (
event_time datetime,
event_type varchar(50),
product_id bigint,
category_id bigint,
category_code varchar(255),
brand varchar(255),
price decimal(10,2),
user_id bigint,
user_session varchar(255));
show tables;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dec_cleaned_dataset.csv'
INTO TABLE dec_cleaned_dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(*) from dec_cleaned_dataset;