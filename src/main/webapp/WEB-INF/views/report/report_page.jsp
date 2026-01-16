<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>신고하기</title>
    <script src="${pageContext.request.contextPath}/resources/assets/js/reportpage.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/reportpage.css" />
  </head>
  <body>
    <div class="header"><span class="header-icon">🚨</span> 신고하기</div>

    <form id="reportForm" action="${pageContext.request.contextPath}/report/doSave.do" method="post">
      <div class="container">
        <c:if test="${not empty errorMsg}">
          <script>alert('${errorMsg}'); window.close();</script>
        </c:if>
        <input type="hidden" name="diarySid" value="${diaryVO.diarySid}" />
        
        <div class="row">
          <div class="label">제 목</div>
          <div class="value">${diaryVO.diaryTitle}</div>
        </div>

        <div class="row">
          <div class="label">작성자 닉네임</div>
          <div class="value">${diaryVO.nickname}</div>
        </div>

        <div class="row">
          <div class="label">신고자 닉네임</div>  
          <div class="value">
            <c:choose>
              <c:when test="${not empty sessionScope.loginUser.nickname}">
                ${sessionScope.loginUser.nickname}
              </c:when>
              <c:otherwise>
                -
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <div class="row">
          <div class="label">신고사유</div>
          <div class="value radio-group">
            <label>
              <input type="radio" name="reportCategory" value="10" checked required />
              욕설/비방
            </label>
            <label><input type="radio" name="reportCategory" value="20" /> 음란성</label>
            <label>
              <input type="radio" name="reportCategory" value="30" /> 홍보/상업성
            </label>
            <label><input type="radio" name="reportCategory" value="40" /> 개인정보유출</label>
            <label><input type="radio" name="reportCategory" value="50" /> 도배</label>
            <label><input type="radio" name="reportCategory" value="60" /> 기타</label>
          </div>
        </div>
        <div class="row">
          <textarea
            class="textarea-box"
            name="reportContent"
            placeholder="신고 사유를 상세히 입력해주세요."
            required
          ></textarea>
        </div>
        <div class="info-box">
          신고 게시물은 삭제되며, 해당 게시물을 올린 유저는 덧글쓰기 및 글쓰기 제한을 받을 수 있습니다.<br />
          단, 허위신고일 경우, 신고자의 활동에 제한을 받게 되오니, 그 점 유의해 주시기 바랍니다.
        </div>
      </div>
      <div class="footer-buttons">
        <button type="submit" class="btn btn-submit">🚨 신고하기</button>
        <button type="button" class="btn btn-close" onclick="window.close();">닫 기</button>
      </div>
    </form>
  </body>
</html>
