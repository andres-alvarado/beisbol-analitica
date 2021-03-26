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
							runsScoredAway,
							runsAllowedAway,
							runsParkFactor,
							HRhitHome,
							HRhitAway,
							HRallowedHome,
							HRallowedAway,
							HRparkFactor,
							hitsBattedHome,
							hitsBattedAway,
							hitsAllowedHome,
							hitsAllowedAway,
							hitsParkFactor,
							doublesHitHome,
							doublesHitAway,
							doublesAllowedHome,
							doublesAllowedAway,
							doublesParkFactor,
							triplesHitHome,
							triplesHitAway,
							triplesAllowedHome,
							triplesAllowedAway,
							triplesParkFactor,
							strikeoutsReceivedHome,
							strikeoutsReceivedAway,
							strikeoutsThrowedHome,
							strikeoutsThrowedAway,
							strikeoutsParkFactor,
							walksReceivedHome,
							walksReceivedAway,
							walksAllowedHome,
							walksAllowedAway,
							walksParkFactor
                            )                           
                            With home_scored AS (
							Select majorLeagueId, seasonId, venueId, teamId, runs, games, homeRuns, 
                            hits, doubles, triples, strikeOuts, walks
							From agg_batting_stats
							Where grouping_id = 126
							And gameType2 = 'RS'
							And teamType = 'home'
							), away_scored AS (
							Select majorLeagueId, seasonId, venueId, teamId, runs, games, homeRuns,
                            hits, doubles, triples, strikeOuts, walks
							From agg_batting_stats
							Where grouping_id = 122
							And gameType2 = 'RS'
							And teamType = 'away'),	    				
							home_allowed AS 
							(Select majorLeagueId, seasonId, venueId, teamId, runs, homeRuns, 
                            hits, doubles, triples, strikeouts, walks
							From agg_pitching_stats
							Where groupingId = 126
							And gameType2 = 'RS'
							And teamType = 'home'), 
							away_allowed AS (
							Select majorLeagueId, seasonId, venueId, teamId, runs, homeRuns, 
                            hits, doubles, triples, strikeOuts, walks
							From agg_pitching_stats
							Where groupingId = 122
							and gameType2 = 'RS'
							And teamType = 'away')
							
							
							SELECT hs.majorLeagueId, hs.seasonId, hs.venueId, hs.teamId, hs.games AS homeGames, hs.runs AS runsScoredHome, 
							ha.runs AS runsAllowedHome, aws.games AS awayGames, aws.runs AS runsScoredAway, aa.runs AS runsAllowedAway,
						    ((hs.runs + ha.runs) / hs.games) / ((aws.runs + aa.runs) / aws.games) AS runsParkFactor, 
                            hs.homeRuns as HRhitHome, aws.homeRuns as HRhitAway, ha.homeRuns as HRallowedHome, aa.homeRuns as HRallowedAway,
                            ((hs.homeRuns + ha.homeRuns) / hs.games) / ((aws.homeRuns + aa.homeRuns) / aws.games) AS HRparkFactor,
                            hs.hits AS hitsBattedHome, aws.hits AS hitsBattedAway, ha.hits AS hitsAllowedHome, aa.hits AS hitsAllowedAway,
                            ((hs.hits + ha.hits) / hs.games) / ((aws.hits + aa.hits) / aws.games) AS hitsParkFactor,
                            hs.doubles AS doublesHitHome, aws.doubles as doublesHitAway, ha.doubles AS doublesAllowedHome, 
                            aa.doubles AS doublesAllowedAway, ((hs.doubles + ha.doubles) / hs.games) / ((aws.doubles + aa.doubles) / aws.games) AS doublesParkFactor,
                            hs.triples AS triplesHitHome, aws.triples as triplesHitAway, ha.triples AS triplesAllowedHome, aa.triples AS triplesAllowedAway,
                            ((hs.triples + ha.triples) / hs.games) / ((aws.triples + aa.triples) / aws.games) AS triplesParkFactor,
                            hs.strikeouts AS strikeoutsReceivedHome, aws.strikeouts as strikeoutsReceivedAway, ha.strikeouts AS strikeoutsThrowedHome, 
                            aa.strikeouts AS strikeoutsThrowedAway, ((hs.strikeouts + ha.strikeouts) / hs.games) / ((aws.strikeouts + aa.strikeouts) / aws.games) AS strikeoutsParkFactor,
                            hs.walks AS walksReceivedHome, aws.walks as walksReceivedAway, ha.walks AS walksAllowedHome, aa.walks AS walksAllowedAway, 
                            ((hs.walks + ha.walks) / hs.games) / ((aws.walks + aa.walks) / aws.games) AS walksParkFactor
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
