<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<body class="container-fluid">
<div class="row justify-content-center m-4">
    <h1 class="text-center">Grids & Circle</h1>
</div>
<div class="card">
    <div class="row">
        <div class="col-md-8 mx-auto mt-4 d-flex flex-column align-items-start p-3 pt-0">
            <h5 class="flex-grow-0"><b>상품 목록</b></h5>
            <ul class="list-group products">
                <c:forEach items="${products}" var="product" varStatus="status">
                    <li class="list-group-item d-flex mt-3">
                        <div class="col-2"><img class="img-fluid" src="${product.image.url}" alt="">
                        </div>
                        <div class="col">
                            <div class="row text-muted">커피콩</div>
                            <div class="row">${product.name}</div>
                        </div>
                        <div class="col">${product.price}원</div>
                        <div class="col">${product.amount}개</div>
                        <div class="col action">
                            <button class="btn btn-small btn-outline-dark">수정</button>
                        </div>
                        <div class="col action">
                            <button class="btn btn-small btn-outline-dark"
                                    onclick="deleteProduct(${product.id})">제거
                            </button>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<c:if test="${not empty message}">
    <script>
      alert("${message}");
    </script>
</c:if>

<script>
  function deleteProduct(productId) {
    if (!confirm("정말 삭제하시겠습니까?")) return;

    fetch(`/admin/product/` + productId, {
      method: 'DELETE',
      redirect: 'follow'
    }).then(response => {
      if (response.ok) {
        window.location.href = '/admin/product/list';
      } else {
        alert('삭제 실패');
      }
    });
  }
</script>
</body>
</html>