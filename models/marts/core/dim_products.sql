select
    product_id,
    product_name,
    category,
    unit_price,
    _dbt_loaded_at

from {{ ref('stg_products') }}
