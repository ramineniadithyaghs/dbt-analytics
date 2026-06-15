
# Olist E-Commerce Mini Data Warehouse
A modern analytics engineering project built using Snowflake, dbt, and AWS S3.
## Project Overview
This project represents my implementation of an end-to-end data warehouse designed using the modern data stack. I chose the Olist Brazilian E-Commerce dataset because it offers realistic customer, order, product, and transaction data, which allowed me to build a warehouse structure similar to what many analytics teams maintain in production systems.
My goal was to transform a collection of raw CSV files into a clean, structured, analytics-ready environment. To do this, I used Snowflake as the warehouse, AWS S3 as the landing zone, and dbt as the transformation layer. The final result is a small but complete warehouse that moves data through predictable layers, enforces quality, and produces reliable tables for business insights.
## Architecture
The overall design follows a simple but effective layered structure. Raw files are stored in an S3 bucket and accessed using a Snowflake external stage. From there, they are loaded into raw tables without modification. dbt takes responsibility for all further processing. The staging layer standardizes and cleans the data, while the marts layer organizes it into facts and dimensions that support analysis.
## Design Principles

I built the project around the same principles used in real analytics engineering work:

**Raw as Source of Truth**
Raw tables in Snowflake mirror the input files exactly as they arrive. No transformations occur at this stage, ensuring a reliable audit trail of the original data.

**Staging for Standardization**
The staging layer cleans column names, applies consistent data types, removes invalid values, and prepares the data for further modeling. This layer acts as the foundation for all downstream logic.

**Dimensional Modeling in the Marts Layer**
The marts layer contains fact and dimension tables designed for analytics. These tables are simplified, readable, and optimized for tools like Power BI or Tableau.

**Testing and Quality Enforcement**
dbt tests ensure that the datasets maintain required integrity. Keys must be unique, null values are caught early, and relationships between tables are enforced.

---

## Warehouse Layers in Detail

### Raw Layer (Snowflake + S3)

This layer consists entirely of unmodified data loaded directly from S3 via a Snowflake stage. It includes customers, orders, order items, and products. All `COPY INTO` operations target this schema, and the tables are intentionally kept identical to the source files.

### Staging Layer (dbt STG)

The staging models reformat and standardize the raw data. Column names are made consistent and readable, timestamps are converted properly, and fields are cast into the correct data types. This layer eliminates the inconsistencies typical of CSV source data and prepares the dataset for modeling.

### Marts Layer (dbt MARTS)

The marts layer contains the business-facing tables of the warehouse.
The core tables include:

**fact_orders**, which consolidates order-level metrics such as total revenue, freight cost, item count, and purchase or delivery timelines.

**fact_order_items**, which holds item-level details linking individual products to their corresponding orders, along with price and freight information.

**dim_products**, which contains product attributes, cleaned category information, and product-level metadata needed for analysis.

These models follow a dimensional approach that mirrors what is used in real production warehouses.

---

## Data Quality and Testing

Data quality is enforced through dbt’s testing framework, which applies validation rules across the staging and marts layers. This includes ensuring key fields are unique, checking that important attributes are not null, and verifying that relationships between tables are valid. These tests help maintain trust in the downstream analytics and make the workflow more resilient.

---

## Running the Project

To run this project locally, clone the repository, install dbt with the Snowflake adapter, and configure your `profiles.yml` with your Snowflake credentials. Once configured, the project can be executed with the standard dbt commands: `dbt debug`, `dbt run`, and `dbt test`. This will reproduce the full pipeline, from loading the models to validating them.

---

## Why This Project Matters

This project showcases the practical skills expected of a modern data or analytics engineer. It demonstrates an understanding of warehouse design, familiarity with Snowflake and dbt, the ability to organize data into clean layers, and the discipline required to enforce quality through testing. It also reflects a deeper understanding of how raw operational data is transformed into reliable information that analysts and business teams depend on.

---

If you want, I can also help you now with a short, strong description to add to your **resume**, so this project appears polished and professional.
# Olist E-Commerce Data Warehouse
### Snowflake · dbt · AWS S3 · SQL · Dimensional Modeling

A production-style analytics data warehouse built on the Olist Brazilian 
E-Commerce dataset. This project demonstrates end-to-end data engineering 
using the modern data stack — from raw CSV ingestion through S3 into 
Snowflake, to clean, tested, analytics-ready dimensional models built 
with dbt
## Architecture
AWS S3 (Raw CSVs)
        ↓
Snowflake External Stage (COPY INTO)
        ↓
Raw Layer → Staging Layer → Marts Layer
               (dbt)          (dbt)
Raw files land in S3, are loaded into Snowflake via external stage, 
and dbt handles all transformation logic through three clean layers.
## Project Structure

dbt-analytics/
│
├── models/
│   ├── sources/
│   │   └── sales_sources.yml      # Source definitions + tests
│   │
│   ├── staging/
│   │   ├── stg_customers.sql      # Cleaned customer data
│   │   ├── stg_orders.sql         # Standardized order records
│   │   ├── stg_order_items.sql    # Item-level order details
│   │   ├── stg_products.sql       # Product attributes
│   │   └── *.yml                  # Column-level tests
│   │
│   └── marts/
│       ├── fact_orders.sql        # Order-level fact table
│       ├── fact_order_items.sql   # Item-level fact table
│       └── *.yml                  # Column-level tests
│
├── dbt_project.yml
└── README.md
## Warehouse Layers
### Raw Layer
Raw CSV files from the Olist dataset are stored in AWS S3 and loaded 
into Snowflake using COPY INTO commands via an external stage. Tables 
are kept identical to source files — no transformations at this layer.
### Staging Layer
dbt staging models clean and standardize the raw data:
- Column names renamed to snake_case conventions
- Data types explicitly cast (timestamps, numerics, strings)
- Invalid characters removed from zip codes
- Consistent field naming across all models

### Marts Layer
Business-facing dimensional models built for analytics:

**fact_orders** — Order-level fact table joining orders, customers, 
and aggregated item metrics. Includes revenue, freight, item count, 
and full delivery timeline per order.

**fact_order_items** — Item-level fact table with price, freight, 
and total item value per line item.

---

## Data Quality & Testing

dbt tests are applied across staging and marts layers:

| Test Type | Fields Covered |
|---|---|
| `not_null` | order_id, customer_id, product_id, price |
| `unique` | order_id, product_id |
| `relationships` | order_id across fact tables |

Run all tests:
```bash
dbt test
## Dataset

**Olist Brazilian E-Commerce** — a real commercial dataset containing
100k+ orders from 2016–2018 across multiple Brazilian marketplaces.
Includes customers, orders, order items, products, sellers, and reviews.

Source: [Kaggle — Olist E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Getting Started

### Prerequisites
- Snowflake account (free trial available)
- AWS S3 bucket with Olist CSVs uploaded
- Python 3.9+
- dbt-snowflake

### Setup

1. Clone the repository
```bash
git clone https://github.com/ramineniadithyaghs/dbt-analytics.git
cd dbt-analytics
2. Install dbt
```bash
pip install dbt-snowflake


3. Configure your Snowflake connection in `~/.dbt/profiles.yml`
```yaml
dbt_analytics:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: YOUR_ACCOUNT
      user: YOUR_USERNAME
      password: YOUR_PASSWORD
      role: YOUR_ROLE
      database: SALES_DB
      schema: SALES_SCHEMA
      warehouse: YOUR_WAREHOUSE
      threads: 4

4. Run the pipeline
bash
dbt debug    # Verify connection
dbt run      # Build all models
dbt test     # Run all data quality tests

## Key Design Decisions

**Raw as source of truth** — Raw tables mirror source files exactly, 
providing a reliable audit trail before any transformation occurs.

**Explicit type casting in staging** — Every column is cast to its 
correct type in the staging layer, preventing type errors from 
propagating downstream.

**CTE-based SQL patterns** — All models use CTEs for readability 
and maintainability, following dbt best practices.

**Test coverage at every layer** — Quality checks are applied at 
both staging and marts layers, not just at the end of the pipeline.

## Future Enhancements
- [ ] Add `dim_products` and `dim_customers` dimension tables
- [ ] Implement incremental models for large order tables
- [ ] Add GitHub Actions CI/CD to run dbt test on every push
- [ ] Generate and publish dbt docs with full lineage graph


## Author

**Adithya Ramineni** — Senior Data Engineer
- LinkedIn: [linkedin.com/in/dataengineeradi](https://linkedin.com/in/dataengineeradi)
- GitHub: [github.com/ramineniadithyaghs](https://github.com/ramineniadithyaghs)
- Email: adithyachowdaryr@gmail.com

### How To Paste This Into GitHub

1. Go to `dbt-analytics` repo
2. Click on `README.md`
3. Click the **pencil ✏️ icon** to edit
4. Select all existing text → delete it
5. Paste everything above
6. Scroll down → **Commit changes**
7. Commit message: `"Updated README with full project documentation"`
8. Click **Commit directly to main**


Once that's done, also fix this one small thing in `dbt_project.yml` — click that file, edit it, and change:

yaml
name: 'my_new_project'
to:
yaml
name: 'dbt_analytics'
``Commit that too.

Tell me when both are done and we'll move to updating LinkedIn.
