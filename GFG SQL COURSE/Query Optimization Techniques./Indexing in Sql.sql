
Indexing in SQL is similar to creating a detailed table of contents for a book, enabling the database management system (DBMS) to quickly locate specific rows within a table. It works by creating a structured data structure (the index) that allows for efficient lookup operations based on the values of one or more columns.

How Does Indexing Work?
Imagine a scenario where you need to find all employees with a specific last name in a large company database. Without an index, the DBMS would potentially need to scan every row of the employees table sequentially, which becomes inefficient as the dataset grows. With an index on the last_name column, however, the DBMS can swiftly locate the rows matching the specified last name by directly accessing the index.

Types of Indexes in SQL
SQL databases support several types of indexes, each suited for different data access patterns and query requirements:

Primary Index: Automatically created when defining a primary key constraint. It uniquely identifies each row in a table, facilitating fast retrieval of specific rows.
Unique Index: Ensures that all values in the indexed column(s) are unique. It speeds up searches for unique values and also supports fast lookups.
Non-Unique Index: Allows duplicate values in the indexed column(s) but still speeds up data retrieval operations.
Composite Index: Combines multiple columns into a single index, useful for queries that filter or sort data using multiple columns.
Clustered vs. Non-Clustered Index:
Clustered Index: Organizes the physical order of rows in the table based on the indexed column(s). Each table can have only one clustered index.
Non-Clustered Index: Stores the index separate from the actual data rows, allowing for more flexibility but typically requiring an additional lookup step to retrieve row data.
Benefits of Indexing
Improved Query Performance: Indexes reduce the number of data pages the DBMS needs to read to satisfy a query, resulting in faster data retrieval.
Faster Sorting and Grouping: Indexes can accelerate sorting and grouping operations by providing pre-sorted views of data.
Enhanced Data Integrity: Unique and primary key indexes enforce data integrity by preventing duplicate or null entries in specified columns.
Optimized Joins: Indexes facilitate efficient join operations between tables by reducing the amount of data that needs to be scanned.
1. Simple Index
create index idx_city on messy_indian_dataset(city);

-- Query using the index
select name, city, purchase_amount 
from messy_indian_dataset 
where city = 'Mumbai';
Explanation:
Index Creation (create index idx_city on messy_indian_dataset(city)):
This query creates a simple index named idx_city on the city column of the messy_indian_dataset table.
Indexes are data structures that allow the database system to quickly retrieve rows based on the indexed columns. They enhance query performance for columns frequently used in WHERE, JOIN, and ORDER BY clauses.
Query Execution (select ... where city = 'Mumbai'):
The WHERE clause filters rows where the city column equals 'Mumbai'.
With the idx_city index on city, the database can efficiently locate and retrieve rows matching this condition. It does this by directly accessing the index structure rather than scanning the entire table.
2. Composite Index
-- Drop existing index if it exists
drop index idx_city on messy_indian_dataset;

-- Create a composite index on the 
 and 
 columns
create index idx_city on messy_indian_dataset(city, gender);

-- Query using the composite index
select name, city, purchase_amount 
from messy_indian_dataset 
where city = 'Mumbai';
Explanation:
Composite Index Creation (create index idx_city on messy_indian_dataset(city, gender)):
This query creates a composite index named idx_city on the city and gender columns of the messy_indian_dataset table.
Composite indexes are useful when queries involve multiple columns in conditions, such as WHERE or JOIN clauses involving both city and gender. They are particularly effective when these columns are queried together.
Query Execution (select ... where city = 'Mumbai'):
The query filters rows where the city column equals 'Mumbai'.
The composite index idx_city can still be leveraged efficiently for this query despite gender not being used directly in the WHERE clause. It allows for rapid access to rows matching the specified city.
3. Unique Index
-- Drop existing index if it exists
drop index idx_city on messy_indian_dataset;

-- Create a unique index on the 
 column
create unique index idx_city on messy_indian_dataset(id);

-- Query using the unique index
select name, city, purchase_amount 
from messy_indian_dataset 
where city = 'Mumbai';
Explanation:
Unique Index Creation (create unique index idx_city on messy_indian_dataset(id)):
This query creates a unique index named idx_city on the id column of the messy_indian_dataset table.
Unique indexes enforce uniqueness on the indexed column(s), ensuring that no two rows can have the same id value.
Query Execution (select ... where city = 'Mumbai'):
The query filters rows where the city column equals 'Mumbai'.
Despite the unique index being on the id column, it does not directly impact the execution of this query because the WHERE clause does not involve the id column. The database optimizer will primarily use other available indexes or perform a full table scan.
4. Full-Text Index
-- Drop existing index if it exists
drop index idx_city on messy_indian_dataset;

-- Create a full-text index on the 
 and 
 columns
create fulltext index idx_city on messy_indian_dataset(name, email);

-- Query using the full-text index for full-text search
select name, city, purchase_amount 
from messy_indian_dataset 
where match(name, email) against('Rajesh');
Explanation:
Full-Text Index Creation (create fulltext index idx_city on messy_indian_dataset(name, email)):
This query creates a full-text index named idx_city on the name and email columns of the messy_indian_dataset table.
Full-text indexes are specialized indexes designed for efficiently searching and retrieving text-based data. They are optimized for operations involving natural language processing, such as searching for words or phrases within text columns.
Query Execution (select ... where match(name, email) against('Rajesh')):
The query uses the match ... against syntax to perform a full-text search for the term 'Rajesh' within the name and email columns.
Full-text indexes enable fast retrieval of rows containing the specified search term, using techniques like word stemming and relevance ranking to improve search accuracy and performance.
5. Full-Text Index with Boolean Mode
-- Query using the full-text index in boolean mode
select name, city, purchase_amount 
from messy_indian_dataset 
where match(name, email) against('+Patel -Pooja' in boolean mode);
Explanation:
Query Execution (match ... against('+Patel -Pooja' in boolean mode)):
The match ... against clause is used in boolean mode (IN BOOLEAN MODE) to perform a more complex full-text search.
In boolean mode, you can use operators like + (must include), - (must exclude), and quotes for exact phrases (" "). This allows for precise control over the search criteria, refining the search results based on specific conditions.
Use Case:
The query searches for rows where the name or email columns contain the term Patel (+Patel) and excludes rows where Pooja is present (-Pooja).
Full-text indexes in boolean mode are beneficial for advanced text search scenarios where you need fine-grained control over search criteria and result filtering.
Best Practices for Indexing
To maximize the benefits of indexing while minimizing potential drawbacks like increased storage space and overhead, consider these best practices:

Identify Query Patterns: Analyze frequently executed queries and their access patterns to determine which columns should be indexed.
Use Indexes Sparingly: Avoid over-indexing, as each index consumes storage and may slow down data modification operations (inserts, updates, deletes).
Monitor Index Usage: Regularly monitor index usage and performance metrics to identify unused or underused indexes that can be safely removed.
Index Maintenance: Periodically update statistics and rebuild/reorganize indexes to ensure they remain efficient as data in the table changes over time.
Consider Database-specific Features: Different database systems (e.g., MySQL, PostgreSQL, SQL Server) may have unique indexing features and optimizations. Understand and utilize these features effectively.
