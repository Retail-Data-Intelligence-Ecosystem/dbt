with source as (

    select * from {{ source('raw', 'users') }}

),

renamed as (

    select
        cast(user_id as string) as user_id,
        lower(trim(email)) as email,
        cast(created_at as timestamp) as created_at,
        upper(trim(country_code)) as country_code,
        current_timestamp() as _stg_loaded_at

    from source
    where user_id is not null

)

select * from renamed
