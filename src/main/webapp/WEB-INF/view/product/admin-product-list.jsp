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
        border: transparent
      }

      img {
        width: 3.5rem
      }

      .flex {
        display: flex;
        align-items: center;
      }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/view/include/header.jsp" %>
<%@ include file="/WEB-INF/view/include/sidenav.jsp" %>

<main class="container">
    <div class="card">
        <div class="row">
            <div class="col s12 mt-4 p-3 pt-0">
                <!-- 상품 목록 제목 가운데 정렬 -->
                <h5 class="center-align"><b>상품 목록</b></h5>

                <ul class="collection with-header">
                    <!-- 컬럼 헤더 -->
                    <li class="collection-header grey lighten-2">
                        <div class="row" style="margin-bottom: 0">
                            <div class="col s2 center-align">사진</div>
                            <div class="col s2 center-align">이름</div>
                            <div class="col s2 center-align">가격</div>
                            <div class="col s2 center-align">수량</div>
                            <div class="col s2 center-align">수정</div>
                            <div class="col s2 center-align">삭제</div>
                        </div>
                    </li>

                    <!-- 상품 목록 반복 -->
                    <c:forEach items="${products}" var="product" varStatus="status">
                        <li class="collection-item">
                            <div class="row flex">
                                <div class="col s2 center-align">
                                    <img class="responsive-img" src="${product.image.url}" alt="">
                                </div>
                                <div class="col s2 center-align">
                                        ${product.name}
                                </div>
                                <div class="col s2 center-align">${product.price}원</div>
                                <div class="col s2 center-align">${product.amount}개</div>
                                <div class="col s2 center-align">
                                    <a class="waves-effect waves-light btn-small"
                                       href="/admin/product/${product.id}">
                                        수정
                                    </a>
                                </div>
                                <div class="col s2 center-align">
                                    <button class="waves-effect waves-light btn-small red lighten-1"
                                            onclick="deleteProduct(${product.id}, '${product.image.path}')">
                                        삭제
                                    </button>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>

                <!-- 페이지네이션 -->
                <ul class="pagination center">
                    <c:if test="${currentPage > 1}">
                        <li class="waves-effect">
                            <a href="/admin/product/list?page=${currentPage - 1}"><i
                                    class="material-icons">chevron_left</i></a>
                        </li>
                    </c:if>
                    <c:if test="${currentPage == 1}">
                        <li class="disabled"><a href="#!"><i class="material-icons">chevron_left</i></a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <li class="active"><a href="#!">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="waves-effect">
                                    <a href="/admin/product/list?page=${i}">${i}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="waves-effect"><a href="/admin/product/list?page=${currentPage + 1}"><i class="material-icons">chevron_right</i></a></li>
                    </c:if>
                    <c:if test="${currentPage == totalPages}">
                        <li class="disabled"><a href="#!"><i class="material-icons">chevron_right</i></a>
                        </li>
                    </c:if>
                </ul>
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
<%@ include file="/WEB-INF/view/include/footer.jsp" %>
<script src="${context}/assets/js/sidebar.js" defer></script>
</body>
</html>