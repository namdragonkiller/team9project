<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/WEB-INF/view/include/page.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>상품 목록</title>
    <%@include file="/WEB-INF/view/include/static.jsp" %>
    <style>
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
    </style>
</head>
<body>
<%@include file="/WEB-INF/view/include/header.jsp" %>
<%@include file="/WEB-INF/view/include/sidenav.jsp" %>

<div class="cart-sidebar" id="cartSidebar">
    <h6>🛒 장바구니 (<span id="cartCount">0</span>)</h6>
    <ul id="cartItems" class="collection"></ul>
    <form id="cartForm" action="/test/list" method="POST">
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
                    <div class="card-image">
                        <img src="${product.image.url}" style="height: 400px;" class="thumbnail">
                        <a class="btn-floating halfway-fab waves-effect black add-cart">
                            <i class="material-icons">add_shopping_cart</i>
                        </a>
                    </div>
                    <div class="card-content">
                        <span class="card-title name"><c:out value="${product.name}"/></span>
                        <p class="info blue-grey-text"><c:out value="${product.info}"/></p>
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
