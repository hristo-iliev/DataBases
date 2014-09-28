/* 01. Write a SQL query to find the names and salaries of 
the employees that take the minimal salary in the 
company. Use a nested SELECT statement.*/
select FirstName + ' ' + LastName as Name, Salary from Employees
where Salary =
	( select min(Salary) from Employees )

/* 02. Write a SQL query to find the names and salaries of 
the employees that have a salary that is up to 10% 
higher than the minimal salary for the company.*/
select FirstName + ' ' + LastName as Name, Salary from Employees
where Salary <=
	( select min(Salary) from Employees ) * 1.1

/* 03. Write a SQL query to find the full name, salary and 
department of the employees that take the minimal 
salary in their department. Use a nested SELECT
statement. */
select e.FirstName + ' ' + e.LastName as Name, e.Salary, d.Name as Department from Employees e
join Departments d
	on e.DepartmentID = d.DepartmentID
where e.Salary =
	( select min(Salary) from Employees 
	  where DepartmentID = d.DepartmentID)

/* 04. Write a SQL query to find the average salary in the 
department #1. */
select min(d.Name) as Department, avg(e.Salary) as [Average Salary] from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentID = 1

/* 05. Write a SQL query to find the average salary in the 
"Sales" department. */
select min(d.Name) as Department, avg(e.Salary) as [Average Salary] from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.Name = 'Sales'

/* 06. Write a SQL query to find the number of employees 
in the "Sales" department. */
select min(d.Name) as Department, count(e.EmployeeID) as EmployeeCount from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.Name = 'Sales'

/* 07. Write a SQL query to find the number of all 
employees that have manager. */
select count(ManagerID) as CountOfEmployeesWithManager from Employees
	
/* 08. Write a SQL query to find the number of all 
employees that have no manager. */
select count(*) as CountOfEmployeesWithManager from Employees
where ManagerID is null

/* 09. Write a SQL query to find all departments and the 
average salary for each of them. */
select min(d.Name) as Department, avg(e.Salary) as AverageSalary from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentID

/* 10. Write a SQL query to find the count of all employees 
in each department and for each town. */
select min(d.Name) as Department, min(t.Name) as Town, count(e.EmployeeID) as Employees
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
join Addresses a on e.AddressID = a.AddressID
join Towns t on a.TownID = t.TownID
group by d.DepartmentID, t.TownID

/* 11. Write a SQL query to find all managers that have 
exactly 5 employees. Display their first name and 
last name. */
select min(m.FirstName) + ' ' + min(m.LastName) as Name, count(e.ManagerID) from Employees m
join Employees e on m.EmployeeID = e.ManagerID
group by e.ManagerID

/* 12. Write a SQL query to find all employees along with 
their managers. For employees that do not have 
manager display the value "(no manager)". */
select e.LastName as Employee, coalesce(m.LastName, 'no manager') as Manager from Employees e
left join Employees m on (m.EmployeeID = e.ManagerID)

/* 13. Write a SQL query to find the names of all 
employees whose last name is exactly 5 characters 
long. Use the built-in LEN(str) function. */
select LastName from Employees
where len(LastName) = 5

/* 14. Write a SQL query to display the current date and 
time in the following format "day.month.year 
hour:minutes:seconds:milliseconds". Search in 
Google to find how to format dates in SQL Server. */
SELECT convert(varchar, getdate(), 113)

/* 15. Write a SQL statement to create a table Users. 
Users should have username, password, full name 
and last login time. Choose appropriate data types 
for the table fields. Define a primary key column 
with a primary key constraint. Define the primary 
key column as identity to facilitate inserting records. 
Define unique constraint to avoid repeating 
usernames. Define a check constraint to ensure the 
password is at least 5 characters long. */

/*CREATE TABLE Users ( 
 UserID int IDENTITY NOT NULL, 
 UserName nvarchar(100) NOT NULL,
 Pass nvarchar(100) NOT NULL,
 FirstName nvarchar(50) NOT NULL,
 LastName nvarchar(50) NOT NULL,
 LastLogIn date, 
 CONSTRAINT PK_Users PRIMARY KEY (UserID), 
 CONSTRAINT UK_UserName UNIQUE (UserName),
 CONSTRAINT CHK_Pass CHECK (LEN(Pass) between 5 and 100) 
)*/



/* 16. Write a SQL statement to create a view that displays 
the users from the Users table that have been in the 
system today. Test if the view works correctly. */

/*CREATE VIEW CheckUser AS 
select LastLogIn from Users
where LastLogIn = cast(GETDATE() as date)*/
--select * from CheckUser


/* 17. Write a SQL statement to create a table Groups. 
Groups should have unique name (use unique 
constraint). Define primary key and identity column. */
/*CREATE TABLE Groups ( 
 GroupID int IDENTITY NOT NULL, 
 Name nvarchar(100) NOT NULL, 
 CONSTRAINT PK_Groups PRIMARY KEY(GroupID),
 CONSTRAINT UK_Name UNIQUE (Name) 
) */

/* 18. Write a SQL statement to add a column GroupID to 
the table Users. Fill some data in this new column 
and as well in the Groups table. Write a SQL 
statement to add a foreign key constraint between 
tables Users and Groups tables. */
/*ALTER TABLE Users 
ADD GroupID int

ALTER TABLE Users 
ADD CONSTRAINT FK_Users_Groups 
FOREIGN KEY (GroupID) 
REFERENCES Groups(GroupID) */


/*19. Write SQL statements to insert several records in 
the Users and Groups tables.*/
--INSERT INTO Groups
--VALUES ('PHP')

--INSERT INTO Users
--VALUES ('pepata', '12345', 'Petar', 'Peshov', '2014-08-24', 1);
--INSERT INTO Users
--VALUES ('mamata', '12345', 'Petar', 'Mishkov', '2014-08-24', 1);

/*20. Write SQL statements to update some of the 
records in the Users and Groups tables. */
--UPDATE Users
--SET FirstName='Ivan'
--WHERE LastName='Peshov';
select * from Users

/*21. Write SQL statements to delete some of the records 
from the Users and Groups tables. */
DELETE FROM Users
WHERE LastName='Mishkov';
select * from Users

/*22. Write SQL statements to insert in the Users table 
the names of all employees from the Employees
table. Combine the first and last names as a full 
name. For username use the first letter of the first 
name + the last name (in lowercase). Use the same 
for the password, and NULL for last login time.  */
/*INSERT INTO Users(Username, Pass, FirstName, LastName, GroupID)
SELECT  LOWER(LEFT(FirstName,3)+LastName),
                LOWER(LEFT(FirstName,3)+LastName),
                FirstName, LastName,
                1
FROM Employees*/

/*23. Write SQL statements to insert in the Users table 
the names of all employees from the Employees
table. Combine the first and last names as a full 
name. For username use the first letter of the first 
name + the last name (in lowercase). Use the same 
for the password, and NULL for last login time.  */
/*UPDATE Users
SET Pass = NULL
FROM Users
WHERE   LastLogin < CONVERT(datetime, '10-03-2010')
                AND Pass IS NOT NULL*/

/*24. Write a SQL statement that deletes all users without 
passwords (NULL password). */
--BEGIN TRAN
--DELETE FROM Users
--WHERE Pass IS NULL
 
--ROLLBACK TRAN

/*25. Write a SQL query to display the average employee 
salary by department and job title.  */
select min(d.Name) as Department, e.JobTitle, AVG(e.Salary) as AverageSalary from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
group by e.DepartmentID, e.JobTitle


/*26. Write a SQL query to display the minimal employee 
salary by department and job title along with the 
name of some of the employees that take it.   */
select min(e.FirstName + ' ' + e.LastName) as Name, min(d.Name) as Department,
			 e.JobTitle, min(e.Salary) as MinSalary
 from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
group by e.DepartmentID, e.JobTitle


/*27. Write a SQL query to display the town where 
maximal number of employees work. */
SELECT TOP(1) t.Name, COUNT(e.EmployeeID) AS WorkingEmployees
FROM Towns t
        JOIN Addresses a
        ON t.TownID = a.TownID
        JOIN Employees e
        ON e.AddressID = a.AddressID
GROUP BY t.Name
ORDER BY WorkingEmployees DESC

/*28. Write a SQL query to display the number of 
managers from each town. */ 
SELECT COUNT(DISTINCT e.ManagerID) as NumberOfManagers, t.Name
FROM Employees e
        JOIN Employees m
        ON e.ManagerID = m.EmployeeID
        JOIN Addresses a
        ON a.AddressID = m.AddressID
        JOIN Towns t
        ON a.TownID = t.TownID
GROUP BY t.Name