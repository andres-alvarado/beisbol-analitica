USE baseball;

DROP PROCEDURE pf_park_factors;

DELIMITER //

CREATE PROCEDURE pf_park_factors()
BEGIN

INSERT INTO pf_park_factors(
    groupingId,
    groupingDescription,
    majorLeagueId,
    seasonId,
    venueId,
    teamId,
    homeGames,
    awayGames,
    runsScoredHome,
    runsAllowedHome,
    runsScoredAway,
    runsAllowedAway,
    singlesScoredHome,
    singlesAllowedHome,
    singlesScoredAway,
    singlesAllowedAway,
    doublesScoredHome,
    doublesAllowedHome,
    doublesScoredAway,
    doublesAllowedAway,
    triplesScoredHome,
    triplesAllowedHome,
    triplesScoredAway,
    triplesAllowedAway,
    homeRunsScoredHome,
    homeRunsAllowedHome,
    homeRunsScoredAway,
    homeRunsAllowedAway,
    runsParkFactor,
    singlesParkFactor,
    doublesParkFactor,
    triplesParkFactor,
    homeRunsParkFactor
  )
  WITH home_scored AS (
    SELECT
      groupingId,
      groupingDescription,
      majorLeagueId,
      seasonId,
      venueId,
      teamId,
      runs AS runsScoredHome,
      hits AS hitsScoredHome,
      singles AS singlesScoredHome,
      doubles AS doublesScoredHome,
      triples AS triplesScoredHome,
      homeRuns AS homeRunsScoredHome,
      games AS homeGames
    FROM agg_batting_stats
    WHERE
      groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_VENUEID_TEAMID_TEAMTYPE'
      AND gameType2 = 'RS'
      AND teamType = 'home'
  ),
  away_scored AS (
    SELECT
      majorLeagueId,
      seasonId,
      venueId,
      teamId,
      runs AS runsScoredAway,
      hits AS hitsScoredAway,
      singles AS singlesScoredAway,
      doubles AS doublesScoredAway,
      triples AS triplesScoredAway,
      homeRuns AS homeRunsScoredAway,
      games AS awayGames
    FROM agg_batting_stats
    WHERE
      groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_TEAMID_TEAMTYPE'
      AND gameType2 = 'RS'
      AND teamType = 'away'
  ),
  home_allowed AS (
    SELECT
      majorLeagueId,
      seasonId,
      venueId,
      teamId,
      runs AS runsAllowedHome,
      hits AS hitsAllowedHome,
      singles AS singlesAllowedHome,
      doubles AS doublesAllowedHome,
      triples AS triplesAllowedHome,
      homeRuns AS homeRunsAllowedHome
    FROM agg_pitching_stats
    WHERE
      groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_VENUEID_TEAMID_TEAMTYPE'
      AND gameType2 = 'RS'
      AND teamType = 'home'
  ),
  away_allowed AS (
    SELECT
      majorLeagueId,
      seasonId,
      venueId,
      teamId,
      runs AS runsAllowedAway,
      hits AS hitsAllowedAway,
      singles AS singlesAllowedAway,
      doubles AS doublesAllowedAway,
      triples AS triplesAllowedAway,
      homeRuns AS homeRunsAllowedAway
    FROM agg_pitching_stats
    WHERE
      groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_TEAMID_TEAMTYPE'
      AND gameType2 = 'RS'
      AND teamType = 'away'
  )
SELECT
  hs.groupingId,
  hs.groupingDescription,
  hs.majorLeagueId,
  hs.seasonId,
  hs.venueId,
  hs.teamId,
  homeGames,
  awayGames,
  runsScoredHome,
  runsAllowedHome,
  runsScoredAway,
  runsAllowedAway,
  singlesScoredHome,
  singlesAllowedHome,
  singlesScoredAway,
  singlesAllowedAway,
  doublesScoredHome,
  doublesAllowedHome,
  doublesScoredAway,
  doublesAllowedAway,
  triplesScoredHome,
  triplesAllowedHome,
  triplesScoredAway,
  triplesAllowedAway,
  homeRunsScoredHome,
  homeRunsAllowedHome,
  homeRunsScoredAway,
  homeRunsAllowedAway,
  IF( runsScoredAway + runsAllowedAway > 0,
    ((runsScoredHome + runsAllowedHome) / homeGames) /
    ((runsScoredAway + runsAllowedAway) / awayGames),
    NULL
    ) AS runsParkFactor,
  IF( singlesScoredAway + singlesAllowedAway > 0,
    ((singlesScoredHome + singlesAllowedHome) / homeGames) /
    ((singlesScoredAway + singlesAllowedAway) / awayGames),
    NULL
    ) AS singlesParkFactor,
  IF( doublesScoredAway + doublesAllowedAway > 0,
    ((doublesScoredHome + doublesAllowedHome) / homeGames) /
    ((doublesScoredAway + doublesAllowedAway) / awayGames),
    NULL
    ) AS doublesParkFactor,
  IF( triplesScoredAway + triplesAllowedAway > 0,
    ((triplesScoredHome + triplesAllowedHome) / homeGames) /
    ((triplesScoredAway + triplesAllowedAway) / awayGames),
    NULL
   ) AS triplesParkFactor,
  IF( homeRunsScoredAway + homeRunsAllowedAway > 0,
    ((homeRunsScoredHome + homeRunsAllowedHome) / homeGames) /
    ((homeRunsScoredAway + homeRunsAllowedAway) / awayGames),
    NULL
   ) AS homeRunsParkFactor
FROM home_scored hs
INNER JOIN away_scored aws
  ON hs.seasonId = aws.seasonId
  AND hs.majorLeagueId = aws.majorLeagueId
  AND hs.teamId = aws.teamId
INNER JOIN home_allowed ha
  ON hs.seasonId = ha.seasonId
  AND hs.majorLeagueId = ha.majorLeagueId
  AND hs.teamId = ha.teamId
INNER JOIN away_allowed aa
  ON ha.seasonId = aa.seasonId
  AND ha.majorLeagueId = aa.majorLeagueId
  AND ha.teamId = aa.teamId;

COMMIT;

END //

DELIMITER ;
