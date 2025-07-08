Handling Duplicate Values
Duplicate values in a dataset can cause inaccuracies and inconsistencies in data analysis. In SQL, there are various methods to identify and handle duplicate values. This article will explore these techniques using a sample dataset called messy_indian_dataset.

Finding Unique Values Based on ID
To find unique values based on a specific column, such as id, we can use GROUP BY:

SELECT id
FROM messy_indian_dataset
GROUP BY id
ORDER BY id;
Output:

id
1
2
3
4
7
8
9
10
Finding Unique Values Based on Name
Similarly, to find unique values based on the name column:

SELECT name
FROM messy_indian_dataset
GROUP BY name
ORDER BY name;
Output:
name
Amit Kumar
Ankit Tiwari
Priya Sharma
Rajesh Patel
Ritu Singh
Swati Gupta
Finding Unique Values Based on ID Using Rank
We can use the ROW_NUMBER window function to assign a unique rank to each row within the partition of a specified column. This helps in selecting unique values based on the id column:

SELECT id, name, age, gender, email, phone_number, city, state, purchase_amount, purchase_date 
FROM (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS 'rank' 
    FROM messy_indian_dataset
) AS subtable
WHERE subtable.rank = 1;
Output:
id	name	age	gender	email	phone_number	city	state	purchase_amount	purchase_date
1	Rajesh Patel	30	Male	rajesh@example.com	9876543210	Mumbai	Maharashtra	1000.50	2023-01-05
2	Priya Sharma	25	Female	priya@example.com	9876543211	Delhi	Delhi	NULL	2023-02-15
3	Amit Kumar	35	Male	amit@example.com	9876543212	Bangalore	Karnataka	750.25	2023-03-25
4	Ritu Singh	28	Female	NULL	9876543213	Kolkata	West Bengal	1200.75	2023-04-10
5	Rajesh Patel	30	Male	rajesh@example.com	9876543210	Mumbai	Maharashtra	1000.50	2023-01-05
6	Priya Sharma	25	Female	priya@example.com	9876543211	Delhi	Delhi	800.00	2023-02-15
7	Amit Kumar	NULL	Male	amit@example.com	NULL	Bangalore	Karnataka	750.25	2023-03-25
8	Ritu Singh	28	Female	ritu@example.com	9876543213	Kolkata	West Bengal	1200.75	2023-04-10
9	Ankit Tiwari	32	Male	ankit@example.com	9876543214	Lucknow	Uttar Pradesh	900.00	2023-05-20
10	Swati Gupta	27	Female	swati@example.com	9876543215	Jaipur	Rajasthan	1500.00	NULL
Finding Unique Values Based on Multiple Columns
By partitioning by multiple columns, we can find unique rows based on a combination of columns such as id and name.

SELECT id, name, age, gender, email, phone_number, city, state, purchase_amount, purchase_date 
FROM (
    SELECT *, ROW_NUMBER() OVER(PARTITION BY id, name ORDER BY id) AS 'rank' 
    FROM messy_indian_dataset
) AS subtable
WHERE subtable.rank = 1;
Output:
id	name	age	gender	email	phone_number	city	state	purchase_amount	purchase_date
1	Rajesh Patel	30	Male	rajesh@example.com	9876543210	Mumbai	Maharashtra	1000.50	2023-01-05
2	Priya Sharma	25	Female	priya@example.com	9876543211	Delhi	Delhi	NULL	2023-02-15
3	Amit Kumar	35	Male	amit@example.com	9876543212	Bangalore	Karnataka	750.25	2023-03-25
4	Ritu Singh	28	Female	NULL	9876543213	Kolkata	West Bengal	1200.75	2023-04-10
5	Rajesh Patel	30	Male	rajesh@example.com	9876543210	Mumbai	Maharashtra	1000.50	2023-01-05
6	Priya Sharma	25	Female	priya@example.com	9876543211	Delhi	Delhi	800.00	2023-02-15
7	Amit Kumar	NULL	Male	amit@example.com	NULL	Bangalore	Karnataka	750.25	2023-03-25
8	Ritu Singh	28	Female	ritu@example.com	9876543213	Kolkata	West Bengal	1200.75	2023-04-10
9	Ankit Tiwari	32	Male	ankit@example.com	9876543214	Lucknow	Uttar Pradesh	900.00	2023-05-20
10	Swati Gupta	27	Female	swati@example.com	9876543215	Jaipur	Rajasthan	1500.00	NULL
Conclusion
Handling duplicates in SQL is crucial for maintaining data integrity and ensuring accurate analysis. By using techniques like DISTINCT, GROUP BY, and window functions like ROW_NUMBER(), you can effectively identify and manage duplicate values in your datasets.
