
Common Table Expressions (CTEs) are a powerful feature in SQL that allow for better readability, modularity, and performance in complex queries. Introduced in SQL Server 2005 and later adopted by other database systems like PostgreSQL, MySQL, and Oracle, CTEs provide a way to define temporary result sets that can be referenced within a query.

What is a Common Table Expression (CTE)?
A Common Table Expression (CTE) is a named temporary result set that exists within the scope of a single SQL statement. It helps simplify complex queries by breaking them into smaller, more manageable parts. Essentially, a CTE is a query declaration that behaves like a temporary table or a view, but it only exists for the duration of the query.

Syntax of CTE
The syntax for creating a CTE involves two main parts:

WITH cte_name (column_list) AS (
    -- CTE query definition
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition
)
-- Main query using CTE
SELECT *
FROM cte_name;
WITH clause: This begins the CTE definition. It includes the name of the CTE (cte_name) and optionally a list of column names (column_list) that the CTE will return.

CTE query definition: This is a regular SQL SELECT statement that defines the data to be included in the CTE. It can include filtering, joining tables, aggregating data, or any other valid SQL operations.

Main query: This is the query that uses the CTE. It references the CTE by its name (cte_name) as if it were a table or view.

Advantages of Using CTEs
Code Reusability: CTEs allow complex logic to be defined once and referenced multiple times within the same query, enhancing code reusability and maintainability.
Improved Readability: By breaking down complex queries into smaller, named parts, CTEs improve query readability, making it easier to understand and debug SQL code.
Optimization: Database engines can optimize CTEs like they would with views, potentially improving query performance by optimizing execution plans.
Recursive Queries: CTEs can be recursive, enabling queries that iterate over hierarchical or recursive data structures, such as organizational charts or bill of materials.
Practical Examples
Example 1: Original Query vs. Simplified Query Using CTE
Original Query:
SELECT id, name, city, purchase_amount
FROM messy_indian_dataset
WHERE city = 'Mumbai' AND purchase_amount > 1000 AND gender = 'Male';
Simplified Query Using CTE:
WITH MumbaiHighSpenders AS (
    SELECT id, name, city, purchase_amount
    FROM messy_indian_dataset
    WHERE city = 'Mumbai' AND purchase_amount > 1000 AND gender = 'Male'
)
SELECT id, name, city, purchase_amount
FROM MumbaiHighSpenders;
id	name	city	purchase_amount
1	Rajesh Patel	Mumbai	1000.50
5	Rajesh Patel	Mumbai	1000.50
Explanation:
Original Query: Retrieves records from messy_indian_dataset where city is 'Mumbai', purchase_amount is greater than 1000, and gender is 'Male'.
Simplified Query Using CTE: Defines a CTE named MumbaiHighSpenders that filters data based on the same conditions as the original query. The main query then selects all columns from this CTE. This approach enhances readability by separating the filtering logic into a named subquery (MumbaiHighSpenders).
Example 2: Simplifying Complex Queries
WITH ComplexQuery AS (
    SELECT c.customer_id, c.name, SUM(o.order_total) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE c.city = 'New York' AND o.order_date >= '2023-01-01'
    GROUP BY c.customer_id, c.name
    HAVING SUM(o.order_total) > 5000
)
SELECT *
FROM ComplexQuery;
customer_id	name	total_spent
101

John Doe

6000.00
102

Jane Smith

7500.00
Explanation:
This example demonstrates using a CTE named ComplexQuery to simplify a complex query involving joins, aggregation, filtering (WHERE), and grouping (GROUP BY). The CTE calculates the total amount spent by customers from New York since January 1, 2023, and filters out customers whose total spend exceeds 5000. The main query then selects all columns from this CTE, making the query more modular and easier to understand.

Example 3: Reusing the Same Subquery
WITH TopCustomers AS (
    SELECT customer_id, SUM(order_total) AS total_spent
    FROM orders
    GROUP BY customer_id
    HAVING SUM(order_total) > 10000
)
SELECT c.name, tc.total_spent
FROM customers c
JOIN TopCustomers tc ON c.customer_id = tc.customer_id;
name	total_spent
John Doe	15000.00
Jane Smith	12000.00
Explanation:
In this example, the TopCustomers CTE identifies customers whose total spending on orders exceeds 10,000. The main query then joins this CTE with the customers table to retrieve the names and total spending of these top customers. This approach avoids duplicating the subquery logic and improves query maintenance.

Example 4: Improving Aggregation Performance
WITH PreAggregated AS (
    SELECT 
        city, 
        COUNT(*) AS num_purchases, 
        SUM(purchase_amount) AS total_purchase, 
        AVG(purchase_amount) AS avg_purchase, 
        MAX(purchase_amount) AS max_purchase
    FROM messy_indian_dataset
    GROUP BY city
)
SELECT 
    p.city, 
    p.num_purchases, 
    p.total_purchase, 
    p.avg_purchase, 
    p.max_purchase
FROM PreAggregated p
WHERE p.total_purchase > 100;
city	num_purchases	total_purchase	avg_purchase	max_purchase
Mumbai	2	2001.00	1000.50	1000.50
Delhi	2	1600.75	800.38	800.00
Bangalore	2	1500.50	750.25	750.25
Kolkata	2	2401.50	1200.75	1200.75
Lucknow	2	1950.50	975.25	900.00
Jaipur	3	4200.00	1400.00	1500.00
Chennai	1	1100.50	1100.50	1100.50
Hyderabad	1	850.25	850.25	850.25
Pune	1	950.75	950.75	950.75
Ahmedabad	1	1300.00	1300.00	1300.00
Surat	1	1150.50	1150.50	1150.50
Varanasi	1	850.00	850.00	850.00
Indore	1	1250.25	1250.25	1250.25
Kochi	1	900.75	900.75	900.75
Nagpur	1	1000.75	1000.75	1000.75
Nashik	1	1150.50	1150.50	1150.50
Patna	1	1250.25	1250.25	1250.25
Chandigarh	1	1200.75	1200.75	1200.75
Jaipur	1	1300.00	1300.00	1300.00
Jodhpur	1	1400.25	1400.25	1400.25
Explanation:
The PreAggregated CTE computes aggregated metrics (COUNT, SUM, AVG, MAX) for purchase_amount grouped by city. This pre-aggregation reduces the amount of data processed and improves query performance. The main query then selects cities where the total purchase amount exceeds 100. This strategy leverages CTEs to optimize aggregation operations and enhance query efficiency.

