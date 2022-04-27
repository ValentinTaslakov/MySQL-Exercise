# zad 1 Employees with Salary Above 35000
DELIMITER ***
CREATE PROCEDURE `usp_get_employees_salary_above_35000`()
BEGIN
SELECT first_name, last_name
FROM employees
WHERE salary > 35000
ORDER BY first_name, last_name, employee_id;
END
***

# zad 2. Employees with Salary Above Number
CREATE PROCEDURE `usp_get_employees_salary_above` (above_sum DECIMAL(10,4))
BEGIN
SELECT first_name, last_name
FROM employees
WHERE salary >= above_sum
ORDER BY first_name, last_name, employee_id;
END
***

# zad 3.Town Names Starting With
CREATE PROCEDURE `usp_get_towns_starting_with`(start_string VARCHAR(10))
BEGIN
SELECT t.name AS "town_name" FROM towns AS t 
WHERE t.name LIKE CONCAT(start_string , "%")
ORDER BY t.name;
END
***
# zad 4. Employees from Town
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
SELECT e.first_name,
e.last_name 
FROM employees AS e
 
JOIN addresses AS a
ON e.address_id = a.address_id

JOIN towns as t
ON a.town_id = t.town_id

WHERE t.name = town_name
ORDER BY e.first_name, e.last_name, employee_id;
END
***

# zad 5.Salary Level Function
CREATE FUNCTION ufn_get_salary_level(employee_salary INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
        IF employee_salary < 30000 THEN RETURN "Low";
        ELSEIF  employee_salary >= 30000 AND employee_salary <= 50000 THEN RETURN "Average";
		ELSEIF  employee_salary >50000 THEN RETURN "High";
        END IF; 
END
***

# zad 6.Employees by Salary Level
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(30))
BEGIN
	IF salary_level = "Low" THEN 
			SELECT e.first_name,e.last_name 
            FROM employees AS e
            WHERE salary < 30000
            ORDER BY e.first_name DESC, e.last_name DESC;
	ELSEIF salary_level = "Average" THEN
			SELECT e.first_name,e.last_name 
            FROM employees AS e
            WHERE salary >= 30000 AND salary <= 50000
            ORDER BY e.first_name DESC, e.last_name DESC;
	ELSEIF salary_level = "High" THEN
			SELECT e.first_name,e.last_name 
            FROM employees AS e
            WHERE salary > 50000
            ORDER BY e.first_name DESC, e.last_name DESC;
    END IF;
END
***
CREATE PROCEDURE usp_get_employees_by_salary_level1(salary_level VARCHAR(30))
BEGIN
	SELECT e.first_name,e.last_name 
            FROM employees AS e
            WHERE ufn_get_salary_level(e.salary) = salary_level
            ORDER BY e.first_name DESC, e.last_name DESC;
END
***
# zad 7.Define Function-------------------------------------------------------------

CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))  
RETURNS BIT
DETERMINISTIC
BEGIN
        RETURN word REGEXP(CONCAT("^[", set_of_letters, "]+$"));
END
/* Обяснение за регекса - връща 1 ако word го има регекса и 0 ако го няма ако едно от двете е
NULL връща NULL. Съпоставяме думата със сета от букви, като след като вкараме сета в регекс
той търси съвпадение на която и да е буква от сета в думата и ако всички букви от думата
ги има връща 1 ако някоя липсва връща 0(понеже като липсва не може да маркира цялата дума)
- "^" - маркира началото на думата тук в SQL , а в сайта regex101 и май по принцип навсякъде 
        маркира начало на линия
- "$" - същото като горното само че маркира края
- "[]" - между тези скоби се поставят символите които ще мачваме
- "+" - мачва символите веднъж или много пъти 
*/
***
# zad 8.Find Full Name
CREATE PROCEDURE usp_get_holders_full_name ()
BEGIN
		SELECT CONCAT(ah.first_name," ", ah.last_name) AS "full_name"
		FROM account_holders AS ah
		ORDER BY full_name, ah.id;
END
***

# zad 9.People with Balance Higher Than-------------------------------------------------
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(supplied_number DECIMAL(19,4))
BEGIN
		SELECT ah.first_name, ah.last_name 
		FROM account_holders AS ah

		JOIN accounts AS a
		ON ah.id = a.account_holder_id

		GROUP BY ah.id
		HAVING SUM(a.balance) > supplied_number
		ORDER BY ah.id;
END
***
# zad 10.Future Value Function-------------------------------------------------
CREATE FUNCTION ufn_calculate_future_value
	(initial_sum DECIMAL(19,4) , yearly_interest_rate DOUBLE(10,4), years INT)
RETURNS DECIMAL(19,4)
DETERMINISTIC
BEGIN
		RETURN initial_sum*(pow(1+yearly_interest_rate,years));
END
***
# zad 11.Calculating Interest-------------------------------------
CREATE PROCEDURE usp_calculate_future_value_for_account
				(account_id  INT, interest_rate DECIMAL(19,4))
BEGIN
		SELECT 
		a.id AS "account_id",
		ah.first_name,
		ah.last_name,
		a.balance AS "current_balance",
		ufn_calculate_future_value(a.balance, interest_rate, 5) AS "balance_in_5_years"
		FROM account_holders AS ah

		JOIN accounts AS a
		ON ah.id = a.account_holder_id
		WHERE a.id = account_id;
END
***

# zad 12.Deposit Money ------------------------------------------------------------
CREATE PROCEDURE usp_deposit_money(account_id INT , money_amount DECIMAL(30,4)) 
BEGIN
	START TRANSACTION;
    IF  money_amount <= 0 THEN 
    ROLLBACK;
    ELSE 
		UPDATE
		account_holders AS  ah
        
		JOIN accounts AS a
		ON ah.id = a.account_holder_id
        
        SET  balance= balance + money_amount 
		WHERE a.id = account_id;
	END IF;
END
***

# zad 13.Withdraw Money---------------------------------------------------

CREATE PROCEDURE usp_withdraw_money(account_id INT , money_amount DECIMAL(30,4)) 
BEGIN
	START TRANSACTION;
    IF  money_amount < 0 OR 
		money_amount > (SELECT balance 
						FROM accounts AS a
						WHERE a.id = account_id )
	THEN 
		ROLLBACK;
    ELSE 
		UPDATE
		account_holders AS  ah
        
		JOIN accounts AS a
		ON ah.id = a.account_holder_id
        
        SET  balance = balance - money_amount 
		WHERE a.id = account_id;
	END IF;
END
***
# zad 14.Money Transfer ---------------------------------------------------------------
CREATE PROCEDURE usp_transfer_money(from_account_id INT,
									to_account_id INT,
                                    money_amount DECIMAL(30,4)) 
BEGIN
	START TRANSACTION;
	CASE WHEN ((SELECT a.id FROM accounts as a WHERE a.id = from_account_id) IS NULL)
			OR ((SELECT a.id FROM accounts as a WHERE a.id = to_account_id) IS NULL)
            OR from_account_id = to_account_id
            OR amount < 0 
			OR amount > (SELECT a.balance FROM accounts as a
				     WHERE a.id = from_account_id)
		THEN ROLLBACK;
	ELSE
		CALL usp_withdraw_money(from_account_id,money_amount);
		CALL usp_deposit_money(to_account_id,money_amount);
	END CASE;
END
***

# zad 15.Log Accounts Trigger -----------------------------------------------------------
CREATE TABLE `logs`(
log_id INT PRIMARY KEY AUTO_INCREMENT,
account_id INT NOT NULL,
old_sum DECIMAL(20,4) NOT NULL,
new_sum DECIMAL(20,4) NOT NULL);

CREATE TRIGGER log_balance_changes AFTER UPDATE ON accounts 
FOR EACH ROW
BEGIN
	CASE WHEN OLD.balance != NEW.balance THEN 
		INSERT INTO `logs`(account_id, old_sum, new_sum)
		VALUES (OLD.id, OLD.balance, NEW.balance);
	ELSE
		BEGIN END;
	END CASE;
END
***

# zad 16.Emails Trigger-------------------------------------------------------
CREATE TABLE `logs`(
log_id INT PRIMARY KEY AUTO_INCREMENT,
account_id INT NOT NULL,
old_sum DECIMAL(20,4) NOT NULL,
new_sum DECIMAL(20,4) NOT NULL);

CREATE TRIGGER log_balance_changes AFTER UPDATE ON accounts 
FOR EACH ROW
BEGIN
	CASE WHEN OLD.balance != NEW.balance THEN 
		 INSERT INTO `logs`(account_id, old_sum, new_sum)
		 VALUES (OLD.id, OLD.balance, NEW.balance);
	ELSE
		BEGIN END;
	END CASE;
END;

CREATE TABLE notification_emails(
id INT PRIMARY KEY AUTO_INCREMENT,
recipient INT NOT NULL,
subject VARCHAR(50) NOT NULL,
body TEXT NOT NULL);

CREATE TRIGGER create_notification_email AFTER INSERT ON `logs` 
FOR EACH ROW
BEGIN 
	INSERT INTO notification_emails (recipient, subject, body)
	VALUES (NEW.account_id, CONCAT('Balance change for account: ', NEW.account_id),
	CONCAT('On ', DATE_FORMAT(NOW(), '%b %d %Y'), ' at ', DATE_FORMAT(NOW(), '%r'),
	' your account balance was changed from ', NEW.old_sum, ' to ', NEW.new_sum, '.'));
END
***

