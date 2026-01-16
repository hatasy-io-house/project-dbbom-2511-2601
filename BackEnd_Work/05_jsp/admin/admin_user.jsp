<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="section" id="section2">
    <strong>👥 전체 회원 관리</strong>
    <form action="${pageContext.request.contextPath}/admin/userList.do" method="get" class="controls">
        <select name="searchDiv" style="border:1px solid #000;">
            <option value="10" ${dto.searchDiv == '10' ? 'selected' : ''}>ID</option>
            <option value="20" ${dto.searchDiv == '20' ? 'selected' : ''}>이름</option>
        </select>
        <input type="text" name="searchWord" value="${dto.searchWord}" placeholder="검색어 입력..." />
        <button type="submit">조회</button>
    </form>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>이름</th>
                <th>닉네임</th>
                <th>이메일</th>
                <th>권한</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="vo" items="${userList}">
                <tr>
                    <td>${vo.userId}</td>
                    <td>${vo.userName}</td>
                    <td>${vo.nickname}</td>
                    <td>${vo.userEmail}</td>
                    <td>
                        <select onchange="updateAdminRole('${vo.userId}', this.value)">
                            <option value="Y" ${vo.adminChk == 'Y' ? 'selected' : ''}>관리자</option>
                            <option value="N" ${vo.adminChk == 'N' ? 'selected' : ''}>일반</option>
                        </select>
                    </td>
                    <td><button onclick="withdrawUser('${vo.userId}')">강제탈퇴</button></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>