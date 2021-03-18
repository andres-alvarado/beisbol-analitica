USE baseball;

DROP PROCEDURE atbats;

DELIMITER //

CREATE PROCEDURE atbats()
BEGIN

INSERT INTO atbats(
    gamePk,
    inning,
    halfInning,
    atBatIndex,
    endOuts,
    endBalls,
    endStrikes,
    batterId,
    pitcherId,
    hasOut,
    hasReview,
    isScoringPlay,
    rbi,
    awayScore,
    homeScore,
    event,
    eventType,
    batSide,
    pitchHand,
    menOnBase,
    description
  )
SELECT
  gamePk,
  inning,
  halfInning,
  atBatIndex,
  outs AS endOuts,
  balls AS endBalls,
  strikes AS endStrikes,
  batterId,
  pitcherId,
  hasOut,
  hasReview,
  isScoringPlay,
  rbi,
  awayScore,
  homeScore,
  event,
  eventType,
  batterSideCode AS batSide,
  pitcherHandCode AS pitchHand,
  menOnBase,
  description
FROM stg_play_atbat
WHERE
  1 = 1
  AND (gamePk, atBatIndex) NOT IN (
    SELECT
      gamePk,
      atBatIndex
    FROM atbats
  );

-- Update batting/pitching teams
UPDATE
  atbats a
INNER JOIN (
  SELECT
    gamePk,
    homeTeamId,
    awayTeamId
  FROM games g
) q
  ON (a.gamePk = q.gamePk)
  SET a.pitchingTeamId = If( a.halfInning = 'top', homeTeamId, awayTeamId )
  ,   a.battingTeamId  = If( a.halfInning = 'top', awayTeamId, homeTeamId )
  Where 1 = 1
  And   ( pitchingTeamId Is Null Or battingTeamId Is Null );

-- Stats from pitching
UPDATE atbats a
INNER JOIN
(
    SELECT
      gamePk,
      atBatIndex,
      SUM(IF(callCode IN ('B', 'I', 'P', 'V', '*B'), 1, 0 )) AS balls,
      SUM(IF(callCode IN ('P'), 1, 0 ) ) AS ballsPitchOut,
      SUM(IF(callCode IN ('*B'), 1, 0 ) ) AS ballsInDirt,
      SUM(IF(callCode IN ('I'), 1, 0 ) ) AS intentBalls,
      SUM(IF(callCode IN ('F', 'L', 'O', 'R', 'T'), 1, 0 ) ) AS fouls,
      SUM(IF(callCode IN ('L'), 1, 0 ) ) AS foulBunts,
      SUM(IF(callCode IN ('T','O'), 1, 0 ) ) AS foulTips,
      SUM(IF(callCode IN ('R'), 1, 0 ) ) AS foulPitchouts,
      SUM(IF(callCode IN ('D','E','J','X','Y','Z'), 1, 0 ) ) AS hitIntoPlay,
      COUNT(1) pitches,
      SUM(IF(callCode IN ('J','P','Q','R','Y','Z'), 1, 0 ) ) AS pitchouts,
      SUM(IF(callCode IN ('A', 'C', 'K', 'M', 'Q', 'S',  'W' )
          OR callDescription2 IN ( 'Strike - Foul', 'Strike - Foul Bunt', 'Strike - Foul Tip' )
          , 1, 0 ) ) AS strikes,
      SUM(IF(callCode IN ('C'), 1, 0 ) ) AS strikesCalled,
      SUM(IF(callCode IN ('Q')
          OR callDescription2 IN ( 'Strike - Foul on Pitchout' ), 1, 0 ) ) AS strikesPitchOuts,
      SUM(IF(callCode IN ('M'), 1, 0 )) AS missedBunts,
      SUM(IF(callCode IN ('Q', 'S', 'W'), 1, 0 )) swingAndMissStrikes,
      SUM(IF(callCode IN ('J','Q','R','Y','Z'), 1, 0 )) AS swingsPitchOuts,
      SUM(IF(callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 )) AS swings,
      -- Swings Per Ball and Strikes
      -- 0 Ball(s)
      SUM( IF(startBalls = 0 AND startStrikes = 0 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsZeroAndZero,
      SUM( IF(startBalls = 0 AND startStrikes = 1 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsZeroAndOne,
      SUM( IF(startBalls = 0 AND startStrikes = 2 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsZeroAndTwo,
      -- 1 Ball(s)
      SUM( IF(startBalls = 1 AND startStrikes = 0 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsOneAndZero,
      SUM( IF(startBalls = 1 AND startStrikes = 1 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsOneAndOne,
      SUM( IF(startBalls = 1 AND startStrikes = 2 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsOneAndTwo,
      -- 2 Ball(s)
      SUM( IF(startBalls = 2 AND startStrikes = 0 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsTwoAndZero,
      SUM( IF(startBalls = 2 AND startStrikes = 1 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsTwoAndOne,
      SUM( IF(startBalls = 2 AND startStrikes = 2 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsTwoAndTwo,
      -- 3 Ball(s)
      SUM( IF(startBalls = 3 AND startStrikes = 0 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsThreeAndZero,
      SUM( IF(startBalls = 3 AND startStrikes = 1 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsThreeAndOne,
      SUM( IF(startBalls = 3 AND startStrikes = 2 AND callCode IN ('D', 'E', 'F', 'J', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'), 1, 0 ) ) AS swingsThreeAndTwo,
      -- Trajectories
      SUM(IF( trajectory = 'fly_ball', 1, 0 ) ) AS flyBalls,
      SUM(IF( trajectory = 'ground_ball', 1, 0 ) ) AS groundBalls,
      SUM(IF( trajectory = 'line_drive', 1, 0 ) ) AS lineDrives,
      SUM(IF( trajectory = 'popup', 1, 0 ) ) AS popUps,
      SUM(IF( trajectory = 'bunt_grounder', 1, 0 ) ) AS groundBunts,
      SUM(IF( trajectory = 'bunt_popup', 1, 0 ) ) AS popupBunts,
      SUM(IF( trajectory = 'bunt_line_drive', 1, 0 ) ) AS lineDriveBunts
    FROM pitches
    WHERE ( gamePk, atBatIndex ) NOT IN ( SELECT gamePk, atBatIndex
                                          FROM atbats
                                          WHERE balls IS NOT NULL
                                        )
    GROUP BY 1, 2
) p
ON a.gamePk = p.gamePk
AND a.atBatIndex = p.atBatIndex
SET a.balls = p.balls,
    a.ballsPitchOut = p.ballsPitchOut,
    a.ballsInDirt = p.ballsInDirt,
    a.intentBalls = p.intentBalls,
    a.fouls = p.fouls,
    a.foulBunts = p.foulBunts,
    a.foulTips = p.foulTips,
    a.foulPitchOuts = p.foulPitchOuts,
    a.hitIntoPlay = p.hitIntoPlay,
    a.pitches = p.pitches,
    a.pitchOuts = p.pitchOuts,
    a.strikes = p.strikes,
    a.strikesCalled = p.strikesCalled,
    a.strikesPitchOuts = p.strikesPitchOuts,
    a.missedBunts = p.missedBunts,
    a.swingAndMissStrikes = p.swingAndMissStrikes,
    a.swingsPitchOuts = p.swingsPitchOuts,
    a.swings = p.swings,
    -- Swings Per Ball and Strikes
    -- 0 Ball(s)
    a.swingsZeroAndZero = p.swingsZeroAndZero,
    a.swingsZeroAndOne = p.swingsZeroAndOne,
    a.swingsZeroAndTwo = p.swingsZeroAndTwo,
    -- 1 Ball(s)
    a.swingsOneAndZero = p.swingsOneAndZero,
    a.swingsOneAndOne = p.swingsOneAndOne,
    a.swingsOneAndTwo = p.swingsOneAndTwo,
    -- 2 Ball(s)
    a.swingsTwoAndZero = p.swingsTwoAndZero,
    a.swingsTwoAndOne = p.swingsTwoAndOne,
    a.swingsTwoAndTwo = p.swingsTwoAndTwo,
    -- 3 Ball(s)
    a.swingsThreeAndZero = p.swingsThreeAndZero,
    a.swingsThreeAndOne = p.swingsThreeAndOne,
    a.swingsThreeAndTwo = p.swingsThreeAndTwo,
    -- Trajectories
    a.flyBalls = p.flyBalls,
    a.groundBalls	= p.groundBalls,
    a.lineDrives = p.lineDrives,
    a.popUps = p.popUps,
    a.groundBunts = p.groundBunts,
    a.popupBunts = p.popupBunts,
    a.lineDriveBunts = p.lineDriveBunts;

COMMIT;

END //

DELIMITER ;
