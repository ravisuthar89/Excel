
-- 1. Display all information in the tables EMP and DEPT.
select * from employees
join departments using (department_id);

-- 2. Display only the hire date and employee name for each employee.   
select hire_date, concat(first_name,' ',last_name) as emp_name from employees group by employee_id;

-- 3. Display the ename concatenated with the job ID, separated by a comma and space, and name the column Employee and Title   
select concat(first_name,' ',last_name,', ',job_id) as 'Employee and Title' from employees;

-- 4. Display the hire date, name and department number for all clerks.   
select hire_date, concat(first_name,' ',last_name) as emp_name, department_id from employees;

-- 5. Create a query to display all the data from the EMP table. Separate each column by a comma. Name the column THE OUTPUT  
select concat(employee_id,', ',first_name,', ',last_name,', ',email,', ',phone_number,', ',hire_date,', ',job_id,', ',salary,', ',commission_pct,', ',manager_id,', ',department_id)
as THE_OUTPUT from employees;

-- 6. Display the names and salaries of all employees with a salary greater than 2000.   
select concat(first_name,' ',last_name) as emp_name, salary from employees
where salary > 2000;

-- 7. Display the names and dates of employees with the column headers "Name" and "Start Date"   
select concat(first_name,' ',last_name) as Name, hire_date as 'start date'  from employees;

-- 8. Display the names and hire dates of all employees in the order they were hired.   
select  concat(first_name,' ',last_name) as Name, hire_date from employees order by hire_date;

-- 9. Display the names and salaries of all employees in reverse salary order.   
select concat(first_name,' ',last_name) as emp_name, salary from employees order by salary desc;

-- 10. Display 'ename" and "deptno" who are all earned commission and display salary in reverse order. 
select concat(first_name,' ',last_name) as ename, department_id, salary from employees 
where commission_pct is not null order by salary desc;
 
-- 11. Display the last name and job title of all employees who do not have a manager   
select e.last_name, j.job_title 
from employees e
join jobs j
on e.job_id= j.job_id
where e.manager_id is null;

-- 12. Display the last name, job, and salary for all employees whose job is sales representative or stock clerk and whose salary is not equal to $2,500, $3,500, or $5,000
select last_name, job_id, salary from employees 
where job_id in ('SA_REP','SH_CLERK') and salary not in (2500,3500,5000);


-- 1) Display the maximum, minimum and average salary and commission earned.  
select max(salary), min(salary), avg(salary), commission_pct from employees group by commission_pct;

-- 2) Display the department number, total salary payout and total commission payout for each department.
select department_id, sum(salary), sum(commission_pct) from employees group by department_id; 
    
-- 3) Display the department number and number of employees in each department.   
select department_id, employee_id from employees 
where department_id is not null;

-- 4) Display the department number and total salary of employees in each department.   
select department_id, sum(salary) from employees group by department_id; 

-- 5) Display the employee's name who doesn't earn a commission. Order the result set without using the column name   
select concat(first_name,' ',last_name) as name from employees 
where commission_pct is null order by 1;

-- 6) Display the employees name, department id and commission. If an Employee doesn't earn the commission, then display as 'No commission'. Name the columns appropriately 
select  concat(first_name,' ',last_name) as 'employees name', department_id as 'department id' , coalesce(commission_pct,"no commission") as "commission" from employees; 

-- 7) Display the employee's name, salary and commission multiplied by 2. If an Employee doesn't earn the commission, then display as 'No commission. Name the columns appropriately  
select concat(first_name,' ',last_name) as 'employees name', salary, coalesce(commission_pct /2,"no commission") as "commission" from employees;

-- 8) Display the employee's name, department id who have the first name same as another employee in the same department 
select concat(e1.first_name,' ',e1.last_name) as 'employees name', e1.department_id 
from employees e1
join employees e2
on e1.first_name = e2.first_name
and e1.department_id = e2.department_id
and e1.employee_id <> e2.employee_id;

-- 9) Display the sum of salaries of the employees working under each Manager.   
select sum(salary) as salary from employees group by manager_id;

-- 10) Select the Managers name, the count of employees working under and the department ID of the manager.   
select concat(m.first_name,' ',m.last_name) as 'manager name', count(e.employee_id) as 'no of emp', m.department_id 
from employees e
join employees m
on e.manager_id = m.employee_id
group by e.manager_id;

-- 11) Select the employee name, department id, and the salary. Group the result with the manager name and the employee last name should have second letter 'a!   
select concat(m.first_name,' ',m.last_name) as 'manager name', concat(e.first_name,' ',e.last_name) as 'employee name', e.department_id, e.salary 
from employees e
join employees m
on e.manager_id = m.employee_id
where m.last_name like '_a%'
and e.last_name like '_a%';                -- 


-- 12) Display the average of sum of the salaries and group the result with the department id. Order the result with the department id.  
select department_id, avg(sum_of_salary) as salary
from 
( select department_id, sum(salary) as sum_of_salary
from employees
group by department_id) as salary_sum
group by department_id
order by department_id;
 
-- 13) Select the maximum salary of each department along with the department id   
select department_id, max(salary) as salary
from employees
group by department_id;

-- 14) Display the commission, if not null display 10% of salary, if null display a default value 1
select commission_pct, 
case 
when commission_pct is not null then salary * 0.10 
else 1
end as commission
from employees;

-- 1. Write a query that displays the employee's last names only from the string's 2-5th position with the first letter capitalized and all other letters lowercase, Give each column an appropriate label. 

-- 2. Write a query that displays the employee's first name and last name along with a " in between for e.g.: first name : Ram; last name : Kumar then Ram-Kumar. Also displays the month on which the employee has joined.
select concat(first_name,'-',last_name) as EMP_Name, month(hire_date) as join_month from employees;

-- 3. Write a query to display the employee's last name and if half of the salary is greater than 
-- ten thousand then increase the salary by 10% else by 11.5% along with the bonus amount of 
-- 1500 each. Provide each column an appropriate label.   
select last_name as employee_last_name, 
case
when salary / 2 > 10000 then salary + salary * 0.10 
else salary + salary * 0.115 
end as emp_salary,
1500 as bonus_amount
from employees;

-- 4. Display the employee ID by Appending two zeros after 2nd digit and 'E' in the end, 
-- department id, salary and the manager name all in Upper case, if the Manager name 
-- consists of 'z' replace it with '$! 
-- 5. Write a query that displays the employee's last names with the first letter capitalized and 
-- all other letters lowercase, and the length of the names, for all employees whose name 
-- starts with J, A, or M. Give each column an appropriate label. Sort the results by the 
-- employees' last names  
 
-- 6. Create a query to display the last name and salary for all employees. Format the salary to 
-- be 15 characters long, left-padded with $. Label the column SALARY   
-- 7. Display the employee's name if it is a palindrome  
-- 8. Display First names of all employees with initcaps. 
-- 9. From LOCATIONS table, extract the word between first and second space from the 
-- STREET ADDRESS column.   
-- 10. Extract first letter from First Name column and append it with the Last Name. Also add 
-- "@systechusa.com" at the end. Name the column as e-mail address. All characters should 
-- be in lower case. Display this along with their First Name.   

-- 11. Display the names and job titles of all employees with the same job as Trenna.
select concat(first_name,' ',last_name) as employee_name, job_title
from employees 
join jobs using (job_id)
where job_id = 
(select job_id from employees
where first_name = 'Trenna');

-- 12. Display the names and department name of all employees working in the same city as Trenna.   
select concat(first_name,' ',last_name) as employee_name, department_name
from employees 
join departments using (department_id)
join locations using (location_id)
where city =  
(select city from employees
join departments using (department_id)
join locations using (location_id)
where first_name = 'Trenna');  

-- 13. Display the name of the employee whose salary is the lowest.  
select concat(first_name,' ',last_name) as employee_name
from employees
where salary = 
( select min(salary) from employees);

-- 14. Display the names of all employees except the lowest paid.
select concat(first_name,' ',last_name) as employee_name
from employees
where salary != 
( select min(salary) from employees);


-- 1. Write a query to display the last name, department number, department name for all employees.  
select e.last_name, e.department_id, d.department_name 
from employees e
join departments d
on e.department_id = d.department_id;

-- 2. Create a unique list of all jobs that are in department 4. Include the location of the 
-- department in the output.   
select  distinct e.job_id, d.location_id 
from employees e
join departments d
on e.department_id = d.department_id
where e.department_id = 4;

-- 3. Write a query to display the employee last name,department name,location id and city of 
-- all employees who earn commission.   
select e.last_name, d.department_name, d.location_id, l.city
from departments d
join employees e 
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where e.commission_pct is not null;

-- 4. Display the employee last name and department name of all employees who have an 'a' 
-- in their last name  
select last_name, department_name
from employees 
join departments using (department_id)
where last_name like '%a%';
 
-- 5. Write a query to display the last name,job,department number and department name for 
-- all employees who work in ATLANTA.   
select e.last_name, e.job_id, d.department_name, d.department_id
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city = 'ATLANTA';

-- 6. Display the employee last name and employee number along with their manager's last 
-- name and manager number.  
select e.last_name as emp_last_name , e.employee_id as emp_number, m.last_name as manager_last_name, m.employee_id as emp_manager_id
from employees e
join employees m
on e.manager_id = m.employee_id;
 
-- 7. Display the employee last name and employee number along with their manager's last 
-- name and manager number (including the employees who have no manager). 
select e.last_name as emp_last_name , e.employee_id as emp_number, m.last_name as manager_last_name, m.employee_id as emp_manager_id
from employees e
left join employees m
on e.manager_id = m.employee_id;
  
-- 8. Create a query that displays employees last name,department number,and all the 
-- employees who work in the same department as a given employee.
select e1.last_name, e1.department_id, e2.last_name
from employees e1
join employees e2
on e1.department_id = e2.department_id
where e1.last_name != e2.last_name;

-- 9. Create a query that displays the name,job,department name,salary,grade for all 
-- employees.  Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) 
select concat(first_name,' ',last_name) as full_name, job_id, department_name, salary, 
case 
when salary >= 50000 then 'A'
when salary >= 30000 then 'B'
when salary < 30000 then 'C'
end as grade
from employees 
join departments using (department_id);

-- 10. Display the names and hire date for all employees who were hired before their 
-- managers along withe their manager names and hire date. Label the columns as Employee 
-- name, emp_hire_date,manager name,man_hire_date
select concat(e.first_name,' ',e.last_name) as Employee_name, e.hire_date as emp_hire_date, concat(m.first_name,' ',m.last_name) as manager_name, m.hire_date as man_hire_date
from employees e
join employees m
on e.manager_id = m.employee_id
where e.hire_date < m.hire_date;


-- 1. Write a query to display the last name and hire date of any employee in the same 
-- department as SALES.
select last_name, hire_date 
from employees 
join departments using (department_id)
where department_name = 'SALES';
    
-- 2. Create a query to display the employee numbers and last names of all employees who 
-- earn more than the average salary. Sort the results in ascending order of salary.  
select employee_id, last_name from employees
where salary > (select avg(salary) from employees)
order by salary;
 
-- 3. Write a query that displays the employee numbers and last names of all employees who 
-- work in a department with any employee whose last name contains a' u   
select employee_id, last_name from employees 
where department_id is not null and last_name like '%a%' or '%u%';

-- 4. Display the last name, department number, and job ID of all employees whose 
-- department location is ATLANTA.
select e.last_name, e.department_id, e.job_id 
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city = 'ATLANTA';
   
-- 5. Display the last name and salary of every employee who reports to FILLMORE.
select last_name, salary
from employees
where manager_id =
(select employee_id from employees
where first_name = 'FILLMORE') ; 
   
-- 6. Display the department number, last name, and job ID for every employee in the 
-- OPERATIONS department.   
select d.department_id, e.last_name, e.job_id 
from employees e
join departments d
on e.department_id = d.department_id
where d.department_name = 'Operations';

-- 7. Modify the above query to display the employee numbers, last names, and salaries of all 
-- employees who earn more than the average salary and who work in a department with any 
-- employee with a 'u'in their name. 
select e.employee_id, e.last_name, e.salary
from employees e
join departments d
on e.department_id = d.department_id
where e.salary > (select avg(salary) from employees)
and e.first_name like '%u%' or e.last_name like '%u%';

-- 8. Display the names of all employees whose job title is the same as anyone in the sales dept.   
select concat(e.first_name,' ',e.last_name) as Employee_name
from employees e
join departments d
on e.department_id = d.department_id 
join jobs j
on e.job_id = j.job_id
where d.department_name like 'sales%' and
 j.job_title like 'sales%';
 
-- 9. Write a compound query to produce a list of employees showing raise percentages, 
-- employee IDs, and salaries. Employees in department 1 and 3 are given a 5% raise, 
-- employees in department 2 are given a 10% raise, employees in departments 4 and 5 are 
-- given a 15% raise, and employees in department 6 are not given a raise.   
select employee_id, salary, 5 as raise_percentage
from employees
where department_id in (1,3) 
union all
select employee_id, salary, 10 as raise_percentage
from employees
where department_id = 2
union all
select employee_id, salary, 15 as raise_percentage
from employees
where department_id in (4,5)
union all
select employee_id, salary, 'not given' as raise_percentage
from employees
where department_id = 6;

-- 10. Write a query to display the top three earners in the EMPLOYEES table. Display their last 
-- names and salaries.   
select last_name, salary
from employees
order by salary desc limit 3;

-- 11. Display the names of all employees with their salary and commission earned. Employees 
-- with a null commission should have O in the commission column.
select concat(first_name,' ',last_name) as emp_name, salary, coalesce(commission_pct,0) as commission from employees;

-- 12. Display the Managers (name) with top three salaries along with their salaries and 
-- department information.
select distinct concat(m.first_name,' ',m.last_name) as manager_name, m.salary, m.department_id
from employees e
join employees m
on e.manager_id = m.employee_id
order by salary desc limit 3;