-------------- Set-5: PostgreSQL Basic Interview Query - (Group By Related Queries) ------------------------------------------ 


-- 42. Write the query to get the department and department wise total(sum) salary from "EmployeeDetail" table.

		select * from employeedetail e ;

	select department , sum(salary) as dept_wise_sal  from employeedetail  group by department  ;
/*	
department	    dept_wise_sal
Finance			550000.00
Payroll			500000.00
IT				1600000.00
HR				1010000.00
*/
	

-- 43. Write the query to get the department and department wise total(sum) salary, display it in ascending order according to salary. 

	select department, sum(salary) as "Total Salary" from employeedetail group by department order by "Total Salary" ;
					-- you need to use alias in order by since after group by there will no salary column in Grouped data.
					-- If alias not used then - RDER BY SUM(salary)															-- else 	This will fail, because there's no column named salary in the result—salary was aggregated, and the raw salary column no longer exists at this stage.
-- Aliases can’t be used in the WHERE or GROUP BY clauses — only can be used in ORDER BY and HAVING.
	/*
✅ Summary:
			Use the full expression: ORDER BY SUM(salary)
			Or use column index: ORDER BY 2
			Don’t use original column name after aggregation: ORDER BY salary ❌ 
	 */
	
	
	/*
Payroll	500000.00
Finance	550000.00
HR	1010000.00
IT	1600000.00
	 */
	
	/*
	 Execution flow:

				FROM employeedetail — get the data.

				(No WHERE clause)

				GROUP BY department — group data by department.

				(No HAVING clause)

				SELECT department, SUM(salary) AS "Total Salary" — calculate totals.

				ORDER BY "Total Salary" — sort by the summed salaries.
	 */


	
-- 	44. Write the query to get the department and department wise total(sum) salary, display it in descending order according to salary. 

	select department , SUM(salary ) as "Total Salary" from employeedetail group by department order by "Total Salary" DESC;
/*
IT		1600000.00
HR		1010000.00
Finance	550000.00
Payroll	500000.00
*/
	

-- 45. Write the query to get the department, total no. of departments, total(sum) salary with respect to department from "EmployeeDetail" table. 
	
	select department , COUNT(*) as "Dept Count", SUM(salary ) as "Total Salary" from employeedetail group by department ;
/*
	department Dept Count   Total Salary

Finance			1		550000.00
Payroll			1		500000.00
IT			    2		1600000.00
HR				2		1010000.00
*/
	
	
-- 46. Get department wise average salary from "EmployeeDetail" table order by salary ascending	.
	
	select department , AVG(salary ) as "Average Salary" from employeedetail group by department order by "Average Salary";
/*
department           Average Salary  
Payroll				500000.000000000000
HR					505000.000000000000
Finance				550000.000000000000
IT					800000.000000000000
 */	
	

-- 47. Get department wise maximum salary from "EmployeeDetail" table order by salary ascending.
	
	select department , MAX(salary) "Dept Max Salary"  from employeedetail group by department order by "Dept Max Salary";  

/*
department    Dept Max Salary  
Payroll			500000.00
HR				530000.00
Finance			550000.00
IT				1000000.00
*/
	
-- Get department wise minimum salary from "EmployeeDetail" table order by salary ascending.
	select  department , MIN(salary) as "Dept Min Salary" from employeedetail group by department order by  "Dept Min Salary";	
	
/*
department    Dept Min Salary	
HR				480000.00
Payroll			500000.00
Finance			550000.00
IT				600000.00	
*/

 USE OF HAVING :

-- 49. Write down the query to fetch Project name assign to more than one Employee .
 	select * from ProjectDetail;
	select projectname , COUNT(employeedetailid) as "Num of Emp in Project" from ProjectDetail group by projectname;

/* 
Project select * 
1	1	Task Track
2	1	CLP
3	1	Survey Managment
4	2	HR Managment
5	3	Task Track
6	3	GRS
7	3	DDS
8	4	HR Managment
9	6	GL Managment
 */	

-- 	select projectname , COUNT(employeedetailid) as "Num of Emp in Project" from ProjectDetail group by projectname;

projectname     Num of Emp in Project

GL Managment		1
Survey Managment	1
CLP					1
HR Managment		2
DDS					1
Task Track			2
GRS					1
	
 NOW need to use filter condition (will use having instead of where since having used on Grouped data) based on given requirent.
 
 select projectname , COUNT(employeedetailid) as "Num of Emp in Project" from projectdetail group by projectname 
-- 																	having "Num of Emp in Project" > 1;  -- ERRRRORRRR
 																	having COUNT(employeedetailid) > 1;
 -- You can use ALIAS in HAVING SINCE - Error reason: SQL evaluates the HAVING clause before the SELECT clause where the alias is defined.
 						-- In short: SQL doesn't know about the alias yet when it's evaluating HAVING.
 
 projectname     Num of Emp in Project
 HR Managment		2
Task Track			2


/*
 ✅ Key Rule:
 
Aggregate functions are calculated before SELECT, but after grouping.
Aliases are only available in SELECT and ORDER BY, not in WHERE or HAVING.
 */

-----------  SET -5 - Completed : 05/JUNE/2025 at 08:25 AM ----------------------------------
