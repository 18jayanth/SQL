Handling Missing Values
Handling missing values is a crucial aspect of data cleaning and preprocessing. In SQL, there are various techniques to identify, manage, and replace missing values to ensure the integrity and usability of the dataset. This article will discuss different methods for dealing with missing values using a sample dataset.

Sample Dataset
Lets begin with the messy_indian_dataset table, which contains some missing values.

DROP TABLE IF EXISTS messy_indian_dataset;
CREATE TABLE IF NOT EXISTS messy_indian_dataset (
    id INT,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    purchase_amount DECIMAL(10, 2),
    purchase_date DATE
);
-- Insert messy data into the table for Indian users
INSERT INTO messy_indian_dataset (id, name, age, gender, email, phone_number, city, state, purchase_amount, purchase_date) VALUES
(1, 'Rajesh Patel', 30, 'Male', 'rajesh@example.com', '9876543210', 'Mumbai', 'Maharashtra', 1000.50, '2023-01-05'),
(2, 'Priya Sharma', 25, 'Female', 'priya@example.com', '9876543211', 'Delhi', 'Delhi', NULL, '2023-02-15'),
(3, 'Amit Kumar', 35, 'Male', 'amit@example.com', '9876543212', 'Bangalore', 'Karnataka', 750.25, '2023-03-25'),
(4, 'Ritu Singh', 28, 'Female', NULL, '9876543213', 'Kolkata', 'West Bengal', 1200.75, '2023-04-10'),
(5, 'Rajesh Patel', 30, 'Male', 'rajesh@example.com', '9876543210', 'Mumbai', 'Maharashtra', 1000.50, '2023-01-05'),
(6, 'Priya Sharma', 25, 'Female', 'priya@example.com', '9876543211', 'Delhi', 'Delhi', 800.00, '2023-02-15'),
(7, 'Amit Kumar', NULL, 'Male', 'amit@example.com', NULL, 'Bangalore', 'Karnataka', 750.25, '2023-03-25'),
(8, 'Ritu Singh', 28, 'Female', 'ritu@example.com', '9876543213', 'Kolkata', 'West Bengal', 1200.75, '2023-04-10'),
(9, 'Ankit Tiwari', 32, 'Male', 'ankit@example.com', '9876543214', 'Lucknow', 'Uttar Pradesh', 900.00, '2023-05-20'),
(10, 'Swati Gupta', 27, 'Female', 'swati@example.com', '9876543215', 'Jaipur', 'Rajasthan', 1500.00, NULL);
Finding Missing Values
To identify rows with missing values, we can use the following query:

SELECT * FROM messy_indian_dataset 
WHERE name IS NULL OR age IS NULL OR gender IS NULL OR email IS NULL OR city IS NULL OR
    phone_number IS NULL OR state IS NULL OR purchase_amount IS NULL OR purchase_date IS NULL;
This query returns rows where any column contains a NULL value.

Finding Rows Without Missing Values
To find rows that have no missing values, use:

SELECT * FROM messy_indian_dataset 
WHERE name IS NOT NULL AND age IS NOT NULL AND gender IS NOT NULL AND email IS NOT NULL AND city IS NOT NULL AND
    phone_number IS NOT NULL AND state IS NOT NULL AND purchase_amount IS NOT NULL AND purchase_date IS NOT NULL;
This query ensures that only complete records are returned.

Saving a Clean Table
You can save the rows without missing values into a new table:

CREATE TABLE IF NOT EXISTS clean_table AS
SELECT * FROM messy_indian_dataset 
WHERE name IS NOT NULL AND age IS NOT NULL AND gender IS NOT NULL AND email IS NOT NULL AND city IS NOT NULL AND
    phone_number IS NOT NULL AND state IS NOT NULL AND purchase_amount IS NOT NULL AND purchase_date IS NOT NULL;

SELECT * FROM clean_table;
Filling Missing Values with Specific Values
1. Filling Missing Age
To fill missing age values with a specific value (e.g., 0), use:

UPDATE messy_indian_dataset SET age = COALESCE(age, 0);
SELECT * FROM messy_indian_dataset;
2. Filling Other Null Values
To fill other columns with specific values, use:

UPDATE messy_indian_dataset 
SET
    name = COALESCE(name, 'Unknown'),
    gender = COALESCE(gender, 'Unknown'),
    email = COALESCE(email, 'Unknown'),
    phone_number = COALESCE(phone_number, 'Unknown'),
    state = COALESCE(state, 'Unknown'),
    purchase_date = COALESCE(purchase_date, '2023-01-01');

SELECT * FROM messy_indian_dataset;
Filling Missing Values with Calculated Values
1. Filling Null Purchase Amount with Average Amount
To fill missing purchase amounts with the average purchase amount, use:

UPDATE messy_indian_dataset
SET purchase_amount = (
    SELECT AVG(purchase_amount) 
    FROM messy_indian_dataset
)
WHERE purchase_amount IS NULL;

SELECT * FROM messy_indian_dataset;
2. Filling Null City with Most Frequent City
To fill missing city values with the most frequent city, use:

UPDATE messy_indian_dataset 
SET city = (
    SELECT city FROM (
        SELECT city, COUNT(*) AS frequency 
        FROM messy_indian_dataset
        WHERE city IS NOT NULL
        GROUP BY city
        ORDER BY frequency DESC
        LIMIT 1
    ) AS subquery
) WHERE city IS NULL;

SELECT * FROM messy_indian_dataset;
