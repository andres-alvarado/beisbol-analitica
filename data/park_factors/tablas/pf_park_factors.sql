DROP TABLE pf_park_factors;

CREATE TABLE pf_park_factors (
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  venueId INTEGER,
  teamId INTEGER,
  homeGames INTEGER,
  runsScoredHome INTEGER,
  runsAllowedHome INTEGER,
  awayGames INTEGER,
  runsScoredAway INTEGER,
  runsAllowedAway INTEGER,
  runsParkFactor DOUBLE
) ;

ALTER TABLE pf_park_factors ADD INDEX(majorLeagueId);
ALTER TABLE pf_park_factors ADD INDEX(seasonId);
ALTER TABLE pf_park_factors ADD INDEX(venueId);