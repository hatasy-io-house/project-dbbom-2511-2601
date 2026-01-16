<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>감사일기 | 오늘의 흔적</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/t_diary_start.css"/>
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/common.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/diary/t_diary_start.js"></script>
    <script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
  </head>
  <body>
    <main class="container">
      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="heart-pulse"></i> 마음의 흔적
          </h3>
          <p>오늘 하루, 고마웠던 마음을 남겨 보세요.</p>
          <p style="color: #ddb100; line-height: 1.6" class="p_font">
            누군가의 말 한마디, 당연하게 여겼던 환경, 혹은 무사히 지나간 하루 그
            자체일 수도 있어요.
          </p>

          <div class="info-grid">
            <div style="grid-column: span 2">
              <p>
                기쁨, 슬픔, 설렘부터 고민스러운 마음까지 당신이 느낀 감정을
                그대로 이해하고,<br />
                <span class="p_font"
                  >감사는 잃어버린 것을 채우는 마음이 아니라, 이미 가진 것을
                  다시 바라보는 시선입니다.</span
                >
              </p>
              <br />
              <p>
                하루를 마무리하며 감사를 적다 보면 마음이 조금 느려지고,<br />
                지나온 순간들이 더 따뜻하게 남게 됩니다.<br />
                <span class="p_font"
                  >감사의 흔적은 당신의 하루를 부드럽게 감싸주는
                  기록입니다.</span
                >
              </p>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="edit"></i> 마음의 흔적 작성 요령
          </h3>
          <p style="color: #374151; line-height: 1.6">
            감사의 마음을 더 잘 느끼기 위해 아래의 요령을 참고해 주세요.
          </p>

          <div class="info-grid">
            <div class="info-box blue">
              <h4>사소한 감사도 괜찮아요</h4>
              <p class="p_font">큰 사건이 아니어도 괜찮아요 :)</p>
              <p>작은 배려, 평범한 일상도 감사의 이유가 됩니다.</p>
            </div>
            <div class="info-box indigo">
              <h4>누구에게 감사한지 적어보세요</h4>
              <p class="p_font">
                타인에게, 상황에게, 그리고 오늘을 버틴 나 자신에게도 괜찮아요.
              </p>
            </div>
            <div class="info-box blue">
              <h4>길게 쓰지 않아도 돼요</h4>
              <p class="p_font">“오늘도 무사해서 고맙다” 한 줄이면 충분해요.</p>
              <p>길게 쓰지 않아도 진심이 담기면 충분합니다.</p>
            </div>
            <div class="info-box indigo">
              <h4>억지로 찾지 않아도 돼요</h4>
              <p class="p_font">떠오르는 만큼만 기록해도 충분합니다.</p>
              <p>우리 모두 다 할 수 있어요.</p>
            </div>
          </div>

          <div style="text-align: center; margin-top: 20px">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <a
                        href="${pageContext.request.contextPath}/diary/tDiaryWrite.do"
                        class="diary-btn"
                        style="
                            text-decoration: none;
                            display: inline-block;
                            padding: 10px 20px;
                            background-color: #ddb100;
                            color: #fff;
                            border-radius: 5px;
                        "
                    >일기 작성하기</a>
                </c:when>
                <c:otherwise>
                    <a
                        href="${pageContext.request.contextPath}/login_page.html"
                        class="diary-btn"
                        style="
                            text-decoration: none;
                            display: inline-block;
                            padding: 10px 20px;
                            background-color: #bdbdbd;
                            color: #fff;
                            border-radius: 5px;
                            cursor: not-allowed;
                        "
                        onclick="alert('로그인 후 이용 가능합니다.'); return false;"
                    >일기 작성하기</a>
                </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </main>

    <footer>
      <div class="container">
        <p style="margin-bottom: 0.5rem">
          © 2024 내면의 흔적. All rights reserved.
        </p>
        <p style="font-size: 0.875rem">당신의 감정을 소중히 여기는 공간</p>
      </div>
    </footer>

    <script>
      lucide.createIcons();
    </script>
  </body>
</html>
