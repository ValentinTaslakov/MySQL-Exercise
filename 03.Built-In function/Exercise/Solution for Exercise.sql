

Решения на задачите от упражнение 03

# zad 1
SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    SUBSTRING(`first_name`, 1, 2) = 'Sa';
    
# zad 2
SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    `last_name` LIKE "%ei%";
    
SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
locate("ei",LOWER(`last_name`));

# zad 3
SELECT 
    `first_name`
FROM
    `employees`
WHERE
    `department_id` IN ('3' , '10')
        AND YEAR(hire_date) BETWEEN 1995 AND 2005
        # Използвам Година преди да посоча полето понеже в датата на полето 
        # има и месец и ден и час а на нас ни трябва само година (поплето е timestamp).
ORDER BY `employee_id`; 

# zad 4
SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
     `job_title` NOT LIKE "%engineer%"
ORDER BY `employee_id`;

# zad 5
SELECT 
    `name`
FROM
    `towns`
WHERE
    CHAR_LENGTH(`name`) IN (5 , 6)
ORDER BY `name`;

# zad 6
SELECT * FROM
    `towns`
WHERE
   SUBSTRING(`name`, 1, 1) IN ("M", "K", "B", "E") 
ORDER BY `name`;
# различни методи за решаване на задачата има и още.
SELECT * FROM
    `towns`
WHERE
  `name` LIKE "M%" 
  OR `name` LIKE "K%" 
  OR `name` LIKE "B%"
  OR `name` LIKE "E%" 
ORDER BY `name`;

SELECT * FROM
    `towns`
WHERE
 left(lower(`name`),1) IN ("m", "b", "k", "e")  
ORDER BY `name`;

# zad 7
SELECT * FROM
    `towns`
WHERE
 left(lower(`name`),1) NOT IN ("r", "b", "d")  
ORDER BY `name`;

SELECT * FROM
    `towns`
WHERE
  lower(`name`) NOT LIKE "r%" 
  AND lower(`name`) NOT LIKE "b%" 
  AND lower(`name`) NOT LIKE "d%"
  # бях го написал със OR което значи или -  при което връща тру понеже на 
  # него му трябва само едно тру от всички условия и използваме AND за
  # да се наложи всички условия да са тру
 ORDER BY `name`;
 
 # zad 8
CREATE VIEW `v_employees_hired_after_2000` AS
    SELECT 
        `first_name`, `last_name`
    FROM
        `employees`
    WHERE
        YEAR(hire_date) > 2000;
 
SELECT 
    *
FROM
    `v_employees_hired_after_2000`;
 
 
CREATE VIEW `v_employees_hired_after_2000` AS
    SELECT 
        `first_name`, `last_name`
    FROM
        `employees`
    WHERE
        EXTRACT(YEAR FROM `hire_date`) > 2000;
 
SELECT 
    *
FROM
    `v_employees_hired_after_2000`;
    
# zad 9 
 SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    CHAR_LENGTH(`last_name`) = 5;
    
# zad 10
SELECT 
    `country_name`, `iso_code`
FROM
    `countries`
WHERE
    LOWER(`country_name`) LIKE '%a%a%a%'
ORDER BY `iso_code`;

# zad 11
SELECT 
    p.`peak_name`,
    r.`river_name`,
    CONCAT(LOWER(LEFT(p.`peak_name`,
                        CHAR_LENGTH(p.`peak_name`) - 1)),
            LOWER(`river_name`)) AS `mix`
            # първо взимам имената на върховете с малки букви
            # после взимам лявата част на името без последната буква 
			# защото при залепянето не трябва да я има
            # а и трябва да посоча колко от ляво на думата да вземе функцията LEFT
            # и долепям името на реката с малки букви
FROM
    `peaks` AS p,
    `rivers` AS r
WHERE
    RIGHT(LOWER(`peak_name`), 1) = LEFT(LOWER(`river_name`), 1)
ORDER BY `mix`;

# zad 12
SELECT 
    `name`, date_format(`start`, "%Y-%m-%d") 
FROM
    `games`
WHERE
    YEAR(`start`) BETWEEN 2011 AND 2012
ORDER BY `start` , `name`
LIMIT 50;

# zad 13 diablo database
SELECT `user_name`, substring(`email`,LOCATE("@",`email`) +1) AS "email provider" 
FROM `users`
ORDER BY `email provider` ,`user_name`;

SELECT `user_name`, 
REGEXP_REPLACE(`email`, ".*@", "") AS "email provider" 
FROM `users`
ORDER BY `email provider` ,`user_name`;

SELECT `user_name`, 
substring_index(`email`, "@", -1) AS "email provider" 
FROM `users`
ORDER BY `email provider` ,`user_name`;

# zad 14
SELECT `user_name`,`ip_address`
FROM `users`
WHERE `ip_address` REGEXP "^[0-9]{3}.1[0-9]{2}\.[0-9]+.[0-9]{3}" 
ORDER BY `user_name`;
# горното не минава в джъдж понеже има ИП-та които след единицата има повече от три символа
SELECT `user_name`,`ip_address`
FROM `users`
WHERE `ip_address` LIKE "___.1%.%.___"
ORDER BY `user_name`;

# zad 15
SELECT 
    `name` AS 'game',
    CASE
        WHEN
            EXTRACT(HOUR FROM `start`) >= 0
                AND EXTRACT(HOUR FROM `start`) < 12
        THEN
            'Morning'
        WHEN
            EXTRACT(HOUR FROM `start`) >= 12
                AND EXTRACT(HOUR FROM `start`) < 18
        THEN
            'Afternoon'
        WHEN
            EXTRACT(HOUR FROM `start`) >= 18
                AND EXTRACT(HOUR FROM `start`) < 24
        THEN
            'Evening'
    END AS 'Part of the day ',
    CASE
        WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` > 3 AND `duration` <= 6 THEN 'Short'
        WHEN `duration` > 6 AND `duration` <= 10 THEN 'Long'
        ELSE 'Extra Long'
    END AS 'Duration'
FROM
    `games`;
 
 # zad 16
 SELECT 
	`product_name`, 
    `order_date`, 
    DATE_ADD(`order_date`, INTERVAL 3 DAY) AS "pay_due", 
    DATE_ADD(`order_date`, INTERVAL 1 MONTH) AS "deliver_due"
   
FROM `orders`;
