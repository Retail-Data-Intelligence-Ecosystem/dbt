with users as (

    select * from {{ ref('stg_users') }}

),

enriched as (

    select
        user_id,
        email,
        created_at,
        country_code,
        case
            when country_code in ('US', 'CA', 'GB', 'AU') then 'EN'
            else 'OTHER'
        end as region_group,
        current_timestamp() as _dim_updated_at

    from users

)

select * from enriched
