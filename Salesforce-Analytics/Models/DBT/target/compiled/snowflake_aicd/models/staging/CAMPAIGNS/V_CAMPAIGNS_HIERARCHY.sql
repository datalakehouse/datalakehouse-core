

-- This is the WITH clause, of course.
with recursive campaigns 
      -- Column names for the "view"/CTE
      (indent, id, parentid, name) 
    as
      -- Common Table Expression
      (
        
         -- Recursive Clause
        select '' as INDENT,
            C.id, C.PARENTID, C.NAME
          from DEVELOPER_SANDBOX.DEMO_SALESFORCE."CAMPAIGN" C
        where C.parentid is null
        AND NOT(C.ISDELETED)
        
        union all
        
        -- Recursive Clause
        select INDENT || '- ',
            C.id, C.PARENTID, C.NAME
          from DEVELOPER_SANDBOX.DEMO_SALESFORCE."CAMPAIGN" C join campaigns CA
            on C.PARENTID = CA.ID
          WHERE
           NOT(C.ISDELETED)
      )

  -- This is the "main select".
  select indent || name as A_CAMPAIGN_FULL_NAME, id AS K_CAMPAIGN_BK
    from campaigns