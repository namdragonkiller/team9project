<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/view/include/page.jsp" %>
<html lang='ko'>
<head>
    <title>Title</title>
</head>
<body>
    <script>
        alert('<c:out value="${requestScope.message}"/>');
        location.href = '/';
    </script>

</body>
</html>
