<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="section" id="section1">
    <strong>🚩 전체 신고 내역</strong>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>신고유형</th>
                <th>신고내용</th>
                <th>작성자ID</th>
                <th>누적신고수</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty reportList}">
                    <c:forEach var="vo" items="${reportList}">
                        <tr>
                            <td>${vo.reportSid}</td>
                            <td>${vo.reportCategory}</td>
                            <td>${vo.reportContent}</td>
                            <td>${vo.regId}</td>
                            <td><strong>${vo.reportCnt}</strong></td>
                            <td>
                                <button onclick="deleteDiary(${vo.diarySid})">게시글삭제</button>
                                <button onclick="dismissReport(${vo.reportSid})">무시</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="6">신고된 내역이 없습니다.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>