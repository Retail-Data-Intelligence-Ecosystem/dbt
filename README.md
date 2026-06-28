# learning — E-Commerce dbt on Databricks

Hands-on dbt project with dummy retail data. Demonstrates seeds, sources, staging, intermediate, marts, tests, macros, snapshots, packages, and analyses.

## Data flow

```
seeds (raw CSVs)
  → staging (views)
  → intermediate (tables)
  → marts/core + marts/metrics (tables)
```

## Models

| Layer | Model | Purpose |
|-------|-------|---------|
| staging | `stg_customers`, `stg_products`, `stg_orders`, `stg_order_items`, `stg_payments` | Clean raw data |
| intermediate | `int_order_items_enriched`, `int_customer_orders` | Joins and order-level logic |
| marts/core | `dim_customers`, `dim_products`, `fct_orders` | Dimensions and facts |
| marts/metrics | `agg_daily_revenue`, `agg_customer_lifetime_value` | KPI rollups |

## dbt features included

| Feature | Where |
|---------|-------|
| Seeds | `seeds/*.csv` + `seeds/_seeds.yml` |
| Sources + model docs + tests | `models/_ecommerce.yml` (combined) |
| Generic tests | `unique`, `not_null`, `relationships`, `accepted_values` |
| Package tests | `dbt_utils` in `models/_ecommerce.yml` |
| Custom test | `tests/assert_positive_daily_revenue.sql` |
| Macros | `macros/audit_columns.sql`, `macros/line_total.sql` |
| Snapshots | `snapshots/snap_customers.sql` |
| Analyses | `analyses/top_customers_by_revenue.sql` |
| Packages | `packages.yml` → `dbt-labs/dbt_utils` |

## Run order

Load credentials first (dbt does **not** read `.env` automatically):

```powershell
. .\load-env.ps1
dbt debug
dbt deps
dbt seed
dbt run
dbt test
dbt snapshot
dbt docs generate
dbt docs serve
```

Run only staging and downstream:

```powershell
dbt run --select staging+
dbt test --select staging+
```

## Connection

Profile: `databricks_free` (see `profiles/profiles.yml`)  
Secrets: `.env` (gitignored)
