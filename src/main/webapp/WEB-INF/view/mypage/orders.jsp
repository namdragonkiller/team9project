
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>
    <!doctype html>
    <html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <style>
            body {
                background: #ddd;
            }

            .card {
                margin: auto;
                max-width: 950px;
                width: 90%;
                box-shadow: 0 6px 20px 0 rgba(0, 0, 0, 0.19);
                border-radius: 1rem;
                border: transparent
            }

            .summary {
                background-color: #ddd;
                border-top-right-radius: 1rem;
                border-bottom-right-radius: 1rem;
                padding: 4vh;
                color: rgb(65, 65, 65)
            }

            @media (max-width: 767px) {
                .summary {
                    border-top-right-radius: unset;
                    border-bottom-left-radius: 1rem
                }
            }

            .row {
                margin: 0
            }

            .title b {
                font-size: 1.5rem
            }

            .col-2,
            .col {
                padding: 0 1vh
            }

            img {
                width: 3.5rem
            }

            hr {
                margin-top: 1.25rem
            }
            .products {
                width: 100%;
            }
            .products .price, .products .action {
                line-height: 38px;
            }
            .products .action {
                line-height: 38px;
            }

        </style>
    <meta charset="UTF-8">
    <title>주문내역</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            rel="stylesheet">
</head>
<body class="container py-4">
<c:if test="${not empty message}">
    <div class="alert alert-success" role="alert">
            ${message}
    </div>
</c:if>
<h2 class="mb-4">주문내역</h2>
<table class="table table-striped">
    <thead>
    <tr>
        <th>상품명</th>
        <th>수량</th>
        <th>배송상태</th>
        <th>주문일시</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="order" items="${orderHistory}">
        <tr>
            <td>${order.productName}</td>
            <td>${order.quantity}</td>
            <td>${order.status}</td>
            <td>${order.createdAt}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div class="mt-4">
    <a href="<c:url value='/mypage/mypagemain' />" class="btn btn-secondary">마이페이지</a>
    <a href="<c:url value='/' />" class="btn btn-outline-primary">홈으로</a>
</div>
</body>
</html>
