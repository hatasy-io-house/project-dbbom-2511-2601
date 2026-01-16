<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>내면의 흔적 - 공지사항 <c:choose>
      <c:when test="${not empty vo.noticeSid}">수정</c:when>
      <c:otherwise>작성</c:otherwise>
   </c:choose></title>

<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/assets/css/notice.css" />

<style>
/* 1. 전체 레이아웃 */
html, body {
margin: 0 !important;
    padding: 0 !important;
    background-color: #f8fafc;
    height: auto !important;
    overflow-y: auto !important;
}

/* 2. 메뉴바 영역: menu.jsp가 스스로의 디자인을 갖도록 최소한의 설정만 남깁니다. */
#header-wrapper {
/* 고정(fixed)만 해제하여 스크롤 시 위로 올라가게 합니다. */
    position: relative !important; 
    width: 100% !important;
    z-index: 1000 !important;
    
    /* 디자인 간섭 제거: 아래 속성들이 menu.jsp의 디자인을 방해하지 않게 합니다. */
    display: block !important;
    background: none !important; /* 배경색 중첩 방지 */
    border: none !important;     /* 테두리 중첩 방지 */
    box-shadow: none !important; /* 그림자 중첩 방지 */
    padding: 0 !important;
    margin: 0 !important;
}

/* 3. 본문 컨테이너 */
main.container {
display: flex !important;
    justify-content: center !important;
    padding-top: 20px !important; /* 메뉴바 바로 아래 적절한 여백 */
    padding-bottom: 80px !important;
    margin: 0 auto !important;
}

/* 4. 공지사항 폼 박스 디자인 */
.tab-content {
    width: 100%;
    max-width: 1000px;
    padding: 0 20px;
}

.reg-container {
background: #ffffff;
    padding: 40px;
    border-radius: 16px;
    border: 1px solid #e2e8f0;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

/* 입력 필드 및 버튼 스타일 (기존 유지) */
.section-title { display: flex; align-items: center; gap: 12px; font-size: 1.4rem; margin-bottom: 5px; color: #1e293b; }
.form-control { width: 100%; padding: 14px; border: 1px solid #e2e8f0; border-radius: 10px; font-size: 1rem; box-sizing: border-box; }
.btn-save { background-color: #3b82f6; color: white; padding: 12px 28px; border: none; border-radius: 10px; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 8px; }
.btn-cancel { background-color: #f1f5f9; color: #64748b; padding: 12px 24px; border: none; border-radius: 10px; cursor: pointer; font-weight: 600; text-decoration: none; font-size: 0.95rem; }
</style>


</head>
<body>
<div id="header-wrapper">
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
</div>

   <main class="container">
      <div class="tab-content">
         <div class="reg-container">
            <h3 class="section-title">
               <i data-lucide="megaphone"></i>
               <c:choose>
                  <c:when test="${not empty vo.noticeSid}">공지사항 수정</c:when>
                  <c:otherwise>공지사항 작성</c:otherwise>
               </c:choose>
            </h3>
            <hr
               style="margin: 20px 0 30px 0; border: 0; border-top: 1px solid #f1f5f9;">

            <form id="saveForm">
               <input type="hidden" id="noticeSid" name="noticeSid"
                  value="${vo.noticeSid}">

               <div class="form-group">
                  <label class="form-label">제목</label> <input type="text"
                     id="noticeTitle" name="noticeTitle" class="form-control"
                     placeholder="공지사항 제목을 입력하세요" value="${vo.noticeTitle}"
                     maxlength="30">
               </div>
               <div class="form-group">
                  <label class="form-label">내용</label>
                  <textarea id="noticeContent" name="noticeContent"
                     class="form-control" rows="15" placeholder="공지사항 상세 내용을 입력하세요">${vo.noticeContent}</textarea>
               </div>

               <div
                  style="display: flex; justify-content: flex-end; gap: 12px; margin-top: 30px;">
                  <a href="${pageContext.request.contextPath}/notice/noticeList.do"
                     class="btn-cancel">취소</a>
                  <button type="button" id="doSaveBtn" class="btn-save">
                     <i data-lucide="check" style="width: 18px;"></i>
                     <c:choose>
                        <c:when test="${not empty vo.noticeSid}">수정완료</c:when>
                        <c:otherwise>등록하기</c:otherwise>
                     </c:choose>
                  </button>
               </div>
            </form>
         </div>
      </div>
   </main>

     <script>
    // 아이콘 생성
    lucide.createIcons();

    $(document).ready(function() {
        console.log("JSP 로드 완료 - 버튼 이벤트 대기 중");

        $("#doSaveBtn").on("click", function() {
            console.log("버튼 클릭됨");

            // 1. 데이터 가져오기
            const sid = $("#noticeSid").val();
            const title = $("#noticeTitle").val();
            const content = $("#noticeContent").val();
            
            console.log("데이터 확인:", { sid, title, content });

            // 2. 유효성 검사
            if(!title || title.trim() === "") { 
                alert("제목을 입력하세요."); 
                $("#noticeTitle").focus();
                return; 
            }
            if(!content || content.trim() === "") { 
                alert("내용을 입력하세요."); 
                $("#noticeContent").focus();
                return; 
            }

            // 3. 등록/수정 구분
            const isUpdate = (sid !== null && sid !== "" && sid !== "0");
            const url = isUpdate ? "${pageContext.request.contextPath}/notice/doUpdate.do" 
                                 : "${pageContext.request.contextPath}/notice/doSave.do";
            const confirmMsg = isUpdate ? "공지사항을 수정하시겠습니까?" : "공지사항을 등록하시겠습니까?";

            if(!confirm(confirmMsg)) return;

            // 4. Ajax 전송
            $.ajax({
                type: "POST",
                url: url,
                dataType: "json", // 응답 형식을 JSON으로 강제
                data: {
                    "noticeSid": isUpdate ? parseInt(sid) : 0,
                    "noticeTitle": title,
                    "noticeContent": content
                },
                success: function(data) {
                    console.log("서버 응답:", data);
                    // 컨트롤러 리턴 타입에 맞춰 분기 (status 또는 flag)
                    if(data.status === "success" || data.flag == 1) {
                        alert(isUpdate ? "수정되었습니다." : "등록되었습니다.");
                        location.href = "${pageContext.request.contextPath}/notice/noticeList.do";
                    } else {
                        alert(data.msg || "처리에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("에러 발생:", error);
                    alert("서버와 통신 중 오류가 발생했습니다. 이클립스 콘솔을 확인하세요.");
                }
            });
        });
    });
</script>


</body>
</html>