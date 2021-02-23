DROP TABLE pf_park_factors;

CREATE TABLE pf_park_factors (
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  venueId INTEGER,
  teamId INTEGER,
  homeGames INTEGER,
  homeScored INTEGER,
  homeAllowed INTEGER,
  awayGames INTEGER,
  awayScored INTEGER,
  awayAllowed INTEGER,
  runParkFactor DOUBLE
) ;

ALTER TABLE pf_park_factors ADD INDEX(majorLeagueId);
ALTER TABLE pf_park_factors ADD INDEX(seasonId);
ALTER TABLE pf_park_factors ADD INDEX(venueId);