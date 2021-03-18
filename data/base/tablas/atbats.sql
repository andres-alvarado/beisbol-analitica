USE baseball;

DROP TABLE atbats;

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
  description VARCHAR(700),
  -- These metrics come from the pitches table
  balls INTEGER,
  ballsPitchOut INTEGER,
  ballsInDirt INTEGER,
  intentBalls INTEGER,
  fouls INTEGER,
  foulBunts INTEGER,
  foulTips INTEGER,
  foulPitchOuts INTEGER,
  hitIntoPlay INTEGER,
  pitches INTEGER,
  pitchOuts INTEGER,
  strikes INTEGER,
  strikesCalled INTEGER,
  strikesPitchOuts INTEGER,
  missedBunts INTEGER,
  swingAndMissStrikes INTEGER,
  swingsPitchOuts INTEGER,
  swings INTEGER,
  -- Swings Per Ball and Strikes
  -- 0 Ball(s)
  swingsZeroAndZero INTEGER,
  swingsZeroAndOne INTEGER,
  swingsZeroAndTwo INTEGER,
  -- 1 Ball(s)
  swingsOneAndZero INTEGER,
  swingsOneAndOne INTEGER,
  swingsOneAndTwo INTEGER,
  -- 2 Ball(s)
  swingsTwoAndZero INTEGER,
  swingsTwoAndOne INTEGER,
  swingsTwoAndTwo INTEGER,
  -- 3 Ball(s)
  swingsThreeAndZero INTEGER,
  swingsThreeAndOne INTEGER,
  swingsThreeAndTwo INTEGER,
  -- Trajectories
  flyBalls INTEGER,
  groundBalls INTEGER,
  lineDrives INTEGER,
  popUps INTEGER,
  groundBunts INTEGER,
  popupBunts INTEGER,
  lineDriveBunts INTEGER
) ENGINE = INNODB;

ALTER TABLE atbats ADD PRIMARY KEY(gamePk, atBatIndex);
