{% macro incremental_date_filter(timestamp_column, lookback_days=var('incremental_lookback_days')) %}

    {% if is_incremental() %}
        {{ timestamp_column }} >= dateadd(
            day,
            -{{ lookback_days }},
            (select coalesce(max({{ timestamp_column }}), '1900-01-01') from {{ this }})
        )
    {% else %}
        true
    {% endif %}

{% endmacro %}
