--creating full name by concatenating first and last name
{% macro full_name(firstName, lastName) %}
    (COALESCE({{firstName}},'') || ' ' || COALESCE({{lastName}},''))
{% endmacro %}