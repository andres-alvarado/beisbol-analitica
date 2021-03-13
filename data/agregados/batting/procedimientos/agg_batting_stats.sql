USE baseball;

DROP PROCEDURE agg_batting_stats;

DELIMITER //

CREATE PROCEDURE agg_batting_stats( IN p_grouping_fields VARCHAR(255), OUT insert_stmt VARCHAR(16000))
BEGIN

/* Para probar este procedimiento hacer: CALL agg_batting_stats( 'majorLeagueId', @insert_stmt);  */

SET @insert_stmt = CONCAT('INSERT INTO agg_batting_stats (', p_grouping_fields,',',
                          ' atBats,
                            walks,
                            catcherInterferences,
                            caughtStealing,
                            doubles,
                            flyOuts,
                            games,
                            groundedIntoDoublePlays,
                            groundedIntoTriplePlays,
                            groundOuts,
                            hitByPitch,
                            hits,
                            homeRuns,
                            intentionalWalks,
                            leftOnBase,
                            pickoffs,
                            plateAppearances,
                            rbi,
                            runs,
                            sacBunts,
                            sacFlies,
                            singles,
                            stolenBases,
                            stolenBaseAttempts,
                            strikeOuts,
                            totalBases,
                            triples,
                            unintentionalWalks,
                            groupingId,
                            groupingDescription
                            )
                            SELECT ', p_grouping_fields, ',',
                            '   SUM(atBats) AS atBats,
                                SUM(walks) AS walks,
                                SUM(catchersInterference) AS catcherInterferences,
                                SUM(caughtStealing) AS caughtStealing,
                                SUM(doubles) AS doubles,
                                SUM(flyOuts) AS flyOuts,
                                COUNT(DISTINCT g.gamePk) AS games,
                                SUM(groundIntoDoublePlay) AS groundedIntoDoublePlays,
                                SUM(groundIntoTriplePlay) AS groundedIntoTriplePlays,
                                SUM(groundOuts) AS groundOuts,
                                SUM(hitByPitch) AS hitByPitch,
                                SUM(hits) AS hits,
                                SUM(homeRuns) AS homeRuns,
                                SUM(intentionalWalks) AS intentionalWalks,
                                SUM(leftOnBase) AS leftOnBase,
                                SUM(pickoffs) AS pickoffs,
                                SUM(atBats) + SUM(sacBunts) + SUM(sacFlies) + SUM(walks) + SUM(hitByPitch) AS plateAppearances,
                                SUM(rbi) AS rbi,
                                SUM(runs) AS runs,
                                SUM(sacBunts) AS sacBunts,
                                SUM(sacFlies) AS sacFlies,
                                SUM(hits) - SUM(homeRuns) - SUM(doubles) - SUM(triples) AS singles,
                                SUM(stolenBases) AS stolenBases,
                                SUM(caughtStealing) + SUM(stolenBases) stolenBaseAttempts,
                                SUM(strikeOuts) AS strikeOuts,
                                SUM(singles) + SUM(doubles)*2 + SUM(triples)*3 + SUM(homeRuns)*4 totalBases,
                                SUM(triples) AS triples,
                                SUM(walks) - SUM(intentionalWalks) AS unintentionalWalks,
                                agg_grouping_id("', p_grouping_fields, '") groupingId,
                                agg_grouping_description("', p_grouping_fields, '") groupingDescription
                            FROM games g
                            INNER JOIN game_player_batting_stats bs
                                ON g.gamePk = bs.gamePk
                            WHERE gameType2 IN ("PS","RS")
                            GROUP BY ',
                                p_grouping_fields
                        );

SELECT @insert_stmt;
PREPARE insert_stmt_sql FROM @insert_stmt;
EXECUTE insert_stmt_sql;

END //

DELIMITER ;
