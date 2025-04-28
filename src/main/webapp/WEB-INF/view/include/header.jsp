<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header class="header">
    <nav class="navbar"  style="background-color: darkgray">
        <div class="nav-wrapper ">
            <a href="/" class="brand-logo  center black-text">Grids & Circles</a>
            <ul id="nav-mobile" class="right hide-on-med-and-down black-text">
                <sec:authorize access="isAuthenticated()">
                    <li style="margin-right: 10px;">
                        <span class="black-text" style="font-weight:bold;">
                            <sec:authentication property="principal.username"/>님
                        </span>
                    </li>
                </sec:authorize>
                <li>
                    <a href="mobile.html">
                        <i class="material-icons black-text sidenav-trigger"
                           data-target="slide-out">more_vert</i>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>
