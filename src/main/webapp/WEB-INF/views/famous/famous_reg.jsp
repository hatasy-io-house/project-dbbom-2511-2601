<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>명언 모음집 | 등록하기</title>
    
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/f_diary_write.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />

    <style>
    
        /* 명언 등록을 위한 소량의 보정 스타일 */
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
            <i data-lucide="arrow-left" size="18"></i> 목록으로 돌아가기
        </a>

        <div class="card diary-card">
            <div class="diary-st">
                <span class="icon-circle">
                    <i data-lucide="quote"></i>
                </span>
                <span class="diary-title-text">새로운 명언 남기기</span>
            </div>

            <div class="diary-header flex-between">
                <input
                    type="text"
                    class="diary-title"
                    id="famousAuthor" 
                    name="famousAuthor"
                    placeholder="작가의 이름을 입력하세요 (예: 알베르 카뮈)"
                />
            </div>

            <div style="padding: 10px 0; border-bottom: 1px solid #f1f5f9; display: flex; align-items: center;">
                <span style="color: #64748b; font-size: 0.9rem; margin-left: 5px;">감정 테마 :</span>
                <select id="famousEmotion" name="famousEmotion" class="emotion-select">
                    <option value="P">☀️ 긍정적이고 따뜻한</option>
                    <option value="N">🌙 사색적이고 차분한</option>
                </select>
            </div>

            <textarea
                class="diary-content"
                id="famousContent" 
                name="famousContent"
                placeholder="마음을 울리는 명언 한 줄을 작성해보세요"
                style="min-height: 300px;"
            ></textarea>

            <div class="diary-footer">
                <div class="radio-group">
                    <span style="color: #94a3b8; font-size: 0.85rem;">작성하신 명언은 전체 공개됩니다.</span>
                </div>
                <button class="diary-btn" id="saveFamous" type="button">등록하기</button>
            </div>
        </div>
    </main>

  <script>
$(document).ready(function() {
    // 1. 세션에서 로그인 사용자 객체와 ID를 가져옵니다.
    // 따옴표로 감싸야 값이 없을 때 빈 문자열("")로 인식되어 에러가 나지 않습니다.
    const loginUser = "${sessionScope.loginUser}";
    const loginUserId = "${sessionScope.loginUser.userId}";

    // 2. 진입 시 로그인 체크 (가장 먼저 실행)
    // loginUser가 존재하지 않거나 userId가 비어있으면 로그인 안 된 상태로 간주
    if (!loginUser || loginUserId === "") {
        alert("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동합니다.");
        
        // 중요: 프로젝트의 실제 로그인 주소를 넣으세요. 
        // famous.jsp에서 확인한 경로가 /user/signIn.do 라면 아래 주소로 수정!
        location.href = "${pageContext.request.contextPath}/user/signIn.do";
        return; 
    }

    // Lucide 아이콘 초기화
    if (typeof lucide !== "undefined") {
        lucide.createIcons();
    }

    // 등록 버튼 이벤트
    $("#saveFamous").on("click", function() {
        const author = $("#famousAuthor").val().trim();
        const content = $("#famousContent").val().trim();
        const emotion = $("#famousEmotion").val();

        if (author === "" || content === "") {
            alert("작가와 내용을 모두 입력해주세요.");
            return;
        }

        const param = {
            famousAuthor: author,
            famousContent: content,
            famousEmotion: emotion,
            regId: loginUserId // 위에서 정의한 변수 사용
        };

        if(confirm("작성하신 명언을 등록하시겠습니까?")) {
            $.ajax({
                url: "${pageContext.request.contextPath}/famous/doSave.do",
                type: "POST",
                data: param,
                dataType: "json",
                success: function(res) {
                    if(res.flag == "1" || res == "1") {
                        alert("성공적으로 등록되었습니다.");
                        location.href = "${pageContext.request.contextPath}/famous/famous.do";
                    } else {
                        alert("등록 실패: " + (res.message || "오류 발생"));
                    }
                }
            });
        }
    });
});
</script>
</body>
</html>