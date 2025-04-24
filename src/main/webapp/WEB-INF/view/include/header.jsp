<%@ page language="java" %>
<header class="header">
    <nav class="navbar brown">
        <div class="nav-wrapper ">
            <a href="/" class="brand-logo center grey-text">Grids & Circles</a>
            <ul id="nav-mobile" class="right hide-on-med-and-down grey-text">
                <sec:authorize access="isAnonymous()">

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