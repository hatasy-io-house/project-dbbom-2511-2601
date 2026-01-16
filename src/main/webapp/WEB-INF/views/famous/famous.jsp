<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.famous.domain.FamousVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>내면의 흔적 - 명언 모음집</title>

<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets/css/famous_diary_board.css" />

<script
	src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<jsp:include page="/WEB-INF/views/main/menu.jsp" />

<style>
    /* 명언 모음집 전체 섹션의 중앙 정렬 해제 */
   .board-latest-section { text-align: left !important; }

    /* 타이틀과 버튼을 가로로 배치하는 컨테이너 */
   .custom-header-flex {
        display: flex !important;
        align-items: center !important;
        gap: 15px !important;
        margin-bottom: 25px !important;
        margin-left: 10px !important;
    }

    /* 타이틀 텍스트 스타일 */
    .custom-header-flex .title-group {
        text-align: left !important;
    }

    .custom-header-flex h3 {
        margin: 0 !important;
        font-size: 1.5rem !important;
        color: #1e293b !important;
    }

    /* 버튼 스타일 (기존 디자인 유지하며 정렬만 수정) */
    .btn-custom-famous {
        all: unset !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 8px !important;
        background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%) !important;
        color: white !important;
        padding: 10px 20px !important;
        border-radius: 50px !important;
        font-weight: 600 !important;
        cursor: pointer !important;
        box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3) !important;
        transition: 0.3s !important;
    }
    /* 좋아요 버튼의 기본 상태를 빨간색으로 설정 */
/* 좋아요 버튼/아이콘 기본 빨간색 설정 (목록의 하트와 상세페이지 버튼 모두 대응) */
    .btn-like, .likes-trigger {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: #ff4d4d !important; /* 숫자 색상 */
        cursor: pointer;
    }

/* 목록과 상세페이지의 모든 하트 아이콘을 빨간색으로 */
    .heart-icon, #heartIcon {
        color: #ff4d4d !important; /* 테두리 */
        fill: #ff4d4d !important;  /* 내부 채우기 */
        width: 18px;
        height: 18px;
        transition: transform 0.2s ease;
    }
    
    .likes-trigger:hover .heart-icon {
        transform: scale(1.2);
    }

    /* 버튼에 마우스를 올렸을 때 효과 (선택 사항) */
    .btn-like:hover {
        background-color: #fff5f5;
        transform: scale(1.05);
    }
</style>


</head>
<body>

	<main class="container">
		<div class="tab-content">
			<section class="board-best-section">
				<div class="section-title">
					<h3>🏆 명예의 명언 (Best 3)</h3>
					<span style="font-size: 0.9rem; color: #64748b; margin-left: 10px">실시간
						추천 순위 반영</span>
				</div>
				<div id="best-posts-container" class="posts-grid">
					<c:forEach var="best" items="${bestList}" varStatus="status">
						<article class="post-card best-card" data-sid="${best.famousSid}">
							<div
								style="position: absolute; top: 15px; right: 15px; display: flex; align-items: center; gap: 4px; z-index: 10;">
								<span class="rank-badge">${status.count}위</span> <i
									data-lucide="crown"
									style="width: 18px; height: 18px; color: ${status.index == 0 ? '#fbbf24' : (status.index == 1 ? '#94a3b8' : '#b45309')}; fill: currentColor;"></i>
							</div>

							<c:set var="bestEmotion" value="${fn:trim(best.famousEmotion)}" />
							<div
								class="sentiment-tag ${fn:trim(best.famousEmotion) eq 'P' ? 'tag-positive' : 'tag-negative'}"
								style="position: absolute; top: 15px; left: 15px; z-index: 10;">
								<i
									data-lucide="${fn:trim(best.famousEmotion) eq 'P' ? 'sun' : 'moon'}"></i>

							</div>

							<div class="post-content-main">
								<h3 class="display-author">${best.famousAuthor}</h3>
								<p class="display-content">"${best.famousContent}"</p>
							</div>

							<div class="post-meta">
    <span class="reg-id">
        <c:choose>
            <c:when test="${not empty best.userVO.nickname}">
                ${best.userVO.nickname}
            </c:when>
            <c:otherwise>
                ${best.regId}
            </c:otherwise>
        </c:choose>
    </span>
    
   <div class="meta-icons">
        <div class="views-info">
            <i data-lucide="eye"></i>
            <span>${best.famousViewcount}</span>
        </div>
        
        <div class="likes-trigger">
            <i data-lucide="heart" class="heart-icon"></i> 
            <span class="like-count count-${best.famousSid}">${best.famousReccount}</span>
        </div>
        
        <i data-lucide="chevron-right" class="arrow-icon"></i>
    </div>
</div>
						</article>
					</c:forEach>
				</div>
			</section>

			<hr class="section-divider">

			<section class="board-latest-section">
    <div class="custom-header-flex" style="justify-content: space-between; align-items: center;">
        <div class="title-group">
            <h3>💬 명언 모음집</h3>
            <p style="margin: 4px 0 0 0; font-size: 0.9rem; color: #64748b;">마음을 울리는 한 줄의 힘</p>
        </div>

        <button id="btnMoveToReg" class="btn-custom-famous" type="button">
            <i data-lucide="plus-circle" style="width: 18px; height: 18px;"></i>
            <span>명언 등록하기</span>
        </button>
    </div>
    
    <div class="search-container" style="margin: 10px 0 25px 10px; display: flex; justify-content: flex-start;">
        <form name="famousSearchFrm" id="famousSearchFrm" method="get" action="${pageContext.request.contextPath}/famous/famous.do" style="display: flex; gap: 8px; align-items: center;">
            <input type="hidden" name="pageNo" id="pageNo" value="${vo.pageNo}">
            
            <select name="searchDiv" id="searchDiv" style="padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; background-color: white; color: #475569; font-size: 0.9rem;">
                <option value="">전체</option>
                <option value="10" ${vo.searchDiv == '10' ? 'selected' : ''}>내용</option>
                <option value="20" ${vo.searchDiv == '20' ? 'selected' : ''}>저자</option>
            </select>
            
            <div style="position: relative; display: flex; align-items: center;">
                <input type="text" name="searchWord" id="searchWord" value="${vo.searchWord}" 
                       placeholder="검색어를 입력하세요" 
                       style="padding: 10px 15px; border-radius: 8px; border: 1px solid #e2e8f0; width: 280px; font-size: 0.9rem; outline: none;">
            </div>
            
            <button type="button" id="doRetrieve" class="btn-custom-famous" style="padding: 10px 20px !important; box-shadow: none !important;">
                <i data-lucide="search" style="width: 16px; height: 16px;"></i>
                <span>검색</span>
            </button>
        </form>
    </div>
</section>
				<div id="paged-list-container" class="posts-grid">
					<c:choose>
						<c:when test="${empty list}">
							<p
								style="text-align: center; grid-column: 1/-1; padding: 50px; color: #64748b;">
								현재 등록된 명언이 없습니다. 첫 명언을 등록해보세요!</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="vo" items="${list}">
								<article class="post-card" data-sid="${vo.famousSid}">
									<div
										class="sentiment-tag ${fn:trim(vo.famousEmotion) eq 'P' ? 'tag-positive' : 'tag-negative'}"
										style="position: absolute; top: 15px; left: 15px; z-index: 10;">
										<i
											data-lucide="${fn:trim(vo.famousEmotion) eq 'P' ? 'sun' : 'moon'}"></i>

									</div>

									<div class="post-content-main">
										<h3 class="display-author">${vo.famousAuthor}</h3>
										<p class="display-content">"${vo.famousContent}"</p>
									</div>

									<div class="post-meta">
										<span class="reg-id">
    <c:choose>
        <c:when test="${not empty vo.userVO.nickname}">${vo.userVO.nickname}</c:when>
        <c:otherwise>${vo.regId}</c:otherwise>
    </c:choose>
</span>
										<div class="meta-icons">
											<div class="views-info">
    <i data-lucide="eye"></i> 
    <span>${not empty vo.famousViewcount ? vo.famousViewcount : 0}</span>
</div>
											<div class="likes-trigger">
												<i data-lucide="heart" class="heart-icon"></i> <span
													class="like-count count-${vo.famousSid}">${vo.famousReccount}</span>
											</div>
											<i data-lucide="chevron-right" class="arrow-icon"></i>
										</div>
									</div>
								</article>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>

<div class="pagination-container">
    <ul class="pagination-list">
        <c:if test="${totalCnt > 0}">
            <%-- 전체 페이지 수 계산: (전체건수 + 페이지사이즈 - 1) / 페이지사이즈 --%>
            <c:set var="totalPageNum" value="${((totalCnt + vo.pageSize - 1) / vo.pageSize).intValue()}" />

            <%-- '이전' 버튼 --%>
            <c:if test="${vo.pageNo > 1}">
                <li>
                    <a href="?pageNo=${vo.pageNo - 1}&pageSize=${vo.pageSize}&searchDiv=${vo.searchDiv}&searchWord=${vo.searchWord}" 
                       class="page-link prev-next">이전</a>
                </li>
            </c:if>

            <%-- 페이지 번호 --%>
            <c:forEach begin="1" end="${totalPageNum}" var="i">
                <li>
                    <a href="?pageNo=${i}&pageSize=${vo.pageSize}&searchDiv=${vo.searchDiv}&searchWord=${vo.searchWord}"
                       class="page-link ${vo.pageNo == i ? 'active' : ''}">${i}</a>
                </li>
            </c:forEach>

            <%-- '다음' 버튼 --%>
            <c:if test="${vo.pageNo < totalPageNum}">
                <li>
                    <a href="?pageNo=${vo.pageNo + 1}&pageSize=${vo.pageSize}&searchDiv=${vo.searchDiv}&searchWord=${vo.searchWord}" 
                       class="page-link prev-next">다음</a>
                </li>
            </c:if>
        </c:if>
    </ul>
</div>
			</section>
		</div>
		
	</main>

	<footer>
		<div class="container">
			<p>© 2026 내면의 흔적. All rights reserved.</p>
		</div>
	</footer>


<script>
    $(document).ready(function() {
        // --- 1. 검색 및 페이징 관련 이벤트 ---
        
        // 검색 버튼 클릭
        $("#doRetrieve").on("click", function() {
            const searchWord = $("#searchWord").val();
            if(searchWord && !$("#searchDiv").val()) {
                alert("검색 조건을 선택해주세요.");
                return;
            }
            $("#pageNo").val(1); // 검색 시 1페이지로 리셋
            $("#famousSearchFrm").submit();
        });

        // 엔터키 검색 허용
        $("#searchWord").on("keypress", function(e) {
            if(e.keyCode === 13) {
                e.preventDefault();
                $("#doRetrieve").click();
            }
        });

        // 페이징 번호 클릭 (검색어 유지하며 페이지 이동)
        $(".page-link").on("click", function(e) {
            e.preventDefault();
            // href 속성에서 pageNo 추출
            const href = $(this).attr("href");
            if(href && href.indexOf("pageNo=") !== -1) {
                const pageNo = href.split("pageNo=")[1].split("&")[0];
                $("#pageNo").val(pageNo);
                $("#famousSearchFrm").submit();
            }
        });


        // --- 2. 페이지 이동 및 UI 초기화 ---

        // 등록 페이지로 이동
        $("#btnMoveToReg").on("click", function() {
            location.href = "${pageContext.request.contextPath}/famous/famousRegView.do";
        });

        // 베스트 및 일반 카드 UI (왕관, 하트 등) 초기 설정 함수
        function refreshRankUI() {
            // Best 3 왕관 아이콘 및 순위 설정
            $("#best-posts-container .post-card").each(function(index) {
                const $card = $(this);
                const rank = index + 1;
                const $tag = $card.find(".sentiment-tag");
                
                $tag.find(".rank-badge").text(rank + "위");
                const $crown = $tag.find("[data-lucide='crown']");
                
                if (rank === 1) $crown.css({"color": "#fbbf24", "fill": "#fbbf24"});
                else if (rank === 2) $crown.css({"color": "#94a3b8", "fill": "#94a3b8"});
                else if (rank === 3) $crown.css({"color": "#b45309", "fill": "#b45309"});
            });

            // 좋아요 상태 복구 (localStorage)
            $(".post-card").each(function() {
                const sid = $(this).data("sid");
                if (localStorage.getItem("famous_liked_" + sid) === "true") {
                    const $trigger = $(this).find(".likes-trigger");
                    $trigger.data("is-liked", true);
                    $trigger.find(".heart-icon").attr({"fill": "#ef4444", "stroke": "#ef4444"});
                    $trigger.css("color", "#ef4444");
                }
            });
            lucide.createIcons(); // 루시드 아이콘 렌더링
        }

        refreshRankUI();


        // --- 3. 카드 클릭 및 좋아요 AJAX ---

        // 상세페이지 이동
        $(document).on("click", ".post-card", function(e) {
            if ($(e.target).closest('.likes-trigger').length) return;

            const famousSid = $(this).data("sid");
            const pNo = "${vo.pageNo}";
            const pSize = "${vo.pageSize}";

            let url = "${pageContext.request.contextPath}/famous/getFamousDetail.do";
            url += "?famousSid=" + famousSid;
            url += "&pageNo=" + (pNo ? pNo : 1);
            url += "&pageSize=" + (pSize ? pSize : 12);
            // 검색어 유지 이동을 위해 추가 (선택사항)
            url += "&searchDiv=${vo.searchDiv}&searchWord=${vo.searchWord}";
            
            location.href = url;
        });

        // 좋아요 클릭 (AJAX)
        $(document).off("click", ".likes-trigger").on("click", ".likes-trigger", function(e) {
            e.stopPropagation();
            const loginUser = "${sessionScope.loginUser}";
            if (!loginUser) {
                if (confirm("좋아요는 로그인 후에 가능합니다.\n로그인 페이지로 이동하시겠습니까?")) {
                    location.href = "${pageContext.request.contextPath}/user/signIn.do";
                }
                return;
            }

            const famousSid = $(this).closest(".post-card").data("sid");

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/famous/doUpdateLike.do",
                data: { "famousSid": famousSid },
                dataType: "text",
                success: function(res) {
                    if (res === "LOGIN_REQUIRED") alert("로그인이 필요합니다.");
                    else if (res.includes("TIME_LIMIT")) {
                        alert("이미 추천하셨습니다. " + res.split(":")[1] + "분 후에 다시 가능합니다.");
                    } else if (res === "ERROR") alert("처리 중 오류가 발생했습니다.");
                    else {
                        $(".count-" + famousSid).text(res);
                        alert("추천되었습니다!");
                    }
                },
                error: function() { alert("통신 오류가 발생했습니다."); }
            });
        });
    });
</script>
</body>
</html>