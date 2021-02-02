USE baseball;

DROP PROCEDURE agg_fielding_stats;

DELIMITER //

CREATE PROCEDURE agg_fielding_stats IN p_grouping_fields VARCHAR(255), OUT insert_stmt VARCHAR(16000))
BEGIN

/* Para probar este procedimiento hacer: CALL agg_fielding_stats( 'majorLeagueId', @insert_stmt);  */

SET @insert_stmt = CONCAT('INSERT INTO agg_fielding_stats (', p_grouping_fields,',',
                          ' games
                            chances,
                            assists,
							if_assists,
							of_assists,
							putOuts,
                            errors,                    
                            fieldingPercentage,                     
                            grouping_id,
                            grouping_description
                            )
                            WITH stats AS (
                            SELECT ', p_grouping_fields, ',',
                            '   COUNT(DISTINCT g.gamePk) AS games,
                                SUM(fc.f_throwing_error + fc.f_putout + fc.f_assist + fc.f_assist_of
								+ fc.f_fielding_error + fc.f_error_dropped_ball) AS chances,
                                SUM(fc.f_assist) AS assists,
								SUM(fc.f_assist - fc.f_assist_of) AS if_assists,
								SUM(fc.f_assist_of) AS of_assists,
								SUM(fc.f_putout) AS putOuts,                               
								SUM(fc.f_throwing_error + fc.f_fielding_error + fc.f_error_dropped_ball) AS errors,
                           
 						    FROM games g
                            INNER JOIN fielding_credits fc
                                ON g.gamePk = fc.gamePk
                            WHERE gameType2 IN ("PS","RS")
                            GROUP BY ',
                                p_grouping_fields
                           );
SELECT @insert_stmt;
PREPARE insert_stmt_sql FROM @insert_stmt;
EXECUTE insert_stmt_sql;

UPDATE
	agg_fielding_stats
	SET
	  IF(chances > 0, (assists + putOuts / chances, NULL) fieldingPercentage
      
                           


COMMIT;

END //

DELIMITER ;
