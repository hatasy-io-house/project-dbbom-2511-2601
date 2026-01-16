<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO" %>
<%
    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
    String welcomeName = "";
    boolean isLogin = false;
    if (loginUser != null) {
        isLogin = true;
        welcomeName = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty()) 
                      ? loginUser.getNickname() : loginUser.getUserId();
    }
%>
<header>

    <script>
        // 마이페이지 이동 로직 (로그인 여부 체크)
        function moveToMyPage() {
            var isLogin = <%= isLogin %>;
            if (!isLogin) {
                alert("로그인이 필요합니다.");
                location.href = "<%=request.getContextPath()%>/user/signIn.do";
                return;
            }
            location.href = "<%=request.getContextPath()%>/user/myPage.do";
        }

        // 로그아웃 로직
        function doLogout() {
            if (!confirm("로그아웃 하시겠습니까?")) return;
            $.ajax({
                url: "<%=request.getContextPath()%>/user/doLogoutAjax.do",
                type: "POST",
                dataType: "json",
                success: function(res) {
                    alert(res.message);
                    if (res.flag === 1) location.href = "<%=request.getContextPath()%>/main/main.do";
                },
                error: function(xhr, status, err) { alert("오류 발생"); }
            });
        }

        // 회원탈퇴 로직
        <%-- function doWithdraw() {
            if (!confirm("정말 회원탈퇴 하시겠습니까?\n(가입 정보가 DB에서 삭제됩니다.)")) return;
            $.ajax({
                url: "<%=request.getContextPath()%>/user/doWithdrawAjax.do",
                type: "POST",
                dataType: "json",
                success: function(res) {
                    alert(res.message);
                    if (res.flag === 1) location.href = "<%=request.getContextPath()%>/main/main.do";
                },
                error: function(xhr, status, err) { alert("오류 발생"); }
            });
        } --%>
    </script>
  <div class="container header-inner flex-between">
    <a href="<%=request.getContextPath()%>/main/main.do" class="logo-area" style="text-decoration: none">
      <h1 class="logo-text">내면의 흔적</h1>
    </a>
    <div class="auth-links">
      <% if (!isLogin) { %>
          <a href="<%=request.getContextPath()%>/user/signIn.do" class="auth-item">로그인</a>
          <span class="divider">|</span>
          <a href="<%=request.getContextPath()%>/user/signUp.do" class="auth-item">회원가입</a>
      <% } else { %>
          <span class="auth-item"><b><%= welcomeName %></b>님 환영합니다</span>

          
          <span class="divider">|</span>
          <a href="javascript:doLogout();" class="auth-item">로그아웃</a>
          <%-- <span class="divider">|</span>
          <a href="javascript:doWithdraw();" class="auth-item" style="color:red; font-size:0.8rem;">회원탈퇴</a> --%>
      <% } %>
    </div>
  </div>
</header>
  <div class="container">
<div class="tab-list">
  <div class="menu-label">메뉴</div>
  <a href="<%=request.getContextPath()%>/main/outline.do" class="tab-btn"><i data-lucide="sparkles"></i> 개요</a>
  <a href="<%=request.getContextPath()%>/notice/noticeList.do" class="tab-btn">
    <i data-lucide="book-open"></i> 공지사항</a>
  <div class="dropdown-container">
    <a href="<%=request.getContextPath()%>/diary/diaryList.do" class="tab-btn" style="width: 100%; border: none"><i data-lucide="pencil"></i> 게시판</a>
    <div class="dropdown-content">
      <a href="<%=request.getContextPath()%>/diary/diaryList.do">📖 일기 공개 게시판</a>
      <a href="<%=request.getContextPath()%>/famous/famous.do">💬 명언 모음집</a>
    </div>
  </div>
  <a href="javascript:moveToMyPage();" class="tab-btn"><i data-lucide="user"></i> 마이페이지</a>
</div>
</div>
<script>
    function moveToMyPage() {
        var isLogin = <%= isLogin %>;
        if (!isLogin) {
            alert("로그인이 필요합니다.");
            location.href = "<%=request.getContextPath()%>/user/signIn.do";
            return;
        }
        location.href = "<%=request.getContextPath()%>/user/myPage.do";
    }
    function doLogout() {
        if (!confirm("로그아웃 하시겠습니까?")) return;
        $.ajax({
            url: "<%=request.getContextPath()%>/user/doLogoutAjax.do",
            type: "POST",
            dataType: "json",
            success: function(res) {
                alert(res.message);
                if (res.flag === 1) location.href = "<%=request.getContextPath()%>/main/main.do";
            },
            error: function(xhr, status, err) { alert("오류 발생"); }
        });
    }
    function doWithdraw() {
        if (!confirm("정말 회원탈퇴 하시겠습니까?\n(가입 정보가 DB에서 삭제됩니다.)")) return;
        $.ajax({
            url: "<%=request.getContextPath()%>/user/doWithdrawAjax.do",
            type: "POST",
            dataType: "json",
            success: function(res) {
                alert(res.message);
                if (res.flag === 1) location.href = "<%=request.getContextPath()%>/main/main.do";
            },
            error: function(xhr, status, err) { alert("오류 발생"); }
        });
    }
</script>

<script>
    window.loginUserId = "<%= (loginUser != null) ? loginUser.getUserId() : "" %>";
</script>