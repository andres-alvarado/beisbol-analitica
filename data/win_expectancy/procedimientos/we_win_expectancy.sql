USE baseball;

DROP PROCEDURE we_win_expectancy;

DELIMITER //

CREATE PROCEDURE we_win_expectancy(IN p_grouping_fields VARCHAR(255), IN p_perspective VARCHAR(30), IN p_score_difference INTEGER, IN p_minus_seasons INT, p_plus_seasons INT, OUT insert_stmt VARCHAR(10000) )
BEGIN

  SET @insert_stmt = CONCAT('INSERT INTO we_win_expectancy (',  p_grouping_fields,','
                            ' perspective,
                              scoreDifference,
                              startSeason,
                              endSeason,
                              games,
                              wins,
                              losses,
                              winExpectancy,
                              groupingId,
                              groupingDescription
                              )
                              WITH pbp AS (
                              SELECT DISTINCT gamePk, ',
                                  p_grouping_fields, ',',
                                  we_generate_score_clause( p_perspective, p_score_difference ),
                            '  FROM rem_play_by_play
                              WHERE gameType2 IN ("PS","RS")
                              AND battingTeamScoreEndGame != pitchingTeamScoreEndGame
                            ), s AS
                            (
                              SELECT DISTINCT
                                  seasonId,
                                  majorLeagueId,
                                  ROUND(seasonId,0) -', p_minus_seasons, ' start_season,
                                  ROUND(seasonId,0) +', p_plus_seasons, ' end_season
                              FROM games
                            ), d AS
                            (
                              SELECT
                                  s.seasonId,
                                  s.start_season,
                                  s.end_season,
                                  pbp.scoreDifference,
                                  pbp.wins,
                                  pbp.losses,',
                                  REPLACE(we_generate_table_alias( 'pbp', p_grouping_fields ), 'pbp.seasonId', 'pbp.seasonId AS seasons'),
                            '  FROM pbp
                              INNER JOIN s
                              ON pbp.seasonId BETWEEN s.start_season AND s.end_season
                              AND pbp.majorLeagueId = s.majorLeagueId
                            )
                              SELECT ',
                                  p_grouping_fields,',"',
                                  p_perspective, '" perspective,',
                            '     scoreDifference,
                                  MIN(seasons) startSeason,
                                  MAX(seasons) endSeason,
                                  COUNT( 1 ) AS games,
                                  SUM( wins ) AS wins,
                                  SUM( losses ) AS losses,
                                  SUM( wins ) / COUNT( 1 ) winExpectancy,
                                  agg_grouping_id("', p_grouping_fields, '") groupingId,
                                  agg_grouping_description("', p_grouping_fields, '") groupingDescription
                              FROM d
                              GROUP BY ', p_grouping_fields, ', perspective, scoreDifference'
                            );

  SELECT @insert_stmt;
  PREPARE insert_stmt_sql FROM @insert_stmt;
  EXECUTE insert_stmt_sql;

END //

DELIMITER ;
