<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>회원가입</title>

  <script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>

  <style>
    .wrap { width: 520px; margin: 30px auto; padding: 20px; border: 1px solid #ddd; }
    .row { margin-bottom: 12px; }
    label { display:block; margin-bottom: 6px; font-weight: 600; }
    input, textarea { width: 100%; padding: 10px; box-sizing: border-box; }
    .btns { display:flex; gap:10px; margin-top: 16px; }
    button { padding: 10px 14px; cursor:pointer; }
    .hint { font-size: 12px; color: #666; margin-top: 4px; }
    
    /* [공통] 입력창과 버튼을 한 줄에 배치하는 그룹 */
    .input-group {
        display: flex;
        gap: 8px;
    }
    .input-group input {
        flex: 1;
    }
    
    /* [공통] 중복확인 버튼 디자인 (아이디 스타일로 통일) */
    .btn-check {
        width: 100px;
        padding: 10px;
        background-color: #4A90E2; /* 파란색 */
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        white-space: nowrap;
        font-size: 13px;
    }
    .btn-check:hover {
        background-color: #357ABD;
    }
    
    /* [공통] 중복확인 결과 메시지 스타일 */
    .check-msg {
        font-size: 13px;
        margin-top: 5px;
        display: none;
    }
    
    /* 가입하기 버튼 스타일 강조 */
    #doSignUp {
        background-color: #333;
        color: white;
        border: none;
        border-radius: 4px;
        flex: 1;
    }
  </style>

  <script>
    let isIdChecked = false;
    let isNicknameChecked = false;

    function isEmpty(v) {
        return v === null || v === undefined || (String(v).trim().length === 0);
    }

    function isValidEmail(email) {
        if (isEmpty(email)) return false;
        return email.includes("@") && email.includes(".");
    }

    function doSignUpRequest() {
        const userId = document.querySelector("#userId");
        const userName = document.querySelector("#userName");
        const userPw = document.querySelector("#userPw");
        const userTel = document.querySelector("#userTel");
        const userEmail = document.querySelector("#userEmail");
        const nickname = document.querySelector("#nickname");

        // 1) 아이디/닉네임 중복 체크 필수 확인
        if (isEmpty(userId.value)) { alert("아이디를 입력하세요."); userId.focus(); return; }
        if (!isIdChecked) { alert("아이디 중복 확인을 해주세요."); userId.focus(); return; }

        if (isEmpty(nickname.value)) { alert("닉네임을 입력하세요."); nickname.focus(); return; }
        if (!isNicknameChecked) { alert("닉네임 중복 확인을 해주세요."); nickname.focus(); return; }

        // 2) 기타 필수값 검증
        if (isEmpty(userName.value)) { alert("이름을 입력하세요."); userName.focus(); return; }
        if (isEmpty(userPw.value)) { alert("비밀번호를 입력하세요."); userPw.focus(); return; }
        if (isEmpty(userTel.value)) { alert("전화번호를 입력하세요."); userTel.focus(); return; }
        if (!isValidEmail(userEmail.value)) { alert("이메일 형식을 확인하세요."); userEmail.focus(); return; }

        if (confirm("가입 하시겠습니까?") === false) return;

        let param = $("#signUpForm").serialize();
        $.ajax({
            url: "<%=request.getContextPath()%>/user/doSignUpAjax.do",
            type: "POST",
            data: param,
            dataType: "json",
            success: function(res) {
                if (res.flag === 1) {
                    alert(res.message);
                    location.href = "<%=request.getContextPath()%>/main/main.do";
                } else {
                    alert(res.message);
                }
            },
            error: function() { alert("통신 오류가 발생했습니다."); }
        });
    }

    $(document).ready(function() {
        // 아이디 중복 확인
        $("#btnCheckId").on("click", function() {
            const userId = $("#userId").val();
            if (isEmpty(userId)) { alert("아이디를 입력해주세요."); $("#userId").focus(); return; }

            $.ajax({
                url: "<%=request.getContextPath()%>/user/doCheckIdAjax.do",
                type: "GET",
                data: { "userId": userId },
                success: function(res) {
                    $("#idCheckMsg").show();
                    if (res.flag === 1) {
                        $("#idCheckMsg").text("사용 가능한 아이디입니다!").css("color", "#28a745");
                        isIdChecked = true;
                    } else {
                        $("#idCheckMsg").text("중복된 아이디가 존재합니다.").css("color", "#dc3545");
                        isIdChecked = false;
                    }
                }
            });
        });

        // 닉네임 중복 확인
        $("#btnCheckNickname").on("click", function() {
            const nickname = $("#nickname").val();
            if (isEmpty(nickname)) { alert("닉네임을 입력해주세요."); $("#nickname").focus(); return; }

            $.ajax({
                url: "<%=request.getContextPath()%>/user/doCheckNicknameAjax.do",
                type: "GET",
                data: { "nickname": nickname },
                success: function(res) {
                    $("#nickCheckMsg").show();
                    if (res.flag === 1) {
                        $("#nickCheckMsg").text("사용 가능한 닉네임입니다!").css("color", "#28a745");
                        isNicknameChecked = true;
                    } else {
                        $("#nickCheckMsg").text("이미 사용 중인 닉네임입니다.").css("color", "#dc3545");
                        isNicknameChecked = false;
                    }
                }
            });
        });

        // 입력창 변경 시 상태 초기화
        $("#userId").on("input", function() { isIdChecked = false; $("#idCheckMsg").hide(); });
        $("#nickname").on("input", function() { isNicknameChecked = false; $("#nickCheckMsg").hide(); });

        $("#doSignUp").on("click", function() { doSignUpRequest(); });
        $("#signUpForm").on("submit", function(e) { e.preventDefault(); doSignUpRequest(); });
    });
  </script>
</head>
<body>

<div class="wrap">
    <h2>회원가입</h2>
    <form method="post" id="signUpForm">
        <div class="row">
            <label for="userId">아이디(user_id) *</label>
            <div class="input-group">
                <input type="text" id="userId" name="userId" maxlength="20" placeholder="아이디 입력" />
                <button type="button" id="btnCheckId" class="btn-check">중복확인</button>
            </div>
            <div id="idCheckMsg" class="check-msg"></div>
        </div>

        <div class="row">
            <label for="userName">이름(user_name) *</label>
            <input type="text" id="userName" name="userName" maxlength="7" />
        </div>

        <div class="row">
            <label for="userPw">비밀번호(user_pw) *</label>
            <input type="password" id="userPw" name="userPw" maxlength="30" />
            <div class="hint">※ 비밀번호 암호화가 적용됩니다.</div>
        </div>

        <div class="row">
            <label for="userTel">전화번호(user_tel) *</label>
            <input type="text" id="userTel" name="userTel" maxlength="13" placeholder="010-1234-5678" />
        </div>

        <div class="row">
            <label for="userEmail">이메일(user_email) *</label>
            <input type="email" id="userEmail" name="userEmail" maxlength="255" />
        </div>

        <div class="row">
            <label for="nickname">닉네임(nickname) *</label>
            <div class="input-group">
                <input type="text" id="nickname" name="nickname" maxlength="20" placeholder="닉네임 입력">
                <button type="button" id="btnCheckNickname" class="btn-check">중복확인</button>
            </div>
            <div id="nickCheckMsg" class="check-msg"></div>
        </div>

        <div class="row">
            <label for="userIntro">자기소개(user_intro)</label>
            <textarea id="userIntro" name="userIntro" rows="4" maxlength="50"></textarea>
        </div>

        <input type="hidden" name="adminChk" value="N"/>

        <div class="btns">
            <button type="button" id="doSignUp">가입하기</button>
            <button type="button" onclick="location.href='<%=request.getContextPath()%>/main/main.do'">메인으로</button>
        </div>
    </form>
</div>

</body>
</html>