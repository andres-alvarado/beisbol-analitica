USE baseball;

DROP TABLE game_player_split_stats;

CREATE TABLE game_player_split_stats (
  gamePk INTEGER,
  battingTeamId INTEGER,
  batterId INTEGER,
  batSide VARCHAR(1),
  pitchingTeamId INTEGER,
  pitcherId INTEGER,
  pitchHand VARCHAR(1),
  balks INTEGER,
  batterInterferences INTEGER,
  bunts INTEGER,
  catcherInterferences INTEGER,
  doubles INTEGER,
  fanInterferences INTEGER,
  fieldErrors INTEGER,
  fieldersChoice INTEGER,
  flyouts INTEGER,
  forceOuts INTEGER,
  groundedIntoDoublePlays INTEGER,
  groundOuts INTEGER,
  hitByPitch INTEGER,
  homeRuns INTEGER,
  intentionalWalks INTEGER,
  lineOuts INTEGER,
  passedBalls INTEGER,
  popOuts INTEGER,
  runsBattedIn INTEGER,
  sacBunts INTEGER,
  sacFlies INTEGER,
  singles INTEGER,
  strikeOuts INTEGER,
  triples INTEGER,
  triplePlays INTEGER,
  walks INTEGER,
  wildPitches INTEGER
);

ALTER TABLE game_player_split_stats ADD INDEX(gamePk, battingTeamId, batterId);
ALTER TABLE game_player_split_stats ADD INDEX(gamePk, pitchingTeamId, pitcherId);
