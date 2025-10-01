// Google Auth temporalmente deshabilitado
class GoogleAuthConfig {
    constructor() {
        this.clientId = '';
        this.initialized = false;
    }

    async initialize() {
        console.log('ℹ️ Google Auth deshabilitado');
        this.initialized = false;
    }

    renderSignInButton(containerId) {
        const container = document.getElementById(containerId);
        if (container) {
            container.style.display = 'none';
        }
    }

    promptGoogleSignIn() {
        console.log('Google Auth no disponible');
    }

    signOut() {}
}

window.googleAuth = new GoogleAuthConfig();
