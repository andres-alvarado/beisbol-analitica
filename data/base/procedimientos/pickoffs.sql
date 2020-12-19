USE baseball;

DROP PROCEDURE pickoffs;

DELIMITER //

CREATE PROCEDURE pickoffs()
BEGIN

INSERT INTO pickoffs(
    gamePk,
    atBatIndex,
    playIndex,
    outs,
    balls,
    strikes,
    fromCatcher,
    hasReview,
    baseCode
  )
SELECT
  gamePk,
  atBatIndex,
  `index` playIndex,
  outs,
  balls,
  strikes,
  fromCatcher,
  hasReview,
  code baseCode
FROM stg_play_pickoff
WHERE
  1 = 1
  AND (gamePk, atBatIndex) NOT IN (
    SELECT
      gamePk,
      atBatIndex
    FROM pickoffs
  );

COMMIT;

END //

DELIMITER ;
