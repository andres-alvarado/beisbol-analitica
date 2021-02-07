USE baseball;

DROP TABLE rem_run_expectancy_matrix;

CREATE TABLE IF NOT EXISTS rem_run_expectancy_matrix (
  groupingId INTEGER UNSIGNED,
  groupingDescription VARCHAR(255),
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  venueId INTEGER,
  runnersBeforePlay VARCHAR(3),
  zeroOut DOUBLE,
  oneOut DOUBLE,
  twoOut DOUBLE,
  startSeason INTEGER,
  endSeason INTEGER,
  sortingOrder INTEGER
);

ALTER TABLE rem_run_expectancy_matrix ADD INDEX(groupingId);
ALTER TABLE rem_run_expectancy_matrix ADD INDEX(majorLeagueId, seasonId, venueId);
