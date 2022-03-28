const H_INVOCATION_ID = require("./includes/H_INVOCATION_ID.js");
const V_CUSTOMER_STG = require("./includes/staging/CUSTOMERS/V_CUSTOMER_STG.js");
const V_MERCHANT_LOCATION_STG = require("./includes/staging/LOCATION/V_MERCHANT_LOCATION_STG.js");
const V_PAYMENT_STG = require("./includes/staging/PAYMENT/V_PAYMENT_STG.js");
const V_CATALOG_CATEGORY_STG = require("./includes/staging/CATALOG/V_CATALOG_CATEGORY_STG.js");
const V_CATALOG_TAX_STG = require("./includes/staging/CATALOG/V_CATALOG_TAX_STG.js");
const V_CATALOG_DISCOUNT_STG = require("./includes/staging/CATALOG/V_CATALOG_DISCOUNT_STG.js");
const V_CATALOG_ITEM_VARIATION_STG = require("./includes/staging/CATALOG/V_CATALOG_ITEM_VARIATION_STG.js");
const V_CATALOG_ITEM_MODIFIER_STG = require("./includes/staging/CATALOG/V_CATALOG_ITEM_MODIFIER_STG.js");
const V_DATE_STG = require("./includes/staging/DATE/V_DATE_STG.js");
const V_ORDER_LINE_ITEM_STG = require("./includes/staging/ORDERS/V_ORDER_LINE_ITEM_STG.js");
const V_ORDER_HEADER_STG = require("./includes/staging/ORDERS/V_ORDER_HEADER_STG.js");
const V_ORDER_LINE_ITEM_MODIFIER_STG = require("./includes/staging/ORDERS/V_ORDER_LINE_ITEM_MODIFIER_STG.js");
const V_CURRENCY_STG = require("./includes/staging/CURRENCY/V_CURRENCY_STG.js");
const W_DATE_D = require("./includes/master/W_DATE_D.js");
const W_ORDERS_F = require("./includes/master/W_ORDERS_F.js");
const W_CUSTOMERS_D = require("./includes/master/W_CUSTOMERS_D.js");
const W_PAYMENTS_F = require("./includes/master/W_PAYMENTS_F.js");
const W_CATALOG_ITEM_D = require("./includes/master/W_CATALOG_ITEM_D.js");
const W_MERCHANT_LOCATION_D = require("./includes/master/W_MERCHANT_LOCATION_D.js");
const W_CURRENCY_D = require("./includes/master/W_CURRENCY_D.js");


module.exports = (params) => {
  params = {
    source_database: 'DEVELOPER_SANDBOX',
    source_schema: 'DEMO_SQUARE_ALT13',
    target_schema: 'DATAFORM_SQUARE',
    ...params
  };
  const {
    source_database,
    source_schema,
    target_schema
} = params;

const CUSTOMER = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "CUSTOMER"
});
const ORDER_DISCOUNT = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "ORDER_DISCOUNT"
});
const ORDER_LINE_ITEM = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "ORDER_LINE_ITEM"
});
const ORDER = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "ORDER"
});
const PAYMENT = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "PAYMENT"
});
const CATALOG_ITEM = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "CATALOG_ITEM"
});
const CATALOG_ITEM_VARIATION = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "CATALOG_ITEM_VARIATION"
});
const CATALOG_CATEGORY = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "CATALOG_CATEGORY"
});
const CATALOG_MODIFIER = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "CATALOG_MODIFIER"
});
const CATALOG_TAX = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "CATALOG_TAX"
});
const CATALOG_DISCOUNT = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "CATALOG_DISCOUNT"
});
const ORDER_LINE_ITEM_MODIFIER = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "ORDER_LINE_ITEM_MODIFIER"
});
const LOCATION = declare({
  database: "DEVELOPER_SANDBOX",
  schema: "DEMO_SQUARE_ALT13",
  name: "LOCATION"
});
  return {
    CUSTOMER,
    ORDER_DISCOUNT,
    ORDER_LINE_ITEM,
    ORDER,
    PAYMENT,
    CATALOG_ITEM,
    CATALOG_ITEM_VARIATION,
    CATALOG_CATEGORY,
    CATALOG_MODIFIER,
    CATALOG_TAX,
    CATALOG_DISCOUNT,
    ORDER_LINE_ITEM_MODIFIER,
    LOCATION,
    H_INVOCATION_ID: H_INVOCATION_ID(params),
    V_CUSTOMER_STG: V_CUSTOMER_STG(params),
    V_MERCHANT_LOCATION_STG: V_MERCHANT_LOCATION_STG(params),
    V_PAYMENT_STG: V_PAYMENT_STG(params),
    V_CATALOG_CATEGORY_STG: V_CATALOG_CATEGORY_STG(params),
    V_CATALOG_TAX_STG: V_CATALOG_TAX_STG(params),
    V_CATALOG_DISCOUNT_STG: V_CATALOG_DISCOUNT_STG(params),
    V_CATALOG_ITEM_VARIATION_STG: V_CATALOG_ITEM_VARIATION_STG(params),
    V_CATALOG_ITEM_MODIFIER_STG: V_CATALOG_ITEM_MODIFIER_STG(params),
    V_DATE_STG: V_DATE_STG(params),
    V_ORDER_LINE_ITEM_STG: V_ORDER_LINE_ITEM_STG(params),
    V_ORDER_HEADER_STG: V_ORDER_HEADER_STG(params),
    V_ORDER_LINE_ITEM_MODIFIER_STG: V_ORDER_LINE_ITEM_MODIFIER_STG(params),
    V_CURRENCY_STG: V_CURRENCY_STG(params),
    W_DATE_D: W_DATE_D(params),
    W_ORDERS_F: W_ORDERS_F(params),
    W_CUSTOMERS_D: W_CUSTOMERS_D(params),
    W_PAYMENTS_F: W_PAYMENTS_F(params),
    W_CATALOG_ITEM_D: W_CATALOG_ITEM_D(params),
    W_MERCHANT_LOCATION_D: W_MERCHANT_LOCATION_D(params),
    W_CURRENCY_D: W_CURRENCY_D(params),

  }
}