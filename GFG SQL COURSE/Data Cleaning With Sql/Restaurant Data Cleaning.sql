Restaurant Data Cleaning
Data cleaning is a crucial step in the data analysis pipeline, ensuring that datasets are accurate, consistent, and ready for meaningful insights. In this article, we will explore how to clean restaurant data sourced from Swiggy using SQL queries. You can download the dataset here.

Understanding the Dataset
The dataset from Swiggy contains information about various restaurants, including their name, city, cuisine, rating, rating count, cost, and a link that potentially contains useful identifiers like the restaurant ID.

Step-by-Step Data Cleaning Process
We will walk through a series of SQL queries designed to clean and prepare the dataset for analysis.

Step 1: Initial Exploration and Restaurant ID Extraction
Firstly, lets explore the structure of our dataset and extract the restaurant ID from the link.

SELECT *, SUBSTRING_INDEX(link, '-', -1) AS id
FROM restaurants;
Explanation:
SUBSTRING_INDEX: This function extracts the substring after the last '-' in the link column, assuming it contains the restaurant ID.
Step 2: Updating the Dataset with Extracted IDs
Next, we create a temporary table (rest_1) where we incorporate the extracted restaurant ID (new_id) into our dataset.

CREATE TABLE IF NOT EXISTS rest_1 AS
(SELECT *, SUBSTRING_INDEX(link, '-', -1) AS new_id
FROM restaurants);

SELECT * FROM rest_1;
Explanation:
CREATE TABLE AS: This creates a new table rest_1 based on the result of the SELECT query, adding new_id as a new column.
SUBSTRING_INDEX: Again used to extract new_id from the link column.
Step 3: Cleaning the Name Column
In this step, we normalize the restaurant names by converting them to lowercase and removing any leading or trailing whitespace.

CREATE TABLE IF NOT EXISTS rest_2 AS
(SELECT *, LOWER(TRIM(name)) AS new_name
FROM rest_1);

SELECT * FROM rest_2;
Explanation:
LOWER and TRIM: These functions ensure that name is uniformly formatted by converting to lowercase and removing extra spaces.
Step 4: Cleaning City and Cuisine Columns
Here, we clean up the city and cuisine columns by converting them to lowercase and trimming excess spaces.

CREATE TABLE IF NOT EXISTS rest_3 AS
(SELECT new_id, new_name, LOWER(TRIM(city)) AS clean_city,
        rating, rating_count, LOWER(TRIM(cuisine)) AS clean_cuisine, cost
 FROM rest_2);

SELECT * FROM rest_3;
Explanation:
LOWER and TRIM: Applied to city and cuisine columns to standardize their format.
Step 5: Removing Odd Cuisines
Filter out rows with non-standard cuisines that are not useful for our analysis.

CREATE TABLE IF NOT EXISTS rest_4 AS
(SELECT new_id, new_name, clean_city, rating, rating_count,
        clean_cuisine, cost
 FROM rest_3
 WHERE clean_cuisine NOT IN ('combo', 'na', 'discount offer from garden cafe express kankurgachi', 
                            'svanidhi street food vendor', 'tex-mex',
                            'special discount from (hotel swagath)',
                            'free delivery ! limited stocks!'));

SELECT * FROM rest_4;
Explanation:
NOT IN: Filters out rows where clean_cuisine matches any of the specified non-standard values.

Step 6: Clean-Up and Final Steps
Finally, drop temporary tables (rest_1, rest_2, rest_3) used during the cleaning process to keep the environment tidy.

-- Clean-Up: Drop temporary tables

DROP TABLE IF EXISTS rest_1, rest_2, rest_3;
Conclusion
By following these SQL queries, we have successfully cleaned and standardized the restaurant data from Swiggy. Each step ensures that our dataset is prepared for analysis, eliminating inconsistencies and ensuring accurate insights can be drawn from the data.

