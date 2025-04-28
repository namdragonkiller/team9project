<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/include/page.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Grepp</title>
    <%@include file="/WEB-INF/view/include/static.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/view/include/header.jsp" %>
<%@include file="/WEB-INF/view/include/sidenav.jsp" %>
<main class="container">
    <c:if test="${not empty errorMessage}">
        <div class="card-panel red lighten-2 text-white">아이디나 비밀번호를 확인하세요</div>
    </c:if>
    <form:form modelAttribute="signinForm" class="col s12" action="/user/signin" method="post">
        <sec:csrfInput/>
        <div class="row">
            <div class="input-field col s7 ">
                <i class="material-icons prefix">account_circle</i>
                <form:input path="id" id="id" name="id" type="text" placeholder="아이디"
                            class="validate"/>
                <form:errors path="id" cssClass="helper-text"/>
            </div>
            <div class="input-field col s7 ">
                <i class="material-icons prefix">lock</i>
                <form:input path="password" id="password" name="password" type="password"
                            placeholder="비밀번호"
                            class="validate"/>
                <form:errors path="password" cssClass="helper-text"/>
            </div>
        </div>
        <div class="row">
            <p>
                <label>
                    <input type="checkbox" name="remember-me" />
                    <span>remember-me</span>
                </label>
            </p>
        </div>
        <button class="btn grey waves-effect waves-light offset-s1" type="submit" name="action">
            로그인
            <i class="material-icons right">send</i>
        </button>
    </form:form>

</main>
<%@include file="/WEB-INF/view/include/footer.jsp" %>

</body>
</html>