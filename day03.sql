select * from employee_demographics;
select count(*) from employee_demographics;
select gender,
avg(age) as avg,
min(age) as min_age,
max(age) as max_age,
count(age) as count_age
from employee_demographics
group by gender;


select * from employee_salary;
select occupation,
avg(salary) from employee_salary
group by occupation;

select * from employee_demographics
order by gender,age; ## use the correct order in order by statement...
## you can also use col_number like 5,4 for gender amd age respectively..


## differnece bw GROPUP BY AND HAVING clause
select gender, 
avg(age)
from employee_demographics
group by gender 
having avg(age)>40;  ## cant use where clause here coz its not created

## where-- row level ; having--aggregate function level

select occupation, 
avg(salary)					##example
from employee_salary 
where occupation like '%manager%'
group by occupation
having avg(salary) > 60000
;


## limit n
##limit pos,number of rows want to disp
select first_name,age
from employee_demographics
order by age desc
limit 2,3;


## alising 
select first_name,
avg(salary) as avg_salary ## change the name of a column by "AS" key word...
from employee_salary
group by first_name 
order by avg_salary asc 
;

##Practice 
##1.Show occupations where the average salary is more than ₹60,000. 
select occupation,
avg(salary) as avg_salary 
from employee_salary
group by occupation 
having avg_salary > 60000
;
##2.Display the first name, occupation, and salary of the top 3 highest paid employees.
select first_name,
occupation,
salary
from employee_salary 
order by salary desc
limit 3
;
##3.Show each dept_id with the number of employees, but only show departments with at least 2 employees.
select dept_id,
count(dept_id) as no_employee 
from employee_salary
group by dept_id 
having no_employee >= 2
;

##4.Show all employees whose salary is below the average salary. 
select first_name,
salary
from employee_salary
where salary < (select avg(salary) from employee_salary)
;

##5.Show all unique occupations sorted in ascending order.
select distinct occupation 
from employee_salary  
order by occupation asc
;

##Join statment 
## inner join 
select dem.employee_id,
dem.first_name,
occupation
from employee_demographics as dem 
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
    ;



