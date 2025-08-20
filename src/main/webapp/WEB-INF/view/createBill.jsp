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
    <title>Create Bill - Pahana Edu</title>
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
            max-width: 1200px;
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

        .item-row {
            border-bottom: 1px solid #eee;
            padding: 1rem 0;
        }

        .item-select {
            flex: 2;
        }

        .quantity-input {
            flex: 1;
            max-width: 120px;
        }

        .price-display {
            flex: 1;
            text-align: right;
            font-weight: 600;
            color: #28a745;
        }

        .subtotal-display {
            flex: 1;
            text-align: right;
            font-weight: 700;
            color: #667eea;
        }

        .remove-item {
            flex: 0 0 40px;
            text-align: center;
            color: #dc3545;
            cursor: pointer;
        }

        .total-amount {
            font-size: 1.5rem;
            font-weight: 700;
            color: #764ba2;
            text-align: right;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 2px solid #764ba2;
        }

        .add-item-btn {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            border: none;
            border-radius: 25px;
            padding: 0.5rem 1.5rem;
            color: white;
            font-weight: 600;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="container">
        <a href="bill?action=list" class="back-link">Back to Bills</a>
        
        <div class="page-header">
            <h1 class="page-title">Create New Bill</h1>
            <p class="page-subtitle">Generate a new bill for a customer</p>
        </div>
        
        <div class="form-container">
            <form action="bill?action=create" method="post" id="createBillForm">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="customerId">Customer *</label>
                        <select class="form-control" id="customerId" name="customerId" required>
                            <option value="">Select Customer</option>
                            <c:forEach var="customer" items="${customers}">
                                <option value="${customer.customerId}">${customer.name} (${customer.accountNumber})</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group col-md-3">
                        <label for="billDate">Bill Date *</label>
                        <input type="date" class="form-control" id="billDate" name="billDate" required 
                               value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                    </div>
                    
                    <div class="form-group col-md-3">
                        <label for="dueDate">Due Date *</label>
                        <input type="date" class="form-control" id="dueDate" name="dueDate" required>
                    </div>
                </div>
                
                <h4 class="mt-4 mb-3">Items</h4>
                
                <div id="itemsContainer">
                    <div class="item-row row align-items-center">
                        <div class="item-select col-md-5">
                            <select class="form-control item-select" name="itemId" required>
                                <option value="">Select Item</option>
                                <c:forEach var="item" items="${items}">
                                    <option value="${item.itemId}" data-price="${item.price}">${item.name} - LKR ${item.price}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="quantity-input col-md-2">
                            <input type="number" class="form-control" name="quantity" min="1" value="1" required>
                        </div>
                        <div class="price-display col-md-2">
                            LKR <span class="price">0.00</span>
                        </div>
                        <div class="subtotal-display col-md-2">
                            LKR <span class="subtotal">0.00</span>
                        </div>
                        <div class="remove-item col-md-1">
                            <i class="fas fa-times-circle"></i>
                        </div>
                    </div>
                </div>
                
                <button type="button" id="addItem" class="btn add-item-btn">
                    <i class="fas fa-plus"></i> Add Another Item
                </button>
                
                <div class="total-amount">
                    Total: LKR <span id="totalAmount">0.00</span>
                </div>
                
                <button type="submit" class="btn btn-primary">Create Bill</button>
            </form>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Set due date to 30 days from now
            const today = new Date();
            const dueDate = new Date();
            dueDate.setDate(today.getDate() + 30);
            
            $('#dueDate').val(dueDate.toISOString().split('T')[0]);
            
            // Add new item row
            $('#addItem').click(function() {
                const newRow = $('.item-row:first').clone();
                newRow.find('select').val('');
                newRow.find('input').val('1');
                newRow.find('.price').text('0.00');
                newRow.find('.subtotal').text('0.00');
                $('#itemsContainer').append(newRow);
                updateRemoveButtons();
            });
            
            // Update remove buttons
            function updateRemoveButtons() {
                $('.remove-item').off('click').click(function() {
                    if ($('.item-row').length > 1) {
                        $(this).closest('.item-row').remove();
                        calculateTotal();
                    }
                });
            }
            
            // Calculate item subtotal
            $(document).on('change', '.item-select', function() {
                const price = $(this).find('option:selected').data('price') || 0;
                const row = $(this).closest('.item-row');
                row.find('.price').text(price.toFixed(2));
                updateSubtotal(row);
            });
            
            $(document).on('input', 'input[name="quantity"]', function() {
                updateSubtotal($(this).closest('.item-row'));
            });
            
            function updateSubtotal(row) {
                const price = parseFloat(row.find('.price').text()) || 0;
                const quantity = parseInt(row.find('input[name="quantity"]').val()) || 0;
                const subtotal = price * quantity;
                row.find('.subtotal').text(subtotal.toFixed(2));
                calculateTotal();
            }
            
            function calculateTotal() {
                let total = 0;
                $('.subtotal').each(function() {
                    total += parseFloat($(this).text()) || 0;
                });
                $('#totalAmount').text(total.toFixed(2));
            }
            
            // Initialize
            updateRemoveButtons();
            $('.item-select').trigger('change');
        });
    </script>
</body>
</html>