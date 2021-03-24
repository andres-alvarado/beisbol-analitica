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
    events,
    runValue
  )
WITH /* Matriz de Expectativa de Carrera */
run_expectancy_matrix AS (
  SELECT
    majorLeagueId,
    seasonId,
    outsBeforePlay,
    runnersBeforePlay,
    ( SUM(runsScoredEndInning) - SUM( runsScoredBeforePlay ) ) / COUNT(1) runExpectancy
  FROM rem_play_by_play
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
      When event IN ('Pickoff Caught Stealing Home') THEN 'Caught Stealing Home'
      WHEN event IN ('Sac Bunt Double Play') THEN 'Sac Bunt'
      ELSE event
    END event
  FROM rem_play_by_play

  UNION ALL

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
    'Out' AS event
  FROM rem_play_by_play
  WHERE event IN (
        'Field Out',
        'Flyout',
        'Forceout',
        'Groundout',
        'Fielders Choice Out',
        'Lineout',
        'Pop Out',
        'Runner Out',
        'Sac Bunt Double Play',
        'Sac Bunt',
        'Bunt Groundout',
        'Bunt Lineout',
        'Bunt Pop Out',
        'Sac Fly Double Play',
        'Sac Fly',
        'Strikeout Double Play',
        'Strikeout Triple Play',
        'Strikeout',
        'Grounded Into DP',
        'Runner Double Play',
        'Double Play',
        'Pickoff Caught Stealing 2B',
        'Caught Stealing 2B',
        'Pickoff Caught Stealing 3B',
        'Caught Stealing 3B',
        'Pickoff Caught Stealing Home',
        'Caught Stealing Home',
        'Field Out',
        'Fielders Choice',
        'Pickoff 1B',
        'Pickoff 2B',
        'Pickoff 3B'
      )
),
/* Calcular run expectancies al inicio, durante y final de jugada */
run_expectancies AS (
  SELECT
    rpbp.majorLeagueId,
    rpbp.seasonId,
    rpbp.event,
    SUM(rem.runExpectancy) startRunExpectancy,
    SUM(runsScoredInPlay) runsScoredInPlay,
    SUM(rem2.runExpectancy) endRunExpectancy,
    COUNT(1) events
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
  events,
  ( endRunExpectancy - startRunExpectancy + runsScoredInPlay ) / events runValue
FROM run_expectancies;

COMMIT;

END //

DELIMITER ;
