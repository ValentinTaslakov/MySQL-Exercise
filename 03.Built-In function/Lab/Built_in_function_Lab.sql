
Решения на задачите от Лаб 03

# ZAD 1
SELECT `title` FROM `books`
WHERE `title` LIKE "The%";

SELECT 
    `title`
FROM
    `books`
WHERE
    SUBSTRING(`title`, 1, 3) = 'The'; 

# zad 2
SELECT 
    REPLACE(`title`, 'The', '***')
    AS "Title"
FROM
    `books`
    WHERE substring(`title`, 1, 3) = "The";
    
# Zad 3
SELECT 
    ROUND(SUM(`cost`), 2)
FROM
    `books`;
    
# zad 4
SELECT 
    CONCAT_WS(' ',
            `first_name`,
            `last_name`) AS `Full name`,
    TIMESTAMPDIFF(DAY, `born`, `died`) AS `Dsys Lived`
FROM
    `authors`;
    
# zad 5

SELECT `title` FROM `books`
WHERE `title` LIKE "Harry%";