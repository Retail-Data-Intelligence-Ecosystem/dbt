with source as (

    select * from {{ source('raw', 'payments') }}

),

renamed as (

    select
        cast(payment_id as int) as payment_id,
        cast(order_id as int) as order_id,
        lower(trim(payment_method)) as payment_method,
        cast(amount as decimal(10, 2)) as amount,
        cast(payment_date as date) as payment_date,
        {{ audit_columns() }}

    from source

)

select * from renamed
