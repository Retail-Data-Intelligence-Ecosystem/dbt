with source as (

    select * from {{ source('raw', 'orders') }}

),

renamed as (

    select
        cast(order_id as int) as order_id,
        cast(customer_id as int) as customer_id,
        cast(order_date as date) as order_date,
        lower(trim(order_status)) as order_status,
        {{ audit_columns() }}

    from source

)

select * from renamed
