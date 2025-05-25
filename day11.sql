##event 
delimiter $$ 
create event delete_retirees
on schedule every 30 second 
do 
Begin 
	delete from employee_demographics
    where age >= 60;
end $$
select * from employee_demographics;
actor_infoselect * from sakila;