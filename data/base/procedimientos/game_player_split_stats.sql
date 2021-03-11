USE baseball;

DROP PROCEDURE game_player_split_stats;

DELIMITER //

CREATE PROCEDURE game_player_split_stats()
BEGIN

INSERT INTO game_player_split_stats(
    gamePk,
    battingTeamId,
    batterId,
    batSide,
    pitchingTeamId,
    pitcherId,
    pitchHand,
    balks,
    batterInterferences,
    bunts,
    catcherInterferences,
    doubles,
    fanInterferences,
    fieldErrors,
    fieldersChoice,
    flyouts,
    forceOuts,
    groundedIntoDoublePlays,
    groundOuts,
    hitByPitch,
    homeRuns,
    intentionalWalks,
    lineOuts,
    passedBalls,
    popOuts,
    sacBunts,
    sacFlies,
    singles,
    strikeOuts,
    triples,
    triplePlays,
    walks,
    wildPitches
  )
SELECT
  gamePk,
  battingTeamId,
  batterId,
  batSide,
  pitchingTeamId,
  pitcherId,
  pitchHand,
  SUM(IF(event = 'Balk', 1, 0)) balks,
  SUM(IF(event = 'Batter Interference', 1, 0)) batterInterferences,
  SUM(IF(event IN ('Bunt Groundout', 'Bunt Lineout', 'Bunt Pop Out'), 1, 0)) AS bunts,
  SUM(IF(event = 'Catcher Interference', 1, 0)) catcherInterferences,
  SUM(IF(event = 'Double', 1, 0)) AS doubles,
  SUM(IF(event = 'Fan Interference', 1, 0)) fanInterferences,
  SUM(IF(event = 'Field Error', 1, 0)) fieldErrors,
  SUM(IF(event IN ('Fielders Choice', 'Fielders Choice Out'), 1, 0)) fieldersChoices,
  SUM(IF(event = 'Flyout', 1, 0)) AS flyouts,
  SUM(IF(event = 'Forceout', 1, 0)) forceOuts,
  SUM(IF(event IN ('Double Play', 'Grounded Into DP'), 1, 0)) AS groundedIntoDoublePlays,
  SUM(IF(event = 'Groundout', 1, 0)) AS groundOuts,
  SUM(IF(event = 'Hit By Pitch', 1, 0)) AS hitByPitch,
  SUM(IF(event = 'Home Run', 1, 0)) AS homeRuns,
  SUM(IF(event = 'Intent Walk', 1, 0)) AS intentionalWalks,
  SUM(IF(event = 'Lineout', 1, 0)) AS lineOuts,
  SUM(IF(event = 'Passed Ball', 1, 0)) AS passedBalls,
  SUM(IF(event = 'Pop Out', 1, 0)) AS popOuts,
  SUM(IF(event IN ('Sac Bunt', 'Sac Bunt Double Play'), 1, 0)) AS sacBunts,
  SUM(IF(event IN ('Sac Fly', 'Sac Fly Double Play'), 1, 0)) AS sacFlies,
  SUM(IF(event = 'Single', 1, 0)) AS singles,
  SUM(IF(event IN ('Strikeout', 'Strikeout Double Play', 'Strikeout Triple Play'), 1, 0))
    AS strikeOuts,
  SUM(IF(event = 'Triple', 1, 0)) AS triples,
  SUM(IF(event = 'Triple Play', 1, 0)) AS triplePlays,
  SUM(IF(event = 'Walk', 1, 0)) AS walks,
  SUM(IF(event = 'Wild Pitch', 1, 0)) AS wildPitches
FROM atbats
WHERE
  event NOT IN (
    'Caught Stealing 2B',
    'Caught Stealing 3B',
    'Caught Stealing Home',
    'Defensive Sub',
    'Defensive Switch',
    'Ejection',
    'Offensive Substitution',
    'Other Advance',
    'Pickoff 1B',
    'Pickoff 2B',
    'Pickoff 3B',
    'Pickoff Caught Stealing 2B',
    'Pickoff Caught Stealing 3B',
    'Pickoff Caught Stealing Home',
    'Pickoff Error 1B',
    'Pickoff Error 2B',
    'Pickoff Error 3B',
    'Pitching Substitution',
    'Stolen Base 2B',
    'Stolen Base 3B',
    'Stolen Base Home',
    'Game Advisory',
    'Runner Double Play',
    'Runner Out'
  )
GROUP BY 1,2,3,4,5,6,7;

COMMIT;

END //

DELIMITER ;
