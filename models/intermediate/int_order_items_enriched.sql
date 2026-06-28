with order_items as (

    select * from {{ ref('stg_order_items') }}

),

products as (

    select * from {{ ref('stg_products') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

enriched as (

    select
        order_items.order_item_id,
        order_items.order_id,
        order_items.product_id,
        products.product_name,
        products.category,
        order_items.quantity,
        order_items.unit_price,
        order_items.line_total,
        orders.customer_id,
        orders.order_date,
        orders.order_status

    from order_items
    inner join products
        on order_items.product_id = products.product_id
    inner join orders
        on order_items.order_id = orders.order_id

)

select * from enriched
