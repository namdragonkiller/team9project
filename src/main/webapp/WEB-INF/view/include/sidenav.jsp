<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<ul id="slide-out" class="sidenav">
    <li><a class="waves-effect" href="/user/signin"><i class="material-icons">login</i>로그인</a></li>
    <li><a class="waves-effect" href="/user/signup"><i class="material-icons">person_add</i>회원가입</a></li>
</ul>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    const elems = document.querySelectorAll('.sidenav');
    M.Sidenav.init(elems, { edge: 'right' });
  });
</script>