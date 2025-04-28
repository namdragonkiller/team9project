<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <title>전화번호 변경</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
          crossorigin="anonymous"/>
    <style>
        body { background: #ddd; }
        .card {
            margin: auto;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 6px 20px rgba(0,0,0,0.19);
            border-radius: 1rem;
            background: #fff;
            padding: 2rem;
        }
        .alert { margin-bottom: 1rem; }
    </style>
</head>
<body>
<!-- 1) 플래시 메시지 -->
<c:if test="${not empty message}">
    <div class="alert alert-success" role="alert">
            ${message}
    </div>
</c:if>

<div class="card">
    <h4 class="mb-4">전화번호 변경</h4>
    <form:form modelAttribute="telForm" method="post">
        <div class="mb-3">
            <form:label path="tel" cssClass="form-label">새 전화번호</form:label>
            <form:input path="tel" cssClass="form-control" placeholder="010-1234-5678"/>
            <form:errors path="tel" cssClass="text-danger"/>
        </div>
        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-dark">변경</button>
            <!-- 취소 버튼 -->
            <a href="<c:url value='/mypage/mypagemain'/>" class="btn btn-outline-secondary">
                취소
            </a>
            <!-- 마이페이지로 돌아가기 -->
            <a href="<c:url value='/mypage/mypagemain'/>" class="btn btn-secondary">
                마이페이지
            </a>
        </div>
    </form:form>
</div>
</body>
</html>

