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
                                  ROUND(seasonId,0) -', p_minus_seasons, ' startSeason,
                                  ROUND(seasonId,0) +', p_plus_seasons, ' endSeason
                              FROM games
                            )
                              SELECT ',
                                  generate_table_alias( 'pbp', p_grouping_fields ),',"',
                                  p_perspective, '" perspective,',
                            '     scoreDifference,
                                  IF( MIN(s.seasonId) < ROUND(pbp.seasonId,0) -', p_minus_seasons, ',ROUND(pbp.seasonId,0) -', p_minus_seasons,', MIN(s.seasonId)) startSeason,
                                  IF( MAX(s.seasonId) > ROUND(pbp.seasonId,0) +', p_plus_seasons, ', ROUND(pbp.seasonId,0) +', p_plus_seasons, ', MAX(s.seasonId)) endSeason,
                                  COUNT( 1 ) AS games,
                                  SUM( wins ) AS wins,
                                  SUM( losses ) AS losses,
                                  SUM( wins ) / COUNT( 1 ) winExpectancy,
                                  agg_grouping_id("', p_grouping_fields, '") groupingId,
                                  agg_grouping_description("', p_grouping_fields, '") groupingDescription
                              FROM pbp
                              INNER JOIN s
                              ON pbp.seasonId BETWEEN s.startSeason AND s.endSeason
                              AND pbp.majorLeagueId = s.majorLeagueId
                              GROUP BY ', p_grouping_fields, ', perspective, scoreDifference'
                            );

  SELECT @insert_stmt;
  PREPARE insert_stmt_sql FROM @insert_stmt;
  EXECUTE insert_stmt_sql;

END //

DELIMITER ;
