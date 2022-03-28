--creating full name by concatenating first and last name
{% macro full_name(firstName, lastName) %}
    (COALESCE({{firstName}},'') || ' ' || COALESCE({{lastName}},''))
{% endmacro %}

{% macro address_json_parse(address_json) %}
    MD5(CONCAT(coalesce(to_varchar(get_path(parse_json({{address_json}}), 'address1')),'00'),
              coalesce(to_varchar(get_path(parse_json({{address_json}}), 'address2')),'00'),
              coalesce(to_varchar(get_path(parse_json({{address_json}}), 'city')),'00'),
              coalesce(to_varchar(get_path(parse_json({{address_json}}), 'country')),'00'),
              coalesce(to_varchar(get_path(parse_json({{address_json}}), 'country_code')),'00'),
              coalesce(to_varchar(get_path(parse_json({{address_json}}), 'first_name')),'00'),
              coalesce(to_varchar(get_path(parse_json({{address_json}}), 'last_name')),'00'),
              coalesce(to_varchar(get_path(parse_json({{address_json}}), 'province')),'00'),
              coalesce(to_varchar(get_path(parse_json({{address_json}}), 'province_code')),'00'),
              coalesce(to_varchar(get_path(parse_json({{address_json}}), 'zip')),'00')))
{% endmacro %}

{% macro amount_origin_currency(value) %}
    coalesce(get_path(parse_json({{value}}), 'presentment_money.amount'),'0')::decimal(15,2)
{% endmacro %}

{% macro amount_currency(value, type) %}

CASE WHEN  '{{type}}' = 'original' THEN
    coalesce(get_path(parse_json({{value}}), 'presentment_money.amount'),'0')::decimal(15,2)
WHEN '{{type}}' = 'primary' THEN
    coalesce(get_path(parse_json({{value}}), 'shop_money.amount'),'0')::decimal(15,2)
END

{% endmacro %}

