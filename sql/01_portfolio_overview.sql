/*
CREDIT CARD COLLECTIONS & DELINQUENCY RISK ANALYTICS
01 - PORTFOLIO OVERVIEW

Purpose:
Provide a high-level view of portfolio size, default risk, customer risk segmentation, and financial exposure.
*/


-- 1. PORTFOLIO KPIs

SELECT
    COUNT(*) AS total_customers,
    SUM(default_next_month) AS total_defaults,

    ROUND(
        AVG(default_next_month) * 100,
        2
    ) AS overall_default_rate_pct,

    SUM(current_exposure) AS total_exposure,

    ROUND(
        AVG(current_exposure),
        2
    ) AS avg_customer_exposure

FROM credit_risk_analytics;


-- 2. RISK SEGMENT PERFORMANCE

SELECT
    risk_segment,

    COUNT(*) AS customers,

    SUM(default_next_month) AS defaults,

    ROUND(
        AVG(default_next_month) * 100,
        2
    ) AS default_rate_pct,

    SUM(current_exposure) AS total_exposure

FROM credit_risk_analytics

GROUP BY risk_segment

ORDER BY default_rate_pct DESC;


-- 3. PORTFOLIO EXPOSURE BY RISK SEGMENT


SELECT
    risk_segment,

    COUNT(*) AS customers,

    SUM(current_exposure) AS total_exposure,

    ROUND(
        SUM(current_exposure) * 100.0
        / SUM(SUM(current_exposure)) OVER (),
        2
    ) AS exposure_share_pct

FROM credit_risk_analytics

GROUP BY risk_segment

ORDER BY total_exposure DESC;