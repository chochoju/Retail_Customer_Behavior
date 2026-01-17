# \# Retail Customer Behavior \& Shopping Trends Analysis

# 

# \## Project Overview

# 

# This project is an \*\*end-to-end retail analytics case study\*\* designed to simulate a real-world data analyst workflow.

# 

# It focuses on understanding \*\*sales trends,\*\* \*\*customer segmentation \& shopping behavior, and product performance\*\* using \*\*Python, SQL (PostgreSQL), and Power BI\*\*.

# 

# The project emphasizes:

# 

# \- realistic business logic

# \- data quality issues

# \- clear analytical storytelling

# \- executive-ready dashboards

# 

# ---

# 

# \## Business Problem

# 

# A mid-sized omnichannel retail company wants to better understand:

# 

# \- How different \*\*customer segments\*\* behave

# \- Which \*\*products and categories\*\* drive revenue

# \- How \*\*promotions and discounts\*\* impact sales

# \- Whether \*\*loyal customers\*\* are more valuable

# \- How \*\*seasonality and demographics\*\* influence purchasing patterns

# 

# The company’s goal is to use data to improve \*\*customer retention, optimize promotions, and identify growth opportunities\*\* across product categories

# 

# ---

# 

# \## Dataset Description

# 

# The dataset is designed to resemble \*\*real-world retail data\*\*, including common data issues.

# 

# \### Tables

# 

# \- \*\*orders\*\*

# \- \*\*customers\*\*

# \- \*\*products\*\*

# \- \*\*categories\*\*

# 

# \### Key Characteristics

# 

# \- 5 years of data (2019–2023), ~100 orders per day

# \- Seasonal sales spikes (holiday lift)

# \- Gender and age-driven purchasing behavior

# \- Data quality issues: missing values, duplicates, and inconsistent formats.

# 

# ---

# 

# \## Tools \& Technologies

# 

# \- \*\*Python\*\* (Pandas, NumPy, Matplotlib): data loading, cleaning, manipulation, EDA

# \- \*\*PostgreSQL:\*\* business logic, analytical SQL queries

# \- \*\*Power BI:\*\* interactive dashboards \& storytelling

# \- \*\*Jupyter Notebook:\*\* reproducible analysis workflow

# 

# ---

# 

# \## Project Workflow

# 

# \### 1. Data Import \& Exploration (Python)

# 

# \- Load multiple CSV files

# \- Inspect schema \& data quality

# \- Identify missing values, duplicates, inconsistencies

# \- Normalize:

# &nbsp;   - dates \& times

# &nbsp;   - state/location fields

# &nbsp;   - customer attributes

# 

# \### 2. Data Cleaning \& Feature Engineering (Python)

# 

# \- Handle missing prices using hybrid strategies

# \- Remove or flag duplicate records

# \- Create derived fields:

# &nbsp;   - Age Group (Young adults / Adults / Senior)

# &nbsp;   - Customer Segment (New / Returning / Loyal)

# &nbsp;   - Revenue, units sold, discount flags

# 

# \### 3. Exploratory Data Analysis (Python)

# 

# \- Revenue trends history (Monthly)

# \- Seasonality analysis

# \- Customer demographics \& behavior

# \- Product and category performance

# 

# \### 4. Business Analysis (PostgreSQL)

# 

# \- Load \*\*cleaned tables\*\* directly from Jupyter Notebook into PostgreSQL

# \- Write analytical SQL queries to answer business questions:

# &nbsp;   - Customer profile \& Demographics

# &nbsp;   - Revenue Contribution by Demographics

# &nbsp;   - Customer Purchase Behavior (e.g., Shipping, Discount usage)

# &nbsp;   - Product and Category Performance (e.g., Top-selling products)

# &nbsp;   - Promotion Effectiveness (e.g., Discount dependency by loyalty level)

# \- Queries written with clarity and reusability

# 

# \### 5. Dashboard Creation (Power BI)

# 

# \### 1) Executive Overview

# 

# \- KPIs: Revenue, Orders, Customers, AOV

# \- Revenue trends by time, category, gender, age group

# \- High-level business health view

# 

# \### 2) Customer Segmentation \& Behavior

# 

# \- New vs Returning vs Loyal customers

# \- Loyalty impact on spend \& discounts

# \- Category preference by gender \& age Group

# \- Promotion popularity trend

# \- High-value customer list

# 

# \### 3) Product Performance

# 

# \- Top products by revenue \& units sold

# \- Best-selling products per category

# \- Shipping method segment

# \- Seasonal product trends

# 

# ---

# 

# \## Key Insights

# 

# \- \*\*Electronics and Home Improvement categories dominate total revenue\*\* and exhibit the \*\*strongest seasonal uplift\*\*, particularly during Q4, indicating that these are the primary drivers of both baseline and holiday sales.

# \- \*\*Loyal and high-value customers consistently spend more regardless of discount usage\*\*, suggesting that their spending behavior is driven more by product value and brand affinity than by promotional incentives.

# \- \*\*Shipping method has little impact on average order value\*\*, suggesting that fulfillment speed affects convenience more than purchase size.

# \- \*\*Promotions significantly increase order volume but not average spend,\*\*  implying that promotions are more effective as a demand accelerator than as a revenue uplift per order.

# \- \*\*Customer demographics (gender and age group) show distinct category preferences\*\*, highlighting opportunities for targeted marketing and merchandising strategies.

# 

# ---

# 

# \## How to Run This Project

# 

# 1\. Clone the repository

# 2\. Run notebooks in order:

# &nbsp;   - Data cleaning

# &nbsp;   - EDA

# 3\. Load cleaned CSVs into PostgreSQL

# 4\. Execute SQL queries

# 5\. Open Power BI file and refresh data

# 

# ---

# 

# \## Contact

# 

# If you’d like to discuss this project or my work:

# 

# \- \*\*LinkedIn:\*\* https://www.linkedin.com/in/juyeon-cho/

# \- \*\*Email:\*\* jc973@alumni.duke.edu

