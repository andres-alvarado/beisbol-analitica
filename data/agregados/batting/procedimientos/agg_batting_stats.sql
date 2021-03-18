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
                                SUM(lineDriveBunts) AS lineDriveBunts,
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
