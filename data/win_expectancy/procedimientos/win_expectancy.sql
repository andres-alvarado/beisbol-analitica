USE baseball;

DROP PROCEDURE we_win_expectancy;

DELIMITER //

CREATE PROCEDURE we_win_expectancy(IN p_grouping_fields VARCHAR(255), IN p_perspective VARCHAR(30), IN p_score_difference INTEGER )
BEGIN

/* Para probar este procedimiento  hacer: CALL we_win_expectancy( 'majorLeagueId', 'BATTING', 5, @insert_stmt); */

SET @insert_stmt = CONCAT('INSERT INTO we_win_expectancy (',  p_grouping_fields,','
                          ' perspective,
                            score_difference,
                            games,
                            wins,
                            losses,
                            win_expectancy,
                            grouping_id,
                            grouping_description
                            )
                            WITH pbp AS (
                             SELECT DISTINCT gamePk, ',
                             p_grouping_fields, ',',
                             we_generate_score_clause( p_perspective, p_score_difference ),
                           ' FROM rem_play_by_play
                             WHERE gameType2 IN ("PS","RS")
                             AND battingTeamScoreEndGame != pitchingTeamScoreEndGame
                           ) SELECT ', p_grouping_fields,',"', p_perspective, '" perspective,',
                          '     score_difference,
                                COUNT( 1 ) AS games,
                                SUM( wins ) AS wins,
                                SUM( losses ) AS losses,
                                SUM( wins ) / SUM( wins + losses ) win_expectancy,
                                agg_grouping_id("', p_grouping_fields, '") grouping_id,
                                agg_grouping_description("', p_grouping_fields, '") grouping_description
                             FROM pbp
                             GROUP BY ', p_grouping_fields, ', perspective, score_difference'
                           );

PREPARE insert_stmt_sql FROM @insert_stmt;
EXECUTE insert_stmt_sql;

END //

DELIMITER ;
