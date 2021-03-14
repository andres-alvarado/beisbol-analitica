USE baseball;

DROP PROCEDURE agg_batting_split_stats;

DELIMITER //

CREATE PROCEDURE agg_batting_split_stats( IN p_grouping_fields VARCHAR(255), OUT insert_stmt VARCHAR(16000))
BEGIN

SET @insert_stmt = CONCAT('INSERT INTO agg_batting_stats (', p_grouping_fields,',',
                          ' atbats,
                            balks,
                            batterInterferences,
                            bunts,
                            catcherInterferences,
                            doubles,
                            fanInterferences,
                            fieldErrors,
                            fieldersChoice,
                            flyouts,
                            forceOuts,
                            games,
                            groundedIntoDoublePlays,
                            groundedIntoTriplePlays,
                            groundOuts,
                            hitByPitch,
                            hits,
                            homeRuns,
                            intentionalWalks,
                            lineOuts,
                            passedBalls,
                            popOuts,
                            runsBattedIn,
                            sacBunts,
                            sacFlies,
                            singles,
                            strikeOuts,
                            triples,
                            walks,
                            wildPitches,
                            groupingId,
                            groupingDescription
                            )
                        WITH bs AS (
                            SELECT
                                *
                            FROM game_player_split_stats
                            ),
                            g AS (
                            SELECT
                                majorLeagueId,
                                seasonId,
                                gamePk,
                                gameType2,
                                venueId,
                                homeTeamId
                            FROM games
                            WHERE gameType2 IN ("PS","RS")
                            ),
                            data AS (
                            SELECT
                                g.majorLeagueId,
                                g.seasonId,
                                g.gamePk,
                                g.gameType2,
                                g.venueId,
                                IF( g.homeTeamId = bs.battingTeamId, "home", "away" ) teamType,
                                bs.battingTeamId AS teamId,
                                bs.batterId AS playerId,
                                batSide,
                                pitchHand,
                                batterInterferences + bunts + doubles + fanInterferences + fieldErrors + fieldersChoice
                              + flyouts + forceOuts + groundedIntoDoublePlays + triplePlays + groundOuts + homeRuns
                              + lineOuts + popOuts + singles + strikeOuts + triples AS atbats,
                                balks,
                                batterInterferences,
                                bunts,
                                catcherInterferences,
                                doubles,
                                fanInterferences,
                                fieldErrors,
                                fieldersChoice,
                                flyouts,
                                forceOuts,
                                groundedIntoDoublePlays,
                                groundOuts,
                                hitByPitch,
                                homeRuns,
                                intentionalWalks,
                                lineOuts,
                                passedBalls,
                                popOuts,
                                runsBattedIn,
                                sacBunts,
                                sacFlies,
                                singles,
                                strikeOuts,
                                triples,
                                triplePlays,
                                walks,
                                wildPitches
                            FROM g
                            INNER JOIN bs
                                ON g.gamePk = bs.gamePk
                            )
                            SELECT ', p_grouping_fields, ',',
                            '   SUM(atbats) AS atbats,
                                SUM(balks) AS balks,
                                SUM(batterInterferences) AS batterInterferences,
                                SUM(bunts) AS bunts,
                                SUM(catcherInterferences) AS catcherInterferences,
                                SUM(doubles) AS doubles,
                                SUM(fanInterferences) AS fanInterferences,
                                SUM(fieldErrors) AS fieldErrors,
                                SUM(fieldersChoice) AS fieldersChoice,
                                SUM(flyouts) AS flyouts,
                                SUM(forceOuts) AS forceOuts,
                                COUNT(DISTINCT gamePk) AS games,
                                SUM(groundedIntoDoublePlays) AS groundedIntoDoublePlays,
                                SUM(triplePlays) AS groundedIntoTriplePlays,
                                SUM(groundOuts) AS groundOuts,
                                SUM(hitByPitch) AS hitByPitch,
                                SUM(singles) + SUM(doubles) + SUM(triples) + SUM(homeRuns) hits,
                                SUM(homeRuns) AS homeRuns,
                                SUM(intentionalWalks) AS intentionalWalks,
                                SUM(lineOuts) AS lineOuts,
                                SUM(passedBalls) AS passedBalls,
                                SUM(popOuts) AS popOuts,
                                SUM(runsBattedIn) as runsBattedIn,
                                SUM(sacBunts) AS sacBunts,
                                SUM(sacFlies) AS sacFlies,
                                SUM(singles) AS singles,
                                SUM(strikeOuts) AS strikeOuts,
                                SUM(triples) AS triples,
                                SUM(walks) AS walks,
                                SUM(wildPitches) AS wildPitches,
                                agg_grouping_id("', p_grouping_fields, '") groupingId,
                                agg_grouping_description("', p_grouping_fields, '") groupingDescription
                                FROM data
                                GROUP BY ',
                                p_grouping_fields
                    );

SELECT @insert_stmt;
PREPARE insert_stmt_sql FROM @insert_stmt;
EXECUTE insert_stmt_sql;

END //

DELIMITER ;
