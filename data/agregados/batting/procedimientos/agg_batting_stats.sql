USE baseball;

DROP PROCEDURE agg_batting_stats;

DELIMITER //

CREATE PROCEDURE agg_batting_stats( IN p_grouping_fields VARCHAR(255), OUT insert_stmt VARCHAR(16000))
BEGIN

/* Para probar este procedimiento hacer: CALL agg_batting_stats( 'majorLeagueId', @insert_stmt);  */

SET @insert_stmt = CONCAT('INSERT INTO agg_batting_stats (', p_grouping_fields,',',
                          ' games
                            atBats,
                            walks,
                            catchersInterference,
                            caughtStealing,
                            doubles,
                            flyOuts,
                            groundIntoDoublePlay,
                            groundIntoTriplePlay,
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
                            strikeOuts,
                            totalBases,
                            triples,
                            unintentionalWalks,
                            battingAverage,
                            isolatedPower,
                            secondBattingAverage,
                            extraBaseHitPercentage,
                            sluggingPercentage,
                            stolenBasePercentage,
                            atBatsPerHomeRunsPercentage,
                            walksPerStrikeOutsPercentage,
                            onBasePercentage,
                            onBasePlusSluggingPercentage,
                            walksPerPlateAppearancesPercentage,
                            strikeOutsPerPlateAppearancesPercentage,
                            homeRunsPerPlateAppearancesPercentage,
                            extraBasePercentage,
                            inPlayPercentage,
                            runsCreated,
                            powerSpeed,
                            runScoredPercentage,
                            battedBallsInPlayPercentage,
                            grouping_id,
                            grouping_description
                            )
                            WITH stats AS (
                            SELECT ', p_grouping_fields, ',',
                            '   COUNT(DISTINCT g.gamePk) AS games,
                                SUM(atBats) AS atBats,
                                SUM(walks) AS walks,
                                SUM(catchersInterference) AS catchersInterference,
                                SUM(caughtStealing) AS caughtStealing,
                                SUM(doubles) AS doubles,
                                SUM(flyOuts) AS flyOuts,
                                SUM(groundIntoDoublePlay) AS groundIntoDoublePlay,
                                SUM(groundIntoTriplePlay) AS groundIntoTriplePlay,
                                SUM(groundOuts) AS groundOuts,
                                SUM(hitByPitch) AS hitByPitch,
                                SUM(hits) AS hits,
                                SUM(homeRuns) AS homeRuns,
                                SUM(intentionalWalks) AS intentionalWalks,
                                SUM(leftOnBase) AS leftOnBase,
                                SUM(pickoffs) AS pickoffs,
                                SUM(rbi) AS rbi,
                                SUM(runs) AS runs,
                                SUM(sacBunts) AS sacBunts,
                                SUM(sacFlies) AS sacFlies,
                                SUM(stolenBases) AS stolenBases,
                                SUM(strikeOuts) AS strikeOuts,
                                SUM(totalBases) AS totalBases,
                                SUM(triples) AS triples,
                                SUM(hits - homeRuns - doubles - triples) AS singles,
                                SUM(atBats + sacBunts + sacFlies + walks + hitByPitch) AS plateAppearances,
                                SUM(walks - intentionalWalks) AS unintentionalWalks
                            FROM games g
                            INNER JOIN game_player_batting_stats bs
                                ON g.gamePk = bs.gamePk
                            WHERE gameType2 IN ("PS","RS")
                            GROUP BY ',
                                p_grouping_fields,
                           '),
                            advanced_stats AS (
                            SELECT
                                *,
                                IF(atBats > 0, hits / atBats, NULL) battingAverage,
                                IF(atBats > 0, (doubles + 2 * triples + 3 * homeRuns) / atBats, NULL) isolatedPower,
                                IF(
                                atBats > 0,
                                (walks + doubles + 2 * triples + 3 * homeRuns + stolenBases - caughtStealing) / atBats,
                                NULL
                                ) secondBattingAverage,
                                IF(hits > 0, (doubles + triples + homeRuns) / hits, NULL) extraBaseHitPercentage,
                                IF(atBats > 0, totalBases / atBats, NULL) sluggingPercentage,
                                caughtStealing + stolenBases stolenBaseAttempts,
                                IF(
                                caughtStealing + stolenBases > 0,
                                stolenBases / (caughtStealing + stolenBases),
                                NULL
                                ) stolenBasePercentage,
                                IF(homeRuns > 0, atBats / homeRuns, NULL) atBatsPerHomeRunsPercentage,
                                IF(strikeOuts > 0, walks / strikeOuts, NULL) walksPerStrikeOutsPercentage,
                                IF(plateAppearances > 0, (hits + walks + hitByPitch) / plateAppearances, NULL) onBasePercentage,
                                IF(plateAppearances > 0, (hits + walks + hitByPitch) / plateAppearances, 0 )
                              + IF(atBats > 0, totalBases / atBats, 0) onBasePlusSluggingPercentage,
                                IF(plateAppearances > 0, walks / plateAppearances, NULL) walksPerPlateAppearancesPercentage,
                                IF(plateAppearances > 0, strikeOuts / plateAppearances, NULL) strikeOutsPerPlateAppearancesPercentage,
                                IF(plateAppearances > 0, homeRuns / plateAppearances, NULL) homeRunsPerPlateAppearancesPercentage,
                                IF(plateAppearances > 0, (doubles + triples + homeRuns) / plateAppearances, NULL) extraBasePercentage,
                                IF(
                                plateAppearances > 0,
                                (atBats - strikeOuts - homeRuns - sacFlies) / plateAppearances,
                                NULL
                                ) inPlayPercentage,
                                IF(
                                walks + atBats > 0,
                                (singles + doubles + triples + homeRuns + walks) * (
                                    singles + 2 * doubles + 3 * triples + 4 * homeRuns
                                ) / (atBats + walks),
                                NULL
                                ) runsCreated,
                                IF(
                                homeRuns + stolenBases > 0,
                                2 * homeRuns * stolenBases / (homeRuns + stolenBases),
                                NULL
                                ) powerSpeed,
                                IF(
                                singles + doubles + triples + homeRuns + walks + hitByPitch - homeRuns > 0,
                                (runs - homeRuns) / (
                                    singles + doubles + triples + homeRuns + walks + hitByPitch - homeRuns
                                ),
                                NULL
                                ) runScoredPercentage,
                                IF(
                                atBats - strikeOuts - homeRuns - sacFlies > 0,
                                (singles + doubles + triples) / (atBats - strikeOuts - homeRuns + sacFlies),
                                NULL
                                ) battedBallsInPlayPercentage
                            FROM stats
                            )
                            SELECT ', p_grouping_fields,',',
                          ' games
                            atBats,
                            walks,
                            catchersInterference,
                            caughtStealing,
                            doubles,
                            flyOuts,
                            groundIntoDoublePlay,
                            groundIntoTriplePlay,
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
                            strikeOuts,
                            totalBases,
                            triples,
                            unintentionalWalks,
                            battingAverage,
                            isolatedPower,
                            secondBattingAverage,
                            extraBaseHitPercentage,
                            sluggingPercentage,
                            stolenBasePercentage,
                            atBatsPerHomeRunsPercentage,
                            walksPerStrikeOutsPercentage,
                            onBasePercentage,
                            onBasePlusSluggingPercentage,
                            walksPerPlateAppearancesPercentage,
                            strikeOutsPerPlateAppearancesPercentage,
                            homeRunsPerPlateAppearancesPercentage,
                            extraBasePercentage,
                            inPlayPercentage,
                            runsCreated,
                            powerSpeed,
                            runScoredPercentage,
                            battedBallsInPlayPercentage,
                            agg_grouping_id("', p_grouping_fields, '") grouping_id,
                            agg_grouping_description("', p_grouping_fields, '") grouping_description
                            FROM advanced_stats a
                            ');

SELECT @insert_stmt;
PREPARE insert_stmt_sql FROM @insert_stmt;
EXECUTE insert_stmt_sql;

END //

DELIMITER ;
