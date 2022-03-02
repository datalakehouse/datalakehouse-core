--creating full name by concatenating first and last name
{% macro full_name(firstName,middleName, lastName) %}
    (COALESCE({{firstName}},'') || ' ' || COALESCE({{middleName}} || ' ','') || COALESCE({{lastName}},''))
{% endmacro %}