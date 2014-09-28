/*04. Write a SQL query to find all information about all 
departments (use "TelerikAcademy" database).*/
select * from Departments

/*05. Write a SQL query to find all department names.*/
select Name from Departments

/*06. Write a SQL query to find the salary of each 
employee.*/
select FirstName + ' ' + LastName as Name, Salary from Employees

/*07. Write a SQL to find the full name of each employee.*/
select FirstName + ' ' + LastName as Name from Employees

/*08. Write a SQL query to find the email addresses of 
each employee (by his first and last name). Consider 
that the mail domain is telerik.com. Emails should 
look like “John.Doe@telerik.com". The produced 
column should be named "Full Email Addresses".*/

select FirstName + '.' + LastName + '@telerik.com' as [Full Email Addresses] from Employees

/*09. Write a SQL query to find all different employee 
salaries.*/
select FirstName + ' ' + LastName as Name, Salary from Employees

/*10. Write a SQL query to find all information about the 
employees whose job title is “Sales Representative“.*/
select * from Employees
where JobTitle = 'Sales Representative'

/*11. Write a SQL query to find the names of all 
employees whose first name starts with "SA".*/
select FirstName + ' ' + LastName as Name from Employees
where FirstName like 'SA%'

/*12. Write a SQL query to find the names of all 
employees whose last name contains "ei".*/
select FirstName + ' ' + LastName as Name from Employees
where LastName like '%ei%'

/*13. Write a SQL query to find the salary of all employees 
whose salary is in the range [20000…30000].*/
select FirstName + ' ' + LastName as Name, Salary from Employees
where Salary between 20000 and 30000

/*14. Write a SQL query to find the names of all 
employees whose salary is 25000, 14000, 12500 or 
23600.*/
select FirstName + ' ' + LastName as Name, Salary from Employees
where Salary in (25000, 14000, 12500, 23600)

/*15. Write a SQL query to find all employees that do not 
have manager.*/
select FirstName + ' ' + LastName as Name from Employees
where ManagerID is null

/*16. Write a SQL query to find all employees that have 
salary more than 50000. Order them in decreasing 
order by salary.*/
select FirstName + ' ' + LastName as Name, Salary from Employees
where Salary > 50000
order by Salary DESC

/*17. Write a SQL query to find the top 5 best paid 
employees.*/
select top 5 FirstName + ' ' + LastName as Name, Salary from Employees
order by Salary DESC

/*18. Write a SQL query to find all employees along with 
their address. Use inner join with ON clause.*/
select e.FirstName + ' ' + e.LastName as Name, a.AddressText as [Address], t.Name as Town
 from Employees e 
 join Addresses a on e.AddressID = a.AddressID
 join Towns t on a.TownID = t.TownID

 /*19. Write a SQL query to find all employees and their 
address. Use equijoins (conditions in the WHERE
clause).*/
select e.FirstName + ' ' + e.LastName as Name, a.AddressText as [Address], t.Name as Town
 from Employees e, Addresses a, Towns t  
 where e.AddressID = a.AddressID and a.TownID = t.TownID

 /*20. Write a SQL query to find all employees along with 
their manager.*/
select e.FirstName + ' ' + e.LastName as Employee, m.FirstName + ' ' + m.LastName as Manager 
from Employees e
full join Employees m on m.EmployeeID = e.ManagerID

 /*21. Write a SQL query to find all employees, along with 
their manager and their address. Join the 3 tables: 
Employees e, Employees m and Addresses a.*/
select e.FirstName + ' ' + e.LastName as Employee, m.FirstName + ' ' + m.LastName as Manager,
	 a.AddressText as [Address], t.Name as Town   
from Employees e
full join Employees m on m.EmployeeID = e.ManagerID
join Addresses a on e.AddressID = a.AddressID
join Towns t on a.TownID = t.TownID

 /*22. Write a SQL query to find all departments and all 
town names as a single list. Use UNION.*/
select Name from Departments
union
select Name from Towns

 /*23. Write a SQL query to find all the employees and the 
manager for each of them along with the employees 
that do not have manager. Use right outer join. 
Rewrite the query to use left outer join.*/
select e.FirstName + ' ' + e.LastName as Employee, m.FirstName + ' ' + m.LastName as Manager 
from Employees e
left join Employees m on m.EmployeeID = e.ManagerID

select e.FirstName + ' ' + e.LastName as Employee, m.FirstName + ' ' + m.LastName as Manager 
from Employees e
right join Employees m on m.EmployeeID = e.ManagerID

 /*24. Write a SQL query to find the names of all 
employees from the departments "Sales" and 
"Finance" whose hire year is between 1995 and 2005.*/
select e.FirstName + ' ' + e.LastName as Name, d.Name as Department, e.HireDate from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where (d.Name in ('Finance', 'Sales')) and (e.HireDate between '1995-01-01' and '2005-12-31')


