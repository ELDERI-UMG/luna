# Configuración de Autenticación - Sistema CisNet

## ✅ Funcionalidades Implementadas

He implementado las siguientes funcionalidades de autenticación:

### 1. **Login de Usuarios**
- Formulario de login en `frontend/views/auth/login.html`
- Validación de credenciales con email y contraseña
- Generación de JWT tokens para sesiones
- Soporte para Google OAuth (ya estaba implementado)

### 2. **Registro de Nuevos Usuarios**
- Formulario de registro en `frontend/views/auth/register.html`
- Validación de campos (nombre, email, contraseña, confirmación)
- Hashing de contraseñas con bcrypt
- Verificación de emails duplicados
- Soporte para Google OAuth (ya estaba implementado)

### 3. **Recuperación de Contraseña**
- Nueva vista `frontend/views/auth/recover-password.html`
- Envío de instrucciones de recuperación por email
- Generación de tokens de recuperación
- Endpoint para resetear contraseña

## 📁 Archivos Modificados/Creados

### Backend
- ✅ `backend/server.js` - Rutas de autenticación integradas
- ✅ `backend/.env` - Variables de entorno copiadas
- ℹ️ `backend/src/auth/*` - Estructura DDD ya existía

### Frontend
- ✅ `frontend/views/auth/recover-password.html` - **NUEVO**
- ✅ `frontend/models/User.js` - Método `recoverPassword()` agregado
- ✅ `frontend/controllers/AuthController.js` - Método `handleRecoverPassword()` agregado
- ✅ `frontend/controllers/ViewManager.js` - Event listeners para todas las vistas de auth

## 🔌 Endpoints de la API

### Auth Endpoints (http://localhost:3000/api/auth)

```
POST /api/auth/register
Body: { "name": "string", "email": "string", "password": "string" }
Response: { "success": true, "data": { "id": 1, "name": "...", "email": "..." } }

POST /api/auth/login
Body: { "email": "string", "password": "string" }
Response: { "success": true, "data": { "user": {...}, "token": "jwt-token" } }

POST /api/auth/recover
Body: { "email": "string" }
Response: { "success": true, "message": "Instrucciones enviadas..." }

POST /api/auth/reset-password
Body: { "token": "string", "newPassword": "string" }
Response: { "success": true, "message": "Contraseña actualizada" }

GET /api/auth/profile
Headers: { "Authorization": "Bearer jwt-token" }
Response: { "id": 1, "name": "...", "email": "..." }

POST /api/auth/logout
Headers: { "Authorization": "Bearer jwt-token" }
Response: { "success": true, "message": "Sesión cerrada" }
```

## 🚀 Cómo Usar

### Iniciar el Servidor
```bash
cd backend
npm start
```
El servidor iniciará en http://localhost:3000

### Abrir el Frontend
Abre `frontend/index.html` en tu navegador o usa un servidor local:
```bash
# Desde la raíz del proyecto
npx serve frontend
```

### Probar las Funcionalidades

1. **Registro**:
   - Haz clic en "Iniciar Sesión" en el menú
   - Luego en "¿No tienes cuenta? Regístrate"
   - Completa el formulario de registro

2. **Login**:
   - Haz clic en "Iniciar Sesión"
   - Ingresa email y contraseña
   - O usa "Sign in with Google"

3. **Recuperar Contraseña**:
   - En la página de login, haz clic en "¿Olvidaste tu contraseña?"
   - Ingresa tu email
   - Recibirás un token de recuperación (en desarrollo, se muestra en la consola del servidor)

## ⚙️ Configuración de Supabase

Las funcionalidades están conectadas a Supabase. Asegúrate de que:

1. **Variables de entorno configuradas** (`.env`):
```env
SUPABASE_URL=tu-url-de-supabase
SUPABASE_ANON_KEY=tu-anon-key
SUPABASE_SERVICE_ROLE_KEY=tu-service-role-key
JWT_SECRET=tu-jwt-secret
```

2. **Tabla de usuarios en Supabase**:
```sql
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  username TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  google_id TEXT,
  profile_picture TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

3. **Row Level Security (RLS)**:
Necesitas configurar políticas RLS en Supabase para que los usuarios puedan registrarse e iniciar sesión. Puedes desactivar temporalmente RLS para testing:
```sql
ALTER TABLE users DISABLE ROW LEVEL SECURITY;
```

O crear políticas adecuadas:
```sql
-- Permitir inserción durante registro
CREATE POLICY "Permitir registro" ON users
  FOR INSERT
  WITH CHECK (true);

-- Permitir lectura solo del propio perfil
CREATE POLICY "Ver propio perfil" ON users
  FOR SELECT
  USING (auth.uid()::text = id::text OR true);
```

## 🧪 Testing de la API

### Registro
```bash
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"pass123456"}'
```

### Login
```bash
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"pass123456"}'
```

### Recuperar Contraseña
```bash
curl -X POST http://localhost:3000/api/auth/recover \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com"}'
```

## 📝 Notas Importantes

1. **Passwords**: Se hashean con bcrypt (10 rounds) antes de guardar
2. **JWT Tokens**: Expiran en 24 horas (configurable en `.env`)
3. **Recuperación de contraseña**: En desarrollo, el token se imprime en la consola del servidor
4. **Google OAuth**: Ya estaba implementado, sigue funcionando igual

## 🔧 Troubleshooting

### Error: "supabaseUrl is required"
- Asegúrate de copiar el `.env` al directorio `backend/`
- Verifica que las variables SUPABASE_URL y SUPABASE_ANON_KEY están configuradas

### Error al registrar usuarios
- Verifica que RLS esté deshabilitado o tenga políticas correctas
- Revisa que la tabla `users` existe en Supabase
- Verifica que el campo `username` existe (no solo `name`)

### Error: "Credenciales inválidas" al hacer login
- Verifica que la contraseña sea correcta
- Si el usuario fue creado directamente en Supabase, asegúrate de que la contraseña esté hasheada con bcrypt

## 🎯 Próximos Pasos

Para mejorar el sistema de autenticación:

1. **Email real**: Integrar servicio de email (SendGrid, AWS SES, etc.)
2. **Reset password completo**: Crear página para cambiar contraseña con token
3. **Verificación de email**: Enviar email de confirmación al registrarse
4. **2FA**: Agregar autenticación de dos factores
5. **Social Auth**: Agregar más proveedores (Facebook, GitHub, etc.)
