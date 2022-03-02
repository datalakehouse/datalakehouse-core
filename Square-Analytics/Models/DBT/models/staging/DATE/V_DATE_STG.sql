{{ config (
  materialized= 'view',
  schema= 'SQUARE',
  tags= ["staging", "daily"]
)
}}

SELECT 
     to_date('2015-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS') as DD, /*<<Modify date for preferred table start date*/
      seq1() as Sl,row_number() over (order by Sl) as row_numbers,
      dateadd(day,row_numbers,DD) as V_DATE,
      case when date_part(dd, V_DATE) < 10 and date_part(mm, V_DATE) > 9 then
        date_part(year, V_DATE)||date_part(mm, V_DATE)||'0'||date_part(dd, V_DATE)
         when date_part(dd, V_DATE) < 10 and  date_part(mm, V_DATE) < 10 then 
         date_part(year, V_DATE)||'0'||date_part(mm, V_DATE)||'0'||date_part(dd, V_DATE)
         when date_part(dd, V_DATE) > 9 and  date_part(mm, V_DATE) < 10 then
         date_part(year, V_DATE)||'0'||date_part(mm, V_DATE)||date_part(dd, V_DATE)
         when date_part(dd, V_DATE) > 9 and  date_part(mm, V_DATE) > 9 then
         date_part(year, V_DATE)||date_part(mm, V_DATE)||date_part(dd, V_DATE) end as DATE_KEY,
      V_DATE as DATE_COLUMN,
      dayname(dateadd(day,row_numbers,DD)) as DAY_NAME_1,
      case 
        when dayname(dateadd(day,row_numbers,DD)) = 'Mon' then 'Monday'
        when dayname(dateadd(day,row_numbers,DD)) = 'Tue' then 'Tuesday'
        when dayname(dateadd(day,row_numbers,DD)) = 'Wed' then 'Wednesday'
        when dayname(dateadd(day,row_numbers,DD)) = 'Thu' then 'Thursday'
        when dayname(dateadd(day,row_numbers,DD)) = 'Fri' then 'Friday'
        when dayname(dateadd(day,row_numbers,DD)) = 'Sat' then 'Saturday'
        when dayname(dateadd(day,row_numbers,DD)) = 'Sun' then 'Sunday' end ||', '||
      case when monthname(dateadd(day,row_numbers,DD)) ='Jan' then 'January'
           when monthname(dateadd(day,row_numbers,DD)) ='Feb' then 'February'
           when monthname(dateadd(day,row_numbers,DD)) ='Mar' then 'March'
           when monthname(dateadd(day,row_numbers,DD)) ='Apr' then 'April'
           when monthname(dateadd(day,row_numbers,DD)) ='May' then 'May'
           when monthname(dateadd(day,row_numbers,DD)) ='Jun' then 'June'
           when monthname(dateadd(day,row_numbers,DD)) ='Jul' then 'July'
           when monthname(dateadd(day,row_numbers,DD)) ='Aug' then 'August'
           when monthname(dateadd(day,row_numbers,DD)) ='Sep' then 'September'
           when monthname(dateadd(day,row_numbers,DD)) ='Oct' then 'October'
           when monthname(dateadd(day,row_numbers,DD)) ='Nov' then 'November'
           when monthname(dateadd(day,row_numbers,DD)) ='Dec' then 'December' end
           ||' '|| to_varchar(dateadd(day,row_numbers,DD), ' dd, yyyy') as FULL_DATE_DESC,
      dateadd(day,row_numbers,DD) as V_DATE_1,
      dayofweek(V_DATE_1)+1 as DAY_NUM_IN_WEEK,
      Date_part(dd,V_DATE_1) as DAY_NUM_IN_MONTH,
      dayofyear(V_DATE_1) as DAY_NUM_IN_YEAR,
      case 
        when dayname(V_DATE_1) = 'Mon' then 'Monday'
        when dayname(V_DATE_1) = 'Tue' then 'Tuesday'
        when dayname(V_DATE_1) = 'Wed' then 'Wednesday'
        when dayname(V_DATE_1) = 'Thu' then 'Thursday'
        when dayname(V_DATE_1) = 'Fri' then 'Friday'
        when dayname(V_DATE_1) = 'Sat' then 'Saturday'
        when dayname(V_DATE_1) = 'Sun' then 'Sunday' end as DAY_NAME,
      dayname(dateadd(day,row_numbers,DD)) as DAY_ABBREV,
      case  
        when dayname(V_DATE_1) = 'Sun' and dayname(V_DATE_1) = 'Sat' then 
                 'Not-Weekday'
        else 'Weekday' end as WEEKDAY_IND,
       case 
        when (DATE_KEY = date_part(year, V_DATE)||'0101' or DATE_KEY = date_part(year, V_DATE)||'0704' or
        DATE_KEY = date_part(year, V_DATE)||'1225' or DATE_KEY = date_part(year, V_DATE)||'1226') then  
        'Holiday' 
        when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Wed' 
        and dateadd(day,-2,last_day(V_DATE_1)) = V_DATE_1  then
        'Holiday'
        when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Thu' 
        and dateadd(day,-3,last_day(V_DATE_1)) = V_DATE_1  then
        'Holiday'
        when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Fri' 
        and dateadd(day,-4,last_day(V_DATE_1)) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Sat' 
        and dateadd(day,-5,last_day(V_DATE_1)) = V_DATE_1  then
        'Holiday'
        when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Sun' 
        and dateadd(day,-6,last_day(V_DATE_1)) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Mon' 
        and last_day(V_DATE_1) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Tue' 
        and dateadd(day,-1 ,last_day(V_DATE_1)) = V_DATE_1  then
        'Holiday'
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Wed' 
        and dateadd(day,5,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Thu' 
        and dateadd(day,4,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Fri' 
        and dateadd(day,3,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sat' 
        and dateadd(day,2,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sun' 
        and dateadd(day,1,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Mon' 
        and date_part(year, V_DATE_1)||'-09-01' = V_DATE_1 then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Tue' 
        and dateadd(day,6 ,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Wed' 
        and (dateadd(day,23,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1  or 
           dateadd(day,22,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Thu' 
        and ( dateadd(day,22,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
           dateadd(day,21,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Fri' 
        and ( dateadd(day,21,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
           dateadd(day,20,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
         'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sat' 
        and ( dateadd(day,27,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
           dateadd(day,26,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sun' 
        and ( dateadd(day,26,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
           dateadd(day,25,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Mon' 
        and (dateadd(day,25,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
           dateadd(day,24,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Tue' 
        and (dateadd(day,24,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
           dateadd(day,23,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
         'Holiday'    
        else
        'Not-Holiday' end as US_HOLIDAY_IND,
      /*Modify the following for Company Specific Holidays*/
      case 
        when (DATE_KEY = date_part(year, V_DATE)||'0101' or DATE_KEY = date_part(year, V_DATE)||'0219'
        or DATE_KEY = date_part(year, V_DATE)||'0528' or DATE_KEY = date_part(year, V_DATE)||'0704' 
        or DATE_KEY = date_part(year, V_DATE)||'1225' )then 
        'Holiday'               
                when monthname(V_DATE_1) ='Mar' and dayname(last_day(V_DATE_1)) = 'Fri' 
        and last_day(V_DATE_1) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Mar' and dayname(last_day(V_DATE_1)) = 'Sat' 
        and dateadd(day,-1,last_day(V_DATE_1)) = V_DATE_1  then
        'Holiday'
        when monthname(V_DATE_1) ='Mar' and dayname(last_day(V_DATE_1)) = 'Sun' 
        and dateadd(day,-2,last_day(V_DATE_1)) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Tue'
                and dateadd(day,3,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Wed' 
        and dateadd(day,2,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Thu'
                and dateadd(day,1,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Fri' 
        and date_part(year, V_DATE_1)||'-04-01' = V_DATE_1 then
        'Holiday'
                when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Wed' 
        and dateadd(day,5,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Thu' 
        and dateadd(day,4,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Fri' 
        and dateadd(day,3,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
        'Holiday' 
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Sat' 
        and dateadd(day,2,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Sun' 
        and dateadd(day,1,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
        'Holiday' 
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Mon' 
                and date_part(year, V_DATE_1)||'-04-01'= V_DATE_1 then
        'Holiday' 
        when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Tue' 
        and dateadd(day,6 ,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
        'Holiday'   
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Wed' 
        and dateadd(day,5,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Thu' 
        and dateadd(day,4,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Fri' 
        and dateadd(day,3,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sat' 
        and dateadd(day,2,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sun' 
        and dateadd(day,1,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Mon' 
                and date_part(year, V_DATE_1)||'-09-01' = V_DATE_1 then
        'Holiday' 
        when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Tue' 
        and dateadd(day,6 ,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
        'Holiday' 
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Wed' 
        and dateadd(day,23,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Thu' 
        and dateadd(day,22,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Fri' 
        and dateadd(day,21,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1  then
         'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sat' 
        and dateadd(day,27,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sun' 
        and dateadd(day,26,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Mon' 
        and dateadd(day,25,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
        'Holiday'
        when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Tue' 
        and dateadd(day,24,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1  then
         'Holiday'     
        else
        'Not-Holiday' end as COMPANY_HOLIDAY_IND,
      case                                           
        when last_day(V_DATE_1) = V_DATE_1 then 
        'Month-end'
        else 'Not-Month-end' end as MONTH_END_IND,
          
      case when date_part(mm,date_trunc('week',V_DATE_1)) < 10 and date_part(dd,date_trunc('week',V_DATE_1)) < 10 then
            date_part(yyyy,date_trunc('week',V_DATE_1))||'0'||
            date_part(mm,date_trunc('week',V_DATE_1))||'0'||
            date_part(dd,date_trunc('week',V_DATE_1))  
         when date_part(mm,date_trunc('week',V_DATE_1)) < 10 and date_part(dd,date_trunc('week',V_DATE_1)) > 9 then
            date_part(yyyy,date_trunc('week',V_DATE_1))||'0'||
            date_part(mm,date_trunc('week',V_DATE_1))||date_part(dd,date_trunc('week',V_DATE_1))    
         when date_part(mm,date_trunc('week',V_DATE_1)) > 9 and date_part(dd,date_trunc('week',V_DATE_1)) < 10 then
            date_part(yyyy,date_trunc('week',V_DATE_1))||date_part(mm,date_trunc('week',V_DATE_1))||
            '0'||date_part(dd,date_trunc('week',V_DATE_1))    
        when date_part(mm,date_trunc('week',V_DATE_1)) > 9 and date_part(dd,date_trunc('week',V_DATE_1)) > 9 then
            date_part(yyyy,date_trunc('week',V_DATE_1))||
            date_part(mm,date_trunc('week',V_DATE_1))||
            date_part(dd,date_trunc('week',V_DATE_1)) end as WEEK_BEGIN_DATE_NKEY,
      date_trunc('week',V_DATE_1) as WEEK_BEGIN_DATE,

      case when  date_part(mm,last_day(V_DATE_1,'week')) < 10 and date_part(dd,last_day(V_DATE_1,'week')) < 10 then
            date_part(yyyy,last_day(V_DATE_1,'week'))||'0'||
            date_part(mm,last_day(V_DATE_1,'week'))||'0'||
            date_part(dd,last_day(V_DATE_1,'week')) 
         when  date_part(mm,last_day(V_DATE_1,'week')) < 10 and date_part(dd,last_day(V_DATE_1,'week')) > 9 then
            date_part(yyyy,last_day(V_DATE_1,'week'))||'0'||
            date_part(mm,last_day(V_DATE_1,'week'))||date_part(dd,last_day(V_DATE_1,'week'))   
         when  date_part(mm,last_day(V_DATE_1,'week')) > 9 and date_part(dd,last_day(V_DATE_1,'week')) < 10  then
            date_part(yyyy,last_day(V_DATE_1,'week'))||date_part(mm,last_day(V_DATE_1,'week'))||'0'||
            date_part(dd,last_day(V_DATE_1,'week'))   
         when  date_part(mm,last_day(V_DATE_1,'week')) > 9 and date_part(dd,last_day(V_DATE_1,'week')) > 9 then
            date_part(yyyy,last_day(V_DATE_1,'week'))||
            date_part(mm,last_day(V_DATE_1,'week'))||
            date_part(dd,last_day(V_DATE_1,'week')) end as WEEK_END_DATE_NKEY,
      last_day(V_DATE_1,'week') as WEEK_END_DATE,
      week(V_DATE_1) as WEEK_NUM_IN_YEAR,
      case when monthname(V_DATE_1) ='Jan' then 'January'
           when monthname(V_DATE_1) ='Feb' then 'February'
           when monthname(V_DATE_1) ='Mar' then 'March'
           when monthname(V_DATE_1) ='Apr' then 'April'
           when monthname(V_DATE_1) ='May' then 'May'
           when monthname(V_DATE_1) ='Jun' then 'June'
           when monthname(V_DATE_1) ='Jul' then 'July'
           when monthname(V_DATE_1) ='Aug' then 'August'
           when monthname(V_DATE_1) ='Sep' then 'September'
           when monthname(V_DATE_1) ='Oct' then 'October'
           when monthname(V_DATE_1) ='Nov' then 'November'
           when monthname(V_DATE_1) ='Dec' then 'December' end as MONTH_NAME,
      monthname(V_DATE_1) as MONTH_ABBREV,
      month(V_DATE_1) as MONTH_NUM_IN_YEAR,
      case when month(V_DATE_1) < 10 then 
      year(V_DATE_1)||'-0'||month(V_DATE_1)   
      else year(V_DATE_1)||'-'||month(V_DATE_1) end as YEARMONTH,
      quarter(V_DATE_1) as CURRENT_QUARTER,
      year(V_DATE_1)||'-0'||quarter(V_DATE_1) as YEARQUARTER,
      year(V_DATE_1) as CURRENT_YEAR,
      /*Modify the following based on company fiscal year - assumes Jan 01*/
            to_date(year(V_DATE_1)||'-01-01','YYYY-MM-DD') as FISCAL_CUR_YEAR,
            to_date(year(V_DATE_1) -1||'-01-01','YYYY-MM-DD') as FISCAL_PREV_YEAR,
      case when   V_DATE_1 < FISCAL_CUR_YEAR then
      datediff('week', FISCAL_PREV_YEAR,V_DATE_1)
      else 
      datediff('week', FISCAL_CUR_YEAR,V_DATE_1)  end as FISCAL_WEEK_NUM  ,
      decode(datediff('MONTH',FISCAL_CUR_YEAR, V_DATE_1)+1 ,-2,10,-1,11,0,12,
                   datediff('MONTH',FISCAL_CUR_YEAR, V_DATE_1)+1 ) as FISCAL_MONTH_NUM,
      concat( year(FISCAL_CUR_YEAR) 
           ,case when to_number(FISCAL_MONTH_NUM) = 10 or 
              to_number(FISCAL_MONTH_NUM) = 11 or 
                            to_number(FISCAL_MONTH_NUM) = 12  then
              '-'||FISCAL_MONTH_NUM
          else  concat('-0',FISCAL_MONTH_NUM) end ) as FISCAL_YEARMONTH,
      case when quarter(V_DATE_1) = 4 then 4
         when quarter(V_DATE_1) = 3 then 3
         when quarter(V_DATE_1) = 2 then 2
         when quarter(V_DATE_1) = 1 then 1 end as FISCAL_QUARTER,
      
      case when   V_DATE_1 < FISCAL_CUR_YEAR then
          year(FISCAL_CUR_YEAR)
          else year(FISCAL_CUR_YEAR)+1 end
          ||'-0'||case when quarter(V_DATE_1) = 4 then 4
           when quarter(V_DATE_1) = 3 then 3
           when quarter(V_DATE_1) = 2 then 2
           when quarter(V_DATE_1) = 1 then 1 end as FISCAL_YEARQUARTER,
      case when quarter(V_DATE_1) = 4  then 2 when quarter(V_DATE_1) = 3 then 2
        when quarter(V_DATE_1) = 1  then 1 when quarter(V_DATE_1) = 2 then 1
      end as FISCAL_HALFYEAR,
      year(FISCAL_CUR_YEAR) as FISCAL_YEAR,
      to_timestamp_ntz(V_DATE) as SQL_TIMESTAMP,
      'Y' as CURRENT_ROW_IND,
      to_date(current_timestamp) as EFFECTIVE_DATE,
      to_date('9999-12-31') as EXPIRA_DATE
      from table(generator(rowcount => 8401)) /*<< Set to generate 20 years. Modify rowcount to increase or decrease size*/