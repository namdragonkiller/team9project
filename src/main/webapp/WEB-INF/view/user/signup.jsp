<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/include/page.jsp" %>
<html>
<head>
    <title>Grepp</title>
    <%@include file="/WEB-INF/view/include/static.jsp" %>
</head>

<body>
<%@include file="/WEB-INF/view/include/header.jsp" %>
<%@include file="/WEB-INF/view/include/sidenav.jsp" %>
    <main class="container">
        <form:form modelAttribute="signupForm" class="col s12" action="/user/signup" method="post" id="signupForm">
            <div class="row">

                <div class="input-field col s7">
                    <i class="material-icons prefix">account_circle</i>
                    <form:input path="id" id="id" class="validate"/>
                    <label for="id">아이디</label>
                    <form:errors path="id" cssClass="helper-text red-text"/>
                    <span class="helper-text" id="idCheckMsg" style="display: none"></span>
                </div>

                <div class="input-field col s7">
                    <i class="material-icons prefix">lock</i>
                    <form:input path="password" id="password" type="password" class="validate"/>
                    <label for="password">비밀번호</label>
                    <form:errors path="password" cssClass="helper-text red-text"/>
                </div>

                <div class="input-field col s7">
                    <i class="material-icons prefix">email</i>
                    <form:input path="email" id="email" type="email" class="validate"/>
                    <label for="email">이메일</label>
                    <form:errors path="email" cssClass="helper-text red-text"/>
                </div>

                <div class="input-field col s7">
                    <i class="material-icons prefix">phone</i>
                    <form:input path="tel" id="tel" type="tel" class="validate"/>
                    <label for="tel">전화번호</label>
                    <form:errors path="tel" cssClass="helper-text red-text"/>
                </div>

                <div class="input-field col s7">
                    <i class="material-icons prefix">home</i>
                    <form:input path="address" id="address" class="validate"/>
                    <label for="address">주소</label>
                    <form:errors path="address" cssClass="helper-text red-text"/>
                </div>

                <div class="input-field col s7">
                    <i class="material-icons prefix">location_on</i>
                    <form:input path="addressNumber" id="addressNumber" class="validate"/>
                    <label for="addressNumber">주소번호</label>
                    <form:errors path="addressNumber" cssClass="helper-text red-text"/>
                </div>

            </div>

            <button class="btn grey waves-effect waves-light offset-s1" type="submit" name="action">
                회원가입
                <i class="material-icons right">send</i>
            </button>
        </form:form>
    </main>

<%@include file="/WEB-INF/view/include/footer.jsp" %>


</body>
</html>