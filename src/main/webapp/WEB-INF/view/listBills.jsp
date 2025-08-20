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
    <title>Bills - Pahana Edu</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            margin-top: 4rem;
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

        .table-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px 0 rgba(31, 38, 135, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 2rem;
            margin: 2rem 0;
        }

        .table {
            margin: 0;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .table thead th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 1rem;
            font-size: 0.9rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
            border: none;
        }

        .table tbody tr:hover {
            background: rgba(102, 126, 234, 0.05);
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.1);
        }

        .table tbody td {
            padding: 1rem;
            border-color: rgba(0, 0, 0, 0.05);
            vertical-align: middle;
            font-weight: 500;
        }

        .table tbody tr:nth-child(even) {
            background-color: rgba(248, 249, 250, 0.5);
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

        .btn-info {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .btn-info:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(79, 172, 254, 0.4);
            color: white;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 1rem 2rem;
            font-size: 1rem;
            margin-top: 1rem;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
        }

        .btn-sm {
            margin: 0 0.25rem;
            padding: 0.4rem 1rem;
        }

        .text-center {
            text-align: center;
        }

        .text-right {
            text-align: right;
            font-weight: 600;
            color: #28a745;
        }

        .actions-cell {
            white-space: nowrap;
            text-align: center;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.3;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.8rem;
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

        @media (max-width: 768px) {
            .container {
                padding: 1rem 0.5rem;
            }
            
            .table-container {
                padding: 1rem;
                margin: 1rem 0;
            }
            
            .page-title {
                font-size: 2rem;
            }
            
            .table {
                font-size: 0.9rem;
            }
            
            .btn-sm {
                padding: 0.3rem 0.8rem;
                font-size: 0.7rem;
                margin: 0.1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Billing Management</h1>
            <p class="page-subtitle">View and manage all bills</p>
        </div>
        
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty bills}">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Bill ID</th>
                                <th>Customer</th>
                                <th>Account #</th>
                                <th>Bill Date</th>
                                <th>Due Date</th>
                                <th>Amount (LKR)</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="bill" items="${bills}">
                                <tr>
                                    <td>${bill.billId}</td>
                                    <td>${bill.customer.name}</td>
                                    <td>${bill.customer.accountNumber}</td>
                                    <td><fmt:formatDate value="${bill.billDate}" pattern="yyyy-MM-dd" /></td>
                                    <td><fmt:formatDate value="${bill.dueDate}" pattern="yyyy-MM-dd" /></td>
                                    <td class="text-right">${bill.totalAmount}</td>
                                    <td>
                                        <span class="status-badge status-${bill.status.toLowerCase()}">${bill.status}</span>
                                    </td>
                                    <td class="actions-cell">
                                        <a href="bill?action=view&id=${bill.billId}" class="btn btn-info btn-sm">View</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div style="font-size: 4rem; margin-bottom: 1rem; opacity: 0.3;"><i class="fas fa-file-invoice-dollar"></i></div>
                        <h3>No Bills Found</h3>
                        <p>Start by creating your first bill for a customer.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="text-center">
            <a href="bill?action=create" class="btn btn-primary">Create New Bill</a>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>