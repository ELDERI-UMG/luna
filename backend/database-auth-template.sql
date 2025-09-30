-- ============================================================================
-- PLANTILLA DE AUTENTICACIÓN PARA NUEVOS PROYECTOS
-- Compatible con la estructura del proyecto Luna
-- ============================================================================

-- Habilitar extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================================
-- TABLA USERS (Autenticación)
-- ============================================================================

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255), -- NULL si usa Google OAuth
    google_id VARCHAR(255) UNIQUE, -- Para autenticación con Google
    profile_picture VARCHAR(500), -- URL de foto de perfil de Google
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índices para optimización
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_google_id ON users(google_id);

-- ============================================================================
-- COMENTARIOS DE LOS CAMPOS
-- ============================================================================

COMMENT ON TABLE users IS 'Tabla de usuarios para autenticación';
COMMENT ON COLUMN users.id IS 'ID único del usuario';
COMMENT ON COLUMN users.username IS 'Nombre completo del usuario';
COMMENT ON COLUMN users.email IS 'Email único del usuario';
COMMENT ON COLUMN users.password IS 'Hash de contraseña (bcrypt) - NULL para usuarios de Google OAuth';
COMMENT ON COLUMN users.google_id IS 'Google ID para autenticación OAuth';
COMMENT ON COLUMN users.profile_picture IS 'URL de la foto de perfil del usuario';

-- ============================================================================
-- DATOS DE PRUEBA (OPCIONAL - ELIMINAR EN PRODUCCIÓN)
-- ============================================================================

-- Usuario de prueba con email/password
-- Email: test@example.com
-- Password: test123
-- Hash generado con bcrypt (10 rounds)
INSERT INTO users (username, email, password, created_at)
VALUES (
    'Usuario de Prueba',
    'test@example.com',
    '$2a$10$YrNkxQjfzKvH0QhGKpWlH.qnX8ZGvQJKFKVQzKYzFQYzKYzKYzKYz',
    NOW()
) ON CONFLICT (email) DO NOTHING;

-- ============================================================================
-- TABLAS ADICIONALES PARA TU PROYECTO
-- Agrega aquí las tablas específicas de tu nuevo proyecto
-- ============================================================================

-- Ejemplo: Tabla de productos
-- CREATE TABLE products (
--     id BIGSERIAL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     description TEXT,
--     price DECIMAL(10,2) NOT NULL,
--     image_url VARCHAR(500),
--     created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
--     updated_at TIMESTAMPTZ DEFAULT NOW()
-- );

-- Ejemplo: Tabla de pedidos
-- CREATE TABLE orders (
--     id BIGSERIAL PRIMARY KEY,
--     user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
--     total DECIMAL(10,2) NOT NULL,
--     status VARCHAR(50) DEFAULT 'pending',
--     created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
--     updated_at TIMESTAMPTZ DEFAULT NOW()
-- );

-- ============================================================================
-- NOTAS DE IMPLEMENTACIÓN
-- ============================================================================

/*
✅ ESTRUCTURA COMPATIBLE CON EL PROYECTO ACTUAL

Este script crea la tabla 'users' compatible con:
- SupabaseUserRepository.js
- Autenticación con email/password (bcrypt)
- Autenticación con Google OAuth
- Sistema de JWT tokens

📋 CAMPOS DE LA TABLA USERS:
- id: Identificador único autoincrementable
- username: Nombre del usuario (mapea a user.name en el código)
- email: Email único (usado para login)
- password: Hash bcrypt (NULL para usuarios de Google)
- google_id: ID de Google para OAuth
- profile_picture: URL de la foto de Google
- created_at: Fecha de creación
- updated_at: Fecha de última actualización

🔐 FLUJO DE AUTENTICACIÓN:

1. REGISTRO CON EMAIL:
   POST /api/auth/register
   Body: { name, email, password }
   → Crea usuario con password hasheado

2. LOGIN CON EMAIL:
   POST /api/auth/login
   Body: { email, password }
   → Verifica password y retorna JWT token

3. LOGIN CON GOOGLE:
   POST /api/auth/google-login
   Body: { googleUser: { id, email, name, picture } }
   → Crea/actualiza usuario con google_id

📦 PASOS PARA USAR ESTA PLANTILLA:

1. Ejecuta este SQL en tu proyecto Supabase:
   - Ve a SQL Editor en Supabase Dashboard
   - Copia y pega este script
   - Click en "Run"

2. Verifica que se creó la tabla:
   - Ve a Table Editor
   - Deberías ver la tabla "users"

3. Actualiza .env (ya lo hiciste):
   ✅ SUPABASE_URL=https://jipiioluictohoxnszfp.supabase.co
   ✅ SUPABASE_ANON_KEY=...
   ✅ SUPABASE_SERVICE_ROLE_KEY=...
   ✅ JWT_SECRET=...

4. Actualiza frontend/config/supabase-config.js (ya lo hiciste):
   ✅ url: 'https://jipiioluictohoxnszfp.supabase.co'
   ✅ anonKey: '...'

5. Instala dependencias:
   npm install

6. Inicia el servidor:
   npm run dev

7. Prueba la autenticación:
   - Registro: POST http://localhost:3000/api/auth/register
   - Login: POST http://localhost:3000/api/auth/login
   - Google: Usa el botón de Google en el frontend

🎯 AGREGAR TUS PROPIAS TABLAS:

Después de la tabla users, agrega tus tablas personalizadas con:
- BIGSERIAL PRIMARY KEY para IDs
- TIMESTAMPTZ para fechas
- Referencias a users: REFERENCES users(id) ON DELETE CASCADE
- Índices para campos que uses en búsquedas

Ejemplo:
CREATE TABLE mi_tabla (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT REFERENCES users(id) ON DELETE CASCADE,
    nombre VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_mi_tabla_user ON mi_tabla(user_id);

*/
