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


UPDATE
  agg_batting_stats
  SET
    battingAverage = IF(atBats > 0, hits / atBats, NULL)
  , isolatedPower = IF(atBats > 0, (doubles + 2 * triples + 3 * homeRuns) / atBats, NULL)
  , secondBattingAverage = IF(atBats > 0, (walks + doubles + 2 * triples + 3 * homeRuns + stolenBases - caughtStealing) / atBats, NULL)
  , extraBaseHitPercentage = IF(hits > 0, (doubles + triples + homeRuns) / hits, NULL)
  , sluggingPercentage = IF(atBats > 0, totalBases / atBats, NULL)
  , stolenBasePercentage = IF(stolenBaseAttempts > 0, stolenBases / stolenBaseAttempts, NULL)
  , atBatsPerHomeRunsPercentage = IF(homeRuns > 0, atBats / homeRuns, NULL)
  , walksPerStrikeOutsPercentage = IF(strikeOuts > 0, walks / strikeOuts, NULL)
  , onBasePercentage = IF(plateAppearances > 0, (hits + walks + hitByPitch) / plateAppearances, NULL)
  , onBasePlusSluggingPercentage = IF(plateAppearances > 0, (hits + walks + hitByPitch) / plateAppearances, 0 ) + IF(atBats > 0, totalBases / atBats, 0)
  , walksPerPlateAppearancesPercentage = IF(plateAppearances > 0, walks / plateAppearances, NULL)
  , strikeOutsPerPlateAppearancesPercentage = IF(plateAppearances > 0, strikeOuts / plateAppearances, NULL)
  , homeRunsPerPlateAppearancesPercentage = IF(plateAppearances > 0, homeRuns / plateAppearances, NULL)
  , extraBasePercentage = IF(plateAppearances > 0, (doubles + triples + homeRuns) / plateAppearances, NULL)
  , inPlayPercentage = IF(plateAppearances > 0, (atBats - strikeOuts - homeRuns - sacFlies) / plateAppearances, NULL)
  , runsCreated = IF(walks + atBats > 0, (singles + doubles + triples + homeRuns + walks) * totalBases / (atBats + walks), NULL)
  , powerSpeed = IF(homeRuns + stolenBases > 0, 2 * homeRuns * stolenBases / (homeRuns + stolenBases), NULL)
  , runScoredPercentage = IF(singles + doubles + triples + homeRuns + walks + hitByPitch - homeRuns > 0, (runs - homeRuns) / (singles + doubles + triples + homeRuns + walks + hitByPitch - homeRuns), NULL)
  , battedBallsInPlayPercentage = IF(atBats - strikeOuts - homeRuns - sacFlies > 0,(singles + doubles + triples) / (atBats - strikeOuts - homeRuns + sacFlies), NULL)
WHERE groupingId = agg_grouping_id(p_grouping_fields);

END //

DELIMITER ;
