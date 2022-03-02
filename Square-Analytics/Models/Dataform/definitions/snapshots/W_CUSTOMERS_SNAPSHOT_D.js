const scd = require("dataform-scd");


scd("W_CUSTOMERS_SNAPSHOT_D", {
  uniqueKey: "K_POS_CUSTOMER_DLHK",
  timestamp: "A_POS_UPDATED_AT_DTS",
  source: {
    schema: "DATAFORM_SQUARE",
    name: "W_CUSTOMERS_D",
  }, 
});
