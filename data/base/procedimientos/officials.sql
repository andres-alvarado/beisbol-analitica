USE baseball;

DROP PROCEDURE officials;

DELIMITER //

CREATE PROCEDURE officials()
BEGIN

INSERT INTO officials(
    officialId,
    firstName,
    lastName,
    birthDate,
    birthCity,
    birthStateProvince,
    birthCountry
  )
SELECT DISTINCT
  id officialId,
  firstName,
  lastName,
  birthDate,
  birthCity,
  birthStateProvince,
  birthCountry
FROM stg_officials
WHERE
  1 = 1
  AND id NOT IN (
    SELECT
      officialId
    FROM officials
  );

COMMIT;

END //

DELIMITER ;
