USE baseball;

DROP PROCEDURE agg_fielding_stats;

DELIMITER //

CREATE PROCEDURE agg_fielding_stats( IN p_grouping_fields VARCHAR(255),
                                     IN p_aggregation_type VARCHAR(255),
                                     OUT insert_stmt VARCHAR(16000)
                                  )
BEGIN

/* Para probar este procedimiento hacer: CALL agg_fielding_stats( 'majorLeagueId', @insert_stmt);  */

SET @insert_stmt = CONCAT('INSERT INTO agg_fielding_stats (',
                            IF( p_aggregation_type = 'CUMULATIVE', 'gameDate,',''),
                            p_grouping_fields,',',
                          ' aggregationType,
                            assists,
                            catcherInterferences,
                            errors,
                            games,
							              putOuts,
                            totalChances,
                            outsPlayed,
                            inningsPlayed,
                            gamesPlayed,
                            groupingId,
                            groupingDescription
                            )
                            WITH stats AS
                            (
                              /* PutOuts, asistencias, etc */
                              SELECT
                              majorLeagueId
                            , seasonId
                            , gameDate
                            , gameType2
                            , venueId
                            , positionAbbrev
                            , IF( halfInning = "top", "home", "away" ) teamType
                            , IF( halfInning = "top", homeTeamId, awayTeamId ) teamId
                            , g.gamePk
                            , playerId
                            , IF( credit LIKE "%assist%", 1, 0 ) assists
                            , IF( credit = "c_catcher_interf", 1, 0 ) catcherInterferences
                            , IF( credit LIKE "%error%", 1,  0 ) errors
                            , IF( credit = "f_putout", 1, 0 ) putOuts
 						                FROM games g
                            INNER JOIN fielding_credits fc
                                ON g.gamePk = fc.gamePk
                            INNER JOIN atbats a
                                ON fc.gamePk = a.gamePk
                                AND fc.atBatIndex = a.atBatIndex
                            WHERE gameType2 IN ("PS","RS")
                            ), outs AS
                            (
                              /* Outs, renombrar variables para agrupaciones */
                              SELECT gamePk outsGamePk, playerId outsPlayerId, positionAbbrev outsPositionAbbrev, outs
                              FROM game_player_fielding_outs
                            ), d AS
                            (
                            SELECT ',
                            IF( p_aggregation_type = 'CUMULATIVE', 'gameDate,',''),
                            p_grouping_fields, ',',
                          ' SUM( assists ) assists,
                            SUM( catcherInterferences ) catcherInterferences,
                            SUM( errors ) errors,
                            COUNT(DISTINCT gamePk) games,
                            SUM( putOuts ) putOuts,
                            SUM( assists + catcherInterferences + errors + putOuts ) totalChances,
                            SUM( outs ) outsPlayed,
                            SUM( outs ) / 3 inningsPlayed,
                            SUM( outs ) / 27 gamesPlayed,
                            agg_grouping_id("', p_grouping_fields, '") groupingId,
                            agg_grouping_description("', p_grouping_fields, '") groupingDescription
                            FROM stats s
                            INNER JOIN  outs o
                            ON s.gamePk = o.outsGamePk
                            AND s.playerId = o.outsPlayerId
                            AND s.positionAbbrev = o.outsPositionAbbrev
                            GROUP BY ',
                                IF( p_aggregation_type = 'CUMULATIVE', 'gameDate,',''),
                                p_grouping_fields,
                            ')
                            SELECT ',
                            IF( p_aggregation_type = 'CUMULATIVE', 'gameDate,',''),
                            p_grouping_fields, ',',
                            IF( p_aggregation_type = 'CUMULATIVE', '"CUMULATIVE",','"AGGREGATED",'),
                          ' SUM( assists ) assists,
                            SUM( catcherInterferences ) catcherInterferences,
                            SUM( errors ) errors,
                            SUM( games ) games,
                            SUM( putOuts ) putOuts,
                            SUM( assists + catcherInterferences + errors + putOuts ) totalChances,
                            SUM( outsPlayed ) outsPlayed,
                            SUM( outsPlayed ) / 3 inningsPlayed,
                            SUM( outsPlayed ) / 27 gamesPlayed,
                            agg_grouping_id("', p_grouping_fields, '") groupingId,
                            agg_grouping_description("', p_grouping_fields, '") groupingDescription
                            FROM d
                            GROUP BY ',
                                IF( p_aggregation_type = 'CUMULATIVE', 'gameDate,',''),
                                p_grouping_fields
                           );
SELECT @insert_stmt;
PREPARE insert_stmt_sql FROM @insert_stmt;
EXECUTE insert_stmt_sql;

UPDATE
  agg_fielding_stats
  SET
    fieldingPercentage = IF(  putOuts + assists + errors > 0, ( putouts + assists ) / ( putOuts + assists + errors ), NULL )
  , rangeFactorPerInning =  ( putOuts + assists ) / inningsPlayed
  , rangeFactorPerGame = ( putOuts + assists ) / gamesPlayed
WHERE groupingId = agg_grouping_id(p_grouping_fields);

COMMIT;

END //

DELIMITER ;
