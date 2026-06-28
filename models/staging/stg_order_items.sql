with source as (

    select * from {{ source('raw', 'order_items') }}

),

renamed as (

    select
        cast(order_item_id as int) as order_item_id,
        cast(order_id as int) as order_id,
        cast(product_id as int) as product_id,
        cast(quantity as int) as quantity,
        cast(unit_price as decimal(10, 2)) as unit_price,
        cast({{ line_total('quantity', 'unit_price') }} as decimal(10, 2)) as line_total,
        {{ audit_columns() }}

    from source

)

select * from renamed
