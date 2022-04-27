-- 10.Find all players that play on stadium
DELIMITER ***
CREATE FUNCTION udf_stadium_players_count (stadium_name VARCHAR(30)) 
RETURNS INT
DETERMINISTIC
BEGIN
RETURN (SELECT COUNT(p.id)  
FROM stadiums AS s

JOIN teams AS t
ON s.id = t.stadium_id

JOIN players AS p 
ON t.id = p.team_id

WHERE s.name = stadium_name
GROUP BY s.id);
END
***
