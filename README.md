
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
