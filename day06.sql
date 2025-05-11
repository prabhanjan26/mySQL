##subqueryemployee_demographics
select first_name,
last_name
from employee_demographics
where employee_id in (
select employee_id from employee_salary
where dept_id = 01
)
;
select first_name,
occupation,
salary,
avg(salary) as avg_salary
from employee_salary
group by occupation
;
select occupation,
avg(salary)
from employee_salary
group by occupation;

select first_name,
salary,
(select avg(salary) from employee_salary)
from employee_salary;
