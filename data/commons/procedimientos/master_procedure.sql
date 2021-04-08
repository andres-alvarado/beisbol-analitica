USE baseball;

DROP PROCEDURE master_procedure;

DELIMITER //

CREATE PROCEDURE master_procedure()
BEGIN

-- Base
CALL major_leagues();
CALL game_batting_orders();
CALL games();
CALL players();
CALL officials();
CALL game_player_batting_stats();
CALL game_player_fielding_stats();
CALL game_player_pitching_stats();
CALL teams();
CALL game_player_positions();
CALL atbats();
CALL pitches();
CALL runners();
CALL fielding_credits();
CALL actions();
CALL pickoffs();
CALL game_officials();
CALL defensive_substitutions();
CALL game_player_fielding_outs();
CALL game_battery_fielding_stats();
CALL game_player_split_stats();

-- Run Expectancy
CALL rem_play_by_play();
CALL rem_run_expectancy_matrix();
CALL rem_event_run_value();

-- Win Expectancy
CALL we_win_expectancy();

-- Win Probability Added
CALL we_win_probability_added( 'majorLeagueId,seasonId,gameType2,runnerId', 'majorLeagueId,seasonId,gameType2,playerId', @insert_stmt );
CALL we_win_probability_added( 'majorLeagueId,seasonId,gameType2,batterId', 'majorLeagueId,seasonId,gameType2,playerId', @insert_stmt );
CALL we_win_probability_added( 'majorLeagueId,seasonId,gameType2,pitcherId', 'majorLeagueId,seasonId,gameType2,playerId', @insert_stmt );
CALL we_win_probability_added( 'majorLeagueId,seasonId,gameType2,battingTeamId', 'majorLeagueId,seasonId,gameType2,teamId', @insert_stmt );
CALL we_win_probability_added( 'majorLeagueId,seasonId,gameType2,pitchingTeamId', 'majorLeagueId,seasonId,gameType2,teamId', @insert_stmt );
CALL we_win_probability_added( 'majorLeagueId,seasonId,gameType2,battingTeamId,runnerId', 'majorLeagueId,seasonId,gameType2,teamId,playerId', @insert_stmt );
CALL we_win_probability_added( 'majorLeagueId,seasonId,gameType2,battingTeamId,batterId', 'majorLeagueId,seasonId,gameType2,teamId,playerId', @insert_stmt );
CALL we_win_probability_added( 'majorLeagueId,seasonId,gameType2,pitchingTeamId,pitcherId', 'majorLeagueId,seasonId,gameType2,teamId,playerId', @insert_stmt );

-- Aggregated Batting Stats
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,playerId', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,teamId', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,teamId,playerId', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,teamId,teamType', @insert_stmt );

-- Aggregated Batting Split Stats
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,batSide', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,pitchHand', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,menOnBase', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,playerId,batSide', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,playerId,pitchHand', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,playerId,menOnBase', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,batSide', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,pitchHand', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,menOnBase', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,playerId,batSide', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,playerId,pitchHand', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,batSide,pitchHand', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType,batSide', @insert_stmt );
CALL agg_batting_split_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType,pitchHand', @insert_stmt );

-- Derived Batting metrics
CALL agg_batting_derived_metrics();
CALL woba();
CALL wraa();
CALL wrc();
CALL ops_plus();

-- Aggregated Pitching Stats
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,playerId', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,teamId', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,teamId,playerId', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,teamId,teamType', @insert_stmt );

-- Aggregated Pitching Split Stats
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,batSide', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,pitchHand', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,menOnBase', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,playerId,batSide', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,playerId,pitchHand', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,playerId,menOnBase', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,batSide', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,pitchHand', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,menOnBase', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,playerId,batSide', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,playerId,pitchHand', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,teamId,batSide,pitchHand', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType,batSide', @insert_stmt );
CALL agg_pitching_split_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType,pitchHand', @insert_stmt );

-- Derived Pitching Metrics
CALL agg_pitching_derived_metrics();

-- Aggregated Fielding Stats
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,positionAbbrev,playerId', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,teamId', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,teamId,positionAbbrev,playerId', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,teamId,teamType', @insert_stmt );

-- Park Factors
CALL pf_park_factors();

-- Clean Staging Tables
CALL clean_staging_tables();

END //

DELIMITER ;
