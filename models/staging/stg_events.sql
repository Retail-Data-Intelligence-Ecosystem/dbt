with source as (

    select * from {{ source('raw', 'events') }}

),

renamed as (

    select
        cast(event_id as string) as event_id,
        cast(user_id as string) as user_id,
        lower(trim(event_name)) as event_name,
        cast(event_timestamp as timestamp) as event_timestamp,
        cast(event_properties as string) as event_properties,
        cast(_loaded_at as timestamp) as _loaded_at,
        current_timestamp() as _stg_loaded_at

    from source
    where event_id is not null
      and user_id is not null
      and event_timestamp is not null

)

select * from renamed
