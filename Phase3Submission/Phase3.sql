/*
The first section of this sql doc contains the entirety of our CREATE
TABLE statements from the phase two submission, followed by the phase
3 operations. The SELECT statements chosen for this phase were designed
and written partially by each member of the group (Dylan Binu, Grant Finn,
Travis Justice, and Adam Mizgalski).
*/

-- DROP TABLE Player;
-- DROP TABLE CoachStaff;
-- DROP TABLE Team;
-- DROP TABLE Conference;

CREATE TABLE Conference(
confName CHAR(3),

PRIMARY KEY(confName)
);

CREATE TABLE Team(
teamName VARCHAR(15), 
teamLocation VARCHAR(20),
yearEst CHAR(4),
confName CHAR(3),
teamDivision CHAR(1),

PRIMARY KEY(teamName)
);

CREATE TABLE CoachStaff(
coachName VARCHAR(25),
coachID INT,
salary NUMERIC(9,2),
coachRole VARCHAR(20),
teamName VARCHAR(15),

FOREIGN KEY (teamName) REFERENCES Team,

PRIMARY KEY(coachID)
);

CREATE TABLE Player(
playerName VARCHAR(25),
playerID INT,
playerNum INT,
position VARCHAR(20),
college VARCHAR(30),
teamName VARCHAR(15),

FOREIGN KEY (teamName) REFERENCES Team,

PRIMARY KEY (playerID)
);

/*
Scenario 1: Player Search. User wants to look up the players in a given team to 
see their names,numbers, positions, etc. In this application, the user could 
enter a valid team name into a search bar-type user interface that would bring 
up a resulting table containing every player on the Salt Lake City Mountain
Ducks.
*/

SELECT *
FROM Player NATURAL JOIN Team
WHERE teamName = 'Mountain ducks'
ORDER BY playerName;

/*
Scenario 2: Coaching Staff Search. User wants to know who coaches the African
Skinks, their respective salaries, coaching roles, and their coach ID numbers.
This application would allow the user to enter a team name into a "coach search"
that would then bring up every coach on that team, as well as corresponding data
*/

SELECT *
FROM CoachStaff NATURAL JOIN Team
WHERE teamName = 'African skinks'
ORDER BY coachRole;

/*
Scenario 3: Position Search. This user wants to know the names and player ID's
of every offensive player in a chosen league/conference. The user would enter
a position (in this scenario, "Offense"), and the interface would bring up a
table of every player from every team that plays the chosen position.
*/

SELECT *
FROM Team NATURAL JOIN Player
WHERE position = 'Offense'
ORDER BY teamName;

/*
Scenario 4: Coach Role Search. This user wants to compare the salaries of every 
head coach in the league. This search tool would allow the user to enter a 
coach role (e.g., "Head Coach") and the resulting table would show every coach 
of the selected role, their respective teams, their salaries, and all other 
information from the two tables.
*/

SELECT *
FROM CoachStaff NATURAL JOIN Team
WHERE coachRole = 'Head Coach'
ORDER BY coachName;

/*
Scenario 5: Average Coach Salary by Team.
*/

SELECT DISTINCT teamName, ROUND(AVG(salary),2) AS AVGSALARY
FROM CoachStaff
GROUP BY teamName
ORDER BY teamName;

/*
Scenario 6: Full Team Roster including players and coaching staff.
*/

(SELECT Player.playerName as name, 'Player' as role, Player.position as position
FROM Team NATURAL JOIN Player
WHERE teamName = 'Frogs') UNION (
SELECT CoachStaff.coachName as name, 'Coach', CoachStaff.coachRole as position
FROM Team NATURAL JOIN CoachStaff
WHERE teamName = 'Frogs')
ORDER BY role, position;


-- Scenario 7: Teams established in or before a certain year.

SELECT teamName, yearEst
FROM Team
WHERE yearEst <= 2000;

-- Scenario 8: Teams in a certain division

SELECT teamName, teamDivision
FROM Team
WHERE teamDivision = 'S';

/*
Scenario 9: Find all coaches and players for a given position.
*/

(SELECT Player.playerName as name, 'Player' as role, Player.position as position
FROM Team NATURAL JOIN Player
WHERE position = 'Offense' AND teamName = 'Herons') UNION (
SELECT CoachStaff.coachName as name, 'Coach', CoachStaff.coachRole as position
FROM Team NATURAL JOIN CoachStaff
WHERE (coachRole = 'Offensive Coordinator' OR coachRole = 'Head Coach') AND teamName = 'Herons')
ORDER BY role, position;