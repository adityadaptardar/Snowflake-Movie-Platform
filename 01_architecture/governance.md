# Governance Model

## Role Hierarchy

* PLATFORM_ADMIN → full control
* DATA_ENGINEER → pipeline execution privileges
* ANALYST → read-only access to MART layer

Privileges are granted to roles rather than users.

## Naming Conventions

| Object      | Pattern         |
| ----------- | --------------- |
| Warehouses  | `<layer>_wh`    |
| Raw tables  | `raw_<entity>`  |
| Core tables | `core_<entity>` |
| Dimensions  | `dim_<entity>`  |
| Facts       | `fact_<entity>` |
| Streams     | `str_<table>`   |
| Tasks       | `tsk_<purpose>` |

## Security Principles

* Least privilege access
* Role-based grants
* Masking for sensitive fields
* Secure views for consumption
