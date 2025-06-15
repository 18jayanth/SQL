** Pattern matching


use geeks;
show tables;
select * from data;
-- Patterns

-- 1)Find The Products Where Product Names ends with 's'
select * from data where  product_name like '%s';

-- 2)Find The Products Where Product Names contains 'ad'
select * from data where product_name like '%ad%';

-- 3)Find The Products Where Product Names starts with 'p' ends with 's'
select * from data where product_name like 'p%s';

-- 4) Find the Products with brand names of exactly 6 length
select * from data where brand_name like '______';

-- 5) Find the Products with brand names second character is 's'
select * from data where brand_name like '_s%';
















