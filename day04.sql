select * from employee_demographics;
select * from employee_salary;

select * from parks_departments;

## self join 
select emp1.employee_id as santa_id,
emp1.first_name as santa_name,
emp2.employee_id as id,
emp2.first_name as name_emp

from employee_salary emp1 ## if the id id missing then it will skip tha row 
join employee_salary emp2
	on emp1.employee_id + 1 = emp2.employee_id
;


## multiple joins ie.. joining multiple tables 
select * 
from employee_demographics dem
join employee_salary sal 
	on dem.employee_id = sal.employee_id
	join parks_departments pd 
    on sal.dept_id = pd.department_id
;
## exercise 
##1.Show the first_name, last_name, and salary of only those employees who have salary records.
select dem.first_name,
dem.last_name,
sal.salary
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
;
##2. List all employee names and their salary if available; if not, show NULL

select dem.first_name,
dem.last_name,
sal.salary
from employee_demographics dem
left join employee_salary sal
	on dem.employee_id = sal.employee_id
;


##3.For each department, show the department_name and average salary of employees working in it.
select pd.department_name,
avg(sal.salary) as avg_salary
from employee_salary sal
join parks_departments pd
	on sal.dept_id = pd.department_id
    group by department_name
;
##4.For each department, find the first_name, salary, and department_name of the highest paid employee.
select sal.first_name,
max(sal.salary) max_salary,
pd.department_name 
from employee_salary sal
join parks_departments pd 
	on sal.dept_id = pd.department_id
    group by pd.department_name
;








