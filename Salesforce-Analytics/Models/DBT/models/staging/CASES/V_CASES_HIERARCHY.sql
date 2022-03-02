{{ config (
  materialized= 'view',
  schema= 'SALESFORCE',
  tags= ["staging", "daily"]
)
}}

-- This is the WITH clause, of course.
with recursive cases 
      -- Column names for the "view"/CTE
      (indent, id, parentid, CASENUMBER) 
    as
      -- Common Table Expression
      (
        
         -- Recursive Clause
        select '' as INDENT,
            A.id, A.PARENTID, A.CASENUMBER
          from {{source('DEMO_SALESFORCE','CASE')}} A
        where A.parentid is null
        AND  NOT(A.ISDELETED)
        
        union all
        
        -- Recursive Clause
        select INDENT || '- ',
            A.id, A.PARENTID, A.CASENUMBER
          from {{source('DEMO_SALESFORCE','CASE')}} A join cases C
            on A.PARENTID = C.ID
            WHERE
            NOT(A.ISDELETED)
      )

  -- This is the "main select".
  select indent || CASENUMBER as A_CASE_NUMBER_HIERARCHY, id AS K_CASE_BK
    from cases
    
    
  