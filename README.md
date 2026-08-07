#  Credit Risk Analytics Dashboard

An end-to-end **Credit Risk Analytics** project that demonstrates the complete analytics lifecycle using **Python, PostgreSQL, SQL, and Power BI**.

The project focuses on customer risk assessment, delinquency monitoring, portfolio exposure analysis, and collection prioritization through interactive business intelligence dashboards.

---

## Project Overview

Financial institutions manage thousands of credit card customers and need to continuously monitor portfolio risk, identify delinquent customers, and prioritize collection efforts.

This project simulates a real-world banking analytics workflow by:

- Cleaning and preprocessing raw credit card data using Python
- Engineering business-focused risk features
- Performing business analysis using PostgreSQL and SQL
- Building interactive Power BI dashboards for executive and operational reporting

#  Project Architecture

```
                Raw Credit Card Dataset
                         │
                         ▼
        Python (Data Cleaning & Feature Engineering)
                         │
                         ▼
              Processed Analytics Dataset
                         │
                         ▼
            PostgreSQL Business Analysis
                         │
                         ▼
         Power BI Interactive Dashboards
```

---

#  Tech Stack

| Category | Technologies |
|----------|--------------|
| Programming | Python |
| Data Processing | Pandas, NumPy |
| Database | PostgreSQL |
| Query Language | SQL |
| Visualization | Power BI |
| Development Environment | Jupyter Notebook |

---

#  Project Structure

```
Credit-Risk-Analytics-Dashboard
│
├── data
│   ├── raw
│   └── processed
│
├── notebooks
│   ├── 01_data_understanding.ipynb
│   └── 02_Feature_Engineering.ipynb
│
├── sql
│   ├── 01_portfolio_overview.sql
│   ├── 02_delinquency_analysis.sql
│   ├── 03_collection_priority.sql
│   └── 04_collection_work_queue.sql
│
├── powerbi
│   └── Credit_Risk_Analytics.pbix
│
├── screenshots
│   ├── executive_dashboard.png
│   ├── operations_dashboard.png
│   └── sql_analysis.png
│
├── requirements.txt
└── README.md
```

---

#  Data Preprocessing

The raw credit card dataset was cleaned and transformed using Python.

The preprocessing pipeline included:

- Handling missing values
- Removing duplicate records
- Data type conversion
- Outlier inspection
- Feature transformation
- Data validation

---

# ⚙️ Feature Engineering

Several business-oriented features were engineered to improve portfolio analysis.

### Features Created

- Risk Segment
- Collection Priority
- Behavioral Risk Score
- Delinquency Severity
- Delinquency Trajectory
- Exposure Band
- Utilization Band
- Recent Delinquency
- Months Delinquent (6 Months)

These engineered features were later used for SQL analysis and dashboard creation.

---

#  SQL Business Analysis

Business analysis was performed in PostgreSQL using SQL.

The analysis focused on:

- Portfolio Exposure Analysis
- Delinquency Trends
- Collection Priority Distribution
- High-Risk Customer Identification
- Executive Portfolio KPIs

Example SQL techniques used:

- Common Table Expressions (CTEs)
- Window Functions
- Aggregate Functions
- Ranking Functions
- Conditional Logic

---

#  Power BI Dashboard

The project contains two interactive dashboards.

## Executive Dashboard

Provides a high-level overview of portfolio performance.

Includes:

- Total Customers
- Total Exposure
- Default Rate
- Delinquent Customers
- Critical Accounts
- Risk Segment Performance
- Portfolio Exposure Distribution

### Dashboard Preview

![Executive Dashboard](Screenshots/executive_dashboard.png)

---

## Collections & Delinquency Dashboard

Designed for operational collection teams.

Includes:

- Collection Priority Distribution
- Risk Segment Summary
- Top High-Risk Accounts
- Interactive Slicers
- Customer-Level Analysis

### Dashboard Preview

![Operations Dashboard](Screenshots/operations_dashboard.png)

---

#  SQL Analysis Preview

Business analysis performed using PostgreSQL.

![SQL Analysis](Screenshots/sql_analysis.png)

---

#  Key Business Insights

- Low-risk customers account for the majority of the customer base.
- High-risk customers exhibit significantly higher default rates.
- Portfolio exposure is concentrated among a relatively small number of customers.
- Collection Priority enables operational teams to focus recovery efforts efficiently.
- Risk segmentation improves customer monitoring and portfolio management.

---

#  Business Value

This solution enables financial institutions to:

- Monitor portfolio health
- Track delinquency trends
- Prioritize collection activities
- Identify high-risk customers
- Support executive decision-making through interactive dashboards

---

#  Future Enhancements

Planned improvements include:

- Develop Machine Learning models for default prediction
- Compare Logistic Regression, Random Forest, and XGBoost
- Evaluate models using Precision, Recall, F1-Score, and ROC-AUC
- Integrate predicted default probability into the Power BI dashboard
- Deploy the analytics pipeline using FastAPI

---

#  How to Run

## Clone Repository

```bash
git clone https://github.com/HarshRaj-072004/Credit-Risk-Analytics-Dashboard.git
```

## Install Dependencies

```bash
pip install -r requirements.txt
```

## Workflow

1. Run the Jupyter notebooks for preprocessing and feature engineering.
2. Import the processed dataset into PostgreSQL.
3. Execute SQL scripts.
4. Open the Power BI dashboard (.pbix file).
5. Explore interactive dashboards.

---

#  Author

**Harsh Raj**

GitHub: https://github.com/HarshRaj-072004

LinkedIn: *https://www.linkedin.com/in/harsh-raj-3537342a2/*

---

