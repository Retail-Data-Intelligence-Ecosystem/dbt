with events as (

    select * from {{ ref('int_events_deduped') }}

),

sessionized as (

    select
        event_id,
        user_id,
        event_name,
        event_timestamp,
        event_date,
        event_properties,
        sum(
            case
                when timestampdiff(
                    minute,
                    lag(event_timestamp) over (
                        partition by user_id
                        order by event_timestamp
                    ),
                    event_timestamp
                ) > 30
                or lag(event_timestamp) over (
                    partition by user_id
                    order by event_timestamp
                ) is null
                then 1
                else 0
            end
        ) over (
            partition by user_id
            order by event_timestamp
            rows between unbounded preceding and current row
        ) as session_id

    from events

)

select
  {{ dbt_utils.generate_surrogate_key(['user_id', 'session_id']) }} as session_key,
    user_id,
    session_id,
    min(event_timestamp) as session_start_at,
    max(event_timestamp) as session_end_at,
    count(*) as event_count

from sessionized
group by 1, 2, 3
