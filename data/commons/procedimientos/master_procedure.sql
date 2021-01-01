USE baseball;

DROP PROCEDURE master_procedure;

DELIMITER //

CREATE PROCEDURE master_procedure()
BEGIN

-- Base
CALL batting_orders();
CALL games();
CALL players();
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

-- Run Expectancy
CALL rem_play_by_play();
CALL rem_run_expectancy_matrix();
CALL rem_event_run_value();

-- Win Expectancy
CALL we_win_expectancy();

-- Aggregated Batting Stats
CALL agg_batting_stats('majorLeagueId,seasonId,gameType2');
CALL agg_batting_stats('majorLeagueId,seasonId,gameType2,teamId');
CALL agg_batting_stats('majorLeagueId,seasonId,gameType2,teamId,playerId');
CALL agg_batting_stats('majorLeagueId,seasonId,gameType2,venueId,teamType');

-- Clean Staging Tables
CALL clean_staging_tables();

END //

DELIMITER ;
