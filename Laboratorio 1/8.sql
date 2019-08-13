DECLARE
    CURSOR product IS 
        SELECT id,precio,cantidad FROM producto FOR UPDATE;
BEGIN
    FOR pro IN product LOOP
        IF pro.cantidad < 10 THEN
            UPDATE producto SET precio= precio+ precio*0.05
                WHERE CURRENT OF product;
        END IF;
    END LOOP;
END;