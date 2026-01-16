<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>명언 모음집 | 수정하기</title>
    
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/f_diary_write.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />

    <style>
        .emotion-select {
            border: none;
            border-bottom: 1px solid #eee;
            padding: 10px;
            font-size: 1rem;
            color: #64748b;
            outline: none;
            width: 200px;
            margin-left: 10px;
        }
        .diary-card { max-width: 800px; margin: 40px auto; }
        .back-link { 
            display: inline-flex; 
            align-items: center; 
            gap: 5px; 
            text-decoration: none; 
            color: #64748b; 
            margin-bottom: 20px;
            font-size: 0.9rem;
        }
    </style>

    <jsp:include page="/WEB-INF/views/main/menu.jsp" />
</head>
<body>
    <main class="container">
        <a href="javascript:history.back();" class="back-link">
            <i data-lucide="arrow-left" size="18"></i> 취소하고 돌아가기
        </a>

        <div class="card diary-card">
            <input type="hidden" id="famousSid" name="famousSid" value="${vo.famousSid}">
            
            <div class="diary-st">
                <span class="icon-circle">
                    <i data-lucide="edit-3"></i>
                </span>
                <span class="diary-title-text">명언 수정하기</span>
            </div>

            <div class="diary-header flex-between">
                <input
                    type="text"
                    class="diary-title"
                    id="famousAuthor" 
                    name="famousAuthor"
                    value="${vo.famousAuthor}" 
                    placeholder="작가의 이름을 입력하세요"
                />
            </div>

            <div style="padding: 10px 0; border-bottom: 1px solid #f1f5f9; display: flex; align-items: center;">
                <span style="color: #64748b; font-size: 0.9rem; margin-left: 5px;">감정 테마 :</span>
                <select id="famousEmotion" name="famousEmotion" class="emotion-select">
                    <option value="P" ${vo.famousEmotion eq 'P' ? 'selected' : ''}>☀️ 긍정적이고 따뜻한</option>
                    <option value="N" ${vo.famousEmotion eq 'N' ? 'selected' : ''}>🌙 사색적이고 차분한</option>
                </select>
            </div>

            <textarea
                class="diary-content"
                id="famousContent" 
                name="famousContent"
                placeholder="마음을 울리는 명언 한 줄을 작성해보세요"
                style="min-height: 300px;"
            >${vo.famousContent}</textarea>

            <div class="diary-footer">
                <div class="radio-group">
                    <span style="color: #94a3b8; font-size: 0.85rem;">수정 후에도 전체 공개로 유지됩니다.</span>
                </div>
                <button class="diary-btn" id="updateFamous" type="button">수정완료</button>
            </div>
        </div>
    </main>

<script>
$(document).ready(function() {
    const loginUserId = "${sessionScope.loginUser.userId}";

    if (typeof lucide !== "undefined") {
        lucide.createIcons();
    }

    // 수정 완료 버튼 이벤트
    $("#updateFamous").on("click", function() {
        const sid = $("#famousSid").val();
        const author = $("#famousAuthor").val().trim();
        const content = $("#famousContent").val().trim();
        const emotion = $("#famousEmotion").val();

        if (author === "" || content === "") {
            alert("작가와 내용을 모두 입력해주세요.");
            return;
        }

        const param = {
            famousSid: sid, // 필수!
            famousAuthor: author,
            famousContent: content,
            famousEmotion: emotion
        };

        if(confirm("수정한 내용을 저장하시겠습니까?")) {
            $.ajax({
                url: "${pageContext.request.contextPath}/famous/doUpdate.do", // 수정 경로
                type: "POST",
                data: param,
                success: function(res) {
                    // 서버 응답이 "1"이거나 flag가 1인 경우 성공
                    if(res == "1" || res.flag == "1") {
                        alert("성공적으로 수정되었습니다.");
                        location.href = "${pageContext.request.contextPath}/famous/getFamousDetail.do?famousSid=" + sid;
                    } else {
                        alert("수정 실패: " + (res.message || "권한이 없거나 오류가 발생했습니다."));
                    }
                },
                error: function() {
                    alert("서버 통신 오류가 발생했습니다.");
                }
            });
        }
    });
});
</script>
</body>
</html>