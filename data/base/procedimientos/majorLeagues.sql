USE baseball;

DROP PROCEDURE majorLeagues;

DELIMITER //

CREATE PROCEDURE majorLeagues()
BEGIN

INSERT INTO majorLeagues(
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
