select
    order_id,
    customer_id,
    order_date,
    order_status,
    order_revenue,
    item_count,
    payment_amount,
    payment_method,
    payment_date

from {{ ref('int_customer_orders') }}
