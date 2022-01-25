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

-- E/R Schema, SQL statements, and sample data were collected and updated as a group effort by Grant Finn, Dylan Binu, Adam Mizgalski, and Travis Justice.