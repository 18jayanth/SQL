Introduction to Window Functions
In SQL, window functions provide a powerful way to perform calculations across a set of rows related to the current row, without grouping the rows into a single output row. This capability allows for more complex and insightful data analysis compared to traditional aggregate functions. Window functions operate over a "window" of rows, which is defined by the OVER clause.

Theory Explanation
Window functions are distinguished from traditional aggregate functions like SUM() or AVG() because they do not collapse rows into a single result row. Instead, they maintain the individual rows and calculate a value for each row based on a window of related rows.

Key components of a window function:
PARTITION BY: Divides the result set into partitions to which the window function is applied separately. Each partition forms its own window.


ORDER BY: Specifies how rows within a partition are ordered before the window function is applied. This determines the peer group of rows considered for each row's calculation.


ROWS/RANGE: Defines the window frame in terms of rows or a logical range within the partition. It further refines which rows are included in the window for computation.
Let's define a simple restaurants table with some sample data:




Example 1: Average Rating Across Dataset
SELECT *, ROUND(AVG(rating) OVER(), 2) AS avg_rating
FROM restaurants;
Explanation:
AVG(rating) OVER(): This part calculates the average rating across all rows in the restaurants table without grouping the rows. The OVER() clause without any PARTITION BY or ORDER BY clause means it considers the entire result set as a single partition.
ROUND(..., 2) AS avg_rating: Rounds the average rating to two decimal places and assigns it to a new column named avg_rating.
Result: Each row in the result set will have an additional column avg_rating showing the average rating of all restaurants in the dataset.



Example 2: Average Rating Count Across Dataset
SELECT *, ROUND(AVG(rating_count) OVER(), 0) AS avg_rating_count
FROM restaurants;
Explanation:
AVG(rating_count) OVER(): Computes the average rating_count across all rows in the restaurants table, similar to Example 1.
ROUND(..., 0) AS avg_rating_count: Rounds the average rating count to the nearest whole number and assigns it to a new column named avg_rating_count.
Result: Each row will include avg_rating_count, showing the average count of ratings across all restaurants.



Example 3: Average Cost Across Dataset
SELECT *, ROUND(AVG(cost) OVER(), 0) AS avg_cost
FROM restaurants;
Explanation:
AVG(cost) OVER(): Calculates the average cost across all rows in the restaurants table.
ROUND(..., 0) AS avg_cost: Rounds the average cost to the nearest whole number and adds it as a new column named avg_cost.
Result: Each row now includes avg_cost, representing the average cost of all restaurants in the dataset.



Example 4: Aggregate Statistics Across Dataset
SELECT id, name, city, cuisine, rating,
       ROUND(MAX(rating) OVER(), 2) AS max_rating,
       ROUND(AVG(rating) OVER(), 2) AS avg_rating,
       ROUND(MIN(rating) OVER(), 2) AS min_rating,
       ROUND(MAX(cost) OVER(), 2) AS max_cost,
       ROUND(AVG(cost) OVER(), 2) AS avg_cost,
       ROUND(MIN(cost) OVER(), 2) AS min_cost
FROM restaurants;
Explanation:
MAX, AVG, MIN: These aggregate functions are applied over the entire dataset for both rating and cost.
OVER(): Without specifying PARTITION BY or ORDER BY, these functions operate across the entire dataset.
ROUND(..., 2): Rounds the results to two decimal places for clarity.
Result: Each row will display aggregate statistics (max, avg, min) for rating and cost across all restaurants.



Example 5: Average Cost by City
SELECT *,
       ROUND(AVG(cost) OVER(PARTITION BY city), 0) AS avg_cost_city
FROM restaurants;
Explanation:
PARTITION BY city: Divides the dataset into partitions based on city. For each city, a separate calculation of average cost is performed.
AVG(cost) OVER(...): Calculates the average cost within each city partition.
ROUND(..., 0) AS avg_cost_city: Rounds the average city cost to the nearest whole number and adds it as avg_cost_city.
Result: Each row includes avg_cost_city, showing the average cost of restaurants within their respective cities.



Example 6: Average Cost by Cuisine
SELECT *,
       ROUND(AVG(cost) OVER(PARTITION BY cuisine), 0) AS avg_cost_cuisine
FROM restaurants;
Explanation:
PARTITION BY cuisine: Divides the dataset into partitions based on cuisine. For each cuisine type, a separate calculation of average cost is performed.
AVG(cost) OVER(...): Computes the average cost within each cuisine partition.
ROUND(..., 0) AS avg_cost_cuisine: Rounds the average cuisine cost to the nearest whole number and adds it as avg_cost_cuisine.
Result: Each row includes avg_cost_cuisine, showing the average cost of restaurants serving each type of cuisine.



Example 7: Combined City and Cuisine Averages
SELECT *,
       ROUND(AVG(cost) OVER(PARTITION BY city), 0) AS avg_cost_city,
       ROUND(AVG(cost) OVER(PARTITION BY cuisine), 0) AS avg_cost_cuisine
FROM restaurants;
Explanation:
PARTITION BY city: Computes the average cost within each city partition.
PARTITION BY cuisine: Computes the average cost within each cuisine partition.
Result: Each row will have avg_cost_city and avg_cost_cuisine columns showing the average cost for the respective city and cuisine.



Example 8: Restaurants Above Average Cost
SELECT *
FROM restaurants
WHERE cost > (SELECT AVG(cost) FROM restaurants);
Explanation:
Subquery: Calculates the average cost of all restaurants in the dataset.
Outer query: Selects rows from restaurants where the cost is greater than the calculated average cost.
Result: Lists restaurants where the cost exceeds the overall average cost of all restaurants.



Example 9: Restaurants Above Average Cuisine Cost
SELECT *
FROM (SELECT *, AVG(cost) OVER(PARTITION BY cuisine) AS avg_cost FROM restaurants) AS t
WHERE cost > avg_cost;
Explanation:
Subquery: Computes the average cost within each cuisine partition.
Outer query: Selects rows where the cost of each restaurant exceeds the average cost of its respective cuisine.
Result: Lists restaurants whose cost is higher than the average cost of their specific cuisine.





-- Window Functions
use geeks;
select * from restaurants;
-- 1)Create a New Column containing average rating of the restaurants throughout the dataset
-- over() will create a new column
select *,round(avg(rating) over(),2) from restaurants;

-- 2)Create a New Column containing average rating count of the restaurants throughout the dataset
select *,round(avg(rating_count) over(),2) from restaurants;

-- 3)Create a New Column containing average rating cost of the restaurants throughout the dataset
select *,round(avg(cost) over(),2) from restaurants;

-- 4)Create a New Column containing average,min,max of cost,rating, rating cost of the restaurants throughout the dataset
select name,round(min(cost) over(),2) as "minimum cost",round(max(cost) over(),2)  as "maximum cost",round(avg(cost) over(),2)  as "average cost",
round(min(rating) over(),2)  as "minimum rating",round(max(rating) over(),2)  as "maximum rating",round(avg(rating) over(),2)  as "average rating",
round(min(rating_count) over(),2)  as "minimum rating count",round(max(rating_count) over(),2)  as "maximum rating count",
round(avg(rating_count) over(),2)  as "average rating count"
from restaurants;

-- 5)Create a New Column containing average cost of the city the restarant from
select name,city ,round(avg(cost) over(partition by city),2) as 'average cost' from restaurants order by city;

-- 6)Create a New Column containing average cost of the cuisine which that particular restaurant is serving 
select cuisine,name ,round(avg(cost) over(partition by cuisine),2) as 'average cost' from restaurants ;

-- 7)Create both columns together
select name,city ,
round(avg(cost) over(partition by city),2) as 'average cost by city' ,
round(avg(cost) over(partition by cuisine),2) as 'average cost by cuisine'
from restaurants order by city;

-- 8)List the restaurants where cost is more than average cost of restaurants
select *from restaurants where cost>(select avg(cost) from restaurants);
select * from (select *,avg(cost) over() as 'average_cost' from restaurants)t where t.cost>t.average_cost;

-- 9)List the restaurants whose cuisine  cost more than average cost of restaurants
select * from (select *,avg(cost) over(partition by cuisine) as 'average_cost' from restaurants)t where t.cost>t.average_cost;

