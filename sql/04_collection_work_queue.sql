/*

CREDIT CARD COLLECTIONS & DELINQUENCY RISK ANALYTICS
04 - COLLECTION WORK QUEUE

Purpose:
Create a prioritized customer-level review queue for delinquent accounts based on collection priority and financial exposure.
*/


-- 1. TOP DELINQUENT ACCOUNTS WITHIN EACH PRIORITY SEGMENT

WITH delinquent_accounts AS (

    SELECT
        customer_id,
        collection_priority,
        risk_segment,
        delinquency_severity,
        recent_delinquency,
        months_delinquent_6m,
        behavioral_risk_score,
        current_exposure

    FROM credit_risk_analytics

    WHERE recent_delinquency > 0
),

ranked_accounts AS (

    SELECT
        *,

        ROW_NUMBER() OVER (
            PARTITION BY collection_priority
            ORDER BY current_exposure DESC
        ) AS exposure_rank

    FROM delinquent_accounts
)

SELECT
    customer_id,
    collection_priority,
    risk_segment,
    delinquency_severity,
    recent_delinquency,
    months_delinquent_6m,
    behavioral_risk_score,
    current_exposure,
    exposure_rank

FROM ranked_accounts

WHERE exposure_rank <= 10

ORDER BY
    collection_priority,
    exposure_rank;



-- 2. CRITICAL ACCOUNT RUNNING EXPOSURE


WITH critical_accounts AS (

    SELECT
        customer_id,
        current_exposure,

        ROW_NUMBER() OVER (
            ORDER BY current_exposure DESC
        ) AS exposure_rank

    FROM credit_risk_analytics

    WHERE collection_priority = 'Critical'
      AND recent_delinquency > 0
)

SELECT
    customer_id,
    exposure_rank,
    current_exposure,

    SUM(current_exposure) OVER (
        ORDER BY current_exposure DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS cumulative_exposure

FROM critical_accounts

ORDER BY exposure_rank

LIMIT 50;