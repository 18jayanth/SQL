Working with Dates
Dates play a crucial role in data analysis, especially when it comes to tracking changes over time, generating reports, and making data-driven decisions. In SQL, handling dates can involve various operations such as extracting components, formatting, and performing calculations. Lets explore how to work with dates using SQL with practical examples.

Extracting Components of a Date
To work with specific components of a date, such as the day, month, or year, you can use SQL functions like DAY(), MONTH(), and YEAR(). Lets add these components to our table:

ALTER TABLE messy_indian_dataset
    ADD COLUMN day INT,
    ADD COLUMN month INT,
    ADD COLUMN year INT;

UPDATE messy_indian_dataset
    SET day = DAY(purchase_date),
        month = MONTH(purchase_date),
        year = YEAR(purchase_date);

SELECT * FROM messy_indian_dataset;
id	name	age	gender	email	phone_number	city	state	purchase_amount	purchase_date	day	month	year
1	Rajesh Patel	30	Male	rajesh@example.com	9876543210	Mumbai	Maharashtra	1000.50	2023-01-05	5	1	2023
2	Priya Sharma	25	Female	priya@example.com	9876543211	Delhi	Delhi	5000.00	2023-02-15	15	2	2023
3	Amit Kumar	35	Male	amit@example.com	9876543212	Bangalore	Karnataka	750.25	2023-03-25	25	3	2023
4	Ritu Singh	28	Female	ritu@example.com	9876543213	Kolkata	West Bengal	1200.75	2023-04-10	10	4	2023
5	Ankit Tiwari	32	Male	ankit@example.com	9876543214	Lucknow	Uttar Pradesh	900.00	2023-05-20	20	5	2023
6	Swati Gupta	27	Female	swati@example.com	9876543215	Jaipur	Rajasthan	1500.00	2023-06-05	5	6	2023
Adding a Column for Day of the Week
To add a column that stores the name of the day of the week (e.g., Monday, Tuesday), we alter the table and update the new column:

ALTER TABLE messy_indian_dataset
    ADD COLUMN day_of_week VARCHAR(10);

UPDATE messy_indian_dataset
    SET day_of_week = DAYNAME(purchase_date);
Output:
id	name	age	gender	email	phone_number	city	state	purchase_amount	purchase_date	day_of_week
1	Rajesh Patel	30	Male	rajesh@example.com	9876543210	Mumbai	Maharashtra	1000.50	2023-01-05	Thursday
2	Priya Sharma	25	Female	priya@example.com	9876543211	Delhi	Delhi	5000.00	2023-02-15	Wednesday
3	Amit Kumar	35	Male	amit@example.com	9876543212	Bangalore	Karnataka	750.25	2023-03-25	Saturday
4	Ritu Singh	28	Female	ritu@example.com	9876543213	Kolkata	West Bengal	1200.75	2023-04-10	Monday
5	Ankit Tiwari	32	Male	ankit@example.com	9876543214	Lucknow	Uttar Pradesh	900.00	2023-05-20	Saturday
6	Swati Gupta	27	Female	swati@example.com	9876543215	Jaipur	Rajasthan	1500.00	2023-06-05	Monday
Adding a Column for Month Name
Similarly, to add a column that stores the name of the month (e.g., January, February), we alter the table and update the new column:

ALTER TABLE messy_indian_dataset
    ADD COLUMN month_name VARCHAR(10);

UPDATE messy_indian_dataset
    SET month_name = MONTHNAME(purchase_date);
Output:
id	name	age	gender	email	phone_number	city	state	purchase_amount	purchase_date	month_name
1	Rajesh Patel	30	Male	rajesh@example.com	9876543210	Mumbai	Maharashtra	1000.50	2023-01-05	January
2	Priya Sharma	25	Female	priya@example.com	9876543211	Delhi	Delhi	5000.00	2023-02-15	February
3	Amit Kumar	35	Male	amit@example.com	9876543212	Bangalore	Karnataka	750.25	2023-03-25	March
4	Ritu Singh	28	Female	ritu@example.com	9876543213	Kolkata	West Bengal	1200.75	2023-04-10	April
5	Ankit Tiwari	32	Male	ankit@example.com	9876543214	Lucknow	Uttar Pradesh	900.00	2023-05-20	May
6	Swati Gupta	27	Female	swati@example.com	9876543215	Jaipur	Rajasthan	1500.00	2023-06-05	June
Conclusion
Working with dates in SQL allows you to extract and manipulate temporal data effectively. By adding and updating columns for day, month, year, day of the week, and month name, you enhance your dataset with additional temporal context. These operations facilitate better analysis and reporting, enabling deeper insights into your data based on temporal characteristics.

