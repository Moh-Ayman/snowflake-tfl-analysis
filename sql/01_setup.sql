-- 1. Create a new database for the project
CREATE OR REPLACE DATABASE TFL_PORTFOLIO_DB;

-- 2. Create a new, extra-small warehouse for running our queries
-- Using an X-SMALL warehouse is cost-effective for a small dataset like this.
CREATE OR REPLACE WAREHOUSE TFL_PORTFOLIO_WH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60 -- Suspends after 60 seconds of inactivity to save credits
  AUTO_RESUME = TRUE;

-- 3. Use the new database and schema
USE TFL_PORTFOLIO_DB.PUBLIC;