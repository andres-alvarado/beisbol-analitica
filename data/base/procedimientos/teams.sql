USE baseball;

DROP PROCEDURE teams;

DELIMITER //

CREATE PROCEDURE teams()
BEGIN

INSERT INTO teams(
    majorLeagueId,
    divisionId,
    seasonId,
    teamId,
    teamAbbreviation,
    teamCode,
    teamShortName,
    teamFullName,
    teamName,
    leagueName,
    venueId,
    venueName,
    locationName
  )
  SELECT DISTINCT
  leagueId,
  divisionId,
  COALESCE(season, 0) seasonId,
  id AS teamId,
  abbreviation teamAbbreviation,
  teamCode,
  shortName teamShortName,
  name teamFullName,
  teamName,
  leagueName,
  venueId,
  venueName,
  /* Problema con la temporada 2019 de LBPRC y LIDOM */
  CASE
    WHEN season = 2019 AND teamName = 'Santurce' THEN 'Santurce'
    WHEN locationName = 'Santo Dominigo' THEN 'Santo Domingo'
    ELSE locationName
  END locationName
FROM stg_box_team
WHERE
  1 = 1
  AND (leagueId, COALESCE(season, 0), teamId) NOT IN (
    SELECT
      leagueId,
      seasonId,
      teamId
    FROM teams
  );

COMMIT;

END //

DELIMITER ;
