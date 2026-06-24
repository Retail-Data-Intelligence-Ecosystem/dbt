-- Run once in Databricks SQL to create raw source tables in dev.bronze.
-- These are required before `dbt run --select staging+`.

create table if not exists dev.bronze.events (
    event_id string,
    user_id string,
    event_name string,
    event_timestamp timestamp,
    event_properties string,
    _loaded_at timestamp
) using delta;

create table if not exists dev.bronze.users (
    user_id string,
    email string,
    created_at timestamp,
    country_code string
) using delta;

-- Optional seed data for local testing
insert into dev.bronze.users
select * from values
    ('u1', 'alice@example.com', timestamp('2024-01-01'), 'US'),
    ('u2', 'bob@example.com', timestamp('2024-01-02'), 'GB')
as t(user_id, email, created_at, country_code)
where not exists (select 1 from dev.bronze.users limit 1);

insert into dev.bronze.events
select * from values
    ('e1', 'u1', 'page_view', timestamp('2024-06-01 10:00:00'), '{"page":"/home"}', current_timestamp()),
    ('e2', 'u1', 'click', timestamp('2024-06-01 10:05:00'), '{"button":"signup"}', current_timestamp()),
    ('e3', 'u2', 'page_view', timestamp('2024-06-01 11:00:00'), '{"page":"/pricing"}', current_timestamp())
as t(event_id, user_id, event_name, event_timestamp, event_properties, _loaded_at)
where not exists (select 1 from dev.bronze.events limit 1);
