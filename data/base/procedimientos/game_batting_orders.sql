USE baseball;

DROP PROCEDURE game_batting_orders;

DELIMITER //

CREATE PROCEDURE game_batting_orders()
BEGIN

INSERT INTO game_batting_orders(
    gamePk,
    teamId,
    playerId,
    battingOrder
  )
SELECT DISTINCT
  gamePk,
  teamId,
  playerId,
  /* Data issue, MLB */
  CASE WHEN gamePk = 237178 AND teamId = 2291 AND playerId =  534721 THEN 2
  ELSE battingOrder
  END battingOrder
FROM stg_box_team_batting_order
WHERE
  gamePk NOT IN (
    SELECT
      gamePk
    FROM game_batting_orders
  );

COMMIT;

END //

DELIMITER ;
