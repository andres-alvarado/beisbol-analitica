DROP TABLE agg_fielding_stats;

CREATE TABLE agg_fielding_stats (
  groupingId INTEGER UNSIGNED,
  groupingDescription VARCHAR(255),
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  gameType2 VARCHAR(10),
  teamType VARCHAR(10),
  venueId INTEGER,
  teamId INTEGER,
  positionAbbrev VARCHAR(10),
  playerId INTEGER,
  assists INTEGER,
  catcherInterferences INTEGER,
  errors INTEGER,
  games INTEGER,
  putOuts INTEGER,
  totalChances INTEGER,
  outsPlayed INTEGER,
  inningsPlayed DOUBLE,
  gamesPlayed DOUBLE,
  fieldingPercentage DOUBLE,
  rangeFactorPerInning DOUBLE,
  rangeFactorPerGame DOUBLE
);

ALTER TABLE agg_fielding_stats ADD INDEX(groupingId);
ALTER TABLE agg_fielding_stats ADD INDEX(majorLeagueId);
ALTER TABLE agg_fielding_stats ADD INDEX(seasonId);
ALTER TABLE agg_fielding_stats ADD INDEX(venueId);
ALTER TABLE agg_fielding_stats ADD INDEX(teamId);
ALTER TABLE agg_fielding_stats ADD INDEX(playerId);
