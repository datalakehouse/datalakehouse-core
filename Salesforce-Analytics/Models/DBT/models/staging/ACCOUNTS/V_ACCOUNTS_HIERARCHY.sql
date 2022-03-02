{{ config (
  materialized= 'view',
  schema= 'SALESFORCE',
  tags= ["staging", "daily"]
)
}}

-- This is the WITH clause, of course.
with recursive accounts 
      -- Column names for the "view"/CTE
      (indent, id, parentroleid, name) 
    as
      -- Common Table Expression
      (
        
         -- Recursive Clause
        select '' as INDENT,
            A.id, A.PARENTID, A.NAME
          from {{source('DEMO_SALESFORCE','ACCOUNT')}} A
        where A.parentid is null
        AND NOT(A.ISDELETED)
        
        union all
        
        -- Recursive Clause
        select INDENT || '- ',
            A.id, A.PARENTID, A.NAME
          from {{source('DEMO_SALESFORCE','ACCOUNT')}} A join accounts AP
            on A.PARENTID = AP.ID
        WHERE NOT(A.ISDELETED)
      )

  -- This is the "main select".
  select indent || name as A_ACCOUNT_FULL_NAME, id AS K_ACCOUNT_BK
    from accounts
    
    
  