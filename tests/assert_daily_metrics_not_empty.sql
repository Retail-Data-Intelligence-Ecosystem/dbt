select *
from {{ ref('agg_daily_metrics') }}
where total_events <= 0
