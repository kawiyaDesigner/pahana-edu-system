<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login");
        return;
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Customer - Pahana Edu</title>
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

        .info-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px 0 rgba(31, 38, 135, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 2.5rem;
            margin: 2rem 0;
        }

        .info-group {
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .info-group:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .info-label {
            font-weight: 600;
            color: #495057;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }

        .info-value {
            font-size: 1.1rem;
            color: #212529;
            font-weight: 500;
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

        .btn {
            border-radius: 25px;
            font-weight: 600;
            padding: 0.5rem 1.2rem;
            transition: all 0.3s ease;
            border: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.8rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }

        .account-number {
            font-family: 'Courier New', monospace;
            font-weight: bold;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.3rem;
        }

        .customer-id {
            font-weight: bold;
            color: #667eea;
            font-size: 1.1rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem 0.5rem;
            }
            
            .info-container {
                padding: 1.5rem;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="container">
        <a href="customer?action=list" class="back-link">Back to Customer List</a>
        
        <div class="page-header">
            <h1 class="page-title">Customer Details</h1>
            <p class="page-subtitle">View customer account information</p>
        </div>
        
        <div class="info-container">
            <div class="info-group">
                <div class="info-label">Customer ID</div>
                <div class="info-value customer-id">${customer.customerId}</div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Account Number</div>
                <div class="info-value account-number">${customer.accountNumber}</div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Full Name</div>
                <div class="info-value">${customer.name}</div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Address</div>
                <div class="info-value">${customer.address}</div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Telephone</div>
                <div class="info-value">${customer.telephone}</div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Email Address</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${not empty customer.email}">
                            ${customer.email}
                        </c:when>
                        <c:otherwise>
                            <span class="text-muted">Not provided</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Registration Date</div>
                <div class="info-value"><fmt:formatDate value="${customer.registrationDate}" pattern="MMMM dd, yyyy" /></div>
            </div>
            
            <div class="action-buttons">
                <a href="customer?action=edit&id=${customer.customerId}" class="btn btn-primary">Edit Customer</a>
                <a href="customer?action=list" class="btn btn-secondary">Back to List</a>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>