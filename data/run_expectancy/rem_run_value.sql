USE baseball;

DROP PROCEDURE rem_event_run_value;

DELIMITER //

CREATE PROCEDURE rem_event_run_value()
BEGIN

INSERT INTO rem_event_run_value(
    majorLeagueId,
    seasonId,
    event,
    startRunExpectancy,
    runsScoredInPlay,
    endRunExpectancy,
    runsScoredEndInning,
    runValue
  )
WITH /* Matriz de Expectativa de Carrera */
run_expectancy_matrix AS (
  SELECT
    majorLeagueId,
    seasonId,
    outsBeforePlay,
    runnersBeforePlay,
    AVG(runsScoredEndInning - runsScoredBeforePlay) runExpectancy
  FROM rem_play_by_play
  WHERE
    (majorLeagueId, seasonId) NOT IN (
      SELECT
        majorLeagueId,
        seasonId
      FROM rem_event_run_value
    )
  GROUP BY
    1, 2, 3, 4
),
/* Modificar eventos de Play by Play */
rem_play_by_play_events AS (
  SELECT
    majorLeagueId,
    seasonId,
    runnersBeforePlay,
    runsScoredBeforePlay,
    outsBeforePlay,
    runsScoredInPlay,
    outsAfterPlay,
    runnersAfterPlay,
    runsScoredEndInning,
    CASE
      WHEN event IN ('Bunt Groundout', 'Bunt Lineout', 'Bunt Pop Out') THEN 'Bunt'
      WHEN event IN ('Field Error', 'Error') THEN 'Error'
      WHEN event IN ('Sac Fly Double Play') THEN 'Sac Fly'
      WHEN event IN ('Strikeout Double Play', 'Strikeout Triple Play') THEN 'Strikeout'
      WHEN event IN ('Grounded Into DP', 'Runner Double Play') THEN 'Double Play'
      WHEN event IN ('Pickoff Caught Stealing 2B') THEN 'Caught Stealing 2B'
      WHEN event IN ('Pickoff Caught Stealing 3B') THEN 'Caught Stealing 3B'
      When event In ('Pickoff Caught Stealing Home') THEN 'Caught Stealing Home'
      WHEN event IN ('Sac Bunt Double Play') THEN 'Sac Bunt'
      WHEN event IN (
        'Field Out',
        'Flyout',
        'Forceout',
        'Groundout',
        'Fielders Choice Out',
        'Lineout',
        'Pop Out',
        'Runner Out'
      ) THEN 'Out'
      ELSE event
    END event
  FROM rem_play_by_play
),
/* Calcular run expectancies al inicio, durante y final de jugada */
run_expectancies AS (
  SELECT
    rpbp.majorLeagueId,
    rpbp.seasonId,
    rpbp.event,
    AVG(rem.runExpectancy) startRunExpectancy,
    AVG(runsScoredInPlay) runsScoredInPlay,
    AVG(rem2.runExpectancy) endRunExpectancy,
    AVG(runsScoredEndInning - runsScoredBeforePlay) runsScoredEndInning
  FROM rem_play_by_play_events rpbp
  INNER JOIN run_expectancy_matrix rem
    ON rpbp.majorLeagueId = rem.majorLeagueId
    AND rpbp.seasonId = rem.seasonId
    AND rpbp.outsBeforePlay = rem.outsBeforePlay
    AND rpbp.runnersBeforePlay = rem.runnersBeforePlay
  INNER JOIN run_expectancy_matrix rem2
    ON rpbp.majorLeagueId = rem2.majorLeagueId
    AND rpbp.seasonId = rem2.seasonId
    AND rpbp.outsAfterPlay = rem2.outsBeforePlay
    AND rpbp.runnersAfterPlay = rem2.runnersBeforePlay
  GROUP BY
    1, 2, 3
)
SELECT
  majorLeagueId,
  seasonId,
  event,
  startRunExpectancy,
  runsScoredInPlay,
  endRunExpectancy,
  runsScoredEndInning,
  endRunExpectancy - startRunExpectancy + runsScoredInPlay runValue
FROM run_expectancies;

COMMIT;

END //

DELIMITER ;
