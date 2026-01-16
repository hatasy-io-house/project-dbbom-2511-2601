<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- 외부 스타일시트 연결 (같은 폴더의 style.css 파일을 불러옵니다) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/f_diary_end.css"/>
    	<script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/f_diary_end.js"></script>

    <!-- 아이콘 라이브러리 (CDN) -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>명언일기 | 작성완료</title>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
  </head>
  <body>

    <!-- Main Content -->
    <main class="container">

      <!-- 1. Information Cards -->
      <%-- <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="hand-heart"></i> 흔적 한 줄
          </h3>
          <p>
            <span class="p_font"
              >흔적 속 이야기를 더 선명하게 정리해봤어요 :)</span
            >
          </p>
          <hr />
          <div class="info-box blue"></div>

          <!-- 요약 영역 -->
          <div id="summaryArea">
            <!-- API 요약 결과가 여기에 들어옴 -->
          </div>
        </div>
      </div> --%>

      <!-- 1-1. Information Cards -->
      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="heart-handshake"></i> 당신에게 건네는 명언
          </h3>
          <p style="color: #374151; line-height: 1.6">
            <span class="p_font"
              >기록된 일기에 어울리는 명언을 골라 전해요 ;)</span
            >
          </p>
          <hr />

          <!-- 명언 영역 -->


          <div class="post-tag gratitude" id="famousQuoteArea">
            ${famous.famousContent}
            <div style="text-align:right; color:#555; margin-top:0.5em;">- ${famous.famousAuthor} -</div>
          </div>

          <script>
          <!-- JS 명언 출력 코드 제거 -->
          </script>

          

          <div class="info-grid">
            <div class="info-box indigo"></div>
          </div>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <footer>
      <div class="container">
        <p style="margin-bottom: 0.5rem">
          © 2024 내면의 흔적. All rights reserved.
        </p>
        <p style="font-size: 0.875rem">당신의 감정을 소중히 여기는 공간</p>
      </div>
    </footer>

    <!-- 외부 스크립트 연결 (같은 폴더의 script.js 파일을 불러옵니다) -->
  </body>
</html>
