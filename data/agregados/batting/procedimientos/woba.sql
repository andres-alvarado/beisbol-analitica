USE baseball;

DROP PROCEDURE woba;

DELIMITER //

CREATE PROCEDURE woba( IN p_grouping_fields VARCHAR(255), OUT sql_stmt VARCHAR(16000) )
BEGIN

SET @sql_stmt = CONCAT('UPDATE
                            agg_batting_stats abs
                          INNER JOIN (
                          WITH abs AS (
                            SELECT ', p_grouping_fields, ',',
                          '   groupingId,
                              unintentionalWalks,
                              singles,
                              doubles,
                              triples,
                              homeRuns,
                              atBats,
                              sacFlies,
                              hitByPitch
                            FROM agg_batting_stats
                            WHERE
                              groupingId ="', agg_grouping_id(p_grouping_fields), '"',
                            ' AND gameType2 = "RS"
                          ),
                          w AS (
                            SELECT
                              majorLeagueId,
                              seasonId,
                              SUM(IF(event = "Walk", runValue, 0)) unintentionalWalks,
                              SUM(IF(event = "Hit By Pitch", runValue, 0)) hitByPitchs,
                              SUM(IF(event = "Single", runValue, 0)) singles,
                              SUM(IF(event = "Double", runValue, 0)) doubles,
                              SUM(IF(event = "Triple", runValue, 0)) triples,
                              SUM(IF(event = "Home Run", runValue, 0)) homeRuns
                            FROM rem_event_run_value
                            GROUP BY
                              1, 2
                          )
                          SELECT  groupingId,', generate_table_alias( "abs", p_grouping_fields), ',',
                         '   IF(
                              abs.atBats + abs.unintentionalWalks + abs.sacFlies + abs.hitByPitch > 0,
                              (
                                abs.unintentionalWalks * w.unintentionalWalks + abs.singles * w.singles + abs.doubles
                                  * w.doubles + abs.triples * w.triples + abs.homeRuns * w.homeRuns
                              ) / (abs.atBats + abs.unintentionalWalks + abs.sacFlies + abs.hitByPitch),
                              NULL
                            ) weightedOnBaseAverage
                          FROM abs
                          INNER JOIN w
                            ON abs.majorLeagueId = w.majorLeagueId
                            AND abs.seasonId = w.seasonId

                          ) woba
                        ', generate_table_joins(p_grouping_fields, 'abs', 'woba') ,
                        ' AND abs.groupingId = woba.groupingId
                         SET abs.weightedOnBaseAverage = woba.weightedOnBaseAverage'
                        );

SELECT @sql_stmt;
PREPARE prepared_sql_stmt FROM @sql_stmt;
EXECUTE prepared_sql_stmt;

END //

DELIMITER ;
