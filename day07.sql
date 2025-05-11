select * from employee_salary;
select first_name,
salary,
(select avg(salary) from employee_salary
) as avg_salary
from employee_salary
;
select max(max_age)
from (
select
gender,
min(age) as min_age,
max(age) as max_age,
avg(age) as avg_age,
count(age) as cnt_age
from employee_demographics
group by gender) agg_table 
;

##subquery Problems 
##1.Show first names of employees who earn more than the average salary.
select first_name,
salary
from employee_salary
where salary > (select avg(salary) from employee_salary)
;
/* to display the avg_salary */

select emp.first_name,
emp.salary,
temp_table.avg_salary from employee_salary emp
join
(select avg(salary) as avg_salary from employee_salary) as temp_table
on emp.salary > temp_table.avg_salary
;
/*Problem 2: Find Youngest Employee
Display all details of the employee who has the minimum age.

✨ Hint: Use a subquery with MIN(age).*/
select * from employee_demographics dem 
where age = (select min(age) from employee_demographics)
;

/*Problem 3: Employees in Same Dept as Leslie Knope
Get first names of all employees who work in the same department as Leslie Knope.

✨ Hint: First find Leslie’s dept_id in a subquery.*/

select first_name
from employee_salary 
where dept_id = (select
dept_id from employee_salary
where first_name = 'Leslie' and last_name = 'Knope'
)
;
/*Problem 4: Employees with Salary Higher Than Average Salary in Their Department
Find the first name and salary of employees whose salary is higher than the average 
salary in their respective departments.*/
select first_name,
salary
from employee_salary sal
where salary > (select avg(salary) from employee_salary
where dept_id = sal.dept_id)
;
SELECT first_name, salary
FROM employee_salary sal
WHERE salary > (
    SELECT AVG(salary)
    FROM employee_salary
    WHERE dept_id = sal.dept_id
    
);
/* window function*/
select * from employee_salary;
select * from employee_demographics;
select dem.gender,
avg(sal.salary)
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
group by gender
;

/* This can be done similarly by window function
A window function performs a calculation across a set of table rows that are somehow
 related to the current row. Unlike aggregate functions (like AVG, SUM, COUNT, etc.),
 window functions do not collapse rows — they retain each row and add an extra computed column.
 */
 select dem.first_name,
 dem.last_name,
 dem.gender,
avg(sal.salary) over(partition by dem.gender) avg_salary
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
;

/* Rolling down important function where you can add subsequent rows in partiton by.....*/
select dem.first_name,
 dem.last_name,
 sal.salary,
 dem.gender,
sum(sal.salary) over(partition by dem.gender order by dem.employee_id) rolling_total,
count(sal.salary) over(partition by dem.gender order by sal.salary desc) count_total
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
;

## row_number()
select dem.first_name,
 dem.last_name,
 dem.gender,
 sal.salary,
 row_number() over(partition by gender order by salary desc) row_no,
 rank() over(partition by gender order by salary desc) rank_no,
dense_rank() over(partition by gender order by salary desc) dense_rank_no
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
;
/* Problem 1: Show each employee’s salary and the average salary of their department*/
select first_name,
last_name,
salary,
dept_id,
avg(salary) over(partition by dept_id) avg_dept_salary
from employee_salary
;
/*🔸 Problem 2: Rank employees within each department based on salary
Goal: Show first_name, dept_id, salary, and their salary_rank in the department.*/
select first_name,
last_name,
salary,
dept_id,
rank() over(partition by dept_id order by salary desc) as rank_id
from employee_salary
;

/*🔸 Problem 3: Display running total of salary in each department
Goal: Show first_name, dept_id, salary, and a cumulative running_total.*/
select first_name,
last_name,
salary,
dept_id,
sum(salary) over(partition by dept_id order by salary desc) as running_total
from employee_salary
;


/*A CTE is a temporary result set that you can reference within a 
SELECT, INSERT, UPDATE, or DELETE statement. It improves code readability, reusability,
 and helps break complex queries into simpler parts.
 */
 with cte_temp as 
 (
select
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


