select
    customer_id,
    customer_name,
    email,
    city,
    signup_date,
    _dbt_loaded_at

from {{ ref('stg_customers') }}
