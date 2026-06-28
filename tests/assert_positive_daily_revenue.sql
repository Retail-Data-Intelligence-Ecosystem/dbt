-- Custom test: daily revenue must never be negative
select
    order_date,
    total_revenue

from {{ ref('agg_daily_revenue') }}
where total_revenue < 0
