// Script para crear un usuario de prueba con hash real de bcrypt
const bcrypt = require('bcryptjs');

async function generatePasswordHash() {
    const password = 'test123';
    const hash = await bcrypt.hash(password, 10);

    console.log('\n=== USUARIO DE PRUEBA ===');
    console.log('Email: test@example.com');
    console.log('Password:', password);
    console.log('\n=== SQL PARA INSERTAR EN SUPABASE ===\n');
    console.log(`INSERT INTO users (username, email, password, created_at)`);
    console.log(`VALUES (`);
    console.log(`    'Usuario de Prueba',`);
    console.log(`    'test@example.com',`);
    console.log(`    '${hash}',`);
    console.log(`    NOW()`);
    console.log(`) ON CONFLICT (email) DO UPDATE SET password = EXCLUDED.password;`);
    console.log('\n');
}

generatePasswordHash();
