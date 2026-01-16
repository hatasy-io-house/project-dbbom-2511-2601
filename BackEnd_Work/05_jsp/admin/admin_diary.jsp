<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="section" id="section3">
    <strong>📝 전체 게시글 관리</strong>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>상태</th>
                <th>날짜</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="vo" items="${diaryList}">
                <tr>
                    <td>${vo.diarySid}</td>
                    <td style="text-align:left; padding-left:10px;">${vo.diaryTitle}</td>
                    <td>${vo.regId}</td>
                    <td>${vo.diaryViewcount}</td>
                    <td>
                        <select onchange="changeDiaryStatus(${vo.diarySid}, this.value)">
                            <option value="Y" ${vo.diaryStatus == 'Y' ? 'selected' : ''}>공개</option>
                            <option value="N" ${vo.diaryStatus == 'N' ? 'selected' : ''}>비공개</option>
                        </select>
                    </td>
                    <td>${vo.diaryUploadDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>