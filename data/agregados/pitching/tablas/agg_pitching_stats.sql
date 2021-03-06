USE baseball;

DROP TABLE agg_pitching_stats;

CREATE TABLE agg_pitching_stats (
  groupingId INTEGER UNSIGNED,
  groupingDescription VARCHAR(255),
  aggregationType VARCHAR(20),
  majorLeagueId INTEGER,
  seasonId DOUBLE,
  gameDate DATE,
  gameType2 VARCHAR(10),
  teamType VARCHAR(10),
  venueId INTEGER,
  teamId INTEGER,
  playerId INTEGER,
  batSide VARCHAR(1),
  pitchHand VARCHAR(1),
  menOnBase VARCHAR(10),
  airOuts INTEGER,
  atBats INTEGER,
  battersFaced INTEGER,
  blownSaves INTEGER,
  bunts INTEGER,
  catcherInterferences INTEGER,
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
  totalBases INTEGER,
  triples INTEGER,
  unintentionalWalks INTEGER,
  walks INTEGER,
  wildPitches INTEGER,
  wins INTEGER,
  strikeOutsPerNineInnings DOUBLE,
  walksPerNineInnings DOUBLE,
  homeRunsPerNineInnings DOUBLE,
  runsPerNineInnings DOUBLE,
  earnedRunsPerNineInnings DOUBLE,
  walksHitsPerInning DOUBLE,
  strikeOutPerBattersFaced DOUBLE,
  baseOnBallsPerBattersFaced DOUBLE,
  strikeOutsWalksPercentage DOUBLE,
  strikeOutsPerWalksPercentage DOUBLE,
  leftOnBasePercentage DOUBLE,
  opponentsBattingAverage DOUBLE,
  battedBallsInPlayPercentage DOUBLE,
  sluggingPercentage DOUBLE,
  stolenBasePercentage DOUBLE,
  onBasePercentage DOUBLE,
  onBasePlusSluggingPercentage DOUBLE,
  isolatedPower DOUBLE,
  savePercentage DOUBLE,
  winPercentage DOUBLE,
  inningsPitched DOUBLE,
  -- FIP
  -- wOBA weights
  weightUnintentionalWalk DOUBLE,
  weightHitByPitch DOUBLE,
  weightSingle DOUBLE,
  weightDouble DOUBLE,
  weightTriple DOUBLE,
  weightHomeRun DOUBLE,
  weightStrikeout DOUBLE,
  weightOut DOUBLE,
  weightBallInPlay DOUBLE,
  -- league Totals
  leagueHitBatsmen INTEGER,
  leagueStrikeOuts INTEGER,
  leagueUnintentionalWalks INTEGER,
  leagueSingles INTEGER,
  leagueDoubles INTEGER,
  leagueTriples INTEGER,
  leagueHomeRuns INTEGER,
  leagueOuts INTEGER,
  leagueAtBats INTEGER,
  leagueInningsPitched DOUBLE,
  leagueEarnedRunsPerNineInnings DOUBLE,
  leagueRunsPerTeamPerGame INTEGER,
  leaguePlateAppearancesPerTeamPerGame INTEGER,
  leagueRunsPerPlateAppearancePerTeamPerGame DOUBLE,
  -- FIP weights
  fipWeightStrikeOut DOUBLE,
  fipWeightUnintentionalWalk DOUBLE,
  fipWeightHomeRun DOUBLE,
  fipConstant DOUBLE,
  fieldIndepedentPitching DOUBLE,
  -- These come from the pitches table
  -- These metrics come from the pitches table
  balls INTEGER,
  balks INTEGER,
  ballsPitchOut INTEGER,
  ballsInDirt INTEGER,
  batterInterferences INTEGER,
  doublePlays INTEGER,
  intentBalls INTEGER,
  fanInterferences INTEGER,
  fieldErrors INTEGER,
  fieldersChoice INTEGER,
  flyOuts INTEGER,
  forceOuts INTEGER,
  fouls INTEGER,
  foulBunts INTEGER,
  foulTips INTEGER,
  foulPitchOuts INTEGER,
  games INTEGER,
  triplePlays INTEGER,
  hitIntoPlay INTEGER,
  lineOuts INTEGER,
  passedBalls INTEGER,
  pitches INTEGER,
  pitchOuts INTEGER,
  popOuts INTEGER,
  runsBattedIn INTEGER,
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
  threeAndTwoSwingPercentage DOUBLE,
  -- Atributos
  majorLeague VARCHAR(10),
  playerName VARCHAR(100),
  teamName VARCHAR(100),
  venueName VARCHAR(100)
);

ALTER TABLE agg_pitching_stats ADD INDEX(groupingId);
ALTER TABLE agg_pitching_stats ADD INDEX(groupingDescription(255));
ALTER TABLE agg_pitching_stats ADD INDEX(majorLeagueId);
ALTER TABLE agg_pitching_stats ADD INDEX(seasonId);
ALTER TABLE agg_pitching_stats ADD INDEX(venueId);
ALTER TABLE agg_pitching_stats ADD INDEX(teamId);
ALTER TABLE agg_pitching_stats ADD INDEX(playerId);
