
  create or replace  view DEVELOPER_SANDBOX.DBT_SALESFORCE.V_USER_ROLE_HIERARCHY  as (
    

-- This is the WITH clause, of course.
with recursive userroles 
      -- Column names for the "view"/CTE
      (indent, id, parentroleid, name) 
    as
      -- Common Table Expression
      (
        
         -- Recursive Clause
        select '' as INDENT,
            ur.id, ur.parentroleid, ur.name
          from DEVELOPER_SANDBOX.DEMO_SALESFORCE."USERROLE" UR
        where ur.parentroleid is null
        
        
        union all
        
        -- Recursive Clause
        select INDENT || '- ',
            ur.id, ur.parentroleid, ur.name
          from DEVELOPER_SANDBOX.DEMO_SALESFORCE."USERROLE" UR join userroles URP
            on UR.parentroleid = URP.id
        
      )

  -- This is the "main select".
  select indent || name as A_USER_ROLE_FULL_NAME, id AS K_USER_ROLE_BK, name A_USER_ROLE_NAME
    from userroles
  );
