Solution Exercise 5

# zad 1
CREATE SCHEMA `exercise_1`;
DROP TABLE `passports`;

CREATE TABLE `passports`(
`passport_id` INT AUTO_INCREMENT UNIQUE NOT NULL,
`passport_number` VARCHAR(50) NOT NULL,
 PRIMARY KEY `pk_passports` (`passport_id`)
)AUTO_INCREMENT = 100;

CREATE TABLE `people`(
`person_id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(50) NOT NULL,
`salary` DECIMAL(10, 2) NOT NULL DEFAULT 0,
`passport_id` INT NOT NULL UNIQUE,
CONSTRAINT `fk_passport_id`
FOREIGN KEY (`passport_id`)
REFERENCES `passports`(`passport_id`)
);

INSERT INTO `passports`(`passport_id`, `passport_number`) VALUES
(101, "N34FG21B"),
(102, "K65LO4R7"),
(103, "ZE657QP2");

INSERT INTO `people`(person_id,	first_name,	salary,	passport_id) VALUES
(1, "Roberto", 43300.00, 102),
(2, "Tom", 56100.00, 103),
(3, "Yana", 60200.00, 101);

# zad 2
CREATE TABLE `manufacturers`(
`manufacturer_id` INT PRIMARY KEY AUTO_INCREMENT ,
`name` VARCHAR(50) NOT NULL , 
`established_on` DATE NOT NULL 
);

CREATE TABLE `models`(
`model_id` INT PRIMARY KEY AUTO_INCREMENT ,
`name` VARCHAR(50) NOT NULL ,
`manufacturer_id` INT NOT NULL,
CONSTRAINT `fk_manufacturer_id`
FOREIGN KEY (`manufacturer_id`)
REFERENCES `manufacturers`(`manufacturer_id`)
)AUTO_INCREMENT = 100;

INSERT INTO `manufacturers` VALUES
(1, "BMW", "1916-03-01"),
(2,	"Tesla", "2003-01-01"),
(3,	"Lada", "1966-05-01");

INSERT INTO `models` (`model_id`,	`name`,	`manufacturer_id`) VALUES
(101, "X1", 1),
(102, "i6",	1),
(103, "Model S", 2),
(104, "Model X", 2),
(105, "Model 3", 2),
(106, "Nova", 3);


# zad 3
CREATE TABLE `students`(
`student_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);

CREATE TABLE `exams`(
`exam_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
)AUTO_INCREMENT = 100;

CREATE TABLE `students_exams`(
`student_id` INT ,
`exam_id` INT,
PRIMARY KEY `pk_students_exams`(`student_id`, `exam_id`),
CONSTRAINT `fk_students_id`
FOREIGN KEY (`student_id`)
REFERENCES `students`(`student_id`),
CONSTRAINT `fk_exams_id`
FOREIGN KEY (`exam_id`)
REFERENCES `exams`(`exam_id`)
);

INSERT INTO `students` VALUES
(1,	"Mila"),                                      
(2, "Toni"),
(3,	"Ron");

INSERT INTO `exams` VALUES
(101, "Spring MVC"),
(102, "Neo4j"),
(103, "Oracle 11g");

INSERT INTO `students_exams` VALUES
(1,	101),
(1,	102),
(2,	101),
(3,	103),
(2,	102),
(2,	103);


# zad 4
CREATE TABLE `teachers` (
`teacher_id` INT PRIMARY KEY,
`name` VARCHAR(30) NOT NULL ,
`manager_id` INT DEFAULT NULL
);

INSERT INTO `teachers`(`teacher_id`, `name`, `manager_id`) VALUES
(101, "John",NULL),	
(102, "Maya", 106),
(103, "Silvia", 106),
(104, "Ted", 105),
(105, "Mark", 101),
(106, "Greta", 101);

ALTER TABLE `teachers`
ADD CONSTRAINT `fk_manager_teacher`
FOREIGN KEY (`manager_id`)
REFERENCES `teachers`(`teacher_id`);

# zad 5
CREATE TABLE `item_types` (
`item_type_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE `items` (
`item_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`item_type_id` INT,
CONSTRAINT `fk_item_types_id`
FOREIGN KEY (`item_type_id`)
REFERENCES `item_types`(`item_type_id`)
);

CREATE TABLE `cities`(
`city_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE `customers`(
`customer_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`birthday` DATE NOT NULL,
`city_id` INT ,
CONSTRAINT `fk_customers_cities`
FOREIGN KEY (`city_id`)
REFERENCES `cities`(`city_id`)
);

CREATE TABLE `orders`(
`order_id` INT PRIMARY KEY AUTO_INCREMENT,
`customer_id` INT,
CONSTRAINT `fk_orders_customers`
FOREIGN KEY (`customer_id`)
REFERENCES `customers`(`customer_id`)
);

CREATE TABLE `order_items`(
`order_id` INT ,
`item_id` INT,
PRIMARY KEY `pk_sorder_items`(`order_id`, `item_id`),
CONSTRAINT `fk_order_item_orders`
FOREIGN KEY (`order_id`)
REFERENCES `orders`(`order_id`),

CONSTRAINT `fk_order_item_items`
FOREIGN KEY (`item_id`)
REFERENCES `items`(`item_id`)
);

# zad 6

CREATE TABLE `majors`(
`major_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) 
);

CREATE TABLE `students`(
`student_id` INT PRIMARY KEY  AUTO_INCREMENT,
`student_number` VARCHAR(12) ,
`student_name` VARCHAR(50) ,
`major_id` INT,
CONSTRAINT `fk_students_majors`
FOREIGN KEY (`major_id`)
REFERENCES `majors`(`major_id`)
);

CREATE TABLE `payments`(
`payment_id` INT PRIMARY KEY  AUTO_INCREMENT,
`payment_date` DATE ,
`payment_amount` DECIMAL (8,2),
`student_id` INT,
CONSTRAINT `fk_payments_students`
FOREIGN KEY (`student_id`)
REFERENCES `students`(`student_id`)
);

CREATE TABLE `subjects`(
`subject_id` INT PRIMARY KEY  AUTO_INCREMENT,
`subjects_name` VARCHAR(50) 
);

CREATE TABLE `agenda`(
`student_id` INT ,
`subject_id` INT,
PRIMARY KEY `pk_agenda`(`student_id`, `subject_id`),

CONSTRAINT `fk_agenda_students`
FOREIGN KEY (`student_id`)
REFERENCES `students`(`student_id`),

CONSTRAINT `fk_agenda_subjects`
FOREIGN KEY (`subject_id`)
REFERENCES `subjects`(`subject_id`)
);

# zad 9
SELECT 
m.`mountain_range`,
p.`peak_name`,
p.`elevation` AS peak_elevation
 FROM `peaks` AS p
 JOIN `mountains` AS m
 ON p.`mountain_id` = m.`id`
 WHERE `mountain_range` LIKE "Rila"
 ORDER BY `peak_elevation` DESC;

