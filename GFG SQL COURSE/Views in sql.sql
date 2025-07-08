Views in SQL
Views in SQL are a powerful feature that allows users to encapsulate complex queries into a virtual table. A view provides a way to simplify data access, enhance security, and maintain data consistency.

What is a View?
A view in SQL is a virtual table based on the result set of a SELECT query. Unlike a physical table, a view does not store data physically. Instead, it dynamically retrieves data from one or more tables whenever it is queried. Views can be used to simplify complex queries, present data in a specific format, or restrict access to sensitive data.

Creating a View
To create a view, the CREATE VIEW statement is used, followed by the view name and the SELECT query that defines the view.

Uses of a View
A good database should contain views for the given reasons:

Restricting data access – Views provide an additional level of table security by restricting access to a predetermined set of rows and columns of a table.
Hiding data complexity – A view can hide the complexity that exists in multiple joined tables.
Simplify commands for the user – Views allow the user to select information from multiple tables without requiring the users to actually know how to perform a join.
Store complex queries – Views can be used to store complex queries.
Rename Columns – Views can also be used to rename the columns without affecting the base tables provided the number of columns in view must match the number of columns specified in a select statement. Thus, renaming helps to hide the names of the columns of the base tables.
Multiple view facility – Different views can be created on the same table for different users.
Practical Examples
Let's explore SQL views using a series of practical examples, using the given in the restaurant's dataset

Example 1: Creating a Basic View
First, we create a view named rest which contains selected columns from the restaurants table and a calculated column for revenue.

DROP VIEW IF EXISTS rest;
CREATE VIEW rest AS (
    SELECT name, city, rating, rating_count AS 'orders', 
           cuisine, cost, cost * rating_count AS 'revenue' 
    FROM restaurants
);
SELECT * FROM rest;
In this example:

We drop the view rest if it already exists.
We create the view rest with selected columns: name, city, rating, rating_count (aliased as orders), cuisine, cost, and a calculated column revenue (cost multiplied by the number of orders).
Example 2: Creating a User View
Next, we create a view user_view for end-users, which hides some columns like revenue.

DROP VIEW IF EXISTS user_view;
CREATE VIEW user_view AS (
    SELECT name, city, rating, rating_count AS 'orders', 
           cuisine, cost 
    FROM restaurants
);
SELECT * FROM user_view;
In this example:

We create a view user_view that excludes sensitive or irrelevant columns such as revenue. This is useful for presenting simplified data to end-users.
Example 3: View for Specific Cuisine
We create a view rest_of_sweet_dishes that lists restaurants specializing in sweet dishes.

DROP VIEW IF EXISTS rest_of_sweet_dishes;
CREATE VIEW rest_of_sweet_dishes AS (
    SELECT * 
    FROM restaurants 
    WHERE cuisine IN ('Sweets', 'Desserts', 'Bakery', 'Ice Cream')
);
SELECT * FROM rest_of_sweet_dishes;
In this example:

The view rest_of_sweet_dishes filters restaurants that offer specific types of cuisine like sweets, desserts, bakery items, or ice cream.
Example 4: View for Top 100 Restaurants
We create a view top_100 to display the top 100 restaurants based on the number of orders.

DROP VIEW IF EXISTS top_100;
CREATE VIEW top_100 AS (
    SELECT * 
    FROM restaurants 
    ORDER BY rating_count DESC 
    LIMIT 100
);
SELECT * FROM top_100;
In this example:

The view top_100 lists the top 100 restaurants with the highest number of orders (rating_count).
Example 5: View for Restaurants with At Least 100 Visitors
We create a view least_100 that shows the top 100 restaurants with the fewest visitors.

DROP VIEW IF EXISTS least_100;
CREATE VIEW least_100 AS (
    SELECT * 
    FROM restaurants 
    ORDER BY rating_count ASC 
    LIMIT 100
);
SELECT * FROM least_100;
In this example:

The view least_100 lists the top 100 restaurants with the lowest number of visitors, which might be useful for identifying underperforming restaurants.
Example 6: View for Top 1000 Most Expensive Restaurants
We create a view top_1000_exp for the most expensive restaurants.

DROP VIEW IF EXISTS top_1000_exp;
CREATE VIEW top_1000_exp AS (
    SELECT * 
    FROM restaurants 
    ORDER BY cost DESC 
    LIMIT 1000
);
SELECT * FROM top_1000_exp;
In this example:

The view top_1000_exp lists the top 1000 restaurants based on the cost of their offerings.
Example 7: Top-Rated Restaurants in Each City
Finally, we create a view top_rated_rest_per_city to display the top-rated restaurant in each city.

DROP VIEW IF EXISTS top_rated_rest_per_city;
CREATE VIEW top_rated_rest_per_city AS (
    SELECT * 
    FROM ( 
        SELECT *,  ROW_NUMBER() OVER(PARTITION BY city ORDER BY rating * rating_count DESC) AS 'rank' 
        FROM restaurants
    ) AS ranked_table
    WHERE ranked_table.rank = 1
);
SELECT * FROM top_rated_rest_per_city;
In this example:
We use a subquery with ROW_NUMBER() to rank restaurants within each city based on a combination of rating and number of orders.
The outer query filters to include only the top-ranked restaurant in each city.
