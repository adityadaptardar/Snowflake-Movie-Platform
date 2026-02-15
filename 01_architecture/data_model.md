# Data Model Plan

The platform will implement a dimensional model.

## Dimensions

* dim_user
* dim_movie
* dim_date

## Fact

* fact_rating

## Grain

fact_rating represents a single user rating event for a movie at a specific timestamp.

Surrogate keys will be used for dimension references.
