USE baseball;

DROP PROCEDURE game_player_fielding_outs;

DELIMITER //

CREATE PROCEDURE game_player_fielding_outs()
BEGIN

INSERT INTO game_player_fielding_outs(gamePk, teamId, playerId, positionAbbrev, outs)
  WITH ab AS (
    /* Obtener numero de outs en el partido */
    SELECT
      gamePk,
      halfInning,
      MAX(inning + endOuts * .1) gameInningOuts
    FROM atbats
    GROUP BY
      1, 2
  ),
  gps AS (
    /* Obtener todos los jugadores que no sean DH, PR, PH */
    SELECT
      gamePk,
      teamId,
      IF(teamType = 'away', 'bottom', 'top') halfInning,
      positionAbbrev,
      playerId
    FROM game_player_positions
    WHERE
      positionAbbrev NOT IN ('DH', 'PR', 'PH')
  ),
  ds AS (
    /* Obtener todas las sustituciones */
    SELECT
      gamePk,
      inning,
      outs,
      halfInning,
      pitchingTeamId AS teamId,
      positionAbbrev,
      playerId,
      substitutingPlayerId,
      substitutingInning,
      substitutingOuts
    FROM defensive_substitutions
  ),
  ns AS (
    /* Obtener jugadores que no fueron sustituidos */
    SELECT
      gps.*
    FROM gps
    LEFT JOIN ds
      ON gps.gamePk = ds.gamePk
      AND (
        gps.playerId = ds.playerId
        OR gps.playerId = ds.substitutingPlayerId
      )
    WHERE
      ds.playerId IS NULL
      AND ds.substitutingPlayerId IS NULL
  ),
  sns AS (
    /* Unir jugadores sustituidos con no sustituidos*/
    SELECT
      gamePk,
      inning,
      outs,
      halfInning,
      teamId,
      positionAbbrev,
      playerId,
      substitutingInning,
      substitutingOuts
    FROM ds

    UNION ALL

    SELECT
      gamePk,
      1 inning,
      0 outs,
      halfInning,
      teamId,
      positionAbbrev,
      playerId,
      NULL substitutingInning,
      NULL substitutingOuts
    FROM ns
  ),
  ab_sns AS (
    /* Obtener start inning y end inning the cada sustitucion*/
    SELECT
      sns.*,
      CAST(
        SUBSTR(ab.gameInningOuts, 1, Instr(ab.gameInningOuts, '.') - 1) AS UNSIGNED
      ) gameInnings,
      CAST(
        SUBSTR(ab.gameInningOuts, Instr(ab.gameInningOuts, '.') + 1) AS UNSIGNED
      ) gameOuts
    FROM sns
    INNER JOIN ab
      ON sns.gamePk = ab.gamePk
      AND sns.halfInning = ab.halfInning
  ),
  op AS (
    /* Obtener outs jugados */
    SELECT
      gamePk,
      teamId,
      playerId,
      positionAbbrev,
      CASE
        WHEN substitutingInning IS NULL THEN (gameInnings - inning) * 3 + gameOuts - outs
        WHEN substitutingInning IS NOT NULL THEN (substitutingInning - inning) * 3
          + substitutingOuts - outs
      END outs
    FROM ab_sns
  )
SELECT
  gamePk,
  teamId,
  playerId,
  positionAbbrev,
  SUM(outs) outs
FROM op
GROUP BY
  1, 2, 3, 4
HAVING
  SUM(outs) > 0;

COMMIT;

END //

DELIMITER ;
