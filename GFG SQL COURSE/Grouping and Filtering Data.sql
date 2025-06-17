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







