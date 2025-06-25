select * from user_2021;
select * from user_2022;
select * from user_2023;

-- UNION   Data of both the tables without duplicates
select * from user_2021
UNION
select * from user_2022 UNION select* from user_2023;
select * from user_2021 UNION select* from user_2022;
select * from user_2021 UNION select* from user_2023;
select * from user_2022 UNION select* from user_2023 UNION select* from user_2021;

-- UNION ALL  Date of both the tables including duplicates
select * from user_2022 UNION ALL select* from user_2023;
select * from user_2021 UNION ALL select* from user_2022;
select * from user_2021 UNION ALL select* from user_2023;
select * from user_2021 UNION ALL select * from user_2022 UNION ALL select* from user_2023;
select * from user_2021 UNION ALL select * from user_2022 UNION  select* from user_2023;

-- EXCEPT
select * from user_2021 EXCEPT select* from user_2022;-- Except dont work in mysql
SELECT u1.* FROM user_2021 u1 LEFT JOIN user_2022 u2 ON u1.userid = u2.userid WHERE u2.userid IS NULL;
SELECT u1.* FROM user_2022 u1 LEFT JOIN user_2021 u2 ON u1.userid = u2.userid WHERE u2.userid IS NULL;
SELECT u1.* FROM user_2021 u1 LEFT JOIN user_2023 u2 ON u1.userid = u2.userid WHERE u2.userid IS NULL;
SELECT u1.* FROM user_2023 u1 LEFT JOIN user_2021 u2 ON u1.userid = u2.userid WHERE u2.userid IS NULL;
SELECT u1.* FROM user_2022 u1 LEFT JOIN user_2023 u2 ON u1.userid = u2.userid WHERE u2.userid IS NULL;
SELECT u1.* FROM user_2023 u1 LEFT JOIN user_2022 u2 ON u1.userid = u2.userid WHERE u2.userid IS NULL;



-- INTERSECT Common data between 2 tables
select * from user_2021 INTERSECT select * from user_2022; -- Intersect dont work in mysql
SELECT u1.* FROM user_2021 u1 INNER JOIN user_2022 u2 ON u1.userid = u2.userid;
SELECT u2.* FROM user_2022 u2 INNER JOIN user_2021 u1 ON u1.userid = u2.userid;
SELECT u1.* FROM user_2021 u1 INNER JOIN user_2023 u3 ON u1.userid = u3.userid;
SELECT u3.* FROM user_2023 u3 INNER JOIN user_2021 u1 ON u1.userid = u3.userid;
SELECT u2.* FROM user_2022 u2 INNER JOIN user_2023 u3 ON u3.userid = u2.userid;
SELECT u3.* FROM user_2023 u3 INNER JOIN user_2022 u2 ON u3.userid = u2.userid;

-- Questions
-- List the New users added in 2022
select u2.* from user_2022 u2 left join user_2021 u1 on u2.userid=u1.userid where u1.userid is null;

-- List the New users added in 2023
select u3.* from user_2023 u3 left join user_2022 u2 on u3.userid=u2.userid where u2.userid is null;

-- List the Users who left us
-- it should be in 2021 but not in either 2022 or 2023
SELECT u1.* FROM user_2021 u1 LEFT JOIN user_2022 u2 ON u1.userid = u2.userid LEFT JOIN user_2023 u3 ON u1.userid = u3.userid
WHERE u2.userid IS NULL OR u3.userid IS NULL;

-- List all the users who are there from 2021 and 2022
SELECT * FROM USER_2021  UNION SELECT * FROM USER_2022;

-- List all the users who are there from 2021-2022-2023
SELECT * FROM USER_2021   UNION SELECT * FROM USER_2022 UNION   SELECT * FROM USER_2023 ;

-- List all the users who are there with us for last 3 years
SELECT user_2021.name FROM USER_2021 INNER JOIN USER_2022 ON USER_2021.USERID=USER_2022.USERID 
INNER JOIN USER_2023 ON USER_2021.USERID=USER_2023.USERID;


-- List all the users EXCEPT who are there with us for last 3 years
-- all union - all intersect

SELECT *FROM (SELECT * FROM user_2021 UNION SELECT * FROM user_2022 UNION SELECT * FROM user_2023) AS all_users
WHERE name NOT IN (SELECT u1.name FROM user_2021 u1 INNER JOIN user_2022 u2 ON u1.name = u2.name INNER JOIN user_2023 u3 ON u1.name = u3.name);

-- Full outer join There is no full outer join in mysql
select * from user_2021 left join user_2022 on user_2021.userid=user_2022.userid
union
select * from user_2021 right join user_2022 on user_2021.userid=user_2022.userid;

-- names not common in both tables
-- names not common in 2021 and 2022
select name from user_2021 where name not in (select name from user_2022)
union
select name from user_2022 where name not in (select name from user_2021);

-- names not common in 2021 and 2023
select name from user_2021 where name not in (select name from user_2023)
union
select name from user_2023 where name not in (select name from user_2021);

-- names not common in 2023 and 2022
select name from user_2022 where name not in (select name from user_2023)
union
select name from user_2023 where name not in (select name from user_2022);











