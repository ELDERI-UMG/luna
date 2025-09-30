// Vercel Serverless Function - Proxy to Express Backend
const express = require('express');
const cors = require('cors');

// Import use cases and repositories
const SupabaseUserRepository = require('../backend/src/auth/infrastructure/repositories/SupabaseUserRepository');
const LoginUser = require('../backend/src/auth/application/useCases/LoginUser');
const RegisterUser = require('../backend/src/auth/application/useCases/RegisterUser');
const JwtService = require('../backend/src/auth/infrastructure/services/JwtService');

// Import controllers
const AuthControllerClass = require('../backend/src/auth/infrastructure/controllers/AuthController');
const ProductControllerClass = require('../backend/src/products/infrastructure/controllers/ProductController');
const CartControllerClass = require('../backend/src/cart/infrastructure/controllers/CartController');

// Initialize repositories and services
const userRepository = new SupabaseUserRepository();
const jwtService = new JwtService();

// Initialize use cases
const loginUser = new LoginUser(userRepository);
const registerUser = new RegisterUser(userRepository);

// Initialize controllers
const AuthController = new AuthControllerClass(loginUser, registerUser, jwtService);
const ProductController = new ProductControllerClass();
const CartController = new CartControllerClass();

// Auth middleware
const authMiddleware = require('../backend/src/shared/infrastructure/middleware/AuthMiddleware');

// Create Express app
const app = express();

// CORS Configuration
app.use(cors({
    origin: '*',
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(express.json());

// Logging middleware
app.use((req, res, next) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
    next();
});

// Health check
app.get('/api/health', (req, res) => {
    res.json({
        status: 'OK',
        message: 'Server is healthy',
        timestamp: new Date().toISOString()
    });
});

// Auth routes
app.post('/api/auth/register', (req, res) => AuthController.register(req, res));
app.post('/api/auth/login', (req, res) => AuthController.login(req, res));
app.get('/api/auth/profile', authMiddleware, (req, res) => AuthController.getProfile(req, res));
app.post('/api/auth/google-login', (req, res) => AuthController.googleLogin(req, res));

// Product routes
app.get('/api/products', (req, res) => ProductController.getAll(req, res));
app.get('/api/products/search', (req, res) => ProductController.search(req, res));
app.get('/api/products/:id', (req, res) => ProductController.getById(req, res));

// Cart routes
app.get('/api/cart', authMiddleware, (req, res) => CartController.getCart(req, res));
app.post('/api/cart/add', authMiddleware, (req, res) => CartController.addItem(req, res));
app.put('/api/cart/:itemId', authMiddleware, (req, res) => CartController.updateItem(req, res));
app.delete('/api/cart/:itemId', authMiddleware, (req, res) => CartController.removeItem(req, res));
app.delete('/api/cart/clear', authMiddleware, (req, res) => CartController.clearCart(req, res));

// Export as serverless function
module.exports = (req, res) => {
    return app(req, res);
};
