<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>신고하기</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/reportpage.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/reportpage.css" />
</head>
<body>
	<div class="header">
		<span class="header-icon">🚨</span> 신고하기
	</div>

	<form id="reportForm"
		action="${pageContext.request.contextPath}/report/doSave.do"
		method="post">
		<div class="container">
			<c:if test="${not empty errorMsg}">
				<script>
					alert('${errorMsg}');
					window.close();
				</script>
			</c:if>

			<input type="hidden" name="famousSid" value="${famousVO.famousSid}" />
			<input type="hidden" name="commentSid"
				value="${not empty commentVO.commentSid ? commentVO.commentSid : 0}" />

			<div class="row">
				<div class="label">신고 대상 내용</div>
				<div class="value">
					<c:choose>
						<%-- 1. 댓글 신고인 경우: 댓글 내용 표시 --%>
						<c:when test="${not empty commentVO.commentContent}">
							<span style="color: #3b82f6; font-weight: bold;">[댓글 신고]</span>
							<br />
							<div style="margin-top: 5px; color: #475569;">${commentVO.commentContent}</div>
						</c:when>
						<%-- 2. 명언 원문 신고인 경우: 명언 내용 표시 --%>
						<c:otherwise>
							<span style="color: #ef4444; font-weight: bold;">[명언 원문
								신고]</span>
							<br />
							<div style="margin-top: 5px; color: #475569;">${famousVO.famousContent}</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="row">
				<div class="label">대상 작성자</div>
				<div class="value">
					<strong>${not empty commentVO.nickname ? commentVO.nickname : famousVO.nickname}</strong>
				</div>
			</div>

			<div class="row">
				<div class="label">신고자 닉네임</div>
				<div class="value">
					<c:choose>
						<c:when test="${not empty sessionScope.loginUser.nickname}">
                ${sessionScope.loginUser.nickname}
              </c:when>
						<c:otherwise>
							<span style="color: #94a3b8;">(알 수 없음)</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="row">
				<div class="label">신고사유</div>
				<div class="value radio-group">
					<label><input type="radio" name="reportCategory" value="10"
						checked required /> 욕설/비방</label> <label><input type="radio"
						name="reportCategory" value="20" /> 음란성</label> <label><input
						type="radio" name="reportCategory" value="30" /> 홍보/상업성</label> <label><input
						type="radio" name="reportCategory" value="40" /> 개인정보유출</label> <label><input
						type="radio" name="reportCategory" value="50" /> 도배</label> <label><input
						type="radio" name="reportCategory" value="60" /> 기타</label>
				</div>
			</div>

			<div class="row">
				<textarea class="textarea-box" name="reportContent"
					placeholder="신고 사유를 상세히 입력해주세요." required></textarea>
			</div>

			<div class="info-box">신고 게시물은 관리자 확인 후 삭제될 수 있으며, 허위 신고 시 이용에
				제한을 받을 수 있으니 주의해 주세요.</div>
		</div>

		<div class="footer-buttons">
			<button type="submit" class="btn btn-submit">🚨 신고하기</button>
			<button type="button" class="btn btn-close" onclick="window.close();">닫
				기</button>
		</div>
	</form>
</body>
</html>