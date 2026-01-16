<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>
<style>
    .wrap { width: 400px; margin: 50px auto; padding: 30px; border: 1px solid #ddd; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #333; margin-bottom: 30px; }
    .row { margin-bottom: 20px; }
    label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
    input { width: 100%; padding: 12px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
    .btn-area { margin-top: 30px; }
    button { width: 100%; padding: 12px; background-color: #4a90e2; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; margin-bottom: 10px; }
    button:hover { background-color: #357abd; }
    .sub-link { text-align: center; font-size: 14px; }
    .sub-link a { color: #666; text-decoration: none; }
</style>
</head>
<body>
    <div class="wrap">
        <h2>아이디 찾기</h2>
        <form id="findIdForm" method="post" action="<%=request.getContextPath()%>/user/doFindId.do">
            <div class="row">
                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName" placeholder="이름을 입력하세요">
            </div>
            <div class="row">
                <label for="userEmail">이메일</label>
                <input type="email" id="userEmail" name="userEmail" placeholder="가입 시 등록한 이메일을 입력하세요">
            </div>
            <div class="btn-area">
                <button type="button" id="doFindId">아이디 찾기</button>
                <button type="button" style="background-color: #6c757d;" onclick="history.back();">취소</button>
            </div>
        </form>
        <div class="sub-link">
            <a href="<%=request.getContextPath()%>/user/findPwView.do">비밀번호를 잊으셨나요?</a>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $("#doFindId").on("click", function() {
                const name = $("#userName").val();
                const email = $("#userEmail").val();

                if(!name) { alert("이름을 입력해주세요."); return; }
                if(!email) { alert("이메일을 입력해주세요."); return; }

                // 1. "아이디를 찾으시겠습니까?" 확인창
                if(confirm("아이디를 찾으시겠습니까?")) {
                    // AJAX 대신 폼 전송(submit)을 실행하여 결과 페이지로 이동합니다.
                    $("#findIdForm").submit();
                }
            });
        });
    </script>
</body>
</html>