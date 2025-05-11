 with cte_temp(EMP_id,Gender,MIN_AGE,MAX_AGE,AVG_AGE,CNT_AGE) as 
 (
select
employee_id,
gender,
min(age) as min_age,
max(age) as max_age,
avg(age) as avg_age,
count(age) as cnt_age
from employee_demographics
group by gender
)
select * from cte_temp
;

with example as
(
select
employee_id,
gender,
age
from employee_demographics
where birth_date >'1975-01-01'


),
example2 as 
(
select employee_id,
salary
from employee_salary
where salary > 50000
)
select * from example
join 
example2 
	on example.employee_id = example2.employee_id
    ;
