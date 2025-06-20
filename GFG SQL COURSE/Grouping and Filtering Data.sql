
Notes
Grouping and Filtering Data
Grouping data in SQL allows you to aggregate data based on one or more columns, making it possible to calculate summary statistics, such as counts, 
sums, averages, and more. The GROUP BY clause is used for this purpose.

Filtering data involves selecting specific rows that meet certain criteria. This can be done using the WHERE clause before aggregation or the HAVING
clause after aggregation.

Grouping Data
The GROUP BY clause groups rows that have the same values in specified columns into summary rows. It is often used in conjunction with 
aggregate functions like COUNT, SUM, AVG, MAX, and MIN.

Syntax:
SELECT column1, column2, aggregate_function(column3)
FROM table_name
WHERE condition
GROUP BY column1, column2;
Dataset Overview: Products Table
Assume we have a products table with columns like product_name, brand_name, brand_tag, product_tag, rating, rating_count, marked_price, discounted_price, and discount_percent.

Using the Database and Viewing the Table
First, ensure youre using the correct database and view the data in the products table:

USE gfg;
SELECT * FROM products;
--Grouping Data Examples
--Finding Unique Brand Names
SELECT DISTINCT brand_name FROM products;
--This query retrieves all unique brand names from the products table.

--Counting Unique Brands
SELECT COUNT(DISTINCT brand_name) FROM products;
--This query returns the total number of unique brands.

--Counting Products in Each Brand
SELECT brand_tag, COUNT(product_tag) FROM products GROUP BY brand_tag;
--This query counts the number of products for each brand.


--Top 5 Brands with the Most Products
SELECT brand_tag, COUNT(product_tag) AS 'products'
FROM products
GROUP BY brand_tag
ORDER BY products DESC
LIMIT 5;
--This query lists the top 5 brands with the most products in their inventory.

*/
--Top 5 Brands with the Most Products Sold
SELECT brand_tag, SUM(rating_count) AS 'products_sold'
FROM products
GROUP BY brand_tag
ORDER BY products_sold DESC
LIMIT 5;
--This query lists the top 5 brands that have sold the most products.


--Top 5 Most Expensive Brands Based on Discounted Price
SELECT brand_tag, ROUND(AVG(discounted_price)) AS 'average_price'
FROM products
GROUP BY brand_tag
ORDER BY average_price DESC
LIMIT 5;
--This query lists the top 5 most expensive brands based on the average discounted price of their products.


--Top 5 Least Expensive Brands Based on Discounted Price
SELECT brand_tag, ROUND(AVG(discounted_price)) AS 'average_price'
FROM products
GROUP BY brand_tag
ORDER BY average_price ASC
LIMIT 5;
--This query lists the top 5 least expensive brands based on the average discounted price of their products.


Filtering Data
Filtering data is essential for narrowing down the dataset to include only relevant rows.

Using the WHERE Clause:
The WHERE clause is used to filter rows before any grouping or aggregation is performed.
       

-- Select sales data for a specific product
SELECT product_id, quantity, price
FROM sales
WHERE product_id = 101;
Using the HAVING Clause:
--The HAVING clause is used to filter groups after the GROUP BY operation. It is similar to the WHERE clause but is applied to aggregated data.


-- Calculate the total sales quantity for each product, and show only those with a total quantity greater than 100
SELECT product_id, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_id
HAVING SUM(quantity) > 100;
Finding Top 10 Best-Selling Product Categories
SELECT product_tag, SUM(rating_count) AS 'product_sold'
FROM products
GROUP BY product_tag
ORDER BY product_sold DESC
LIMIT 10;
--This query lists the top 10 best-selling product categories based on the total number of ratings.

--Top 5 Brands Offering Maximum Discount
SELECT brand_tag, AVG(discount_percent) AS 'avg_discount'
FROM products
GROUP BY brand_tag
ORDER BY avg_discount DESC
LIMIT 5;
--This query lists the top 5 brands offering the highest average discount.


--Top 5 Most Expensive Product Categories
SELECT product_tag, AVG(discounted_price) AS 'avg_price'
FROM products
GROUP BY product_tag
ORDER BY avg_price DESC
LIMIT 5;
--This query lists the top 5 most expensive product categories based on the average discounted price.


--Combining Grouping and Filtering
--By combining WHERE, GROUP BY, and HAVING clauses, you can perform complex queries that aggregate and filter data simultaneously.

--Brand Report Card
SELECT brand_tag, 
       SUM(rating_count) AS 'people_rated',
       MIN(marked_price) AS 'min_mar_price',
       AVG(marked_price) AS 'avg_mar_price',
       MAX(marked_price) AS 'max_mar_price'
FROM products
GROUP BY brand_tag;
--This query provides a summary report for each brand, including the total number of ratings, minimum, average, and maximum marked price.


--Most Popular Product Category for Each Brand
SELECT brand_tag, product_tag, SUM(rating_count) AS 'people_rated'
FROM products
GROUP BY brand_tag, product_tag
ORDER BY people_rated DESC
LIMIT 10;
This query identifies the most popular product category for each brand based on the total number of ratings.

Specific Product Category Examples

--Top 5 Brands Selling Most T-Shirts
SELECT brand_tag, product_tag, SUM(rating_count) AS 'orders', AVG(discounted_price) AS 'avg_price'
FROM products
WHERE product_tag = 'tshirts'
GROUP BY brand_tag
ORDER BY orders DESC
LIMIT 5;

*/
Top 5 Brands Selling Most Shirts
SELECT brand_tag, product_tag, SUM(rating_count) AS 'orders', AVG(discounted_price) AS 'avg_price'
FROM products
WHERE product_tag = 'shirts'
GROUP BY brand_tag
ORDER BY orders DESC
LIMIT 5;


--Top 5 Brands Selling Most Jeans
SELECT brand_tag, product_tag, SUM(rating_count) AS 'orders', AVG(discounted_price) AS 'avg_price'
FROM products
WHERE product_tag = 'jeans'
GROUP BY brand_tag
ORDER BY orders DESC
LIMIT 5;


--Top 5 Brands Selling Most Dresses
SELECT brand_tag, product_tag, SUM(rating_count) AS 'orders', AVG(discounted_price) AS 'avg_price'
FROM products
WHERE product_tag = 'dresses'
GROUP BY brand_tag
ORDER BY orders DESC
LIMIT 5;


--Advanced Grouping and Filtering

--Most Popular Product Names
SELECT product_name, COUNT(product_name) AS 'name_count'
FROM products
GROUP BY product_name
ORDER BY name_count DESC
LIMIT 10;


--Number of Products Sold for Each Rating
SELECT rating, COUNT(rating) AS 'freq'
FROM products
GROUP BY rating
ORDER BY rating ASC;


--Number of Products Sold for Each Rating by Nike
SELECT rating, COUNT(rating) AS 'freq'
FROM products
WHERE brand_tag = 'nike'
GROUP BY rating
ORDER BY rating ASC;


--Number of Products Sold for Each Rating in T-Shirt Category
SELECT rating, COUNT(rating_count) AS 'freq'
FROM products
WHERE product_tag = 'tshirts'
GROUP BY rating
ORDER BY rating ASC;


--Relation Between T-Shirt Price and Rating
SELECT product_tag, rating, ROUND(AVG(rating_count)) AS 'product_count', ROUND(AVG(discounted_price))
FROM products
WHERE product_tag = 'tshirts'
GROUP BY rating
ORDER BY rating ASC;


-- Average Rating for Each Product Category
SELECT product_tag, AVG(rating) AS 'avg_rating', COUNT(*) AS 'total_products', SUM(rating_count) AS 'total_rating_count'
FROM products
GROUP BY product_tag
ORDER BY avg_rating ASC;


-- Brand with Highest Average Rating for Products with Discounted Price > 5000
SELECT brand_tag, AVG(rating) AS 'avg_rating', SUM(rating_count)
FROM products
WHERE discounted_price > 5000
GROUP BY brand_tag
ORDER BY avg_rating DESC;




use geeks;
select* from data;
select count(*) from data;

-- 1) Find Unique Brands in the Products table
select distinct(brand_name) from data;

-- 2) Find Number of Unique Brands in the Product table
select count(distinct(brand_name)) from data;

-- 3) Find No of Products in each Brand
select brand_name,count(product_name) as "No of Products in this brand" from data group by brand_name;

-- 4)Find the top 5 brands who have most number of Products
select brand_name,count(product_name) as "No of Products in this brand" from data group by brand_name order by count(product_name) desc limit 5;

-- 5) Finding top 5 brands who sold most number of products
-- More People Rated More Will be Sold
select brand_name,sum(rating_count) as "No of Products sold in this brand" from data group by brand_name order by count(rating_count) desc limit 5;

-- 6) Finding Top 5 most Expensive brands based on their discounted price
select brand_name,avg(discounted_price) as "Average Price" from data group by brand_name order by avg(discounted_price) desc limit 5;

-- 7) Finding Top 5 most Least brands based on their discounted price
select brand_name,avg(discounted_price) as "Average Price" from data group by brand_name order by avg(discounted_price)  limit 5;

-- 8) Finding Top 10 Best selling Product Categories
select product_tag,sum(rating_count) as "Total Products Sold" from data group by product_tag order by sum(rating_count)  desc limit 10;

-- 9)Finding Top 10 brands which gives maximum discounts
select brand_tag,avg(discount_percent) as "Total Discount Given" from data group by brand_tag order by avg(discount_percent) desc   limit 10;

-- 10)Finding top 5 most expensive product categories
select product_tag,avg(discounted_price) as "average price of the product" from data group by product_tag order by avg(discounted_price) desc limit 10;

-- 11)Brand Report card
select brand_tag,sum(rating_count) as "No of People Rated",min(marked_price) as "minimum marked price",avg(marked_price) as "average marked price",
max(marked_price) as "maximum marked price" ,
min(discounted_price) as "minimum disounted price",avg(discounted_price) as "average discounted price",
max(discounted_price) as "maximum discounted price" 
from data group by brand_tag;

-- 12)which product category of any brand is sold the most(which product of which brand or which brand of which product)
select brand_tag,product_tag,sum(rating_count) as "No of People Rated" from data group by brand_tag,product_tag order by sum(rating_count) desc limit 10;

-- 13)List top 5 brands which has sold most no of t shirts
select brand_tag,product_tag ,sum(rating_count) as "No of People Rated",avg(discounted_price) as "Average Price"
 from data where product_tag="tshirts" group by brand_tag 
order by sum(rating_count) desc limit 10;

-- 14)List top 5 brands which has sold most no of  shirts
select brand_tag,product_tag ,sum(rating_count) as "No of People Rated",avg(discounted_price) as "Average Price"
 from data where product_tag="shirts" group by brand_tag 
order by sum(rating_count) desc limit 5;

-- 15)List top 5 brands which has sold most no of jeans
select brand_tag,product_tag ,sum(rating_count) as "No of People Rated",avg(discounted_price) as "Average Price"
 from data where product_tag="jeans" group by brand_tag 
order by sum(rating_count) desc limit 5;

-- 16)List top 5 brands which has sold most no of dresses
select brand_tag,product_tag ,sum(rating_count) as "No of People Rated",avg(discounted_price) as "Average Price"
 from data where product_tag="dresses" group by brand_tag 
order by sum(rating_count) desc limit 5;

-- 17) Most Popular Product name listed in Mynthra
select product_name ,count(product_name) as "Name Count"  from data group by product_name order by count(product_name) desc limit 10;

-- 18) No of Products sold for every rating (0-5)
select rating,count(rating_count) as "frequency" from data group by rating order by rating ;

-- 19) No of Products  sold for every rating (0-5) by nike
select rating,count(rating_count) as "frequency" from data where brand_tag="nike" group by rating order by count(rating_count) desc ;

-- 20) No of Products  sold for every rating (0-5) by tshirt category
select rating,count(rating_count) as "frequency" from data where product_tag="tshirts" group by rating order by rating desc ;

-- 21) Relation between price of the tshirt and its rating count wrt to people rated
select product_tag,rating,avg(rating_count) as "no of people rated" ,avg(discounted_price ) as "discounted price" from data
where product_tag="tshirts" group by rating,product_tag  order by rating desc;

-- 22)Find the average rating for each product category (product tag) along with no of products and total rating count
select product_tag,avg(rating) as "average rating",count(*) as 'total no of products' ,sum(rating_count) as 'total rating count'
from data group by product_tag order by avg(rating) desc;

-- 23) Find the brand with highest average rating among products with a discounted price greater than 5000
select brand_name ,avg(rating),sum(rating_count) from data where discounted_price>5000 group by brand_name order by avg(rating) desc;







