-- Sistema HR convertido para PostgreSQL/Supabase
-- Estructura completa sin datos de prueba
-- 68 tablas con relaciones correctas

-- Habilitar extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Función para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS
'BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;'
LANGUAGE plpgsql;

-- ============================================================================
-- TABLAS DE CATÁLOGOS BÁSICOS
-- ============================================================================

-- Tabla ascendencias
CREATE TABLE ascendencias (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla bancos
CREATE TABLE bancos (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla costos1
CREATE TABLE costos1 (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    nombre2 VARCHAR(255),
    nombre3 VARCHAR(255),
    desde DATE,
    hasta DATE,
    comentarios TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla costos2
CREATE TABLE costos2 (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(5) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    nombre2 VARCHAR(255),
    nombre3 VARCHAR(255),
    desde DATE,
    hasta DATE,
    comentarios TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla costos3
CREATE TABLE costos3 (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100),
    nombre2 VARCHAR(255),
    nombre3 VARCHAR(255),
    establecimientos_id BIGINT,
    igss_id BIGINT,
    regiones_id BIGINT,
    desde DATE,
    hasta DATE,
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla costos4
CREATE TABLE costos4 (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    nombre2 VARCHAR(255),
    nombre3 VARCHAR(255),
    desde DATE,
    hasta DATE,
    comentarios TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla cuentasbancos
CREATE TABLE cuentasbancos (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    tipocuenta VARCHAR(20) NOT NULL CHECK (tipocuenta IN ('MONETARIA', 'AHORRO')),
    bancos_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla departamentos
CREATE TABLE departamentos (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    desde DATE,
    hasta DATE,
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla discapacidades
CREATE TABLE discapacidades (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla duracioncontratos
CREATE TABLE duracioncontratos (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla establecimientos
CREATE TABLE establecimientos (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    nombre2 VARCHAR(75),
    nombre3 VARCHAR(75),
    desde DATE,
    hasta DATE,
    comentarios TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla estadocivil
CREATE TABLE estadocivil (
    id BIGSERIAL PRIMARY KEY,
    codigo INTEGER NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla estadosempleado
CREATE TABLE estadosempleado (
    id BIGSERIAL PRIMARY KEY,
    codigo BIGINT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    desde DATE,
    hasta DATE,
    comentarios TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla estadosestudio
CREATE TABLE estadosestudio (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla estadosnomina
CREATE TABLE estadosnomina (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(15) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla estudios
CREATE TABLE estudios (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    desde DATE,
    hasta DATE,
    comentarios TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla fuentecontratacion
CREATE TABLE fuentecontratacion (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla generos
CREATE TABLE generos (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla idiomas
CREATE TABLE idiomas (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(15) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    desde DATE,
    hasta DATE,
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla jefes
CREATE TABLE jefes (
    id BIGSERIAL PRIMARY KEY,
    codigo INTEGER,
    nombre VARCHAR(255) NOT NULL,
    nombre2 VARCHAR(40) NOT NULL,
    nombre3 VARCHAR(40),
    desde DATE,
    hasta DATE,
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla jornadas
CREATE TABLE jornadas (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla monedas
CREATE TABLE monedas (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla motivoretiro
CREATE TABLE motivoretiro (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla municipios
CREATE TABLE municipios (
    id BIGSERIAL PRIMARY KEY,
    departamentos_id BIGINT NOT NULL,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    desde DATE,
    hasta DATE,
    comentarios TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla nacionalidades
CREATE TABLE nacionalidades (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    pais VARCHAR(75) NOT NULL,
    desde DATE,
    hasta DATE,
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla ocupaciones
CREATE TABLE ocupaciones (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    desde DATE,
    hasta DATE,
    comentarios TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla puestos
CREATE TABLE puestos (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    nombre2 VARCHAR(100),
    nombre3 VARCHAR(100),
    desde DATE,
    hasta DATE,
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla reclutadores
CREATE TABLE reclutadores (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla regiones
CREATE TABLE regiones (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25),
    nombre VARCHAR(75) NOT NULL,
    gruporegion VARCHAR(100),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla secuencias
CREATE TABLE secuencias (
    id BIGSERIAL PRIMARY KEY,
    tipoempleado VARCHAR(5) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    iniciasecuencia INTEGER NOT NULL,
    mascara VARCHAR(20) NOT NULL,
    ultimousado INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipocontacto
CREATE TABLE tipocontacto (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipocontrato
CREATE TABLE tipocontrato (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipodescanso
CREATE TABLE tipodescanso (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(75) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipodescuento
CREATE TABLE tipodescuento (
    id BIGSERIAL PRIMARY KEY,
    codigo INTEGER NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    cuentacontable VARCHAR(100) NOT NULL,
    nombrecuenta VARCHAR(100) NOT NULL,
    sefactura BOOLEAN,
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipoevaluacion
CREATE TABLE tipoevaluacion (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipoexperiencia
CREATE TABLE tipoexperiencia (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipofamiliar
CREATE TABLE tipofamiliar (
    id BIGSERIAL PRIMARY KEY,
    codigo INTEGER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipoidentificacion
CREATE TABLE tipoidentificacion (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipopago
CREATE TABLE tipopago (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipopropiedad
CREATE TABLE tipopropiedad (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(75) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tiporeclutamiento
CREATE TABLE tiporeclutamiento (
    id BIGSERIAL PRIMARY KEY,
    codigo INTEGER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tiporeferencia
CREATE TABLE tiporeferencia (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla tipovacante
CREATE TABLE tipovacante (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla usuarios
CREATE TABLE usuarios (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(255) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    nombreusuario VARCHAR(255),
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================================
-- TABLAS PRINCIPALES
-- ============================================================================

-- Tabla empresas
CREATE TABLE empresas (
    id BIGSERIAL PRIMARY KEY,
    nit VARCHAR(100),
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    pais VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecharegistro DATE,
    tipocontribuyente VARCHAR(50),
    iva INTEGER,
    isr INTEGER,
    desde DATE NOT NULL,
    hasta DATE NOT NULL,
    comentarios TEXT NOT NULL DEFAULT '',
    nombrerepresentante VARCHAR(150),
    edad INTEGER,
    nacionalidades_id BIGINT,
    estadocivil_id BIGINT,
    estudios_id BIGINT,
    tipoidentificacion_id BIGINT,
    numeroidentificacion VARCHAR(100),
    extendidoen VARCHAR(100),
    nombreempresa VARCHAR(100),
    direccionempresa VARCHAR(255),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla contratos
CREATE TABLE contratos (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    actividadeconomica VARCHAR(150),
    salariobase DECIMAL(10,2),
    bonoley DECIMAL(10,2),
    comisionfija DECIMAL(10,2),
    bonofijo DECIMAL(10,2),
    comisionvariable DECIMAL(10,2),
    bonovariable DECIMAL(10,2),
    valorhora DECIMAL(10,2),
    periodopago VARCHAR(50),
    textocontrato TEXT,
    tipocontrato_id BIGINT,
    duracioncontrato_id BIGINT,
    jornadas_id BIGINT,
    empresas_id BIGINT,
    puestos_id BIGINT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla empleados (tabla central)
CREATE TABLE empleados (
    id BIGSERIAL PRIMARY KEY,
    codigoempleado VARCHAR(20) NOT NULL,
    secuencias_id BIGINT,
    nombre1 VARCHAR(75),
    nombre2 VARCHAR(75),
    nombre3 VARCHAR(75),
    apellido1 VARCHAR(75),
    apellido2 VARCHAR(75),
    apellidocasada VARCHAR(75),
    correo VARCHAR(75),
    fechanacimiento DATE,
    fechaingreso DATE,
    cantidadhijos INTEGER,
    cantidadvivencasa INTEGER,
    fecharetiro DATE,
    aprueba VARCHAR(10),
    estadosempleado_id BIGINT,
    estadosnomina_id BIGINT,
    jefes_id BIGINT,
    puestos_id BIGINT,
    costos1_id BIGINT,
    costos2_id BIGINT,
    costos3_id BIGINT,
    costos4_id BIGINT,
    regiones_id BIGINT,
    establecimientos_id BIGINT,
    nacionalidades_id BIGINT,
    ocupaciones_id BIGINT,
    idiomas_id BIGINT,
    generos_id BIGINT,
    contratos_id BIGINT,
    discapacidades_id BIGINT,
    estadocivil_id BIGINT,
    ascendencias_id BIGINT,
    estudios_id BIGINT,
    bancos_id BIGINT,
    tipopago_id BIGINT,
    vacantes_id BIGINT,
    codigoanterior VARCHAR(25),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla vacantes
CREATE TABLE vacantes (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(25),
    nombre VARCHAR(50),
    puestos_id BIGINT NOT NULL,
    costos1_id BIGINT NOT NULL,
    costos2_id BIGINT NOT NULL,
    costos3_id BIGINT NOT NULL,
    departamentos_id BIGINT NOT NULL,
    municipios_id BIGINT NOT NULL,
    jefes_id BIGINT NOT NULL,
    tipovacante_id BIGINT NOT NULL,
    empleados_id_1 BIGINT,
    empleados_id_2 BIGINT,
    reclutadores_id BIGINT NOT NULL,
    fecha DATE NOT NULL,
    cantidad INTEGER NOT NULL,
    vigente BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla periodos
CREATE TABLE periodos (
    id BIGSERIAL PRIMARY KEY,
    codigo DATE NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    desde DATE NOT NULL,
    hasta DATE NOT NULL,
    diasperiodo INTEGER,
    comentarios TEXT NOT NULL DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================================
-- TABLAS DE INFORMACIÓN PERSONAL
-- ============================================================================

-- Tabla contactos
CREATE TABLE contactos (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    telefono VARCHAR(75),
    calle VARCHAR(75),
    avenida VARCHAR(50),
    colonia VARCHAR(50),
    zona VARCHAR(50),
    tipocontacto_id BIGINT NOT NULL,
    departamento_id BIGINT,
    municipio_id BIGINT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla identificaciones
CREATE TABLE identificaciones (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    tipoidentificacion_id BIGINT NOT NULL,
    fechaemision DATE NOT NULL,
    fechavencimiento DATE NOT NULL,
    numeroidentificacion VARCHAR(75) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla evaluaciones
CREATE TABLE evaluaciones (
    id BIGSERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    tipoevaluacion_id BIGINT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla experiencias
CREATE TABLE experiencias (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    tipoexperiencia_id BIGINT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla familiares
CREATE TABLE familiares (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    nombrefamiliar VARCHAR(100) NOT NULL,
    profesion VARCHAR(100) NOT NULL,
    fechanacimiento DATE NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    tipofamiliar_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla referencias
CREATE TABLE referencias (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    telefono VARCHAR(75) NOT NULL,
    jefeinmediato VARCHAR(75) NOT NULL,
    teljefe VARCHAR(75) NOT NULL,
    puesto VARCHAR(75) NOT NULL,
    salario DECIMAL(10,2),
    desde DATE,
    hasta DATE,
    tiporeferencia_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla propiedades
CREATE TABLE propiedades (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    fechaentrega DATE NOT NULL,
    cantidad INTEGER NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('ENTREGADO', 'DEVUELTO')),
    fechadevolucion DATE NOT NULL,
    fechavencimiento DATE NOT NULL,
    codigoaf VARCHAR(75) NOT NULL,
    comentarios VARCHAR(150) NOT NULL,
    talla VARCHAR(50) NOT NULL,
    montodescontar DECIMAL(10,2) NOT NULL,
    montototal DECIMAL(10,2) NOT NULL,
    fechareferido DATE,
    tipopropiedad_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================================
-- TABLAS DE NÓMINA Y PAGOS
-- ============================================================================

-- Tabla bonos
CREATE TABLE bonos (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    periodos_id BIGINT NOT NULL,
    bonos DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla comisiones
CREATE TABLE comisiones (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    periodos_id BIGINT NOT NULL,
    comisiones DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla descuentos
CREATE TABLE descuentos (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    periodos_id BIGINT,
    tipodescuento_id BIGINT NOT NULL,
    desde DATE,
    hasta DATE,
    totaldescuento DECIMAL(10,2) NOT NULL,
    cantidadabonos INTEGER,
    cuotaquincenal DECIMAL(10,2) NOT NULL,
    documentodescuento VARCHAR(100) NOT NULL,
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla descansos
CREATE TABLE descansos (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    tipodescanso_id BIGINT NOT NULL,
    periodo VARCHAR(100) NOT NULL,
    desde DATE NOT NULL,
    hasta DATE NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('GENERADAS', 'GOZADAS')),
    cantidaddias INTEGER NOT NULL,
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla horasextras
CREATE TABLE horasextras (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    periodos_id BIGINT NOT NULL,
    simples INTEGER NOT NULL,
    dobles INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla sueldos
CREATE TABLE sueldos (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    periodos_id BIGINT NOT NULL,
    diastrabajados INTEGER NOT NULL,
    basecomisiones DECIMAL(10,2) NOT NULL,
    sueldoquincenal DECIMAL(10,2) NOT NULL,
    cantidadhorassimples DECIMAL(10,2) NOT NULL,
    cantidadhorasdobles DECIMAL(10,2) NOT NULL,
    bonificaciones DECIMAL(10,2) NOT NULL,
    comisionesventas DECIMAL(10,2) NOT NULL,
    horasparciales DECIMAL(10,2),
    devolucionisr DECIMAL(10,2),
    reintegros DECIMAL(10,2),
    cantidadcongeladores INTEGER NOT NULL,
    comisionescongeladores DECIMAL(10,2) NOT NULL,
    totalcomisiones DECIMAL(10,2) NOT NULL,
    totalordinario DECIMAL(10,2) NOT NULL,
    importehorassimples DECIMAL(10,2) NOT NULL,
    importehorasdobles DECIMAL(10,2) NOT NULL,
    totalhorasextras DECIMAL(10,2) NOT NULL,
    vacaciones DECIMAL(10,2) NOT NULL,
    diasausencia DECIMAL(10,2) NOT NULL,
    bonocongeladores DECIMAL(10,2) NOT NULL,
    bonocumplimiento DECIMAL(10,2) NOT NULL,
    bonoretornos DECIMAL(10,2) NOT NULL,
    otrosbonos DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla incrementos
CREATE TABLE incrementos (
    id BIGSERIAL PRIMARY KEY,
    empledos_id BIGINT NOT NULL,
    nombre VARCHAR(75) NOT NULL,
    fecha DATE NOT NULL,
    sueldo DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla indemnizaciones
CREATE TABLE indemnizaciones (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    indemnizacion INTEGER NOT NULL,
    bono14 INTEGER NOT NULL,
    vacaciones INTEGER NOT NULL,
    bonos INTEGER NOT NULL,
    comisiones INTEGER NOT NULL,
    horasextras INTEGER NOT NULL,
    fechabaja DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla provisiones
CREATE TABLE provisiones (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    indemnizacion INTEGER NOT NULL,
    bono14 INTEGER NOT NULL,
    aguinaldo INTEGER NOT NULL,
    vacaciones INTEGER NOT NULL,
    cuentaprovision INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla nominas
CREATE TABLE nominas (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    periodos_id BIGINT NOT NULL,
    costo1 VARCHAR(255),
    costo2 VARCHAR(255),
    costo3 VARCHAR(255),
    costo4 DECIMAL(10,2),
    aprueba VARCHAR(255),
    nombrejefe VARCHAR(255),
    nombreregion VARCHAR(255),
    nombrecosto VARCHAR(255),
    descuentos_id BIGINT,
    sueldos_id BIGINT,
    nombre1 VARCHAR(255),
    nombre2 VARCHAR(255),
    nombre3 VARCHAR(255),
    apellido1 VARCHAR(255),
    apellido2 VARCHAR(255),
    nombrepuesto1 VARCHAR(255),
    nombrepuesto2 VARCHAR(255),
    tipopago VARCHAR(255),
    banco VARCHAR(255),
    grupocuenta VARCHAR(255),
    diastrabajados DECIMAL(10,2),
    diasausencia DECIMAL(10,2),
    horasparciales DECIMAL(10,2),
    fechabaja DATE,
    estado1 VARCHAR(255),
    basemensual DECIMAL(10,2),
    basequincenal DECIMAL(10,2),
    basesemanal DECIMAL(10,2),
    basecomisiones DECIMAL(10,2),
    comisionesventas DECIMAL(10,2),
    cantidadcongeladores INTEGER,
    comisionescongeladores DECIMAL(10,2),
    totalcomisiones DECIMAL(10,2),
    totalordinario DECIMAL(10,2),
    cantidadhorassimples DECIMAL(10,2),
    importehorassimples DECIMAL(10,2),
    cantidadhorasdobles DECIMAL(10,2),
    importehorasdobles DECIMAL(10,2),
    totalhorasextras DECIMAL(10,2),
    vacaciones DECIMAL(10,2),
    afectoigss DECIMAL(10,2),
    bonoley DECIMAL(10,2),
    bonocongeladores DECIMAL(10,2),
    bonocumplimiento DECIMAL(10,2),
    bonoretornos DECIMAL(10,2),
    otrosbonos DECIMAL(10,2),
    nombrebono VARCHAR(255),
    totalbonificaciones DECIMAL(10,2),
    devolucionisr DECIMAL(10,2),
    reintegros DECIMAL(10,2),
    totalingresos DECIMAL(10,2),
    igsslaboral DECIMAL(10,2),
    isranoanterior DECIMAL(10,2),
    isractual DECIMAL(10,2),
    anticiposalario DECIMAL(10,2),
    prestamogyt DECIMAL(10,2),
    prestamobantrab DECIMAL(10,2),
    uniformes DECIMAL(10,2),
    descuentoinventarios DECIMAL(10,2),
    embargos DECIMAL(10,2),
    boletoornato DECIMAL(10,2),
    tarjetasalud DECIMAL(10,2),
    bazares DECIMAL(10,2),
    ventaproducto DECIMAL(10,2),
    otrosdescuentos DECIMAL(10,2),
    nombredescuento VARCHAR(255),
    totaldescuentos DECIMAL(10,2),
    totalegresos DECIMAL(10,2),
    liquidopagar DECIMAL(10,2),
    bono14gasto DECIMAL(10,2),
    aguinaldogasto DECIMAL(10,2),
    igsspatronalgasto DECIMAL(10,2),
    indemnizaciongasto DECIMAL(10,2),
    bono14provision DECIMAL(10,2),
    aguinaldoprovision DECIMAL(10,2),
    igsspatronalprovision DECIMAL(10,2),
    indemnizacionprovision DECIMAL(10,2),
    documentopago VARCHAR(255),
    comentarios TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla jornalizaciones
CREATE TABLE jornalizaciones (
    id BIGSERIAL PRIMARY KEY,
    empleados_id BIGINT NOT NULL,
    periodos_id BIGINT NOT NULL,
    costos1_id BIGINT NOT NULL,
    costos2_id BIGINT NOT NULL,
    costos3_id BIGINT NOT NULL,
    costos4_id BIGINT NOT NULL,
    cuentacontable VARCHAR(75) NOT NULL,
    debe DECIMAL(10,2) NOT NULL,
    haber DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Tabla permisos
CREATE TABLE permisos (
    id BIGSERIAL PRIMARY KEY,
    idusuario INTEGER NOT NULL,
    tablapermiso VARCHAR(255) NOT NULL,
    rutapermiso VARCHAR(255) NOT NULL,
    tipopermiso VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================================
-- FUNCIÓN PARA GENERAR CÓDIGOS DE EMPLEADOS (SIN USAR POR AHORA)
-- ============================================================================

-- Esta función se agregará más tarde si es necesaria
-- CREATE OR REPLACE FUNCTION generate_employee_code()
-- RETURNS TRIGGER AS
-- 'DECLARE
--     new_code VARCHAR(20);
--     sequence_mask VARCHAR(20);
--     next_number INTEGER;
-- BEGIN
--     UPDATE secuencias
--     SET ultimousado = ultimousado + 1
--     WHERE id = NEW.secuencias_id;
--
--     SELECT mascara, ultimousado
--     INTO sequence_mask, next_number
--     FROM secuencias
--     WHERE id = NEW.secuencias_id;
--
--     new_code := sequence_mask || LPAD(next_number::TEXT, 5, ''0'');
--     NEW.codigoempleado := new_code;
--
--     RETURN NEW;
-- END;'
-- LANGUAGE plpgsql;

-- ============================================================================
-- ÍNDICES PARA OPTIMIZACIÓN
-- ============================================================================

CREATE INDEX idx_empleados_codigo ON empleados(codigoempleado);
CREATE INDEX idx_empleados_nombres ON empleados(nombre1, apellido1);
CREATE INDEX idx_contactos_empleado ON contactos(empleados_id);
CREATE INDEX idx_municipios_departamento ON municipios(departamentos_id);
CREATE INDEX idx_vacantes_vigente ON vacantes(vigente);
CREATE INDEX idx_nominas_periodo ON nominas(periodos_id);
CREATE INDEX idx_descuentos_empleado ON descuentos(empleados_id);
CREATE INDEX idx_empleados_secuencia ON empleados(secuencias_id);
CREATE INDEX idx_empleados_puesto ON empleados(puestos_id);
CREATE INDEX idx_vacantes_puesto ON vacantes(puestos_id);
CREATE INDEX idx_contratos_tipo ON contratos(tipocontrato_id);
CREATE INDEX idx_contactos_tipo ON contactos(tipocontacto_id);

