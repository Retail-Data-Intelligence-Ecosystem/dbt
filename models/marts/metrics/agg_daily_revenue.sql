select
    order_date,
    count(distinct order_id) as order_count,
    sum(order_revenue) as total_revenue,
    round(avg(order_revenue), 2) as avg_order_value

from {{ ref('fct_orders') }}
where order_status = 'completed'
group by 1
