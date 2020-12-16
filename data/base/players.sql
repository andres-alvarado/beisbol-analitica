USE baseball;

DROP PROCEDURE players;

DELIMITER //

CREATE PROCEDURE players()
BEGIN

INSERT INTO players(
    playerId,
    firstName,
    lastName,
    birthDate,
    birthCity,
    birthStateProvince,
    birthCountry,
    strikeZoneTop,
    strikeZoneBottom,
    positionAbbrev,
    batSide,
    pitchHand
  )
SELECT DISTINCT
  id playerId,
  firstName,
  lastName,
  birthDate,
  birthCity,
  birthStateProvince,
  birthCountry,
  strikeZoneTop,
  strikeZoneBottom,
  abbreviation,
  batSideCode batSide,
  pitchHandCode pitchHand
FROM stg_people
WHERE
  1 = 1
  AND id NOT IN (
    SELECT
      playerId
    FROM players
  );

COMMIT;

END //

DELIMITER ;
