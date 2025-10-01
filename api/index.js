// Vercel Serverless Function - Proxy to Express Backend
const express = require('express');
const cors = require('cors');

// Import controllers
const AuthControllerClass = require('../backend/src/auth/infrastructure/controllers/AuthController');
const ProductControllerClass = require('../backend/src/products/infrastructure/controllers/ProductController');
const CartControllerClass = require('../backend/src/cart/infrastructure/controllers/CartController');

// Initialize controllers (they create their own dependencies internally)
const AuthController = new AuthControllerClass();
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
app.post('/api/auth/register', AuthController.register);
app.post('/api/auth/login', AuthController.login);
app.post('/api/auth/recover', AuthController.recover);
app.post('/api/auth/reset-password', AuthController.resetPassword);
app.post('/api/auth/logout', AuthController.logout);
app.get('/api/auth/profile', authMiddleware, AuthController.profile);

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

// Error handler
app.use((error, req, res, next) => {
    console.error('❌ API Error:', error);
    console.error('Stack:', error.stack);
    res.status(500).json({
        success: false,
        error: error.message || 'Internal server error',
        details: process.env.NODE_ENV === 'development' ? error.stack : undefined
    });
});

// Export as serverless function
module.exports = (req, res) => {
    return app(req, res);
};
