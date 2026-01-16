<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<style>
    .wrap { width: 400px; margin: 50px auto; padding: 30px; border: 1px solid #ddd; border-radius: 8px; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    .result-box { background-color: #f8f9fa; padding: 20px; border-radius: 5px; margin: 20px 0; border: 1px dashed #4a90e2; }
    .user-id { font-size: 20px; font-weight: bold; color: #4a90e2; }
    button { width: 100%; padding: 12px; background-color: #4a90e2; color: white; border: none; border-radius: 4px; cursor: pointer; margin-bottom: 10px; }
</style>
</head>
<body>
    <div class="wrap">
        <h2>아이디 찾기 결과</h2>
        
        <c:choose>
            <c:when test="${not empty foundId}">
                <p>${userName} 님의 정보와 일치하는 아이디입니다.</p>
                <div class="result-box">
                    아이디: <span class="user-id">${foundId}</span>
                </div>
            </c:when>
            <c:otherwise>
                <div class="result-box">
                    <p>${message}</p>
                </div>
            </c:otherwise>
        </c:choose>

        <button type="button" onclick="location.href='<%=request.getContextPath()%>/user/signInView.do'">로그인하러 가기</button>
        <button type="button" style="background-color: #6c757d;" onclick="location.href='<%=request.getContextPath()%>/user/findPwView.do'">비밀번호 찾기</button>
    </div>
</body>
</html>