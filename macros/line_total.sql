{% macro line_total(quantity_column, price_column) %}
    {{ quantity_column }} * {{ price_column }}
{% endmacro %}
