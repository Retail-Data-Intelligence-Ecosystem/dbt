with events as (

    select * from {{ ref('stg_events') }}

),

deduped as (

    select
        event_id,
        user_id,
        event_name,
        event_timestamp,
        event_properties,
        _loaded_at,
        _stg_loaded_at,
        row_number() over (
            partition by event_id
            order by event_timestamp desc, _loaded_at desc
        ) as _row_num

    from events

)

select
    event_id,
    user_id,
    event_name,
    event_timestamp,
    cast(event_timestamp as date) as event_date,
    event_properties,
    _loaded_at,
    _stg_loaded_at

from deduped
where _row_num = 1
