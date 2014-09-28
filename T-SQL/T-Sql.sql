use AccountsDB
go
/*01. Create a database with two tables: Persons(Id(PK), FirstName, LastName, SSN)
 and Accounts(Id(PK), PersonId(FK), Balance). Insert few records for testing.
  Write a stored procedure that selects the full names of all persons.*/
create proc usp_SelectFullNameOfEmployees
as
	select FirstName + ' ' + LastName as FullName from Persons
go

exec usp_SelectFullNameOfEmployees
go

/*02. Create a stored procedure that accepts a number as a parameter and returns
 all persons who have more money in their accounts than the supplied number.*/
create proc usp_SelectEmployeesWithMoreMoneyThan (@balance money)
as
	select p.FirstName + ' ' + p.LastName as FullName, a.Balance from Persons p
	join Accounts a on a.PersonId = p.Id
	where a.Balance > @balance
go

exec usp_SelectEmployeesWithMoreMoneyThan 1000
go


/*03. Create a function that accepts as parameters – sum, yearly interest rate
 and number of months. It should calculate and return the new sum. Write a SELECT
 to test whether the function works as expected.*/
 ALTER FUNCTION ufn_BalanceWithYearlyInterest(@balance money, @yearlyInterest money, @months int)
  RETURNS money
AS
begin
	declare	@monthInterest money = @yearlyInterest / 12.00
	while (@months > 0)
	begin
		set @balance = @balance + (@balance * @monthInterest)
		set @months = @months - 1
	end
	return @balance  
end
go

select dbo.ufn_BalanceWithYearlyInterest(500.00, 0.5, 12)
go


/*04. Create a stored procedure that uses the function from the previous example
 to give an interest to a person's account for one month. It should take the 
 AccountId and the interest rate as parameters.*/
 create proc usp_BalanceWithInterestForOneMonth (@yearInterest money, @accoundId int)
as
	select dbo.ufn_BalanceWithYearlyInterest(a.Balance, @yearInterest, 1) from Accounts a
	where a.Id = @accoundId
go

exec usp_BalanceWithInterestForOneMonth 0.5, 1
go

/*05. Add two more stored procedures WithdrawMoney( AccountId, money) and
 DepositMoney (AccountId, money) that operate in transactions.*/
create proc usp_WithdrawMoney(@accountId int, @moneyToDraw money)        
as
    begin transaction
    declare @availableMoney money =
             (select Balance from Accounts
              where Id = @accountId) 
       if (@availableMoney >= @moneyToDraw)
       begin
             update Accounts
             set Balance = Balance - @moneyToDraw
             where Id = @accountId
             COMMIT
       end
    else
    begin
            RAISERROR ('Not enough money in account.', 16, 1)
            rollback tran
    end
go
 
exec usp_WithdrawMoney 1, 200
select * from Accounts
go
--DepositMoney (AccountId, money)
create proc usp_DepositMoney(@accountId int, @money money)
as
	begin transaction
	update Accounts
	set Balance = Balance + @money
	where Id = @accountId
	COMMIT
go

exec usp_DepositMoney 1, 250
go
select * from Logs
go

/*06. Create another table – Logs(LogID, AccountID, OldSum, NewSum).
 Add a trigger to the Accounts table that enters a new entry into the
 Logs table every time the sum on an account changes.*/
 create trigger tr_ChangeBalance on Accounts for update
 as	
	begin
	insert into dbo.Logs(AccountId, OldSum, NewSum)
	select i.Id, d.Balance,	i.Balance from inserted i
		join deleted d on d.Id = i.Id
	end 
go	


/*07. Define a function in the database TelerikAcademy that returns
 all Employee's names (first or middle or last name) and all town's
 names that are comprised of given set of letters. Example 'oistmiahf'
 will return 'Sofia', 'Smith', … but not 'Rob' and 'Guy'.*/
 create function search_string(@str nvarchar(60), @pattern nvarchar(60)) returns int as
begin
	
	if @str is null or @pattern is null return 0
	
	declare @i int = 1
	while @i <= len(@str) 
	begin
		declare @s nchar = substring(@str, @i, 1)
	
		if 0 = (select patindex('%' + @s + '%', @pattern))
		begin 
			return 0
		end

		set @i = @i + 1
	end
	return 1
end
go

alter function CheckNameFromPattern(@pattern nvarchar(60))
returns table as
return
	select e.FirstName, e.MiddleName, e.LastName, t.Name as Town
	from TelerikAcademy.dbo.Employees e
	join TelerikAcademy.dbo.Addresses a on e.AddressID = a.AddressID
	join TelerikAcademy.dbo.Towns t on a.TownID = t.TownID
	where 1 = dbo.search_string(e.FirstName, @pattern) 
		or 1 = dbo.search_string(e.MiddleName, @pattern)
		or 1 = dbo.search_string(e.LastName, @pattern)
		and 1 = dbo.search_string(t.Name , @pattern)
go

--test
select * from CheckNameFromPattern('oistmiahf')
go
/*08. Using database cursor write a T-SQL script that scans all employees
 and their addresses and prints all pairs of employees that live in the same town.*/
 DECLARE empCursor CURSOR FOR
  SELECT e.FirstName, e.LastName, t.Name as Town, o.FirstName, o.LastName
   FROM TelerikAcademy.dbo.Employees e
  inner join TelerikAcademy.dbo.Addresses a on e.AddressID = a.AddressID
  inner join TelerikAcademy.dbo.Towns t on a.TownID = t.TownID,
  TelerikAcademy.dbo.Employees o 
  INNER JOIN TelerikAcademy.dbo.Addresses a1
                        ON a1.AddressID = o.AddressID
                INNER JOIN TelerikAcademy.dbo.Towns t1
                        ON t1.TownID = a1.TownID 
  
OPEN empCursor
DECLARE @firstName varchar(50), @lastName varchar(50), @town varchar(50), @oFirstName varchar(50), @oLastName varchar(50)
FETCH NEXT FROM empCursor INTO @firstName, @lastName, @town, @oFirstName, @oLastName

WHILE @@FETCH_STATUS = 0
  BEGIN
  if (@firstName <> @oFirstName) AND (@lastName <> @oLastName)
  
    PRINT @firstName + ' ' + @lastName + '   <---TOWN: ' + @town + '--->   ' + @oFirstName + ' ' + @oLastName
    FETCH NEXT FROM empCursor 
    INTO @firstName, @lastName, @town, @oFirstName, @oLastName
  
  END

CLOSE empCursor
DEALLOCATE empCursor
go

/*09. Write a T-SQL script that shows for each town a list of all
 employees that live in it. Sample output:
 Sofia -> Svetlin Nakov, Martin Kulov, George Denchev
Ottawa -> Jose Saraiva*/
use TelerikAcademy
 DECLARE empCursor CURSOR FOR
  SELECT t.Name as Town, e.LastName as Name FROM Towns t
  join Addresses a on a.TownID = t.TownID
  join Employees e on a.AddressID = e.AddressID

OPEN empCursor
DECLARE @town varchar(50), @lastName char(50)
FETCH NEXT FROM empCursor INTO @town, @lastName

WHILE @@FETCH_STATUS = 0
  BEGIN
    PRINT @town + ' ' + @lastName
    FETCH NEXT FROM empCursor 
    INTO @town, @lastName
  END

CLOSE empCursor
DEALLOCATE empCursor
go