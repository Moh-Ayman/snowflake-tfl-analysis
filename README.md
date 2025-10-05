# London Public Transport Analysis with Snowflake & Looker Studio

## Introduction
This project analyzes over a decade of public transport data from Transport for London (TfL). The goal was to build a complete end-to-end data pipeline, from raw data ingestion and transformation in Snowflake to visualization in an interactive business intelligence dashboard.

**Live Dashboard Link:** [Link to your published Looker Studio or Tableau Public report]

![Dashboard Screenshot](dashboard/dashboard_screenshot.png)

## Tech Stack
- **Data Warehouse:** Snowflake
- **Data Transformation:** SQL
- **BI & Visualization:** Looker Studio (or Tableau)
- **Code Repository:** Git / GitHub

## Project Steps
1.  **Setup:** A dedicated database (`TFL_PORTFOLIO_DB`) and virtual warehouse (`TFL_PORTFOLIO_WH`) were created in Snowflake.
2.  **Data Loading:** Raw CSV data was loaded into a staging table (`JOURNEYS_STAGING`).
3.  **Transformation:** An SQL script (`02_transform.sql`) was used to clean the data, convert data types, and handle NULLs, creating a production-ready table (`JOURNEYS_PROD`).
4.  **Analysis:** SQL views were created (`03_analysis_views.sql`) to pre-aggregate and analyze the data, providing a semantic layer for the BI tool. I used advanced functions like `RANK()` to derive deeper insights.
5.  **Visualization:** Looker Studio was connected directly to the Snowflake views to build an interactive dashboard exploring trends over time and transport popularity.

## Key Insights
- **Buses are King:** Buses are consistently the most used form of public transport, with over 24 billion journeys in the dataset.
- **The COVID-19 Impact:** All transport methods saw a dramatic decline in ridership starting in 2020, with Underground & DLR travel being the most affected.
- **Emirates Airline Seasonality:** The Emirates Airline cable car shows peak ridership during the spring and summer months (April-June), suggesting it is used more for tourism than commuting.

## How to Reproduce
1. Clone this repository.
2. Create a Snowflake account and run the scripts in the `/sql` folder in order.
3. You will need to upload the `tfl_journeys_final.csv` data (not included in the repo) during the `02_transform.sql` step.