
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
