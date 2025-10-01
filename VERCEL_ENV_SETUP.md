# Configuración de Variables de Entorno en Vercel

## ⚠️ IMPORTANTE - Variables Requeridas

El sistema de autenticación **NO FUNCIONARÁ** sin estas variables de entorno configuradas en Vercel:

## 📋 Variables que DEBES configurar

Ve a tu proyecto en Vercel: https://vercel.com/tu-usuario/luna

1. **Settings** → **Environment Variables**

2. Agrega las siguientes variables:

### Variables de Supabase (REQUERIDAS)
```
SUPABASE_URL=https://jipiioluictohoxnszfp.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImppcGlpb2x1aWN0b2hveG5zemZwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkwMTg3NzMsImV4cCI6MjA3NDU5NDc3M30.lcIi7NP3t7S9sWN7HcKmFIjqZYcmiiCFalt-TV--69g
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImppcGlpb2x1aWN0b2hveG5zemZwIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1OTAxODc3MywiZXhwIjoyMDc0NTk0NzczfQ.Y1xtoVR0SV9NemuvT9O6XMS2t4MtlK6oJrnGquStk3A
```

### Variable JWT (REQUERIDA)
```
JWT_SECRET=j2L4754wyQna46zpvqfae7hg6RDimsCXiJL2HrYI6tSNgo7ucyYY7cHhzPEHvHzCDUDe6O4pe9p6FUHPtM8lOQ==
```

### Variable de Entorno (REQUERIDA)
```
NODE_ENV=production
```

## 🎯 Pasos para Configurar

1. **Ir a Vercel Dashboard**: https://vercel.com
2. Seleccionar tu proyecto **luna**
3. Click en **Settings** (arriba)
4. Click en **Environment Variables** (menú izquierdo)
5. Para cada variable:
   - **Key**: Nombre de la variable (ej: `SUPABASE_URL`)
   - **Value**: Valor de la variable
   - **Environment**: Seleccionar **Production**, **Preview**, y **Development**
   - Click **Save**

## 🔄 Después de Configurar

1. Ve a **Deployments**
2. Click en **...** (tres puntos) del último deployment
3. Click **Redeploy**
4. Selecciona **Use existing Build Cache** (opcional)
5. Click **Redeploy**

## ✅ Verificar Configuración

Después del redeploy, prueba:

```bash
curl https://tu-proyecto.vercel.app/api/health
```

Debería devolver:
```json
{"status":"OK","message":"Server is healthy","timestamp":"..."}
```

Luego prueba el registro:
```bash
curl -X POST https://tu-proyecto.vercel.app/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test","email":"test@example.com","password":"test123"}'
```

## 🐛 Troubleshooting

### Error: "supabaseUrl is required"
- Verifica que `SUPABASE_URL` está configurado correctamente
- Asegúrate de hacer redeploy después de agregar las variables

### Error 500 en /api/auth/register
- Verifica que todas las variables están configuradas
- Revisa los logs en Vercel: **Deployments** → Click en el deployment → **Function Logs**

### Error: "Internal Server Error"
- Puede ser un problema con Supabase RLS (Row Level Security)
- Ve a Supabase → SQL Editor y ejecuta:
  ```sql
  ALTER TABLE users DISABLE ROW LEVEL SECURITY;
  ```

## 📝 Notas de Seguridad

⚠️ **IMPORTANTE**: Las variables de entorno en Vercel son **seguras** y no se exponen al frontend.
- Solo están disponibles en el servidor (api/index.js)
- No aparecen en el código del cliente
- Vercel las encripta y protege

## 🎉 ¡Listo!

Una vez configuradas las variables y redesplegado, tu sistema de autenticación funcionará perfectamente en producción.
