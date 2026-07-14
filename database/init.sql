-- =============================================================================
-- Ferreteria ERP — Inicializacion de base de datos
-- Ejecutado una sola vez al crear el contenedor PostgreSQL (antes del esquema).
-- Crea extensiones, esquemas base, funcion de timestamp compartida y permisos.
-- Las TABLAS las crea el script de esquema (Squema.sql) o Prisma db push.
-- =============================================================================

-- Extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Esquemas del sistema
CREATE SCHEMA IF NOT EXISTS sales;
CREATE SCHEMA IF NOT EXISTS dte;
CREATE SCHEMA IF NOT EXISTS hr;
CREATE SCHEMA IF NOT EXISTS system;
CREATE SCHEMA IF NOT EXISTS purchasing;
CREATE SCHEMA IF NOT EXISTS fiscal;

-- Funcion compartida para actualizar UpdatedAt automaticamente.
CREATE OR REPLACE FUNCTION public.fn_update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW."UpdatedAt" = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Permisos para el usuario de desarrollo
GRANT ALL PRIVILEGES ON SCHEMA public     TO ferreteria_user;
GRANT ALL PRIVILEGES ON SCHEMA sales      TO ferreteria_user;
GRANT ALL PRIVILEGES ON SCHEMA dte        TO ferreteria_user;
GRANT ALL PRIVILEGES ON SCHEMA hr         TO ferreteria_user;
GRANT ALL PRIVILEGES ON SCHEMA system     TO ferreteria_user;
GRANT ALL PRIVILEGES ON SCHEMA purchasing TO ferreteria_user;
GRANT ALL PRIVILEGES ON SCHEMA fiscal     TO ferreteria_user;

ALTER DEFAULT PRIVILEGES FOR ROLE ferreteria_user IN SCHEMA public     GRANT ALL ON TABLES TO ferreteria_user;
ALTER DEFAULT PRIVILEGES FOR ROLE ferreteria_user IN SCHEMA sales      GRANT ALL ON TABLES TO ferreteria_user;
ALTER DEFAULT PRIVILEGES FOR ROLE ferreteria_user IN SCHEMA dte        GRANT ALL ON TABLES TO ferreteria_user;
ALTER DEFAULT PRIVILEGES FOR ROLE ferreteria_user IN SCHEMA hr         GRANT ALL ON TABLES TO ferreteria_user;
ALTER DEFAULT PRIVILEGES FOR ROLE ferreteria_user IN SCHEMA system     GRANT ALL ON TABLES TO ferreteria_user;
ALTER DEFAULT PRIVILEGES FOR ROLE ferreteria_user IN SCHEMA purchasing GRANT ALL ON TABLES TO ferreteria_user;
ALTER DEFAULT PRIVILEGES FOR ROLE ferreteria_user IN SCHEMA fiscal     GRANT ALL ON TABLES TO ferreteria_user;
