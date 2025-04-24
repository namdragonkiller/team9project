<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/view/include/page.jsp" %>
<html>
<head>
    <title>Title</title>
    <%@include file="/WEB-INF/view/include/static.jsp" %>

</head>

<body>
<%@include file="/WEB-INF/view/include/header.jsp" %>
<%--<a href="#" data-target="slide-out" class="sidenav-trigger right">--%>
<%--    <i class="material-icons">menu</i>--%>
<%--</a>--%>
<a href="#" data-target="slide-out" class="sidenav-trigger btn brown waves-effect waves-light">
    <i class="material-icons left">menu</i> 메뉴
</a>
<%@include file="/WEB-INF/view/include/sidenav.jsp" %>

<h1>Hello This is index jsp</h1>
<%@include file="/WEB-INF/view/include/footer.jsp" %>


<script>
  document.addEventListener('DOMContentLoaded', function () {
    const elems = document.querySelectorAll('.sidenav');
    M.Sidenav.init(elems, { edge: 'right' });
  });
</script>
</body>

</html>
