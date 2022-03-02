/* 
 * The function countryGroup() takes as input the name of the country code field and returns a CASE statement that maps country codes to country groups
 * You can learn more about functions on https://docs.dataform.co/guides/includes
*/

function full_name(firstName, middleName, lastName) {    
  return `(COALESCE(${firstName},'') || ' ' || COALESCE(${middleName} || ' ','') || COALESCE(${lastName},''))`;

  

}

module.exports = {
  full_name
};
 