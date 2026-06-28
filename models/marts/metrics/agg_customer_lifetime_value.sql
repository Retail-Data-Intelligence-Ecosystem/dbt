select
    customer_id,
    count(distinct order_id) as total_orders,
    sum(case when order_status = 'completed' then order_revenue else 0 end) as lifetime_revenue,
    max(order_date) as last_order_date

from {{ ref('fct_orders') }}
group by 1
