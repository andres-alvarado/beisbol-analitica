USE baseball;

DROP FUNCTION we_generate_score_clause;

DELIMITER //

CREATE FUNCTION we_generate_score_clause( p_perspective VARCHAR(30), p_score_difference INTEGER )
RETURNS VARCHAR(500)
DETERMINISTIC
BEGIN

    /* Para probar esta funcion Select we_generate_score_clause( 'PITCHING', 5 ); */

    DECLARE clause VARCHAR(500);

    CASE p_perspective
    WHEN 'BATTING' THEN
        SET clause = CONCAT(' CASE ',
                            ' WHEN battingTeamScore - pitchingTeamScore <= ', -p_score_difference, ' THEN ', -p_score_difference,
                            ' WHEN battingTeamScore - pitchingTeamScore >  ',  p_score_difference, ' THEN ',  p_score_difference,
                            ' ELSE battingTeamScore - pitchingTeamScore',
                            ' END scoreDifference, ',
                            ' battingTeamScoreEndGame > pitchingTeamScoreEndGame wins, ',
                            ' battingTeamScoreEndGame < pitchingTeamScoreEndGame losses '
                        );
    WHEN 'PITCHING' THEN
        SET clause = CONCAT(' CASE ',
                            ' WHEN pitchingTeamScore - battingTeamScore <= ', -p_score_difference, ' THEN ', -p_score_difference,
                            ' WHEN pitchingTeamScore - battingTeamScore >  ',  p_score_difference, ' THEN ',  p_score_difference,
                            ' ELSE pitchingTeamScore - battingTeamScore',
                            ' END scoreDifference, ',
                            ' pitchingTeamScoreEndGame > battingTeamScoreEndGame wins, ',
                            ' pitchingTeamScoreEndGame < battingTeamScoreEndGame losses '
                            );
    END CASE;

    RETURN clause;

END //

DELIMITER ;
