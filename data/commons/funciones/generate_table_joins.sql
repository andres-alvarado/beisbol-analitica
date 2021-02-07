USE baseball;

DROP FUNCTION generate_table_joins;

DELIMITER //

CREATE FUNCTION generate_table_joins( p_joining_fields VARCHAR(255), first_table_name VARCHAR(255), second_table_name VARCHAR(255) )
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN


    DECLARE join_statement VARCHAR(1000) DEFAULT 'ON';
    DECLARE gf VARCHAR(30);

    /* Recorrer p_joining_fields, extraer campo por campo(gf). Si gf existe
       en p_joining_fields, agregar 1 a grouping_id, sino, 0. Al final se convierte
       grouping_id a decimal. */

    WHILE LENGTH(p_joining_fields) > 0
    DO

        SET gf = SUBSTRING_INDEX(p_joining_fields, ',', 1);
        SET p_joining_fields = REPLACE(p_joining_fields, gf, '');
        SET p_joining_fields = TRIM(LEADING ',' FROM p_joining_fields );
        SET join_statement = CONCAT( join_statement, ' ', first_table_name, '.', gf, '=', second_table_name, '.', gf, ' AND' );

    END WHILE;

    RETURN TRIM( TRAILING 'AND' FROM join_statement );

END //

DELIMITER ;
