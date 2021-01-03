USE baseball;

DROP TABLE stg_game_context;

CREATE TABLE stg_game_context (
  gamePk INTEGER,
  gameType VARCHAR(100),
  majorLeague VARCHAR(20),
  majorLeagueId INTEGER,
  season VARCHAR(100),
  gameDate VARCHAR(100),
  isTie TINYINT,
  gameNumber INTEGER,
  publicFacing TINYINT,
  doubleHeader VARCHAR(100),
  gamedayType VARCHAR(100),
  tiebreaker VARCHAR(100),
  calendarEventID VARCHAR(100),
  seasonDisplay VARCHAR(100),
  dayNight VARCHAR(100),
  description VARCHAR(400),
  scheduledInnings INTEGER,
  gamesInSeries INTEGER,
  seriesGameNumber INTEGER,
  seriesDescription VARCHAR(100),
  recordSource VARCHAR(100),
  ifNecessary VARCHAR(100),
  ifNecessaryDescription VARCHAR(100),
  gameId VARCHAR(100),
  abstractGameState VARCHAR(100),
  codedGameState VARCHAR(100),
  detailedState VARCHAR(100),
  statusCode VARCHAR(100),
  abstractGameCode VARCHAR(100),
  awayWins INTEGER,
  awayLosses INTEGER,
  awayPct VARCHAR(100),
  awayScore INTEGER,
  awayId INTEGER,
  awayName VARCHAR(100),
  awayIsWinner TINYINT,
  homeWins INTEGER,
  homeLosses INTEGER,
  homePct VARCHAR(100),
  homeScore INTEGER,
  homeId INTEGER,
  homeName VARCHAR(100),
  homeIsWinner TINYINT,
  venueId INTEGER,
  venueName VARCHAR(100),
  venueLink VARCHAR(100)
) ENGINE = INNODB;
