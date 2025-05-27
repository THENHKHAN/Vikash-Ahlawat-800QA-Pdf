-------------- Set-3: PostgreSQL Basic Interview Query - (Date Time related Queries) ------------------------------------------ 

-- 21). Get only Year part of "JoiningDate". 

		select * from employeedetail e ;
		
		select Extract(year from joiningdate) as joining_date_year
						from employeedetail; -- it comes like the 2,013 and not 2013 
						
		other way:
		 select to_char(joiningdate, 'yyyy') as joining_date_year
		 				from employeedetail;
	
		
-- 22). Get only Month part of "JoiningDate". 

		select extract(month from joiningdate) as joining_date_month
						from employeedetail;-- correct  - but not adding 0 . getting 1,2,3 and not 01,02,03
						
		select to_char(joiningdate, 'mm') as joining_date_month
						from employeedetail e ; -- correct
		
		-- SO it all relies on how we need the result
						

-- 23). Get system date. 
					
		select DATE(now() ) as sys_date ;
		select CURRENT_DATE as currentdate; -- this and above both correct : 2025-05-24
		-- Current Date and Time (Timestamp):
		select now() as current_timestampl; -- 
		select CURRENT_TIMESTAMP;  -- 2025-05-24 08:37:24.027 +0530
		
		--  Current Time Only:
		select CURRENT_TIME ;	 -- 08:38:42 +0530
		
		
-- 24). Get UTC date. 
		select CURRENT_DATE AT TIME ZONE 'UTC'; -- 2025-05-23 18:30:00.000 
						-- This returns the output in 'YYYY-MM-DD hh:mm:ss.mmm' format.
		
		 -- Note - The time difference between IST(Indian Standard Time) and UTC(Coordinated Universal Time) is as follows:
							--  IST - UTC = 5:30 hours i.e. IST is ahead of UTC by 5 hours and 30 minutes.
		 select CURRENT_DATE as currentdate , CURRENT_DATE AT TIME ZONE 'UTC' as current_date_urc; 
		
		
-- 25). Get the first name, current date, joiningdate and diff between current date and 
					-- joining date in months. 	
		 
		 select e.firstname, CURRENT_DATE as "Current Date" , e.joiningdate "JoiningDate", 
--		 		to_char(CURRENT_DATE, 'mm') - CAST(TO_CHAR(e.joiningdate, 'mm'), INT) -- wogn entiher snyatx nor logic snce it will ignore year count.
				EXTRACT(year from AGE(CURRENT_DATE, e.joiningdate) ) * 12 +   -- converting year to month
				-- AGE(CURRENT_DATE, e.joiningdate) returns an interval
				EXTRACT(month from AGE(CURRENT_DATE, e.joiningdate) ) as "Total Months"				
		 		from employeedetail e ;
		 
		 		 ------- Other way without AGE()-----
		 SELECT 
				    e.firstname AS "First Name",
				    CURRENT_DATE AS "Current Date",
				    e.joiningdate AS "Joining Date",
				    (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM e.joiningdate)) * 12 +
				    (EXTRACT(MONTH FROM CURRENT_DATE) - EXTRACT(MONTH FROM e.joiningdate)) AS "Total Months Approx"
				FROM employeedetail e;
		
		-- you can make alias to contain one or more spaces using " "
	
--  26). Get the first name, current date, joiningdate and diff between current date and joining date in days. 


		 
		 select e.firstname "First Name", CURRENT_DATE as "Current Date", e.joiningdate as "Joining Date",
		 CURRENT_DATE - e.joiningdate::date as  "Total Days"		
		 from employeedetail e ;	
		--  ✅ Best way to get total days difference is still: ABOVE IS THE BEST.
		 
		 /*
		  *  to_char
		  * SELECT 
  e.firstname,
  CAST(TO_CHAR(CURRENT_DATE, 'YYYY') AS INT) - CAST(TO_CHAR(e.joiningdate, 'YYYY') AS INT) AS year_diff,
  CAST(TO_CHAR(CURRENT_DATE, 'MM') AS INT) - CAST(TO_CHAR(e.joiningdate, 'MM') AS INT) AS month_diff,
  CAST(TO_CHAR(CURRENT_DATE, 'DD') AS INT) - CAST(TO_CHAR(e.joiningdate, 'DD') AS INT) AS day_diff
FROM employeedetail e;
But you'd need to combine these diffs into days carefully (e.g., convert years and months to days approximately), which is error-prone.
		  */
		 
		 /* with extract - EXTRACT can only pull parts from a date or interval; it can't subtract dates by itself. But you can subtract dates, get an interval, and then extract days:
		  * SELECT
  e.firstname,
  CURRENT_DATE AS "Current Date",
  e.joiningdate,
  EXTRACT(DAY FROM (CURRENT_DATE - e.joiningdate::date)) AS "Days Difference"
FROM employeedetail e;

⚠️ Problem: This returns only the day part of the interval, not the total days if the interval is more than a month/year.

		  */
		 
		 
		 
-- 27). Get all employee details from EmployeeDetail table whose joining year is 2013. 

		 select * from employeedetail e 
--		 		where CAST(to_char(e.joiningdate, 'yyyy') as INT) = 2013;
		 		where EXTRACT(year from e.joiningdate) = 2013; -- both correct
		
-- 28). Get all employee details from EmployeeDetail table whose joining month is Jan(1).  He means JAN month and not 1 jan
		 	 select * from employeedetail e
--		 	  where extract(month from e.joiningdate)  = 1; exttact give single digit without 0 as prefix.
			  where to_char(e.joiningdate, 'mon') = 'jan'	; -- both correct 
		 
		 		
-- 29). Get all employee details from EmployeeDetail table whose joining date between "2013-01-01" and "2013-12-01". 	 
			  
			  select * from employeedetail e 
			  where e.joiningdate::date between '2013-01-01'::date  AND '2013-12-01'::date  ;
			  
			  -- OTHER WAYS to do the same 
			  
			  --1 : Recommended Option:
			   select * from employeedetail e where e.joiningdate::date between DATE '2013-01-01'  AND DATE '2013-12-01';
			  --2 : to_date
			  	 select * from employeedetail e where e.joiningdate::date between TO_DATE('2013-01-01', 'yyyy-mm-dd') and TO_DATE('2013-12-01', 'yyyy-mm-dd');
			  --3 : comparison operators >= and <=			 
			  select * from employeedetail e where e.joiningdate::date >= DATE '2013-01-01' and e.joiningdate::date <= DATE '2013-12-01'; 
			  
-- 30). Get how many employee exist in "EmployeeDetail" table. 
			select count(*) employee_count from employeedetail e ;-- You can also use COUNT(id) if id is a non-null primary key:
			  
	  
		 
-----------  SET -3 - Completed : 24/may/2025 at 09:57 AM ----------------------------------