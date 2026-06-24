# stream — dbt on Databricks

Heavy data engineering dbt project for event/stream analytics on Databricks.

## Architecture

```
dev.bronze (raw)
  → dev.silver (staging + intermediate)
  → dev.gold   (marts)
```

### Models

| Layer | Model | Purpose |
|-------|-------|---------|
| staging | `stg_events`, `stg_users` | Source-aligned cleaning |
| intermediate | `int_events_deduped` | Deduplicate events |
| intermediate | `int_user_sessions` | 30-min sessionization |
| marts/core | `dim_users` | User dimension |
| marts/core | `fct_events` | Incremental Delta fact |
| marts/metrics | `agg_daily_metrics` | Daily KPI rollups |

## Setup

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

cp .env.example .env

set -a && source .env && set +a
export DBT_PROFILES_DIR=./profiles
```

## Before first run

1. Bootstrap raw tables — run `analyses/bootstrap_bronze_tables.sql` in Databricks SQL.
2. Or point `models/staging/_sources.yml` at your existing bronze tables.

## Run

Run each command on its own line (do not copy inline comments):

```bash
dbt debug
dbt deps
dbt run
dbt run --select staging+
dbt run --select tag:daily
dbt test
dbt snapshot
```

## Unity Catalog

This workspace uses Unity Catalog (Hive Metastore is disabled). Configured via `.env`:

| Variable | Value |
|----------|-------|
| `DBT_DATABRICKS_CATALOG` | `dev` |
| `DBT_DATABRICKS_SCHEMA` | `silver` (dbt model default) |
| `DBT_RAW_SCHEMA` | `bronze` (raw sources) |

Marts write to `dev.gold`, staging/intermediate write to `dev.silver`.
