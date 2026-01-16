<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>내면의 흔적 - 공지사항</title>

<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice.css" />

<style>
/* 검색 및 글쓰기 영역 */
.search-area { display: flex; justify-content: flex-end; gap: 8px; margin-bottom: 20px; align-items: center; }
.search-select, .search-input { padding: 8px 12px; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 0.9rem; }
.search-input:focus { border-color: #3b82f6; outline: none; } /* 포커스 효과 추가 */

.btn-search { background-color: #3b82f6; color: white; padding: 8px 16px; border: none; border-radius: 8px; cursor: pointer; font-weight: bold; display: flex; align-items: center; gap: 4px; }
.btn-write { background-color: #10b981; color: white; padding: 8px 16px; border: none; border-radius: 8px; cursor: pointer; font-weight: bold; display: flex; align-items: center; gap: 4px; text-decoration: none; font-size: 0.9rem; }

/* 페이징 스타일 */
.pagination { display: flex; justify-content: center; margin-top: 30px; gap: 5px; }
.page-item { padding: 6px 14px; border: 1px solid #e2e8f0; border-radius: 8px; color: #64748b; cursor: pointer; text-decoration: none; transition: all 0.2s; }
.page-item:hover { background-color: #f1f5f9; }
.page-item.active { background-color: #3b82f6; color: white; border-color: #3b82f6; font-weight: bold; }

/* 데이터 없음 스타일 */
.no-data-area { text-align: center; padding: 80px 0; color: #94a3b8; background: #f8fafc; border-radius: 16px; border: 1px dashed #e2e8f0; }
.search-keyword-highlight { color: #3b82f6; text-decoration: underline; font-weight: bold; }
</style>

<jsp:include page="/WEB-INF/views/main/menu.jsp" />
</head>
<body>
	<form action="${pageContext.request.contextPath}/notice/noticeList.do" method="get" name="noticeForm" id="noticeForm">
		<input type="hidden" name="pageNo" id="pageNo" value="${vo.pageNo}">

		<main class="container">
			<div class="tab-content">
				<div class="notice-container">
					<div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 10px;">
						<h3 class="section-title">
							<i data-lucide="megaphone"></i> 공지사항
						</h3>
					</div>

					<div class="search-area">
						<select name="searchDiv" id="searchDiv" class="search-select">
							<option value="">전체</option>
							<option value="10" ${vo.searchDiv == '10' ? 'selected' : ''}>제목</option>
							<option value="20" ${vo.searchDiv == '20' ? 'selected' : ''}>내용</option>
							<option value="30" ${vo.searchDiv == '30' ? 'selected' : ''}>제목+내용</option>
						</select> 
						
						<input type="text" name="searchWord" id="searchWord"
							class="search-input" value="${vo.searchWord}"
							placeholder="검색어를 입력하세요" autocomplete="off">

						<button type="button" class="btn-search" onclick="doRetrieve(1)">
							<i data-lucide="search" style="width: 14px;"></i> 검색
						</button>

						<c:if test="${sessionScope.loginUser.adminChk == 'Y'}">
							<a href="${pageContext.request.contextPath}/notice/moveToReg.do"
								class="btn-write"> <i data-lucide="pen-tool"></i> 글쓰기
							</a>
						</c:if>
					</div>

					<hr style="margin: 10px 0 20px 0; border-color: #f1f5f9;">

					<ul style="list-style: none; padding: 0;">
						<c:choose>
							<c:when test="${not empty list && list.size() > 0}">
								<c:forEach var="item" items="${list}">
									<li class="notice-item"
										onclick="location.href='${pageContext.request.contextPath}/notice/doSelectOne.do?noticeSid=${item.noticeSid}'">
										<div class="notice-info">
											<span style="font-weight: 600; font-size: 1.05rem;">${item.noticeTitle}</span>
										</div> <span class="notice-date">${item.noticeTime}</span>
									</li>
								</c:forEach>
							</c:when>

							<c:otherwise>
								<li class="no-data-area">
									<i data-lucide="search-x" style="width: 48px; height: 48px; margin-bottom: 15px; opacity: 0.5; color: #3b82f6;"></i>
									<p style="font-size: 1.1rem; font-weight: 600; color: #475569;">검색된 공지사항이 없습니다.</p> 
									<c:if test="${not empty vo.searchWord}">
										<p style="font-size: 0.9rem; margin-top: 8px;">
											입력하신 검색어 <span class="search-keyword-highlight">"${vo.searchWord}"</span>에 매칭되는 내용이 없습니다.
										</p>
									</c:if>
									<p style="font-size: 0.85rem; margin-top: 4px;">단어의 철자가 정확한지 확인하거나 다른 검색어를 시도해 보세요.</p>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>

					<div class="pagination">
						<c:if test="${totalCnt > 0}">
							<fmt:parseNumber var="totalPage" value="${Math.ceil(totalCnt / vo.pageSize)}" integerOnly="true" />
							<c:forEach var="i" begin="1" end="${totalPage}">
								<a href="javascript:doRetrieve(${i});"
									class="page-item ${vo.pageNo == i ? 'active' : ''}">${i}</a>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
		</main>

		<footer>
			<div class="container">
				<p>© 2024 내면의 흔적. All rights reserved.</p>
			</div>
		</footer>
	</form>

	<script>
		// Lucide 아이콘 초기화
		if (typeof lucide !== 'undefined') lucide.createIcons();

		$(document).ready(function() {
			// 페이지 로드 시 검색창에 커서 배치 (값이 있으면 끝으로)
			const $searchWord = $("#searchWord");
			if($searchWord.val()) {
				$searchWord.focus();
				const len = $searchWord.val().length;
				$searchWord[0].setSelectionRange(len, len);
			}
		});

		// 조회 함수
		function doRetrieve(pageNo) {
			console.log("조회 실행 - 페이지: " + pageNo);
			
			// 검색 버튼을 누를 때는 무조건 1페이지로 가야 함 (onclick="doRetrieve(1)")
			// 페이지 번호를 클릭할 때는 해당 번호가 인자로 들어옴
			const pageNoField = document.getElementById("pageNo");
			if (pageNoField) {
				pageNoField.value = pageNo;
			}
			const form = document.getElementById("noticeForm");
			if (form) {
				form.submit();
			}
		}

		// 엔터키 검색 지원 (중복 제출 방지 포함)
		document.getElementById("searchWord").addEventListener("keydown", function(e) {
			if (e.key === "Enter") {
				e.preventDefault(); // 기본 폼 제출 막기
				doRetrieve(1);      // 명시적으로 1페이지 조회 호출
			}
		});
	</script>
</body>
</html>