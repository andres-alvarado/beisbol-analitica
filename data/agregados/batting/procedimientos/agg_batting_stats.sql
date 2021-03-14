USE baseball;

DROP PROCEDURE agg_batting_stats;

DELIMITER //

CREATE PROCEDURE agg_batting_stats( IN p_grouping_fields VARCHAR(255), OUT insert_stmt VARCHAR(16000))
BEGIN

/* Para probar este procedimiento hacer: CALL agg_batting_stats( 'majorLeagueId', @insert_stmt);  */

SET @insert_stmt = CONCAT('INSERT INTO agg_batting_stats (', p_grouping_fields,',',
                          ' atBats,
                            balks,
                            batterInterferences,
                            bunts,
                            catcherInterferences,
                            caughtStealing,
                            doubles,
                            fanInterferences,
                            fieldErrors,
                            fieldersChoice,
                            flyOuts,
                            forceOuts,
                            games,
                            groundedIntoDoublePlays,
                            groundedIntoTriplePlays,
                            groundOuts,
                            hitByPitch,
                            hits,
                            homeRuns,
                            intentionalWalks,
                            leftOnBase,
                            lineOuts,
                            passedBalls,
                            pickoffs,
                            popOuts,
                            runsBattedIn,
                            runs,
                            sacBunts,
                            sacFlies,
                            stolenBases,
                            strikeOuts,
                            triples,
                            walks,
                            wildPitches,
                            groupingId,
                            groupingDescription
                            )
                            WITH game_split_stats AS
                            (
                            SELECT
                                gamePk,
                                batterId,
                                SUM(balks) AS balks,
                                SUM(batterInterferences) AS batterInterferences,
                                SUM(bunts) AS bunts,
                                SUM(fanInterferences) AS fanInterferences,
                                SUM(fieldErrors) AS fieldErrors,
                                SUM(fieldersChoice) AS fieldersChoice,
                                SUM(forceOuts) AS forceOuts,
                                SUM(lineOuts) AS lineOuts,
                                SUM(passedBalls) AS passedBalls,
                                SUM(popOuts) AS popOuts,
                                SUM(wildPitches) AS wildPitches
                            FROM game_player_split_stats
                            GROUP BY 1, 2
                            )
                            SELECT ', p_grouping_fields, ',',
                            '   SUM(atBats) AS atBats,
                                SUM(balks) AS balks,
                                SUM(batterInterferences) AS batterInterferences,
                                SUM(bunts) AS bunts,
                                SUM(catchersInterference) AS catcherInterferences,
                                SUM(caughtStealing) AS caughtStealing,
                                SUM(doubles) AS doubles,
                                SUM(fanInterferences) AS fanInterferences,
                                SUM(fieldErrors) AS fieldErrors,
                                SUM(fieldersChoice) AS fieldersChoice,
                                SUM(flyOuts) AS flyOuts,
                                SUM(forceOuts) AS forceOuts,
                                COUNT(DISTINCT g.gamePk) AS games,
                                SUM(groundIntoDoublePlay) AS groundedIntoDoublePlays,
                                SUM(groundIntoTriplePlay) AS groundedIntoTriplePlays,
                                SUM(groundOuts) AS groundOuts,
                                SUM(hitByPitch) AS hitByPitch,
                                SUM(hits) AS hits,
                                SUM(homeRuns) AS homeRuns,
                                SUM(intentionalWalks) AS intentionalWalks,
                                SUM(leftOnBase) AS leftOnBase,
                                SUM(lineOuts) AS lineOuts,
                                SUM(passedBalls) AS passedBalls,
                                SUM(pickoffs) AS pickoffs,
                                SUM(popOuts) AS popOuts,
                                SUM(rbi) AS runsBattedIn,
                                SUM(runs) AS runs,
                                SUM(sacBunts) AS sacBunts,
                                SUM(sacFlies) AS sacFlies,
                                SUM(stolenBases) AS stolenBases,
                                SUM(strikeOuts) AS strikeOuts,
                                SUM(triples) AS triples,
                                SUM(walks) AS walks,
                                SUM(wildPitches) AS wildPitches,
                                agg_grouping_id("', p_grouping_fields, '") groupingId,
                                agg_grouping_description("', p_grouping_fields, '") groupingDescription
                            FROM games g
                            INNER JOIN game_player_batting_stats bs
                                ON g.gamePk = bs.gamePk
                            INNER JOIN game_split_stats ss
                                ON bs.gamePk = ss.gamePk
                                AND bs.playerId = ss.batterId
                            WHERE gameType2 IN ("PS","RS")
                            GROUP BY ',
                                p_grouping_fields
                        );

SELECT @insert_stmt;
PREPARE insert_stmt_sql FROM @insert_stmt;
EXECUTE insert_stmt_sql;

END //

DELIMITER ;
