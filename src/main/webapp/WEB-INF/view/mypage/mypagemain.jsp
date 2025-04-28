<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
          rel="stylesheet"/>
    <style>
        body {
            background: #ddd;
        }

        .card {
            margin: auto;
            max-width: 950px;
            width: 90%;
            box-shadow: 0 6px 20px rgba(0,0,0,0.19);
            border-radius: 1rem;
            overflow: hidden;
        }

        .summary {
            background: #fff;
            padding: 4vh;
            color: #000;
        }

        .alert {
            margin: 1rem;
        }
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
            </div>
        </div>
    </div>
</div>

</body>
</html>

