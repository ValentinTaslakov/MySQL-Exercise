
Solution for exercise 6

# zad 1

SELECT e.employee_id,
e.job_title,
a.address_id,
a.address_text 
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
ORDER BY a.address_id
LIMIT 5;

# zad 2 
SELECT e.first_name,
e.last_name, 
t.name,
a.address_text
FROM employees AS e

JOIN addresses AS a
ON e.address_id = a.address_id

JOIN towns AS t
ON a.town_id = t.town_id

ORDER BY first_name, last_name
LIMIT 5;

# zad 3
SELECT e.employee_id,
e.first_name, 
e.last_name,
d.`name` AS "department_name"
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id 
WHERE d.`name` = "Sales"
ORDER BY employee_id DESC;

# zad 4
SELECT e.employee_id,
e.first_name, 
e.salary,
d.`name` AS "department_name"
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id 
WHERE salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

# zad 5
SELECT e.employee_id,
e.first_name
FROM employees AS e
LEFT JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
WHERE project_id is NULL
ORDER BY employee_id DESC
LIMIT 3;

# zad 6
SELECT 
e.first_name,
e.last_name, 
e.hire_date,
d.`name` AS "dept_name"
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id 
WHERE hire_date > 1998 AND d.`name` IN ("Sales", "Finance")
ORDER BY e.hire_date ;

# zad 7
SELECT e.employee_id,
e.first_name,
p.`name` AS "project_name"
FROM employees AS e

JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id

JOIN projects AS p 
ON ep.project_id = p.project_id

WHERE DATE(p.start_date) > "2002-08-13" AND p.end_date IS NULL
ORDER BY e.first_name, p.`name`
LIMIT 5;

# zad 8
SELECT e.employee_id,
e.first_name,
CASE 
	WHEN (p.start_date) > '20050101' THEN NULL
    ELSE p.`name` END  AS "project_name" 
    
FROM employees AS e

JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id

JOIN projects AS p 
ON ep.project_id = p.project_id

WHERE e.employee_id = 24 
ORDER BY p.`name` ;

/* За тази задача трябва да изкарам всички проекти за служител с ИД 24
обаче ако датата на която е стартирал проекта е след 01-01-2005 вместо името на проекта 
трябва да се отпечата NULL. При горния вариант вкарвам проверката в селекта като използвам
CASE но може и ИФ Ако стартовата дата е след посочената дата(изписвам слято ден,месец, година)
тогава нулл иначе да принтира името на проекта в в колона с име , но така не ги сортира
както иска джъдж (първо нулите и после имената в азбучен ред)
В долния вариант изписвам колоните от таблиците които ми трябват в селекта
после си правя джойн със свързващата таблица и след това ляв джойн на свързващата 
и таблицата с проектите и като дам ON за да посоча колоните спрямо които ще стане свързването
добавям и AND YEAR(p.start_date) < '2005' така ако годината на стартиране на проекта 
не е по малка от 2005 (а е след 2005) името става нулл понеже сме дали ляв джойн 
изважда служителя задължително , а на проекта изписва нулл и при сортиране нулите са първи 
и после самите имена на проектите  
*/

SELECT e.employee_id,
e.first_name,
p.`name`   AS "project_name" 
FROM employees AS e

JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id

LEFT JOIN projects AS p 
ON ep.project_id = p.project_id
AND YEAR(p.start_date) < '2005' 

WHERE e.employee_id = 24 
ORDER BY p.`name` ;

# zad 9 
SELECT 
    e.employee_id, e.first_name, e.manager_id, e1.first_name
FROM
    employees AS e
        JOIN
    employees AS e1 ON e1.employee_id = e.manager_id
WHERE
    e.manager_id IN (3 , 7)
ORDER BY e.first_name;

/*В задачата се иска да се изкарат служителите със мениджър със ИД = 3 или 7 и колона 
със името на мениджъра . Понеже таблицата реферира със вторичен ключ (manager_id) към
първичния (employee_id) трябва да джойна тази таблица със нея си(в ЕР диаграмата се 
вижда референцията), правя го като стандартен джойн но посочвам пак същата таблица 
с AS е1 при ON взимам e1.employee_id = e.manager_id и в селекта e1.first_name след 
като в WHERE съм поставил условието в е1 при ОН клаузата взима само допустимите случаи 
(3 и 7) и за  e1.first_name в селекта ми извежда първите имена на допустимите случаи 

*/

# zad 10
SELECT 
    e.employee_id, 
    CONCAT( e.first_name, " ", e.last_name) AS "employee_name",
    CONCAT(e1.first_name, " ", e1.last_name) AS "manager_name",
    d.`name` AS "department_name"
FROM
    employees AS e
        JOIN
    employees AS e1 ON e1.employee_id = e.manager_id
		JOIN departments AS d ON d.department_id = e.department_id

ORDER BY e.employee_id
LIMIT 5;

# zad 11
SELECT AVG(e.`salary`) AS "min_average_salary"
FROM employees AS e
GROUP BY department_id
ORDER BY min_average_salary
LIMIT 1;
/*Иска се да изведа най-малката средна заплата по департаменти, 
намирам средната заплата групирам по департаменти 
подреждам ги спрямо средната заплата за всеки департамент 
и давам да покаже само първия запис 
*/

# zad 12
SELECT 
    c.country_code,
    m.mountain_range,
    p.peak_name,
    p.elevation
FROM
    countries AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN
    mountains AS m ON mc.mountain_id = m.id
		JOIN 
	peaks AS p ON m.id = p.mountain_id

WHERE c.country_code = "BG" AND p.elevation > 2835
ORDER BY p.elevation DESC;

# zad 13
SELECT 
    c.country_code,
    COUNT(m.mountain_range) AS "mountain_range"
FROM
    countries AS c
        JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        JOIN
    mountains AS m ON mc.mountain_id = m.id
WHERE c.country_code IN ("BG", "RU", "US")
GROUP BY c.country_code
ORDER BY mountain_range DESC;

# zad 14
SELECT 
c.country_name,
r.river_name
FROM countries AS c

LEFT JOIN countries_rivers AS cr
ON c.country_code = cr.country_code

LEFT JOIN rivers AS r 
ON cr.river_id = r.id

WHERE c.continent_code = "AF"
ORDER BY c.country_name
LIMIT 5;

# zad 15 
SELECT 
con.continent_code,
cou.currency_code,
COUNT(cur.description) AS "currency_usage"
FROM continents AS con

JOIN countries AS cou
ON con.continent_code = cou.continent_code

JOIN currencies AS cur
ON cou.currency_code = cur.currency_code

GROUP BY con.continent_code

ORDER BY con.continent_code, cou.currency_code;
-- --------------------
SELECT d1.continent_code, d1.currency_code, d1.currency_usage FROM 
	(SELECT `c`.`continent_code`, `c`.`currency_code`,
    COUNT(`c`.`currency_code`) AS `currency_usage` FROM countries as c
	GROUP BY c.currency_code, c.continent_code HAVING currency_usage > 1) as d1
LEFT JOIN 
	(SELECT `c`.`continent_code`,`c`.`currency_code`,
    COUNT(`c`.`currency_code`) AS `currency_usage` FROM countries as c
	 GROUP BY c.currency_code, c.continent_code HAVING currency_usage > 1) as d2
ON d1.continent_code = d2.continent_code AND d2.currency_usage > d1.currency_usage

WHERE d2.currency_usage IS NULL
ORDER BY d1.continent_code, d1.currency_code;

# zad 16
SELECT COUNT(c.country_name) AS "country_count" 
FROM countries AS c
LEFT JOIN mountains_countries AS mc
ON c.country_code = mc.country_code

LEFT JOIN mountains AS m
ON mc.mountain_id = m.id
WHERE m.mountain_range IS NULL;

# zad 17
SELECT 
c.country_name,
MAX(ANY_VALUE(p.elevation)) AS "highest_peak_elevation",
MAX(ANY_VALUE(r.length)) AS "longest_river_length"
FROM countries AS c

LEFT JOIN mountains_countries AS mc
ON c.country_code = mc.country_code

LEFT JOIN mountains AS m
ON mc.mountain_id = m.id

LEFT JOIN peaks AS p
ON m.id = p.mountain_id 

LEFT JOIN countries_rivers AS cr
ON c.country_code = cr.country_code

LEFT JOIN rivers AS r 
ON cr.river_id = r.id

GROUP BY c.country_code
ORDER BY highest_peak_elevation DESC,
		longest_river_length DESC,
        c.country_name
LIMIT 5;