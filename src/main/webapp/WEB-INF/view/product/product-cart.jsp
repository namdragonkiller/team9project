<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/include/page.jsp" %>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
          crossorigin="anonymous">
    <link rel="stylesheet" href="${context}/assets/css/product-cart.css">
    <title>Hello, world!</title>
</head>
<c:set var="totalPrice" value="0" />
<c:forEach items="${cartList}" var="item">
    <c:set var="totalPrice" value="${totalPrice + (item.price * item.amount)}" />
</c:forEach>
<body class="container-fluid">
<div class="row justify-content-center m-4">
    <h1 class="text-center">Grids & Circle</h1>
</div>
<div class="card">
    <div class="row">
        <div class="col-md-8 mt-4 d-flex flex-column align-items-start p-3 pt-0">
            <h5 class="flex-grow-0"><b>장바구니 목록</b></h5>
            <ul class="list-group products">
                <c:forEach items="${cartList}" var="list" varStatus="status">
                    <li class="list-group-item d-flex mt-3">
                        <input type="hidden" name="id" value="${list.id}">
                        <div class="col-2"><img class="img-fluid"
                                                src="${list.imageUrl}" alt="${list.name}"></div>
                        <div class="col">
                            <div class="row text-muted">커피콩</div>
                            <div class="row">${list.name}</div>
                        </div>
                        <div class="col text-center price" data-name="${list.name}"
                             data-id="${list.id}">
                                ${list.price} 원
                        </div>
                        <div class="col-3 text-center price" data-name="${list.name}"
                             data-id="${list.id}">
                                ${list.amount} 개
                        </div>
                        <div class="col text-end action">
                            <button class="btn btn-small btn-outline-dark" data-action="plus">+
                            </button>
                            <button class="btn btn-small btn-outline-dark" data-action="minus">-
                            </button>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            <c:if test="${totalPages > 1}">
                <nav class="mt-4 page-nav">
                    <ul class="pagination justify-content-center">
                        <!-- 이전 버튼 -->
                        <c:if test="${currentPage > 0}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage - 1}&size=5">&laquo; 이전</a>
                            </li>
                        </c:if>

                        <!-- 페이지 번호 -->
                        <c:forEach var="i" begin="0" end="${totalPages - 1}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&size=5">${i + 1}</a>
                            </li>
                        </c:forEach>

                        <!-- 다음 버튼 -->
                        <c:if test="${currentPage < totalPages - 1}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage + 1}&size=5">다음 &raquo;</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </div>
        <div class="col-md-4 summary p-4">
            <%--            <div>--%>
            <%--                <h5 class="m-0 p-0"><b>Summary</b></h5>--%>
            <%--            </div>--%>
            <%--            <hr>--%>
            <div id="summary-items" class="mb-3"></div>
            <form action="${context}/product/purchase" method="post" id="purchase-form">
                <c:choose>
                    <c:when test="${not empty userInfo.id}">
                        <div class="mb-3">
                            <label for="email" class="form-label">아이디</label>
                            <input type="text" class="form-control mb-1" id="userId" name="userId"
                                   value="${userInfo.id}" readonly>
                            <input type="hidden" name="email" id="email" value="${userInfo.email}">
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">주소</label>
                            <input type="text" class="form-control mb-1" id="address" name="address"
                                   value="${userInfo.address}">
                            <p class="red address">주소는 필수 입력입니다.</p>

                        </div>
                        <div class="mb-3">
                            <label for="addressNumber" class="form-label">우편번호</label>
                            <input type="text" class="form-control" id="addressNumber"
                                   name="addressNumber" value="${userInfo.addressNumber}">
                            <p class="red addressNumber">우편번호는 필수 입력입니다.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="mb-3">
                            <label for="email" class="form-label">이메일</label>
                            <input type="email" class="form-control mb-1" id="email" name="email">
                            <p class="red email">이메일은 필수 입력입니다.</p>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">주소</label>
                            <input type="text" class="form-control mb-1" id="address" name="address">
                            <p class="red address">주소는 필수 입력입니다.</p>
                        </div>
                        <div class="mb-3">
                            <label for="addressNumber" class="form-label">우편번호</label>
                            <input type="text" class="form-control" id="addressNumber"
                                   name="addressNumber">
                            <p class="red addressNumber">우편번호는 필수 입력입니다.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div>당일 오후 2시 이후의 주문은 다음날 배송을 시작합니다.</div>
                <div class="row pt-2 pb-2 border-top">
                    <h5 class="col">총금액</h5>
                    <h5 class="col text-end">${totalPrice}원</h5>
                </div>
                <div id="hidden-fields"></div>
                <button type="submit" class="btn btn-dark col-12">결제하기</button>
            </form>
        </div>
    </div>
</div>
<script src="${context}/assets/js/product-cart.js" defer></script>

</body>
</html>