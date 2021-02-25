USE baseball;

DROP PROCEDURE pf_park_factors;

DELIMITER //

CREATE PROCEDURE pf_park_factors( )
BEGIN

INSERT INTO pf_park_factors (
    majorLeagueId,
    seasonId,
    venueId,
    teamId,
    homeGames,
    runsScoredHome,
    runsAllowedHome,
    awayGames,
    runsScoredAway,
    runsAllowedAway,
    runsParkFactor
  )
  WITH home_scored AS (
    SELECT
      majorLeagueId,
      seasonId,
      venueId,
      teamId,
      runs,
      games
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
      runs,
      games
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
      runs
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
      runs
    FROM agg_pitching_stats
    WHERE
      groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_TEAMID_TEAMTYPE'
      AND gameType2 = 'RS'
      AND teamType = 'away'
  )
SELECT
  hs.majorLeagueId,
  hs.seasonId,
  hs.venueId,
  hs.teamId,
  hs.games AS homeGames,
  hs.runs AS runsScoredHome,
  ha.runs AS runsAllowedHome,
  aws.games AS awayGames,
  aws.runs AS runsScoredAway,
  aa.runs AS runsAllowedAway,
  ((hs.runs + ha.runs) / hs.games) / ((aws.runs + aa.runs) / aws.games) AS runsParkFactor
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
