-------------- Set-4: PostgreSQL Basic Interview Query - (Salary Related Queries) ------------------------------------------ 

-- 31. Select only one/top 1 record from "EmployeeDetail" table. 

select * from employeedetail limit 1;
-- 1	Vikas	Ahlawat	600000.00	2013-02-15 11:16:28.290	IT	Male


-- 32. Select all employee detail with First name "Vikas","Ashish", and "Nikhil".
 
select * from employeedetail where firstname in ('Vikas', 'Ashish', 'Nikhil'); -- We use IN() Operator for checking multiple OR conditon operator: colName IN (value1,value2,...)
/*
1	Vikas	Ahlawat	600000.00	2013-02-15 11:16:28.290	IT	Male
3	Ashish	Kumar	1000000.00	2014-01-09 10:05:07.793	IT	Male
4	Nikhil	Sharma	480000.00	2014-01-09 09:00:07.793	HR	Male
 */
	


-- 33. Select all employee detail with First name not in "Vikas","Ashish", and "Nikhil". 
select * from employeedetail e where e.firstname not in ('Vikas', 'Ashish', 'Nikhil');
/*
2	nikta	Jain	530000.00	2014-01-09 17:31:07.793	HR	Female
5	anish	kadian	500000.00	2014-01-09 09:31:07.793	Payroll	Male
6	Ravi	Verma	550000.00	2014-01-10 08:45:00.000	Finance	Male
 */


-- 34. Select first name from "EmployeeDetail" table after removing white spaces from right side .
	select rtrim(e.firstname) as FirstName from employeedetail e ;
/*
 * How to Trim Strings????????? : trim(). ltrim(), rtrim(), btrim()  ; here b for both
 * https://bipp.io/sql-tutorial/postgresql/trim-strings/#:~:text=In%20order%20to%20trim%20spaces,(right)%20of%20the%20string.&text=However%20the%20trim%20function%20not,they%20can%20remove%20any%20character.
 
 In order to trim spaces Postgres provides 3 main functions: trim which removes spaces from the start and the end of any string. 
 		The functions ltrim and rtrim allow to remove spaces only in the start(left) or the end(right) of the string.
 		
Vikas
nikta
Ashish
Nikhil
anish
Ravi
 */


-- 35. Select first name from "EmployeeDetail" table after removing white spaces from left side.
	select ltrim(firstname) as FirstName from employeedetail ;
/*
Vikas
nikta
Ashish
Nikhil
anish
Ravi
 */


-- 36. Display first name and Gender as M/F.(if male then M, if Female then F) 
	 	select firstname, left(gender, 1) as gender from employeedetail ; -- LEFT(string, n) - col or string , n- number of character we want from left side.
   -- https://neon.tech/postgresql/postgresql-string-functions/postgresql-left
/*
Vikas	M
nikta	F
Ashish	M
Nikhil	M
anish	M
Ravi	M
 */
	 	-- CASE statement/expression: https://www.w3schools.com/postgresql/postgresql_case.php
	 	 --  if-then-else statement - Here WHEN works as IF and THEN as ELSE. And Expression is like Switch Case
	 	--* https://www.postgresql.org/docs/current/functions-conditional.html
	 	-- https://www.geeksforgeeks.org/postgresql-case-statement/
	 	-- https://neon.tech/postgresql/postgresql-tutorial/postgresql-case
	 	select firstname,
	 							case
	 								when gender = 'Male' then 'M'
	 							 	when gender = 'Female' then 'F'
	 							else 'Unknown' -- Unknown or Unspecified
	 							end as Gender -- after end is Optional but we normally use Alias
	 			from employeedetail;
	 							
	 							
-- 37. Select first name from "EmployeeDetail" table prifixed with "Hello ". Means we have to use Hello in each firstname in return.
						-- "prefixed with 'Hello '" → You should add the text "Hello " in front of each first name in the result.
	select concat('Hello', ' ', firstname) 	 as "FirstName" from employeedetail;
-- ( || )double pipe operator
	select 'Hello '|| firstname as "FirstName" from employeedetail ; -- both are correct for concatanation of strings.
/*
Hello Vikas
Hello nikta
Hello Ashish
Hello Nikhil
Hello anish
Hello Ravi

🔍 Comparison
| Feature 							| CONCAT() | 											|| Operator |
|--------------------------			|--------------------------------------------	|---------------------------------------------|
| Mostly used in PostgreSQL? 		| ❌ Not as common (in PG) 					 	| ✅ More common in PostgreSQL |
| Null-safe? 						| ✅ Skips NULL values automatically 		 	| ❌ Returns NULL if any part is NULL |
| Readability 						| ✅ Clear for beginners 					 	| ✅ Very concise and natural for short cases |
| Standard SQL? 					| ✅ Yes, part of SQL standard 				 	| ❌ No, specific to PostgreSQL and some others|
| Flexibility 						| ✅ Good for many arguments (e.g., 3–4 pieces) | ✅ Simple for 2–3 parts |
| Performance 						| 🟰 No major difference in small queries 		| 🟰 No major difference |
You want null-safe concatenation — if any field is NULL, CONCAT() will treat it as an empty string (''), not return NULL.
✅ Use || for PostgreSQL-specific, simple cases — most commonly used.
✅ Use CONCAT() when you want null-safe, more portable SQL (especially if you may reuse the SQL on MySQL or other systems).
 */

	
-- 38. Get employee details from "EmployeeDetail" table whose Salary greater than 600000 .
		select * from employeedetail where salary > 600000 ;
-- 3	Ashish	Kumar	1000000.00	2014-01-09 10:05:07.793	IT	Male

-- 39. Get employee details from "EmployeeDetail" table whose Salary less than 700000
		select * from employeedetail where salary<700000;
/*
1	Vikas	Ahlawat	600000.00	2013-02-15 11:16:28.290	IT	Male
2	nikta	Jain	530000.00	2014-01-09 17:31:07.793	HR	Female
4	Nikhil	Sharma	480000.00	2014-01-09 09:00:07.793	HR	Male
5	anish	kadian	500000.00	2014-01-09 09:31:07.793	Payroll	Male
6	Ravi	Verma	550000.00	2014-01-10 08:45:00.000	Finance	Male
 */

-- 40. Get employee details from "EmployeeDetail" table whose Salary between 500000 than 600000.
		select * from employeedetail where salary between 500000 AND 600000; 
/*
1	Vikas	Ahlawat	600000.00	2013-02-15 11:16:28.290	IT	Male
2	nikta	Jain	530000.00	2014-01-09 17:31:07.793	HR	Female
5	anish	kadian	500000.00	2014-01-09 09:31:07.793	Payroll	Male
6	Ravi	Verma	550000.00	2014-01-10 08:45:00.000	Finance	Male 
 
--> The BETWEEN operator selects values within a given range. The values can be numbers, text, or dates.
				The BETWEEN operator is inclusive: begin and end values are included.

-->  The BETWEEN operator can also be used on text values.
The result returns all records that are alphabetically between the specified values.
 */


-- 41. Select second highest salary from "EmployeeDetail" table.
	select * from employeedetail order by salary desc limit 1 OFFSET 1;
-- Other way without using Limit and Offset:
	select MAX(salary) as second_max_salary from employeedetail 
				where salary  < (select max(salary)from employeedetail ) ;
								--  (select max(salary) as salary from employeedetail ) ; we dont need to make alis in subquery.
			🔍 Why it works:
			SELECT MAX(salary) gives the highest salary. 
			
			Then you filter the table to include only rows with salary less than the maximum.
			
			Finally, MAX(salary) on this filtered set gives the second highest.
			
			HOW??????????????
			Step 1: Execute the Subquery
					This scans the entire employeedetail table.
					Finds the highest salary.
					Example result: 80000
			✅ Step 2: Use the Subquery Result in the WHERE clause
						WHERE salary < 80000
						Now the outer query filters all rows where the salary is less than the highest value.
						The result is a subset of employees with salaries below the top.
			✅ Step 3: Apply the Aggregate Function on the Filtered rows
					Now it finds the maximum salary from the filtered rows.	
					That is the second highest salary.
					
						Step-by-step:
										Subquery: MAX(salary) → 80000
										
										Filter: salary < 80000 → keep 75000, 60000, 55000
										
										Outer MAX: MAX(salary) → 75000
										
										✅ So final result is 75000 — the second highest.
					
				/*
				 1	Vikas	Ahlawat	600000.00	2013-02-15 11:16:28.290	IT	Male
				
				second_max_salary 
				 600000.00
				 */

🔍 Explanation:
ORDER BY salary DESC → highest salaries first.

OFFSET 1 → skip the top 1.

LIMIT 1 → take the next one (i.e., 2nd highest).

--To get nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn-th highest salary:

SELECT DISTINCT salary
FROM employeedetail
ORDER BY salary DESC
OFFSET n-1 LIMIT 1;

Replace n with the number you want. 
Example for 2nd highest - n = 2 ==> 2-1 = 1 ==> OFFSET 2-1 LIMIT 1; ==> OFFSET 1 LIMIT 1;

--for window funciton :
🧠 Use this if:
You want the true 2nd distinct highest, even if salaries are repeated.
You may want more flexibility, like selecting all employees who earn the 2nd highest.

--OTHER WAYS to do:

| Use Case                              | Recommended Method               |
| ------------------------------------- | -------------------------------- |
| You want just the value (1 row)       | `LIMIT` + `OFFSET`               |
| You want to include ties (duplicates) | `DENSE_RANK()`                   |
| You want the nth highest with filters | `DENSE_RANK()` or `ROW_NUMBER()` |



-----------  SET -4 - Completed : 28/may/2025 at 10:23AM ----------------------------------