<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- <script src="../javascript/outline.js"></script> -->
    <script src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
    <!-- 외부 스타일시트 연결 (같은 폴더의 style.css 파일을 불러옵니다) -->
    <link rel="stylesheet" href=${pageContext.request.contextPath}/resources/assets/css/outline.css />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css"/>
    <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>

    <!-- 아이콘 라이브러리 (CDN) -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <title>개요 | 내면의 흔적</title>

  </head>
  <body>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
    <!-- Main Content -->
    <main class="container">


      <!-- 1. Information Cards -->
      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="activity"></i> 다양한 감정과 생각을 기록하는 일기
          </h3>
          <p>
            저희 내면의 흔적은 당신의
            <span class="p_font">"모든 감정을 존중하고 기록하는 곳"</span
            >입니다.
          </p>
          <hr />
          <div>
            <p>
              무거운 하루의 감정부터, 행복과 감사로 가득한 특별한 순간까지.
              <br />
            </p>
            <p style="color: #1837a0; line-height: 1.6" class="p_font">
              삶에서 마주하는 모든 감정을 솔직하게 기록하세요.
            </p>
            <br />
            <p class="p_font">
              "좋고 나쁨을 나누지 않아도, 판단하지 않아도 괜찮습니다."
            </p>
            <p>
              부담 없이 찾아와 일기를 작성하는 것만으로 마음의 안정을 얻고,
              스스로를 돌아볼 수 있습니다.
            </p>
            <p>
              ‘내면의 흔적’에서 당신의 감정을 조용히 마주하고, 마음의 평온을
              느껴보세요.
            </p>
            <p style="color: #1837a0; line-height: 1.6" class="p_font">
              당신의 기록은 언제나 당신의 편으로 남아 있을 것입니다.
            </p>
          </div>
        </div>
      </div>

      <!-- 1-1. Information Cards -->
      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="heart-handshake"></i> 다양한 감정 유형 일기
          </h3>
          <p style="color: #374151; line-height: 1.6">
            기쁨, 슬픔, 성취, 취운 등 <span class="p_font">다양한 감정</span>을
            기록할 수 있습니다.
          </p>

          <div class="info-grid">
            <div class="info-box blue">
              <h4>안전한 기록 공간</h4>
              <p class="p_font">
                모든 일기는 소중한 개인의 기록으로 안전하게 보호됩니다.
              </p>
              <p>
                편안한 환경에서 누구의 시선도 걱정하지 않고 감정을 솔직하게 남길
                수 있습니다.
              </p>
            </div>
            <div class="info-box indigo">
              <h4>다양한 감정 맞춤형 일기</h4>
              <p class="p_font">
                그날의 기분에 따라 일기를 선택하고 글을 써보세요.
              </p>
              <p>
                기쁨, 슬픔, 설렘, 스트레스 등 다양한 감정을 쉽게 기록하고,
                감정별로 일기를 분류할 수 있습니다.
              </p>
            </div>
            <div class="info-box blue">
              <h4>감정을 이해하는 기록</h4>
              <p class="p_font">
                단순한 글쓰기를 넘어, 나의 감정을 돌아보는 시간이 됩니다.
              </p>
              <p>
                하루하루 쌓인 기록을 통해 스스로의 마음을 더 깊이 이해할 수
                있습니다.
              </p>
            </div>
            <div class="info-box indigo">
              <h4>자유로운 공유</h4>
              <p class="p_font">
                기록을 혼자 간직하거나, 공감하고 싶은 사람들과 자유롭게 이야기를
                나누세요.
              </p>
              <p>
                커뮤니티와 감정을 공유하며 서로 위로와 격려를 주고받을 수
                있습니다.
              </p>
            </div>
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

      <script>
    if (typeof lucide !== 'undefined') lucide.createIcons();
  </script>

    <!-- 외부 스크립트 연결 (같은 폴더의 script.js 파일을 불러옵니다) -->
  </body>
</html>
