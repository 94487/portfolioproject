select * from portfolioproject.dbo.customers$

-- transaction table--
 
 select *from portfolioproject..transactions$

 -- let' start with join table or full join 

select portfolioproject.dbo.customers$.firstName,portfolioproject.dbo.customers$.lastName,
portfolioproject.dbo.transactions$.amount,portfolioproject.dbo.transactions$.transactionID
from portfolioproject.dbo.transactions$
full join portfolioproject.dbo.customers$ on portfolioproject.dbo.customers$.[customer ID ]=
portfolioproject.dbo.transactions$.[customer id]

--left joint transaction table--

select* 
from portfolioproject.dbo.transactions$
left join portfolioproject.dbo.customers$ on portfolioproject.dbo.customers$.[customer ID ]=
portfolioproject.dbo.transactions$.[customer id]

 --let' right join customer table

select * 
from portfolioproject.dbo.transactions$
right join portfolioproject.dbo.customers$ on customers$.[customer ID ]=
transactions$.[customer id]

--let modified transactions table--
 alter table portfolioproject.dbo.transactions$
 add refferalID int

 -- let's filled out the referralid with numeric values--

 update portfolioproject.dbo.transactions$
 set refferalID= 2
 where [customer id]=3

 update portfolioproject.dbo.transactions$
 set refferalID= 2
 where [customer id]=2
 
 update portfolioproject.dbo.transactions$
 set refferalID= 3
 where [customer id]=3

 update portfolioproject.dbo.transactions$
 set refferalID= 1
 where [customer id]=1

 -- let's self join table transactionid --
 select *from portfolioproject.dbo.transactions$ as a
 inner join portfolioproject.dbo.transactions$ as b
on a.[customer id]=b.refferalID


 -- let's see how many death count by state --

 select count (death), state from portfolioproject.dbo.Sheet1$
 group by state
 order by count (death)

 -- let's use union joint tranascations table and customers--

 select [customer ID ] from portfolioproject.dbo.customers$
 union 
 select [customer id] from portfolioproject.dbo.transactions$

  -- let's use union joint tranascations table and customers  by allowing
  -- duplicate values--

 select [customer ID ] from portfolioproject.dbo.customers$
 union all
 select [customer id]  from portfolioproject.dbo.transactions$


 --  let test if there is any existence record in a subquery --

 select firstName from portfolioproject.dbo.customers$
 where exists(select [customer id] from portfolioproject.dbo.transactions$
 where customers$.[customer ID ]=transactions$.[customer id] and [customer id] between 1 and  2) or [customer ID ]=3
 

 select * from portfolioproject.dbo.customers$

-- transaction table--
 
 select *from portfolioproject..transactions$

 -- let's count  a numer of death in each state where death is greater than 60--

 select count( death)as [count death],state  from portfolioproject.dbo.Sheet1$
 where state like '[a-z]%'
 group by state 
 having count(death)>60
 order by count(death) desc

 -- select into --
 select [customer ID ], firstName
 into portfolioproject.dbo.customers$2
 from portfolioproject.dbo.customers$
 where [customer ID ]=2

  -- select into --
 select [customer ID ], firstName
 into customers$1
 from portfolioproject.dbo.customers$

 --let me drop this table customers$2 --
 drop table  portfolioproject.dbo.customers$2

 -- let's see if in the customer table there is any ID that is equale 
 -- to any ID in the transactions table--

 select [firstName] , lastName, [customer ID ]
 from portfolioproject.dbo.customers$
 where [customer ID ]=any
 (select [customer id] from portfolioproject.dbo.transactions$
 where portfolioproject.dbo.customers$.[customer ID ]=
 portfolioproject.dbo.transactions$.[customer id])

 select * from portfolioproject.dbo.customers$

-- transaction table--
 
 select *from portfolioproject..transactions$

 -- let's use case --

select [customer ID ], firstName,  lastName,
CASE 
    WHEN [customer ID ]=1 then'perfect'
	when [customer ID ] =3 then 'perfect'
	else 'not perfect'
	end as [perfect in]
from portfolioproject.dbo.customers$


-- let's join customer and tranasaction and apply a discount to each customer based on their ID --

select customers$.[customer ID ],customers$.firstName,customers$.lastName,
transactions$.amount,

CASE
	when  customers$.[customer ID ]=1 then amount -(amount *.10)
	when customers$.[customer ID ]=2 then amount -(amount *.20)
	when customers$.[customer ID ]=3 then amount-(amount*.5)
	else amount-(amount*.0)
	end as [changed amount]
from portfolioproject.dbo.customers$
join portfolioproject.dbo.transactions$ 
on customers$.[customer ID ]=transactions$.[customer id]

-- let's extract death and state from sheet table and order it by death if death or state
-- but if death isnull order by state

select death,state 
 from portfolioproject.dbo.Sheet1$
 where state like 'ga'
 order by
 case 
		when death is null  then state
		else death
		end


-- let's me join customer and trasaction by creasting store procedure--

create procedure reductions1
as
select customers$.[customer ID ], customers$.firstName,customers$.lastName, transactions$.amount,
case
	when customers$.[customer ID ]=1 then amount-(amount*ISNULL(.10,0))
	when customers$.[customer ID ]=2 then amount-(amount*ISNULL(.20,0))
	when customers$.[customer ID ]=3 then amount-(amount*ISNULL(.17,0))
	when customers$.[customer ID ]=4 then amount-(amount*ISNULL(.17,0))
else amount-(amount*ISNULL(.0,0))


	end as [discount promotion]
from portfolioproject.dbo.customers$
left join portfolioproject.dbo.transactions$
on customers$.[customer ID ]=transactions$.[customer id]

-- let's execute reductions--

exec reductions1

-- now let's pass parameters and called only 
alter procedure reductions1
@firstName nvarchar(255)
as
select customers$.[customer ID ], customers$.firstName,customers$.lastName, transactions$.amount,
case
	when customers$.[customer ID ]=1 then amount-(amount*ISNULL(.10,0))
	when customers$.[customer ID ]=2 then amount-(amount*ISNULL(.20,0))
	when customers$.[customer ID ]=3 then amount-(amount*ISNULL(.17,0))
	when customers$.[customer ID ]=4 then amount-(amount*ISNULL(.17,0))
else amount-(amount*ISNULL(.0,0))


	end as [discount promotion]
from portfolioproject.dbo.customers$
left join portfolioproject.dbo.transactions$
on customers$.[customer ID ]=transactions$.[customer id]
where firstName=@firstName

--let's execute the parameter--

exec reductions1 'larry'

create table employee(
id int primary key  ,
firstName nvarchar(225) not null,
lastName nvarchar(225) not null,
adress varchar (555)   null)

insert into employee
values('1','sandra','lawson','georgia'),
		('2','noelli', 'appeti','florida'),
		('3','rogatte','moris','mariland')

		 drop table employee
