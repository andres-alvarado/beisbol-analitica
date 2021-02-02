DROP TABLE agg_fielding_stats;

CREATE TABLE agg_fielding_stats (
  grouping_id INTEGER UNSIGNED,
  grouping_description VARCHAR(255),
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  gameType2 VARCHAR(10),
  teamType VARCHAR(10),
  venueId INTEGER,
  teamId INTEGER,
  playerId INTEGER,
  games INTEGER,
  chances INTEGER,
  assists INTEGER,
  if_assists INTEGER,
  of_assists INTEGER,
  putOuts INTEGER,
  errors INTEGER,
  fieldingPercentage DOUBLE,
) 

ALTER TABLE agg_fielding_stats ADD INDEX(grouping_id);
