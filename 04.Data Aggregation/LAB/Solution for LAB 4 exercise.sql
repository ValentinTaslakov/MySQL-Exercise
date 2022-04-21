
Решения на задачите от упражнение 04

# zad 1 
SELECT `department_id`, count(`department_id`) AS "Number of employees"
FROM employees
GROUP BY `department_id`
ORDER BY `department_id`, `Number of employees`;

# zad 2
SELECT `department_id`, round(AVG(`salary`), 2 ) AS "Average Salary"
FROM employees
GROUP BY `department_id`
ORDER BY `department_id`, `Average Salary`;

# zad 3
SELECT `department_id`, round(MIN(`salary`), 2 ) AS "Min Salary"
FROM employees
GROUP BY `department_id`
HAVING `Min Salary` > 800 
ORDER BY `department_id`, `Min Salary`;

# задача 3 я правим с HAVING, а не както долу със WHERE
# в долния случай връща всички заплати  над 800 защото е преди групирането и 
# МИН салари не работи , но ако го поставим след групирането (горе) всичко е ок.

SELECT `department_id`, round(MIN(`salary`), 2 ) AS "Min Salary"
FROM employees
WHERE`Salary` > 800 
GROUP BY `department_id`
ORDER BY `department_id`, `Min Salary`;

# zad 4

SELECT COUNT(`category_id`)
FROM products
WHERE  `price` > 8
GROUP BY `category_id`
HAVING `category_id` = 2 ;

# 1-во задавам му каунт който да брои в колоната категори_ид
# от посочената таблица , 2-ро му казвам да вземе тези при които цената е > 8
# после групирам по колоната категори_ид и му казвам да вземе само тези с ид = 2

# zad 5
SELECT 
	`category_id`,
	ROUND(AVG(`price`),2) AS "Average Price",
    ROUND(MIN(`price`),2) AS "Cheapest Product",
    ROUND(MAX(`price`),2) AS "Most Expensive Product"
FROM `products`
GROUP BY `category_id` ;
