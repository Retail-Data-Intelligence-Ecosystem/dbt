-- Ad-hoc analysis: top customers by lifetime revenue (not materialized)
select
    customers.customer_name,
    customers.city,
    clv.lifetime_revenue,
    clv.total_orders

from {{ ref('agg_customer_lifetime_value') }} as clv
inner join {{ ref('dim_customers') }} as customers
    on clv.customer_id = customers.customer_id
order by clv.lifetime_revenue desc
