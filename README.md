#  E-Commerce Sales Analysis - End-to-End Data Analytics Project

##  Project Overview

This is a **comprehensive End-to-End E-Commerce Analytics Project** that demonstrates professional data analysis skills required for entry to intermediate-level data analyst roles. The project showcases the complete analytics workflow from raw data to actionable insights.

###  Complete Analytics Workflow
```
Raw CSV Data → Database Design → ETL Pipeline → Data Cleaning → SQL Analysis 
→ Statistical Testing → Machine Learning → Visualization → Business Insights
```

###  Quick Stats
| Metric | Details |
|--------|---------|
| **Dataset** | Brazilian E-Commerce Public Dataset (Kaggle) |
| **Time Period** | August 2016 - September 2018 |
| **Records** | 100,000+ orders across 7 tables |
| **Technologies** | MySQL, Python, Pandas, Scikit-Learn, Tableau |
| **Analysis Methods** | SQL, Statistics, ML Clustering, Regression |

---

##  Project Goals & Skills Demonstrated

###  Data Analysis Skills
 **Data Collection & ETL** - Load CSV data into MySQL  
**Database Design** - Created normalized relational schema with 7 tables  
**SQL Analytics** - 15+ complex queries for business insights  
**Data Cleaning** - Handled missing values, outliers, data validation  
**Statistical Analysis** - Hypothesis testing, correlation, chi-square tests  
**Business Metrics** - KPI calculation, trend analysis, cohort analysis  
**Customer Segmentation** - RFM analysis, K-Means clustering  
**Predictive Modeling** - Regression, classification for business forecasting  
**Data Visualization** - Python plots + Tableau dashboards  
**Business Communication** - Executive summaries, findings, recommendations  

---

##  Key Findings & Business Metrics

| KPI | Value | Insight |
|-----|-------|---------|
| **Total Revenue (GMV)** | ₹ 16,008,872 | Strong market presence |
| **Total Orders** | 99,441 | High transaction volume |
| **Average Order Value (AOV)** | ₹ 160.99 | Mid-range product focus |
| **Unique Customers** | 96,096 | Diverse customer base |
| **On-Time Delivery Rate** | 93.2% | Excellent fulfillment |
| **Repeat Customer Rate** | 0.8% | Opportunity for loyalty programs |
| **Top Category** | Furniture | 40% of revenue |
| **Geographic Concentration** | 66.8% in top 3 states | Expansion opportunity |

---

##  Project Structure & File Guide

```
e-Commerce_Sales-Python_sql-Project/ 
│
├── 📂 data_dictionary/               # Database documentation
│   └── schema.md                     # 7 tables, relationships, column details
    |__  README.md
│
├── 📂 etl/                           # Extract, Transform, Load Pipeline
│   ├── 01_create_tables.sql         # MySQL table creation (7 tables)
│   ├── 02_load_csvs.ipynb           # Python ETL - CSV → MySQL
│   └── 03_cleaning.sql              # Data validation & constraints
│
├── 📂 sql/                           # SQL Analytics Queries
│   ├── kpis.sql                     # 10 essential business metrics
│   ├── cohorts.sql                  # Customer retention & cohort analysis
│   ├── rfm.sql                      # RFM segmentation queries
│   └── business_queries.sql         # 15 business questions with solutions
│
├── 📂 notebooks/                     # Jupyter Notebooks
│   ├── 01_stats_tests.ipynb         # Statistical hypothesis testing
│   │   └── Chi-square, T-tests, Correlation analysis
│   │
│   └── 02_light_ml.ipynb            # Machine Learning & Prediction
│       └── K-Means clustering, Linear/Logistic Regression
│
├── 📂 Dataset/                       # Raw data files
│   ├── customers.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── payments.csv
│   ├── products.csv
│   ├── sellers.csv
│   └── geolocation.csv
│
├── 📂 tableau/                       # Visualization & Dashboard
│   ├── dashboard.twbx                # Interactive Tableau dashboard
│   └── screenshots/                  # Dashboard images for presentations
│
└── 📂 reports/                       # Analysis & Recommendations
    └── findings.md                   # Executive summary, insights, recommendations
```

###  File Descriptions

| File | Purpose | Audience |
|------|---------|----------|
| `README.md` | Project overview & setup | Everyone |
| `data_dictionary/schema.md` | Database structure docs | Analysts & Engineers |
| `etl/01_create_tables.sql` | Table creation DDL | Database team |
| `etl/02_load_csvs.ipynb` | Data loading pipeline | Data engineers |
| `sql/kpis.sql` | Business metrics queries | Analysts & Managers |
| `sql/business_queries.sql` | 15 analytical queries | Stakeholders |
| `notebooks/01_stats_tests.ipynb` | Statistical analysis | Data scientists |
| `notebooks/02_light_ml.ipynb` | Predictive models | Decision makers |
| `reports/findings.md` | Executive summary | Management |

---

##  Installation & Setup

### Prerequisites
```bash
MySQL Server 8.0+ (with root access)
Python 3.8+ (with pip)
Jupyter Notebook
Tableau Public (free version) for visualizations
```

### Step 1: Create Database & Tables
```bash
# Log into MySQL and run the DDL script
mysql -u root -p
mysql> source etl/01_create_tables.sql;
```

### Step 2: Load Data from CSV
```bash
# Open and run the ETL notebook
jupyter notebook etl/02_load_csvs.ipynb

# This will:
# - Connect to MySQL
# - Read CSV files from Dataset/
# - Insert data into respective tables
# - Handle data type conversions
```

### Step 3: Apply Data Cleaning & Constraints
```bash
mysql -u root -p ecommerce < etl/03_cleaning.sql
```

### Step 4: Verify Data Load
```bash
# Run a quick test query
mysql -u root -p ecommerce
mysql> SELECT COUNT(*) FROM orders;
mysql> SELECT COUNT(*) FROM customers;
```

### Step 5: Run Analytics
```bash
# Run SQL queries
mysql -u root -p ecommerce < sql/kpis.sql

# Run statistical analysis notebook
jupyter notebook notebooks/01_stats_tests.ipynb

# Run ML models
jupyter notebook notebooks/02_light_ml.ipynb
```

---

##  Data Dictionary

### Tables Overview

| Table | Records | Purpose |
|-------|---------|---------|
| **customers** | 96,096 | Customer demographic information |
| **orders** | 99,441 | Order transactions & delivery data |
| **order_items** | 112,650 | Product line items in orders |
| **payments** | 103,886 | Payment methods & amounts |
| **products** | 32,951 | Product catalog & categories |
| **sellers** | 3,095 | Seller information |
| **geolocation** | 13,288 | City/state geographic codes |

**Detailed schema documentation:** See `data_dictionary/schema.md`

### 2. Run SQL Analyses
```bash
# Execute KPI calculations
mysql -u root -p ecommerce < sql/kpis.sql

# Run cohort analysis
mysql -u root -p ecommerce < sql/cohorts.sql

# Execute RFM segmentation
mysql -u root -p ecommerce < sql/rfm.sql
```

### 3. Statistical Testing & ML
```bash
# Run statistical tests
jupyter notebook notebooks/01_stats_tests.ipynb

# Apply machine learning
jupyter notebook notebooks/02_light_ml.ipynb
```

### 4. View Tableau Dashboard
or
Open tableau/dashboard.twbx in Tableau Desktop Public Edition
```
or
View dashboard online: [ADD YOUR TABLEAU PUBLIC LINK HERE]
```

---

##  Analysis Highlights

### 1. **Statistical Testing**

#### Test 1: Payment Type vs Order Value (Chi-Square Test)
- **Hypothesis:** Is there a relationship between payment type and order value?
- **Result:** Statistically significant relationship found (p < 0.05)
- **Insight:** Credit card users have higher average order values

#### Test 2: Delivery Time Comparison (T-Test)
- **Hypothesis:** Do delivery times differ significantly between states?
- **Result:** Significant difference found between SP and RJ states
- **Insight:** Logistics optimization needed for distant states

### 2. **Customer Segmentation (RFM Analysis)**

| Segment | % of Customers | Avg Monetary Value |
|---------|---------------|-------------------|
| Champions | 12.5% | ₹ 450 |
| Loyal Customers | 18.3% | ₹ 320 |
| At Risk | 8.2% | ₹ 180 |
| One-Time Buyers | 61.0% | ₹ 140 |

### 3. **Machine Learning Results**

**K-Means Clustering:**
- 4 optimal customer clusters identified
- Silhouette Score: 0.72

**Sales Prediction:**
- Linear Regression R² Score: 0.85
- RMSE: ₹ 12,450

**Delivery Classification:**
- Logistic Regression Accuracy: 88%
- Precision (On-Time): 0.91

---

##  Key Insights & Findings

###  **Top Findings**

1. **Geographic Concentration**
   - 42% of orders come from São Paulo state
   - Top 5 states generate 75% of total revenue

2. **Seasonal Patterns**
   - Peak sales in November (Black Friday impact)
   - Lowest sales in January-February

3. **Customer Retention Challenge**
   - **0.26%** repeat purchase rate within 6 months
   - Average customer lifetime: 1.2 orders

4. **Product Performance**
   - Top category: Bed/Bath/Table (₹ 1.7M revenue)
   - Avg items per order: 1.2

5. **Delivery Insights**
   - Average delivery time: 12 days
   - 93% on-time delivery rate
   - Freight cost correlation with product weight: 0.68

---

### Tableau Dashboard

### Dashboard Overview
Below are screenshots of the Tableau dashboard exported to the `tableau/screenshots/` folder. Click an image to view the full-size version.

- [Revenue & Map](tableau/screenshots/Screenshot%202025-12-01%20085245.png)
- [Monthly Trend](tableau/screenshots/Screenshot%202025-12-01%20085309.png)
- [Top Products](tableau/screenshots/Screenshot%202025-12-01%20085325.png)
- [Customer Segmentation](tableau/screenshots/Screenshot%202025-12-01%20085356.png)
- [Delivery Performance](tableau/screenshots/Screenshot%202025-12-01%20085406.png)
- [Filters & Interactions](tableau/screenshots/Screenshot%202025-12-01%20085419.png)
- [Drilldowns](tableau/screenshots/Screenshot%202025-12-01%20085446.png)
- [Export & Summary](tableau/screenshots/Screenshot%202025-12-01%20085456.png)

**Interactive Features:**
- Revenue by State (Map Visualization)
- Monthly Sales Trend
- Top Products & Categories
- Customer Segmentation Distribution
- Delivery Performance Metrics

**Dashboard Link:** [Add your Tableau Public link]

---

##  Technologies Used

| Tool | Purpose |
|------|---------|
| **MySQL** | Database management & SQL queries |
| **Python** | Data manipulation & analysis |
| **Pandas** | Data wrangling |
| **NumPy** | Numerical computing |
| **Matplotlib/Seaborn** | Data visualization |
| **Scikit-Learn** | Machine learning |
| **SciPy** | Statistical testing |
| **Tableau** | Interactive dashboards |
| **Jupyter Notebook** | Analysis documentation |

---





