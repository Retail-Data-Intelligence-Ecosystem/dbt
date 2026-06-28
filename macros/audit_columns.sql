{% macro audit_columns() %}
    current_timestamp() as _dbt_loaded_at
{% endmacro %}
