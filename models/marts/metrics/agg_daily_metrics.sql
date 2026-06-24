with events as (

    select * from {{ ref('fct_events') }}

),

daily as (

    select
        event_date,
        count(*) as total_events,
        count(distinct user_id) as active_users,
        count(distinct event_name) as distinct_event_types,
        min(event_timestamp) as first_event_at,
        max(event_timestamp) as last_event_at

    from events
    group by 1

)

select * from daily
