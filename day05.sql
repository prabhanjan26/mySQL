##unions and union all statment 
select first_name 
from employee_demographics
union all 
select first_name 
from employee_salary;

select first_name, 
last_name,
'Old lady' as label
from employee_demographics
where age > 35 and gender = 'female'
union 
select first_name, 
last_name,
'Old Man' as label
from employee_demographics
where age > 35 and gender = 'male'
union 
select first_name, 
last_name,
'Highly Paid' as label
from employee_salary
where salary > 60000
order by first_name,last_name
;

##string 

select length('hello');

select first_name, length(first_name)  name_size
from employee_demographics
order by name_size
;

select upper('hello');
select lower('CATTY');


select trim('     mysql      '); ## ltrim   rtrim

select first_name,
right(first_name,3),
left(first_name,3),
substring(first_name,1,3),
birth_date,
substring(birth_date,6,2)


from employee_demographics
;


select first_name,
replace(first_name,'a','z'),
locate('a',first_name),
concat(first_name,' ',last_name)
 from employee_demographics;

select first_name
last_name,
age ,
CASE
	WHEN age<=30 then 'young'
    when age between 39 and 59 then 'too old'   
    when age>60 then 'old'
     
end as age_lable
from employee_demographics
;
##select * from ;

select first_name,
last_name,
salary,
case
	when salary <= 50000 then salary*1.05
    when salary > 50000 then salary*1.07
end as new_salary,
case 
	when dept_id = 06 then salary * 0.10
end as bonus
from employee_salary
;
##Write a query to display each employee's full name and a new column title
select first_name,
last_name,
gender,
case
	when gender = 'Male' then 'Mr'
    when gender = 'Female' then 'Ms'
    when gender = null then 'Others'
end as Title
from employee_demographics
;
##Write a query to display each employee's name and a column salary_bracket that shows:'Low' if salary < 40000;
##'Medium' if salary between 40000 and 70000;'High' if salary > 70000
select concat(first_name,' ' ,last_name) as Full_name,
salary,
case
	when salary<40000 then 'Low'
    when salary between 40000 and 700000 then 'Medium'
    when salary>70000 then 'High'
end as salary_bracket
from employee_salary
;










