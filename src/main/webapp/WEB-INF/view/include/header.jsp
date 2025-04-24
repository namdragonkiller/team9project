<%@ page language="java" %>
<header class="header">
    <nav class="navbar brown">
        <div class="nav-wrapper ">
            <a href="/" class="brand-logo white-text" style="position: absolute; left: 50%; transform: translateX(-50%);"
            >Grids & Circles</a>
            <ul id="nav-mobile" class="hide-on-med-and-down" style="display: flex; justify-content: center;">
                <sec:authorize access="isAnonymous()">
                    <li><a href="/member/signin" class="grey-text">sign in</a></li>
                    <li><a href="/member/signup" class="grey-text">sign up</a></li>
                    <li>
                        <a href="mobile.html">
                            <i class="material-icons grey-text sidenav-trigger"
                               data-target="slide-out">more_vert</i>
                        </a>
                    </li>
                </sec:authorize>
            </ul>
        </div>
    </nav>
</header>
<form:form action="/logout" method="post" id="logoutForm">
</form:form>
<script>

  (() => {

    const logout = document.querySelector('#logout');
    if(!logout) return;

    logout.addEventListener('click', ev => {
      ev.preventDefault();
      logoutForm.submit();
    });

  })();
</script>