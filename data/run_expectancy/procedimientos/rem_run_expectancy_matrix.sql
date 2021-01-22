USE baseball;

DROP PROCEDURE rem_run_expectancy_matrix;

DELIMITER //

CREATE PROCEDURE rem_run_expectancy_matrix(IN p_grouping_fields VARCHAR(255), IN p_minus_seasons INT, p_plus_seasons INT, OUT insert_stmt VARCHAR(10000) )
BEGIN

  SET @insert_stmt = CONCAT('INSERT INTO rem_run_expectancy_matrix (',  p_grouping_fields,','
                            ' runnersBeforePlay,
                              zeroOut,
                              oneOut,
                              twoOut,
                              startSeason,
                              endSeason,
                              sortingOrder,
                              groupingId,
                              groupingDescription
                            )
                            WITH rem AS (
                              SELECT ',
                                p_grouping_fields, ',',
                            '   outsBeforePlay,
                                runnersBeforePlay,
                                AVG(runsScoredEndInning - runsScoredBeforePlay) runExpectancy
                              FROM rem_play_by_play
                              WHERE gameType2 IN ("RS", "PS")
                              AND (
                                  scheduledInnings > inning
                                OR (
                                    scheduledInnings = inning
                                    AND halfInning = "top"
                                  )
                                )
                              GROUP BY ', p_grouping_fields, ', outsBeforePlay, runnersBeforePlay
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
                              generate_table_alias( "rem", p_grouping_fields), ',',
                            ' runnersBeforePlay,
                              SUM(IF(outsBeforePlay = 0, runExpectancy, 0)) zeroOut,
                              SUM(IF(outsBeforePlay = 1, runExpectancy, 0)) oneOut,
                              SUM(IF(outsBeforePlay = 2, runExpectancy, 0)) twoOut,
                              IF( MIN(s.seasonId) < ROUND(rem.seasonId,0) -', p_minus_seasons, ',ROUND(rem.seasonId,0) -', p_minus_seasons,', MIN(s.seasonId)) startSeason,
                              IF( MAX(s.seasonId) > ROUND(rem.seasonId,0) +', p_plus_seasons, ', ROUND(rem.seasonId,0) +', p_plus_seasons, ', MAX(s.seasonId)) endSeason,
                              CASE
                                WHEN runnersBeforePlay = "---" THEN 0
                                WHEN runnersBeforePlay = "1--" THEN 1
                                WHEN runnersBeforePlay = "-2-" THEN 2
                                WHEN runnersBeforePlay = "12-" THEN 3
                                WHEN runnersBeforePlay = "--3" THEN 4
                                WHEN runnersBeforePlay = "1-3" THEN 5
                                WHEN runnersBeforePlay = "-23" THEN 6
                                WHEN runnersBeforePlay = "123" THEN 7
                              END sortingOrder,
                              agg_grouping_id("', p_grouping_fields, '") groupingId,
                              agg_grouping_description("', p_grouping_fields, '") groupingDescription
                              FROM rem
                              INNER JOIN s
                              ON rem.seasonId BETWEEN s.startSeason AND s.endSeason
                              AND rem.majorLeagueId = s.majorLeagueId
                              GROUP BY ', p_grouping_fields, ', runnersBeforePlay'
                            );

  SELECT @insert_stmt;
  PREPARE insert_stmt_sql FROM @insert_stmt;
  EXECUTE insert_stmt_sql;

  COMMIT;

END //

DELIMITER ;
