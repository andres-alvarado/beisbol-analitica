USE baseball;

DROP PROCEDURE we_win_expectancy;

DELIMITER //

CREATE PROCEDURE we_win_expectancy( IN p_perspective VARCHAR(30) )
BEGIN

INSERT INTO we_win_expectancy (
    groupingId,
    groupingDescription,
    majorLeagueId,
    seasonId,
    inning,
    gameType2,
    menOnBaseBeforePlay,
    outsBeforePlay,
    perspective,
    score,
    games,
    wins,
    losses
  )
  WITH pbp AS (
    SELECT DISTINCT
      gamePk,
      majorLeagueId,
      seasonId,
      inning,
      gameType2,
      menOnBaseBeforePlay,
      outsBeforePlay,
      p_perspective perspective,
      CASE
        WHEN p_perspective = 'BATTING' AND battingTeamScore - pitchingTeamScore < 0 THEN 'LOSING'
        WHEN p_perspective = 'BATTING' AND battingTeamScore - pitchingTeamScore > 0 THEN 'WINNING'
        WHEN p_perspective = 'PITCHING' AND pitchingTeamScore - battingTeamScore < 0 THEN 'LOSING'
        WHEN p_perspective = 'PITCHING' AND pitchingTeamScore - battingTeamScore > 0
          THEN 'WINNING'
        ELSE 'TIE'
      END score,
      CASE
        WHEN p_perspective = 'BATTING' AND battingTeamScoreEndGame > pitchingTeamScoreEndGame
          THEN 1
        WHEN p_perspective = 'PITCHING' AND pitchingTeamScoreEndGame > battingTeamScoreEndGame
          THEN 1
        ELSE 0
      END wins,
      CASE
        WHEN p_perspective = 'BATTING' AND battingTeamScoreEndGame < pitchingTeamScoreEndGame
          THEN 1
        WHEN p_perspective = 'PITCHING' AND pitchingTeamScoreEndGame < battingTeamScoreEndGame
          THEN 1
        ELSE 0
      END losses
    FROM rem_play_by_play
    WHERE
      gameType2 = 'RS'
      AND battingTeamScoreEndGame != pitchingTeamScoreEndGame
  )
SELECT
  agg_grouping_id('majorLeagueId,seasonId,inning,gameType2,menOnBaseBeforePlay,outsBeforePlay') groupingId,
  agg_grouping_description('majorLeagueId,seasonId,inning,gameType2,menOnBaseBeforePlay,outsBeforePlay') groupingDescription,
  majorLeagueId,
  seasonId,
  inning,
  gameType2,
  menOnBaseBeforePlay,
  outsBeforePlay,
  perspective,
  score,
  COUNT(1) AS games,
  SUM(wins) AS wins,
  SUM(losses) AS losses
FROM pbp
GROUP BY
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10

UNION ALL

SELECT
  agg_grouping_id('majorLeagueId,seasonId,inning,gameType2') groupingId,
  agg_grouping_description('majorLeagueId,seasonId,inning,gameType2') groupingDescription,
  majorLeagueId,
  seasonId,
  inning,
  gameType2,
  NULL menOnBaseBeforePlay,
  NULL outsBeforePlay,
  perspective,
  score,
  COUNT(1) AS games,
  SUM(wins) AS wins,
  SUM(losses) AS losses
FROM pbp
GROUP BY
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10;

UPDATE
  we_win_expectancy
  SET winExpectancy = wins / games;

COMMIT;

END //

DELIMITER ;
