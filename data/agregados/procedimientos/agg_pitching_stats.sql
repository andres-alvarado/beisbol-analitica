USE baseball;

DROP PROCEDURE agg_pitching_stats;

DELIMITER //

CREATE PROCEDURE agg_pitching_stats( IN p_grouping_fields VARCHAR(255), OUT insert_stmt VARCHAR(16000))
BEGIN

/* Para probar este procedimiento hacer: CALL agg_pitching_stats( 'majorLeagueId', @insert_stmt);  */

SET @insert_stmt = CONCAT('INSERT INTO agg_pitching_stats (', p_grouping_fields,',',
                          ' airOuts,
                            atBats,
                            balls,
                            walks,
                            battersFaced,
                            blownSaves,
                            catchersInterference,
                            caughtStealing,
                            completeGames,
                            doubles,
                            earnedRuns,
                            gamesFinished,
                            gamesPitched,
                            gamesPlayed,
                            gamesStarted,
                            groundOuts,
                            hitBatsmen,
                            hits,
                            holds,
                            homeRuns,
                            inheritedRunners,
                            inheritedRunnersScored,
                            intentionalWalks,
                            losses,
                            numberOfPitches,
                            outs,
                            pickoffs,
                            pitchesThrown,
                            plateAppearances,
                            rbi,
                            runs,
                            sacBunts,
                            sacFlies,
                            saveOpportunities,
                            saves,
                            singles,
                            shutouts,
                            stolenBases,
                            strikeOuts,
                            strikes,
                            totalBases,
                            triples,
                            unintentionalWalks,
                            wildPitches,
                            wins,
                            groupingId,
                            groupingDescription
                            )
                            SELECT ', p_grouping_fields, ',',
                            '   SUM(airOuts) airOuts,
                                SUM(atBats) atBats,
                                SUM(balls) balls,
                                SUM(walks) walks,
                                SUM(battersFaced) battersFaced,
                                SUM(blownSaves) blownSaves,
                                SUM(catchersInterference) catchersInterference,
                                SUM(caughtStealing) caughtStealing,
                                SUM(completeGames) completeGames,
                                SUM(doubles) doubles,
                                SUM(earnedRuns) earnedRuns,
                                SUM(gamesFinished) gamesFinished,
                                SUM(gamesPitched) gamesPitched,
                                SUM(gamesPlayed) gamesPlayed,
                                SUM(gamesStarted) gamesStarted,
                                SUM(groundOuts) groundOuts,
                                SUM(hitBatsmen) hitBatsmen,
                                SUM(hits) hits,
                                SUM(holds) holds,
                                SUM(homeRuns) homeRuns,
                                SUM(inheritedRunners) inheritedRunners,
                                SUM(inheritedRunnersScored) inheritedRunnersScored,
                                SUM(intentionalWalks) intentionalWalks,
                                SUM(losses) losses,
                                SUM(numberOfPitches) numberOfPitches,
                                SUM(outs) outs,
                                SUM(pickoffs) pickoffs,
                                SUM(pitchesThrown) pitchesThrown,
                                SUM(plateAppearances) plateAppearances,
                                SUM(rbi) rbi,
                                SUM(runs) runs,
                                SUM(sacBunts) sacBunts,
                                SUM(sacFlies) sacFlies,
                                SUM(saveOpportunities) saveOpportunities,
                                SUM(saves) saves,
                                SUM(singles) singles,
                                SUM(shutouts) shutouts,
                                SUM(stolenBases) stolenBases,
                                SUM(strikeOuts) strikeOuts,
                                SUM(strikes) strikes,
                                SUM(triples) triples,
                                SUM(unintentionalWalks) unintentionalWalks,
                                SUM(wildPitches) wildPitches,
                                SUM(wins) wins,
                                SUM(singles) + SUM(doubles)*2 + SUM(triples)*3 + SUM(homeRuns)*4 totalBases,
                                agg_grouping_id("', p_grouping_fields, '") grouping_id,
                                agg_grouping_description("', p_grouping_fields, '") grouping_description
                            FROM games g
                            INNER JOIN game_player_pitching_stats bs
                                ON g.gamePk = bs.gamePk
                            WHERE gameType2 IN ("PS","RS")
                            GROUP BY ',
                                p_grouping_fields
                        );

SELECT @insert_stmt;
PREPARE insert_stmt_sql FROM @insert_stmt;
EXECUTE insert_stmt_sql;

UPDATE
  agg_pitching_stats
  SET
    strikeOutsPerNineInnings = IF(outs > 0, strikeouts * 27 / outs, NULL)
  , walksPerNineInnings = IF(outs > 0, walks * 27 / outs, NULL)
  , homeRunsPerNineInnings = IF(outs > 0, homeRuns * 27 / outs, NULL)
  , runsPerNineInnings = IF(outs > 0, runs * 27 / outs, NULL)
  , earnedRunsPerNineInnings = IF(outs > 0, earnedRuns * 27 / outs, NULL)
  , walksHitsPerInning = IF(outs > 0, (hits + walks) * 3 / outs, NULL)
  , fieldIndepedentPitching =  IF(outs > 0, (13 * homeRuns + 3 * (walks + hitBatsmen) - 2 * strikeOuts) * 3 / outs, NULL )
  , strikeOutPerBattersFaced = IF(battersFaced > 0, strikeOuts / battersFaced, NULL)
  , baseOnBallsPerBattersFaced = IF(battersFaced > 0, walks / battersFaced, NULL)
  , strikeOutsWalksPercentage = IF(battersFaced > 0, (strikeOuts - walks) / battersFaced, NULL)
  , strikeOutsPerWalksPercentage = IF(walks > 0, strikeOuts / walks, NULL)
  , leftOnBasePercentage = IF(hits + walks + hitBatsmen - 1.4 * homeRuns > 0, (hits + walks + hitBatsmen - runs) / (hits + walks + hitBatsmen - 1.4 * homeRuns), NULL)
  , opponentsBattingAverage = IF(atbats > 0, hits / atBats, NULL)
  , battedBallsInPlayPercentage = IF(atBats - strikeOuts - homeRuns - sacFlies > 0, (singles + doubles + triples) / (atBats - strikeOuts - homeRuns - sacFlies), NULL)
  , sluggingPercentage = IF(atBats > 0, totalBases / atBats, NULL)
  , stolenBasePercentage = IF(caughtStealing + stolenBases > 0, stolenBases / (caughtStealing + stolenBases), NULL)
  , onBasePercentage = IF(plateAppearances > 0, (hits + walks + hitBatsmen) / plateAppearances, NULL)
  , onBasePlusSluggingPercentage = IF(plateAppearances > 0, (hits + walks + hitBatsmen) / plateAppearances, 0) + IF(atbats > 0, totalBases / atBats, 0)
  , isolatedPower = IF(atBats > 0, (doubles + 2 * triples + 3 * homeRuns) / atBats, NULL)
WHERE groupingId = agg_grouping_id(p_grouping_fields);

COMMIT;

END //

DELIMITER ;
