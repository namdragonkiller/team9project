<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <title>주소 변경</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<c:if test="${not empty message}">
    <div class="alert alert-success" role="alert">${message}</div>
</c:if>
<div class="card mx-auto mt-5 p-4" style="max-width:500px; background:#fff; border-radius:1rem;">
    <h4>주소 변경</h4>
    <form:form modelAttribute="addressForm" method="post">
        <div class="mb-3">
            <form:label path="address" cssClass="form-label">새 주소</form:label>
            <form:input path="address" cssClass="form-control" placeholder="도로명, 상세주소 포함"/>
            <form:errors path="address" cssClass="text-danger"/>
        </div>
        <div class="mb-3">
            <form:label path="addressNumber" cssClass="form-label">우편번호</form:label>
            <form:input path="addressNumber" cssClass="form-control" placeholder="12345"/>
            <form:errors path="addressNumber" cssClass="text-danger"/>
        </div>
        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-dark">변경</button>
            <a href="<c:url value='/mypage/mypagemain'/>" class="btn btn-outline-dark">취소</a>
        </div>
    </form:form>
</div>
</body>
</html>


