-- Creating a Database

create database Nehru_College;
--drop database Nehru_College;   --This command should be used carefully as it deletes all the content

use Nehru_College;

--Create a new table in a database
create table stu_data (Adm_no int unique, Stu_name varchar(50), Age int default 20, 
doa date not null, marks float, city varchar(20));

-- Dropping the existing table
drop table stu_data;

--Alter table
alter table stu_data add gender varchar(10);  --adding a new column to an existing table 
alter table stu_data drop column gender;  --Drop a column in existing table
alter table stu_data alter column city varchar(50) not null;  --altering existing column in a table

--Inserting data into table
insert into stu_data (Stu_name, Age, marks, doa, Adm_no, city) 
values ('Ravi', 21, 78.91, '12-03-2021', 1011, 'Delhi');

select * from stu_data;

insert into stu_data values (1012, 'Suman', default, '11-29-2021', 96.56, 'Mumbai'),
(1013, 'Seema',22,'12-01-2021', 85.12, 'Gurugram'),
(1014, 'Kajal',21,'12-04-2021', 69.88,'Delhi'),
(1015,'Priya',23,'12-02-2021',98.20,'Noida'),
(1016,'Kiran',21,'11-30-2021',78,'Pune');

insert into stu_data (Stu_name, Age, marks, doa, Adm_no, city) 
values ('Radhika', 21, 90.91, '11-30-2021', 1018, 'Lucknow');

insert into stu_data (Stu_name, Age, marks, doa, Adm_no, city) 
values ('Rosy', null, 78.91, '11-30-2021', 1019, 'Kanpur');

--Select Statement
select doa, Adm_no, Stu_name from stu_data;
select * from stu_data;

-- Where Clause
select * from stu_data where city = 'delhi';
select doa, adm_no, stu_name, marks from stu_data where marks>75;
select * from stu_data where marks>75 and city = 'pune';
select * from stu_data where marks>90 or city='delhi';
select * from stu_data where age is null;

--Update data in table
update stu_data set marks = 82 where adm_no = 1019;
update stu_data set city='lckn' where city='lucknow';

--Aliasing (Aliases)
select adm_no as Admission_no, doa as Date_of_Joining, stu_name as Student_name
from stu_data where marks>80;

select * from stu_data;

--Difference between truncate, delete and drop
truncate table stu_data;
delete from stu_data where age is null;


--Min Max Count Avg Sum   #Aggregation
select min(marks) from stu_data;
select max(marks) from stu_data;
select count(city) from stu_data;
select avg(marks) from stu_data;
select sum(marks) from stu_data;

--Subquaries
select * from stu_data where marks=(select min(marks) from stu_data);
select * from stu_data where marks<(select avg(marks) from stu_data);

--Like Clause
select * from stu_data where stu_name like 'k%';
select * from stu_data where stu_name like '_a%';
select * from stu_data where stu_name like '%a';
select * from stu_data where stu_name like '%k_';
select * from stu_data where stu_name like '%i%';

--Top Clause
select top(4) * from stu_data;
select top 25 percent * from stu_data;

-- select-->from-->where-->group by-->having-->order by


--order by
select * from stu_data order by marks;
select * from stu_data order by marks desc;
select * from stu_data where age=21 order by marks;
select * from stu_data order by city desc;
select * from stu_data order by city desc, marks;

--group by clause
select city from stu_data group by city;
select city,age from stu_data group by city,age;
select age,city from stu_data group by age,city order by age desc;
select age,city from stu_data where age<22 group by age,city order by age desc;
select age,city from stu_data where age<22 group by age,city having city != 'delhi' order by age desc;

--Distinct Clause
select distinct age,city from stu_data;

--Copy of a table 
select * into stu_data_c from stu_data;

--View 
create view above_avg as select * from stu_data where marks>(select avg(marks) from stu_data);
select * from above_avg;

alter view above_avg as select * from stu_data where marks>(select avg(marks) from stu_data) or city = 'delhi';

drop view above_avg;

--Union and Union All
create table stu_data_new (Adm_no int unique, Stu_name varchar(50), Age int default 20, 
doa date not null, marks float, city varchar(20));

insert into stu_data_new values (2012, 'Shital', default, '3-29-2022', 92.56, 'Mumbai'),
(2013, 'Poko',22,'4-01-2021', 88.12, 'Delhi'),
(2014, 'Pritam',21,'4-6-2021', 94.88,'Delhi'),
(2015,'Kirti',23,'4-2-2021',98.20,'Noida'),
(2016,'Kiran',21,'4-2-2021',78,'Pune');

select * from stu_data_new;

select * from stu_data union select * from stu_data_new;

insert into stu_data_new (Stu_name, Age, marks, doa, Adm_no, city) 
values ('Radhika', 21, 90.91, '11-30-2021', 1018, 'Lucknow');
insert into stu_data_new (Stu_name, Age, marks, doa, Adm_no, city) 
values ('Rosy', null, 78.91, '11-30-2021', 1019, 'Kanpur');

select * from stu_data union all select * from stu_data_new;

select * from stu_data where stu_name like '%a%' union
select * from stu_data_new where stu_name like '%r%';


--Joins
create table stu_hostel (Adm_no int unique, block_ varchar(10),
room_no int, room_type varchar(10), mess varchar(10));

select * from stu_data;

insert into stu_hostel values (1012,'B',301,'A/C','Yes'),
(1014,'A',507,'Non A/C','No'),
(1015,'A',202,'A/C','No'),
(1016,'B',306,'AC','Yes'),
(1020,'B',309,'AC','No'),
(1022,'A',901,'AC','Yes');

select * from stu_hostel;

-- Inner Join
select stu_data.adm_no, stu_data.stu_name, stu_data.doa, stu_hostel.block_, stu_hostel.room_no 
from stu_data inner join stu_hostel 
on stu_data.adm_no = stu_hostel.adm_no;

-- Left outer join
select stu_data.adm_no, stu_data.stu_name, stu_data.doa, stu_hostel.block_, stu_hostel.room_no 
from stu_data left join stu_hostel 
on stu_data.adm_no = stu_hostel.adm_no;

-- Right outer join
select stu_hostel.adm_no, stu_data.stu_name, stu_data.doa, stu_hostel.block_, stu_hostel.room_no 
from stu_data right join stu_hostel 
on stu_data.adm_no = stu_hostel.adm_no;

-- Full Join
select  stu_data.adm_no, stu_data.stu_name, stu_data.doa, stu_hostel.block_, stu_hostel.room_no 
from stu_data full join stu_hostel 
on stu_data.adm_no = stu_hostel.adm_no;

--Cross Join (one to many)
select stu_data.adm_no, stu_hostel.adm_no 
from stu_data cross join stu_hostel;


-- CASE Statement
select *,
(case 
when marks>=85 then 'A'
when marks>=75 and marks<85 then 'B'
else 'C'
end) as Grade from stu_data;


-- Stored Procedure
select * from stu_data;

create procedure i_in_name 
as 
select adm_no, stu_name, age from stu_data where stu_name like '%i%';
go

exec i_in_name;

create procedure marks_stu @score int 
as
select * from stu_data where marks>= @score;
go

execute marks_stu 90;

create procedure state_stu @state varchar(20) 
as
select * from stu_data where city like @state;
go

execute state_stu 'delhi';

drop procedure marks_student;

--Transactions
select * from stu_data;

begin transaction update_stu_data;
set transaction isolation level read committed;
update stu_data set city='NCR' where city like 'delhi';
save transaction changed_delhi;
update stu_data set marks=80 where stu_name ='kiran' and adm_no=1016;
save transaction kiran_marks;
delete from stu_data where age>22;
rollback transaction kiran_marks;
insert into stu_data values (1017,'poko',22,'03-29-2021',89,'pune');
save transaction new_student;
rollback transaction new_student;
commit;

begin transaction update_stu_data1;
set transaction isolation level read committed;
save transaction begun;
update stu_data set city ='Delhi' where city like 'NCR';
commit;






















