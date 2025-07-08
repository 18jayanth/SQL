Errors and Exceptions
Errors and exceptions are inevitable when working with SQL databases, ranging from syntax errors to more complex issues like constraint violations and transaction errors. This guide explores various types of SQL errors and how to handle them effectively using examples from a hypothetical scenario involving a food delivery service, Swiggy.

Common Types of SQL Errors
Lets delve into several common types of SQL errors and exceptions, illustrated with examples from the context of managing restaurant data on Swiggy.

1. Syntax Errors
Syntax errors occur due to incorrect SQL syntax.

SELECT * form restaurants;
Error Output:
Error: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'form restaurants' at line 1

2. Logical Exception
Logical exceptions involve queries that return unexpected or contradictory results.

SELECT * FROM restaurants WHERE rating > 4.0 AND rating < 2.0;
Error Output:
Empty set (0.00 sec)

3. Data Type Exception
Data type exceptions occur when inappropriate data types are used in operations.

SELECT * FROM restaurants WHERE rating = 'high';
Error Output:
Error: Operand should contain 1 column(s)

4. Performance Exception
Performance exceptions relate to queries that are inefficient or slow.

SELECT * FROM restaurants WHERE rating = 4.5;
Error Output:
Warning: Using where; Open rows: 2; Opened table: rating; Using 16; To use temporary; Retrieving data: one message in memory 0.00 rows 2

5. Aggregate Function Errors
Aggregate function errors occur when using aggregate functions incorrectly.

SELECT city, COUNT(*) FROM restaurants;
Error Output:
Error: Column 'city' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.

6. Subquery Exception
Subquery exceptions happen when subqueries return unexpected results.

SELECT * FROM restaurants WHERE id = (SELECT id FROM restaurants WHERE city = 'NonExistedCity');
Error Output:
Error: Subquery returned more than 1 value. This is not permitted when the subquery follows =, !=, <, <= , >, >= or when the subquery is used as an expression.

7. Constraint Errors
Constraint errors occur when database constraints are violated.

INSERT INTO restaurants (id, name, city, rating) 
VALUES (301, 'Invalid', 'Mumbai', 6);
Error Output:
Error: Check constraint 'rating_check' is violated.

8. Function Errors
Function errors happen when using SQL functions incorrectly.

SELECT LEFT(name, -3) FROM restaurants;
Error Output:
Error: Invalid length parameter passed to the LEFT or SUBSTRING function.
9. Indexing Errors
Indexing errors occur when indexes are not used properly.

SELECT * FROM restaurants WHERE city = 'Bangalore';
Potential Issue:

Query performance may be poor if there is no index on the 'city' column.

10. Transaction Errors
Transaction errors happen during transaction management.

BEGIN TRANSACTION;
UPDATE restaurants SET rating = 5 WHERE id = 1;
INSERT INTO restaurants (id, name, city, rating) VALUES (1, 'Duplicate', 'Mumbai', 4.5);
COMMIT;
Error Output:
Error: Duplicate entry '1' for key 'PRIMARY'

11. Permission and Access Errors
Permission errors occur when there are insufficient privileges to execute a command.

GRANT SELECT ON restaurants TO 'user1';
Error Output:
Error: You need the SUPER privilege for this operation

12. Temporary Table Errors
Temporary table errors happen when there are issues with temporary table creation or usage.

CREATE TEMPORARY TABLE temp_restaurants (id INT, name VARCHAR(50));
INSERT INTO temp_restaurants (id, name) VALUES (1, 'Temp Restaurant');
SELECT * FROM temp_restaurants;
Potential Issue
Temporary table might not persist across different sessions.

13. Data Import/Export Errors
Data import/export errors occur during data transfer operations.

LOAD DATA INFILE 'path/to/file.csv' INTO TABLE restaurants
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
(id, name, city, rating);
Error Output:
Error: File 'path/to/file.csv' not found (OS errno 2 - No such file or directory)

Exception Handling in SQL
Proper exception handling ensures that errors do not cause the application to crash and provides meaningful error messages.

1. Handling Non-Existent Table Error
DELIMITER //
DROP PROCEDURE IF EXISTS handle_non_existent_table;
CREATE PROCEDURE handle_non_existent_table()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'The table "non_existent_table" does not exist' AS message;
    END;
    SELECT * FROM non_existent_table;
END //
DELIMITER ;


CALL handle_non_existent_table();
Output:
+--------------------------------------------+

| message |

+--------------------------------------------+

| The table "non_existent_table" does not exist |

+--------------------------------------------+

2. Handling Unique Constraint Violation
DELIMITER //
DROP PROCEDURE IF EXISTS handle_unique_violation;
CREATE PROCEDURE handle_unique_violation()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'Duplicate restaurant ID or name found' AS message;
    END;
    INSERT INTO restaurants (id, name, city, rating)
    VALUES (211, 'Tandoori Hut', 'Bangalore', 4.3);
END //
DELIMITER ;


CALL handle_unique_violation();
Output:
+----------------------------------+

| message |

+----------------------------------+

| Duplicate restaurant ID or name found |

+----------------------------------+
