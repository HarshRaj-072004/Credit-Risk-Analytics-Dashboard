/*
CREDIT CARD COLLECTIONS & DELINQUENCY RISK ANALYTICS
03 - COLLECTION PRIORITY ANALYSIS

Purpose:
Evaluate collection-priority segments using customer risk,
default behavior, and financial exposure to support collections resource prioritization.
*/


-- 1. COLLECTION PRIORITY PERFORMANCE


SELECT
    collection_priority,

    COUNT(*) AS customers,

    SUM(default_next_month) AS defaults,

    ROUND(
        AVG(default_next_month) * 100,
        2
    ) AS default_rate_pct,

    SUM(current_exposure) AS total_exposure,

    ROUND(
        AVG(current_exposure),
        2
    ) AS avg_exposure,

    ROUND(
        SUM(current_exposure) * 100.0
        / SUM(SUM(current_exposure)) OVER (),
        2
    ) AS exposure_share_pct

FROM credit_risk_analytics

GROUP BY collection_priority

ORDER BY avg_exposure DESC;



-- 2. DELINQUENT ACCOUNTS BY COLLECTION PRIORITY


WITH delinquent_accounts AS (

    SELECT
        customer_id,
        collection_priority,
        risk_segment,
        recent_delinquency,
        current_exposure,
        default_next_month

    FROM credit_risk_analytics

    WHERE recent_delinquency > 0
)

SELECT
    collection_priority,

    COUNT(*) AS delinquent_customers,

    SUM(current_exposure) AS delinquent_exposure,

    ROUND(
        AVG(current_exposure),
        2
    ) AS avg_exposure,

    ROUND(
        AVG(default_next_month) * 100,
        2
    ) AS default_rate_pct

FROM delinquent_accounts

GROUP BY collection_priority

ORDER BY delinquent_exposure DESC;



-- 3. CRITICAL ACCOUNT EXPOSURE CONCENTRATION


WITH ranked_critical AS (

    SELECT
        customer_id,
        current_exposure,

        ROW_NUMBER() OVER (
            ORDER BY current_exposure DESC
        ) AS exposure_rank

    FROM credit_risk_analytics

    WHERE collection_priority = 'Critical'
      AND recent_delinquency > 0
),

total_critical AS (

    SELECT
        SUM(current_exposure) AS total_critical_exposure
    FROM ranked_critical
)

SELECT
    SUM(
        CASE
            WHEN exposure_rank <= 10
            THEN current_exposure
            ELSE 0
        END
    ) AS top_10_exposure,

    ROUND(
        SUM(
            CASE
                WHEN exposure_rank <= 10
                THEN current_exposure
                ELSE 0
            END
        ) * 100.0
        / MAX(total_critical_exposure),
        2
    ) AS top_10_share_pct,

    SUM(
        CASE
            WHEN exposure_rank <= 25
            THEN current_exposure
            ELSE 0
        END
    ) AS top_25_exposure,

    ROUND(
        SUM(
            CASE
                WHEN exposure_rank <= 25
                THEN current_exposure
                ELSE 0
            END
        ) * 100.0
        / MAX(total_critical_exposure),
        2
    ) AS top_25_share_pct,

    SUM(
        CASE
            WHEN exposure_rank <= 50
            THEN current_exposure
            ELSE 0
        END
    ) AS top_50_exposure,

    ROUND(
        SUM(
            CASE
                WHEN exposure_rank <= 50
                THEN current_exposure
                ELSE 0
            END
        ) * 100.0
        / MAX(total_critical_exposure),
        2
    ) AS top_50_share_pct

FROM ranked_critical

CROSS JOIN total_critical;