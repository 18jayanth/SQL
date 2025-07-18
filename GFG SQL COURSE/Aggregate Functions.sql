** Aggregate Functions

use geeks;
select* from data;

-- 1) Find No of Products in Dataset
select count(*) from data;

-- 2) Find average of discounted Price in Dataset
select avg(discounted_price) as "average price" from data;

-- 2) Find maximum discounted Price in Dataset
select max(discounted_price) as "max discount price" from data;

-- 3) Find most expensive price in Dataset
select max(marked_price) as "Expensive product" from data;

-- 4) Find least expensive price in Dataset
select min(marked_price) as "Least Expensive product" from data;

-- 5) Find total rating count of all Products in Dataset
select sum(rating_count) as "Total Ratings on All Products" from data;

-- 6) Find the total unique brands in Dataset
select distinct(brand_name) as "Unique Brands" from data;

-- 7) Find the no of total unique brands in Dataset
select count(distinct(brand_name)) as "No of Unique Brands" from data;


