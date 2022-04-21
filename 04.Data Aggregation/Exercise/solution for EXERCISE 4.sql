
Решения на задачите от упражнение 04

# zad 1
SELECT COUNT(*) FROM `wizzard_deposits`;


# zad 2 
SELECT 
	MAX(`magic_wand_size`) AS "longest_magic_wand"
FROM 
	`wizzard_deposits`;


    
# zad 3 
SELECT 
	`deposit_group`,
	MAX(`magic_wand_size`) AS "longest_magic_wand"
FROM 
	`wizzard_deposits`
GROUP BY
	`deposit_group`
ORDER BY
	`longest_magic_wand`, `deposit_group` ;

    
# zad 4 
SELECT
	`deposit_group` 
FROM 
	`wizzard_deposits`
GROUP BY
	`deposit_group` 
ORDER BY AVG(magic_wand_size)
LIMIT 1;


# zad 5
SELECT
	`deposit_group`, SUM(`deposit_amount`) AS "total_sum"
FROM 
	`wizzard_deposits`
GROUP BY
	`deposit_group` 
ORDER BY `total_sum`;


# zad 6
SELECT
	`deposit_group`, SUM(`deposit_amount`) AS "total_sum"
FROM 
	`wizzard_deposits`
WHERE `magic_wand_creator` = "Ollivander family"
GROUP BY
	`deposit_group` 
ORDER BY `deposit_group`;


# zad 7
SELECT
	`deposit_group`, SUM(`deposit_amount`) AS "total_sum"
FROM 
	`wizzard_deposits`
WHERE `magic_wand_creator` = "Ollivander family"
GROUP BY
	`deposit_group` 
HAVING `total_sum` < 150000
ORDER BY `total_sum` DESC;


# zad 8
SELECT 
    `deposit_group`,
    `magic_wand_creator`,
    MIN(`deposit_charge`) AS `min_deposit_charge`
FROM
    `wizzard_deposits`
GROUP BY `deposit_group` , `magic_wand_creator`
ORDER BY `magic_wand_creator` , `deposit_group`;


# zad 9
SELECT 
    CASE
        WHEN `age` <= 10 THEN '[0-10]'
        WHEN `age` <= 20 THEN '[11-20]'
        WHEN `age` <= 30 THEN '[21-30]'
        WHEN `age` <= 40 THEN '[31-40]'
        WHEN `age` <= 50 THEN '[41-50]'
        WHEN `age` <= 60 THEN '[51-60]'
        ELSE '[61+]'
    END AS 'age_group',
    COUNT(`age`)
		# когато искаме да вкараме имена на наши полета и да прекръстим колоната 
		# трябва ни колоната за години в която да дефинираме различни интервали
		# използваме КАСЕ и за последната група ЕЛСЕ и името на полето
		# накрая завършваме с ЕНД и елиас за името на колоната
		# Долу групираме и сортираме по тази колона която сме създали.
FROM
    `wizzard_deposits`
GROUP BY `age_group`
ORDER BY `age_group`;
    

# zad 10 		 
SELECT DISTINCT(LEFT(`first_name`, 1)) AS "first_letter"
FROM `wizzard_deposits`
WHERE `deposit_group` = "Troll Chest"
ORDER BY `first_letter`;

SELECT LEFT(`first_name`, 1) AS "first_letter"
FROM `wizzard_deposits`
WHERE `deposit_group` = "Troll Chest"
GROUP BY `first_letter`
ORDER BY `first_letter`;


# zad 11
SELECT `deposit_group`, `is_deposit_expired`, AVG(`deposit_interest`) AS "average_interest"
FROM `wizzard_deposits`
WHERE (`deposit_start_date`) > "1985-01-01"
GROUP BY `deposit_group` , `is_deposit_expired` 
ORDER BY `deposit_group` DESC, `is_deposit_expired`;


# zad 12 
SELECT `department_id`, MIN(`salary`) AS "minimum_salary"
FROM `employees`
WHERE YEAR(`hire_date`) > 1999 
GROUP BY `department_id`
HAVING `department_id` in (2,5,7);


# zad 13
SELECT `department_id`, IF(`department_id`= 1, AVG(`salary`) + 5000, AVG(`salary`)) AS "avg_salary"
FROM `employees`
WHERE `salary` > 30000 AND `manager_id` != 42
GROUP BY `department_id`
ORDER BY `department_id`;


# zad 14
SELECT `department_id`, MAX(`salary`) AS "max_salary"
FROM `employees`
# WHERE `max_salary` NOT BETWEEN 30000 AND 70000 
GROUP BY `department_id`
HAVING `max_salary` NOT BETWEEN 30000 AND 70000 
ORDER BY `department_id`;


# zad 15
SELECT (COUNT(*) - COUNT(`manager_id`))
FROM `employees`;


# zad 16 
SELECT 
    `department_id`,
    (SELECT DISTINCT
            `salary`
        FROM
            `employees` AS e2
        WHERE
            e1.department_id = e2.department_id
        ORDER BY `salary` DESC
        LIMIT 2 , 1) AS 'third_highest_salary'
FROM
    `employees` AS e1
GROUP BY `department_id`
HAVING `third_highest_salary` IS NOT NULL
ORDER BY `department_id`;

/* Ред 139-140 : избираме да ни покаже  `department_id`
ред 141 - 148 : Вложен селект правим го в скоби веднага след запетаята след като 
сме избрали  `department_id` ->
(на мястото където избираме втора колонка за показване)
ред 141 - избираме всяка уникална стойност
ред 142 - от колона заплата 
ред 143 - 144 - от таблица служители представена с име е2
ред 145 - 146 - където ид-то на отдела от е1 съвпада със отдела от е2
ред 147 - да се сортират по заплата от най - високата към най-ниската 
ред 148 - даваме лимит като посочваме да почне от втория ред и да покаже 
само един ред (подредили сме заплатите по големина и по този начин започваме 
от втората и взимаме една след нея -> третата) става и с LIMIT 1 OFFSET 2

ред 150 - таблицата служители с име а1 (представянето на таблицата с едно име тук и 
с друго във вложения цикъл е да сме сигурни че при двата селекта с 
различни условия ще ни изкара третата най - висока заплата за конкретния отдел )
старт бутона + v - показва клип борда и там се пази всичко което съм копирал докато 
не рестартирам или изгася компа
*/


# zad 17 
SELECT 
    e1.`first_name`, e1.`last_name`, e1.`department_id`
FROM
    `employees` AS e1
        JOIN
    (SELECT 
        e2.`department_id`, AVG(e2.`salary`) AS `salary`
    FROM
        employees AS e2
    GROUP BY e2.`department_id`
    ) AS `dep_average` ON e1.`department_id` = `dep_average`.`department_id`
WHERE
   e1.`salary` > `dep_average`.`salary`
ORDER BY e1.`department_id` , e1.`employee_id`
LIMIT 10;
     /* join очаква да свържем две таблици , ON очаква при какво условие се свързват 
     таблиците (в случая свързваме таблица със заявка която извлича нужната информация)
     */
SELECT `first_name`, `last_name`, `department_id`
FROM `employees` AS e
WHERE e.`salary` > (SELECT AVG(`salary`) FROM `employees`
					WHERE `department_id` = e.`department_id` 
                    GROUP BY `department_id`)
ORDER BY `department_id`, `employee_id`
LIMIT 10;

# правим вложен селект в Where клаузата, където взимаме средната заплата и добавяме 
# Where за да можем да вземем средната за съотверния отдел, като я вземем 
# средната заплата тя трябва да е по малка от заплатата на служителя от този департамент 


# zad 18
SELECT `department_id`, SUM(`salary`)
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;


