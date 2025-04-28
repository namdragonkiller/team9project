<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/include/page.jsp" %>
<html>
<head>
    <title>Grepp</title>
    <%@ include file="/WEB-INF/view/include/static.jsp" %>
    <style>
      .card {
        margin: auto;
        max-width: 950px;
        width: 90%;
        box-shadow: 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        border-radius: 1rem;
        border: transparent;
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
      .product-image {
        width: 100%;
        height: auto;
        object-fit: contain;
        max-height: 400px; /* 필요한 경우 이미지 최대 높이 지정 */
      }
      .button-group {
        display: flex;
        justify-content: center;
        margin-top: 20px;
      }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/view/include/header.jsp" %>
<%@ include file="/WEB-INF/view/include/sidenav.jsp" %>

<main class="container">
    <div class="card">
        <div class="row">
            <!-- 상품 이미지 부분 -->
            <div class="col s12 m8 mt-4 d-flex flex-column p-3 pt-0 justify-center" style="margin-top: 4vh">
                <img class="rounded mb-3 product-image" id="productImage"
                     src="${product.image.url}"
                     alt="${product.image.originFileName}">
                <div class="center-align gap-2 my-2" style="margin-top: 10px">
                    <input type="file" id="newImage" name="newImage" accept="image/*"
                           style="display: none;" onchange="previewImage(event)">
                    <button class="waves-effect waves-light btn btn-outline-dark black"
                            onclick="document.getElementById('newImage').click()">사진 변경
                    </button>
                    <button class="waves-effect waves-light btn btn-outline-dark black"
                            onclick="rollback('${product.image.url}', '${product.image.originFileName}')">
                        되돌리기
                    </button>
                </div>
            </div>

            <!-- 상품 상세 부분 -->
            <div class="col s12 m4 summary p-4" style="padding: 4vh;">
                <div>
                    <h5 class="m-0 p-0"><b>상품 상세</b></h5>
                </div>
                <hr>
                <div class="input-field mb-3">
                    <label for="name">이름</label>
                    <input value="${product.name}" type="text" class="validate" id="name"/>
                    <span id="error-name" class="helper-text red-text"></span>
                </div>
                <div class="input-field mb-3">
                    <label for="price">가격</label>
                    <input value="${product.price}" type="text" class="validate" id="price"/>
                    <span id="error-price" class="helper-text red-text"></span>
                </div>
                <div class="input-field mb-3">
                    <label for="amount">수량</label>
                    <input value="${product.amount}" type="text" class="validate" id="amount"/>
                    <span id="error-amount" class="helper-text red-text"></span>
                </div>
                <div class="input-field mb-3">
                    <label for="info">상세 정보</label>
                    <textarea path="info" class="materialize-textarea" id="info"
                              rows="4">${product.info}</textarea>
                    <span id="error-info" class="helper-text red-text"></span>
                </div>
                <div class="button-group">
                    <button class="waves-effect waves-light btn col s5 black"
                            onclick="updateProduct(${product.id}, '${product.image.path}')">
                        수정
                    </button>
                    <button class="waves-effect waves-light btn col s5 black"
                            onclick="window.location.href = '/admin/product/list'">취소
                    </button>
                </div>
            </div>
        </div>

    </div>
</main>
<c:if test="${not empty message}">
    <script>
      alert("${message}");
    </script>
</c:if>

<script>
  const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
  const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

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
      headers: {
        [csrfHeader]: csrfToken
      },
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
<%@ include file="/WEB-INF/view/include/footer.jsp" %>
<script src="${context}/assets/js/sidebar.js" defer></script>
</body>
</html>