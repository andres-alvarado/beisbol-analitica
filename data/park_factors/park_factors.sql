USE baseball;

DROP TABLE park_factors;

CREATE TABLE park_factors (
  groupingId INTEGER UNSIGNED,
  groupingDescription VARCHAR(255)
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  venueId INTEGER,
  runsScoredHome INTEGER,
  runsAllowedHome INTEGER,
  runsScoredAway INTEGER,
  runsAllowedAway INTEGER,
  homeGames INTEGER,
  awayGames INTEGER,
  runParkFactor DOUBLE
) ;

ALTER TABLE park_factors ADD INDEX(grouping_id);