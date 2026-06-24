{% snapshot snap_users %}

{{
    config(
        target_schema='silver',
        unique_key='user_id',
        strategy='timestamp',
        updated_at='created_at'
    )
}}

select * from {{ ref('stg_users') }}

{% endsnapshot %}
