<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.modern-navbar {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    backdrop-filter: blur(10px);
    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
    border: 1px solid rgba(255, 255, 255, 0.18);
    padding: 1rem 2rem;
    transition: all 0.3s ease;
    position:fixed;
    top:0;
    left:0;
    width:100%;
    z-index:1000;
}

.modern-navbar .navbar-brand {
    font-weight: 700;
    font-size: 1.5rem;
    color: white !important;
    text-decoration: none;
    transition: all 0.3s ease;
}

.modern-navbar .navbar-brand:hover {
    transform: scale(1.05);
    text-shadow: 0 0 20px rgba(255, 255, 255, 0.5);
}

.modern-navbar .navbar-toggler {
    border: 2px solid rgba(255, 255, 255, 0.3);
    border-radius: 8px;
    padding: 0.5rem;
    transition: all 0.3s ease;
}

.modern-navbar .navbar-toggler:hover {
    border-color: rgba(255, 255, 255, 0.6);
    background: rgba(255, 255, 255, 0.1);
}

.modern-navbar .navbar-toggler-icon {
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.8%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
}

.modern-navbar .nav-link {
    color: rgba(255, 255, 255, 0.9) !important;
    font-weight: 500;
    padding: 0.5rem 1rem !important;
    border-radius: 25px;
    margin: 0 0.25rem;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.modern-navbar .nav-link::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

.modern-navbar .nav-link:hover {
    color: white !important;
    background: rgba(255, 255, 255, 0.15);
    transform: translateY(-2px);
    box-shadow: 0 4px 15px 0 rgba(31, 38, 135, 0.3);
}

.modern-navbar .nav-link:hover::before {
    left: 100%;
}

.modern-navbar .nav-item.active .nav-link {
    background: rgba(255, 255, 255, 0.2);
    color: white !important;
}


</style>
<nav class="navbar navbar-expand-lg modern-navbar">
  <a class="navbar-brand" href="product?action=list">Pahana Edu</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" 
          data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" 
          aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav mr-auto">
     
      <li class="nav-item">
		    <a class="nav-link" href="item?action=list">Manage Items</a>
		</li>
		<li class="nav-item">
		    <a class="nav-link" href="customer?action=list">Manage Customers</a>
		</li>
		<li class="nav-item">
		    <a class="nav-link" href="bill?action=list">Billing</a>
		</li>
    
    </ul>

    <ul class="navbar-nav ml-auto">
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <li class="nav-item">
            <a class="nav-link" href="#">Hello, ${sessionScope.user.username}</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="logout">Logout</a>
          </li>
        </c:when>
        <c:otherwise>
          <li class="nav-item">
            <a class="nav-link" href="login">Login</a>
          </li>
        </c:otherwise>
      </c:choose>
    </ul>
  </div>
</nav>
