-------------- Set-2: PostgreSQL Basic Interview Query ------------------------------------------ 

 https://singhak.in/how-to-extract-year-and-month-from-date-in-postgresql/

-- 11). Get all employee detail from EmployeeDetail table whose "FirstName" not start 
						-- with any single character between 'a-p' 

-- ref of question -10th of SET-1 
select * from EmployeeDetail where firstname ~* '^[a-p]';

-- Solution:
select * from EmployeeDetail where firstname ~* '^[^a-p]'; 
				-- ~* → Case-insensitive regex match.
				-- ^[^a-p] → Matches strings starting with a character not in the range 'a' to 'p' (inclusive).
				-- This will exclude names starting with a, b, c, ..., p, regardless of case.
/*
'^[^a-p]'
	 	can be broken down like this:
				
				^ (outside square brackets) → anchors the pattern to the start of the string (i.e., match only if this is the first character).
				
				[^a-p] → the [] defines a character class, and the ^ inside the brackets means negation of the character range.
				
				🔍 So yes, this is the negation part:
				[^a-p] means: "any character that is NOT between 'a' and 'p'"
				
				Thus, '^[^a-p]' matches strings starting with a character outside the range a–p.
				
				✅ Example Matches:
				"Vikas" ✅ (starts with V, not in a–p)
				
				"Zara" ✅
				
				"nikta" ❌ (starts with n, in a–p)
				
				"ashish" ❌ (starts with a, in a–p)
 */


-- 12). Get all employee detail from EmployeeDetail table whose "Gender" end with 'le' 
					-- and contain 4 letters. The Underscore(_) Wildcard Character represents any single character. 

select * from EmployeeDetail where gender like '__le'; -- one _ Represents any single character


-- 13). Get all employee detail from EmployeeDetail table whose "FirstName" start with 
			-- 'A' or 'a' and contain 5 letters. 

select * from EmployeeDetail where firstname  ilike 'A____'; 

-- 14). Get all employee detail from EmployeeDetail table whose "FirstName" 
			-- containing '%'.	example :-   "Vik%as". 

-- Here this means we have bypass the %.
insert into EmployeeDetail (EmployeeID, FirstName, LastName, Salary, JoiningDate, Department, Gender)
values (10, 'anish2%t',  'kadian2',   500.00, '2014-01-09 09:31:07.793', 'Payroll2','Male2');
select * from EmployeeDetail where firstname like '%\%%';  -- \% is the escape. Means in question % % - text must contains %.
								delete from EmployeeDetail where EmployeeID = 10;



-- 15). Get all unique "Department" from EmployeeDetail table.

select distinct department from EmployeeDetail;

-- 16). Get the highest "Salary" from EmployeeDetail table.

select salary from employeedetail order by salary desc limit 1;
	--	or 
	select max(salary) as hightest_salary from employeedetail ;  -- with max() function.
	-- with multiple Query:
-- 		To get the employee(s) who earn the highest salary, you can even combine things like:
	select * from employeedetail where salary = (select max(salary) from employeedetail);
	
	
	
-- 	17). Get the lowest "Salary" from EmployeeDetail table.
	select * from employeedetail order by salary asc limit 1;
		-- or
				select MIN (salary) as lowest_salary from employeedetail;
			select * from employeedetail where salary  = (select MIN(salary) from employeedetail );
			



-------------------- Date Time related Queries) Extract() and TO_CHAR(col, 'format') Functions ------------------

-- 18). Show "JoiningDate" in "dd mmm yyyy" format, ex- "15 Feb 2013"
		select EXTRACT( day from joiningdate )|| ' ' || to_char(joiningdate, 'Mon')||
							' '|| extract(year from joiningdate) as joiningdate_formatted 
							from employeedetail;
		-- 			or 
		 select to_char(joiningdate, 'DD Mon YYYY') as joiningdate_formatted from employeedetail ; -- these are help to get in the format.
		  -- OR
		 select to_char(joiningdate, 'DD') || ' ' 
		     || to_char(joiningdate, 'Mon')|| ' '
		     || to_char(joiningdate, 'YYYY') as joiningdate_formatted from employeedetail;



-- 19). Show "JoiningDate" in "yyyy/mm/dd" format, ex- "2013/02/15" 
		select Extract(year from joiningdate)|| '/' ||  Extract(month from joiningdate)|| '/'||
			   Extract(day from joiningdate) as date_format_yyyymmdd from employeedetail;  -- Here not getting 2013/02/15 instead 2013/2/15. 
			   													-- Not prefixing 0 in single digit. You can use LPAD to resolve But here below
			   										-- Below have more better Approach.
	 -- OR
			select to_char(joiningdate, 'yyyy/mm/dd') from employeedetail;



-- 20). Show only time part of the "JoiningDate". 

		select Extract(hour from joiningdate)|| ':' ||  Extract(minute from joiningdate)|| ':'||
			   Extract(second from joiningdate) as TS from employeedetail; -- WRONG : 17:31:07.793 value getting as 17:31:7.793000

				select joiningdate , to_char(joiningdate, 'HH:MI:SS') as TS from employeedetail;
				
		/*
		  TO_CHAR(joiningdate, 'HH:MI:SS') – What's right and what's missing:
'HH' – 12-hour format (use 'HH24' for 24-hour). for HH24 how it look like : 03:45:10 ----> 15:45:10

'MI' – minutes (not MM, which is for month).

'SS' – seconds. TWO Digit in second. 11:16:28.290 --> 11:16:28

DONT USE 'hh:mm:ss', Since the correct case-sensitive format should be 'HH:MI:SS'.
		 */


				
-----------  SET -2 - Completed : 22/may/2025 at 12:58 AM ----------------------------------