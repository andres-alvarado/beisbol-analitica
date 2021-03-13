USE baseball;

DROP PROCEDURE agg_batting_derived_metrics;

DELIMITER //

CREATE PROCEDURE agg_batting_derived_metrics( )
BEGIN

UPDATE
  agg_batting_stats
  SET
    battingAverage = IF(atBats > 0, hits / atBats, NULL)
  , isolatedPower = IF(atBats > 0, (doubles + 2 * triples + 3 * homeRuns) / atBats, NULL)
  , secondBattingAverage = IF(atBats > 0, (walks + doubles + 2 * triples + 3 * homeRuns + stolenBases - caughtStealing) / atBats, NULL)
  , extraBaseHitPercentage = IF(hits > 0, (doubles + triples + homeRuns) / hits, NULL)
  , sluggingPercentage = IF(atBats > 0, totalBases / atBats, NULL)
  , stolenBasePercentage = IF(stolenBaseAttempts > 0, stolenBases / stolenBaseAttempts, NULL)
  , atBatsPerHomeRunsPercentage = IF(homeRuns > 0, atBats / homeRuns, NULL)
  , walksPerStrikeOutsPercentage = IF(strikeOuts > 0, walks / strikeOuts, NULL)
  , onBasePercentage = IF(plateAppearances > 0, (hits + walks + hitByPitch) / plateAppearances, NULL)
  , onBasePlusSluggingPercentage = IF(plateAppearances > 0, (hits + walks + hitByPitch) / plateAppearances, 0 ) + IF(atBats > 0, totalBases / atBats, 0)
  , walksPerPlateAppearancesPercentage = IF(plateAppearances > 0, walks / plateAppearances, NULL)
  , strikeOutsPerPlateAppearancesPercentage = IF(plateAppearances > 0, strikeOuts / plateAppearances, NULL)
  , homeRunsPerPlateAppearancesPercentage = IF(plateAppearances > 0, homeRuns / plateAppearances, NULL)
  , extraBasePercentage = IF(plateAppearances > 0, (doubles + triples + homeRuns) / plateAppearances, NULL)
  , inPlayPercentage = IF(plateAppearances > 0, (atBats - strikeOuts - homeRuns - sacFlies) / plateAppearances, NULL)
  , runsCreated = IF(walks + atBats > 0, (singles + doubles + triples + homeRuns + walks) * totalBases / (atBats + walks), NULL)
  , powerSpeed = IF(homeRuns + stolenBases > 0, 2 * homeRuns * stolenBases / (homeRuns + stolenBases), NULL)
  , runScoredPercentage = IF(singles + doubles + triples + homeRuns + walks + hitByPitch - homeRuns > 0, (runs - homeRuns) / (singles + doubles + triples + homeRuns + walks + hitByPitch - homeRuns), NULL)
  , battedBallsInPlayPercentage = IF(atBats - strikeOuts - homeRuns - sacFlies > 0,(singles + doubles + triples) / (atBats - strikeOuts - homeRuns + sacFlies), NULL);

END //

DELIMITER ;
