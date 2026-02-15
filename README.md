# Snowflake Movie Platform (End-to-End Data Platform on ADLS + Snowflake)

## 📌 Overview
This project demonstrates the design and implementation of a production-style Snowflake data platform using Azure Data Lake Storage (ADLS) as the source.

It showcases ingestion, transformation, dimensional modeling, governance, performance tuning, and cost monitoring practices typically used in enterprise Snowflake deployments.

---

## 🧭 Architecture

Data Flow:

ADLS → External Stage → RAW → CORE → MART → BI

Key principles:
- Immutable RAW layer for replayability
- Incremental pipelines using Streams & Tasks
- Dimensional modeling for analytics
- Workload isolation via dedicated warehouses
- Governance through RBAC and masking
- Monitoring for performance and cost visibility

Architecture diagram available in `/01_architecture`.

---

## 🏗️ Platform Components

### Data Ingestion
- External stage connected to ADLS
- COPY-based ingestion framework
- Audit logging for ingestion tracking

### Transformation
- Incremental processing using Streams
- Task orchestration for automated pipelines
- Idempotent MERGE logic for reliability

### Data Modeling
- Dimensional star schema
- SCD Type 2 dimensions
- Fact tables optimized for analytics

### Governance & Security
- Role hierarchy enforcing least privilege
- Masking policies for sensitive attributes
- Secure views for controlled data access

### Observability
- Pipeline freshness monitoring
- Cost usage tracking
- Query performance analysis

---

## 🛠️ Tech Stack

- Snowflake Cloud Data Platform
- Azure Data Lake Storage (ADLS)
- SQL / Snowflake Streams & Tasks
- dbt (for transformation layer)
- Git for version control

---

## 📂 Project Structure

01_architecture/ → Architecture diagrams
02_sql/ → Snowflake SQL scripts
03_dbt/ → dbt models and tests
04_monitoring/ → Monitoring queries
05_docs/ → Architecture and design notes

---

## 🎯 Objectives of this Project

This platform was designed to demonstrate:

- Snowflake architecture design skills
- Production-grade ingestion pipelines
- Incremental processing patterns
- Dimensional modeling expertise
- Cost and performance optimization techniques
- Governance implementation strategies

---

## 🚀 How to Run

1. Configure Snowflake account and ADLS integration
2. Execute setup scripts from `/02_sql`
3. Load data into RAW layer
4. Run transformation pipelines
5. Query MART layer for analytics

---

## 👤 Author

Designed and implemented as a reference Snowflake platform project to demonstrate architect-level design and hands-on implementation skills.
