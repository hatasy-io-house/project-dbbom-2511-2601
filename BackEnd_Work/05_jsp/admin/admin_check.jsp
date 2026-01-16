<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO" %>
<%
    // 세션에서 로그인 사용자 정보 가져오기
    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
    String welcomeName = "";
    boolean isLogin = false;
    boolean isAdmin = false;

    if (loginUser != null) {
        isLogin = true;
        // adminChk가 "1"이면 관리자로 판단
        if("1".equals(loginUser.getAdminChk())) {
            isAdmin = true;
        }
        // 닉네임 우선 표시 
        welcomeName = (loginUser.getNickname() != null && !loginUser.getNickname().trim().isEmpty()) 
                      ? loginUser.getNickname() : loginUser.getUserId();
    }

    // EL 식 및 자바스크립트에서 사용할 수 있도록 request 객체에 담기
    request.setAttribute("isLogin", isLogin);
    request.setAttribute("isAdmin", isAdmin);
    request.setAttribute("welcomeName", welcomeName);
%>