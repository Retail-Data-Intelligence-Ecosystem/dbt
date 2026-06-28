with enriched_items as (

    select * from {{ ref('int_order_items_enriched') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

order_totals as (

    select
        order_id,
        customer_id,
        order_date,
        order_status,
        sum(line_total) as order_revenue,
        count(*) as item_count

    from enriched_items
    group by 1, 2, 3, 4

),

with_payments as (

    select
        order_totals.order_id,
        order_totals.customer_id,
        order_totals.order_date,
        order_totals.order_status,
        order_totals.order_revenue,
        order_totals.item_count,
        coalesce(payments.amount, 0) as payment_amount,
        payments.payment_method,
        payments.payment_date

    from order_totals
    left join payments
        on order_totals.order_id = payments.order_id

)

select * from with_payments
