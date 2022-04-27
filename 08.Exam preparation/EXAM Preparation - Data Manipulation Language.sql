-- 2.insert
INSERT INTO coaches (first_name, last_name, salary, coach_level)
SELECT 
p.first_name,
p.last_name,
p.salary * 2,
char_length(p.first_name)
 FROM 
players AS p 
WHERE p.age >= 45;

-- 3.update

UPDATE coaches AS c
JOIN players_coaches AS pc
ON c.id = pc.coach_id

JOIN players AS p
ON pc.player_id = p.id

SET coach_level = coach_level + 1
WHERE c.first_name LIKE ("A%") ;

-- 4.Delete
DELETE FROM players AS p
WHERE p.age >= 45 ;
