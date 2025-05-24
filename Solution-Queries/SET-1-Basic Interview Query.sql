-------------- Set-1: PostgreSQL Basic Interview Query ------------------------------------------ 

-- 1. Write a query to get all employee detail from "EmployeeDetail" table 

select * from EmployeeDetail; 


-- 2. Write a query to get only "FirstName" column from "EmployeeDetail" table  

select e.firstname from employeeDetail e ;

-- 3. Write a query to get FirstName in upper case as "First Name".  

select UPPER(e.firstname) as "First Name" from employeeDetail e ;

-- 4. Write a query to get FirstName in lower case as "First Name". 

select 	LOWER(e.firstname)	from employeeDetail e ;

-- 5. Write a query for combine FirstName and LastName and display it as "Name" 
			-- (also include white space between first name & last name)  

select e.firstname|| ' ' || e.lastname as Name  from employeeDetail e ; -- Uses PostgreSQL's string concatenation operator (||)
									-- Behavior: If any value is NULL, the result is NULL.
									-- Example: If firstname = 'John' and lastname = NULL → Result: NULL
									-- Standard SQL? No, || is PostgreSQL-specific (but common in many DBs)
 -- OR 
		select CONCAT(e.firstname, ' ', e.lastname) as Name  from employeeDetail e ; -- with concat() function
									-- Concatenates all arguments.
									-- Behavior: Automatically treats NULL as empty string.
									-- Example: If firstname = 'John' and lastname = NULL → Result: 'John '
									-- Standard SQL? Yes. Portable and readable across systems like MySQL, PostgreSQL, SQL Server (with syntax differences).
		
		-- CONCAT_WS(separator, value1, value2, ...)
		select concat_ws(' ', e.firstname, e.lastname) as Name  from employeeDetail e ; -- Concatenate With Separator
									--  Concatenates using a separator (' ' in this case)
									-- Behavior: Skips NULL values entirely, no extra spaces.
									-- Example: If firstname = 'John', lastname = NULL → Result: 'John'
									-- Standard SQL? Not part of ANSI SQL, but supported by PostgreSQL, MySQL.
	
		
		
-- 6. Select employee detail whose name is "Vikas"  

select  *   from employeeDetail e  where firstname = 'Vikas'; -- or e.firstname


-------------------- WHERE string LIKE pattern; ------------------

-- 7. Get all employee detail from EmployeeDetail table whose "FirstName" start with latter 'a'.  

select * from employeeDetail e where firstname Ilike 'a%'; -- ignore case-sensitive : ilike  - EX: -- matches 'Vikas', 'vikas', 'VIKAS'
		

-- 8. Get all employee details from EmployeeDetail table whose "FirstName" contains 'k'  

select * from  employeeDetail e where e.firstname like '%k%'; 


-- 9. Get all employee details from EmployeeDetail table whose "FirstName" end with 'h'  

select * from  employeeDetail e where firstname like '%h';


-- 10. Get all employee detail from EmployeeDetail table whose "FirstName" start with 
						-- any single character between 'a-p'  

select * from employeeDetail where firstname  ~* '^[a-p]';  -- [a_p] if we use _ instead of - then it means start wit 'A' or 'a' since ~* used to ignore the case-sensitivity.
								-- 🔍 Explanation:
									--		~* → Case-insensitive regular expression match. If only * then case - Sensitve.
											
									--		^ → Anchors the match to the start of the string
											
									-- 		[a-p] → Matches any one character from a to p at the start

-----------  SET -1 - Completed : 21/may/2025 at 12:14 AM ----------------------------------
		