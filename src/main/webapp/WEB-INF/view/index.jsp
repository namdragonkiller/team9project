<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="/WEB-INF/view/include/page.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>상품 목록</title>
    <%@include file="/WEB-INF/view/include/static.jsp" %>
    <style>
        body {
            display: flex;
            min-height: 100vh;
            margin: 0;
        }
        main.container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0;
        }
        .cart-sidebar {
            position: fixed;
            top: 50%;
            left: 80px;
            transform: translateY(-50%);
            width: 240px;
            background-color: white;
            padding: 16px;
            box-shadow: 0 0 8px rgba(0,0,0,0.2);
            border-radius: 8px;
            z-index: 999;
        }

        .rounded-card {
            border-radius: 12px;
        }

        .rounded-card .card-image img {
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }

        .custom-price p {
            font-size: 1.3rem;
            font-weight: bold;
            margin: 0;
        }

        .product-list {
            margin-left: 280px;
        }
        .sold-out-overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0, 0, 0, 0.6);
            color: white;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 1.5rem;
            font-weight: bold;
            z-index: 10;
            pointer-events: none;
        }
        a.add-cart[style*="pointer-events: none"] {
            cursor: not-allowed;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/view/include/header.jsp" %>
<%@include file="/WEB-INF/view/include/sidenav.jsp" %>

<div class="cart-sidebar" id="cartSidebar">
    <h6>🛒 장바구니 (<span id="cartCount">0</span>)</h6>
    <ul id="cartItems" class="collection"></ul>
    <form id="cartForm" action="/product/goCart" method="POST">
        <sec:csrfInput/>
        <div id="cartFormInputs"></div>
        <button type="submit" class="btn btn-small green" style="margin-top: 10px;">구매하기</button>
    </form>
</div>

<main class="container" style="padding: 0;">
    <div class="product-list row center-wrapper">
        <c:forEach items="${products}" var="product">
            <div class="col s12 m6 no-padding" style="max-width: 400px;">
                <div class="card hoverable rounded-card z-depth-2" style="margin: 5px;">
                    <div class="card-image" style="position: relative;">
                        <img src="${product.image.url}"
                             style="height: 400px; filter: ${product.amount <= 0 ? 'brightness(50%)' : 'none'};"
                             class="thumbnail">

                        <c:if test="${product.amount <= 0}">
                            <div class="sold-out-overlay">
                                SOLD OUT
                            </div>
                        </c:if>

                        <a class="btn-floating halfway-fab waves-effect black add-cart"
                           style="${product.amount <= 0 ? 'pointer-events: none; opacity: 0.5;' : ''}">
                            <i class="material-icons">add_shopping_cart</i>
                        </a>
                    </div>
                    <input type="hidden" name="id" value="${product.id}">
                    <div class="card-content">
                        <span class="card-title name"><c:out value="${product.name}"/></span>

                        <c:if test="${product.amount <= 5 and product.amount > 0}">
                            <p class="info blue-grey-text"><c:out value="${product.amount}개 남음"/></p>
                        </c:if>
                        <c:if test="${product.amount > 5 or product.amount <=0}">
                            <br>
                        </c:if>
                        <div class="price center-align custom-price">
                            <p><c:out value="${product.price}"/>원</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <span class="target" style="display: block; height: 1px;"></span>
</main>

<div id="productCardTemplate" style="display: none;">
    <div class="col s12 m6 no-padding" style="max-width: 400px;">
        <div class="card hoverable rounded-card z-depth-2" style="margin: 5px;">
            <div class="card-image">
                <img src="${product.image.url}" style="height: 400px;" class="thumbnail">
                <a class="btn-floating halfway-fab waves-effect black add-cart">
                    <i class="material-icons">add_shopping_cart</i>
                </a>
            </div>
            <input type="hidden" name="id" value="${product.id}">
            <div class="card-content">
                <span class="card-title name"></span>
                <p class="info blue-grey-text"></p>
                <div class="price center-align custom-price"><p></p></div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/view/include/footer.jsp" %>
<script src="${context}/assets/js/sidebar.js" defer></script>
</body>
</html>
