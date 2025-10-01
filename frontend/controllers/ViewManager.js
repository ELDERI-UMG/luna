class ViewManager {
    constructor() {
        this.currentView = null;
        this.viewCache = new Map();
        this.mainContent = document.getElementById('main-content');
        this.initializeRouting();
    }

    async loadView(viewPath, data = {}) {
        try {
            let viewHTML;

            // Handle special cases with direct controller methods
            if (viewPath === 'auth/login') {
                if (window.authController) {
                    viewHTML = window.authController.showLoginForm();
                } else {
                    throw new Error('AuthController not available');
                }
            } else if (viewPath === 'auth/register') {
                if (window.authController) {
                    viewHTML = window.authController.showRegisterForm();
                } else {
                    throw new Error('AuthController not available');
                }
            } else if (viewPath === 'products/list') {
                if (window.productController) {
                    await window.productController.showProducts();
                    return true;
                } else {
                    throw new Error('ProductController not available');
                }
            } else if (viewPath === 'cart/cart') {
                if (window.cartController) {
                    await window.cartController.showCart();
                    return true;
                } else {
                    throw new Error('CartController not available');
                }
            } else if (viewPath === 'checkout/payment') {
                if (window.cartController) {
                    window.cartController.showPaymentForm();
                    return true;
                } else {
                    throw new Error('CartController not available');
                }
            } else {
                // Try to load from file for other views
                if (this.viewCache.has(viewPath)) {
                    viewHTML = this.viewCache.get(viewPath);
                } else {
                    const response = await fetch(`views/${viewPath}.html`);
                    if (!response.ok) {
                        throw new Error(`Error loading view: ${viewPath}`);
                    }
                    viewHTML = await response.text();
                    this.viewCache.set(viewPath, viewHTML);
                }
            }

            if (viewHTML) {
                this.mainContent.innerHTML = viewHTML;
                this.currentView = viewPath;

                this.processViewData(data);
                this.attachViewEvents(viewPath);
            }

            return true;
        } catch (error) {
            console.error('Error loading view:', error);
            this.showErrorView(error.message);
            return false;
        }
    }

    async loadSharedComponent(componentPath) {
        try {
            if (this.viewCache.has(componentPath)) {
                return this.viewCache.get(componentPath);
            }
            
            const response = await fetch(`views/shared/${componentPath}.html`);
            if (!response.ok) {
                throw new Error(`Error loading component: ${componentPath}`);
            }
            
            const componentHTML = await response.text();
            this.viewCache.set(componentPath, componentHTML);
            return componentHTML;
        } catch (error) {
            console.error('Error loading component:', error);
            return `<div class="error">Error loading component: ${componentPath}</div>`;
        }
    }

    processViewData(data) {
        Object.keys(data).forEach(key => {
            const elements = this.mainContent.querySelectorAll(`[data-bind="${key}"]`);
            elements.forEach(element => {
                if (element.tagName === 'INPUT') {
                    element.value = data[key];
                } else {
                    element.textContent = data[key];
                }
            });
        });
    }

    attachViewEvents(viewPath) {
        switch (viewPath) {
            case 'auth/login':
                this.attachLoginEvents();
                break;
            case 'auth/register':
                this.attachRegisterEvents();
                break;
            case 'auth/recover-password':
                this.attachRecoverPasswordEvents();
                break;
            case 'products/list':
                this.attachProductsEvents();
                break;
            case 'cart/cart':
                this.attachCartEvents();
                break;
            case 'payment/simulator':
                this.attachPaymentEvents();
                break;
            case 'shared/home':
                this.attachHomeEvents();
                break;
            case 'admin/payment-config':
                this.attachPaymentConfigEvents();
                break;
            case 'checkout/payment':
                this.attachCheckoutEvents();
                break;
            case 'about/index':
                this.attachAboutEvents();
                break;
            case 'services/index':
                this.attachServicesEvents();
                break;
        }
    }

    attachLoginEvents() {
        const loginForm = document.getElementById('login-form');
        const showRegisterLink = document.getElementById('register-link');
        const forgotPasswordLink = document.getElementById('forgot-password-link');

        if (loginForm) {
            loginForm.addEventListener('submit', async (e) => {
                e.preventDefault();
                if (window.authController) {
                    const formData = new FormData(loginForm);
                    await window.authController.handleLogin(formData);
                }
            });
        }

        if (showRegisterLink) {
            showRegisterLink.addEventListener('click', (e) => {
                e.preventDefault();
                this.loadView('auth/register');
            });
        }

        if (forgotPasswordLink) {
            forgotPasswordLink.addEventListener('click', (e) => {
                e.preventDefault();
                this.loadView('auth/recover-password');
            });
        }

        // Initialize Google Sign-In button for login
        console.log('🔧 Setting up Google Sign-In button...');
        if (window.googleAuth && window.googleAuth.initialized) {
            window.googleAuth.renderSignInButton('google-signin-btn');
            console.log('✅ Google Sign-In button rendered immediately');
        } else {
            // Wait for Google Auth to initialize
            console.log('⏳ Waiting for Google Auth to initialize...');
            setTimeout(() => {
                if (window.googleAuth && window.googleAuth.initialized) {
                    window.googleAuth.renderSignInButton('google-signin-btn');
                    console.log('✅ Google Sign-In button rendered after delay');
                } else {
                    console.error('❌ Google Auth still not initialized');
                }
            }, 2000);
        }
    }

    attachRegisterEvents() {
        const registerForm = document.getElementById('register-form');
        const showLoginLink = document.getElementById('login-link-from-register');

        if (registerForm) {
            registerForm.addEventListener('submit', async (e) => {
                e.preventDefault();
                if (window.authController) {
                    const formData = new FormData(registerForm);
                    await window.authController.handleRegister(formData);
                }
            });
        }

        if (showLoginLink) {
            showLoginLink.addEventListener('click', (e) => {
                e.preventDefault();
                this.loadView('auth/login');
            });
        }

        // Initialize Google Sign-In button for registration
        console.log('🔧 Setting up Google Sign-In button for register...');
        if (window.googleAuth && window.googleAuth.initialized) {
            window.googleAuth.renderSignInButton('google-signin-btn');
            console.log('✅ Google Sign-In button rendered immediately');
        } else {
            // Wait for Google Auth to initialize
            console.log('⏳ Waiting for Google Auth to initialize...');
            setTimeout(() => {
                if (window.googleAuth && window.googleAuth.initialized) {
                    window.googleAuth.renderSignInButton('google-signin-btn');
                    console.log('✅ Google Sign-In button rendered after delay');
                } else {
                    console.error('❌ Google Auth still not initialized');
                }
            }, 2000);
        }
    }

    attachRecoverPasswordEvents() {
        const recoverForm = document.getElementById('recover-form');
        const backToLoginLink = document.getElementById('back-to-login-link');

        if (recoverForm) {
            recoverForm.addEventListener('submit', async (e) => {
                e.preventDefault();
                if (window.authController) {
                    const email = document.getElementById('recover-email').value;
                    await window.authController.handleRecoverPassword(email);
                }
            });
        }

        if (backToLoginLink) {
            backToLoginLink.addEventListener('click', (e) => {
                e.preventDefault();
                this.loadView('auth/login');
            });
        }
    }

    attachProductsEvents() {
        const searchBtn = document.getElementById('search-btn');
        const searchInput = document.getElementById('search-input');
        const categoryFilter = document.getElementById('category-filter');
        const priceFilter = document.getElementById('price-filter');
        
        if (searchBtn && window.productController) {
            searchBtn.addEventListener('click', () => {
                window.productController.searchProducts();
            });
        }
        
        if (searchInput && window.productController) {
            searchInput.addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    window.productController.searchProducts();
                }
            });
        }
        
        if (categoryFilter && window.productController) {
            categoryFilter.addEventListener('change', () => {
                window.productController.filterProducts();
            });
        }
        
        if (priceFilter && window.productController) {
            priceFilter.addEventListener('change', () => {
                window.productController.filterProducts();
            });
        }
        
        if (window.productController) {
            window.productController.showProducts();
        }
    }

    attachCartEvents() {
        const clearCartBtn = document.getElementById('clear-cart');
        const checkoutBtn = document.getElementById('checkout-btn');
        const continueShoppingBtn = document.getElementById('continue-shopping');
        
        if (clearCartBtn && window.cartController) {
            clearCartBtn.addEventListener('click', () => {
                window.cartController.clearCart();
            });
        }
        
        if (checkoutBtn) {
            checkoutBtn.addEventListener('click', () => {
                this.loadView('payment/simulator');
            });
        }
        
        if (continueShoppingBtn) {
            continueShoppingBtn.addEventListener('click', (e) => {
                e.preventDefault();
                this.loadView('products/list');
            });
        }
        
        if (window.cartController) {
            window.cartController.displayCartItems();
        }
    }

    attachPaymentEvents() {
        const simulatePaymentBtn = document.getElementById('simulate-payment');
        const cancelPaymentBtn = document.getElementById('cancel-payment');
        const newPaymentBtn = document.getElementById('new-payment');
        const cardNumberInput = document.getElementById('card-number');
        const expiryDateInput = document.getElementById('expiry-date');
        
        if (simulatePaymentBtn) {
            simulatePaymentBtn.addEventListener('click', () => {
                this.simulatePayment();
            });
        }
        
        if (cancelPaymentBtn) {
            cancelPaymentBtn.addEventListener('click', () => {
                this.loadView('cart/cart');
            });
        }
        
        if (newPaymentBtn) {
            newPaymentBtn.addEventListener('click', () => {
                this.resetPaymentForm();
            });
        }
        
        if (cardNumberInput) {
            cardNumberInput.addEventListener('input', (e) => {
                e.target.value = this.formatCardNumber(e.target.value);
            });
        }
        
        if (expiryDateInput) {
            expiryDateInput.addEventListener('input', (e) => {
                e.target.value = this.formatExpiryDate(e.target.value);
            });
        }
        
        this.loadPaymentSummary();
    }

    attachHomeEvents() {
        const browseProductsBtn = document.getElementById('browse-products');
        const categoryCards = document.querySelectorAll('.category-card');
        
        if (browseProductsBtn) {
            browseProductsBtn.addEventListener('click', (e) => {
                e.preventDefault();
                this.loadView('products/list');
            });
        }
        
        categoryCards.forEach(card => {
            card.addEventListener('click', () => {
                const category = card.dataset.category;
                this.loadView('products/list', { selectedCategory: category });
            });
        });
    }

    attachPaymentConfigEvents() {
        console.log('🔧 Setting up payment configuration events');
        
        // Initialize the payment config controller if not already done
        if (!window.paymentConfigController) {
            window.paymentConfigController = new PaymentConfigController();
        }
        
        // Load the payment configuration interface
        window.paymentConfigController.loadPaymentConfig();
    }

    attachCheckoutEvents() {
        console.log('🛒 Setting up checkout events');
        
        // The checkout page initializes itself through inline script
        // This method can be used for additional event handling if needed
    }

    attachAboutEvents() {
        console.log('🏢 Setting up about page events');
        
        // Add any interactive functionality for the about page
        // Currently the page is mostly static with navigation buttons
    }

    attachServicesEvents() {
        console.log('🛠️ Setting up services page events');
        
        // The services page includes inline JavaScript for interactivity
        // This method can be used for additional event handling if needed
    }

    initializeRouting() {
        document.addEventListener('DOMContentLoaded', () => {
            const homeLink = document.getElementById('home-link');
            const productsLink = document.getElementById('products-link');
            const servicesLink = document.getElementById('services-link');
            const cartLink = document.getElementById('cart-link');
            const aboutLink = document.getElementById('about-link');
            const loginLink = document.getElementById('login-link');
            const paymentLink = document.getElementById('payment-link');
            const paymentConfigLink = document.getElementById('payment-config-link');
            const asociadosLink = document.getElementById('asociados-link');
            const soporteLink = document.getElementById('soporte-link');
            
            if (homeLink) {
                homeLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('shared/home');
                });
            }
            
            if (productsLink) {
                productsLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('products/list');
                });
            }
            
            if (servicesLink) {
                servicesLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('services/index');
                });
            }
            
            if (cartLink) {
                cartLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('cart/cart');
                });
            }
            
            if (aboutLink) {
                aboutLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('about/index');
                });
            }
            
            if (loginLink) {
                loginLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('auth/login');
                });
            }
            
            if (paymentLink) {
                paymentLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('payment/simulator');
                });
            }
            
            if (paymentConfigLink) {
                paymentConfigLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('admin/payment-config');
                });
            }
            
            if (asociadosLink) {
                asociadosLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('asociados/index');
                });
            }
            
            if (soporteLink) {
                soporteLink.addEventListener('click', (e) => {
                    e.preventDefault();
                    this.loadView('soporte/index');
                });
            }
            
            this.loadView('shared/home');
        });
    }

    simulatePayment() {
        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked')?.value;
        const cardNumber = document.getElementById('card-number')?.value;
        const expiryDate = document.getElementById('expiry-date')?.value;
        const cvv = document.getElementById('cvv')?.value;
        const cardholderName = document.getElementById('cardholder-name')?.value;
        
        if (!this.validatePaymentForm(paymentMethod, cardNumber, expiryDate, cvv, cardholderName)) {
            return;
        }
        
        const paymentForm = document.querySelector('.payment-form');
        const paymentResult = document.getElementById('payment-result');
        const paymentSuccess = document.getElementById('payment-success');
        const transactionId = document.getElementById('transaction-id');
        
        paymentForm.style.display = 'none';
        paymentResult.style.display = 'block';
        
        const isSuccess = Math.random() > 0.1;
        
        if (isSuccess) {
            paymentSuccess.style.display = 'block';
            transactionId.textContent = 'TXN-' + Date.now();
            
            // Guardar productos comprados antes de limpiar carrito
            this.processPurchase();
            
            if (window.cartController) {
                window.cartController.clearCart();
            }
            
            // Redirigir al catálogo después de 3 segundos y recargar productos
            setTimeout(() => {
                this.loadView('products/list').then(() => {
                    // Forzar recarga de productos después de la redirección
                    if (window.productController) {
                        console.log('🔄 Recargando productos después de compra exitosa');
                        window.productController.showProducts();
                    }
                });
            }, 3000);
        } else {
            document.getElementById('payment-error').style.display = 'block';
        }
    }

    validatePaymentForm(paymentMethod, cardNumber, expiryDate, cvv, cardholderName) {
        if (!paymentMethod || !cardNumber || !expiryDate || !cvv || !cardholderName) {
            alert('Por favor completa todos los campos');
            return false;
        }
        
        if (cardNumber.replace(/\s/g, '').length < 16) {
            alert('Número de tarjeta inválido');
            return false;
        }
        
        return true;
    }

    resetPaymentForm() {
        document.querySelector('.payment-form').style.display = 'block';
        document.getElementById('payment-result').style.display = 'none';
        document.getElementById('payment-success').style.display = 'none';
        document.getElementById('payment-error').style.display = 'none';
        
        document.getElementById('card-number').value = '';
        document.getElementById('expiry-date').value = '';
        document.getElementById('cvv').value = '';
        document.getElementById('cardholder-name').value = '';
    }

    loadPaymentSummary() {
        const paymentItems = document.getElementById('payment-items');
        const paymentTotalAmount = document.getElementById('payment-total-amount');
        
        if (window.cartController && paymentItems && paymentTotalAmount) {
            const cart = window.cartController.getCart();
            let itemsHTML = '';
            let total = 0;
            
            cart.items.forEach(item => {
                const itemTotal = item.price * item.quantity;
                total += itemTotal;
                itemsHTML += `
                    <div class="payment-item">
                        <span>${item.name} x ${item.quantity}</span>
                        <span>$${itemTotal.toFixed(2)}</span>
                    </div>
                `;
            });
            
            paymentItems.innerHTML = itemsHTML;
            paymentTotalAmount.textContent = `$${total.toFixed(2)}`;
        }
    }

    formatCardNumber(value) {
        const v = value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
        const matches = v.match(/\d{4,16}/g);
        const match = matches && matches[0] || '';
        const parts = [];
        
        for (let i = 0, len = match.length; i < len; i += 4) {
            parts.push(match.substring(i, i + 4));
        }
        
        if (parts.length) {
            return parts.join(' ');
        } else {
            return v;
        }
    }

    formatExpiryDate(value) {
        const v = value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
        if (v.length >= 2) {
            return v.substring(0, 2) + '/' + v.substring(2, 4);
        }
        return v;
    }

    showErrorView(message) {
        this.mainContent.innerHTML = `
            <div class="error-container">
                <h2>Error</h2>
                <p>${message}</p>
                <button onclick="window.viewManager.loadView('shared/home')" class="btn btn-primary">
                    Volver al Inicio
                </button>
            </div>
        `;
    }

    // Procesar compra exitosa - crear orden en backend
    async processPurchase() {
        console.log('💳 Procesando compra exitosa');

        if (!window.cartController) {
            console.error('❌ CartController not available');
            return;
        }

        // Obtener items del carrito
        const cart = window.cartController.getCart();

        if (!cart || !cart.items || cart.items.length === 0) {
            console.log('⚠️ No items in cart to process');
            return;
        }

        // Verificar autenticación
        if (!window.app || !window.app.user || !window.app.user.isAuthenticated()) {
            console.error('❌ User not authenticated');
            this.showPurchaseError('Debes iniciar sesión para completar la compra');
            return;
        }

        try {
            // Preparar datos de la orden
            const orderData = {
                productIds: cart.items.map(item => parseInt(item.product_id || item.id)),
                totalAmount: cart.total,
                paymentMethod: 'Simulado',
                paymentId: 'TXN-' + Date.now()
            };

            console.log('📝 Creating order in backend...', orderData);

            // Crear orden en backend
            const response = await fetch('http://localhost:3000/api/purchases/create-order', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${window.app.user.token}`
                },
                body: JSON.stringify(orderData)
            });

            const data = await response.json();

            if (data.success) {
                console.log('✅ Order created successfully:', data);

                // Mostrar mensaje de éxito con detalles
                const purchasedItems = cart.items.map(item => item.name).join(', ');
                const successDiv = document.getElementById('payment-success');
                if (successDiv) {
                    successDiv.innerHTML = `
                        <h3>✅ Pago Exitoso</h3>
                        <p>Tu pago ha sido procesado correctamente</p>
                        <p>Número de transacción: <span id="transaction-id">${orderData.paymentId}</span></p>
                        <p>Número de orden: <strong>#${data.orderId}</strong></p>
                        <p><strong>Productos comprados:</strong> ${purchasedItems}</p>
                        <p>🎁 Serás redirigido al catálogo para descargar tus productos...</p>
                        <p><small>💡 ${data.note || 'Los permisos de descarga se asignarán automáticamente'}</small></p>
                    `;
                }

                console.log('🎉 Compra procesada exitosamente. Orden ID:', data.orderId);

            } else {
                throw new Error(data.error || 'Error al crear la orden');
            }

        } catch (error) {
            console.error('❌ Error processing purchase:', error);
            this.showPurchaseError('Error al procesar la compra: ' + error.message);
        }
    }

    // Show purchase error
    showPurchaseError(message) {
        const successDiv = document.getElementById('payment-success');
        if (successDiv) {
            successDiv.innerHTML = `
                <h3>❌ Error en la Compra</h3>
                <p>${message}</p>
                <button onclick="window.viewManager.resetPaymentForm()" class="btn btn-primary">
                    Intentar de Nuevo
                </button>
            `;
            successDiv.style.display = 'block';
        }
    }

    // Método para navegar al carrito
    async showCart() {
        console.log('🛒 Navigating to cart...');
        return await this.loadView('cart/cart');
    }
}

window.viewManager = new ViewManager();