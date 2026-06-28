{% snapshot snap_customers %}

{{
    config(
        unique_key='customer_id',
        strategy='timestamp',
        updated_at='_dbt_loaded_at',
    )
}}

select * from {{ ref('stg_customers') }}

{% endsnapshot %}
