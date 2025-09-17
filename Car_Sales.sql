

use PortfolioProject

--- CREATE DIMENSION TABLES FROM DATASET

--- DATE dimension table
create table Dim_Date(
Sale_Date Date Primary Key,
[Day] varchar(10) not null,
[Month] varchar(10) not null,
[Quarter] varchar(2) check ([quarter] in ('Q1','Q2','Q3','Q4')) not null,
[Year] int not null)

insert into Dim_Date 
select distinct [Date], Datename(Day,[Date]), Datename(Month,[Date]), 
'Q'+cast(Datepart(Quarter,[Date]) as varchar(2)), Datepart(Year,[Date]) from CarSales

select * from Dim_Date order by Quarter desc


--- Customer dimension table

create table Dim_Customer(
Customer_Id int identity(1,1) primary key,
Customer_Name varchar(20) not null,
Gender varchar(10),
Annual_Income int,
Phone int not null)
insert into Dim_Customer(Customer_name, Gender, Annual_Income, Phone)
select distinct Customer_name, Gender, Annual_Income, Phone from CarSales

select top 10 * from Dim_Customer

---- Dealer dimension table

create table Dim_Car(
Car_Id varchar(30) primary key,
Company varchar(20),
Model varchar(20),
Price int,
Engine varchar(20),
Transmission varchar(20),
Color varchar(20),
Body_Style varchar(10))

Alter table Dim_Car alter column Engine varchar(50)

--- Car dimension table

insert into Dim_Car 
select Car_Id, Company, Model, Price, Engine, Transmission, Color, Body_Style
from CarSales

create table Dim_Dealer(
Dealer_Id int identity(1,1) primary key,
Dealer_No varchar(50),
Dealer_Name varchar(50),
Dealer_Region varchar(30))
insert into Dim_Dealer(Dealer_No,Dealer_Name, Dealer_Region)
select distinct Dealer_No, Dealer_Name, Dealer_Region from CarSales


--- CREATE A FACT TABLE

create table Fact_Sales(
Sale_ID int identity(1,1) primary key,
Car_ID varchar(30),
Customer_Id int,
Dealer_Id int,
Sale_Date date,
Price int,
foreign key (Car_ID) references Dim_Car(Car_Id),
foreign key (Customer_Id) references Dim_Customer(Customer_Id),
foreign key (Dealer_Id) references Dim_Dealer(Dealer_Id),
foreign key (Sale_Date) references Dim_Date(Sale_Date))

insert into Fact_Sales(Car_ID, Customer_Id, Dealer_Id, Sale_Date, Price) 
select c.Car_ID, cu.Customer_Id, d.Dealer_Id, dt.Sale_Date, cs.Price 
from CarSales cs 
JOIN Dim_Car C 
    ON C.car_id = cs.car_id 
JOIN Dim_Customer cu
    ON cu.Customer_Name = cs.Customer_Name AND cu.Gender = cs.Gender AND cu.Annual_Income = cs.Annual_Income and cu.phone = cs.phone
JOIN Dim_Dealer d
    ON d.Dealer_Name = cs.Dealer_Name AND d.Dealer_No = cs.Dealer_No AND d.Dealer_Region = cs.Dealer_Region
JOIN Dim_Date dt 
    ON dt.[Sale_Date] = cs.[Date];

select * from Fact_Sales
select * from Dim_Car
select * from Dim_Customer
select * from Dim_Date
select * from Dim_Dealer

--- HISTORICAL DATA ANALYSIS :

-- Check for null Fact records, data validation
select f.Sale_ID
from Fact_Sales f
left join Dim_Car c on f.Car_ID = c.Car_Id
left join Dim_Customer cu on f.Customer_Id = cu.Customer_Id
left join Dim_Dealer d on f.Dealer_Id = d.Dealer_Id
left join Dim_Date dt on f.Sale_Date = dt.Sale_Date
where c.Car_Id is null or cu.Customer_Id is null or d.Dealer_Id is null or dt.Sale_Date is null;

-- sales trend over time
select 
    dt.Year,
    dt.Month,
    sum(f.Price) as MonthlyRevenue
from Fact_Sales f
join Dim_Date dt on f.Sale_Date = dt.Sale_Date
group by dt.Year, dt.Month
order by dt.Year, dt.Month;

-- year over year growth
with YearlySales as 
(
 select dt.Year, sum(f.Price) as TotalRevenue
 from Fact_Sales f
 join Dim_Date dt on f.Sale_Date = dt.Sale_Date
 group by dt.Year
)
select Year,TotalRevenue,
    lag(TotalRevenue) over (order by Year) as PrevYearRevenue,
    round
    (
        (TotalRevenue - lag(TotalRevenue) over (order by Year)) * 100.0 
        / lag(TotalRevenue) over (order by Year), 2
    ) as YoY_Growth_Percent
from YearlySales;

-- Best selling cars
with CarRevenue as 
(
 select 
       c.Company,
       c.Model,
       sum(f.Price) as TotalRevenue,
       rank() over (partition by c.Company order by sum(f.Price) desc) as [Rank]
 from Fact_Sales f
 join Dim_Car c on f.Car_ID = c.Car_Id
 group by c.Company, c.Model
)
select * 
from CarRevenue
where [Rank] <= 3
order by Company, TotalRevenue desc;

-- top 5 dealers in each quarter
with DealerSales as 
(
 select 
       d.Dealer_Name,
       dt.Quarter,
       dt.Year,
       sum(f.Price) as TotalSales,
       rank() over (partition by dt.Year, dt.Quarter order by sum(f.Price) desc) as sales_rank
 from Fact_Sales f
 join Dim_Dealer d on f.Dealer_Id = d.Dealer_Id
 join Dim_Date dt on f.Sale_Date = dt.Sale_Date
 group by d.Dealer_Name, dt.Quarter, dt.Year
)
select * 
from DealerSales
where sales_rank <= 5
order by Year, Quarter, sales_rank;


-- Customer segment
select 
    cu.Customer_Name,
    cu.Annual_Income,
    sum(f.Price) as TotalSpend,
    case 
        when cu.Annual_Income < 500000 then 'Low Income'
        when cu.Annual_Income between 500000 and 1000000 then 'Mid Income'
        else 'High Income'
    end as IncomeSegment,
    ntile(4) over (order by sum(f.Price)) as SpendingQuartile
from Fact_Sales f
join Dim_Customer cu on f.Customer_Id = cu.Customer_Id
group by cu.Customer_Name, cu.Annual_Income;

-- Regional Insights
with ColorPopularity as 
(
 select 
       d.Dealer_Region,
       c.Color,
       count(*) as CarsSold,
       rank() over (partition by d.Dealer_Region order by count(*) desc) as [Rank]
 from Fact_Sales f
 join Dim_Car c on f.Car_ID = c.Car_Id
 join Dim_Dealer d on f.Dealer_Id = d.Dealer_Id
 group by d.Dealer_Region, c.Color
)
select * 
from ColorPopularity
where [Rank] = 1
order by Dealer_Region;












