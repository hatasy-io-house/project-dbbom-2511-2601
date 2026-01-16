<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>성찰일기 | 오늘의 흔적</title>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/common.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/diary/r_diary_start.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/r_diary_start.css"/>

    <script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
  </head>
  <body>

    <main class="container">
      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="heart-pulse"></i> 생각의 흔적
          </h3>
          <p>나의 실수를 천천히 돌아보는 시간을 가져보세요.</p>
          <p style="color: #1837a0; line-height: 1.6" class="p_font">
            성찰을 두려워하지 마세요:) 잘한 점, 아쉬웠던 점, 마음에 남은
            순간들을 있는 그대로 적어도 괜찮습니다.
          </p>

          <div class="info-grid">
            <div style="grid-column: span 2">
              <p>
                성찰은 반성이 아니라 이해에 가깝습니다.<br />
                <span class="p_font"
                  >스스로를 다그치지 않고, 알아차리는 과정이에요.</span
                >
              </p>
              <br />
              <p>
                오늘의 나를 이해하고, 왜 그런 감정이 들었는지,<br />
                다음에는 어떻게 해보고 싶은지 정답 없이 적어도 충분합니다.<br />
                <span class="p_font"
                  >하루를 정리하며 조금 더 나은 내일을 준비할 수 있습니다.</span
                >
              </p>
            </div>
          </div>
        </div>
      </div>

      <div class="card">
        <div class="card-body">
          <h3 class="section-title">
            <i data-lucide="edit"></i> 생각의 흔적 작성요령
          </h3>
          <p style="color: #374151; line-height: 1.6">
            부담 없이 기록하기 위해 아래의 요령을 참고해 주세요.
          </p>

          <div class="info-grid">
            <div class="info-box blue">
              <h4>잘한 점도 함께 적어주세요</h4>
              <p class="p_font">아쉬움뿐 아니라 노력했던 부분도 중요해요.</p>
              <p>
                질문하는 문장도 좋아요 “왜 그때 그런 기분이었을까?” 같은 문장도
                좋아요.
              </p>
            </div>
            <div class="info-box indigo">
              <h4>질문하는 문장도 좋아요</h4>
              <p class="p_font">
                “왜 그때 그런 기분이었을까?” 같은 문장도 좋아요.
              </p>
            </div>
            <div class="info-box blue">
              <h4>해결하지 않아도 괜찮아요</h4>
              <p class="p_font">각을 적는 것만으로도 이미 충분한 성찰입니다.</p>
              <p>한두 문장만 적어도 충분해요.</p>
            </div>
            <div class="info-box indigo">
              <h4>비난 대신 관찰을 선택하세요</h4>
              <p class="p_font">
                오늘의 나는 그 순간 나름의 이유가 있었을 수도 있고,
              </p>
              <p>최선을 다했을지도 몰라요.</p>
            </div>
          </div>

          <div style="text-align: center; margin-top: 20px">
            <c:choose>
                <c:when test="${not empty sessionScope.loginUser}">
                    <a
                        href="${pageContext.request.contextPath}/diary/rDiaryWrite.do"
                        class="diary-btn"
                        style="
                            text-decoration: none;
                            display: inline-block;
                            padding: 10px 20px;
                            background-color: #3563fc;
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
