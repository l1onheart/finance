﻿IF OBJECT_ID('finance.convert_exchange_rate') IS NOT NULL
DROP FUNCTION finance.convert_exchange_rate;

GO

CREATE FUNCTION finance.convert_exchange_rate(@office_id integer, @source_currency_code national character varying(12), @destination_currency_code national character varying(12))
RETURNS decimal(30, 6)
AS
BEGIN
    DECLARE @unit                           integer = 0;
    DECLARE @exchange_rate                  decimal(30, 6) = 0;
    DECLARE @from_source_currency           decimal(30, 6) = finance.get_exchange_rate(@office_id, @source_currency_code);
    DECLARE @from_destination_currency      decimal(30, 6) = finance.get_exchange_rate(@office_id, @destination_currency_code);

    IF(@source_currency_code = @destination_currency_code)
    BEGIN
        RETURN 1;
    END;
        
    RETURN @from_source_currency / @from_destination_currency ; 
END;

--SELECT * FROM  finance.convert_exchange_rate(1, 'USD', 'NPR')


GO