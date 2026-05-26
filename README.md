# Supply Chain & Operational Intelligence Platform

## Project Overview

This project focuses on analyzing supply chain, customer, product, and operational performance using SQL Server and Power BI. The objective is to transform raw transactional and operational data into actionable business insights that support strategic decision-making.

The project follows an end-to-end analytics workflow including:

- Data Ingestion
- Data Cleaning & Transformation
- Data Quality Validation
- Exploratory Data Analysis
- KPI Development
- Dashboard Design & Reporting
- Business Insights & Recommendations

---

## Business Problem

Organizations often struggle to gain a unified view of sales performance, customer behavior, product profitability, and operational efficiency.

This project addresses the following key business questions:

- Which markets generate the highest revenue and profit?
- Who are the most valuable customers?
- Which products contribute most to profitability?
- Which products are negatively impacting business performance?
- How effective is the shipping and delivery process?
- What operational bottlenecks affect customer satisfaction?

---

## Technology Stack

### Database
- Microsoft SQL Server

### Data Visualization
- Power BI Desktop

### Query Language
- SQL

### Data Modeling
- Star Schema

---

## Data Sources

### Supply Chain Dataset

Contains information related to:

- Orders
- Customers
- Products
- Categories
- Departments
- Shipping
- Delivery Performance
- Revenue
- Profitability

### Tokenized Access Logs

Contains website activity information including:

- Product Views
- Category Views
- Department Traffic
- User Access Patterns

---

## Data Model

### Fact Table

#### fact_orders_cleaned_v2

Contains transactional order-level information:

- Orders
- Revenue
- Profit
- Shipping
- Delivery
- Product Sales

### Dimension Tables

#### dim_customers

Customer attributes including:

- Customer Segment
- Geography
- Customer Information

#### dim_products

Product attributes including:

- Product Name
- Category
- Department
- Product Pricing

#### dim_shipping

Shipping and delivery attributes.

---

# Data Cleaning & Data Quality

Several data quality issues were identified and resolved before analysis.

### Date Corrections

- Excel serial date values were converted into valid SQL datetime values.
- Invalid date records were flagged using a data quality indicator.

### Geography Corrections

Corrupted characters were identified and corrected across:

- Order City
- Order State
- Order Country

Examples:

| Before | After |
|----------|----------|
| Oca±a | Ocaña |
| Sπo Paulo | São Paulo |
| MΘxico | México |

### Validation Checks

Performed:

- Record Count Validation
- Null Value Analysis
- Duplicate Analysis
- Date Logic Validation
- Referential Integrity Checks

---

# Key KPIs

The following KPIs were developed:

- Total Revenue
- Total Profit
- Profit Margin %
- Total Orders
- Total Customers
- Total Products
- Revenue Per Customer
- Revenue Per Product
- Average Order Value
- Average Product Profit
- Late Delivery Rate %
- Average Shipping Days

---

# Dashboard Pages

## 1. Executive Overview

### Screenshot

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%20Executive%20Summary-Supply%20Chain%20%26%20Operational%20%20Intelligence%20Platform%20.png)

Provides a high-level view of overall business performance.

### Key Insight
- The business generated approximately **$37M revenue** and **$4M profit** from **65K orders**, demonstrating strong sales performance but relatively low profit margins.

### Key Insight
- Europe and Latin America are the highest-performing markets and contribute the majority of overall revenue.

### Recommendation
- Improve operational efficiency and cost management to increase profitability while maintaining growth in high-performing markets.

---

## 2. Customer Analytics

### Screenshot

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%20Customer%20Analysis%20-Supply%20Chain%20%26%20Operational%20Intelligence%20Platform%20.png)

Provides insights into customer behavior and value segmentation.

### Key Insight
- The company serves more than **20K customers** with an average order value of approximately **$559**.

### Key Insight
- A small segment of high-value customers contributes a significant portion of overall profit.

### Recommendation
- Implement loyalty and retention strategies to increase the lifetime value of medium-value customers.

---

## 3. Product Analytics

### Screenshot

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%20Product%20Analysis-Supply%20Chain%20%26%20Operational%20%20Intelligence%20Platform%20.png)

Analyzes product, category, and department performance.

### Key Insight
- The Fan Shop department generates the highest revenue while the Fishing category delivers the highest profit contribution.

### Key Insight
- Multiple products were identified as loss-making products despite generating sales revenue.

### Recommendation
- Prioritize investment in profitable categories and review pricing strategies for loss-making products.

---

## 4. Operations & Shipping

### Screenshot

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%20Operation%20%26%20Shipping-Supply%20Chain%20%26%20Operational%20Intelligence%20Platform%20%20.png)
Evaluates shipping efficiency and delivery performance.

### Key Insight
- More than **54% of orders** are associated with late delivery risk.

### Key Insight
- Standard Class shipping processes the highest order volume and experiences the highest number of delivery delays.

### Recommendation
- Improve Standard Class shipping operations to reduce delays and improve customer satisfaction.

---

# Business Insights

### Revenue Performance

- Europe generated the highest revenue among all markets.
- Latin America closely followed Europe in total sales contribution.
- Revenue remained relatively stable between 2015 and 2017.

### Customer Performance

- Customer value distribution indicates opportunities for upselling and retention.
- Customer concentration is highest in the United States and major European markets.

### Product Performance

- Fishing, Cleats, and Camping & Hiking categories delivered the highest profitability.
- Three products were identified as consistently loss-making.

### Operational Performance

- Shipping delays remain the largest operational challenge.
- Standard Class shipping offers the greatest opportunity for process improvement.

  ---

# Statistical Analysis

To support business findings with statistical evidence, Hypothesis Testing and A/B Testing were conducted using Excel's T.TEST() function with a two-tailed test and unequal variance assumption.

## 1. Hypothesis Testing

### Business Question

Do late deliveries affect order profitability?

### Method

- Statistical Test: Two-Sample T-Test
- Significance Level (α): 0.05
- Test Type: Two-Tailed
- Variance Assumption: Unequal Variance

### Null Hypothesis (H₀)

There is no statistically significant difference in average order profitability between late deliveries and non-late deliveries.

### Alternative Hypothesis (H₁)

There is a statistically significant difference in average order profitability between late deliveries and non-late deliveries.

### Result

- p-value = **0.1125**
- Significance Level = **0.05**

### Interpretation

Since the p-value is greater than 0.05, we fail to reject the null hypothesis.

### Conclusion

The analysis found no statistically significant impact of late deliveries on order profitability.

### Screenshot

![Hypothesis Testing](Snapshot%20Hypothesis%20Testing-Supply%20Chain%20%26%20Operational%20Intelligence.png)

---

## 2. A/B Testing

### Business Question

Do Standard Class and Second Class shipping methods generate different average sales?

### Method

- Statistical Test: Two-Sample T-Test
- Significance Level (α): 0.05
- Test Type: Two-Tailed
- Variance Assumption: Unequal Variance

### Group A

Standard Class Shipping

### Group B

Second Class Shipping

### Null Hypothesis (H₀)

There is no statistically significant difference in average sales between Standard Class and Second Class shipping methods.

### Alternative Hypothesis (H₁)

There is a statistically significant difference in average sales between Standard Class and Second Class shipping methods.

### Result

- p-value = **0.0653**
- Significance Level = **0.05**

### Interpretation

Since the p-value is greater than 0.05, we fail to reject the null hypothesis.

### Conclusion

The analysis found no statistically significant difference in average sales between Standard Class and Second Class shipping methods.

### Screenshot

![AB Testing](Snapshot%20AB%20Testing-Supply%20Chain%20%26%20Operational%20Intelligence.png)

---

## Statistical Findings Summary

| Analysis | p-value | Decision | Conclusion |
|-----------|----------|----------|------------|
| Late Delivery vs Profitability | 0.1125 | Fail to Reject H₀ | No significant impact on profitability |
| Standard Class vs Second Class Sales | 0.0653 | Fail to Reject H₀ | No significant difference in average sales |

### Business Implication

The statistical analysis suggests that neither delivery delays nor shipping method selection significantly influenced profitability or average sales at the 95% confidence level. This indicates that operational improvements should focus on customer experience and delivery performance rather than expecting immediate financial gains from shipping mode changes alone.

---

# Project Structure

```text
SupplyChainAnalytics/

│
├── 00_init_database.sql
├── 01_clean_fact_orders.sql
├── 02_clean_tokenized_access_logs.sql
├── 03_data_quality_checks.sql
├── 04_dim_customers_quality_and_exploration.sql
├── 05_dim_products_quality_and_exploration.sql
├── 06_business_kpi.sql
├── 07_magnitude_analysis.sql
├── 08_ranking_analysis.sql
├── 09_change_over_time_analysis.sql
├── 10_cumulative_analysis.sql
├── 11_performance_analysis.sql
├── 12_segmentation_analysis.sql
├── 13_part_to_whole_analysis.sql
│
├── Statistical Analysis/
│   ├── Hypothesis_Testing.xlsx
│   └── AB_Testing.xlsx
│
├── Dashboard Screenshots/
│   ├── Executive Overview.png
│   ├── Customer Analytics.png
│   ├── Product Analytics.png
│   └── Operations & Shipping.png
│
├── Supply Chain & Operational Intelligence Platform.pbix
│
└── README.md
```

---

# Conclusion

The analysis revealed strong revenue generation across global markets, supported by a broad customer base and diverse product portfolio. However, profitability remains constrained by low margins, loss-making products, and significant delivery delays.

The findings highlight opportunities to improve profitability through product portfolio optimization, customer value growth strategies, and supply chain performance improvements.

---

## Author

**Rahul Gowda A**

Data Analytics | SQL | Power BI | Excel
