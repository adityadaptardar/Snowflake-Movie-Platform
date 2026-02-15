# Architecture Overview

This Snowflake platform is designed following a layered data architecture.

## Layers

**RAW**

* Immutable ingestion layer
* Stores source data exactly as received
* Enables replayability and auditability

**CORE**

* Cleaned and standardized datasets
* Deduplicated and typed
* Serves as integration layer

**MART**

* Dimensional models optimized for analytics
* Star schemas and aggregated facts

## Warehouses Strategy

Separate warehouses isolate workloads and control cost:

| Warehouse    | Purpose                | Size   | Auto Suspend |
| ------------ | ---------------------- | ------ | ------------ |
| INGEST_WH    | File ingestion         | XSMALL | 60 sec       |
| TRANSFORM_WH | Pipelines & transforms | SMALL  | 60 sec       |
| BI_WH        | Reporting queries      | XSMALL | 120 sec      |

## Environment Model

DEV → TEST → PROD isolation is recommended.
This project simulates a DEV environment.

## Design Principles

* Immutable ingestion layer
* Idempotent pipelines
* Workload isolation
* Least privilege security model
* Cost-aware architecture
