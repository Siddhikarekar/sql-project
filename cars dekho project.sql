use cars;
-- Read data--
SELECT * FROM cars.`car dekho`;
-- total count--
select count(*) from cars.`car dekho`;
-- how many cars will be available in 2023?--
select count(*) from cars.`car dekho` where year=2023;
-- cars available in 2020,2021,2022 --- group by---
select count(*) from cars.`car dekho` where year  in (2020,2021,2022) group by year;
-- total of all cars by years--
select year, count(*) from cars.`car dekho` group by year;
-- how many diesel cars will be there in 2020?
select count(*) from cars.`car dekho` where year =2020 and fuel ='Diesel';
-- how many car petrol cars will be there in 2020?
select count(*) from cars.`car dekho` where year =2020 and fuel ='petrol';
-- give the print of all fuel cars
select year, count(*) from cars.`car dekho` where fuel ='petrol' group by year;
select year, count(*) from cars.`car dekho` where fuel ='Diesel' group by year;
select year, count(*) from cars.`car dekho` where fuel ='Cng' group by year;
-- there were more than 100 cars in given year , which year?
select year, count(*) from cars.`car dekho` group by year having count(*)>100;
-- all cars details between  2015 to 2023?
select count(*) from cars.`car dekho` where year between 2015 and 2023;