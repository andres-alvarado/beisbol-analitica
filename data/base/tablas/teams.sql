USE baseball;

DROP TABLE teams;

CREATE TABLE teams (
  leagueId VARCHAR(10),
  divisionId INTEGER,
  seasonId VARCHAR(20),
  teamId INTEGER,
  venueId INTEGER,
  teamAbbreviation VARCHAR(10),
  teamCode VARCHAR(10),
  teamShortName VARCHAR(100),
  teamFullName VARCHAR(100),
  teamName VARCHAR(100),
  leagueName VARCHAR(100),
  venueName VARCHAR(100),
  locationName VARCHAR(100)
) ENGINE = INNODB;

ALTER TABLE teams ADD PRIMARY KEY(leagueId, seasonId, teamId);
