-- View 1: Yearly aggregated journey data
CREATE OR REPLACE VIEW V_YEARLY_JOURNEY_SUMMARY AS
SELECT
    year,
    journey_type,
    SUM(journeys_millions) AS total_journeys_millions,
    AVG(journeys_millions) AS avg_monthly_journeys_millions
FROM
    JOURNEYS_PROD
WHERE
    journeys_millions IS NOT NULL
GROUP BY
    year, journey_type;

-- View 2: Ranks journey types by popularity within each year
CREATE OR REPLACE VIEW V_YEARLY_POPULARITY_RANKING AS
SELECT
    year,
    journey_type,
    SUM(journeys_millions) AS total_journeys_millions,
    RANK() OVER (PARTITION BY year ORDER BY SUM(journeys_millions) DESC) AS popularity_rank
FROM
    JOURNEYS_PROD
WHERE
    journeys_millions IS NOT NULL
GROUP BY
    year, journey_type;

-- View 3: Creates a 2019 pre-pandemic baseline for comparison
CREATE OR REPLACE VIEW V_PRECOVID_BASELINE_2019 AS
SELECT
    journey_type,
    SUM(journeys_millions) AS total_2019_journeys
FROM
    JOURNEYS_PROD
WHERE
    year = 2019
GROUP BY
    journey_type;

-- View 4: Calculates yearly performance against the 2019 baseline
CREATE OR REPLACE VIEW V_RECOVERY_ANALYSIS AS
SELECT
    yearly.year,
    yearly.journey_type,
    yearly.total_journeys_millions,
    baseline.total_2019_journeys,
    -- Calculate the percentage of recovery. DIV0 ensures we don't get an error if baseline is zero.
    DIV0(yearly.total_journeys_millions, baseline.total_2019_journeys) AS pct_of_2019_level
FROM
    V_YEARLY_JOURNEY_SUMMARY AS yearly
LEFT JOIN
    V_PRECOVID_BASELINE_2019 AS baseline
    ON yearly.journey_type = baseline.journey_type
WHERE
    yearly.year >= 2019; -- Focus on the relevant period