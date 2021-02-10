USE baseball;

DROP PROCEDURE batting_orders;

DELIMITER //

CREATE PROCEDURE batting_orders()
BEGIN

INSERT INTO batting_orders(
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
    FROM batting_orders
  );

COMMIT;

END //

DELIMITER ;
