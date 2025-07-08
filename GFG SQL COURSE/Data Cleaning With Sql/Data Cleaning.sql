Data Cleaning
Data cleaning is an essential step in the data preparation process. It ensures that your dataset is accurate, consistent, and usable for analysis.

Step 1: Create and Populate the Messy Dataset
First, lets create a table named messy_indian_dataset and populate it with some messy data, as done in previous examples.

Step 2: Trim and Normalize Text Fields
We start by cleaning up the name, gender, city, and state fields by trimming whitespace and converting the text to lowercase.

-- Update Name

UPDATE messy_indian_dataset

SET name = TRIM(LOWER(name));

SELECT * FROM messy_indian_dataset;

-- Update Gender

UPDATE messy_indian_dataset

SET gender = TRIM(LOWER(gender));

SELECT * FROM messy_indian_dataset;



-- Update City

UPDATE messy_indian_dataset

SET city = TRIM(LOWER(city));

SELECT * FROM messy_indian_dataset;



-- Update State

UPDATE messy_indian_dataset

SET state = TRIM(LOWER(state));

SELECT * FROM messy_indian_dataset;

The name, gender, city, and state fields are trimmed of whitespace and converted to lowercase.

Step 3: Clean Email and Phone Number Fields
Next, we clean the email and phone_number fields by removing invalid characters.

-- Clean & Update email

UPDATE messy_indian_dataset

SET email = TRIM(REGEXP_REPLACE(LOWER(email), '[^a-z0-9@.]+',''));

SELECT * FROM messy_indian_dataset;

Invalid characters are removed from the email field.

-- Clean Phone Number

UPDATE messy_indian_dataset

SET phone_number = REGEXP_REPLACE(phone_number, '[^0-9]+','');

SELECT * FROM messy_indian_dataset;

Non-numeric characters are removed from the phone_number field.

Step 4: Extract Username from Email
We add a new column username and populate it by extracting the part before the @ symbol from the email.

-- Extracting username

ALTER TABLE messy_indian_dataset

ADD COLUMN username VARCHAR(30);



UPDATE messy_indian_dataset

SET username = SUBSTRING_INDEX(email, '@', 1);

SELECT * FROM messy_indian_dataset;

A new username field is added and populated with the part before the @ symbol in the email.

Step 5: Create Location Field
We create a new location field by concatenating city and state.

-- Create location

ALTER TABLE messy_indian_dataset

ADD COLUMN location VARCHAR(50);



UPDATE messy_indian_dataset

SET location = CONCAT(city, ', ', state);

SELECT * FROM messy_indian_dataset;

A new location field is created by concatenating the city and state.

Step 6: Calculate Amount Without GST
We add a new field without_gst and calculate it as 82% of the purchase_amount.

-- amount_without_gst

ALTER TABLE messy_indian_dataset

ADD COLUMN without_gst DECIMAL(10, 2);



UPDATE messy_indian_dataset

SET without_gst = purchase_amount * 0.82;

SELECT * FROM messy_indian_dataset;

A new without_gst field is added and calculated as 82% of the purchase_amount.

Step 7: Add Expiry Date
We add a new exp_date field and calculate it as three years from the purchase_date.

-- Adding Expiry Date

ALTER TABLE messy_indian_dataset

ADD COLUMN exp_date DATE;



UPDATE messy_indian_dataset

SET exp_date = DATE_ADD(purchase_date, INTERVAL 3 YEAR);

SELECT * FROM messy_indian_dataset;

A new exp_date field is added and calculated as three years from the purchase_date.

Step 8: Remove Invalid Phone Numbers
We remove rows where the phone_number is not 10 digits long.

-- Removing rows with Invalid Phone Number

DELETE FROM messy_indian_dataset

WHERE LENGTH(phone_number) != 10 OR phone_number REGEXP '[^0-9]';

SELECT * FROM messy_indian_dataset;

Rows with phone numbers that are not 10 digits long are removed.

Step 9: Standardize Gender Field
We clean up the gender field further by standardizing the values to 'M' for male, 'F' for female, and 'other' for anything else.

-- Cleaning Gender even further

UPDATE messy_indian_dataset

SET gender = CASE

WHEN gender IN ('m', 'male', 'MALE') THEN 'M'

WHEN gender IN ('f', 'female', 'FEMALE') THEN 'F'

ELSE 'other'

END;

SELECT * FROM messy_indian_dataset;

The gender field is standardized to 'M', 'F', or 'other'.

Step 10: Validate Age Field
We remove rows where the age is less than or equal to 0 or greater than or equal to 100.

-- Cleaning/Validating Age

DELETE FROM messy_indian_dataset

WHERE age <= 0 OR age >= 100;

SELECT * FROM messy_indian_dataset;

Rows with invalid ages (<= 0 or >= 100) are removed.

Final Cleaned Dataset
After performing the above steps, our messy_indian_dataset table should be clean and ready for analysis. Here's the final state of our dataset:

SELECT * FROM messy_indian_dataset;
