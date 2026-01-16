<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>행운일기 | 오늘의 흔적</title>

    <script src="https://unpkg.com/lucide@latest"></script>
 <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/common.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/diary/l_diary_start.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/l_diary_start.css"/>
    <script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
  </head>
  <body>

    <main class="container">

      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="heart-pulse"></i> 우연의 흔적
          </h3>
          <p>하루 속 작은 행운을 기록해 보세요.</p>
          <p style="color: #18a067; line-height: 1.6" class="p_font">
            우리는 종종 특별한 일이 있어야 행운이라고 생각하지만, 사실 대부분의
            행운은 아주 조용하게 찾아옵니다.
          </p>

          <div class="info-grid">
            <div style="grid-column: span 2">
              <p>
                우연히 맞춰진 타이밍, 생각보다 순조로웠던 하루,<br />
                <span class="p_font"
                  >별일 없어서 오히려 마음이 편했던 순간도 모두 당신의 하루를
                  지켜준 행운일 수 있어요.</span
                >
              </p>
              <br />
              <p>
                남겨진 흔적은 “아무 일도 없던 하루”가 아니라<br />
                “잘 흘러간 하루”였다는 사실을 알려줍니다.<br />
                <span class="p_font"
                  >이 기록이 쌓일수록 당신은 점점 더 많은 행운을 알아보게
                  됩니다.</span
                >
              </p>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="edit"></i> 우연의 흔적 작성 요령
          </h3>
          <p style="color: #374151; line-height: 1.6">
            더 많은 행운을 발견하기 위해 아래의 요령을 참고해 주세요.
          </p>

          <div class="info-grid">
            <div class="info-box blue">
              <h4>작은 행운도 괜찮아요</h4>
              <p class="p_font">크지 않아도 좋아요 :)</p>
              <p>
                버스를 놓치지 않은 일, 커피가 유난히 맛있었던 순간도 행운이에요.
              </p>
            </div>
            <div class="info-box indigo">
              <h4>느낌을 함께 적어보세요</h4>
              <p class="p_font">
                무슨 일이 있었는지 그리고 “기분이 좋아졌다”, “괜히 웃음이 났다”
              </p>
              <p>같은 감정이 중요해요.</p>
            </div>
            <div class="info-box blue">
              <h4>짧아도 충분해요</h4>
              <p class="p_font">한 문장만 적어도</p>
              <p>오늘의 행운은 충분히 기록됩니다.</p>
            </div>
            <div class="info-box indigo">
              <h4>행운의 크기를 비교하지 마세요</h4>
              <p class="p_font">남들과 비교할 필요 없이</p>
              <p>당신에게 의미 있었다면 그걸로 충분해요.</p>
            </div>
          </div>

          <div style="text-align: center; margin-top: 20px">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <a
                        href="${pageContext.request.contextPath}/diary/lDiaryWrite.do"
                        class="diary-btn"
                        style="
                            text-decoration: none;
                            display: inline-block;
                            padding: 10px 20px;
                            background-color: #18a067;
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
