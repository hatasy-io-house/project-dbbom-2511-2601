<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>내면의 흔적 - 공지사항 상세보기</title>

<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/notice_detail_board.css" />

<style>
/* 1. 기본 배경 및 스크롤 허용 */
html, body {
    margin: 0;
    padding: 0;
    background-color: #f8fafc;
    overflow-y: auto !important;
    height: auto;
}

main.container {
    display: flex;
    justify-content: center;
    padding: 40px 20px 80px 20px !important;
    margin-top: 0 !important;
    min-height: 100vh;
}

.tab-content {
    width: 100%;
    max-width: 800px;
}

.detail-card {
    background: #ffffff;
    border-radius: 16px;
    padding: 30px 40px; /* 상하 패딩 약간 축소 */
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    border: 1px solid #eef2f6;
}

.detail-header {
    margin-bottom: 15px; /* 간격 축소 */
    padding-bottom: 15px; /* 간격 축소 */
    border-bottom: 1px solid #f1f5f9;
}

.detail-title {
    font-size: 1.5rem !important;
    font-weight: 700;
    color: #1e293b;
    margin: 5px 0 !important; /* 마진 축소 */
    line-height: 1.2; /* 줄간격 축소 */
}

.detail-meta-row {
    display: flex;
    gap: 15px;
    color: #94a3b8;
    font-size: 0.85rem;
}

/* 상세보기 전용 본문 */
.detail-body {
    white-space: pre-wrap;
    word-break: break-all;
    min-height: 100px; /* 너무 길었던 최소 높이 축소 */
    line-height: 1.6;
    color: #334155;
    font-size: 1rem;
}

/* ==========================================================
   [수정 모드 전용] 공백 최소화 스타일 
   ========================================================== */

/* 수정 모드일 때 detail-body 내부의 불필요한 공백 제거 */
.detail-body:has(form) {
    min-height: auto !important;
    padding: 0 !important;
}

.edit-group {
    margin-bottom: 10px !important; /* 제목칸과 '내용'라벨 사이 간격 대폭 축소 */
}

.edit-label {
    display: block;
    margin: 0 0 4px 0 !important; /* 라벨 아래쪽 마진 최소화 */
    padding: 0 !important;
    font-weight: 700;
    color: #475569;
    font-size: 0.85rem;
}

/* input과 textarea 자체의 줄간격과 패딩 조정 */
input[type="text"], textarea {
    line-height: 1.4 !important;
    padding: 10px 12px !important;
    margin: 0 !important;
}

/* ========================================================== */

.btn-list-container {
    margin-top: 25px; /* 위쪽 여백 축소 */
    padding-top: 15px;
    border-top: 1px solid #f1f5f9;
    display: flex;
    justify-content: space-between;
}

.btn-list-view {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px; /* 버튼 크기 살짝 축소 */
    background-color: #f8fafc;
    color: #64748b;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    text-decoration: none;
    font-size: 0.9rem;
    font-weight: 500;
    transition: 0.2s;
    cursor: pointer;
}

.btn-list-view:hover {
    background-color: #f1f5f9;
    color: #1e293b;
}

.admin-buttons {
    display: flex;
    gap: 8px;
}
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />

    <main class="container">
        <div class="tab-content">
            
            <c:choose>
                <c:when test="${param.mode == 'edit'}">
                    <article class="detail-card">
                        <form action="${pageContext.request.contextPath}/notice/doUpdate.do" method="post">
                            <input type="hidden" name="noticeSid" value="${vo.noticeSid}">
                            
                            <header class="detail-header">
                                <h2 class="detail-title"><i data-lucide="edit-3" size="20"></i> 공지사항 수정</h2>
                            </header>
                            
                            <div class="detail-body" style="padding: 0;"> <div class="edit-group">
                                    <label class="edit-label">제목</label>
                                    <input type="text" name="noticeTitle" value="${vo.noticeTitle}" 
                                           style="width:100%; padding:12px; border:1px solid #e2e8f0; border-radius:10px; outline:none;">
                                </div>
                                
                                <div class="edit-group">
                                    <label class="edit-label">내용</label>
                                    <textarea name="noticeContent" 
                                              style="width:100%; min-height:350px; padding:12px; border:1px solid #e2e8f0; border-radius:10px; line-height:1.6; outline:none; resize: vertical;">${vo.noticeContent}</textarea>
                                </div>
                            </div>
                            
                            <div class="btn-list-container">
                                <div class="admin-buttons">
                                    <button type="submit" class="btn-list-view" style="background:#3b82f6; color:white; border:none;">
                                        <i data-lucide="check"></i> <span>저장하기</span>
                                    </button>
                                    <a href="?noticeSid=${vo.noticeSid}" class="btn-list-view">
                                        <span>취소</span>
                                    </a>
                                </div>
                            </div>
                        </form>
                    </article>
                </c:when>

                <c:otherwise>
                    <article class="detail-card">
                        <header class="detail-header">
                            <span class="post-tag gratitude" style="color:#3b82f6; font-weight:bold; font-size:0.8rem;">공지사항</span>
                            <h2 class="detail-title">${vo.noticeTitle}</h2>
                            <div class="detail-meta-row">
                                <span class="meta-item"><i data-lucide="user" size="14"></i> ${vo.regId}</span> 
                                <span class="meta-item"><i data-lucide="calendar" size="14"></i> ${vo.noticeTime}</span>
                            </div>
                        </header>
                        
                        <div class="detail-body">${vo.noticeContent}</div>
                        
                        <div class="btn-list-container">
                            <a href="${pageContext.request.contextPath}/notice/noticeList.do" class="btn-list-view">
                                <i data-lucide="arrow-left" size="16"></i> <span>목록으로</span>
                            </a>
                            
                            <c:if test="${sessionScope.loginUser.adminChk == 'Y'}">
                                <div class="admin-buttons">
                                    <button type="button" onclick="moveToUpdate()" class="btn-list-view">
                                        <i data-lucide="edit-3" size="16"></i> <span>수정</span>
                                    </button>
                                    <button type="button" onclick="doDelete()" class="btn-list-view" style="color: #ef4444;">
                                        <i data-lucide="trash-2" size="16"></i> <span>삭제</span>
                                    </button>
                                </div>
                            </c:if>
                        </div>
                    </article>
                </c:otherwise>
            </c:choose>

        </div>
    </main>

   <script>
      // 아이콘 생성
      if (typeof lucide !== 'undefined')
         lucide.createIcons();

      // 삭제 함수
      function doDelete() {
         if (!confirm("정말 삭제하시겠습니까?"))
            return;

         $
               .ajax({
                  type : "POST",
                  url : "${pageContext.request.contextPath}/notice/doDelete.do",
                  data : {
                     "noticeSid" : "${vo.noticeSid}"
                  },
                  success : function(data) {
                     if (data.status === "success") {
                        alert(data.msg);
                        location.href = "${pageContext.request.contextPath}/notice/noticeList.do";
                     } else {
                        alert(data.msg);
                     }
                  }
               });
      }

      // 수정 페이지 이동
      function moveToUpdate() {
         location.href = "${pageContext.request.contextPath}/notice/doUpdate.do?noticeSid=${vo.noticeSid}";
      }
   </script>

</body>
</html>