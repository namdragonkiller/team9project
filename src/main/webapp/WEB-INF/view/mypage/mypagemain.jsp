<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body { background: #ddd; }
        .card { margin:auto; max-width:950px; width:90%; box-shadow:0 6px 20px rgba(0,0,0,0.19); border-radius:1rem; }
        .summary { background:#fff; border-top-right-radius:1rem; border-bottom-right-radius:1rem; padding:4vh; color:#000; }
        .alert { margin:1rem; }
    </style>
</head>
<body class="container-fluid">

<div class="row justify-content-center m-4">
    <h1>My Page</h1>
</div>

<div class="card">
    <!-- 1) 플래시 메시지 -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <div class="row">
        <!-- 좌측: 변경 버튼 & 주문내역 -->
        <div class="col-md-8 p-4">
            <div class="list-group mb-4">
                <a href="<c:url value='/mypage/password'/>" class="list-group-item list-group-item-action d-flex justify-content-between">
                    비밀번호 변경 <span class="btn btn-outline-primary btn-sm">변경</span>
                </a>
                <a href="<c:url value='/mypage/email'/>" class="list-group-item list-group-item-action d-flex justify-content-between">
                    이메일 변경   <span class="btn btn-outline-primary btn-sm">변경</span>
                </a>
                <a href="<c:url value='/mypage/address'/>" class="list-group-item list-group-item-action d-flex justify-content-between">
                    주소 변경     <span class="btn btn-outline-primary btn-sm">변경</span>
                </a>
                <a href="<c:url value='/mypage/tel'/>" class="list-group-item list-group-item-action d-flex justify-content-between">
                    전화번호 변경 <span class="btn btn-outline-primary btn-sm">변경</span>
                </a>
            </div>

            <h5 class="mb-3">주문내역</h5>
            <ul class="list-group">
                <c:forEach var="ord" items="${orderHistory}">
                    <li class="list-group-item d-flex align-items-center">
<%--                        <img src="${ord.productImageUrl}" class="img-thumbnail" style="width:4rem;" alt="상품 이미지"/>--%>
<%--                        <div class="ms-3 flex-grow-1">--%>
<%--                            <div>${ord.productName}</div>--%>
<%--                            <div class="text-muted">가격: ${ord.price}원 / ${ord.quantity}개</div>--%>
<%--                        </div>--%>
<%--                        <div class="text-end">--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${ord.createdAt.hour >= 14}">--%>
<%--                                    오후 2시 이후 주문 → 다음날 배송--%>
<%--                                </c:when>--%>
<%--&lt;%&ndash;                                <c:otherwise>${ord.deliveryStatus}</c:otherwise>&ndash;%&gt;--%>
<%--                            </c:choose>--%>
<%--                        </div>--%>
                    </li>
                </c:forEach>
                <c:if test="${empty orderHistory}">
                    <li class="list-group-item text-center">주문 내역이 없습니다.</li>
                </c:if>
            </ul>
        </div>

        <!-- 우측: 내 정보 & 액션 -->
        <div class="col-md-4 summary">
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <h5><b>내 정보</b></h5>

            <p><strong>이메일:</strong> ${currentUser.email}</p>
            <p><strong>주소:</strong> ${currentUser.address}</p>
            <p><strong>우편번호:</strong> ${currentUser.addressNumber}</p>


            <div class="d-grid gap-2 mt-4">
                <!-- 로그아웃 -->
                <form id="logoutForm" action="<c:url value='/logout'/>" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <button class="btn btn-secondary" onclick="document.getElementById('logoutForm').submit()">
                    로그아웃
                </button>

                <!-- 메인페이지로 -->
                <a href="<c:url value='/'/>" class="btn btn-secondary">메인페이지</a>

                <!-- 회원탈퇴 -->
                <form action="<c:url value='/mypage/delete'/>" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-danger">회원탈퇴</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>

