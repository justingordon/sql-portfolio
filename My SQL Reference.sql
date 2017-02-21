/* ********************************************
************* SQL REFERENCE SHEET *************
******************************************** */


/* *************** OPERATORS *************** */


=			--Equal
<>			--Not Equal Note: In some versions of SQL this operator may be written as !=
>			--Greater than
<			--Less than
>=			--Greater than or equal to
<			--Less than or equal to
BETWEEN		--Between an inclusive range. Can also use: 
			--NOT BETWEEN
			--BETWEEN 'a' and 'dog'
LIKE		--Search for a pattern. % is used as a wild card. 
			--Can also use NOT LIKE
IN			--To specify multiple possible values for a column



/* ********** AGGREGATE FUNCTIONS ********** */

--These are the most commonly used aggregate functions

AVG()		--Returns the average value
COUNT()		--Returns the number of rows
FIRST()		--Returns the first value
LAST()		--Returns the last value
MAX()		--Returns the largest value
MIN()		--Returns the smallest value
SUM()		--Returns the sum

--not sure if these functions are 'aggregate', but they're useful
datetime()	--Returns the current date and time
isnull()	--If the enclosed column/variable value is null then it will default to a specified value



/* ***************** TABLES **************** */
/*
TABLE Statements	
Create - Used to create tables
(No retrieve function?)
Alter - Used to modify the table (e.g. add or drop columns)
Truncate - Used to remove all rows/records from a table
Drop - Used to drop tables or columns
*/


/* *********** CREATE AND DELETE *********** */

--CREATE TABLES

	create table dbo.TableName(
		FieldName datatype not null identity(1,1),
		FieldName2 datatype null
	);

	create table dbo.EntityType(
		EntityTypeId	int not null identity(1,1),
		EntityTypeName	varchar(50) not null,
		EntityId		int not null
	);
	

--CREATE COLUMNS
	alter table dbo.TableName add ColumnName datatype null/not null


--UPDATE TABLE
	alter table <schema>.<TableName>

--UPDATE COLUMN
	alter table <schema>.<TableName>
	alter column <ColumnName> datatype null | not null;


--DROP TABLES
	drop table dbo.TableName

--DROP COLUMNS
	alter table dbo.TableName drop column ColumnName


--DROP TABLE VALUES
	truncate table dbo.TableName


--ADD PRIMARY KEY

--Example
	alter table dbo.Client
	add constraint PK_Client_ClientID primary key(ClientId);

--When creating table
	create table dbo.Person(
		PersonId	int not null identity(1,1),
		Title		varchar(5) null,
		FirstName	varchar(5) not null,
		LastName	varchar(5) not null,
		Primary key(PersonId)
	);


--ADD FOREIGN KEY
	alter table dbo.TableName
	add constraint ForeignKeyName foreign key(Column) references dbo.OtherTable(PrimaryKeyColumnFromOtherTable);

	--example
	alter table dbo.Employee
	add constraint FK_Employee_PersonId foreign key(PersonId) references dbo.Person(PersonId);
	--When someone adds a record to the Employee table, a record with the same PersonId must first exist in the Person table


--DROP PRIMARY KEY



/* ***************** SELECT **************** */

--Rename using a column alias
	select	EmployeeID as ID
	from	dbo.Employee
	
	select	TermDate as [Date of Termination]
	from	dbo.Employee


--Rename using a table alias
	select	a.EmployeeID
	from	dbo.Employee a


--Select the top # results from a table
	select	top 2 * --This returns the top 2 results
	from	dbo.Person 


--Select only the records with unique (distinct) values
	select distinct(HireDate)
	from	dbo.Employee


--Putting it all together
	select distinct (em.EmailId) as [E-Mail ID]
	from	dbo.Email as em



--FILTER RESULTS

	--Using where clause
	select	*
	from	dbo.Employee
	where	HireDate > '1/1/2009'


	--Multiple clauses that must match
	select	*
	from	dbo.Employee a inner Join dbo.Person b
	on		a.PersonID = b.PersonId
	where	b.Title='Mr.'
	and		b.LastName='Simmer'


	--Multiple clauses matching either 
	select	*
	from	dbo.Employee a inner Join dbo.Person b
	on		a.PersonID = b.PersonId
	where	b.Title='Mr.'
	or		b.LastName='Simmer'


	--Matching a pattern using the LIKE clause
	select	*
	from	dbo.Employee a inner Join dbo.Person b
	on		a.PersonID = b.PersonId
	where	b.LastName like '%n%'


	--Filter results using IN clause
	select	*
	from	dbo.Employee a
	where	a.PersonId in (1,3,6)

	--Filter results using IN clause and a sub-query
	select	*
	from	dbo.Employee a
	where	a.PersonId in (	select PersonId
							from	dbo.Person
							where	PersonId = 2)




--JOIN ANSI (American National Standards Institution) Standard
select		a.ColumnName,
			a.ColumnName,
			b.ColumnName,
			c.ColumnName
from		table01 as a
inner join	table02 as b on a.ColumnName = b.ColumnName
inner join	table03 as c on b.ColumnName = c.ColumnName


--Old SQL Join
select		a.ColumnName,
			a.ColumnName,
			b.ColumnName
from		table01 a,
			table02 b
where		a.ColumnName = b.ColumnName

--Types of Joins

	inner join
	left outer join
	right outer join
	full outer join


--Order By Clause
	select		*
	from		dbo.Employee a inner Join dbo.Person b
	on			a.PersonID = b.PersonId
	order by	a.EmployeeId desc,
				b.LastName asc



--Aggregate Functions

--Aggregate functions are programmed to return a single value. One common mistake I see is when users are trying to use aggregate
--functions in their SELECT statement while also trying to include a column in the SELECT clause that isn't an aggregate function.


--Average - AVG()
	select	avg(a.PersonId) as AvgPersonId
	from dbo.Person a

--Count - COUNT()
	select	count(*)
	from	dbo.Person

--Sum - SUM()
	select	sum(a.PersonId) as SumPersonId
	from	dbo.Person a


--Max Value - MAX()
	select	max(a.PersonId) as MaxPersonId
	from	dbo.Person a

--Min Value - MIN()
	select	min(a.PersonId) as MinPersonId
	from dbo.Person a



--GROUP BY

--The GROUP BY statement is used in conjunction with the aggregate functions to group the resultset by one or more columns.

--Example

	select		b.EmployeeId,
				count(*) as NumberOfAccounts
	from		dbo.Person a
	inner join	dbo.Employee b on a.PersonId = b.PersonId
	inner join	dbo.LoyaltyAccount c on b. EmployeeId = c.EmployeeId
	inner join	dbo.LoyaltyCompany d on c.LoyaltyCompanyId = d.LoyaltyCompanyId
	group by	b.EmployeeId


--Example Expanded

	select			a.PersonId,
					a.FirstName,
					a.LastName,
					b.EmployeeId,
					isnull(c.NumberOfAccounts, 0) as NumberOfAccounts
	from			dbo.Person a
	inner join		dbo.Employee b on a.PersonId = b.PersonId
	left outer join		(	select		b.EmployeeId,
										count(*) as NumberOfAccounts
							from		dbo.Person a
							inner join	dbo.Employee b on a.PersonId = b.PersonId
							inner join	dbo.LoyaltyAccount c on b. EmployeeId = c.EmployeeId
							inner join	dbo.LoyaltyCompany d on c.LoyaltyCompanyId = d.LoyaltyCompanyId
							group by	b.EmployeeId) c on b.EmployeeId = c.EmployeeId



/* ***************************************** */
/* ****************** CRUD ***************** */
/* ***************************************** */

/*
Create - CREATE and INSERT statements. Uses table name, column names and datatypes
Retrieve - SELECT statement. Uses FROM
Update - UPDATE statement. Uses SET and WHERE 
Delete - DELETE statement. Uses FROM and WHERE
*/



/* ***************** INSERT **************** */

--The values in the values clause must match with the column data types (e.g. int value for int column data type
--Text values need to be enclosed in single quotes
--If a field is required, a value must be specified or the value will fail

--WITHOUT COLUMN NAME
--When we write an insert statement without specifying the column names the number of items in the values
--list must match the number of columns in the table

insert into dbo.Email values('eric.begin@astontech.com', 6, 1);


--WITH COLUMN NAMES
insert into dbo.Email(EmailAddress, EmployeeId, EntityTypeId)
values('eric.begin@astontech.com', 6, 1);


--WITH A SELECT STATEMENT
--The select statement looks of the value of EntityTypeId and uses it as part of the insert statement
insert into dbo.EMail(EmailAddress, EmployeeId, EntityTypeId)
select		'sean@personal.com',
			4,
			EntityTypeId
from		Entity a
inner join	EntityType b on a.EntityId = b.EntityId
where		a.EntityName = 'Email'
and			b.EntityTypeName = 'Personal'



/* ***************** UPDATE **************** */

--A global update doesn't contain a where clause, which will cause the entire column to be updated

--Global update example - Update all values in the column CreateDate with current date and time
update	dbo.Person
set		CreateDate = getdate()


--Non-global update example
update	dbo.Person
set		CreateDate = '2/1/2014'
where	PersonId = 1

--Update one table based on values from another table
update		dbo.Employee
set			CreateDate = a.CreateDate
from		dbo.Person a
inner join	dbo.Employee b on a.PersonId = b.PersonId


/* ***************** DELETE **************** */


--HARD DELETE
--The where clause is optional, but it will delete all records from the table if not used with a where clause.

	delete
	from	TableName
	where	TableName.ColumnName = FilterValue

--SOFT DELETE
--Soft delete is used by creating a column named 'Status' or 'IsDelete" with the type as bit and updating the column values to 0.

--PROS
--If a user accidently deleted some records, it's still in the database and activating the records again just takes a simple update to the velue/column
--No issues with the FOREIGN KEY constraits.

--CONS
--The application utilizing the database has to have some knowledge of the status column.

	update	dbo.Person
	set		IsDeleted = 1
	where	PersonId in (10,11,12)


/* **************** SUBQUERY *************** */

--Must enclose subquery in parenthesis
--Subquery must include both SELCT and FROM clause
--Subquery can include WHERE or GROUP BY clauses
--Subquery can include ORDER BY clause only when a TOP clause is included

--When a subquery is used in the select statements, it can be used in the following ways:


	--In the SELECT clause to create a column expression. The subquery only returns a scalar (singular) value

		select	*,
				(	select	count(*)
					from	dbo.Employee) as TotalNumberOfEmployees
		from dbo.Person


	--Joined to the outer query by specifying a relationin the WHERE clause. 
	--Use sparingly, especially when using a type of JOIN would yield the same results

		select	a.*,
				(	select	HireDate
					from	dbo.Employee
					where	PersonId = a.PersonId) as EmployeeHireDate
		from	dbo.Person a


	--In the FROM clause (aka a derived table). This can return more than one record as it's treated like any other table
	--These are used when the subset of data could not be joined to the outer query. In the example below, we want to
	--retrieve the employee's name, along with their associated loyalty company.

		select		a.CompanyName,
					b.FirstName,
					b.LastName,
					b.DisplayFirstName
		from		(	select		bb.PersonId,
									dd.CompanyName
						from		dbo.Person aa
						inner join	dbo.Employee bb on aa.PersonId = bb.PersonId
						inner join	dbo.LoyaltyAccount cc on bb.EmployeeId = cc.EmployeeId
						inner join	dbo.LoyaltyCompany dd on cc.LoyaltyCompanyId = dd.LoyaltyCompanyId) as a
		inner join	dbo.Person b on a.PersonId = b.PersonId


	--In the WHERE clause
	--The example below returns multiple results and could be accomplished by just using a JOIN statement

		select	*
		from	dbo.Person a
		where	a.PersonId in	(	select	PersonId
									from	dbo.Employee)

		--This subquery example returns a single scalar value
		select	*
		from	dbo.Employee a
		where	a.personId = (	select	PersonId
								from	dbo.person
								where	LastName = 'Simmer')


/* ********************************************
*************** SQL PROGRAMMING ***************
******************************************** */





/* *************** VARIABLES *************** */

/* DECLARATIONS ********** */

--Declaring a variable.
--You must first decalre a variable and assign a data type

	declare	@FirstName	varchar(50),
			@LastName	varchar(50),
			@Title		varchar(50)


--Set value to variable
--Use the SET keyword when assigning local variables when you don't need a query to retrieve the data

	set	@FirstName = 'Daniel';
	set	@FirstName = 'Simmer';
	set @Title = 'Mr.';


--Use SELECT when using a query for assignment

	select	@FirstName = a.FirstName,
			@LastName = a.LastName,
			@Title = a.Title
	from	dbo.Person a
	where	a.PersonId = 1;

/* OUTPUT ********** */

--Select keyword
--Return it as if you're returning a record from a table

	select	@FirstName as FirstName,
			@LastName as LastName,
			@Title as Title;

--Print
--Outputs to messages tab

	print	@FirstName;
	print	@LastName;
	print	@Title;


/* ************* FLOW CONTROL ************** */
--Lets you control the execution of the flow within the script


/* If/Else ********** */
	declare	@QueryId	int = null;

	set	@QueryId = 1;

	if(@QueryId > 0)
		print 'Is greater than 0';
	else
		print 'Is zero or null';


/* Begin/End ********* */
--Allow you to group statements and allow you to execute multiple statements as a result of the flow control
--If statements don't use begin/end keyword since true/false conditons only process a single line of code.
--If there are multiple lines of code you have to use the begin/end keywords

	declare	@QueryId	int = null;

	set	@QueryId = 1;

	if(@QueryId > 0)
		begin
			print 'Is greater than 0';
			print 'Actual value = ' + cast(@QueryId as varchar(5));
		end
	else
		print 'Is zero or null';

/* Case statement ********* */
--Performs a check on the value


	declare @QueryId	int = null;

	set @QueryId = 1

	if(@QueryId > 0)
		begin
			select	a.PersonId,
					a.Title,
					a.FirstName,
					a.LastName,
					a.DisplayFirstName,
					case a.Gender
						when 'M' then 'Male'
						when 'F' then 'Female'
						else null
					end as Gender
			from	dbo.person a
		end
	else
		print 'Is zero or null';

/* Goto ********** */

--T-SQL reads top down in a procedureal manner. The GOTO keyword causes the execution of t-SQL to jump to the
--label specified in the goto statement.

	GOTO LABEL_NAME

		print 'This code is jumped over by the GOTO keyword'

	LABEL_NAME:

		print 'This code is executed'
		GOTO EXIT_SECTION

	EXIT_SECTION:

--Labels end in a colon. It's helpful to write them in all caps and use underscores (where needed) to help
--identify them

	THIS_IS_A_LABEL:



/* *********** STORED PROCEDURES *********** */
/*
It's a best practice to prefix your stored procedures with USP_ (user stored procedure). Don't use SP_ as a
prefix as it's used by sql server and it will need to run through it's own stored procedures before finding
your custom stored procedure.

A single stored procedure should only do a single specific function. For each entity there should be at least
4 stored procedures, one for each CRUD function. There may multiple stored procedures for the retrieve function:
retrieving a single item, a collection of items, filtering out columns, etc.
*/

--Create a procedure
--This can be done in SSMS by opening up the folder Programmability > Stored Procedures and by right clicking
--'New Stored Procedure'

	create procedure <schema>.<procedure_name>(
		@parameter01	int = null,
		@parameter02	varchar(50) = null
	)
	as
	begin
		set nocount on;

		--add code here

	end

--To alter a procedure, use the alter procedure statement (see below). The procedure name must match the name of
--the stored procedure. This can be done in SSMS by opening up the folder Programmability > Stored Procedures
--and by right clicking 'New Stored Procedure'

	alter procedure <schema>.<procedure_name>(
		@parameter01	int = null,
		@parameter02	varchar(50) = null
	)
	as
	begin
		set nocount on;

		--add code here

	end

--Execute a stored procedure
--Stored procedures are executed with the exec statement followed by the name of the stored procedure and required
--parameters. The stored procedure name can be dragged in from the opject explorer menu.

	exec [dbo].[usp_GetPerson] @QueryId=10, @PersonId=1;
	exec [dbo].[usp_ExecutePerson] @QueryId=20, @personId=1, @DisplayFirstName = 'Danny';



/* *************** FUNCTIONS *************** */
/*
Functions are used to modularize your code, improve maintainability and centralize some of your logic
There are two types of functions. Tables are created and modified just like stored procedures.

Scalar valued -	Returns only a single value and can be used in the select clause
Table valued -	Returns table values and can be used in the from clause. Even thought it's not a physical table
				It can be joined with other	tables in the same way.
*/


/* **************** INDEXES **************** */
/*
Clustered vs. Non-clustered indexes

A clustered index determines the order in which the rows of the table will be stored on disk – and it actually
stores row level data in the leaf nodes of the index itself. A non-clustered index has no effect on which the
order of the rows will be stored.

Using a clustered index is an advantage when groups of data that can be clustered are frequently accessed by some
queries. This speeds up retrieval because the data lives close to each other on disk. Also, if data is accessed in
the same order as the clustered index, the retrieval will be much faster because the physical data stored on disk
is sorted in the same order as the index.

A clustered index can be a disadvantage because any time a change is made to a value of an indexed column, the
subsequent possibility of re-sorting rows to maintain order is a definite performance hit.

A table can have multiple non-clustered indexes. But, a table can have only one clustered index.

Non clustered indexes store both a value and a pointer to the actual row that holds that value. Clustered indexes
don’t need to store a pointer to the actual row because of the fact that the rows in the table are stored on disk
in the same exact order as the clustered index – and the clustered index actually stores the row-level data in
it’s leaf nodes.
*/

--create a clustered index named IDX_Training on the column TrainingId
create clustered index IDX_Training on dbo.Training(TrainingId);

--create a non-clustered index named IDX_Training_EmployeeId on the columns TrainingId and EmployeeId
create nonclustered index IDX_Training_EmployeeId on dbo.Training(TrainingId, EmployeeId);