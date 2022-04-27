# zad 1 

CREATE TABLE `mountains`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL
);

CREATE TABLE `peaks`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
`mountain_id` INT,
CONSTRAINT `fk_mountain_peaks`
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains`(`id`)
);

# zad 2
SELECT 
    v.`driver_id`, `vehicle_type`,
    CONCAT(c.`first_name`, " ", c.`last_name`) AS "driver_name"
FROM
    `vehicles` AS v
JOIN `campers` AS c
ON v.`driver_id` = c.`id`;

# zad 3

SELECT r.`starting_point` AS "route_starting_point" , 
r.`end_point` AS "route_ending_point",
r.`leader_id` ,
CONCAT(c.`first_name`, " ", c.`last_name`) AS "leader_name"
FROM `routes` AS r
JOIN `campers` AS c
ON  c.`id` = r.`leader_id`;

/* За да видя връзките м/у таблиците - избирам една от таблиците и гледам дали има foreign key 
ако има цъкам върху него  и долу в полето информация пише 
таргет-> първо е таблицата с която е свързана тази 
после в скобите първо е колоната от тази таблица а после е колоната от другата.
Първо започвам с таблицата която има FOREIGN KEY към другата(гледам двете таблици които са
ми нужни) избирам полетата и при FROM давам -> `routes` AS r
давам по кратко име и пред колоните от тази таблица го слагам (r.`starting_point`) след 
това иползвам (JOIN) и посочвам таблицата към която реферира ключа (`campers` AS c)
като пак и давам по кратко име , следва задължително (ON) -> посочваме критерия на свързване 
 (c.`id` = r.`leader_id`) а именно колоната от едната таблица и колоната от другата
 (тези които са свързани)
*/

# zad 4
DROP TABLE `peaks`;
DROP TABLE `mountains`;

CREATE TABLE `mountains`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL 
);

CREATE TABLE `peaks`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`mountain_id` INT, 
CONSTRAINT `fk_mountain_id`
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains`(`id`)
ON DELETE CASCADE  ON UPDATE CASCADE
);
/* Когато по условие ни е дадено да създадем таблица и за нея ни е дадено 
да направим колона с името на друга таблица и допълнение id значи трябва в 
в тази таблица да се направи FOREIGN KEY към id-то на другата 
Когато даваме име на FOREIGN KEY-а при създаване -> fk_mountain_id - първо 
е абревиатурата fk че е FOREIGN KEY второ пишем таблицата с която се 
свързваме и накрая колоната (най-често тази колона е първичния ключ на таблицата)
ON DELETE CASCADE и ON UPDATE CASCADE се пишат когато искаме да трием или променяме каскадно
Или когато правим промяна в един обект тази промяна се прилага за всички свързани обекти 
При тази задача първо правим таблица с планини после правим таблица с върхове, 
като тези върхове трябва да се намират в някоя планина затова правим връзка от 
табл.Върхове към табл.Планини и ако изтрием някоя планина , то каскадно се трие 
и въховете свързани с нея
*/

