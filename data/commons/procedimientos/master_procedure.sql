USE baseball;

DROP PROCEDURE master_procedure;

DELIMITER //

CREATE PROCEDURE master_procedure()
BEGIN

-- Base
CALL batting_orders();
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

-- Run Expectancy
CALL rem_play_by_play();
CALL rem_run_expectancy_matrix( 'majorLeagueId,seasonId', 0, 0, @insert_stmt );
CALL rem_run_expectancy_matrix( 'majorLeagueId,seasonId,venueId', 0, 0, @insert_stmt );
CALL rem_event_run_value();

-- Win Expectancy
CALL we_win_expectancy( 'majorLeagueId,seasonId,gameType2', 'BATTING', 1, 10, 10, @insert_stmt );
CALL we_win_expectancy( 'majorLeagueId,seasonId,inning,gameType2', 'BATTING', 1, 10, 10, @insert_stmt);
CALL we_win_expectancy( 'majorLeagueId,seasonId,inning,gameType2,menOnBaseBeforePlay,outsBeforePlay', 'BATTING', 1, 10, 10, @insert_stmt);

-- Aggregated Batting Stats
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,playerId', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,teamId', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,teamId,playerId', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType', @insert_stmt );
CALL agg_batting_stats( 'majorLeagueId,seasonId,gameType2,teamId,teamType', @insert_stmt );

CALL woba( 'majorLeagueId,seasonId,gameType2,playerId', @sql_stmt );
CALL woba( 'majorLeagueId,seasonId,gameType2,teamId,playerId', @sql_stmt );

-- Aggregated Pitching Stats
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,playerId', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,teamId', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,teamId,playerId', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType', @insert_stmt );
CALL agg_pitching_stats( 'majorLeagueId,seasonId,gameType2,teamId,teamType', @insert_stmt );

-- Aggregated Fielding Stats
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,positionAbbrev,playerId', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,teamId', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,teamId,positionAbbrev,playerId', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,venueId,teamId,teamType', @insert_stmt );
CALL agg_fielding_stats( 'majorLeagueId,seasonId,gameType2,teamId,teamType', @insert_stmt );


-- Clean Staging Tables
CALL clean_staging_tables();

END //

DELIMITER ;
