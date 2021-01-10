USE baseball;

DROP TABLE we_win_expectancy;

CREATE TABLE IF NOT EXISTS we_win_expectancy (
  grouping_id INTEGER UNSIGNED,
  grouping_description VARCHAR(255),
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  gameType2 VARCHAR(10),
  venueId INTEGER,
  battingTeamId INTEGER,
  pitchingTeamId INTEGER,
  inning INTEGER,
  runnersBeforePlay VARCHAR(3),
  outsBeforePlay INTEGER,
  perspective VARCHAR(20),
  score_difference INTEGER,
  games INTEGER,
  wins INTEGER,
  losses INTEGER,
  win_expectancy DOUBLE
);

ALTER TABLE we_win_expectancy ADD INDEX( grouping_id );
