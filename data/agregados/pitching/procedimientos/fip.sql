USE baseball;

DROP PROCEDURE fip;

DELIMITER //

CREATE PROCEDURE fip( )
BEGIN

/* Based on
   https://web.wpi.edu/Pubs/E-project/Available/E-project-050614-141701/unrestricted/COPYforDesktopJoeMQP.pdf
   https://library.fangraphs.com/pitching/fip/
*/

/* Actualizar valores de los pesos en la tabla */
UPDATE
  agg_pitching_stats aps
INNER JOIN (
  SELECT
    majorLeagueId,
    seasonId,
    SUM(IF(event = 'Ball in Play', runValue, 0)) weightBallInPlay,
    SUM(IF(event = 'Hit By Pitch', runValue, 0)) weightHitByPitch,
    SUM(IF(event = 'Home Run', runValue, 0)) weightHomeRun,
    SUM(IF(event = 'Strikeout', runValue, 0)) weightStrikeout,
    SUM(IF(event = 'Walk', runValue, 0)) weightWalk
  FROM rem_event_run_value
  GROUP BY
    1, 2
) w
  ON aps.majorLeagueId = w.majorLeagueId
  AND aps.seasonId = w.seasonId
  SET aps.weightBallInPlay = w.weightBallInPlay
  ,    aps.weightHitByPitch = w.weightHitByPitch
  ,    aps.weightHomeRun = w.weightHomeRun
  ,    aps.weightStrikeout = w.weightStrikeout
  ,    aps.weightWalk = w.weightWalk
  WHERE groupingDescription IN( 'MAJORLEAGUEID_SEASONID_GAMETYPE2',
                                'MAJORLEAGUEID_SEASONID_GAMETYPE2_PLAYERID'
                              );

/* Runs per Plate Appearance */
UPDATE
  agg_pitching_stats aps
INNER JOIN (
    WITH rpa AS (
      SELECT
        majorLeagueId,
        seasonId,
        SUM(runsScoredInPlay) / COUNT(DISTINCT gamePk) / 2 AS fipLeagueRunsPerTeamPerGame,
        SUM(isPlateAppearance) / COUNT(DISTINCT gamePk) / 2
          AS fipLeaguePlateAppearancesPerTeamPerGame
      FROM rem_play_by_play
      WHERE
        gameType2 = 'RS'
        AND (
          scheduledInnings > inning
          OR (
            scheduledInnings = inning
            AND halfInning = 'top'
          )
        )
      GROUP BY
        1, 2
    )
    SELECT
      majorLeagueId,
      seasonId,
      fipLeagueRunsPerTeamPerGame,
      fipLeaguePlateAppearancesPerTeamPerGame,
      fipLeagueRunsPerTeamPerGame / fipLeaguePlateAppearancesPerTeamPerGame
        AS fipLeagueRunsPerPlateAppearancePerTeamPerGame
    FROM rpa
  ) rpa
  ON aps.majorLeagueId = rpa.majorLeagueId
  AND aps.seasonId = rpa.seasonId
  SET aps.fipLeagueRunsPerTeamPerGame = rpa.fipLeagueRunsPerTeamPerGame
  ,   aps.fipLeaguePlateAppearancesPerTeamPerGame = rpa.fipLeaguePlateAppearancesPerTeamPerGame
  ,   aps.fipLeagueRunsPerPlateAppearancePerTeamPerGame = rpa.fipLeagueRunsPerPlateAppearancePerTeamPerGame
  WHERE groupingDescription IN( 'MAJORLEAGUEID_SEASONID_GAMETYPE2',
                                'MAJORLEAGUEID_SEASONID_GAMETYPE2_PLAYERID'
                              );

/* FIP Weights */
UPDATE
  agg_pitching_stats aps
INNER JOIN (
    WITH woba_weights AS (
      SELECT
        seasonId,
        majorLeagueId,
        weightStrikeOut + fipLeagueRunsPerPlateAppearancePerTeamPerGame AS weightStrikeOut,
        weightBallInPlay + fipLeagueRunsPerPlateAppearancePerTeamPerGame AS weightBallInPlay,
        weightWalk + fipLeagueRunsPerPlateAppearancePerTeamPerGame AS weightWalk,
        weightHomeRun + fipLeagueRunsPerPlateAppearancePerTeamPerGame AS weightHomeRun,
        earnedRunsPerNineInnings AS leagueEarnedRunsPerNineInnings,
        homeRuns AS leagueHomeRuns,
        walks AS leagueWalks,
        strikeOuts AS leagueStrikeOuts,
        inningsPitched AS leagueInningsPitched
      FROM agg_pitching_stats
      WHERE
        groupingDescription IN('MAJORLEAGUEID_SEASONID_GAMETYPE2')
        AND gameType2 = 'RS'
    ),
      fip_weights AS (
      SELECT
        seasonId,
        majorLeagueId,
        (weightStrikeOut - weightBallInPlay) * 9 fipWeightStrikeOut,
        (weightWalk - weightBallInPlay) * 9 fipWeightWalk,
        (weightHomeRun - weightBallInPlay) * 9 fipWeightHomeRun,
        leagueEarnedRunsPerNineInnings,
        leagueHomeRuns,
        leagueWalks,
        leagueStrikeOuts,
        leagueInningsPitched
      FROM woba_weights
    )
    SELECT
      seasonId,
      majorLeagueId,
      fipWeightStrikeOut,
      fipWeightWalk,
      fipWeightHomeRun,
      leagueEarnedRunsPerNineInnings - (
        fipWeightHomeRun * leagueHomeRuns + fipWeightWalk * leagueWalks + fipWeightStrikeOut
          * leagueStrikeOuts
      ) / leagueInningsPitched fipConstant
    FROM fip_weights
  ) AS fp
  ON aps.majorLeagueId = fp.majorLeagueId
  AND aps.seasonId = fp.seasonId
  SET aps.fipWeightStrikeOut = fp.fipWeightStrikeOut
  ,   aps.fipWeightWalk = fp.fipWeightWalk
  ,   aps.fipWeightHomeRun = fp.fipWeightHomeRun
  ,   aps.fipConstant = fp.fipConstant
  WHERE groupingDescription IN( 'MAJORLEAGUEID_SEASONID_GAMETYPE2',
                                'MAJORLEAGUEID_SEASONID_GAMETYPE2_PLAYERID'
                              );

/* FIP */
UPDATE
  agg_pitching_stats
  SET fieldIndepedentPitching = IF( inningsPitched > 0, ( fipWeightHomeRun * homeRuns + fipWeightWalk * walks + fipWeightStrikeOut * strikeOuts ) / inningsPitched  + fipConstant, NULL )
  WHERE groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_PLAYERID';

COMMIT;

END //

DELIMITER ;
