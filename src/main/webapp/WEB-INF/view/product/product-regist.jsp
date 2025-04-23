<%--
  Created by IntelliJ IDEA.
  User: jgarden
  Date: 2025. 4. 23.
  Time: 오전 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
          crossorigin="anonymous">
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
        color: rgb(65, 65, 65) @tringGe wv
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
    <title>Hello, world!</title>
</head>
<body><div class="container my-5">
    <div class="row justify-content-center m-4">
        <h1 class="text-center">Grids & Circle</h1>
    </div>

    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h5 class="mb-4"><b>상품 등록</b></h5>

                    <form:form action="${pageContext.request.contextPath}/admin/product/regist" method="post"
                               enctype="multipart/form-data" modelAttribute="productRegistRequest">

                        <!-- 사진 업로드 -->
                        <div class="mb-3">
                            <label for="thumbnail" class="form-label">사진 업로드</label>
                            <input type="file" class="form-control" id="thumbnail" name="thumbnail">
                        </div>

                        <!-- 이름 -->
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <form:input path="name" class="form-control" id="name"/>
                            <form:errors path="name" cssClass="text-danger"/>
                        </div>

                        <!-- 가격 -->
                        <div class="mb-3">
                            <label for="price" class="form-label">Price</label>
                            <form:input path="price" class="form-control" id="price"/>
                            <form:errors path="price" cssClass="text-danger"/>
                        </div>

                        <!-- 수량 -->
                        <div class="mb-3">
                            <label for="amount" class="form-label">Amount</label>
                            <form:input path="amount" class="form-control" id="amount"/>
                            <form:errors path="amount" cssClass="text-danger"/>
                        </div>

                        <!-- 정보 -->
                        <div class="mb-3">
                            <label for="info" class="form-label">Info</label>
                            <form:textarea path="info" class="form-control" id="info" rows="4"/>
                            <form:errors path="info" cssClass="text-danger"/>
                        </div>

                        <!-- 제출 버튼 -->
                        <div class="d-flex justify-content-end">
                            <button type="submit" class="btn btn-dark">
                                등록하기 <i class="bi bi-send ms-1"></i>
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
