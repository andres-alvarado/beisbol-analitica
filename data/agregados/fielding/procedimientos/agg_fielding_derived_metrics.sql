USE baseball;

DROP PROCEDURE agg_fielding_derived_metrics;

DELIMITER //

CREATE PROCEDURE agg_fielding_derived_metrics()
BEGIN

UPDATE
  agg_fielding_stats
  SET
    fieldingPercentage = IF(  putOuts + assists + errors > 0, ( putouts + assists ) / ( putOuts + assists + errors ), NULL )
  , rangeFactorPerInning =  ( putOuts + assists ) / inningsPlayed
  , rangeFactorPerGame = ( putOuts + assists ) / gamesPlayed;

COMMIT;

END //

DELIMITER ;
