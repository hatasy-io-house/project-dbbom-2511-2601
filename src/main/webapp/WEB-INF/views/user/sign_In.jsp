<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>로그인</title>

  <script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>

  <style>
    .wrap { width: 420px; margin: 30px auto; padding: 20px; border: 1px solid #ddd; }
    .row { margin-bottom: 12px; }
    label { display:block; margin-bottom: 6px; font-weight: 600; }
    input { width: 100%; padding: 10px; box-sizing: border-box; }
    .btns { display:flex; gap:10px; margin-top: 16px; }
    button { padding: 10px 14px; cursor:pointer; }
  </style>

	  <script>
	  function isEmpty(v){
	    return v === null || v === undefined || (String(v).trim().length === 0);
	  }
	
	  document.addEventListener('DOMContentLoaded', function(){
	    const userId = document.querySelector("#userId");
	    const userPw = document.querySelector("#userPw");
	    const doSignInBtn = document.querySelector("#doSignIn");
	
	    // 로그인 실행 함수 (중복 방지를 위해 하나로 합침)
	    function handleSignIn() {
	      if(isEmpty(userId.value)){
	        alert("아이디를 입력하세요.");
	        userId.focus();
	        return;
	      }
	      if(isEmpty(userPw.value)){
	        alert("비밀번호를 입력하세요.");
	        userPw.focus();
	        return;
	      }
	
	      let param = $("#signInForm").serialize();
	
	      $.ajax({
	        url: "<%=request.getContextPath()%>/user/doSignInAjax.do",
	        type: "POST",
	        data: param,
	        dataType: "json",
	        success: function(res){
	          if(res.flag === 1){
	            alert(res.message);
	            location.href = "<%=request.getContextPath()%>/main/main.do";
	          } else {
	            alert(res.message);
	          }
	        },
	        error: function(xhr, status, err){
	          alert("통신 오류가 발생했습니다. (status: " + status + ")");
	        }
	      });
	    }
	
	    // 1. 로그인 버튼 클릭 시 실행
	    doSignInBtn.addEventListener("click", function() {
	        handleSignIn();
	    });
	
	    // 2. 비밀번호 입력창에서 엔터키를 눌렀을 때 실행
	    userPw.addEventListener("keydown", function(e) {
	      if (e.keyCode === 13) { // 13번이 엔터키의 키코드입니다.
	        handleSignIn();
	      }
	    });
	    
	    // 3. (선택사항) 아이디 입력창에서 엔터를 누르면 비밀번호 창으로 이동
	    userId.addEventListener("keydown", function(e) {
	      if (e.keyCode === 13) {
	        userPw.focus();
	      }
	    });
	  });
	</script>
</head>

<body>
  <div class="wrap">
    <h2>로그인</h2>

    <form method="post" id="signInForm">
      <div class="row">
        <label for="userId">아이디</label>
        <input type="text" id="userId" name="userId" maxlength="20" />
      </div>

      <div class="row">
        <label for="userPw">비밀번호</label>
        <input type="password" id="userPw" name="userPw" maxlength="30" />
      </div>

      <div class="btns">
        <button type="button" id="doSignIn">로그인</button>
        <button type="button" onclick="location.href='<%=request.getContextPath()%>/main/main.do'">
                        메인으로
        </button>
      </div>
			<div style="margin-top: 20px; text-align: center;">
				<div style="color: #666; font-size: 14px; margin-bottom: 8px;">아이디/비밀번호를
					잊으셨나요?</div>
				<div style="font-size: 14px;">
					<a href="<%=request.getContextPath()%>/user/findIdView.do"
						style="color: #4a90e2; text-decoration: none; margin-right: 10px;">아이디
						찾기</a> <span style="color: #ccc;">|</span> <a
						href="<%=request.getContextPath()%>/user/findPwView.do"
						style="color: #4a90e2; text-decoration: none; margin-left: 10px;">비밀번호
						찾기</a>
				</div>
			</div>
		</form>
  </div>
</body>
</html>
