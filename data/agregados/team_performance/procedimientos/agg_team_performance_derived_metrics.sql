USE baseball;

DROP PROCEDURE agg_team_performance_stats_derived_metrics;

DELIMITER //

CREATE PROCEDURE agg_team_performance_stats_derived_metrics( )
BEGIN


UPDATE
  agg_team_performance_stats
  SET
    runDifferential = runs - runsAllowed,
    winPercentage = IF( wins + losses > 0, ( wins ) / ( wins + losses ), NULL );

  COMMIT;

END //

DELIMITER ;
