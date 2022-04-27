
# zad 1

SELECT s.employee_id,
concat(s.first_name, " ", s.last_name) AS "full_name",
d.department_id,
d.name
 FROM employees AS s
 RIGHT JOIN  departments AS d
 
 ON d.manager_id = s.employee_id

ORDER BY employee_id
LIMIT 5;

# zad 2
SELECT t.* ,
a.address_text
FROM towns AS t
JOIN addresses AS a
ON t.town_id = a.town_id
WHERE t.`name` IN ("San Francisco", "Sofia", "Carnation")
ORDER BY town_id, address_id ;

# zad 3

SELECT employee_id, first_name, last_name, department_id, salary
 FROM employees
WHERE manager_id is NULL;

# zad 4
SELECT COUNT(e.employee_id) AS "count"
FROM employees AS e
WHERE e.salary > 
(
	SELECT AVG(salary) AS "average_salary"
    FROM employees
);
