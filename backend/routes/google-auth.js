const express = require('express');
const { OAuth2Client } = require('google-auth-library');
const SupabaseUserRepository = require('../src/auth/infrastructure/repositories/SupabaseUserRepository');
const JwtService = require('../src/auth/infrastructure/services/JwtService');
const router = express.Router();

// Initialize Google OAuth client and repositories
const client = new OAuth2Client(process.env.GOOGLE_CLIENT_ID);
const userRepository = new SupabaseUserRepository();
const jwtService = new JwtService();

// Simple test route
router.get('/test', (req, res) => {
    res.json({ 
        message: 'Google Auth routes are working!',
        timestamp: new Date(),
        clientId: process.env.GOOGLE_CLIENT_ID ? 'Loaded' : 'Not loaded'
    });
});

/**
 * Verify Google credential token securely on the server
 * POST /api/auth/google-verify
 */
router.post('/google-verify', async (req, res) => {
    try {
        const { credential, clientId } = req.body;

        if (!credential) {
            return res.status(400).json({
                success: false,
                error: 'Missing credential token'
            });
        }

        // Verify the credential token with Google
        const ticket = await client.verifyIdToken({
            idToken: credential,
            audience: process.env.GOOGLE_CLIENT_ID
        });

        const payload = ticket.getPayload();
        
        if (!payload) {
            return res.status(400).json({
                success: false,
                error: 'Invalid credential token'
            });
        }

        // Extract user information from verified token
        const googleUser = {
            googleId: payload.sub,
            email: payload.email,
            name: payload.name,
            picture: payload.picture,
            emailVerified: payload.email_verified,
            provider: 'google',
            // Additional Google profile data
            givenName: payload.given_name,
            familyName: payload.family_name,
            locale: payload.locale
        };

        console.log('✅ Google token verified for user:', googleUser.email);

        res.json({
            success: true,
            user: googleUser,
            message: 'Google authentication verified successfully'
        });

    } catch (error) {
        console.error('❌ Google token verification error:', error);
        
        res.status(400).json({
            success: false,
            error: 'Failed to verify Google token',
            details: process.env.NODE_ENV === 'development' ? error.message : undefined
        });
    }
});

/**
 * Handle Google login with verified user data
 * POST /api/auth/google-login
 */
router.post('/google-login', async (req, res) => {
    try {
        const { googleId, email, name, picture, emailVerified } = req.body;

        if (!googleId || !email) {
            return res.status(400).json({
                success: false,
                error: 'Missing required Google user data'
            });
        }

        // Check if user exists in Supabase
        let user = await userRepository.findByEmail(email);

        if (!user) {
            // Create new user with Google data
            const googleUser = {
                id: googleId,
                name: name,
                email: email,
                picture: picture
            };

            user = await userRepository.saveGoogleUser(googleUser);
        }

        // Generate JWT token
        const token = jwtService.generateToken({
            id: user.id,
            email: user.email,
            name: user.name
        });

        console.log('🔐 Google login successful for:', email);

        res.json({
            success: true,
            data: {
                user: {
                    id: user.id,
                    name: user.name,
                    email: user.email,
                    picture: user.profile_picture || picture,
                    provider: 'google'
                },
                token: token
            },
            message: 'Google login successful'
        });

    } catch (error) {
        console.error('❌ Google login error:', error);

        res.status(500).json({
            success: false,
            error: 'Internal server error during Google login'
        });
    }
});

/**
 * Handle Google registration with verified user data
 * POST /api/auth/google-register
 */
router.post('/google-register', async (req, res) => {
    try {
        const { googleId, email, name, picture, emailVerified } = req.body;

        if (!googleId || !email || !name) {
            return res.status(400).json({
                success: false,
                error: 'Missing required user data for registration'
            });
        }

        // Here you would typically:
        // 1. Check if user already exists
        // 2. Create new user in database
        // 3. Generate authentication token
        // 4. Send welcome email

        // For now, we'll simulate a successful registration
        const newUser = {
            id: `google_${googleId}`,
            name: name,
            email: email,
            picture: picture,
            provider: 'google',
            emailVerified: emailVerified,
            createdAt: new Date().toISOString()
        };

        // In a real implementation, you'd generate a proper JWT token
        const token = `google_token_${Date.now()}_${googleId}`;

        console.log('👤 Google registration successful for:', email);

        res.json({
            success: true,
            data: {
                user: newUser,
                token: token
            },
            message: 'Google registration successful'
        });

    } catch (error) {
        console.error('❌ Google registration error:', error);
        
        res.status(500).json({
            success: false,
            error: 'Internal server error during Google registration'
        });
    }
});

/**
 * Check if user exists by email
 * POST /api/auth/user-by-email
 */
router.post('/user-by-email', async (req, res) => {
    try {
        const { email } = req.body;

        if (!email) {
            return res.status(400).json({
                success: false,
                error: 'Email is required'
            });
        }

        // Check Supabase for existing user
        const user = await userRepository.findByEmail(email);

        if (user) {
            res.json({
                success: true,
                exists: true,
                message: 'User found'
            });
        } else {
            res.json({
                success: false,
                exists: false,
                message: 'User not found'
            });
        }

    } catch (error) {
        console.error('❌ User lookup error:', error);

        res.status(500).json({
            success: false,
            error: 'Internal server error during user lookup'
        });
    }
});

module.exports = router;