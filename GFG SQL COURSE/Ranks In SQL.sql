Ranks in SQL
In SQL, ranking functions allow us to assign a rank or position to rows within a result set based on specified criteria. These functions are invaluable for analytical queries, helping to identify top performers, outliers, or categorize data based on various attributes. Lets explore the concept of ranking in SQL through theory and practical examples using a hypothetical restaurants dataset.

Theory of Ranking Functions
SQL provides several ranking functions that can be categorized into three main types:

1. Ranking Functions (RANK(), DENSE_RANK(), ROW_NUMBER()):
RANK(): Assigns a unique rank to each distinct row based on the specified ORDER BY clause. If two rows have the same rank, the next rank is skipped.

DENSE_RANK(): Similar to RANK(), but ranks are consecutive without gaps. If two rows have the same rank, the next rank is not skipped.

ROW_NUMBER(): Assigns a unique sequential number to each row, starting from 1 for the first row in each partition.

2. Partitioning:
PARTITION BY: Divides the result set into partitions to which the ranking functions are applied separately. Useful for calculating ranks within groups, such as by city or cuisine.

Example Dataset: Restaurants Table
Consider a sample restaurants table with columns:

id: Unique identifier
name: Restaurant name
city: City where the restaurant is located
cuisine: Type of cuisine served
rating: Average rating of the restaurant
rating_count: Number of ratings received
cost: Average cost per meal
Practical Examples of Ranking Functions
Lets use the provided examples to illustrate various ranking scenarios using the restaurants dataset.

Example 1: Rank Every Restaurant by Cost (Descending Order)
SELECT *, RANK() OVER(ORDER BY cost DESC) AS 'rank'
FROM restaurants;
Explanation:
RANK() OVER(ORDER BY cost DESC): Assigns a rank to each restaurant based on their cost, from most expensive to least expensive.
Output: Each row will display a rank indicating its position based on cost.



Example 2: Rank Every Restaurant by Rating Count (Descending Order)
SELECT *, RANK() OVER(ORDER BY rating_count DESC) AS 'rank'
FROM restaurants;
Explanation:
RANK() OVER(ORDER BY rating_count DESC): Ranks each restaurant based on the number of rating_count, from most visited (highest rating_count) to least visited.
Output: Each row will display a rank based on the number of ratings received.



Example 3: Rank Every Restaurant by Cost Within Each City
SELECT *, RANK() OVER(PARTITION BY city ORDER BY cost DESC) AS 'rank'
FROM restaurants;
Explanation:
RANK() OVER(PARTITION BY city ORDER BY cost DESC): Partitions the data by city and ranks restaurants within each city based on their cost, from most expensive to least expensive.
Output: Each row will display a rank indicating the rank of the restaurant within its city based on cost.



Example 4: Rank Every Restaurant by Cost with Dense Ranking Within Each City
SELECT *,
       RANK() OVER(PARTITION BY city ORDER BY cost DESC) AS 'rank',
       DENSE_RANK() OVER(PARTITION BY city ORDER BY cost DESC) AS 'dense_rank'
FROM restaurants;

Explanation:
RANK() OVER(ORDER BY cost DESC): Ranks restaurants based on their cost across all cities.
DENSE_RANK() OVER(ORDER BY cost DESC): Provides a dense rank based on cost, ensuring consecutive ranks without gaps.
Output: Each row will display rank and dense_rank based on restaurant cost.



Example 5: Row Number Every Restaurant by Cost Within Each City
SELECT *,
       RANK() OVER(PARTITION BY city ORDER BY cost DESC) AS 'rank',
       DENSE_RANK() OVER(PARTITION BY city ORDER BY cost DESC) AS 'dense_rank',
       ROW_NUMBER() OVER(PARTITION BY city ORDER BY cost DESC) AS 'row_number'
FROM restaurants;

ROW_NUMBER() OVER(ORDER BY cost DESC): Assigns a unique sequential number to each row based on restaurant cost, starting from 1 for each partition.
Output: Each row will display rank, dense_rank, and row_number based on restaurant cost.



Example 6: Rank Every Restaurant by Cost Within Each City with City Name Prefix
SELECT *,
       CONCAT(city, ' - ', ROW_NUMBER() OVER(PARTITION BY city ORDER BY cost DESC)) AS 'rank'
FROM restaurants;
Explanation:
ROW_NUMBER() OVER(PARTITION BY city ORDER BY cost DESC): Assigns a sequential number within each city partition based on restaurant cost.
CONCAT(city, ' - ', ...): Concatenates city name with the sequential number to display a custom rank.
Output: Each row will display rank combining city name and the sequential number based on restaurant cost.



Example 7: Find Top 5 Restaurants of Every City by Revenue
SELECT *
FROM (
    SELECT *,
           cost * rating_count AS 'revenue',
           ROW_NUMBER() OVER(PARTITION BY city ORDER BY cost * rating_count DESC) AS 'rank'
    FROM restaurants
) AS t
WHERE t.rank <= 5;
Explanation:
Subquery: Calculates revenue (product of cost and rating_count) and assigns rank within each city based on revenue.
Outer query: Filters rows where rank is less than or equal to 5, showing top 5 restaurants by revenue in each city.
Output: Lists top 5 restaurants by revenue in each city.



Example 8: Find Top 5 Restaurants of Every Cuisine by Revenue
SELECT *
FROM (
    SELECT *,
           cost * rating_count AS 'revenue',
           ROW_NUMBER() OVER(PARTITION BY cuisine ORDER BY cost * rating_count DESC) AS 'rank'
    FROM restaurants
) AS t
WHERE t.rank <= 5;
Explanation:
Subquery: Calculates revenue (product of cost and rating_count) and assigns rank within each cuisine based on revenue.
Outer query: Filters rows where rank is less than or equal to 5, showing top 5 restaurants by revenue in each cuisine type.
Output: Lists top 5 restaurants by revenue in each cuisine type.


-- Ranks in SQL
use geeks;
-- 1)Rank every Restaurant from most expensive to least expensive
select *,rank() over(order by cost) as "Rank" from restaurants;

-- 2)Rank every resturant from most visited to least visited
select *,rank() over(order by rating_count) as "Rank" from restaurants;

-- 3)Rank every resturant from most visited to least visited as per their city
select *,rank() over( partition by city order by rating_count desc) as "Rank" from restaurants;

-- 4)Dense Rank every resturant from most expensive to least expensive
-- in rank ranks will be skipped while in dense-rank ranks will not be skipped
select *,rank() over(order by cost desc) as "Rank",dense_rank() over(order by cost desc) as "Dense Rank" from restaurants;

-- 5)row num every restaurant from most expensive to least expensive as per their city
-- row num will not give duplicates evn though values are same
select *,rank() over(order by cost desc) as "Rank",dense_rank() over(order by cost desc) as "Dense Rank" ,row_number() over(order by cost desc) as "Row Number"from restaurants;

-- 6)Rank every Restaurant from most expensive to least expensive as per their city along with its city [Adilabad-1,Adilabad-2]
select *,concat(city,'-',row_number() over(partition by city order by cost desc)) as "Row Number" from restaurants;

-- 7)Find Top 5 Restaurants Of Every City as per their revenue
select* from 
(select *,cost*rating_count as 'Revenue',row_number() over(partition by city order by cost*rating_count desc) as "rank" from restaurants) t where t.rank<6;

-- 8)Find Top 5 Restaurants Of Every Cuisine as per their revenue
select* from 
(select *,cost*rating_count as 'Revenue',row_number() over(partition by cuisine order by cost*rating_count desc) as "rank" from restaurants) t where t.rank<6;



