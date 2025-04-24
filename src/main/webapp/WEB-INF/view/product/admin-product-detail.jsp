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

      .product-image {
        width: 100%;
        height: auto;
        object-fit: contain;
        max-height: 400px; /* 필요한 경우 이미지 최대 높이 지정 */
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
        <div class="col-md-8 mt-4 d-flex flex-column p-3 pt-0 justify-content-center">
            <img class="img-fluid rounded mb-3 product-image" id="productImage"
                 src="${product.image.url}"
                 alt="${product.image.originFileName}">
            <div class="d-flex justify-content-center gap-2 my-2">
                <input type="file" id="newImage" name="newImage" accept="image/*"
                       style="display: none;" onchange="previewImage(event)">
                <button class="btn btn-outline-dark"
                        onclick="document.getElementById('newImage').click()">사진 변경
                </button>
                <button class="btn btn-outline-dark"
                        onclick="rollback('${product.image.url}', '${product.image.originFileName}')">
                    되돌리기
                </button>
            </div>
        </div>

        <div class="col-md-4 summary p-4">
            <div>
                <h5 class="m-0 p-0"><b>상품 상세</b></h5>
            </div>
            <hr>
            <div class="mb-3">
                <label for="name" class="form-label">이름</label>
                <input value="${product.name}" type="text" class="form-control mb-1" id="name"/>
                <span id="error-name" class="text-danger"></span>
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">가격</label>
                <input value="${product.price}" type="text" class="form-control mb-1" id="price"/>
                <span id="error-price" class="text-danger"></span>
            </div>
            <div class="mb-3">
                <label for="amount" class="form-label">수량</label>
                <input value="${product.amount}" type="text" class="form-control" id="amount"/>
                <span id="error-amount" class="text-danger"></span>
            </div>
            <div class="mb-3">
                <label for="info" class="form-label">Info</label>
                <textarea path="info" class="form-control" id="info"
                          rows="4">${product.info}</textarea>
                <span id="error-info" class="text-danger"></span>
            </div>
            <div class="d-flex justify-content-between">
                <button class="btn btn-dark w-100 me-2"
                        onclick="updateProduct(${product.id}, '${product.image.path}')">
                    수정
                </button>
                <button class="btn btn-dark w-100"
                        onclick="window.location.href = '/admin/product/list'">취소
                </button>
            </div>
        </div>
    </div>
</div>
<c:if test="${not empty message}">
    <script>
      alert("${message}");
    </script>
</c:if>

<script>
  const productImage = document.getElementById("productImage");
  let currentImage;

  function updateProduct(productId, oldPath) {
    const formData = new FormData();

    // 일반 텍스트 필드 추가
    formData.append("name", document.getElementById("name").value);
    formData.append("price", document.getElementById("price").value);
    formData.append("amount", document.getElementById("amount").value);
    formData.append("info", document.getElementById("info").value);
    formData.append("oldPath", "");

    // 이미지 파일 추가 (있을 경우만)
    const fileInput = document.getElementById("newImage");
    if (fileInput.files.length > 0) {
      formData.append("newImage", fileInput.files[0]);
      formData.append("oldPath", oldPath);
    }

    // files 가 비어있는데, 프리뷰 이미지가 원본과 다를 경우
    // currentImage 전달
    if (fileInput.files.length === 0 && !productImage.src.endsWith(oldPath)) {
      formData.append("newImage", currentImage);
      formData.append("oldPath", oldPath);
    }

    fetch('/admin/product/' + productId, {
      method: 'PUT',
      body: formData
    }).then(async (response) => {
      if (response.ok) {
        alert("수정 성공");
        window.location.href = "/admin/product/list";
      } else {
        const errorMessages = await response.json();
        document.querySelector('#error-name').textContent = errorMessages.name;
        document.querySelector('#error-price').textContent = errorMessages.price;
        document.querySelector('#error-amount').textContent = errorMessages.amount;
        document.querySelector('#error-info').textContent = errorMessages.info;
      }
    })
  }

  function previewImage(event) {
    if (event.target.files.length === 0) {
      return;
    }
    const reader = new FileReader();
    reader.onload = function (e) {
      productImage.src = e.target.result;
      productImage.alt = event.target.files[0].name;
      currentImage = event.target.files[0];
    };

    reader.readAsDataURL(event.target.files[0]);
  }

  function rollback(url, name) {
    const newImage = document.getElementById('newImage');

    // 파일 input 초기화
    newImage.value = "";

    // 이미지 src 및 alt 되돌리기
    productImage.src = url;
    productImage.alt = name;
  }
</script>
</body>
</html>