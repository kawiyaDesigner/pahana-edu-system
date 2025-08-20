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
    <title>Edit Item - Pahana Edu</title>
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
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: rgba(255, 255, 255, 1);
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
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
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
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="container">
        <a href="item?action=list" class="back-link">Back to Item List</a>
        
        <div class="page-header">
            <h1 class="page-title">Edit Item</h1>
            <p class="page-subtitle">Update item information</p>
        </div>
        
        <div class="form-container">
            <form action="item?action=update" method="post">
                <input type="hidden" name="id" value="${item.itemId}" />
                
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="name">Item Name</label>
                        <input type="text" class="form-control" id="name" name="name" value="${item.name}" required>
                    </div>
                    
                    <div class="form-group col-md-6">
                        <label for="category">Category</label>
                        <select class="form-control" id="category" name="category" required>
                            <option value="Textbooks" ${item.category == 'Textbooks' ? 'selected' : ''}>Textbooks</option>
                            <option value="Novels" ${item.category == 'Novels' ? 'selected' : ''}>Novels</option>
                            <option value="Reference" ${item.category == 'Reference' ? 'selected' : ''}>Reference Books</option>
                            <option value="Children" ${item.category == 'Children' ? 'selected' : ''}>Children's Books</option>
                            <option value="Academic" ${item.category == 'Academic' ? 'selected' : ''}>Academic Publications</option>
                            <option value="Stationery" ${item.category == 'Stationery' ? 'selected' : ''}>Stationery</option>
                            <option value="Other" ${item.category == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <label for="price">Price (LKR)</label>
                        <input type="number" class="form-control" step="0.01" min="0" id="price" name="price" value="${item.price}" required>
                    </div>
                    
                    <div class="form-group col-md-4">
                        <label for="stockQuantity">Stock Quantity</label>
                        <input type="number" class="form-control" min="0" id="stockQuantity" name="stockQuantity" value="${item.stockQuantity}" required>
                    </div>
                    
                    <div class="form-group col-md-4">
                        <label for="itemId">Item ID</label>
                        <input type="text" class="form-control" id="itemId" value="${item.itemId}" disabled>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea class="form-control" id="description" name="description" rows="3">${item.description}</textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">Update Item</button>
            </form>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>