USE baseball;

DROP FUNCTION agg_or_cum_queries;

DELIMITER //

CREATE FUNCTION agg_or_cum_queries( aggregation_clause VARCHAR(255), p_grouping_fields VARCHAR(255), p_order_by_field VARCHAR(255) )
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN

    IF p_order_by_field IS NOT NULL THEN
        RETURN CONCAT( aggregation_clause, ' OVER ( PARTITION BY ', p_grouping_fields, ' ORDER BY ', p_order_by_field, ')');
    END IF;

        RETURN aggregation_clause;

END //

DELIMITER ;
