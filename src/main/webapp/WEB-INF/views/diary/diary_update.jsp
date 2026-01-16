<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내면의 흔적 - 게시글 상세보기</title>
    <script src="https://unpkg.com/lucide@latest"></script>
    <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/diary_detail_board.css"/> --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css""/>
    	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/f_diary_write.css"/>
    <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
    <%-- <script src="${pageContext.request.contextPath}/resources/assets/js/diary_detail_board.js"></script> --%>

    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
</head>
<body>


<main class="container">
  <form id="diaryUpdateForm" method="post" action="${pageContext.request.contextPath}/diary/diaryUpdate.do">
    <input type="hidden" name="diarySid" value="${diaryVO.diarySid}" />
    <input type="hidden" name="diaryCategory" value="${diaryVO.diaryCategory}" />
    <div class="card diary-card" style="margin-top: 20px">
      <div class="diary-st">
        <span class="icon-circle">
          <i data-lucide="quote"></i>
        </span>
        <span class="diary-title-text">일기 수정</span>
      </div>
      <div class="diary-header flex-between">
        <input
          type="text"
          class="diary-title"
          name="diaryTitle"
          value="${diaryVO.diaryTitle}"
          placeholder="제목을 입력하세요"
          required
        />
      </div>
      <textarea
        class="diary-content"
        name="diaryContent"
        required
        placeholder="오늘의 일기를 작성해보세요"
        style="min-height: 30rem;"
      >${diaryVO.diaryContent}</textarea>
      <div class="diary-footer">
        <div class="radio-group">
          <label class="radio-label">
            <input type="radio" name="diaryStatus" value="Y" <c:if test='${diaryVO.diaryStatus eq "Y"}'>checked</c:if> /> 공개
          </label>
          <label class="radio-label">
            <input type="radio" name="diaryStatus" value="N" <c:if test='${diaryVO.diaryStatus eq "N"}'>checked</c:if> /> 비공개
          </label>
        </div>
        <button class="diary-btn" type="submit">저장</button>
        <a href="${pageContext.request.contextPath}/diary/diaryList.do" class="btn-cancel diary-btn" style="background:#94a3b8; margin-left:8px;">취소</a>
      </div>
    </div>
  </form>
</main>

   <footer>
      <div class="container">
        <p>© 2024 내면의 흔적. All rights reserved.</p>
      </div>
    </footer>


<script>
  // Lucide 아이콘 전체 렌더링 (body 끝에서 한 번만 실행)
  document.addEventListener('DOMContentLoaded', function() {
    if (typeof lucide !== 'undefined') {
      lucide.createIcons();
    }
  });
</script>


  </body>
</html>