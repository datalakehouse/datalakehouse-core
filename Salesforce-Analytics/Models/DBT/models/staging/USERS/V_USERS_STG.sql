{{ config (
  materialized= 'view',
  schema= 'SALESFORCE',
  tags= ["staging","daily"]
)
}}

WITH source AS (
  SELECT * FROM  {{source('DEMO_SALESFORCE','USER')}}
),
user_role_hierarchy AS (
  SELECT * FROM  {{ref('V_USER_ROLE_HIERARCHY')}}
),
user_profile AS (
  SELECT * FROM  {{source('DEMO_SALESFORCE','PROFILE')}}
),
rename AS 
(
SELECT
    --DLHK
    MD5(TRIM(COALESCE(U.ID,'00000000000000000000000000000000')) ) AS K_USER_DLHK
    ,MD5(TRIM(COALESCE(U.ACCOUNTID,'00000000000000000000000000000000')) ) AS K_ACCOUNT_DLHK
    ,MD5(TRIM(COALESCE(U.CONTACTID,'00000000000000000000000000000000')) ) AS K_CONTACT_DLHK
    ,MD5(TRIM(COALESCE(U.INDIVIDUALID,'00000000000000000000000000000000')) ) AS K_INDIVIDUAL_DLHK
    ,MD5(TRIM(COALESCE(U.MANAGERID,'00000000000000000000000000000000')) ) AS K_MANAGER_DLHK
    ,MD5(TRIM(COALESCE(U.PROFILEID,'00000000000000000000000000000000')) ) AS K_PROFILE_DLHK
    ,MD5(TRIM(COALESCE(U.USERROLEID,'00000000000000000000000000000000')) ) AS K_USER_ROLE_DLHK
      
    --BUSINESS KEYS
    ,U.ID AS K_USER_BK
    ,U.ACCOUNTID AS K_ACCOUNT_BK 
    ,U.CONTACTID AS K_CONTACT_BK
    ,U.INDIVIDUALID AS K_INDIVIDUAL_BK
    ,U.MANAGERID AS K_MANAGER_BK
    ,U.PROFILEID AS K_PROFILE_BK 
    ,U.USERROLEID AS K_USER_ROLE_BK  
    ,U.TIMEZONESIDKEY AS K_TIME_ZONE_BK
    ,U.LASTMODIFIEDBYID AS K_LAST_MODIFIED_USER_BK
    ,U.DELEGATEDAPPROVERID AS K_DELEGATED_APPROVER_BK
    ,U.FEDERATIONIDENTIFIER AS K_FEDERATION_IDENTIFIER_BK
    ,U.CALLCENTERID AS K_CALL_CENTER_BK
    ,U.CREATEDBYID AS K_CREATED_BY_USER_BK
    ,U.JIGSAWIMPORTLIMITOVERRIDE AS K_JIGSAW_IMPORT_LIMIT_OVERRIDE_BK    
    ,U.LOCALESIDKEY AS K_LOCALES_BK
    --ATTRIBUTES
    ,U.NAME AS A_FULL_NAME
    ,U.FIRSTNAME AS A_FIRST_NAME    
    ,U.LASTNAME AS A_LAST_NAME
    ,UR.A_USER_ROLE_NAME AS A_USER_ROLE_NAME
    ,UR.A_USER_ROLE_FULL_NAME AS A_USER_ROLE_FULL_NAME
    ,UP.NAME AS A_USER_PROFILE_NAME
    ,U.ALIAS AS A_ALIAS
    ,U.COMPANYNAME AS A_COMPANY_NAME
    ,U.CREATEDDATE AS A_CREATED_DATE
    ,U.DEPARTMENT AS A_DEPARTMENT
    ,U.DIGESTFREQUENCY AS A_DIGEST_FREQUENCY
    ,U.DIVISION AS A_DIVISION
    ,U.EMAIL AS A_EMAIL
    ,U.EMPLOYEENUMBER AS A_EMPLOYEE_NUMBER
    ,U.EXTENSION AS A_EXTENSION
    ,U.FAX AS A_FAX     
    ,U.LASTLOGINDATE AS A_LAST_LOGIN_DATE
    ,U.LASTMODIFIEDDATE AS A_LAST_MODIFIED_DATE
    ,U.MOBILEPHONE AS A_MOBILE_PHONE
    ,U.PHONE AS A_PHONE
    ,U.SENDEREMAIL AS A_SENDER_EMAIL
    ,U.SENDERNAME AS A_SENDER_NAME
    ,U.COUNTRY AS A_COUNTRY
    ,U.CITY AS A_CITY
    ,U.STATE AS A_STATE
    ,U.STREET AS A_STREET
    ,U.POSTALCODE AS A_POSTAL_CODE
    ,U.GEOCODEACCURACY AS A_GEO_CODE_ACCURACY
    ,U.LATITUDE AS A_LATITUDE
    ,U.LONGITUDE AS A_LONGITUDE
    ,U.SYSTEMMODSTAMP AS A_SYSTEM_MOD_STAMP
    ,U.TITLE AS A_TITLE
    ,U.USERNAME AS A_USERNAME
    ,U.USERTYPE AS A_USER_TYPE
    --BOOLEAN
    ,U.ISACTIVE AS B_IS_ACTIVE
    --METRIC    
    ,U.NUMBEROFFAILEDLOGINS AS M_NUMBEROFFAILEDLOGINS
     --METADATA
    ,CURRENT_TIMESTAMP as MD_LOAD_DTS
    ,'{{invocation_id}}' AS MD_INTGR_ID
FROM
    source U
    LEFT JOIN user_role_hierarchy UR ON UR.K_USER_ROLE_BK = U.USERROLEID
    LEFT JOIN user_profile UP ON UP.ID = U.PROFILEID
)

SELECT * FROM rename