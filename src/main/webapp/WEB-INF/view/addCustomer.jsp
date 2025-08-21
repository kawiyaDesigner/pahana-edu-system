<%
if (session.getAttribute("user") == null) {
    response.sendRedirect("login");
    return;
}
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Customer - Pahana Edu</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            margin-top: 2rem;
            max-width: 800px;
            padding: 2rem 1rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 2rem;
             display:flex;
            justify-content: space-between;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            font-weight: 300;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px 0 rgba(31, 38, 135, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 2.5rem;
            margin: 2rem 0;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .form-group label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            border: 2px solid rgba(102, 126, 234, 0.1);
            border-radius: 15px;
            padding: 1rem 1.25rem;
            font-size: 1rem;
            font-weight: 500;
            background: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: rgba(255, 255, 255, 1);
            transform: translateY(-2px);
        }

        .form-control:hover {
            border-color: rgba(102, 126, 234, 0.3);
            background: rgba(255, 255, 255, 0.9);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            width: 100%;
            margin-top: 1rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:active {
            transform: translateY(-1px);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }

        .back-link:hover {
            color: #764ba2;
            text-decoration: none;
            transform: translateX(-5px);
        }

        .back-link::before {
            content: '←';
            margin-right: 0.5rem;
            font-size: 1.2rem;
        }

        .alert-danger {
            border-radius: 15px;
            background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
            border: none;
            color: #721c24;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
        }

        /* Input focus animations */
        .form-group {
            position: relative;
        }

        .floating-label {
            position: absolute;
            top: 1rem;
            left: 1.25rem;
            background: rgba(255, 255, 255, 0.9);
            padding: 0 0.5rem;
            color: #6c757d;
            transition: all 0.3s ease;
            pointer-events: none;
            font-size: 1rem;
            font-weight: 500;
        }

        .form-control:focus + .floating-label,
        .form-control:not(:placeholder-shown) + .floating-label {
            top: -0.5rem;
            left: 1rem;
            font-size: 0.8rem;
            color: #667eea;
            font-weight: 600;
        }

        /* Success animation */
        .form-container.success {
            animation: successPulse 0.6s ease-in-out;
        }

        @keyframes successPulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }
        
        .info-text {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="container">
       
        <div class="form-container">
         <div class="page-header">
         <a href="customer?action=list" class="back-link">Back to Customer List</a>
            <h1 class="page-title">Add New Customer</h1>
           
        </div>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                </div>
            </c:if>
            
            <form action="customer?action=add" method="post" id="addCustomerForm">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="accountNumber">Account Number *</label>
                        <input type="text" class="form-control" id="accountNumber" name="accountNumber" 
                               placeholder="e.g., CUST001" required pattern="[A-Za-z0-9]+" title="Alphanumeric characters only">
                        <small class="info-text">Unique identifier for the customer</small>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="name">Full Name *</label>
                        <input type="text" class="form-control" id="name" name="name" 
                               placeholder="Customer's full name" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="address">Address *</label>
                    <textarea class="form-control" id="address" name="address" rows="2" 
                              placeholder="Full postal address" required></textarea>
                </div>
                
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="telephone">Telephone *</label>
                        <input type="tel" class="form-control" id="telephone" name="telephone" 
                               placeholder="e.g., 0771234567" required pattern="[0-9]{10}" title="10-digit phone number">
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="email">Email Address</label>
                        <input type="email" class="form-control" id="email" name="email" 
                               placeholder="customer@example.com">
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary">Register Customer</button>
            </form>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>
        // Form validation and animation
        document.getElementById('addCustomerForm').addEventListener('submit', function(e) {
            const formContainer = document.querySelector('.form-container');
            formContainer.classList.add('success');
            
            setTimeout(() => {
                formContainer.classList.remove('success');
            }, 600);
        });

        // Enhanced form interactions
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.classList.remove('focused');
            });
        });
        
        // Auto-format telephone number
        document.getElementById('telephone').addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    </script>
</body>
</html>