USE baseball;

DROP TABLE agg_batting_stats;

CREATE TABLE agg_batting_stats (
  groupingId INTEGER UNSIGNED,
  groupingDescription VARCHAR(255),
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  gameType2 VARCHAR(10),
  teamType VARCHAR(10),
  venueId INTEGER,
  teamId INTEGER,
  playerId INTEGER,
  batSide VARCHAR(1),
  pitchHand VARCHAR(1),
  menOnBase VARCHAR(10),
  games INTEGER,
  atBats INTEGER,
  balks INTEGER,
  batterInterferences INTEGER,
  bunts INTEGER,
  catcherInterferences INTEGER,
  caughtStealing INTEGER,
  doubles INTEGER,
  fanInterferences INTEGER,
  fieldErrors INTEGER,
  fieldersChoice INTEGER,
  forceOuts INTEGER,
  flyOuts INTEGER,
  groundedIntoDoublePlays INTEGER,
  groundedIntoTriplePlays INTEGER,
  groundOuts INTEGER,
  hitByPitch INTEGER,
  hits INTEGER,
  homeRuns INTEGER,
  intentionalWalks INTEGER,
  leftOnBase INTEGER,
  lineOuts INTEGER,
  passedBalls INTEGER,
  pickoffs INTEGER,
  plateAppearances INTEGER,
  popOuts INTEGER,
  runsBattedIn INTEGER,
  runs INTEGER,
  sacBunts INTEGER,
  sacFlies INTEGER,
  singles INTEGER,
  stolenBases INTEGER,
  stolenBaseAttempts INTEGER,
  strikeOuts INTEGER,
  totalBases INTEGER,
  triples INTEGER,
  unintentionalWalks INTEGER,
  walks INTEGER,
  wildPitches INTEGER,
  -- Derived Metrics
  battingAverage DOUBLE,
  isolatedPower DOUBLE,
  secondBattingAverage DOUBLE,
  extraBaseHitPercentage DOUBLE,
  sluggingPercentage DOUBLE,
  stolenBasePercentage DOUBLE,
  atBatsPerHomeRunsPercentage DOUBLE,
  walksPerStrikeOutsPercentage DOUBLE,
  onBasePercentage DOUBLE,
  onBasePlusSluggingPercentage DOUBLE,
  walksPerPlateAppearancesPercentage DOUBLE,
  strikeOutsPerPlateAppearancesPercentage DOUBLE,
  homeRunsPerPlateAppearancesPercentage DOUBLE,
  extraBasePercentage DOUBLE,
  inPlayPercentage DOUBLE,
  runsCreated DOUBLE,
  powerSpeed DOUBLE,
  runScoredPercentage DOUBLE,
  battedBallsInPlayPercentage DOUBLE,
  -- wOBA
  weightedOnBaseAverage DOUBLE,
  weightedOnBaseAverageRelativeToOuts DOUBLE,
  weightUnintentionalWalk DOUBLE,
  weightHitByPitch DOUBLE,
  weightSingle DOUBLE,
  weightDouble DOUBLE,
  weightTriple DOUBLE,
  weightHomeRun DOUBLE,
  weightOut DOUBLE,
  -- OPS +
  leagueOnBasePercentage DOUBLE,
  leagueSluggingPercentage DOUBLE,
  onBasePlusSluggingPercentagePlus DOUBLE,
  -- These come from the pitches table
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
  lineDriveBunts INTEGER,
  -- 0 Ball(s)
  zeroAndZeroSwingPercentage DOUBLE,
  zeroAndOneSwingPercentage DOUBLE,
  zeroAndTwoSwingPercentage DOUBLE,
  -- 1 Ball(s)
  oneAndZeroSwingPercentage DOUBLE,
  oneAndOneSwingPercentage DOUBLE,
  oneAndTwoSwingPercentage DOUBLE,
  -- 2 Ball(s)
  twoAndZeroSwingPercentage DOUBLE,
  twoAndOneSwingPercentage DOUBLE,
  twoAndTwoSwingPercentage DOUBLE,
  -- 3 Ball(s)
  threeAndZeroSwingPercentage DOUBLE,
  threeAndOneSwingPercentage DOUBLE,
  threeAndTwoSwingPercentage DOUBLE
) ENGINE = INNODB;

ALTER TABLE agg_batting_stats ADD INDEX(groupingId);
ALTER TABLE agg_batting_stats ADD INDEX(groupingDescription(255));
ALTER TABLE agg_batting_stats ADD INDEX(majorLeagueId);
ALTER TABLE agg_batting_stats ADD INDEX(seasonId);
ALTER TABLE agg_batting_stats ADD INDEX(venueId);
ALTER TABLE agg_batting_stats ADD INDEX(teamId);
ALTER TABLE agg_batting_stats ADD INDEX(playerId);
