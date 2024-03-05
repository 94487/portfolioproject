select   *from portfolioproject.dbo.Sheet1$

-- let's see how many positive people die in ga--
select  count (distinct state)as ga, sum(positive)as positive,sum (death)as death from portfolioproject.dbo.Sheet1$
where state like 'ga'

-- let's see total death and negative in ga

select  sum(negative)as totalnegativeinGA, sum(death)as [total death] from portfolioproject.dbo.Sheet1$
where state like 'ga' and negative is null

-- let's see total death  in ga
select  date, state,death from portfolioproject.dbo.Sheet1$
where state like 'ga'
order by date asc

-- estract or data from the database----
select * from portfolioproject.dbo.sheet1$

-- trying to know how many datapoint we are working with --
select count   (state)  from portfolioproject.dbo.Sheet1$

-- let check the total of death by state of georgia--
select  sum (death) as numberofdeathinga   from portfolioproject.dbo.Sheet1$
where state like 'ga'

--let check what state are affected by covid in the united state--
select Distinct state from portfolioproject.dbo.Sheet1$

-- now let's compte a number of state affected by covid 
select count (Distinct state) from portfolioproject.dbo.Sheet1$

-- now let's see the average  positive people death in ga and percentage
select date, state ,death, positive, (positive/death)as averagepositivedeath, 
(death/positive)*100 as percentagedeath
from portfolioproject.dbo.Sheet1$
where state like 'ga' and (death is not null OR death=1) 
order by positive desc, death asc

--looking at total testResultIncrease by state VS how many tested positive and negative

select  date,  totaltestresultsincrease ,state,positive, negative 
from portfolioproject.dbo.Sheet1$

--now let me check sum of total testresultincrease in ga no duplicate state and 
-- total positive and negative in ga state no duplicate

select    sum( totalTestResultsIncrease)as totaltestresultincrese,sum(negative)as sumnegative, sum(positive)as sumpositive
from portfolioproject.dbo.Sheet1$
 where state like 'ga'
 
 -- let me look at state with highest test positive rate compared to deathconfirmed

 select  date,state,death,positive  from portfolioproject.dbo.Sheet1$
 order by positive desc

 -- let's extract all the negative and positive affected by all
 -- the state except GA and Ak and were not hospitalized or not  death

select date, state, negative, positive,death, hospitalized from portfolioproject.dbo.Sheet1$
where hospitalized is  null
and state  not in ('ga' ,'ak') or death is  null
order by hospitalized asc, death asc

-- let's insert some date into covidDeaths table
--insert into portfolioproject.dbo.covidDeaths$
--value('3-10-2021', 'GA', '10148','2323788','2367', '498819', '1931711','2687','409')

select positive, state, death, negative   from portfolioproject.dbo.Sheet1$
where state ='ga' 
and death is null
and negative is  null

-- let me extract all records from newreport table--

select *from portfolioproject.dbo.newreport$

-- delete from newreport table where state is AK --

delete from  portfolioproject.dbo.newreport$
where state ='ak'
-- insert value into newreport --

insert into portfolioproject.dbo.newreport$
values('AK','10148','25465', '5684', '48795', '125455'
, '2458', '508')

--let select the top 5 rows in the table and check the rate 
-- of death	VS compare to positive people affected 	order by death desc
select top 5 (death/positive)*100 as rateofpositivedeath, *from portfolioproject.dbo.newreport$
where state not in ('ga','ca')
order by death desc

--let select return 10 numbers of row using Select fetch first--
--this not going to work here because fetch first only work in orocle  database--
--select * from portfolioproject.dbo.newreport$
--where state not in ('ga','ca')
--order by death desc
--fecth first 15 rows only

--let select return 10 numbers of row using Select limit--
--this not going to work here because limit  only work in MYsql database--
--select * from portfolioproject.dbo.newreport$
--where state not in ('ga','ca')
--order by death desc
--limit 15 rows 

--let select return 10 numbers of row using Select rowNum--
--this not going to work here because limit  only work in oracle 12 database--
--select * from portfolioproject.dbo.newreport$
--where RowNum<= 10
--and state not in ('ga', ca')
--order by death desc

-- now let update table newreport by updating death where state is Ak 

update   portfolioproject.dbo.newreport$
set death=2000,positive=48000,negative=125500
where state='ak'

-- let's left join newreport to sheet1--
select portfolioproject.dbo.Sheet1$.date,portfolioproject.dbo.Sheet1$.positive, portfolioproject.dbo.newreport$.death,  portfolioproject.dbo.newreport$.negative
from  portfolioproject.dbo.Sheet1$
left join portfolioproject.dbo.newreport$ on portfolioproject.dbo.Sheet1$.state=portfolioproject.dbo.newreport$.state

-- select the avg 
--average function--

select avg(death) from portfolioproject.dbo.newreport$
where state like  'g%'

-- let's use the higher than average to return all death with a higher positive affected--
-- higer than average--

select * from portfolioproject.dbo.Sheet1$
where death> (select avg(death) from portfolioproject.dbo.Sheet1$)

-- let select from sheet1 table a state where death average is higher than average death in newreport table
-- and state start with[ g,n,f, t] or state start with[ n] and end with[y], or any state that start with any charactere and end with [y] 

-- wildcards--
select state, death  from portfolioproject.dbo.Sheet1$
where death >  (select avg(death)  from portfolioproject.dbo.newreport$)
and state like '[gnft]'
or state like 'n%' and state like '%y'
or state like '_y%'
order by death desc


select * from portfolioproject.dbo.customers$

-- transaction table--
 
 select *from portfolioproject..transactions$

 -- let' start with join table or full join 

select portfolioproject.dbo.customers$.firstName,portfolioproject.dbo.customers$.lastName,
portfolioproject.dbo.transactions$.amount,portfolioproject.dbo.transactions$.transactionID
from portfolioproject.dbo.transactions$
full join portfolioproject.dbo.customers$ on customers$.[customer ID ]=
transactions$.[customer id]

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

 -- let's self join table transactions --
 select *from portfolioproject.dbo.transactions$ as a
 inner join portfolioproject.dbo.transactions$ as b
on a.[customer id]=b.refferalID

 -- let's see how many death count by state --

 select count (death), state from portfolioproject.dbo.Sheet1$
 group by state
 order by count (death)

 -- 
