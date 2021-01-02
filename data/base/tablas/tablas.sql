USE baseball;

DROP TABLE players;
DROP TABLE game_player_batting_stats;
DROP TABLE game_player_fielding_stats;
DROP TABLE game_player_pitching_stats;
DROP TABLE teams;
DROP TABLE atbats;
DROP TABLE pitches;
DROP TABLE runners;
DROP TABLE game_player_positions;
DROP TABLE fielding_credits;
DROP TABLE actions;
DROP TABLE pickoffs;
DROP TABLE games;
DROP TABLE batting_orders;

CREATE TABLE players (
  playerId INTEGER,
  firstName VARCHAR(100),
  lastName VARCHAR(100),
  birthDate VARCHAR(100),
  birthCity VARCHAR(100),
  birthStateProvince VARCHAR(100),
  birthCountry VARCHAR(100),
  strikeZoneTop DOUBLE,
  strikeZoneBottom DOUBLE,
  positionAbbrev VARCHAR(10),
  batSide VARCHAR(10),
  pitchHand VARCHAR(10)
) ENGINE = INNODB;

ALTER TABLE players ADD PRIMARY KEY(playerId);

CREATE TABLE game_player_batting_stats (
  gamePk INTEGER,
  teamId INTEGER,
  teamType VARCHAR(10),
  playerId INTEGER,
  atBats INTEGER,
  walks INTEGER,
  catchersInterference INTEGER,
  caughtStealing INTEGER,
  doubles INTEGER,
  flyOuts INTEGER,
  groundIntoDoublePlay INTEGER,
  groundIntoTriplePlay INTEGER,
  groundOuts INTEGER,
  hitByPitch INTEGER,
  hits INTEGER,
  homeRuns INTEGER,
  intentionalWalks INTEGER,
  leftOnBase INTEGER,
  pickoffs INTEGER,
  plateAppearances INTEGER,
  rbi INTEGER,
  runs INTEGER,
  sacBunts INTEGER,
  sacFlies INTEGER,
  singles INTEGER,
  stolenBases INTEGER,
  strikeOuts INTEGER,
  totalBases INTEGER,
  triples INTEGER,
  unintentionalWalks INTEGER
) ENGINE = INNODB;

ALTER TABLE game_player_batting_stats ADD PRIMARY KEY(gamePk, teamId, playerId);

CREATE TABLE game_player_fielding_stats (
  gamePk INTEGER,
  teamId INTEGER,
  teamType VARCHAR(10),
  playerId INTEGER,
  assists INTEGER,
  caughtStealing INTEGER,
  chances INTEGER,
  errors INTEGER,
  passedBall INTEGER,
  pickoffs INTEGER,
  putOuts INTEGER,
  stolenBases INTEGER
) ENGINE = INNODB;

ALTER TABLE game_player_fielding_stats ADD PRIMARY KEY(gamePk, teamId, playerId);

CREATE TABLE game_player_pitching_stats (
  gamePk INTEGER,
  teamId INTEGER,
  teamType VARCHAR(10),
  playerId INTEGER,
  airOuts INTEGER,
  atBats INTEGER,
  balls INTEGER,
  walks INTEGER,
  battersFaced INTEGER,
  blownSaves INTEGER,
  catchersInterference INTEGER,
  caughtStealing INTEGER,
  completeGames INTEGER,
  doubles INTEGER,
  earnedRuns INTEGER,
  gamesFinished INTEGER,
  gamesPitched INTEGER,
  gamesPlayed INTEGER,
  gamesStarted INTEGER,
  groundOuts INTEGER,
  hitBatsmen INTEGER,
  hits INTEGER,
  holds INTEGER,
  homeRuns INTEGER,
  inheritedRunners INTEGER,
  inheritedRunnersScored INTEGER,
  intentionalWalks INTEGER,
  losses INTEGER,
  numberOfPitches INTEGER,
  outs INTEGER,
  pickoffs INTEGER,
  pitchesThrown INTEGER,
  plateAppearances INTEGER,
  rbi INTEGER,
  runs INTEGER,
  sacBunts INTEGER,
  sacFlies INTEGER,
  saveOpportunities INTEGER,
  saves INTEGER,
  singles INTEGER,
  shutouts INTEGER,
  stolenBases INTEGER,
  strikeOuts INTEGER,
  strikes INTEGER,
  triples INTEGER,
  unintentionalWalks INTEGER,
  wildPitches INTEGER,
  wins INTEGER
) ENGINE = INNODB;

ALTER TABLE game_player_pitching_stats ADD PRIMARY KEY(gamePk, teamId, playerId);

CREATE TABLE game_batting_orders (
  gamePk INTEGER,
  teamId INTEGER,
  playerId INTEGER,
  battingOrder INTEGER
) ENGINE = INNODB;

ALTER TABLE game_batting_orders ADD PRIMARY KEY(gamePk, teamId, playerId);

CREATE TABLE teams (
  leagueId VARCHAR(10),
  divisionId INTEGER,
  seasonId VARCHAR(20),
  teamId INTEGER,
  venueId INTEGER,
  teamAbbreviation VARCHAR(10),
  teamCode VARCHAR(10),
  teamShortName VARCHAR(100),
  teamFullName VARCHAR(100),
  teamName VARCHAR(100),
  leagueName VARCHAR(100),
  venueName VARCHAR(100),
  locationName VARCHAR(100)
) ENGINE = INNODB;

ALTER TABLE teams ADD PRIMARY KEY(leagueId, seasonId, teamId);

CREATE TABLE game_player_positions (
  gamePk INTEGER,
  teamId INTEGER,
  teamType VARCHAR(10),
  playerId INTEGER,
  positionAbbrev VARCHAR(10)
) ENGINE = INNODB;

ALTER TABLE game_player_positions ADD INDEX(gamePk, teamId, playerId);

CREATE TABLE atbats (
  gamePk INTEGER,
  inning INTEGER,
  halfInning VARCHAR(15),
  atBatIndex INTEGER,
  battingTeamId INTEGER,
  pitchingTeamId INTEGER,
  endOuts INTEGER,
  endBalls INTEGER,
  endStrikes INTEGER,
  batterId INTEGER,
  pitcherId INTEGER,
  hasOut TINYINT,
  hasReview TINYINT,
  isScoringPlay TINYINT,
  rbi INTEGER,
  awayScore INTEGER,
  homeScore INTEGER,
  event VARCHAR(100),
  eventType VARCHAR(100),
  batSide VARCHAR(1),
  pitchHand VARCHAR(1),
  menOnBase VARCHAR(10),
  description VARCHAR(700)
) ENGINE = INNODB;

ALTER TABLE atbats ADD PRIMARY KEY(gamePk, atBatIndex);

CREATE TABLE pitches (
  gamePk INTEGER,
  atBatIndex INTEGER,
  playIndex INTEGER,
  inning INTEGER,
  halfInning VARCHAR(15),
  battingTeamId INTEGER,
  pitchingTeamId INTEGER,
  batterId INTEGER,
  pitcherId INTEGER,
  pitchNumber INTEGER,
  startBalls INTEGER,
  startStrikes INTEGER,
  endBalls INTEGER,
  endStrikes INTEGER,
  callCode VARCHAR(2),
  callDescription VARCHAR(50),
  callDescription2 VARCHAR(50),
  code VARCHAR(2),
  isInPlay TINYINT,
  isStrike TINYINT,
  isBall TINYINT,
  typeCode VARCHAR(100),
  typeDescription VARCHAR(100),
  hasReview TINYINT,
  runnerGoing TINYINT,
  strikeZoneTop DOUBLE,
  strikeZoneBottom DOUBLE,
  x DOUBLE,
  y DOUBLE,
  x0 DOUBLE,
  y0 DOUBLE,
  trajectory VARCHAR(100),
  hardness VARCHAR(100),
  location INTEGER,
  coordX DOUBLE,
  coordY DOUBLE
) ENGINE = INNODB;

ALTER TABLE pitches ADD INDEX(gamePk, atBatIndex);

CREATE TABLE runners (
  gamePk INTEGER,
  inning INTEGER,
  halfInning VARCHAR(15),
  pitchingTeamId INTEGER,
  battingTeamId INTEGER,
  atBatIndex INTEGER,
  playIndex INTEGER,
  event VARCHAR(100),
  eventType VARCHAR(100),
  isScoringPlay TINYINT,
  movementReason VARCHAR(100),
  rbi TINYINT,
  responsiblePitcherId INTEGER,
  runnerId INTEGER,
  startBase VARCHAR(10),
  endBase VARCHAR(10),
  isOut TINYINT,
  outBase VARCHAR(10),
  outNumber INTEGER,
  earned TINYINT,
  teamUnearned TINYINT
) ENGINE = INNODB;

ALTER TABLE runners ADD INDEX(gamePk, atBatIndex);

CREATE TABLE fielding_credits (
  gamePk INTEGER,
  atBatIndex INTEGER,
  playerId INTEGER,
  positionAbbrev VARCHAR(10),
  credit VARCHAR(30)
) ENGINE = INNODB;

ALTER TABLE fielding_credits ADD INDEX(gamePk, atBatIndex);

CREATE TABLE actions (
  gamePk INTEGER,
  inning INTEGER,
  halfInning VARCHAR(15),
  pitchingTeamId INTEGER,
  battingTeamId INTEGER,
  atBatIndex INTEGER,
  playIndex INTEGER,
  playerId INTEGER,
  endOuts INTEGER,
  endBalls INTEGER,
  endStrikes INTEGER,
  hasReview TINYINT,
  isScoringPlay TINYINT,
  awayScore INTEGER,
  homeScore INTEGER,
  event VARCHAR(50),
  eventType VARCHAR(50),
  battingOrder INTEGER,
  positionAbbrev VARCHAR(10),
  injuryType VARCHAR(50),
  description VARCHAR(700)
) ENGINE = INNODB;

ALTER TABLE actions ADD INDEX(gamePk, atBatIndex);

CREATE TABLE pickoffs (
  gamePk INTEGER,
  atBatIndex INTEGER,
  playIndex INTEGER,
  outs INTEGER,
  balls INTEGER,
  strikes INTEGER,
  fromCatcher TINYINT,
  hasReview TINYINT,
  baseCode INTEGER
) ENGINE = INNODB;

ALTER TABLE pickoffs ADD INDEX(gamePk, atBatIndex);

CREATE TABLE games (
  gamePk INTEGER,
  gameType VARCHAR(10),
  gameType2 VARCHAR(10),
  seasonId VARCHAR(20),
  gameDate DATE,
  isTie TINYINT,
  gameNumber INTEGER,
  majorLeague VARCHAR(20),
  majorLeagueId INTEGER,
  doubleHeader VARCHAR(10),
  dayNight VARCHAR(10),
  scheduledInnings INTEGER,
  gamesInSeries INTEGER,
  seriesDescription VARCHAR(30),
  ifNecessaryDescription VARCHAR(30),
  gameId VARCHAR(30),
  abstractGameState VARCHAR(30),
  codedGameState VARCHAR(30),
  detailedState VARCHAR(30),
  awayWins INTEGER,
  awayLosses INTEGER,
  awayPct DOUBLE,
  awayScore INTEGER,
  awayTeamId INTEGER,
  awayIsWinner TINYINT,
  homeWins INTEGER,
  homeLosses INTEGER,
  homePct DOUBLE,
  homeScore INTEGER,
  homeTeamId INTEGER,
  homeIsWinner TINYINT,
  venueId INTEGER,
  homeTeamName VARCHAR(100),
  awayTeamName VARCHAR(100),
  venueName VARCHAR(100),
  weather VARCHAR(100),
  wind VARCHAR(100),
  attendance INTEGER
) ENGINE = INNODB;

ALTER TABLE games ADD PRIMARY KEY(gamePk);
