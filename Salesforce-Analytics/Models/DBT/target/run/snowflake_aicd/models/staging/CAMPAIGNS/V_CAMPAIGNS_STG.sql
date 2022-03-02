
  create or replace  view DEVELOPER_SANDBOX.DBT_SALESFORCE.V_CAMPAIGNS_STG  as (
    

WITH source AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DEMO_SALESFORCE."CAMPAIGN"
),
user AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DBT_SALESFORCE.W_USERS_D
),
parent_campaign AS (
  SELECT * FROM  DEVELOPER_SANDBOX.DBT_SALESFORCE.V_CAMPAIGNS_HIERARCHY
),
rename AS 
(
SELECT
  --DLHK
  MD5(S.ID) AS K_CAMPAIGN_DLHK
  ,U.K_USER_DLHK AS K_OWNER_USER_DLHK
  ,U2.K_USER_DLHK AS K_MODIFIED_BY_USER_DLHK
  ,U3.K_USER_DLHK AS K_CREATED_BY_USER_DLHK
  --BUSINESS KEYS
  ,S.ID AS K_CAMPAIGN_BK
  ,S.CAMPAIGNMEMBERRECORDTYPEID AS K_CAMPAIGN_MEMBER_RECORD_TYPE_BK
  ,S.CREATEDBYID AS K_CREATED_BY_USER_BK
  ,S.LASTMODIFIEDBYID AS K_MODIFIED_BY_USER_BK
  ,S.OWNERID AS K_OWNER_USER_BK

  ,S.PARENTID AS K_PARENTID
  --ATTRIBUTES
  ,P.A_CAMPAIGN_FULL_NAME AS A_CAMPAIGN_FULL_NAME
  ,S.CREATEDDATE AS A_CREATED_DATE
  ,S.DESCRIPTION AS A_DESCRIPTION
  ,S.ENDDATE AS A_END_DATE
  ,S.LASTACTIVITYDATE AS A_LAST_ACTIVITY_DATE
  ,S.LASTMODIFIEDDATE AS A_LAST_MODIFIED_DATE
  ,S.LASTREFERENCEDDATE AS A_LAST_REFERENCED_DATE
  ,S.LASTVIEWEDDATE AS A_LAST_VIEWED_DATE
  ,S.NAME AS A_NAME
  ,S.STARTDATE AS A_START_DATE
  ,S.STATUS AS A_STATUS
  ,S.SYSTEMMODSTAMP AS A_SYSTEM_MOD_STAMP
  ,S.TYPE AS A_TYPE
  --BOOLEAN
  ,S.ISACTIVE AS B_IS_ACTIVE
  ,S.ISDELETED AS B_IS_DELETED
  --METRICS
  ,S.ACTUALCOST AS M_ACTUAL_COST
  ,S.AMOUNTALLOPPORTUNITIES AS M_AMOUNT_ALL_OPPORTUNITIES
  ,S.AMOUNTWONOPPORTUNITIES AS M_AMOUNT_WON_OPPORTUNITIES
  ,S.BUDGETEDCOST AS M_BUDGETED_COST
  ,S.EXPECTEDRESPONSE AS M_EXPECTED_RESPONSE
  ,S.EXPECTEDREVENUE AS M_EXPECTED_REVENUE
  ,S.NUMBEROFCONTACTS AS M_NUMBER_OF_CONTACTS
  ,S.NUMBEROFCONVERTEDLEADS AS M_NUMBER_OF_CONVERTED_LEADS
  ,S.NUMBEROFLEADS AS M_NUMBER_OF_LEADS
  ,S.NUMBEROFOPPORTUNITIES AS M_NUMBER_OF_OPPORTUNITIES
  ,S.NUMBEROFRESPONSES AS M_NUMBER_OF_RESPONSES
  ,S.NUMBEROFWONOPPORTUNITIES AS M_NUMBER_OF_WON_OPPORTUNITIES
  ,S.NUMBERSENT AS M_NUMBER_SENT
  --METADATA
  ,CURRENT_TIMESTAMP as MD_LOAD_DTS
  ,'7e6fc8ec-9523-4142-87d8-c2d8a3668a01' AS MD_INTGR_ID
FROM source S
    LEFT JOIN user U ON U.K_USER_BK = S.OWNERID
    LEFT JOIN user U2 ON U2.K_USER_BK = S.LASTMODIFIEDBYID
    LEFT JOIN user U3 ON U3.K_USER_BK = S.LASTMODIFIEDBYID
    LEFT JOIN parent_campaign P ON P.K_CAMPAIGN_BK = S.ID
WHERE
  NOT(S.ISDELETED)
) 

SELECT * FROM rename
  );
