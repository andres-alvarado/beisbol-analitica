USE baseball;

DROP TABLE rem_play_by_play;
DROP TABLE rem_run_expectancy_matrix;
DROP TABLE rem_event_run_value;

CREATE TABLE IF NOT EXISTS rem_play_by_play (
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  venueId INTEGER,
  gamePk INTEGER,
  inning INTEGER,
  halfInning VARCHAR(15),
  atBatIndex INTEGER,
  playIndex INTEGER,
  event VARCHAR(100),
  runnersBeforePlay VARCHAR(3),
  runsScoredBeforePlay INTEGER,
  outsBeforePlay INTEGER,
  runsScoredInPlay INTEGER,
  outsInPlay INTEGER,
  runsScoredAfterPlay INTEGER,
  outsAfterPlay INTEGER,
  runnersAfterPlay VARCHAR(3),
  runsScoredEndInning INTEGER
);

ALTER TABLE rem_play_by_play ADD INDEX(gamePk, atBatIndex, playIndex);

CREATE TABLE IF NOT EXISTS rem_run_expectancy_matrix (
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  runnersBeforePlay VARCHAR(3),
  zeroOut DOUBLE,
  oneOut DOUBLE,
  twoOut DOUBLE,
  sortingOrder INTEGER
);

ALTER TABLE rem_run_expectancy_matrix ADD INDEX(majorLeagueId, seasonId);

CREATE TABLE IF NOT EXISTS rem_event_run_value (
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  event VARCHAR(100),
  startRunExpectancy DOUBLE,
  runsScoredInPlay DOUBLE,
  endRunExpectancy DOUBLE,
  runsScoredEndInning DOUBLE,
  runValue DOUBLE
);

ALTER TABLE rem_event_run_value ADD INDEX(majorLeagueId, seasonId);
