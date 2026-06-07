# Supply Chain & Operational Intelligence Platform

## Project Overview

This project delivers an end-to-end Supply Chain & Operational Intelligence solution designed to transform raw operational data into actionable business insights.

Using SQL Server, Power BI, and Excel, the project analyzes sales performance, customer behavior, product profitability, and supply chain efficiency to identify revenue opportunities, operational bottlenecks, and areas for profitability improvement.

The solution combines data engineering, business intelligence, and statistical analysis to support data-driven decision-making.

The project follows an end-to-end analytics workflow including:

- Data Ingestion
- Data Cleaning & Transformation
- Data Quality Validation
- Exploratory Data Analysis
- KPI Development
- Dashboard Design & Reporting
- Business Insights & Recommendations

---

## Business Objective

To analyze supply chain, customer, product, and shipping performance by transforming raw operational data into actionable business insights that support revenue growth, profitability improvement, and operational efficiency.

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
- Average Discount Per Customer
- Total Products
- Average Discount Per Product
- Revenue Per Customer
- Revenue Per Product
- Average Order Value
- Average Product Profit
- Late Delivery Rate %
- Average Shipping Days

---

# Dashboard Pages

## 1. Home Page

### Screenshot

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%201-%20Home.png
)

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%202%20-%20Home.png
)

Project introduction, navigation menu, and business objective.

## 2. Executive Overview

### Screenshot

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%201%20-%20Executive%20Overview.png
)

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapahot%202%20-%20Executive%20Overview.png
)


Provides a high-level view of overall business performance.

### KPIs
- Revenue
- Profit
- Profit Margin
- YoY Growth
- MoM Growth

### Analysis

- Profit by Market
- Profit by Country
- Year-on-Year Profit Trend

### Key Insight
- The business generated approximately **$37M revenue** and **$4M profit** from **65K orders**, demonstrating strong sales performance but relatively low profit margins.

### Key Insight
- Europe and Latin America are the highest-performing markets and contribute the majority of overall revenue.

### Recommendation
- Improve operational efficiency and cost management to increase profitability while maintaining growth in high-performing markets.

---

## 3. Customer Analytics

### Screenshot

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%201%20-%20Customer%20Analysis.png
)

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%202%20-%20Customer%20Analysis.png
)

Provides insights into customer behavior and value segmentation.

### KPIs

- Total Customers
- Revenue per Customer
- Profit per Customer
- Average Order Value
- Discount per Customer

### Analysis

- Customer Segmentation
- Top Customer Countries
- Customer Distribution Map
- Top Customers by Profit

### Key Insight
- The company serves more than **20K customers** with an average order value of approximately **$559**.
- A small segment of high-value customers contributes a significant portion of overall profit.

### Recommendation
- Implement loyalty and retention strategies to increase the lifetime value of medium-value customers.

---

## 4. Product Analytics

### Screenshot

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%201%20-%20Product%20Analysis.png
)

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%202%20-%20Product%20Analysis.png
)

Analyzes product, category, and department performance.

### KPIs

- Total Products
- Average Product Revenue
- Average Product Discount

### Analysis

- Loss-Making Products
- Revenue by Department
- Top Products by Revenue
- Top Categories by Revenue

### Key Insight
- The Fan Shop department generates the highest revenue while the Fishing category delivers the highest profit contribution.

### Key Insight
- Multiple products were identified as loss-making products despite generating sales revenue.

### Recommendation
- Prioritize investment in profitable categories and review pricing strategies for loss-making products.

---

## 4. Operations & Shipping

### Screenshot

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%201%20-%20Operations%20%26%20Shipping.png
)

![Dashboard_upload](https://github.com/rahulgowda2003/Supply-Chain-Operational-Intelligence-Platform/blob/main/Snapshot%202%20-%20Operations%20%26%20Shipping.png)

Evaluates shipping efficiency and delivery performance.

### KPIs

- Total Orders
- Late Delivery Rate
- Average Shipping Days
- Delivery Fulfillment Rate

### Analysis

- Delivery Status Distribution
- Orders by Shipping Mode
- Ordered vs Delivered Quantity
- Late Orders by Shipping Mode
- Profit by Shipping Mode

### Key Insight
- More than **54% of orders** are associated with late delivery risk.

### Key Insight
- Standard Class shipping processes the highest order volume and experiences the highest number of delivery delays.

### Recommendation
- Improve Standard Class shipping operations to reduce delays and improve customer satisfaction.

---

## Key Business Insights

### Executive Overview

**Insight**

Despite generating approximately $37M in revenue, the business maintained a relatively low profit margin of 3.21%, indicating profitability challenges.

**Recommendation**

Focus on margin optimization initiatives such as discount control, product mix optimization, and operational cost reduction.

**Insight**

Europe and Latin America contributed the highest profit among all markets.

**Recommendation**

Prioritize customer acquisition and retention initiatives in high-performing regions.

**Insight**

Profitability experienced a significant decline during 2018.

**Recommendation**

Investigate operational, pricing, and inventory factors contributing to profit erosion.

---

### Customer Analysis

**Insight**

A small group of high-value customers contributed a disproportionately large share of total profit.

**Recommendation**

Implement loyalty programs and targeted retention campaigns for high-value customers.

**Insight**

Customer concentration is highest in North America and Europe.

**Recommendation**

Expand marketing and fulfillment capabilities in high-performing regions.

**Insight**

Average profit per customer remains significantly lower than revenue per customer.

**Recommendation**

Improve customer profitability through cross-selling and discount optimization.

---

### Product Analysis

**Insight**

Three products consistently generated negative profit.

**Recommendation**

Review pricing, supplier contracts, and inventory costs for loss-making products.

**Insight**

The Fan Shop department generated the highest revenue contribution.

**Recommendation**

Increase product assortment and promotional focus within high-performing departments.

**Insight**

A small number of categories contributed a significant portion of total revenue.

**Recommendation**

Protect market share in top-performing categories while identifying emerging growth categories.

---

### Operations & Shipping

**Insight**

54.83% of orders were exposed to late delivery risk.

**Recommendation**

Prioritize logistics optimization and shipping process improvements.

**Insight**

Standard Class shipping handled the highest order volume and late-order count.

**Recommendation**

Improve carrier performance and operational monitoring for Standard Class shipments.

**Insight**

Delivery fulfillment rate remains below optimal levels.

**Recommendation**

Strengthen order tracking, inventory planning, and fulfillment processes.

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
│   ├── Home Page.png
│   ├── Executive Overview.png
│   ├── Customer Analysis.png
│   ├── Product Analysis.png
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
