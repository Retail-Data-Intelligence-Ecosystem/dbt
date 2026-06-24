{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='event_id',
        partition_by=['event_date'],
        file_format='delta',
        on_schema_change='append_new_columns'
    )
}}

with events as (

    select * from {{ ref('int_events_deduped') }}

),

final as (

    select
        event_id,
        user_id,
        event_name,
        event_timestamp,
        event_date,
        event_properties,
        _loaded_at,
        current_timestamp() as _fct_loaded_at

    from events

    {% if is_incremental() %}
        where event_date >= dateadd(
            day,
            -{{ var('incremental_lookback_days') }},
            (select coalesce(max(event_date), '1900-01-01') from {{ this }})
        )
    {% endif %}

)

select * from final
