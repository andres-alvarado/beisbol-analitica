USE baseball;

DROP FUNCTION generate_table_alias;

DELIMITER //

CREATE FUNCTION generate_table_alias( p_table_alias VARCHAR(10), p_cols VARCHAR(1000) )
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN

    DECLARE alias_cols VARCHAR(500);

    SET alias_cols = REPLACE( p_cols, ',', CONCAT( ',', p_table_alias, '.' ) );
    SET alias_cols = CONCAT( p_table_alias, '.', alias_cols );

    RETURN alias_cols;

END //

DELIMITER ;
