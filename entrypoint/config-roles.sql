--DROP ROLE IF EXISTS ecidade;
--DROP ROLE IF EXISTS dbseller;
--DROP ROLE IF EXISTS plugin;

IF NOT EXISTS (SELECT * FROM pg_user WHERE username = 'ecidade')
BEGIN
    create role ecidade with superuser login password 'ecidade';
END;

IF NOT EXISTS (SELECT * FROM pg_user WHERE username = 'dbseller')
BEGIN
    create role dbseller with login password 'dbseller';
END;

IF NOT EXISTS (SELECT * FROM pg_user WHERE username = 'plugin')
BEGIN
    create role plugin with login password 'plugin';
END;

--GRANT ALL PRIVILEGES ON DATABASE "e-cidade" to ecidade;