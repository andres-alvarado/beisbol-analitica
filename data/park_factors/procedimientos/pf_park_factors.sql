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
						    homeScored,
							homeAllowed,
							awayGames,
							awayScored,
							awayAllowed,
							runParkFactor
                            )                           
                            With homeScored AS (
							Select majorLeagueId, seasonId, venueId, teamId, runs, games
							From agg_batting_stats
							Where grouping_id = 126
							And gameType2 = 'RS'
							And teamType = 'home'
							), awayScored AS (
							Select majorLeagueId, seasonId, venueId, teamId, runs, games
							From agg_batting_stats
							Where grouping_id = 122
							And gameType2 = 'RS'
							And teamType = 'away'),	    				
							
							homeAllowed AS 
							(Select majorLeagueId, seasonId, venueId, teamId, runs
							From agg_pitching_stats
							Where groupingId = 126
							And gameType2 = 'RS'
							And teamType = 'home'
							), awayAllowed AS (
							Select majorLeagueId, seasonId, venueId, teamId, runs
							From agg_pitching_stats
							Where groupingId = 122
							and gameType2 = 'RS'
							And teamType = 'away')
							
							SELECT hs.majorLeagueId, hs.seasonId, hs.teamId, hs.venueId, hs.games AS homeGames, hs.runs AS homeScored, 
							ha.runs AS homeAllowed, aws.games AS awayGames, aws.runs AS awayScored, aa.runs AS awayAllowed,
						    ((hs.runs + ha.runs / hs.games) / (aws.runs + aa.runs / aws.games)) AS runParkFactor
							FROM   homescored hs
							INNER JOIN awayscored aws
							ON hs.seasonId = aws.seasonId
							AND hs.majorLeagueId = aws.majorLeagueId
							AND hs.teamId = aws.teamId 

							INNER JOIN homeallowed ha
							ON hs.seasonId = ha.seasonId
							AND hs.majorLeagueId = ha.majorLeagueId
							AND hs.teamId = ha.teamId 

							INNER JOIN awayallowed aa
							ON ha.seasonId = aa.seasonId
							AND ha.majorLeagueId = aa.majorLeagueId
							AND ha.teamId = aa.teamId; 
													
							
			




COMMIT;

END //

DELIMITER ;
