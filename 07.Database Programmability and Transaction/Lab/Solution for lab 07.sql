# zad  1.Count Employees by Town
DELIMITER ###  
# пишем това за да променим делиметъра(разделителя)
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN
	(SELECT COUNT(*) FROM employees AS e
	JOIN  addresses AS a ON e.address_id = a.address_id
	JOIN towns AS t  ON a.town_id = t.town_id
	WHERE t.name = town_name);
END
###  

/* Варианта на лектора 
	- 1-во си пишем заявката който ни показва броя на служителите 
, във подадения в WHERE клаузата град. 
	- 2-ро След като сме написали заявката и сме проверили че работи 
, започваме да изписваме магията за създаване на (функция)->(също като метод в JAVA който 
     връща резултат)
 - Започва се със CREATE FUNCTION после име на функцията -> ufn_count_employees_by_town
след това в скоби име на параметъра който очакваме и от какъв тип е -> (town_name VARCHAR(50))
 - RETURNS INT -> на нов ред , посочва какъв тип данни се връщат 
 - Следващите са стандартни (за DETERMINISTIC - посочва че при един и същи 
 вход има един и същи изход трябва да прочета ) -> DETERMINISTIC и BEGIN
 - след BEGIN слагаме END и между двете нашата заявка, като в WHERE клаузата вместо 
 име на град пишем параметъра който се подава при извикване на функцията ,
 като цялата заявка слагаме в скоби и преди скобите пишем RETURN -> или трябва да се 
 върне резултат и така връщаме резултата от нашата функция 
 - ако не сме променили делиметъра горе заявката свети че е с грешен синтаксис 
 заради ->; след скобите на заявката.
 долу избираме функцията и и подаваме града 
*/
SELECT ufn_count_employees_by_town("Sofia") AS "count";

DELIMITER ***
CREATE FUNCTION ufn_count_employees_by_town1(town_name VARCHAR(20))
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
	SET e_count := (SELECT COUNT(employee_id) FROM employees AS e
	 JOIN addresses AS a ON a.address_id = e.address_id
	 JOIN towns AS t ON t.town_id = a.town_id
	WHERE t.name = town_name);
	RETURN e_count;
END ***
/*Това е варианта (как се прави функция) от презентацията 
 - Пак се използва DELIMITER ***
 - Основна разлика е връщането -> 
		1-во декларираме променлива -> DECLARE e_count INT;
        2-ро сетваме тази променлива да присвоява (:=) резултата от нашата заявка 
			-> SET e_count := 
		3-то връщаме променливата която държи резултата -> RETURN e_count;
 Като отидем на Function (в дясно където са схемите ) с десен бутон върху него 
 ми дава да създам функция (същото важи и за процедурите ), като отворя прозореца трябва само да сменя името, 
 променливата и да добавя работещата заявка. 
*/

# zad 2. Employees Promotion

CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(45)) 
BEGIN
	UPDATE employees AS e
	RIGHT JOIN
		departments AS d ON e.department_id = d.department_id 
	SET 
		e.salary = e.salary * 1.05
	WHERE
		d.name = department_name;
END ***
/* Както при селекта, UPDATE и посочваме таблицата в която ще се извършва промяната 
после си правим джойна и след това пишем сета -> в случая променяме заплатата със 
зададеното условие .
След това задължително условието при което се извършва сета(иначе ще сетне всички). 
Иначе както функция така и процедура с по-малко синтаксис 
CREATE PROCEDURE -> казваме че създаваме процедура 
usp_raise_salaries -> даваме име на процедурата 
(department_name VARCHAR(45)) -> и в скобите че приема някакъв параметър в случая 
приема име на департамент на който да вдигнем заплатата 
Долу -> така се извиква процедурата (войд метод в джава) 
*/
CALL usp_raise_salaries("Tool Design");

# zad 3 Employees Promotion by ID
***
CREATE PROCEDURE usp_raise_salary_by_id(id INT) 
BEGIN
		UPDATE employees AS e
        SET e.salary = e.salary * 1.05
		WHERE e.employee_id = id;
END ***

# zad 4 Triggered
CREATE TABLE deleted_employees(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	middle_name VARCHAR(20),
	job_title VARCHAR(50),
	department_id INT,
	salary DOUBLE 
);
***
CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees 
    (first_name,last_name, middle_name,job_title,department_id,salary)
	VALUES
    (OLD.first_name,
    OLD.last_name,
    OLD.middle_name, 
    OLD.job_title,
    OLD.department_id,
    OLD.salary);
END;
