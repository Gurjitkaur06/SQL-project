create database project_sql;

use project_sql;

select * from retail_data;

alter table retail_data add churn varchar(10); 
update retail_data set churn = 'Churn' where (select * from retail_data where InvoiceDate between '2011-09-01' and '2011-12-01');
