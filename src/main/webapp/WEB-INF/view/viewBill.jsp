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
    <title>View Bill - Pahana Edu</title>
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
            max-width: 1000px;
            padding: 2rem 1rem;
        }

        .invoice-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 2.5rem;
            margin: 2rem 0;
        }

        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 2rem;
            border-bottom: 2px solid #667eea;
            padding-bottom: 1.5rem;
        }

        .invoice-logo {
            font-size: 2rem;
            font-weight: 700;
            color: #667eea;
        }

        .invoice-details {
            text-align: right;
        }

        .invoice-title {
            font-size: 2rem;
            font-weight: 700;
            color: #764ba2;
            margin-bottom: 0.5rem;
        }

        .invoice-number {
            font-size: 1.2rem;
            color: #6c757d;
        }

        .invoice-status {
            display: inline-block;
            padding: 0.5rem 1.5rem;
            border-radius: 20px;
            font-weight: 600;
            margin-top: 1rem;
        }

        .status-pending {
            background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
            color: #856404;
        }

        .status-paid {
            background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
            color: #155724;
        }

        .status-overdue {
            background: linear-gradient(135deg, #ff5858 0%, #f09819 100%);
            color: #721c24;
        }

        .invoice-body {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
        }

        .invoice-from, .invoice-to {
            flex: 1;
        }

        .invoice-section-title {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .invoice-section-content {
            font-size: 1rem;
            color: #212529;
        }

        .invoice-dates {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
        }

        .invoice-date {
            flex: 1;
        }

        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }

        .invoice-table th {
            background-color: #f8f9fa;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: #495057;
            border-bottom: 2px solid #dee2e6;
        }

        .invoice-table td {
            padding: 1rem;
            border-bottom: 1px solid #dee2e6;
        }

        .invoice-table .text-right {
            text-align: right;
        }

        .invoice-totals {
            width: 100%;
            max-width: 300px;
            margin-left: auto;
        }

        .invoice-total-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
        }

        .invoice-total-label {
            font-weight: 600;
        }

        .invoice-total-amount {
            font-weight: 700;
            color: #764ba2;
        }

        .invoice-grand-total {
            font-size: 1.5rem;
            border-top: 2px solid #764ba2;
            margin-top: 0.5rem;
            padding-top: 0.5rem;
        }

        .invoice-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            border-radius: 25px;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            border: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(132, 250, 176, 0.4);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #ff5858 0%, #f09819 100%);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(255, 88, 88, 0.4);
            color: white;
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

        @media (max-width: 768px) {
            .container {
                padding: 1rem 0.5rem;
            }
            
            .invoice-container {
                padding: 1.5rem;
            }
            
            .invoice-header {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }
            
            .invoice-details {
                text-align: center;
                margin-top: 1rem;
            }
            
            .invoice-body {
                flex-direction: column;
            }
            
            .invoice-to {
                margin-top: 1.5rem;
            }
            
            .invoice-actions {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="container">
        
        <div class="invoice-container">
            <div class="invoice-header">
                <div class="invoice-logo">
                    Pahana Edu
                </div>
                <div class="invoice-details">
                    <h1 class="invoice-title">INVOICE</h1>
                    <div class="invoice-number">#${bill.billId}</div>
                    <div class="invoice-status status-${bill.status.toLowerCase()}">${bill.status}</div>
                </div>
            </div>
            
            <div class="invoice-body">
                <div class="invoice-from">
                    <div class="invoice-section-title">From:</div>
                    <div class="invoice-section-content">
                        <strong>Pahana Edu Bookshop</strong><br>
                        123 Book Street<br>
                        Colombo, Sri Lanka<br>
                        Phone: +94 11 123 4567<br>
                        Email: info@pahanaedu.lk
                    </div>
                </div>
                
                <div class="invoice-to">
                    <div class="invoice-section-title">Bill To:</div>
                    <div class="invoice-section-content">
                        <strong>${bill.customer.name}</strong><br>
                        ${bill.customer.address}<br>
                        Phone: ${bill.customer.telephone}<br>
                        Account #: ${bill.customer.accountNumber}
                    </div>
                </div>
            </div>
            
            <div class="invoice-dates">
                <div class="invoice-date">
                    <div class="invoice-section-title">Bill Date:</div>
                    <div class="invoice-section-content">
                        <fmt:formatDate value="${bill.billDate}" pattern="MMMM dd, yyyy" />
                    </div>
                </div>
                
                <div class="invoice-date">
                    <div class="invoice-section-title">Due Date:</div>
                    <div class="invoice-section-content">
                        <fmt:formatDate value="${bill.dueDate}" pattern="MMMM dd, yyyy" />
                    </div>
                </div>
            </div>
            
            <table class="invoice-table">
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Description</th>
                        <th class="text-right">Unit Price</th>
                        <th class="text-right">Quantity</th>
                        <th class="text-right">Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${bill.items}">
                        <tr>
                            <td>${item.item.name}</td>
                            <td>${item.item.description}</td>
                            <td class="text-right">LKR ${item.unitPrice}</td>
                            <td class="text-right">${item.quantity}</td>
                            <td class="text-right">LKR ${item.subtotal}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="invoice-totals">
                <div class="invoice-total-row invoice-grand-total">
                    <div class="invoice-total-label">Total Amount:</div>
                    <div class="invoice-total-amount">LKR ${bill.totalAmount}</div>
                </div>
            </div>
            
            <div class="invoice-actions">
                <a href="bill?action=list" class="btn btn-primary">Back to Bills</a>
                
                <c:if test="${bill.status == 'PENDING'}">
                    <a href="bill?action=updateStatus&id=${bill.billId}&status=PAID" 
                       class="btn btn-success">Mark as Paid</a>
                    <a href="bill?action=updateStatus&id=${bill.billId}&status=OVERDUE" 
                       class="btn btn-danger">Mark as Overdue</a>
                </c:if>
                
                <c:if test="${bill.status == 'PAID'}">
                    <a href="bill?action=updateStatus&id=${bill.billId}&status=PENDING" 
                       class="btn btn-primary">Mark as Pending</a>
                </c:if>
                
                <c:if test="${bill.status == 'OVERDUE'}">
                    <a href="bill?action=updateStatus&id=${bill.billId}&status=PAID" 
                       class="btn btn-success">Mark as Paid</a>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>