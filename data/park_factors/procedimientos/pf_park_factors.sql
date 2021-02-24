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
                            With home_scored AS (
							Select majorLeagueId, seasonId, venueId, teamId, runs, games
							From agg_batting_stats
							Where groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_VENUEID_TEAMID_TEAMTYPE'
							And gameType2 = 'RS'
							And teamType = 'home'
							), away_scored AS (
							Select majorLeagueId, seasonId, venueId, teamId, runs, games
							From agg_batting_stats
							Where groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_TEAMID_TEAMTYPE'
							And gameType2 = 'RS'
							And teamType = 'away'),	    				
							
							home_allowed AS 
							(Select majorLeagueId, seasonId, venueId, teamId, runs
							From agg_pitching_stats
							Where groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_VENUEID_TEAMID_TEAMTYPE'
							And gameType2 = 'RS'
							And teamType = 'home'
							), away_allowed AS (
							Select majorLeagueId, seasonId, venueId, teamId, runs
							From agg_pitching_stats
							Where groupingDescription = 'MAJORLEAGUEID_SEASONID_GAMETYPE2_TEAMID_TEAMTYPE'
							and gameType2 = 'RS'
							And teamType = 'away')
							
							SELECT hs.majorLeagueId, hs.seasonId, hs.teamId, hs.venueId, hs.games AS homeGames, hs.runs AS runsScoredHome, 
							ha.runs AS runsAllowedHome, aws.games AS awayGames, aws.runs AS runsScoredAway, aa.runs AS runsAllowedAway,
						    (hs.runs + ha.runs) / hs.games / (aws.runs + aa.runs) / aws.games AS runsParkFactor
							FROM   home_scored hs
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
