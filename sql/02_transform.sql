-- Create a table to stage the raw CSV data
CREATE OR REPLACE TABLE JOURNEYS_STAGING (
    MONTH VARCHAR,
    YEAR VARCHAR,
    DAYS VARCHAR,
    REPORT_DATE VARCHAR,
    JOURNEY_TYPE VARCHAR,
    JOURNEYS_MILLIONS VARCHAR
);

-- Create a clean, well-typed table from the raw staging data
CREATE OR REPLACE TABLE JOURNEYS_PROD AS
SELECT
    TRY_TO_NUMBER(MONTH) AS month,
    TRY_TO_NUMBER(YEAR) AS year,
    TRY_TO_NUMBER(DAYS) AS days,
    -- Convert 'MM/DD/YYYY' text to a proper date format
    TRY_TO_DATE(REPORT_DATE, 'MM/DD/YYYY') AS report_date,
    JOURNEY_TYPE AS journey_type,
    -- Convert empty strings to NULL and then cast to a number
    TRY_TO_NUMBER(NULLIF(JOURNEYS_MILLIONS, '')) AS journeys_millions
FROM
    JOURNEYS_STAGING;