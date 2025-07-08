Transactions in SQL
A transaction in SQL is a sequence of one or more SQL operations treated as a single unit of work. These operations can include queries (SELECT), updates (UPDATE), deletions (DELETE), or insertions (INSERT). The defining characteristic of a transaction is that it must adhere to the ACID properties: Atomicity, Consistency, Isolation, and Durability.

ACID Properties
Atomicity: This ensures that all operations within a transaction are completed successfully. If any operation fails, the entire transaction is rolled back, leaving the database in its initial state before the transaction began. This is often summarized as "all or nothing."

Consistency: Transactions must leave the database in a consistent state. This means that any data written to the database must be valid according to all defined rules, including constraints, cascades, and triggers.

Isolation: This ensures that concurrently executing transactions do not affect each other. The isolation property helps in achieving concurrency control by managing how transaction operations are visible to each other.

Durability: Once a transaction is committed, the changes are permanent, even in the event of a system failure. This means the results of the transaction are reliably stored and can be recovered.

To illustrate how transactions work in SQL, lets take a detailed example of transferring money between two bank accounts. This scenario will demonstrate the atomicity, consistency, isolation, and durability (ACID) properties of transactions.

Scenario
Assume we have two accounts: Account A and Account B. We need to transfer $100 from Account A to Account B. This operation involves two steps:

Deducting $100 from Account A.
Adding $100 to Account B.
Both steps must be completed successfully for the transaction to be valid. If either step fails, the transaction should be rolled back to maintain the consistency of the accounts.

Implementing Transactions in SQL
Lets create a table and insert some data to demonstrate the use of transactions.

Creating and Populating the Table

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

Insert messy data into the table for Indian users

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
Viewing the Data
SELECT * FROM messy_indian_dataset;
Using Transactions
Example 1: Simple Transaction
-- Start a transaction
START TRANSACTION;
UPDATE messy_indian_dataset SET purchase_amount = 1500 WHERE id = 1;
SELECT * FROM messy_indian_dataset;
In this example, we start a transaction, update the purchase amount for a specific user, and then view the updated data. However, we havent committed or rolled back the transaction yet.

Example 2: Transaction with Rollback
-- Start a transaction
START TRANSACTION;
UPDATE messy_indian_dataset SET purchase_amount = 1400 WHERE id = 1;
SELECT * FROM messy_indian_dataset;
ROLLBACK;
SELECT * FROM messy_indian_dataset;
Here, we start a transaction, update the purchase amount, and then roll back the transaction. The final SELECT statement shows that the update was not applied, demonstrating the rollback.

Example 3: Transaction with Commit
-- Start a transaction
START TRANSACTION;
UPDATE messy_indian_dataset SET purchase_amount = 1300 WHERE id = 1;
SELECT * FROM messy_indian_dataset;
COMMIT;
SELECT * FROM messy_indian_dataset;
In this example, we start a transaction, update the purchase amount, and then commit the transaction. The final SELECT statement shows that the update was successfully applied.

Example 4: Commit and Rollback
-- Start a transaction
START TRANSACTION;
INSERT INTO messy_indian_dataset (id, name, age, gender, email, phone_number, city, state, purchase_amount, purchase_date) 
VALUES (11, 'Mahesh Patel', 30, 'Male', 'rajesh@example.com', '9876543210', 'Mumbai', 'Maharashtra', 1000.50, '2023-01-05');
SELECT * FROM messy_indian_dataset WHERE id = 11;
SELECT * FROM messy_indian_dataset;
COMMIT;
ROLLBACK;
SELECT * FROM messy_indian_dataset;
Here, we insert a new record within a transaction and commit it. However, the subsequent rollback has no effect because the transaction was already committed.

Example 5: Commit and Rollback with Multiple Commands
-- Start a transaction
START TRANSACTION;
INSERT INTO messy_indian_dataset (id, name, age, gender, email, phone_number, city, state, purchase_amount, purchase_date) 
VALUES (12, 'Prakash', 30, 'Male', 'rajesh@example.com', '9876543210', 'Mumbai', 'Maharashtra', 1000.50, '2023-01-05');


INSERT INTO messy_indian_dataset (id, name, age, gender, email, phone_number, city, state, purchase_amount, purchase_date) 
VALUES (13, 'Aarti', 30, 'Female', 'rajesh@example.com', '9876543210', 'Mumbai', 'Maharashtra', 1000.50, '2023-01-05');

SELECT * FROM messy_indian_dataset;
COMMIT;
ROLLBACK;
SELECT * FROM messy_indian_dataset;
In this example, we perform multiple inserts within a transaction and commit it. The rollback has no effect after the commit.

Example 6: Rollback with Multiple Commands
-- Start a transaction
START TRANSACTION;
INSERT INTO messy_indian_dataset (id, name, age, gender, email, phone_number, city, state, purchase_amount, purchase_date) 
VALUES (14, 'Prakash', 30, 'Male', 'rajesh@example.com', '9876543210', 'Mumbai', 'Maharashtra', 1000.50, '2023-01-05');

INSERT INTO messy_indian_dataset (id, name, age, gender, email, phone_number, city, state, purchase_amount, purchase_date) 
VALUES (15, 'Aarti', 30, 'Female', 'rajesh@example.com', '9876543210', 'Mumbai', 'Maharashtra', 1000.50, '2023-01-05');

SELECT * FROM messy_indian_dataset;
ROLLBACK;
SELECT * FROM messy_indian_dataset;
In this example, we perform multiple inserts within a transaction but roll it back. The final SELECT statement shows that the inserts were not applied.

