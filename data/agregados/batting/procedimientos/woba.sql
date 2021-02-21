USE baseball;

DROP PROCEDURE woba;

DELIMITER //

CREATE PROCEDURE woba( )
BEGIN

/* Actualizar valores de los pesos en la tabla */
UPDATE
  agg_batting_stats abs
INNER JOIN (
  SELECT
    majorLeagueId,
    seasonId,
    SUM(IF(event = 'Walk', runValue, 0)) weightUnintentionalWalk,
    SUM(IF(event = 'Hit By Pitch', runValue, 0)) weightHitByPitch,
    SUM(IF(event = 'Single', runValue, 0)) weightSingle,
    SUM(IF(event = 'Double', runValue, 0)) weightDouble,
    SUM(IF(event = 'Triple', runValue, 0)) weightTriple,
    SUM(IF(event = 'Home Run', runValue, 0)) weightHomeRun
  FROM rem_event_run_value
  GROUP BY
    1, 2
) w
  ON abs.majorLeagueId = w.majorLeagueId
  AND abs.seasonId = w.seasonId
  SET abs.weightUnintentionalWalk = w.weightUnintentionalWalk
  ,   abs.weightHitByPitch = w.weightHitByPitch
  ,   abs.weightSingle = w.weightSingle
  ,   abs.weightDouble = w.weightDouble
  ,   abs.weightTriple = w.weightTriple
  ,   abs.weightHomeRun = w.weightHomeRun;

/* Calcular wOBA */
UPDATE
  agg_batting_stats
  SET weightedOnBaseAverage = IF(
                              atBats + unintentionalWalks + sacFlies + hitByPitch > 0,
                              (
                                unintentionalWalks * weightUnintentionalWalk +
                                singles * weightSingle +
                                doubles * weightDouble +
                                triples * weightTriple +
                                homeRuns * weightHomeRun
                              ) / (atBats + unintentionalWalks + sacFlies + hitByPitch),
                              NULL
                            );

COMMIT;

END //

DELIMITER ;
