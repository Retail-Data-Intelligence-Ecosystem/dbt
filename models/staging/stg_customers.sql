with source as (

    select * from {{ source('raw', 'customers') }}

),

renamed as (

    select
        cast(customer_id as int) as customer_id,
        trim(customer_name) as customer_name,
        lower(trim(email)) as email,
        trim(city) as city,
        cast(signup_date as date) as signup_date,
        {{ audit_columns() }}

    from source

)

select * from renamed
