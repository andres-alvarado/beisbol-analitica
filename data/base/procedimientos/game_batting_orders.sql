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
SELECT
  gamePk,
  teamId,
  playerId,
  battingOrder
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
