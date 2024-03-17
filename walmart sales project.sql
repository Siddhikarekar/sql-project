create database walmartsales;

salescreate table sales(
invoice_id varchar(30) not null primary key,
branch varchar(5) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(10) not null,
product_line varchar(100) not null,
unit_price decimal(10,2) not null,
quantity int not null,
vat float(6,4) not null,
total decimal(12,4) not null,
date datetime not null,
time time not null,
payment_method varchar(15) not null,
cogs decimal(10,2) not null,
gross_margin_pct float(11,9),
gross_income float(12,4) not null,
rating float(2,1)
);

-- -----------------------------------------------------------------------------------------------------------------------------
-- ----------------------------feature engineering ---------------------------------

-- time_of_the_day

select 
	time,
		(case 
			when `time` between "00:00:00" and "12:00:00" then "morning"
            when `time` between "12:00:01" and "16:00:00" then "Afternon"
            else "Evening"
        end)as time_of_date
from sales;

alter table sales add column time_of_day varchar(20);

update sales
set time_of_day =(case 
			when `time` between "00:00:00" and "12:00:00" then "morning"
            when `time` between "12:00:01" and "16:00:00" then "Afternon"
            else "Evening"
        end
);

-- day_name--

select date,
dayname(date)
from sales;
alter table sales add column day_name varchar(10);
update sales
set day_name=dayname(date);

-- month name--
select date,
monthname(date)
from sales;
alter table sales add column month_name varchar(10);
update sales
set month_name=monthname(date);

-- How many unique cities does the data have?
select distinct city from sales;

-- In which city each branch?
select distinct branch from sales;

select distinct city,branch from sales;

-- how many unique product does the data have?
select distinct product_line from sales;

select count(distinct product_line) from sales;

-- what is the most common payment method
select payment_method,
count(payment_method) as cnt
from sales 
group by payment_method
order by cnt desc;

-- what is the most selling product_line
select product_line,
count(product_line) as cnt
from sales 
group by product_line
order by cnt desc;

-- what is total revene by month?
select
	month_name as month,
    sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc;

-- what month had largest cogs?
select
	month_name as month,
    sum(cogs) as cogs
from sales
group by month_name
order by cogs desc;

-- what product line had largest revenue?
select 
	product_line,
    sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;

-- what city has largest revenue?
select 
	branch,
    city,
    sum(total) as total_revenue
from sales
group by city,branch
order by total_revenue desc;

-- what product line has largest vat?
select
	product_line,
    avg(vat) as avg_tax
from sales
group by product_line
order by avg_tax desc;

-- which branch sold more products than average product sold?
select
	branch,
    sum(quantity) as qty
from sales
group by branch
having sum(quantity) > (select avg(quantity) from sales);

-- what is the most common product line by gender?
select
	gender,
    product_line,
    count(gender) as total_cnt
from sales
group by gender, product_line
order by total_cnt desc;

-- what is the average rating of each product line?
select
	round(avg(rating), 2) as avg_rating,
    product_line
from sales
group by product_line
order by avg_rating desc;

-- -------------------------------------------sales----------------
-- number of sales made in each time of the day per week

select
	time_of_day,
    count(*) as total_sales
from sales
where day_name='Monday'
group by time_of_day
order by total_sales desc;

-- which of the customer types brings the most revenue
select
	customer_type,
    sum(total) as total_revenue
from sales
group by customer_type
order by total_revenue desc;

-- which city has largest tax percent/vat (value added tax)
select 
	city,
    avg(vat) as vat 
from sales
group by city
order by vat desc;















