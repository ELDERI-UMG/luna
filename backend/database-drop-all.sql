-- ============================================================================
-- SCRIPT PARA ELIMINAR TODAS LAS TABLAS EXISTENTES
-- ⚠️ CUIDADO: Esto borrará TODA la información de la base de datos
-- ============================================================================

-- Deshabilitar verificaciones de claves foráneas temporalmente
SET session_replication_role = 'replica';

-- ============================================================================
-- ELIMINAR TABLAS DE NÓMINA Y PAGOS
-- ============================================================================

DROP TABLE IF EXISTS jornalizaciones CASCADE;
DROP TABLE IF EXISTS nominas CASCADE;
DROP TABLE IF EXISTS provisiones CASCADE;
DROP TABLE IF EXISTS indemnizaciones CASCADE;
DROP TABLE IF EXISTS incrementos CASCADE;
DROP TABLE IF EXISTS sueldos CASCADE;
DROP TABLE IF EXISTS horasextras CASCADE;
DROP TABLE IF EXISTS descansos CASCADE;
DROP TABLE IF EXISTS descuentos CASCADE;
DROP TABLE IF EXISTS comisiones CASCADE;
DROP TABLE IF EXISTS bonos CASCADE;

-- ============================================================================
-- ELIMINAR TABLAS DE INFORMACIÓN PERSONAL
-- ============================================================================

DROP TABLE IF EXISTS propiedades CASCADE;
DROP TABLE IF EXISTS referencias CASCADE;
DROP TABLE IF EXISTS familiares CASCADE;
DROP TABLE IF EXISTS experiencias CASCADE;
DROP TABLE IF EXISTS evaluaciones CASCADE;
DROP TABLE IF EXISTS identificaciones CASCADE;
DROP TABLE IF EXISTS contactos CASCADE;

-- ============================================================================
-- ELIMINAR TABLAS PRINCIPALES
-- ============================================================================

DROP TABLE IF EXISTS permisos CASCADE;
DROP TABLE IF EXISTS periodos CASCADE;
DROP TABLE IF EXISTS vacantes CASCADE;
DROP TABLE IF EXISTS empleados CASCADE;
DROP TABLE IF EXISTS contratos CASCADE;
DROP TABLE IF EXISTS empresas CASCADE;

-- ============================================================================
-- ELIMINAR TABLAS DE CATÁLOGOS
-- ============================================================================

DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS tipovacante CASCADE;
DROP TABLE IF EXISTS tiporeferencia CASCADE;
DROP TABLE IF EXISTS tiporeclutamiento CASCADE;
DROP TABLE IF EXISTS tipopropiedad CASCADE;
DROP TABLE IF EXISTS tipopago CASCADE;
DROP TABLE IF EXISTS tipoidentificacion CASCADE;
DROP TABLE IF EXISTS tipofamiliar CASCADE;
DROP TABLE IF EXISTS tipoexperiencia CASCADE;
DROP TABLE IF EXISTS tipoevaluacion CASCADE;
DROP TABLE IF EXISTS tipodescuento CASCADE;
DROP TABLE IF EXISTS tipodescanso CASCADE;
DROP TABLE IF EXISTS tipocontrato CASCADE;
DROP TABLE IF EXISTS tipocontacto CASCADE;
DROP TABLE IF EXISTS secuencias CASCADE;
DROP TABLE IF EXISTS regiones CASCADE;
DROP TABLE IF EXISTS reclutadores CASCADE;
DROP TABLE IF EXISTS puestos CASCADE;
DROP TABLE IF EXISTS ocupaciones CASCADE;
DROP TABLE IF EXISTS nacionalidades CASCADE;
DROP TABLE IF EXISTS municipios CASCADE;
DROP TABLE IF EXISTS motivoretiro CASCADE;
DROP TABLE IF EXISTS monedas CASCADE;
DROP TABLE IF EXISTS jornadas CASCADE;
DROP TABLE IF EXISTS jefes CASCADE;
DROP TABLE IF EXISTS idiomas CASCADE;
DROP TABLE IF EXISTS generos CASCADE;
DROP TABLE IF EXISTS fuentecontratacion CASCADE;
DROP TABLE IF EXISTS estudios CASCADE;
DROP TABLE IF EXISTS estadosnomina CASCADE;
DROP TABLE IF EXISTS estadosestudio CASCADE;
DROP TABLE IF EXISTS estadosempleado CASCADE;
DROP TABLE IF EXISTS estadocivil CASCADE;
DROP TABLE IF EXISTS establecimientos CASCADE;
DROP TABLE IF EXISTS duracioncontratos CASCADE;
DROP TABLE IF EXISTS discapacidades CASCADE;
DROP TABLE IF EXISTS departamentos CASCADE;
DROP TABLE IF EXISTS cuentasbancos CASCADE;
DROP TABLE IF EXISTS costos4 CASCADE;
DROP TABLE IF EXISTS costos3 CASCADE;
DROP TABLE IF EXISTS costos2 CASCADE;
DROP TABLE IF EXISTS costos1 CASCADE;
DROP TABLE IF EXISTS bancos CASCADE;
DROP TABLE IF EXISTS ascendencias CASCADE;

-- ============================================================================
-- ELIMINAR TABLA USERS (SI EXISTE)
-- ============================================================================

DROP TABLE IF EXISTS users CASCADE;

-- ============================================================================
-- ELIMINAR FUNCIONES
-- ============================================================================

DROP FUNCTION IF EXISTS update_updated_at_column() CASCADE;

-- Rehabilitar verificaciones de claves foráneas
SET session_replication_role = 'origin';

-- ============================================================================
-- MENSAJE DE CONFIRMACIÓN
-- ============================================================================

DO $$
BEGIN
    RAISE NOTICE '✅ Todas las tablas han sido eliminadas correctamente';
    RAISE NOTICE '🚀 Ahora puedes ejecutar database-auth-template.sql';
END $$;
