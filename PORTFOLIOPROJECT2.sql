use myproject1
drop table if exists employee
--ffffg
create table employee(
id int primary key  ,
firstName nvarchar(225) not null,
lastName nvarchar(225) not null,
adress varchar (555)   null)

insert into employee
values('1','sandra','lawson','georgia'),
		('2','noelli', 'appeti','florida'),
		('3','rogatte','moris','mariland')

		select* from myproject1.dbo.employee

		-- let create another table --
		drop table if exists transactionss

create table transactionss (
transacid int primary key,
amount float not null, 
id int  foreign key references employee(id),
referalid int not null)

-- let's add unique constraint to colunm amount--

alter table myproject1.dbo.transactionss
add constraint amount_un unique(amount)

-- let's remove or drop a unique constraint --
alter table myproject1.dbo.transactionss
drop constraint amount_un

-- now let's add multiple constraint at a time--
alter table myproject1.dbo.transactionss
add constraint amount_un unique (amount,referalid)

-- let's drop a foreign  key on transactionss table--
alter table myproject1.dbo.transactionss
drop constraint [FK__transactions__id__398D8EEE]

-- let add back the foreign key on transactionss--

alter table myproject1.dbo.transactionss
add constraint fk_id foreign key(id)references employee(id)

-- let's drop a primary key to transactionss table--

alter table  myproject1.dbo.transactionss
drop constraint [PK__transact__5F28D082C0CE7031]

-- let's add back again the primary key to transactionss--

alter table myproject1.dbo.transactionss
add constraint pk_transacid primary key(transacid)

-- let's insert some data --

insert into transactionss 
values('1000','500', '2','1'),
	  ('1022','505', '1','4'),
	  ('1055','600', '3','2'),
	  ('1055','600', '4','2'),
	  ('1056','700', '2','2')
	--lets select trandasctionss--

select *from myproject1.dbo.transactionss

-- now let's check amount in the transactions --

 alter table  myproject1.dbo.transactionss
 add constraint chk_amount_id
 check (amount <1000 and id<10)

 -- let drop the constraint check--

 alter table myproject1.dbo.transactionss
 drop constraint [chk_amount]

 --let's create default constraint--
 -- let's add one more column to transactions--


 alter table myproject1.dbo.transactionss
 add constraint df_productid default '2' for productid


 select *from myproject1.dbo.transactionss

 -- lets create index--
 use myproject1
 create index id_idx
 on myproject1.dbo.employee(firstName)

 -- let's drop index--

 drop index  [id_idx]  on myproject1.dbo.employee

 -- let's create multi column index--
 create index multi_index
 on myproject1.dbo.employee(firstName, lastName)
  
-- let's create a new table with date type--
drop table if exists  myproject1.dbo.report
use myproject1
create table myproject1.dbo.report(
mydate date,
mytime time,
mydatetime datetime)
-- LET'S INSERT RECORT 
/*USE MYPROJECT1
insert into myproject1.dbo.report
VALUES(CURRENT_DATE, CURRENT TIME, CURRENT DATETIME)*/

---- let's reurn a datetime, date ,

SELECT CONVERT (date, SYSDATETIME())  as [current date]
    ,CONVERT (smalldatetime, SYSDATETIMEOFFSET())  as [current date]	
    ,CONVERT (date, SYSUTCDATETIME())  as [current date]
    ,CONVERT (date, CURRENT_TIMESTAMP)  as [current date]
    ,CONVERT (date, GETDATE())  as [current date]
    ,CONVERT (date, GETUTCDATE()) as [current date]
  

-- LET'S USE CAST INSTEAD OF CONVERT

SELECT CAST ( SYSDATETIME() AS date )  as [current date]
-- date format --

SELECT SYSDATETIME();  
SELECT GETDATE() 
SELECT GETUTCDATE()     
SELECT CURRENT_TIMESTAMP 
SELECT SYSDATETIMEOFFSET()
-- let's select only a part of date --

select datepart(day,SYSDATETIME())
select datepart (year, CURRENT_TIMESTAMP) 
select datepart(millisecond, CURRENT_TIMESTAMP )
select datepart(microsecond,  SYSDATETIMEOFFSET())
select datepart(WEEKDAY, SYSDATETIME());


-- let's create create view --

go
CREATE VIEW [CHANGE OF AMOUNT] 
AS
select amount, id,referalid,
case
	when id=2 then amount+(AMOUNT *.20)
	when id=3 then amount +(AMOUNT *.15)
	when id=1 then amount+(AMOUNT*.6)
	else amount -(amount-amount)
	end as [increase amount]
from myproject1.dbo.transactionss
go

-- LET'S UPDATE THE VIEW ADDADING THE TRANSACTIONID TO THE STATEMENT --
use myproject1
go
create or alter view [CHANGE OF AMOUNT] 
as 
select amount, id,referalid , transacid,
case
	when id=2 then amount+(AMOUNT *.20)
	when id=3 then amount +(AMOUNT *.15)
	when id=1 then amount+(AMOUNT*.6)
	else amount -(amount-amount)
	end as [increase amount]
from myproject1.dbo.transactionss
go
-- let's create a view wher the mount is higher than the average mount --

create view [higher amount  than avg]as
select *from myproject1.dbo.transactionss
where amount >(select avg(amount)from myproject1.dbo.transactionss)