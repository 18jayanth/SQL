Working with Subqueries
In SQL, subqueries are a powerful feature that allow you to perform complex queries and achieve tasks that would be difficult or impossible with a single query. Subqueries, also known as inner queries or nested queries, are queries within another SQL query. This article will delve into the concept of subqueries, their types, and practical examples to help you master their use.

What is a Subquery?
A subquery is a query embedded within another SQL query. The result of the subquery is used by the outer query. Subqueries can be placed in various parts of a SQL statement, including the SELECT, FROM, WHERE, and HAVING clauses.

Types of Subqueries
Single-row Subqueries: Return a single row and are often used with comparison operators like =, >, <.

Multi-row Subqueries: Return multiple rows and are often used with operators like IN, ANY, ALL.

Scalar Subqueries: Return a single value and can be used wherever a single value is expected.

Correlated Subqueries: Refer to columns in the outer query and are executed once for each row selected by the outer query.





--Basic Query
--Find the average rating of products.

SELECT AVG(rating) AS 'avg_rating' FROM gfg.products;
--This query calculates the average rating of all products.



--Subquery in WHERE Clause
--Find the brand names with a rating higher than the average rating

SELECT brand_name FROM gfg.products
WHERE rating > (SELECT AVG(rating) AS 'avg_rating' FROM gfg.products);
--Here, the subquery calculates the average rating of all products, and the outer query selects the brand names with a rating higher than this average.



--Subquery in SELECT Clause
--Retrieve the product name along with the average rating of products.

SELECT product_name, rating,
       (SELECT AVG(rating) FROM gfg.products) AS 'avg_rating'
FROM gfg.products;
--The subquery calculates the average rating, and the outer query selects the product names along with their individual ratings and the overall average rating.




--Subquery with Multiple Results
--Find the total rating count of products for each brand compared to the overall average rating count.

SELECT brand_name,
       (SELECT SUM(rating_count) FROM gfg.products WHERE brand_name = p.brand_name) AS total_rating_count
FROM (SELECT DISTINCT brand_name FROM gfg.products) AS p;
--The subquery calculates the total rating count for each brand, and the outer query compares it with the overall average rating count.




--Example 1: Single-row Subquery
--Find the product with the highest price.

SELECT * FROM products
WHERE price = (SELECT MAX(price) FROM products);
--The subquery finds the highest price, and the outer query selects the product with that price.



--Example 2: Multi-row Subquery
--Find products from brands that have at least one product with a price greater than $1000.
SELECT * FROM products
WHERE brand_name IN (SELECT DISTINCT brand_name FROM products WHERE price > 1000);--The subquery finds all distinct brands with at least one product priced over $1000. The outer query selects products from these brands.




--Example 3: Scalar Subquery
--Find the average price of all products and list products that have a price greater than this average.
SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products);
--The subquery calculates the average price, and the outer query selects products with a price greater than this average.



--Example 4: Correlated Subquery
--Find products with a price greater than the average price of their respective category.
SELECT product_id, product_name, price, category
FROM products p1
WHERE price > (SELECT AVG(price) FROM products p2 WHERE p1.category = p2.category);
--The subquery calculates the average price for each category, and the outer query selects products with a price higher than the average price of their category.



--Example 5: Subquery in FROM Clause
--Find the average price of products for each brand.
SELECT brand_name, AVG(price) AS avg_price
FROM (SELECT brand_name, price FROM products) AS sub
GROUP BY brand_name;
--The subquery retrieves brand names and prices, and the outer query calculates the average price for each brand.


--Example 6: Subquery in SELECT Clause
--Find products and their price as a percentage of the most expensive product's price.
SELECT product_id, product_name, price,
       (price / (SELECT MAX(price) FROM products)) * 100 AS price_percentage
FROM products;
--The subquery calculates the highest price, and the outer query calculates each product's price as a percentage of the highest price.




-- Subqueries
use geeks;
select * from data;

-- Basic Query: Find average rating od Products
select avg(rating) as 'Average Rating'  from data;

-- Subquery in Where Clause:Find brand names of Products with a rating higher than average rating
select brand_name from data where rating >(select avg(rating) as 'Average Rating'  from data);

-- Subquery in Select Clause:Retrieve the Product name along with the average rating of Products
select product_name,(select avg(rating) as 'Average Rating'  from data) from data ;

-- Subquery With Multiple Results:Finding the total rating count of Products for each brand compared to the overall average rating count

select brand_name,(select avg(rating_count) from data where brand_name=p.brand_name) as total_rating_count
from (select distinct brand_name from data) as p;
-- OR
select brand_name ,sum(rating_count) from data group by brand_name;




