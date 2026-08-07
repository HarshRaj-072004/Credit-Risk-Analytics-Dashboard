/*
CREDIT CARD COLLECTIONS & DELINQUENCY RISK ANALYTICS
02 - DELINQUENCY ANALYSIS


Purpose:
Analyze how recent delinquency behavior relates to default risk and identify where delinquent exposure is concentrated.
*/

-- 1. DEFAULT RISK BY RECENT DELINQUENCY


SELECT
    CASE
        WHEN recent_delinquency <= 0 THEN 'Current'
        WHEN recent_delinquency = 1 THEN '1 Month Delinquent'
        WHEN recent_delinquency = 2 THEN '2 Months Delinquent'
        ELSE '3+ Months Delinquent'
    END AS delinquency_bucket,

    COUNT(*) AS customers,

    SUM(current_exposure) AS total_exposure,

    ROUND(
        AVG(default_next_month) * 100,
        2
    ) AS default_rate_pct

FROM credit_risk_analytics

GROUP BY
    CASE
        WHEN recent_delinquency <= 0 THEN 'Current'
        WHEN recent_delinquency = 1 THEN '1 Month Delinquent'
        WHEN recent_delinquency = 2 THEN '2 Months Delinquent'
        ELSE '3+ Months Delinquent'
    END

ORDER BY default_rate_pct;



-- 2. DELINQUENCY CONCENTRATION BY RISK SEGMENT


SELECT
    risk_segment,

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN recent_delinquency > 0 THEN 1
            ELSE 0
        END
    ) AS delinquent_customers,

    ROUND(
        SUM(
            CASE
                WHEN recent_delinquency > 0 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS delinquency_rate_pct,

    SUM(current_exposure) AS total_exposure,

    SUM(
        CASE
            WHEN recent_delinquency > 0
            THEN current_exposure
            ELSE 0
        END
    ) AS delinquent_exposure,

    ROUND(
        SUM(
            CASE
                WHEN recent_delinquency > 0
                THEN current_exposure
                ELSE 0
            END
        ) * 100.0
        / NULLIF(SUM(current_exposure), 0),
        2
    ) AS delinquent_exposure_pct

FROM credit_risk_analytics

GROUP BY risk_segment

ORDER BY delinquency_rate_pct DESC;


-- 3. PAYMENT BEHAVIOR AMONG DELINQUENT ACCOUNTS

SELECT
    risk_segment,

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN made_recent_payment = 0 THEN 1
            ELSE 0
        END
    ) AS no_recent_payment_customers,

    ROUND(
        SUM(
            CASE
                WHEN made_recent_payment = 0 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS no_recent_payment_pct,

    ROUND(
        AVG(default_next_month) * 100,
        2
    ) AS default_rate_pct

FROM credit_risk_analytics

WHERE recent_delinquency > 0

GROUP BY risk_segment

ORDER BY default_rate_pct DESC;