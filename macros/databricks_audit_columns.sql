{% macro databricks_audit_columns() %}
    current_timestamp() as _dbt_loaded_at,
    '{{ invocation_id }}' as _dbt_invocation_id
{% endmacro %}
