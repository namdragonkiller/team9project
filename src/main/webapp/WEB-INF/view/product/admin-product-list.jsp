<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <sec:csrfMetaTags/>

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
        <div class="col-md-12 mx-auto mt-4 d-flex flex-column align-items-center p-3 pt-0">
            <h5 class="flex-grow-0"><b>상품 목록</b></h5>
            <ul class="list-group products">
                <li class="list-group-item d-flex mt-3" style="background-color: #ddd;">
                    <div class="col-2">사진</div>
                    <div class="col">이름</div>
                    <div class="col">가격</div>
                    <div class="col">수량</div>
                    <div class="col">수정</div>
                    <div class="col">삭제</div>
                </li>
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
                            <button class="btn btn-small btn-outline-dark"
                                    onclick="window.location.href = '/admin/product/${product.id}'">
                                수정
                            </button>
                        </div>
                        <div class="col action">
                            <button class="btn btn-small btn-outline-dark"
                                    onclick="deleteProduct(${product.id}, '${product.image.path}')">
                                삭제
                            </button>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            <ul class="pagination mt-3">
                <c:if test="${currentPage > 1}">
                    <li class="page-item"><a class="page-link" href="/admin/product/list?page=${currentPage - 1}">이전</a></li>
                </c:if>
                <c:if test="${currentPage == 1}">
                    <li class="page-item disabled">
                        <span class="page-link">이전</span>
                    </li>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <li class="page-item active" aria-current="page">
                                <a class="page-link" href="#">${i}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="/admin/product/list?page=${i}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <li class="page-item"><a class="page-link" href="/admin/product/list?page=${currentPage + 1}">다음</a></li>
                </c:if>
                <c:if test="${currentPage == totalPages}">
                    <li class="page-item disabled">
                        <span class="page-link">다음</span>
                    </li>
                </c:if>
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
  const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
  const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

  function deleteProduct(productId, imagePath) {
    if (!confirm("정말 삭제하시겠습니까?")) return;

    fetch(`/admin/product/` + productId, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'text/plain',
        [csrfHeader]: csrfToken
      },
      body: imagePath,
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