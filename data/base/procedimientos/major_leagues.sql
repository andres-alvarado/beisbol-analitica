USE baseball;

DROP PROCEDURE major_leagues;

DELIMITER //

CREATE PROCEDURE major_leagues()
BEGIN

INSERT INTO major_leagues(
    majorLeagueId,
    majorLeague
)
SELECT DISTINCT majorLeagueId, majorLeague
FROM stg_game_context
WHERE majorLeagueId NOT  IN (
    SELECT majorLeagueId
    FROM games
);

COMMIT;

END //

DELIMITER ;
