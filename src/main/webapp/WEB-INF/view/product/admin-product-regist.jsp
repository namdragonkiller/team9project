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
    </style>
</head>
<body>
<%@ include file="/WEB-INF/view/include/header.jsp" %>
<%@ include file="/WEB-INF/view/include/sidenav.jsp" %>

<main class="container">
    <div class="row">
        <div class="col s12 m8 l6 offset-m2 offset-l3">
            <div class="card">
                <div class="card-content" >
                    <h5 class="mb-4"><b>상품 등록</b></h5>

                    <form:form action="${pageContext.request.contextPath}/admin/product/regist" method="post"
                               enctype="multipart/form-data" modelAttribute="productRegistRequest">

                        <!-- 사진 업로드 -->
                        <div class="file-field input-field">
                            <div class="btn black">
                                <span>사진 업로드</span>
                                <input type="file" name="thumbnail" id="thumbnail" accept="image/*">
                            </div>
                            <div class="file-path-wrapper">
                                <input class="file-path validate" type="text" placeholder="파일을 선택하세요.">
                            </div>
                        </div>

                        <!-- 이름 -->
                        <div class="input-field">
                            <input type="text" id="name" class="validate" name="name">
                            <label for="name" class="active">이름</label>
                            <form:errors path="name" cssClass="text-danger"/>
                        </div>

                        <!-- 가격 -->
                        <div class="input-field">
                            <input type="number" id="price" class="validate" name="price">
                            <label for="price" class="active">가격</label>
                            <form:errors path="price" cssClass="text-danger"/>
                        </div>

                        <!-- 수량 -->
                        <div class="input-field">
                            <input type="number" id="amount" class="validate" name="amount">
                            <label for="amount" class="active">수량</label>
                            <form:errors path="amount" cssClass="text-danger"/>
                        </div>

                        <!-- 정보 -->
                        <div class="input-field">
                            <textarea id="info" class="materialize-textarea" name="info"></textarea>
                            <label for="info" class="active">상세 정보</label>
                            <form:errors path="info" cssClass="text-danger"/>
                        </div>

                        <!-- 제출 버튼 -->
                        <div class="right-align">
                            <button type="submit" class="btn black waves-effect waves-light">
                                등록하기 <i class="bi bi-send ms-1"></i>
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

</main>

<%@ include file="/WEB-INF/view/include/footer.jsp" %>
<script src="${context}/assets/js/sidebar.js" defer></script>
</body>
</html>