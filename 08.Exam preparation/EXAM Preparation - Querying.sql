-- 5.Players
SELECT 
first_name,
age,
salary 
FROM players 
ORDER BY salary DESC;

-- 6.Young offense players without contract
SELECT 
p.id,
concat(p.first_name, " ", p.last_name) AS "full_name",
p.age,
p.position,
p.hire_date
FROM players AS p

JOIN skills_data AS sd
ON p.skills_data_id = sd.id
WHERE age < 23 AND position = "A" AND hire_date IS NULL AND sd.strength > 50
ORDER BY p.salary , p.age;

-- 7.Detail info for all teams

SELECT 
t.name AS "team_name",
t.established,
t.fan_base,
COUNT(p.id) AS "player_count"
FROM teams AS t
LEFT JOIN players AS p
ON t.id = p.team_id
GROUP BY t.id
ORDER BY player_count DESC, t.fan_base DESC;

-- 8.The fastest player by towns

SELECT 
MAX(sd.speed) AS "max_speed",
tw.name AS "town_name" 
FROM players AS p

RIGHT JOIN skills_data AS sd
ON p.skills_data_id = sd.id

RIGHT JOIN teams AS t
ON p.team_id = t.id

RIGHT JOIN stadiums AS s
ON t.stadium_id = s.id

RIGHT JOIN towns AS tw
ON s.town_id = tw.id
WHERE t.name != "Devify" 
GROUP BY tw.name
ORDER BY max_speed DESC, tw.name;

-- 9.	Total salaries and players by country

SELECT 
c.name AS "name",
COUNT(p.id) AS "total_count_of_players",
SUM(p.salary) AS "total_sum_of_salaries"
FROM players AS p

LEFT JOIN teams AS t
ON p.team_id = t.id

LEFT JOIN stadiums AS s
ON t.stadium_id = s.id

LEFT JOIN towns AS tw
ON s.town_id = tw.id

RIGHT JOIN countries AS c
ON tw.country_id = c.id


GROUP BY c.name
ORDER BY total_count_of_players DESC, c.name;