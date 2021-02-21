USE baseball;

DROP TABLE rem_event_run_value;

CREATE TABLE IF NOT EXISTS rem_event_run_value (
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  event VARCHAR(100),
  startRunExpectancy DOUBLE,
  runsScoredInPlay DOUBLE,
  endRunExpectancy DOUBLE,
  events INTEGER,
  runValue DOUBLE
);

ALTER TABLE rem_event_run_value ADD INDEX(majorLeagueId, seasonId);
