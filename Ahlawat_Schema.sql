CREATE TABLE EmployeeDetail (
    EmployeeID   SERIAL PRIMARY KEY,
    FirstName    VARCHAR(50),
    LastName     VARCHAR(50),
    Salary       NUMERIC(10, 2),
    JoiningDate  TIMESTAMP,
    Department   VARCHAR(50),
    Gender       VARCHAR(10)
);


INSERT INTO EmployeeDetail (EmployeeID, FirstName, LastName, Salary, JoiningDate, Department, Gender) VALUES
(1, 'Vikas',  'Ahlawat',  600000.00, '2013-02-15 11:16:28.290', 'IT',     'Male'),
(2, 'nikta',  'Jain',     530000.00, '2014-01-09 17:31:07.793', 'HR',     'Female'),
(3, 'Ashish', 'Kumar',   1000000.00, '2014-01-09 10:05:07.793', 'IT',     'Male'),
(4, 'Nikhil', 'Sharma',   480000.00, '2014-01-09 09:00:07.793', 'HR',     'Male'),
(5, 'anish',  'kadian',   500000.00, '2014-01-09 09:31:07.793', 'Payroll','Male');


select * from employeeDetail;



CREATE TABLE ProjectDetail (
    ProjectDetailID     SERIAL PRIMARY KEY,
    EmployeeDetailID    INTEGER REFERENCES EmployeeDetail(EmployeeID),
    ProjectName         VARCHAR(100)
);

INSERT INTO ProjectDetail (ProjectDetailID, EmployeeDetailID, ProjectName) VALUES
(1, 1, 'Task Track'),
(2, 1, 'CLP'),
(3, 1, 'Survey Managment'),
(4, 2, 'HR Managment'),
(5, 3, 'Task Track'),
(6, 3, 'GRS'),
(7, 3, 'DDS'),
(8, 4, 'HR Managment'),
(9, 6, 'GL Managment');  -- Note: Employee ID 6 does not exist in the EmployeeDetail table

INSERT INTO EmployeeDetail (EmployeeID, FirstName, LastName, Salary, JoiningDate, Department, Gender) VALUES
(6, 'Ravi', 'Verma', 550000.00, '2014-01-10 08:45:00.000', 'Finance', 'Male');

select * from ProjectDetail;


select * from FuelDetail;


CREATE TABLE FuelDetail (
    ID    SERIAL PRIMARY KEY,
    Fuel  INTEGER,
    Date  TIMESTAMP
);

INSERT INTO FuelDetail (ID, Fuel, Date) VALUES
(1,  10, '2014-04-25 10:00:00.000'),
(2,   9, '2014-04-25 11:00:00.000'),
(3,  12, '2014-04-25 12:00:00.000'),
(4,   6, '2014-04-25 13:00:00.000'),
(5,  12, '2014-04-25 14:00:00.000'),
(6,  12, '2014-04-25 15:00:00.000'),
(7,  12, '2014-04-25 16:00:00.000'),
(8,  12, '2014-04-25 17:00:00.000'),
(9,   8, '2014-04-25 18:00:00.000'),
(10,  9, '2014-04-25 19:00:00.000'),
(11,  5, '2014-04-25 20:00:00.000'),
(12,  4, '2014-04-25 21:00:00.000'),
(13,  9, '2014-04-25 22:00:00.000'),
(14, 15, '2014-04-25 23:00:00.000');








