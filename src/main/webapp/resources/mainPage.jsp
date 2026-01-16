<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My WebApp - 내면의 흔적</title>

    <!-- ✅ 로그아웃/회원탈퇴 AJAX를 위해 jQuery 로드 -->
    <script src="<%=request.getContextPath()%>/resources/assets/js/cmn/jquery.js"></script>

    <style>
        .container { width: 800px; margin: 20px auto; padding: 10px; background-color: #e0e0e0; border: 1px solid #c0c0c0; box-shadow: 2px 2px 5px rgba(0,0,0,0.1); }
        .blue-box { background-color: #4a90e2; color: white; padding: 10px; margin-bottom: 10px; text-align: center; border: 1px solid #3a7bd5; box-sizing: border-box; }
        .main-menu { display: flex; justify-content: space-around; }
        .menu-group { display: flex; flex-grow: 1; justify-content: space-around; }
        .menu-link { color: inherit; text-decoration: none; cursor: pointer; }
        .menu-link:hover { text-decoration: underline; }
        .sub-menu-container { display: flex; justify-content: space-between; margin-top: 10px; }
        .sub-menu-item { width: 24%; text-align: center; }
        .sub-menu-button { background-color: #4a90e2; color: white; padding: 10px 0; margin-bottom: 5px; border: 1px solid #3a7bd5; }
        .sub-menu-description { background-color: #4a90e2; color: white; padding: 5px 0; font-size: 0.8em; border: 1px solid #3a7bd5; }
        .diary-section-title { margin-top: 20px; margin-bottom: 10px; font-weight: bold; }
        .diary-posts-container { display: flex; justify-content: space-between; }
        .diary-post { width: 24%; height: 150px; background-color: #4a90e2; color: white; padding: 15px; text-align: center; display: flex; flex-direction: column; justify-content: center; border: 1px solid #3a7bd5; }

        /* ✅ 상단 로그인 영역 보기 좋게 약간만 정리 */
        .top-auth { text-align: center; margin: 20px; }
        .top-auth .welcome { font-weight: bold; margin-bottom: 10px; }
        .top-auth button { margin: 0 4px; padding: 8px 12px; cursor: pointer; }
    </style>

    <script>
        // ✅ 로그아웃(AJAX)
        function doLogout() {
            // confirm은 "경고창(alert)"이 아니라 "확인창(confirm)"이 맞습니다.
            if (confirm("로그아웃 하시겠습니까?") === false) return;

            $.ajax({
                url: "<%=request.getContextPath()%>/user/doLogoutAjax.do",
                type: "POST",
                dataType: "json",
                success: function(res) {
                    alert(res.message);

                    // 성공이면 메인 새로고침(또는 이동)
                    if (res.flag === 1) {
                        location.href = "<%=request.getContextPath()%>/resources/mainPage.jsp";
                    }
                },
                error: function(xhr, status, err) {
                    alert("통신 오류가 발생했습니다. (status: " + status + ")");
                }
            });
        }

        // ✅ 회원탈퇴(DB 삭제) - 대표님 요구사항의 "로그아웃 누르면 DB 삭제"는 보통 탈퇴 기능입니다.
        function doWithdraw() {
            if (confirm("정말 회원탈퇴 하시겠습니까?\n(가입 정보가 DB에서 삭제됩니다.)") === false) return;

            $.ajax({
                url: "<%=request.getContextPath()%>/user/doWithdrawAjax.do",
                type: "POST",
                dataType: "json",
                success: function(res) {
                    alert(res.message);

                    if (res.flag === 1) {
                        location.href = "<%=request.getContextPath()%>/resources/mainPage.jsp";
                    }
                },
                error: function(xhr, status, err) {
                    alert("통신 오류가 발생했습니다. (status: " + status + ")");
                }
            });
        }
    </script>
</head>
<body>

<%
    // ✅ 세션에서 로그인 사용자 꺼내기
    UserVO loginUser = (UserVO) session.getAttribute("loginUser");

    // 환영 문구에 사용할 이름(닉네임 우선)
    String welcomeName = "";
    if (loginUser != null) {
        if (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty()) {
            welcomeName = loginUser.getNickname();
        } else {
            welcomeName = loginUser.getUserId();
        }
    }
%>

<div class="container">

    <!-- ✅ 회원가입/로그인/환영/마이페이지/로그아웃/탈퇴 버튼 영역 -->
    <div class="top-auth">

        <% if (loginUser == null) { %>
            <!-- 비로그인 상태 -->
            <button onclick="location.href='<%=request.getContextPath()%>/user/signUp.do'">회원가입</button>
            <button onclick="location.href='<%=request.getContextPath()%>/user/signIn.do'">로그인</button>

            <!-- 대표님 요구: 비회원이 로그아웃 누르면 "로그인을 진행 해주세요!" -->
            <!-- 버튼을 보여줄지 말지는 선택인데, 요구사항대로 버튼도 보여주고 메시지도 띄우게 구성 -->
            <button type="button" onclick="doLogout()">로그아웃</button>

        <% } else { %>
            <!-- 로그인 상태 -->
            <div class="welcome"><%= welcomeName %>님 환영합니다</div>

            <!-- 마이페이지는 "버튼만" 요청이므로 화면 이동만 연결(다음 단계에서 구현 가능) -->
            
            <button type="button" onclick="location.href='<%=request.getContextPath()%>/user/myPage.do'">마이페이지</button>            

            <button type="button" onclick="doLogout()">로그아웃</button>

            <!-- 대표님 요구(가입정보 DB 삭제) = 회원탈퇴 버튼 -->
            <button type="button" onclick="doWithdraw()">회원탈퇴</button>
        <% } %>

    </div>
		<div style="text-align: center; color: red;">
			session loginUser =
			<%=(session.getAttribute("loginUser") == null ? "null" : "NOT NULL")%>
		</div>


		<div class="blue-box main-menu">
        <div>메뉴</div>
        <div class="menu-group">
            <a href="summaryPage.jsp" class="menu-link">개요</a> /
            <span class="menu-link">공지사항</span> /
            <span class="menu-link">게시판</span> /
            <span class="menu-link">나의 내면</span>
        </div>
    </div>

    <div class="sub-menu-container">
        <div class="sub-menu-item">
            <div class="sub-menu-button">명언</div>
            <div class="sub-menu-description">설명</div>
        </div>
        <div class="sub-menu-item">
            <div class="sub-menu-button">행운</div>
            <div class="sub-menu-description">설명</div>
        </div>
        <div class="sub-menu-item">
            <div class="sub-menu-button">감사</div>
            <div class="sub-menu-description">설명</div>
        </div>
        <div class="sub-menu-item">
            <div class="sub-menu-button">고해성사</div>
            <div class="sub-menu-description">설명</div>
        </div>
    </div>

    <div class="diary-section-title">일기 게시글</div>

    <div class="diary-posts-container">
        <div class="diary-post">
            <div>인기 공개 일기 1</div>
            <div>(명언)</div>
        </div>
        <div class="diary-post">
            <div>인기 공개 일기 2</div>
            <div>(행운)</div>
        </div>
        <div class="diary-post">
            <div>인기 공개 일기 3</div>
            <div>(감사)</div>
        </div>
        <div class="diary-post">
            <div>인기 공개 일기 4</div>
            <div>(고해성사)</div>
        </div>
    </div>

</div>

</body>
</html>
