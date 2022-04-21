

Решения на задачите от упражнение 02

# zad 1
SELECT * FROM `departments`
ORDER BY `department_id`;

# zad 2
SELECT `name` FROM `departments`
ORDER BY `department_id`;

# zad 3
SELECT `first_name`, `last_name`, `salary` FROM `employees`
ORDER BY `employee_id`; 

#zad 4
SELECT `first_name`, `middle_name`, `last_name` FROM `employees`
ORDER BY `employee_id`; 

# zad 5
SELECT concat(`first_name`, ".", `last_name`, "@softuni.bg")
AS "full_email_address"  
FROM `employees`;

# zad 6
SELECT DISTINCT `salary` FROM `employees`
ORDER BY `salary` ASC;

# zad 7
SELECT * FROM `employees`
WHERE `job_title` = "Sales Representative"
ORDER BY `employee_id`;

# zad 8
SELECT  `first_name`, `last_name`, `job_title` FROM `employees`
WHERE `salary` BETWEEN 20000 AND 30000
ORDER BY `employee_id`;

# zad 9
SELECT concat_ws(" ",`first_name`, `middle_name`, `last_name`)
AS "Full Name"  
FROM `employees`
WHERE `salary` IN (25000, 14000, 12500, 23600);
# тук използвам IN вместо OR защото ОР значи или а при IN взима всички в скобите 

# zad 10
SELECT  `first_name`, `last_name` FROM `employees`
WHERE `manager_id` IS NULL;

# zad 11
SELECT `first_name`, `last_name`, `salary` FROM `employees`
WHERE `salary` > 50000
ORDER BY `salary` DESC;

# zad 12 
SELECT `first_name`, `last_name` FROM `employees`
ORDER BY `salary` DESC
LIMIT 5 ;

# zad 13
SELECT `first_name`, `last_name` FROM `employees`
WHERE `department_id` NOT IN (4);

SELECT `first_name`, `last_name` FROM `employees`
WHERE NOT `department_id` =  4 ;

# zad 14
SELECT * FROM `employees`
ORDER BY `salary` DESC , 
`first_name` , 
`last_name` DESC,
`middle_name`;

# zad 15
CREATE VIEW `v_employees_salaries` AS;
# zad 16
CREATE VIEW `v_employees_job_titles` AS 
SELECT concat_ws(" ",`first_name`, `middle_name`, `last_name`)
AS "full_name" , `job_title`
FROM `employees`;

SELECT *  From  `v_employees_job_titles`;
