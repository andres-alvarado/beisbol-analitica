DROP TABLE pf_park_factors;

CREATE TABLE pf_park_factors (
  groupingId INTEGER,
  groupingDescription VARCHAR(255),
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  venueId INTEGER,
  teamId INTEGER,
  homeGames INTEGER,
  awayGames INTEGER,
  runsScoredHome INTEGER,
  runsAllowedHome INTEGER,
  runsScoredAway INTEGER,
  runsAllowedAway INTEGER,
  singlesScoredHome INTEGER,
  singlesAllowedHome INTEGER,
  singlesScoredAway INTEGER,
  singlesAllowedAway INTEGER,
  doublesScoredHome INTEGER,
  doublesAllowedHome INTEGER,
  doublesScoredAway INTEGER,
  doublesAllowedAway INTEGER,
  triplesScoredHome INTEGER,
  triplesAllowedHome INTEGER,
  triplesScoredAway INTEGER,
  triplesAllowedAway INTEGER,
  homeRunsScoredHome INTEGER,
  homeRunsAllowedHome INTEGER,
  homeRunsScoredAway INTEGER,
  homeRunsAllowedAway INTEGER,
  runsParkFactor DOUBLE,
  singlesParkFactor DOUBLE,
  doublesParkFactor DOUBLE,
  triplesParkFactor DOUBLE,
  homeRunsParkFactor DOUBLE
);

ALTER TABLE pf_park_factors ADD INDEX(groupingId);
ALTER TABLE pf_park_factors ADD INDEX(groupingDescription);
ALTER TABLE pf_park_factors ADD INDEX(majorLeagueId);
ALTER TABLE pf_park_factors ADD INDEX(seasonId);
ALTER TABLE pf_park_factors ADD INDEX(venueId);
