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

