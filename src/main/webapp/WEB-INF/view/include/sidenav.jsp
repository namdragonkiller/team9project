<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<ul id="slide-out" class="sidenav" style="color: antiquewhite">
<sec:authorize access="isAnonymous()">
  <li><a class="waves-effect" href="/user/signin"><i class="material-icons">login</i>로그인</a></li>
  <li><a class="waves-effect" href="/user/signup"><i class="material-icons">person_add</i>회원가입</a></li>
</sec:authorize>
  <sec:authorize access="isAuthenticated()">
      <li><a class="waves-effect" href="/mypage/mypagemain"><i class="material-icons">home</i>myPage</a></li>
      <li><a class="waves-effect" href="/user/promote"><i class="material-icons">admin_panel_settings</i>Grant Admin</a></li>
      <li><a href="#" id="logout" class="grey-text">LogOut</a></li>
  </sec:authorize>
    <sec:authorize access="hasRole('ADMIN')">
        <hr>
        <li><h5 style="margin-left: 10px; color: black">관리자</h5></li>
        <li><a class="waves-effect" href="/admin/product/list">상품 목록</a></li>
        <li><a class="waves-effect" href="/admin/product/regist">상품 등록</a></li>
        <li><a class="waves-effect" href="/admin/order">주문 현황</a></li>
    </sec:authorize>
</ul>
<form:form action="/logout" method="post" id="logoutForm">
</form:form>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    const elems = document.querySelectorAll('.sidenav');
    M.Sidenav.init(elems, { edge: 'right' });
  });

  (() => {

    const logout = document.querySelector('#logout');
    if(!logout) return;

    logout.addEventListener('click', ev => {
      ev.preventDefault();
      logoutForm.submit();
    });

  })();
</script>