select * from HumanResources.Employee
select distinct jobtitle from HumanResources.Employee
select BusinessEntityID,JobTitle,VacationHours,OrganizationLevel  from HumanResources.Employee where MaritalStatus = 'S'order by Gender offset 2 rows fetch next 20 rows only
select count (jobtitle) as 'Single Staffs', Gender from HumanResources.Employee where MaritalStatus = 's' group by Gender
select * from HumanResources.Employee
select * from humanresources.EmployeeDepartmentHistory

-- Hard way
select HumanResources.Employee.JobTitle,HumanResources.EmployeeDepartmentHistory.DepartmentID from HumanResources.Employee join HumanResources.EmployeeDepartmentHistory on HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
  
  -- Easy way with Aliasis
select emp.JobTitle,edh.DepartmentID from HumanResources.Employee emp join HumanResources.EmployeeDepartmentHistory edh on emp.BusinessEntityID = edh.BusinessEntityID
   

 select * from HumanResources.EmployeeDepartmentHistory
  select * from HumanResources.Department

  select HumanResources.EmployeeDepartmentHistory.StartDate,HumanResources.Department.Name from HumanResources.EmployeeDepartmentHistory join HumanResources.Department on HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
    select edh.StartDate,hd.Name from HumanResources.EmployeeDepartmentHistory edh join HumanResources.Department hd on edh.DepartmentID = hd.DepartmentID

select * from Person.Person
 select p.firstname, e.jobtitle from HumanResources.Employee e left outer join Person.Person p on e.BusinessEntityID = p.BusinessEntityID

  select p.firstname, e.jobtitle from HumanResources.Employee e right outer join Person.Person p on e.BusinessEntityID = p.BusinessEntityID

  -- Get the full name and last name of the employees that the sum of their duration is greater than 5, you are getting the duration from humann resourves. employee department history and the names from person.person table no null value is accepted in the result

  select concat (P.FirstName,' ', P.LastName) as 'Full Name',datediff(YY,Startdate,ISNULL(e.EndDate,GETDATE())) as 'Duration' 
   from HumanResources.EmployeeDepartmentHistory E join 
   Person.Person P on E.BusinessEntityID  = P.BusinessEntityID 

     select concat (P.FirstName,' ', P.LastName) as 'Full Name',sum(datediff(YY,Startdate,ISNULL(e.EndDate,GETDATE()))) as 'Duration' 
   from HumanResources.EmployeeDepartmentHistory E join 
   Person.Person P on E.BusinessEntityID  = P.BusinessEntityID group by P.LastName, P.FirstName
   having sum(datediff(YY,Startdate,ISNULL(e.EndDate,GETDATE()))) > 5

   -- Equi Join 
   select person.person.FirstName,HumanResources.EmployeeDepartmentHistory.DepartmentID
    from Person.Person,HumanResources.EmployeeDepartmentHistory
	 where Person.Person.BusinessEntityID=HumanResources.EmployeeDepartmentHistory.BusinessEntityID

	 -- Cross join

	 select P.FirstName, P.LastName ,H.StartDate,h.ShiftID,h.EndDate
	 from Person.Person p cross join HumanResources.EmployeeDepartmentHistory h

	 -- self join
	 select * from HumanResources.Shift

	 select A.Firstname as Firstname1, B.Firstname as Firstname2, A.middlename
	 from Person.Person A , Person.Person B
	 where A.BusinessEntityID<>B.BusinessEntityID
	 and A.MiddleName=B.MiddleName

	 select S.name, s.StartTime, p.name,p.EndTime
	 from HumanResources.shift s join HumanResources.Shift p
	 on s.StartTime=p.EndTime
	 select * from person.person
	 	 select * from HumanResources.Shift
		 select * from HumanResources.Department
		 select * from HumanResources.EmployeeDepartmentHistory
-- 

select DH.StartDate as 'Employment Date', CONCAT (P.firstname,' ',P.lastname) as 'Full name',HumanResources.Department.Name
from HumanResources.EmployeeDepartmentHistory DH join Person.person P 
on DH.BusinessEntityID = P.BusinessEntityID
 
 -- Subqueries

 select * from HumanResources.Employee

 select jobtitle, VacationHours, Gender from HumanResources.Employee where 
 BusinessEntityID not in (select BusinessEntityID from Person.person where FirstName = 'Ken')

 -- Not In subquery
 select Name,GroupName from  HumanResources.Department where 
 DepartmentID not in (select DepartmentID from HumanResources.EmployeeDepartmentHistory where Name = 'Sales')

 -- Exists Subquery
  select Name,GroupName from  HumanResources.Department where exists
 (select DepartmentID from HumanResources.EmployeeDepartmentHistory where Name = 'Sales')

 -- Not Exists
  select Name,GroupName from  HumanResources.Department where not exists
 (select DepartmentID from HumanResources.EmployeeDepartmentHistory where Name = 'Sales')

  -- Get the full name and last name of the employees that the sum of their duration is greater than 5, you are getting the duration from humann resourves. employee department history and the names from person.person table no null value is accepted in the result
 
  select * from  HumanResources.EmployeeDepartmentHistory 
  Select * from Person.Person

  select concat (P.FirstName,' ', P.LastName) as 'Full Name',sum(datediff(YY,Startdate,ISNULL(e.EndDate,GETDATE()))) as 'Duration' 
   from HumanResources.EmployeeDepartmentHistory E join 
   Person.Person P on E.BusinessEntityID  = P.BusinessEntityID group by P.LastName, P.FirstName
   having sum(datediff(YY,Startdate,ISNULL(e.EndDate,GETDATE()))) > 5

   Select CONCAT (Person.Person.FirstName,' ',Person.Person.LastName) as 'Full Name'
    from  Person.Person where BusinessEntityID in 
	(select BusinessEntityID from HumanResources.EmployeeDepartmentHistory group by BusinessEntityID having sum(DATEDIFF(YY,Startdate,isnull(EndDate, getdate())))>5)

	select * from HumanResources.EmployeePayHistory

select * from sales.SalesOrderDetail
 
select * from sales.SalesOrderDetail s where LineTotal = (select max(LineTotal) from sales.SalesOrderDetail)

select * from sales.SalesOrderDetail s where LineTotal = (select max(LineTotal) from sales.SalesOrderDetail where SalesOrderID = s.SalesOrderID )

select * from HumanResources.EmployeePayHistory
select * from HumanResources.Employee

select BusinessEntityID, JobTitle from HumanResources.Employee where BusinessEntityID in (select BusinessEntityID from HumanResources.EmployeePayHistory where Rate > 40)

-- CTE is Common Table Experresions 

With PutaCTE(Rate) AS (select TOP 10 rate = rate from HumanResources.EmployeePayHistory)select Rate, max_Rate = (SELECT  max(rate) from PutaCTE) from PutaCTE


-- Over allows you to aggregate without using Group by
select SUM(s.UnitPrice) Over s.UnitPrice from sales.SalesOrderDetail s 

SELECT 'Columnnames' lag 'columnname' over (Partition by column name by salary) as lowersalary  from employee;



select BusinessEntityID,OrganizationLevel, VacationHours from HumanResources.Employee e where Vacationhours = (select min(Vacationhours) from HumanResources.Employee where OrganizationLevel = e.OrganizationLevel)

With CTE_Prod(ProductID, TotalQuantity) as (SELECT ProductID, SUM(quantity) from Production.TransactionHistory Group by ProductID) SELECT ProductID,TotalQuantity, MaxQuantity = (SELECT MAX(TOTALQUANTITY) FROM CTE_Prod) FROM CTE_Prod order by TotalQuantity DESC


-- Create a target table
 CREATE TABLE Products(
 ProductID INT PRIMARY KEY,
 ProductName VARCHAR (100),
 Rate MONEY
 )
 GO

 -- Insert records into target table 
 INSERT INTO Products
 VALUES
    (1, 'Tea', 10.00),
	(2,'Coffee',20.00),
	(3, 'Muffin', 30.00),
	(4,'Biscuit', 40.00),
	(5, 'coke',70.00)
	GO

-- Create source table

CREATE TABLE UpdatedProducts
(
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(100),
  Rate MONEY
  )
  GO

  -- Insert records into source table 
  INSERT INTO UpdatedProducts
  VALUES
  (1, 'Tea',10.00)
  (2, 'coffee',25.00)
  (3,'Muffin',35.00)
  (4,'Biscuit',80.00)
  (5,'Pizza',60.00)


  SELECT * FROM Products
  SELECT * FROM UpdatedProducts
  GO


  -- MERGE SQL statement - Part 2 

  -- Synchronize the target table with  refreshed data from source table
  MERGE Products AS TARGET
  USING UpdatedProducts AS SOURCE
  ON (TARGET.ProductID = SOURCE.ProductID)
  WHEN MATCHED AND TARGET.ProductName <> SOURCE.ProductName OR TARGET.Rate <> SOURCE.Rate
  THEN UPDATE SET TARGET.ProductName = SOURCE.ProductName, TARGET.Rate = SOURCE.RATE
  WHEN NOT MATCHED BY TARGET 
  THEN INSERT (ProductID, ProductName, Rate) VALUES ( SOURCE.ProductID, SOURCE.ProductName, SOURCE.Rate)
  WHEN NOT MATCHED BY SOURCE 
  THEN DELETE
  OUTPUT $action,
  DELETED.ProductID AS TargetProductID,
  DELETED.ProductName AS TargetproductName,
  DELETED.Rate AS TargetRate,
  INSERTED.ProductID AS SourceProductID,
  INSERTED.ProductName AS SourceProductName,
  INSERTED.Rate AS SourceRate;

  SELECT @@ROWCOUNT;
  GO









