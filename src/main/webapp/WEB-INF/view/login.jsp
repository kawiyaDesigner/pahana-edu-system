<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - SecureApp</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #667eea;
            --primary-dark: #5a6fd8;
            --secondary-color: #764ba2;
            --background-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --card-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            --input-focus-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        body {
            background: var(--background-gradient);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            max-width: 400px;
            width: 100%;
            padding: 2.5rem;
            position: relative;
            overflow: hidden;
        }

        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--background-gradient);
        }

        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-header h1 {
            color: #2d3748;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .login-header p {
            color: #718096;
            font-size: 0.95rem;
            margin: 0;
        }

        .form-floating {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #f8fafc;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: var(--input-focus-shadow);
            background-color: white;
        }

        .form-floating label {
            color: #718096;
            font-weight: 500;
        }

        .input-group-text {
            background-color: transparent;
            border: 2px solid #e2e8f0;
            border-right: none;
            border-radius: 12px 0 0 12px;
            color: #718096;
        }

        .input-group .form-control {
            border-left: none;
            border-radius: 0 12px 12px 0;
        }

        .btn-login {
            background: var(--background-gradient);
            border: none;
            border-radius: 12px;
            padding: 1rem;
            font-weight: 600;
            font-size: 1rem;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            color:white;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
            color:white;
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .alert-custom {
            border-radius: 12px;
            border: none;
            padding: 1rem;
            margin-bottom: 1.5rem;
            background-color: #fed7d7;
            color: #c53030;
            border-left: 4px solid #e53e3e;
        }

        .forgot-password {
            text-align: center;
            margin-top: 1.5rem;
        }

        .forgot-password a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .forgot-password a:hover {
            color: var(--primary-dark);
        }

        .loading-spinner {
            display: none;
        }

        .btn-login.loading .spinner-border {
            display: inline-block;
        }

        .btn-login.loading .btn-text {
            display: none;
        }

        @media (max-width: 576px) {
            .login-card {
                margin: 10px;
                padding: 2rem;
            }
            
            .login-header h1 {
                font-size: 1.5rem;
            }
        }

        /* Accessibility improvements */
        .form-control:focus {
            outline: none;
        }

        .btn:focus {
            outline: 2px solid var(--primary-color);
            outline-offset: 2px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1><i class="bi bi-shield-lock"></i> Welcome Back</h1>
                <p>Please sign in to your account</p>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-custom" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <c:out value="${error}" escapeXml="true"/>
                </div>
            </c:if>

            <!-- Success Message -->
            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert" style="border-radius: 12px;">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    <c:out value="${success}" escapeXml="true"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm" novalidate>
                <!-- CSRF Token (if using Spring Security) -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                
                <!-- Username Field -->
                <div class="form-floating">
                    <input type="text" 
                           class="form-control" 
                           id="username" 
                           name="username" 
                           placeholder="Enter your username"
                           value="${param.username}"
                           required 
                           autocomplete="username"
                           aria-describedby="usernameHelp">
                    <label for="username">
                        <i class="bi bi-person me-2"></i>Username
                    </label>
                </div>

                <!-- Password Field -->
                <div class="form-floating">
                    <input type="password" 
                           class="form-control" 
                           id="password" 
                           name="password" 
                           placeholder="Enter your password"
                           required 
                           autocomplete="current-password"
                           aria-describedby="passwordHelp">
                    <label for="password">
                        <i class="bi bi-lock me-2"></i>Password
                    </label>
                </div>

                <!-- Remember Me -->
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe">
                    <label class="form-check-label" for="rememberMe">
                        Remember me for 30 days
                    </label>
                </div>

                <!-- Login Button -->
                <button type="submit" class="btn btn-login btn-lg w-100" id="loginBtn">
                    <span class="spinner-border spinner-border-sm loading-spinner me-2" role="status" aria-hidden="true"></span>
                    <span class="btn-text">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
                    </span>
                </button>

                <!-- Forgot Password -->
                <div class="forgot-password">
                    <a href="${pageContext.request.contextPath}/forgot-password">
                        Forgot your password?
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginForm = document.getElementById('loginForm');
            const loginBtn = document.getElementById('loginBtn');
            const usernameInput = document.getElementById('username');
            const passwordInput = document.getElementById('password');

            // Form validation
            function validateForm() {
                let isValid = true;
                
                // Clear previous validation states
                [usernameInput, passwordInput].forEach(input => {
                    input.classList.remove('is-invalid', 'is-valid');
                });

                // Validate username
                if (!usernameInput.value.trim()) {
                    usernameInput.classList.add('is-invalid');
                    isValid = false;
                } else {
                    usernameInput.classList.add('is-valid');
                }

                // Validate password
                if (!passwordInput.value || passwordInput.value.length < 3) {
                    passwordInput.classList.add('is-invalid');
                    isValid = false;
                } else {
                    passwordInput.classList.add('is-valid');
                }

                return isValid;
            }

            // Form submission
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                if (!validateForm()) {
                    return;
                }

                // Show loading state
                loginBtn.classList.add('loading');
                loginBtn.disabled = true;

                // Submit form after a brief delay (for UX)
                setTimeout(() => {
                    loginForm.submit();
                }, 500);
            });

            // Real-time validation
            [usernameInput, passwordInput].forEach(input => {
                input.addEventListener('input', function() {
                    if (this.classList.contains('is-invalid') || this.classList.contains('is-valid')) {
                        validateForm();
                    }
                });
            });

            // Focus management
            if (usernameInput.value) {
                passwordInput.focus();
            } else {
                usernameInput.focus();
            }

            // Handle Enter key
            [usernameInput, passwordInput].forEach(input => {
                input.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        loginForm.dispatchEvent(new Event('submit'));
                    }
                });
            });
        });

        // Auto-dismiss alerts after 5 seconds
        document.querySelectorAll('.alert').forEach(alert => {
            setTimeout(() => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
        });
    </script>
</body>
</html>