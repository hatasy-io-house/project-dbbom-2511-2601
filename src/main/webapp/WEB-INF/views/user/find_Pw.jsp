<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
    .wrap { width: 400px; margin: 50px auto; padding: 30px; border: 1px solid #ddd; border-radius: 8px; }
    h2 { text-align: center; margin-bottom: 30px; }
    .row { margin-bottom: 15px; }
    label { display: block; margin-bottom: 5px; font-weight: bold; }
    input { width: 100%; padding: 10px; box-sizing: border-box; }
    button { width: 100%; padding: 12px; background-color: #4a90e2; color: white; border: none; margin-top: 10px; cursor: pointer; }
    .btn-secondary { background-color: #6c757d; }
</style>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // "비밀번호 찾기" 버튼 클릭 이벤트
    $("#doFindPw").on("click", function(e) {
        // 1. 폼의 기본 제출 동작을 막습니다. (GET 에러 방지 핵심)
        e.preventDefault();

        let userId = $("#userId").val();
        let userName = $("#userName").val();
        let userEmail = $("#userEmail").val();

        // 2. 유효성 검사
        if(!userId || !userName || !userEmail) {
            alert("모든 정보를 입력해주세요.");
            return;
        }

        // 3. 비동기 통신 시작
        $.ajax({
            type: "POST", // 컨트롤러의 @PostMapping과 일치
            url: "${pageContext.request.contextPath}/user/doFindPwAjax.do",
            data: {
                userId: userId,
                userName: userName,
                userEmail: userEmail
            },
            success: function(res) {
                // 서버에서 보낸 JSON 응답 처리
                alert(res.message);
                
                if(res.flag == 1) {
                    // 성공 시 로그인 페이지로 이동
                    location.href = "${pageContext.request.contextPath}/user/signIn.do";
                }
            },
            error: function(xhr, status, error) {
                console.error("Status:", status);
                console.error("Error:", error);
                alert("서버 통신 중 오류가 발생했습니다. (에러 코드: " + xhr.status + ")");
            }
        });
    });
});
</script>
<body>
    <div class="wrap">
        <h2>비밀번호 찾기</h2>
        <form id="findPwForm" onsubmit="return false;">
            <div class="row">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요">
            </div>
            <div class="row">
                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName" placeholder="이름을 입력하세요">
            </div>
            <div class="row">
                <label for="userEmail">이메일</label>
                <input type="email" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요">
            </div>
            
            <button type="button" id="doFindPw">비밀번호 찾기</button>
            <button type="button" class="btn-secondary" onclick="history.back();">취소</button>
        </form>
    </div>
</body>
</html>