-------------- Set-6: PostgreSQL - Interview Query Join Interview Queries - (Join Related Queries) ------------------------------------------ 

-- WILL Need Two Tables EmployeeDetail & ProjectDetail

select * from EmployeeDetail;
select * from ProjectDetail;

-- 51. Get employee name, project name order by firstname from "EmployeeDetail" and 
			-- "ProjectDetail" for those employee which have assigned project already. 

select e.employeeid EMPID, e.firstname, p.projectname, p.employeedetailid EMPID_FROM_Project
				from employeedetail e inner join projectdetail p 
				on e.employeeid  = p.employeedetailid order by e.firstname;
/*
output:Why inner join????? -- SInce we needed - those employee which have assigned project . Here left and right table does not matter since we look for Common value if both.
eid  fname  projName  EMPID_FROM_Project
3	Ashish	GRS				3
3	Ashish	DDS				3
3	Ashish	Task Track		3
4	Nikhil	HR Managment	4
2	nikta	HR Managment	2
6	Ravi	GL Managment	6
1	Vikas	Survey Managment 1
1	Vikas	CLP				1
1	Vikas	Task Track	    1
*/


-- 52. Get employee name, project name order by firstname from "EmployeeDetail" and 
	--"ProjectDetail" for all employee even they have not assigned project. 

select e.employeeid EMPID, e.firstname, p.projectname, p.employeedetailid EMPID_FROM_Project 
	from employeedetail e left join projectdetail p 
	on e.employeeid  = p.employeedetailid order by e.firstname;

/*
output:Why LEFT JOIN????? -- SInce we needed - all the employees whether they have assigned any project or not . Here left (employees since all employee needed).
 so all 6 employee will be here.
eid  fname  projName  EMPID_FROM_Project
5	anish     NULL		    NULL
3	Ashish	GRS				3
3	Ashish	Task Track	    3
3	Ashish	DDS				3
4	Nikhil	HR Managment	4
2	nikta	HR Managment	2
6	Ravi	GL Managment	6
1	Vikas	Task Track		1
1	Vikas	CLP				1
1	Vikas	Survey Managment 1
*/


-- 53(35.1) Get employee name, project name order by firstname from "EmployeeDetail" and "ProjectDetail" for all employee if project is not assigned then 
			-- display "-No Project Assigned". 

select e.employeeid EMPID, e.firstname, coalesce(p.projectname, '-No Project Assigned') as Projectname, p.employeedetailid EMPID_FROM_Project
			from employeedetail e left join projectdetail p
			on e.employeeid = p.employeedetailid
			order by e.firstname;
-- have to give alias if using coalesce
-- We can use CASE WHEN as well


/*
output:Why LEFT JOIN????? -- SInce we needed - all the employees whether they have assigned any project or not . Here left (employees since all employee needed).
 so all 6 employee will be here.
eid  fname  projName 			 EMPID_FROM_Project
5	anish	-No Project Assigned	 NULL     --- id i printed null so that i can wheather this exist in project table or not.
3	Ashish	GRS						3
3	Ashish	Task Track				3
3	Ashish	DDS						3	
4	Nikhil	HR Managment			4
2	nikta	HR Managment			2
6	Ravi	GL Managment			6
1	Vikas	Task Track				1
1	Vikas	CLP						1
1	Vikas	Survey Managment		1
*/


/* use this only if multiple conditoned needs to check or fill different values
 
 CASE WHEN LOGIC:
 
 SELECT 
    e.employeeid AS EMPID, 
    e.firstname,
    p.employeedetailid AS EMPID_FROM_Project,
    CASE 
        WHEN p.employeedetailid IS NULL THEN '-No Project Assigned' 
        			-- just extra
        WHEN p.ProjectName = '' THEN 'Unnamed Project'
        ELSE p.ProjectName
    END AS ProjectName
FROM employeedetail e 
LEFT JOIN projectdetail p 
    ON e.employeeid = p.employeedetailid
ORDER BY e.firstname;
 
 -- changed conditon column order
 
SELECT 
    e.employeeid AS EMPID, 
    e.firstname, 
    CASE 
        WHEN p.employeedetailid IS NULL THEN '-No Project Assigned' 
       				 -- just extra
        WHEN p.ProjectName = '' THEN 'Unnamed Project'
        ELSE p.ProjectName
    END AS ProjectName,
    p.employeedetailid AS EMPID_FROM_Project
FROM employeedetail e 
LEFT JOIN projectdetail p 
    ON e.employeeid = p.employeedetailid
ORDER BY e.firstname;
 */


-- 54. Get all project name even they have not matching any employeeid, in left table, 
		-- order by firstname from "EmployeeDetail" and "ProjectDetail".

select e.employeeid EMPID, e.firstname, p.projectname , p.employeedetailid EMPID_FROM_Project
		from employeedetail e RIGHT JOIN  projectdetail p 
		on e.employeeid = p.employeedetailid;


/*
output:Why RIGHT JOIN????? -- SInce we needed - all project name even they have not matching any employeeid (not assigned to any employee) . Here RIGHT (project since all projects needed).
 so all projects will be here.
eid  fname  projName  EMPID_FROM_Project
1	Vikas	Task Track				1
1	Vikas	CLP						1
1	Vikas	Survey Managment		1
2	nikta	HR Managment			2
3	Ashish	Task Track				3
3	Ashish	GRS						3
3	Ashish	DDS						3
4	Nikhil	HR Managment			4
6	Ravi	GL Managment			6
NULL NULL	GL Managment 2 		  NULL	 --- SINCE No emloyee id for this project. Hence this project is not assigned to any employee. Project id will be 10
--NOTE- THis 10 the project was not there in DB so underatandng the quesry- I added this row manually then ran the Query for understanding.
*/


-- 55. Get complete record (employeename, project name) from both tables 
		--  ([EmployeeDetail],[ProjectDetail]), if no match found in any table then show NULL. 

select e.employeeid EMPID, e.firstname, p.projectname , p.employeedetailid EMPID_FROM_Project
		from employeedetail e FULL JOIN projectdetail p 
		on e.employeeid = p.employeedetailid ; -- full outer join also called 'full join' - all from both sides — matched and unmatched

		/*
output:Why full (OR full outer) JOIN????? -- SInce we needed - all from both sides — matched and unmatched
 so all projects will be here.
eid  fname  projName  		EMPID_FROM_Project
1	Vikas	Task Track				1
1	Vikas	CLP						1
1	Vikas	Survey Managment		1
2	nikta	HR Managment			2
3	Ashish	Task Track				3
3	Ashish	GRS						3
3	Ashish	DDS						3
4	Nikhil	HR Managment			4
6	Ravi	GL Managment			6
NULL NULL	GL Managment 2	       NULL --- SINCE No emloyee id for this project. Hence this project is not assigned to any employee. Project id will be 10
5	anish	NULL                   NULL		 -- this emloyee id was in project table. 

*/


-- 56. Write a query to find out the employeename who has not assigned any project, 
		-- and display "-No Project Assigned"( tables :- [EmployeeDetail],[ProjectDetail]).

select e.employeeid EMPID, e.firstname, coalesce(p.projectname, '-No Project Assigned') as projectname, p.employeedetailid EMPID_FROM_Project
		from employeedetail e LEFT JOIN projectdetail p 
		on e.employeeid = p.employeedetailid
		where p.projectname is NULL;

-- EXECUTION ORDER ===>  1️⃣ FROM → 2️⃣ ON → 3️⃣ JOIN → 4️⃣ WHERE → 5️⃣ SELECT → 6️⃣ ORDER BY
-- so SELECT IS EXECUTED after WHERE which means we made alias after filtering NULL project.


/*
output:Why LEFT JOIN????? -- SInce we needed - all employee that are not assigned any project.
 so all employee will be here. But we need to use WHERE clause since we need which has not assigned any project.
 
eid  fname  projName  EMPID_FROM_Project
5	anish	-No Project Assigned	NULL            ---- SINCE it was not in the project table. 		 
*/
		
		
-- 57. Write a query to find out the project name which is not assigned to any employee(tables :- [EmployeeDetail],[ProjectDetail]). 

select  e.employeeid EMPID, e.firstname, p.projectname, p.employeedetailid EMPID_FROM_Project
		from employeedetail e right join projectdetail p 
		on e.employeeid = p.employeedetailid
		where p.employeedetailid  is null;
		-- where e.firstname   is null; -- also coreect since if emp if not there then firstname will also null
		
/*
output:Why RIGHT JOIN?????

-- We use RIGHT JOIN to list all projects, including ones not assigned to any employee.
-- It keeps all rows from ProjectDetail and joins matching employees from EmployeeDetail.
-- If no match is found, employee fields like e.employeeid will be NULL.
-- So we filter with: WHERE e.employeeid IS NULL
-- This gives us projects with no assigned employee.

-- This tells us: “Give me all projects that have no employee assigned.”
🧾 Sample Output:
| EMPID | firstname | projectname   | EMPID_FROM_Project |
| ----- | --------- | ------------- | -------------------- |
| NULL  | NULL      | GL Management 2 |  NULL              |

🔍 What does this row mean?

"GL Management 2" exists in ProjectDetail.
But it’s not linked to any employee.
That’s why employee columns are NULL after the join.

✅ Why RIGHT JOIN is used:
We want to list all projects, even if they are not assigned to any employee.
RIGHT JOIN includes all rows from ProjectDetail, and joins matching employees from EmployeeDetail if found.
If no employee is found, the employee-related columns (EMPID, firstname) will be NULL.
So we filter for those NULLs to find unassigned projects: WHERE e.employeeid IS NULL
		 		 

technically both coprrect but:
WHERE e.firstname IS NULL ✅ (correct and clear — no matching employee)
WHERE p.employeedetailid IS NULL ❌ (risky — depends on how data is stored)

🧠 Best Practice:
Use nulls from the side you're testing for absence.

If you're using LEFT JOIN, check NULL on the right side.

If you're using RIGHT JOIN, check NULL on the left side (like e.firstname IS NULL).
*/
		


-- 58. Write down the query to fetch EmployeeName & Project who has assign more than one project. 
-- do some pen paper and then just normal inner join to see what are the emp that has project.  
-- select e.employeeid , e.firstname , p.projectname from employeedetail e inner join projectdetail p on e.employeeid = p.employeedetailid;
-- THEN think next step. YTou'll understand to which column we need to do GROUP BY.
select e.employeeid , e.firstname , p.projectname 
		from employeedetail e inner join projectdetail p 
		on e.employeeid = p.employeedetailid
		-- group by e.firstname having COUNT(e.employeeid)>1  ;-- WRONG ==> we have to use subQuery as well. and group by inside that.
		where e.employeeid in (select p2.employeedetailid from projectdetail p2 group by employeedetailid having  count(*)>1 ) 
		;

/*
 * STEP-1: To see which employees have projects, we do a basic INNER JOIN:
select e.employeeid , e.firstname , p.projectname 
		from employeedetail e inner join projectdetail p 
		on e.employeeid = p.employeedetailid;
		
1	Vikas	Task Track
1	Vikas	CLP
1	Vikas	Survey Managment
2	nikta	HR Managment
3	Ashish	Task Track
3	Ashish	GRS
3	Ashish	DDS
4	Nikhil	HR Managment
6	Ravi	GL Managment

STEP-2:  Find employees assigned to multiple projects: will give 1,3 - this will be the  employeeid.
->We now need to identify which employees appear more than once in the ProjectDetail table.
->We do that with a subquery using GROUP BY and HAVING COUNT(*) > 1: 

(select p2.employeedetailid from projectdetail p2 group by employeedetailid having  count(*)>1 )
		This returns employee IDs with more than one project assigned.

				
then final
Step 3: Use that subquery to filter the main result
Now, we plug this into a WHERE ... IN (...) clause to get full project details for those employees:
employeeid  firstname   projectname
1			Vikas			Task Track
1			Vikas			CLP
1			Vikas			Survey Managment
3			Ashish			Task Track
3			Ashish			GRS
3			Ashish			DDS

💡 Intuition Recap:
Start with a basic JOIN to see who has projects.

Use GROUP BY + HAVING COUNT(*) > 1 to find employees with >1 project.

Use a WHERE ... IN (...) to filter full details for only those employees.

NEXT : We can achieve same result using a CTE or JOIN-based filter instead of IN!
will do later
 */



-- 59. Write down the query to fetch ProjectName on which more than one employee are working along with EmployeeName. 

-- select p.employeedetailid, p.projectname from projectdetail p; 
select  p.projectname, e.firstname, e.employeeid
		from employeedetail e inner join projectdetail p 
		on e.employeeid = p.employeedetailid
		where p.projectname IN (select p2.projectname from projectdetail p2 group by p2.projectname having count(p2.employeedetailid)>1)
			;
-- OUTPUT FINAL:
/*
projectname		firstname	employeeid
Task Track		Vikas			1
HR Managment	nikta			2
Task Track		Ashish			3
HR Managment	Nikhil			4
*/


/*
--> select p.employeedetailid, p.projectname from projectdetail p; 
 
employeedetailid	projectname
1				Task Track
1					CLP
1					Survey Managment
2					HR Managment
3					Task Track
3					GRS
3					DDS
4					HR Managment
6					GL Managment
[NULL]				GL Managment 2

so only  HR Managment (2,4 employee) and Task Track(1,3 employee) should come since these projects are assigned more than 1 employee.
*/
-- select count(p.employeedetailid) "Count Empl WOrked" , p.projectname from projectdetail p group by p.projectname having count(p.employeedetailid)>1;
/*
Count Empl WOrked	projectname
2					HR Managment
2					Task Track
so 2 empl worked on HR Managment and 2 on Task Track.
*/

/* SIMPLE IINER JOIN : To see at least employee that has assigned any projet.
 
 select  p.projectname, e.firstname, e.employeeid
		from employeedetail e inner join projectdetail p 
		on e.employeeid = p.employeedetailid ;
 
 
projectname			firstname	employeeid
Task Track			Vikas	1
CLP					Vikas	1
Survey Managment	Vikas	1
HR Managment		nikta	2
Task Track			Ashish	3
GRS					Ashish	3
DDS					Ashish	3
HR Managment		Nikhil	4
GL Managment		Ravi	6

*/




🧠 How to Approach (No query — just thinking)
	✅ Step 1: Understand your tables
	You likely have:
			EmployeeDetail → info about employees (employeeid, firstname, etc.)		
			ProjectDetail → info about projects, including which employee is assigned (projectname, employeedetailid, etc.)		
			So every row in ProjectDetail represents one employee assigned to one project.
	
	✅ Step 2: What are you really trying to find?
			You want:			
			Projects that have more than one unique employee assigned.			
			Then, for each of those projects, show each employee's name.			
			So first find the projects with multiple employees, then use that to filter your results.
	
	✅ Step 3: What column should you GROUP BY?
	Ask yourself:
	“What defines a project?” → projectname
	“How can I count how many employees are on each project?” → COUNT(DISTINCT employeedetailid)
	
	That leads you to:
							GROUP BY projectname
							HAVING COUNT(employees) > 1

	✅ Step 4: Do I need a subquery or join?
					Yes. You can:
					Use a subquery to first find those "multi-employee projects"
					Then JOIN that subquery back with the full data to get employee names
					Or:
		      		Use a CTE for readability

🛠 Tools You'll Use
INNER JOIN between employee and project tables
GROUP BY projectname
HAVING COUNT(*) > 1

Possibly a subquery or CTE to isolate projects with >1 employee

👣 Summary of Steps
Join employee and project tables to connect names and projects

Group by projectname and count employees

Filter for HAVING COUNT(*) > 1

Use that result to get full project + employee name info


/*
You can also write:

LEFT JOIN → same as LEFT OUTER JOIN

RIGHT JOIN → same as RIGHT OUTER JOIN

FULL JOIN → same as FULL OUTER JOIN

🧠 Summary:
✅ INNER JOIN  Or Only JOIN→ 1 type

✅ OUTER JOIN means FULL JOIN or FULL OUTER JOIN → 3 types:

LEFT OUTER JOIN 

RIGHT OUTER JOIN

FULL OUTER JOIN
 */

-----------  SET -6 - Completed : 09/JULY/2025 at 01:09 AM ----------------------------------