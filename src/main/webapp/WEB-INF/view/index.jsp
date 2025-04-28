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
            flex-direction: column; /* ← 추가 */
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
        .card {
            transform: scale(0.9);
            transform-origin: center center;
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
            margin-left: 230px;
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
        .modalBackground{
            display:none;
            position:fixed;
            top:0; left:0; width:100%; height:100%;
            background:rgba(0,0,0,0.6);
            z-index:999;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .productModal{
            display:none;
            position:fixed;
            top:50%; left:50%; transform:translate(-50%, -50%) scale(0.8);
            background:white;
            padding:20px;
            box-shadow:0 10px 30px rgba(0,0,0,0.3);
            border-radius:12px;
            z-index:1000;
            max-width:600px; width:90%;
            text-align:center;
            opacity: 0;
            transition: all 0.3s ease;
        }
        .pagination {
            display: flex;
            justify-content: center; /* 가로축 중앙 정렬 */
            margin-top: 20px;
        }
        .page-link {
            font-weight: 500;
            font-size: 1rem;
            text-align: center;
            padding: 8px 12px;
            border-radius: 6px;
            background-color: #f8f8f8;
            margin: 0 4px;
            color: black;
            text-decoration: none;
        }

        .page-item.active .page-link {
            background-color: #f08080; /* 선택된 페이지 */
            color: white;
            border: none;
        }

        .page-link:hover {
            background-color: #e0e0e0; /* 살짝 hover 효과 */
        }

        .page-item.disabled .page-link:hover {
            background-color: #eee; /* 비활성은 hover 효과도 막기 */
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
                <div class="card hoverable rounded-card z-depth-2" style="margin: 5px;"
                     data-name="${product.name}"
                     data-image="${product.image.url}"
                     data-info="${product.info}"
                     data-price="${product.price}">
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
                            <p><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>원</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <span class="target" style="display: block; height: 1px;"></span>
    <ul class="pagination mt-3">
        <c:if test="${currentPage > 1}">
            <li class="page-item">
                <a class="page-link" href="/?page=${currentPage - 1}">이전</a>
            </li>
        </c:if>
        <c:if test="${currentPage == 1}">
            <li class="page-item disabled">
                <span class="page-link">이전</span>
            </li>
        </c:if>

        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <li class="page-item active" aria-current="page">
                        <a class="page-link" href="#">${i}</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item"><a class="page-link" href="/?page=${i}">${i}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
            <li class="page-item"><a class="page-link" href="/?page=${currentPage + 1}">다음</a></li>
        </c:if>
        <c:if test="${currentPage == totalPages}">
            <li class="page-item disabled">
                <span class="page-link">다음</span>
            </li>
        </c:if>
    </ul>
</main>
<div id="modalBackground" class="modalBackground" onclick="closeModal()"></div>

<div id="productModal" class="productModal" >
    <img id="modalProductImage" src="" alt="상품 이미지" style="width:100%; border-radius:8px;">
    <h5 id="modalProductName" style="margin-top:15px;"></h5>
    <p id="modalProductInfo" style="color:gray;"></p>
    <p id="modalProductPrice" style="font-weight:bold; font-size:18px;"></p>
    <button onclick="closeModal()" style="margin-top:15px;" class="btn">닫기</button>
</div>


<%@include file="/WEB-INF/view/include/footer.jsp" %>
<script src="${context}/assets/js/sidebar.js" defer></script>
<script src="${context}/assets/js/product-info.js" defer></script>
</body>
</html>