/*Create a database named PROJECT, then import data_science_team.csv 
proj_table.csv and emp_record_table.csv into the PROJECT database from the given resources*/

create database project;

use project;

create table emp_table(
EMP_ID varchar(50),
F_NAME varchar(50),
L_NAME varchar(50),
GENDER varchar(50),
ROLE varchar(50),
DEPT varchar(50),
EXP int,
COUNTRY varchar(50),
CONTINENT varchar(50),
SALARY float,
EMP_RATING float,
MANAGER_ID varchar(50),
PROJ_ID varchar(50));

create table Project(
PROJ_ID varchar(50),PROJ_NAME varchar(50),DOMAIN varchar(50),START_DATE varchar(50),
CLOSURE_DATE varchar(50),DEV_QTR varchar(50),STATUS varchar(50));

create table D_science(
EMP_ID varchar(50),
F_NAME varchar(50),
L_NAME varchar(50),
GENDER varchar(50),
ROLE varchar(50),
DEPT varchar(50),
EXP int,
COUNTRY varchar(50),
CONTINENT varchar(50));

/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
less than two
greater than four 
between two and four*/

select EMP_ID,F_NAME,L_NAME,GENDER,dept,emp_rating from emp_table
where emp_rating<2;

select EMP_ID,F_NAME,L_NAME,GENDER,dept,emp_rating from emp_table
where emp_rating>4;

select EMP_ID,F_NAME,L_NAME,GENDER,dept,emp_rating from emp_table
where emp_rating>=2 and emp_rating<=4;

/*Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the 
Finance department from the employee table and then give the resultant column alias as NAME*/

select f_name,l_name,concat(f_name,' ',l_name) as NAME from emp_table
where dept = 'finance';

/*Write a query to list only those employees who have someone reporting to them.
 Also, show the number of reporters (including the President)*/

select e1.f_name,e1.l_name,count(1) as no_of_reportees from emp_table as e1
join emp_table as e2
on e1.emp_id = e2.manager_id
group by e1.f_name;

/*Write a query to list down all the employees from the healthcare and finance 
departments using union*/

SELECT * FROM emp_table
where dept = 'healthcare'
union
SELECT * FROM emp_table
where dept = 'finance';

/*Write a query to list down employee details such as EMP_ID, FIRST_NAME, 
LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. 
Also include the respective employee rating along with the max emp rating for the department*/

SELECT EMP_ID,F_NAME,L_NAME,role,dept,emp_rating,
dense_rank() over(partition by dept order by emp_rating desc) 
 FROM emp_table;
 
 /*Write a query to calculate the minimum and the maximum salary of the 
 employees in each role*/
 
 SELECT role,max(salary) as max_salary,min(salary) as min_salary FROM emp_table
 group by role;
 
 /*Write a query to assign ranks to each employee based on their experience*/
 
 SELECT EMP_ID,F_NAME,L_NAME,exp,
dense_rank() over(order by EXP desc) 
 FROM emp_table;
 
 /*Write a query to create a view that displays employees in various 
 countries whose salary is more than six thousand.*/
 
create view sal_6000 as 
select * from emp_table
where SALARY>6000;

/*Write a nested query to find employees with experience of more than ten years*/

select * from(
select * from emp_table
where exp>10) as nest_query;

/*Write a query to create a stored procedure to retrieve the details of the 
employees whose experience is more than three years*/

create procedure 3_years() 
select * from emp_table
where exp>3;
call 3_years();

/*Write a query using stored functions in the project table to check whether the job profile assigned 
to each employee in the data science team matches the organization’s set standard*/

SELECT *,case
when EXP<=2 then 'JUNIOR DATA SCIENTIST'
when (EXP>2 AND EXP<=5) then 'ASSOCIATE DATA SCIENTIST'
when (EXP>5 AND EXP<=10) then 'SENIOR DATA SCIENTIST'
when (EXP>10 and EXP<=12) then 'LEAD DATA SCIENTIST'
when (EXP>12 and EXP<=16) then 'MANAGER'
ELSE 'PRESIDENT'
end AS NEW_ROLE
FROM EMP_TABLE;

/*Create an index to improve the cost and performance of the query to find the 
employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan*/

CREATE INDEX index_f_name
on emp_table(f_name);
desc emp_table;
select * from emp_table
where f_name like 'ERIC';

/*Write a query to calculate the bonus for all the employees,
 based on their ratings and salaries (Use the formula: 5% of salary * employee rating)*/

SELECT EMP_ID,F_NAME,L_NAME,SALARY,EMP_RATING,(0.05*SALARY*EMP_RATING) AS BONUS
FROM emp_table;

/*Write a query to calculate the average salary distribution based on the continent and country.
 Take data from the employee record table*/

SELECT COUNTRY,CONTINENT, AVG(SALARY) AS  AVG_SALARY FROM emp_table
GROUP BY COUNTRY,CONTINENT
ORDER BY COUNTRY;



