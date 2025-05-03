select * from employee_demographics;
select * from parks_and_recreation.employee_demographics;
select first_name,
last_name,
age,
age+10 
from employee_demographics;
select distinct first_name,gender from employee_demographics; #distinct combo of name n age


select * from employee_salary;
select  first_name ,salary
from employee_salary
where salary >=50000 
;


select first_name,
birth_date,
gender
 
from employee_demographics
where birth_date > '1980-01-01'
and gender = 'male'
;
select * from employee_demographics
where (first_name = 'Leslie' and age = 44) or age > 50;


select * from parks_departments;
select first_name from employee_salary 
where dept_id is null;


select first_name from 
employee_salary 
where employee_id not in (select employee_id from employee_demographics 


);


