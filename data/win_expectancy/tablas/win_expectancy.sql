USE baseball;

DROP TABLE we_win_expectancy;

CREATE TABLE IF NOT EXISTS we_win_expectancy (
  groupingId INTEGER UNSIGNED,
  groupingDescription VARCHAR(255),
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  startSeason INTEGER,
  endSeason INTEGER,
  gameType2 VARCHAR(10),
  venueId INTEGER,
  battingTeamId INTEGER,
  pitchingTeamId INTEGER,
  inning INTEGER,
  halfInning VARCHAR(10),
  runnersBeforePlay VARCHAR(3),
  menOnBaseBeforePlay VARCHAR(10),
  outsBeforePlay INTEGER,
  perspective VARCHAR(20),
  scoreDifference INTEGER,
  games INTEGER,
  wins INTEGER,
  losses INTEGER,
  winExpectancy DOUBLE
);

ALTER TABLE we_win_expectancy ADD INDEX( groupingId );
