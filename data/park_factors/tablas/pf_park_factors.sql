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
  runsParkFactor DOUBLE,
  HRhitHome INTEGER,
  HRhitAway INTEGER,
  HRallowedHome INTEGER,
  HRallowedAway INTEGER,
  HRparkFactor DOUBLE,
  hitsBattedHome INTEGER,
  hitsBattedAway INTEGER,
  hitsAllowedHome INTEGER,
  hitsAllowedAway INTEGER,
  hitsParkFactor DOUBLE,
  doublesHitHome INTEGER,
  doublesHitAway INTEGER,
  doublesAllowedHome INTEGER,
  doublesAllowedAway INTEGER,
  doublesParkFactor DOUBLE,
  triplesHitHome INTEGER,
  triplesHitAway INTEGER,
  triplesAllowedHome INTEGER,
  triplesAllowedAway INTEGER,
  triplesParkFactor DOUBLE,
  strikeoutsReceivedHome INTEGER,
  strikeoutsReceivedAway INTEGER,
  strikeoutsThrowedHome INTEGER,
  strikeoutsThrowedAway INTEGER,
  strikeoutsParkFactor DOUBLE,
  walksReceivedHome INTEGER,
  walksReceivedAway INTEGER,
  walksAllowedHome INTEGER,
  walksAllowedAway INTEGER,
  walksParkFactor DOUBLE
) ;

ALTER TABLE pf_park_factors ADD INDEX(majorLeagueId);
ALTER TABLE pf_park_factors ADD INDEX(seasonId);
ALTER TABLE pf_park_factors ADD INDEX(venueId);
