/*
Identify projects that are at risk for going overbudget. A project is considered to be overbudget if the cost of all employees assigned to the project is greater than the budget of the project.


You'll need to prorate the cost of the employees to the duration of the project. For example, if the budget for a project that takes half a year to complete is $10K, 
then the total half-year salary of all employees assigned to the project should not exceed $10K. Salary is defined on a yearly basis, so be careful how to calculate salaries
for the projects that last less or more than one year.


Output a list of projects that are overbudget with their project name, project budget, and prorated total employee expense (rounded to the next dollar amount).

table 1: linkedin_projects
id:				int
title:			varchar
budget:			int
start_date:		datetime
end_date:		datetime

table 2: linkedin_emp_projects
emp_id:			int
project_id:		int

table 3: linkedin_employees
id:				int
first_name:		varchar
last_name:		varchar
salary:			int
*/
--solution
with salary as
(
select project_id,
        sum(salary) as emp_salary
from linkedin_emp_projects a
join linkedin_employees b
on a.emp_id = b.id
group by project_id
)
select c.title, c.budget,
    ceil(datediff(end_date, start_date)/365*d.emp_salary) as total_emp_expense
from linkedin_projects c
join salary d
on c.id = d.project_id
where datediff(end_date, start_date)/365*d.emp_salary > c.budget