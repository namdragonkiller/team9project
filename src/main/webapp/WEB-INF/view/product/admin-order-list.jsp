<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/view/include/page.jsp"%>
<html>
<head>
    <title>Grepp</title>
    <%@ include file="/WEB-INF/view/include/static.jsp"%>
    <style>
      .card {
        margin: auto;
        max-width: 950px;
        width: 90%;
        box-shadow: 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        border-radius: 1rem;
        border: transparent;
      }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/view/include/header.jsp"%>
<%@ include file="/WEB-INF/view/include/sidenav.jsp"%>

<main class="container">
    <div class="card">
        <div class="row">
            <div class="col s12 mt-4 p-3 pt-0 center-align">
                <h5><b>주문 현황</b></h5>
                <ul class="collection with-header">
                    <li class="collection-header grey lighten-2" >
                        <div class="row">
                            <div class="col s1">번호</div>
                            <div class="col s2">아이디/이메일</div>
                            <div class="col s2">주소</div>
                            <div class="col s1">가격</div>
                            <div class="col s3">주문시간</div>
                            <div class="col s2">구매내역</div>
                            <div class="col s1">취소</div>
                        </div>
                    </li>
                    <c:forEach items="${orders}" var="order" varStatus="status">
                        <li class="collection-item" style="padding: 10px 20px">
                            <div class="row" style="margin-bottom: 0;">
                                <div class="col s1">${order.id}</div>

                                <c:if test="${order.isMember}">
                                    <div class="col s2">${order.userId}</div>
                                </c:if>

                                <c:if test="${not order.isMember}">
                                    <div class="col s2">${order.email}</div>
                                </c:if>

                                <div class="col s2">
                                    <div class="row">${order.address}</div>
                                    <div class="row">${order.addressNumber}</div>
                                </div>

                                <div class="col s1">${order.totalPrice}원</div>
                                <div class="col s3">${order.date}</div>

                                <div class="col s2">
                                    <c:forEach items="${order.orderProducts}" var="orderProduct" varStatus="status">
                                        ${orderProduct.name} (${orderProduct.amount}개)
                                        <c:if test="${!status.last}">, </c:if>
                                    </c:forEach>
                                </div>

                                <div class="col s1">
                                    <button class="btn-small waves-effect waves-light btn-outline-dark black"
                                            style="padding: 0 5px;"
                                            onclick="deleteOrder(${order.id})">취소</button>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>

    </div>
</main>
<script>
  const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');
  const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');

  function deleteOrder(orderId) {
    if (!confirm("정말 주문 취소하시겠습니까?")) return;

    fetch(`/admin/order/` + orderId, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'text/plain',
        [csrfHeader]: csrfToken
      },
      redirect: 'follow'
    }).then(response => {
      if (response.ok) {
        window.location.href = '/admin/order';
      } else {
        alert('취소 실패');
      }
    });
  }
</script>
<%@ include file="/WEB-INF/view/include/footer.jsp"%>
<script src="${context}/assets/js/sidebar.js" defer></script>
</body>
</html>