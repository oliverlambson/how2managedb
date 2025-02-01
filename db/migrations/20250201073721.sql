-- I added these manually b/c atlas doesn't detect them (on non-pro plan)
-- create "add_numbers" function
CREATE OR REPLACE FUNCTION add_numbers(a integer, b integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN a + b;
END;
$$;
-- create "subtract_numbers" function
CREATE OR REPLACE FUNCTION subtract_numbers(a integer, b integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN a - b;
END;
$$;
