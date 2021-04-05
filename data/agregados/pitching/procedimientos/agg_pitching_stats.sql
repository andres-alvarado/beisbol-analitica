USE baseball;

DROP PROCEDURE agg_pitching_stats;

DELIMITER //

CREATE PROCEDURE agg_pitching_stats( IN p_grouping_fields VARCHAR(255), OUT insert_stmt VARCHAR(16000))
BEGIN

/* Para probar este procedimiento hacer: CALL agg_pitching_stats( 'majorLeagueId', @insert_stmt);  */

SET @insert_stmt = CONCAT('INSERT INTO agg_pitching_stats (', p_grouping_fields,',',
                          ' airOuts,
                            atBats,
                            walks,
                            battersFaced,
                            blownSaves,
                            catcherInterferences,
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
                            triples,
                            unintentionalWalks,
                            wildPitches,
                            wins,
                            -- Coming from the pitches tables
                            balls,
                            ballsPitchOut,
                            ballsInDirt,
                            intentBalls,
                            fouls,
                            foulBunts,
                            foulTips,
                            foulPitchOuts,
                            hitIntoPlay,
                            pitches,
                            pitchOuts,
                            strikes,
                            strikesCalled,
                            strikesPitchOuts,
                            missedBunts,
                            swingAndMissStrikes,
                            swingsPitchOuts,
                            swings,
                            swingsZeroAndZero,
                            swingsZeroAndOne,
                            swingsZeroAndTwo,
                            swingsOneAndZero,
                            swingsOneAndOne,
                            swingsOneAndTwo,
                            swingsTwoAndZero,
                            swingsTwoAndOne,
                            swingsTwoAndTwo,
                            swingsThreeAndZero,
                            swingsThreeAndOne,
                            swingsThreeAndTwo,
                            flyBalls,
                            groundBalls,
                            lineDrives,
                            popUps,
                            groundBunts,
                            popupBunts,
                            lineDriveBunts,
                            groupingId,
                            groupingDescription
                            )
                            WITH game_split_stats AS
                            (
                            SELECT
                                gamePk,
                                pitcherId,
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
                                SUM(wildPitches) AS wildPitches,
                                -- These metrics come from the pitches table
                                SUM(balls) AS balls,
                                SUM(ballsPitchOut) AS ballsPitchOut,
                                SUM(ballsInDirt) AS ballsInDirt,
                                SUM(intentBalls) AS intentBalls,
                                SUM(fouls) AS fouls,
                                SUM(foulBunts) AS foulBunts,
                                SUM(foulTips) AS foulTips,
                                SUM(foulPitchOuts) AS foulPitchOuts,
                                SUM(hitIntoPlay) AS hitIntoPlay,
                                SUM(pitches) AS pitches,
                                SUM(pitchOuts) AS pitchOuts,
                                SUM(strikes) AS strikes,
                                SUM(strikesCalled) AS strikesCalled,
                                SUM(strikesPitchOuts) AS strikesPitchOuts,
                                SUM(missedBunts) AS missedBunts,
                                SUM(swingAndMissStrikes) AS swingAndMissStrikes,
                                SUM(swingsPitchOuts) AS swingsPitchOuts,
                                SUM(swings) AS swings,
                                -- Swings Per Ball and Strikes
                                -- 0 Ball(s)
                                SUM(swingsZeroAndZero) AS swingsZeroAndZero,
                                SUM(swingsZeroAndOne) AS swingsZeroAndOne,
                                SUM(swingsZeroAndTwo) AS swingsZeroAndTwo,
                                -- 1 Ball(s)
                                SUM(swingsOneAndZero) AS swingsOneAndZero,
                                SUM(swingsOneAndOne) AS swingsOneAndOne,
                                SUM(swingsOneAndTwo) AS swingsOneAndTwo,
                                -- 2 Ball(s)
                                SUM(swingsTwoAndZero) AS swingsTwoAndZero,
                                SUM(swingsTwoAndOne) AS swingsTwoAndOne,
                                SUM(swingsTwoAndTwo) AS swingsTwoAndTwo,
                                -- 3 Ball(s)
                                SUM(swingsThreeAndZero) AS swingsThreeAndZero,
                                SUM(swingsThreeAndOne) AS swingsThreeAndOne,
                                SUM(swingsThreeAndTwo) AS swingsThreeAndTwo,
                                -- Trajectories
                                SUM(flyBalls) AS flyBalls,
                                SUM(groundBalls) AS groundBalls,
                                SUM(lineDrives) AS lineDrives,
                                SUM(popUps) AS popUps,
                                SUM(groundBunts) AS groundBunts,
                                SUM(popupBunts) AS popupBunts,
                                SUM(lineDriveBunts) AS lineDriveBunts
                            FROM game_player_split_stats
                            GROUP BY 1, 2
                            )
                            SELECT ', p_grouping_fields, ',',
                            '   SUM(airOuts) airOuts,
                                SUM(atBats) atBats,
                                SUM(walks) walks,
                                SUM(battersFaced) battersFaced,
                                SUM(blownSaves) blownSaves,
                                SUM(catchersInterference) AS catcherInterferences,
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
                                SUM(triples) triples,
                                SUM(unintentionalWalks) unintentionalWalks,
                                SUM(ss.wildPitches) wildPitches,
                                SUM(wins) wins,
                                -- These metrics come from the pitches table
                                SUM(ss.balls) AS balls,
                                SUM(ballsPitchOut) AS ballsPitchOut,
                                SUM(ballsInDirt) AS ballsInDirt,
                                SUM(intentBalls) AS intentBalls,
                                SUM(fouls) AS fouls,
                                SUM(foulBunts) AS foulBunts,
                                SUM(foulTips) AS foulTips,
                                SUM(foulPitchOuts) AS foulPitchOuts,
                                SUM(hitIntoPlay) AS hitIntoPlay,
                                SUM(pitches) AS pitches,
                                SUM(pitchOuts) AS pitchOuts,
                                SUM(ss.strikes) AS strikes,
                                SUM(strikesCalled) AS strikesCalled,
                                SUM(strikesPitchOuts) AS strikesPitchOuts,
                                SUM(missedBunts) AS missedBunts,
                                SUM(swingAndMissStrikes) AS swingAndMissStrikes,
                                SUM(swingsPitchOuts) AS swingsPitchOuts,
                                SUM(swings) AS swings,
                                -- Swings Per Ball and Strikes
                                -- 0 Ball(s)
                                SUM(swingsZeroAndZero) AS swingsZeroAndZero,
                                SUM(swingsZeroAndOne) AS swingsZeroAndOne,
                                SUM(swingsZeroAndTwo) AS swingsZeroAndTwo,
                                -- 1 Ball(s)
                                SUM(swingsOneAndZero) AS swingsOneAndZero,
                                SUM(swingsOneAndOne) AS swingsOneAndOne,
                                SUM(swingsOneAndTwo) AS swingsOneAndTwo,
                                -- 2 Ball(s)
                                SUM(swingsTwoAndZero) AS swingsTwoAndZero,
                                SUM(swingsTwoAndOne) AS swingsTwoAndOne,
                                SUM(swingsTwoAndTwo) AS swingsTwoAndTwo,
                                -- 3 Ball(s)
                                SUM(swingsThreeAndZero) AS swingsThreeAndZero,
                                SUM(swingsThreeAndOne) AS swingsThreeAndOne,
                                SUM(swingsThreeAndTwo) AS swingsThreeAndTwo,
                                -- Trajectories
                                SUM(flyBalls) AS flyBalls,
                                SUM(groundBalls) AS groundBalls,
                                SUM(lineDrives) AS lineDrives,
                                SUM(popUps) AS popUps,
                                SUM(groundBunts) AS groundBunts,
                                SUM(popupBunts) AS popupBunts,
                                SUM(lineDriveBunts) AS lineDriveBunts,
                                agg_grouping_id("', p_grouping_fields, '") grouping_id,
                                agg_grouping_description("', p_grouping_fields, '") grouping_description
                            FROM games g
                            INNER JOIN game_player_pitching_stats bs
                                ON g.gamePk = bs.gamePk
                            INNER JOIN game_split_stats ss
                                ON bs.gamePk = ss.gamePk
                                AND bs.playerId = ss.pitcherId
                            WHERE gameType2 IN ("PS","RS")
                            GROUP BY ',
                                p_grouping_fields
                        );

SELECT @insert_stmt;
PREPARE insert_stmt_sql FROM @insert_stmt;
EXECUTE insert_stmt_sql;

COMMIT;

END //

DELIMITER ;
