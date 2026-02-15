# Environment Configuration

## Snowflake Account Setup

This project assumes the following objects:

Database: MOVIE_DEV
Schemas: RAW, CORE, MART, MONITORING

Warehouses:

* INGEST_WH → ingestion workloads
* TRANSFORM_WH → pipelines and transformations
* BI_WH → analytics workloads

## Role Usage

* PLATFORM_ADMIN → full ownership
* DATA_ENGINEER → pipeline execution
* ANALYST → read-only analytics access

## Deployment Order

1. Run infra/bootstrap.sql
2. Configure ADLS storage integration
3. Create ingestion objects
4. Deploy pipelines
