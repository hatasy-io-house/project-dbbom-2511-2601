<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>내면의 흔적 - 관리자 콘솔</title>

<script src="https://unpkg.com/lucide@latest"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
  href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet"
  href="${pageContext.request.contextPath}/resources/assets/css/main.css" />

<style>
/* --- 원본 디자인 100% 보존 및 가시성 개선 --- */
header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 70px;
  background: white;
  z-index: 1000;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

main.container {
  margin-top: 100px;
  min-height: calc(100vh - 100px);
}

.admin-header-area {
  margin-bottom: 2rem;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
}

.admin-table-card {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
  border: 1px solid rgba(0, 0, 0, 0.05);
  margin-bottom: 3rem;
  scroll-margin-top: 100px;
}

.admin-search-box {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
  justify-content: flex-end;
  width: fit-content;
  max-width: 40%;
  margin-left: auto;
}

.admin-search-select, .admin-search-input {
  padding: 8px 12px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
  outline: none;
}

.admin-search-input {
  flex-grow: 1;
  min-width: 200px;
}

button {
  cursor: pointer;
  border: none;
  font-family: inherit;
  transition: all 0.2s;
}

.btn-search {
  background: #3b82f6;
  color: white;
  padding: 8px 16px;
  border-radius: 8px;
  font-weight: 600;
}

.btn-search:hover {
  background: #2563eb;
}

.btn-admin-del {
  background-color: #fee2e2;
  color: #ef4444;
  padding: 8px 16px;
  border-radius: 8px;
  font-weight: 600;
}

.btn-admin-del:hover {
  background-color: #fecaca;
}

.btn-batch-del {
  background-color: #3b82f6;
  color: white;
  padding: 10px 20px;
  border-radius: 10px;
  font-weight: 700;
  display: flex;
  align-items: center;
  gap: 8px;
}

.custom-table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0 10px;
  table-layout: fixed;
}

.custom-table th {
  padding: 12px;
  color: #64748b;
  font-weight: 700;
  border-bottom: 2px solid #e2e8f0;
  text-align: center;
}

.custom-table td {
  padding: 15px;
  background-color: #f8fafc;
  text-align: center;
  vertical-align: middle;
}

.custom-table tr td:first-child {
  border-radius: 12px 0 0 12px;
}

.custom-table tr td:last-child {
  border-radius: 0 12px 12px 0;
}

.custom-table tr:hover td {
  background-color: #f1f5f9;
  color: #3b82f6;
}

/* 열 너비 설정 */
.col-chk { width: 50px; }
.col-num { width: 80px; }
.col-type { width: 100px; }
.col-content { width: auto; }
.col-user { width: 120px; }
.col-mng { width: 100px; }

.admin-pagination {
  display: flex;
  justify-content: center;
  gap: 8px;
  margin-top: 25px;
}

.page-link {
  padding: 8px 14px;
  border-radius: 8px;
  border: 1px solid #e2e8f0;
  text-decoration: none;
  color: #64748b;
  font-weight: 600;
}

.page-link:hover {
  background-color: #f1f5f9;
  color: #3b82f6;
}

.page-link.active {
  background-color: #3b82f6;
  color: white;
  border-color: #3b82f6;
}

.modal-overlay {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  z-index: 2000;
  justify-content: center;
  align-items: center;
}

.modal-content {
  background: white;
  width: 90%;
  max-width: 550px;
  padding: 2.5rem;
  border-radius: 20px;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
  box-sizing: border-box;
}

.modal-body {
  line-height: 1.6;
  color: #334155;
  text-align: left;
  max-height: 60vh;
  overflow-y: auto;
  word-break: break-all;
  overflow-wrap: break-word;
}

.text-ellipsis {
  max-width: 100%;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  margin: 0 auto;
}

.clickable-reason {
  color: #2563eb;
  font-weight: 600;
  text-decoration: underline;
  cursor: pointer;
}

.type-badge {
  background: #e2e8f0;
  color: #475569;
  padding: 4px 10px;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 600;
}
</style>
</head>
<body>
  <div id="detailModal" class="modal-overlay">
    <div class="modal-content">
      <div class="modal-header"
        style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; border-bottom: 1px solid #eee; padding-bottom: 1rem;">
        <h3 id="modalTitle" style="margin: 0; font-weight: 700;">상세 내용</h3>
        <i data-lucide="x" style="cursor: pointer; color: #64748b;"
          onclick="closeModal()"></i>
      </div>
      <div id="modalBody" class="modal-body"></div>
    </div>
  </div>

  <header>
    <div class="container header-inner flex-between"
      style="display: flex; align-items: center; height: 100%; padding: 0 20px;">
      <a href="${pageContext.request.contextPath}/main/main.do"
        class="logo-area" style="text-decoration: none">
        <h1 class="logo-text" style="margin: 0;">내면의 흔적</h1>
      </a>
      <div class="auth-links">
        <span class="auth-item" style="color: #3b82f6">관리자님 환영합니다</span> <span
          class="divider">|</span> <a href="javascript:doLogout();"
          class="auth-item">로그아웃</a>
      </div>
    </div>
  </header>

  <main class="container">
    <div class="tab-list">
      <a href="${pageContext.request.contextPath}/main/main.do"
        class="menu-label" style="text-decoration: none;"> <i
        data-lucide="home"
        style="width: 16px; margin-right: 4px; vertical-align: middle;"></i>
        메인으로
      </a> <a href="adminPage.do?menu=all"
        class="tab-btn ${menu eq 'all' ? 'active' : ''}">전체보기</a> <a
        href="adminPage.do?menu=section1"
        class="tab-btn ${menu eq 'section1' ? 'active' : ''}">신고관리</a> <a
        href="adminPage.do?menu=section2"
        class="tab-btn ${menu eq 'section2' ? 'active' : ''}">회원관리</a> <a
        href="adminPage.do?menu=section3"
        class="tab-btn ${menu eq 'section3' ? 'active' : ''}">게시글관리</a>
    </div>

    <div class="tab-content">
      <div class="admin-header-area">
        <section class="hero-section" style="text-align: left; margin: 0;">
          <h2>관리자 통합 콘솔</h2>
          <p>커뮤니티의 건전한 유지와 회원 관리를 수행합니다.</p>
        </section>
        <button type="button" class="btn-batch-del"
          onclick="deleteSelected()">
          <i data-lucide="trash-2"></i> 선택 항목 일괄 삭제
        </button>
      </div>

      <form action="adminPage.do" method="get" id="searchForm"
        class="admin-search-box">
        <input type="hidden" name="menu" value="${menu}"> <select
          name="searchDiv" class="admin-search-select">
          <option value="10" ${searchDiv == '10' ? 'selected' : ''}>제목/내용</option>
          <option value="20" ${searchDiv == '20' ? 'selected' : ''}>작성자/ID</option>
        </select> <input type="text" name="searchWord" class="admin-search-input"
          value="${searchWord}" placeholder="검색어를 입력하세요">
        <button type="submit" class="btn-search">검색</button>
      </form>

      <%-- 1. 신고 관리 섹션 --%>
      <c:if test="${menu eq 'section1' || menu eq 'all'}">
        <div class="admin-table-card" id="section1">
          <div class="section-title"
            style="margin-bottom: 1.5rem; font-weight: 700;">
            <i data-lucide="flame"
              style="color: #ef4444; vertical-align: middle;"></i> 신고 내역 관리
          </div>
          <table class="custom-table">
            <colgroup>
              <col class="col-chk">
              <col class="col-num">
              <col class="col-type">
              <col class="col-content">
              <col class="col-user">
              <col class="col-mng">
            </colgroup>
            <thead>
              <tr>
                <th><input type="checkbox"
                  onclick="toggleAll(this, 'report-chk')"></th>
                <th>번호</th>
                <th>신고 유형</th>
                <th>신고 사유</th>
                <th>작성자</th>
                <th>관리</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${not empty reportList}">
                  <c:forEach var="vo" items="${reportList}">
                    <tr>
                      <td><input type="checkbox" class="report-chk"
                        value="${vo.reportSid}"
                        data-csid="${not empty vo.commentSid ? vo.commentSid : 0}"
                        data-dsid="${not empty vo.diarySid ? vo.diarySid : 0}"
                        data-fsid="${not empty vo.famousSid ? vo.famousSid : 0}"></td>
                      <td>#${vo.reportSid}</td>
                      <td><span class="type-badge">${vo.reportCategory == 10 ? '욕설' : (vo.reportCategory == 20 ? '음란' : (vo.reportCategory == 30 ? '홍보' : '기타'))}</span></td>
											<td onclick="openReportModal(
											    '${fn:escapeXml(vo.reportContent)}', 
											    '${fn:escapeXml(vo.diaryContent)}', 
											    '${not empty vo.diarySid ? vo.diarySid : 0}', 
											    '${not empty vo.commentSid ? vo.commentSid : 0}', 
											    '${not empty vo.famousSid ? vo.famousSid : 0}'
											)">
											    <div class="text-ellipsis clickable-reason">${vo.reportContent}</div>
											</td>
                      <td>${vo.regId}</td>
                      <td><button type="button" class="btn-admin-del"
                          onclick="deleteOneReport('${vo.reportSid}', '${vo.commentSid}', '${vo.diarySid}', '${vo.famousSid}')">삭제</button></td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="6" class="no-data">조회된 결과가 없습니다.</td>
                  </tr>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
          <div class="admin-pagination">
            <c:if test="${reportMaxPage > 0}">
              <c:set var="pb" value="5" />
              <c:set var="cp" value="${empty param.reportPage ? 1 : param.reportPage}" />
              <fmt:parseNumber var="cb" value="${(cp - 1) / pb}" integerOnly="true" />
              <c:set var="sp" value="${cb * pb + 1}" />
              <c:set var="ep" value="${sp + pb - 1}" />
              <c:if test="${ep > reportMaxPage}"><c:set var="ep" value="${reportMaxPage}" /></c:if>
              <c:if test="${sp > 1}">
                <a href="adminPage.do?menu=${menu}&reportPage=${sp-1}&searchDiv=${searchDiv}&searchWord=${searchWord}#section1" class="page-link">&lt;</a>
              </c:if>
              <c:forEach var="i" begin="${sp}" end="${ep}">
                <a href="adminPage.do?menu=${menu}&reportPage=${i}&searchDiv=${searchDiv}&searchWord=${searchWord}#section1" class="page-link ${cp == i ? 'active' : ''}">${i}</a>
              </c:forEach>
              <c:if test="${ep < reportMaxPage}">
                <a href="adminPage.do?menu=${menu}&reportPage=${ep+1}&searchDiv=${searchDiv}&searchWord=${searchWord}#section1" class="page-link">&gt;</a>
              </c:if>
            </c:if>
          </div>
        </div>
      </c:if>

      <%-- 2. 회원 관리 섹션 --%>
      <c:if test="${menu eq 'section2' || menu eq 'all'}">
        <div class="admin-table-card" id="section2">
          <div class="section-title"
            style="margin-bottom: 1.5rem; font-weight: 700;">
            <i data-lucide="users"
              style="color: #3b82f6; vertical-align: middle;"></i> 회원 정보 관리
          </div>
          <table class="custom-table">
            <colgroup>
              <col class="col-chk">
              <col class="col-user">
              <col class="col-content">
              <col class="col-mng">
            </colgroup>
            <thead>
              <tr>
                <th><input type="checkbox"
                  onclick="toggleAll(this, 'user-chk')"></th>
                <th>아이디</th>
                <th>닉네임</th>
                <th>관리</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${not empty userList}">
                  <c:forEach var="user" items="${userList}">
                    <tr>
                      <td><input type="checkbox" class="user-chk"
                        value="${user.userId}"></td>
                      <td>${user.userId}</td>
                      <td>${user.nickname}</td>
                      <td><button type="button" class="btn-admin-del"
                          onclick="deleteOne('user', '${user.userId}')">강퇴</button></td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="4" class="no-data">조회된 결과가 없습니다.</td>
                  </tr>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
          <div class="admin-pagination">
            <c:if test="${userMaxPage > 0}">
              <c:set var="pb" value="5" />
              <c:set var="cp" value="${empty param.userPage ? 1 : param.userPage}" />
              <fmt:parseNumber var="cb" value="${(cp - 1) / pb}" integerOnly="true" />
              <c:set var="sp" value="${cb * pb + 1}" />
              <c:set var="ep" value="${sp + pb - 1}" />
              <c:if test="${ep > userMaxPage}"><c:set var="ep" value="${userMaxPage}" /></c:if>
              <c:if test="${sp > 1}">
                <a href="adminPage.do?menu=${menu}&userPage=${sp-1}&searchDiv=${searchDiv}&searchWord=${searchWord}#section2" class="page-link">&lt;</a>
              </c:if>
              <c:forEach var="i" begin="${sp}" end="${ep}">
                <a href="adminPage.do?menu=${menu}&userPage=${i}&searchDiv=${searchDiv}&searchWord=${searchWord}#section2" class="page-link ${cp == i ? 'active' : ''}">${i}</a>
              </c:forEach>
              <c:if test="${ep < userMaxPage}">
                <a href="adminPage.do?menu=${menu}&userPage=${ep+1}&searchDiv=${searchDiv}&searchWord=${searchWord}#section2" class="page-link">&gt;</a>
              </c:if>
            </c:if>
          </div>
        </div>
      </c:if>

      <%-- 3. 게시글 관리 섹션 --%>
      <c:if test="${menu eq 'section3' || menu eq 'all'}">
        <div class="admin-table-card" id="section3">
          <div class="section-title"
            style="margin-bottom: 1.5rem; font-weight: 700;">
            <i data-lucide="files"
              style="color: #10b981; vertical-align: middle;"></i> 게시글 내역 관리
          </div>
          <table class="custom-table">
            <colgroup>
              <col class="col-chk">
              <col class="col-num">
              <col class="col-content">
              <col class="col-user">
              <col class="col-mng">
            </colgroup>
            <thead>
              <tr>
                <th><input type="checkbox"
                  onclick="toggleAll(this, 'diary-chk')"></th>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>관리</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${not empty diaryList}">
                  <c:forEach var="diary" items="${diaryList}">
                    <tr>
                      <td><input type="checkbox" class="diary-chk"
                        value="${diary.diarySid}"></td>
                      <td>${diary.diarySid}</td>
                      <td
                        onclick="openDiaryModal('상세', '${fn:escapeXml(diary.diaryTitle)}', '${fn:escapeXml(diary.diaryContent)}', '${diary.diarySid}')">
                        <div class="text-ellipsis clickable-reason">${diary.diaryTitle}</div>
                      </td>
                      <td>${diary.nickname}</td>
                      <td><button type="button" class="btn-admin-del"
                          onclick="deleteOne('diary', '${diary.diarySid}')">삭제</button></td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="5" class="no-data">조회된 결과가 없습니다.</td>
                  </tr>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
          <div class="admin-pagination">
            <c:if test="${diaryMaxPage > 0}">
              <c:set var="pb" value="5" />
              <c:set var="cp" value="${empty param.diaryPage ? 1 : param.diaryPage}" />
              <fmt:parseNumber var="cb" value="${(cp - 1) / pb}" integerOnly="true" />
              <c:set var="sp" value="${cb * pb + 1}" />
              <c:set var="ep" value="${sp + pb - 1}" />
              <c:if test="${ep > diaryMaxPage}"><c:set var="ep" value="${diaryMaxPage}" /></c:if>
              <c:if test="${sp > 1}">
                <a href="adminPage.do?menu=${menu}&diaryPage=${sp-1}&searchDiv=${searchDiv}&searchWord=${searchWord}#section3" class="page-link">&lt;</a>
              </c:if>
              <c:forEach var="i" begin="${sp}" end="${ep}">
                <a href="adminPage.do?menu=${menu}&diaryPage=${i}&searchDiv=${searchDiv}&searchWord=${searchWord}#section3" class="page-link ${cp == i ? 'active' : ''}">${i}</a>
              </c:forEach>
              <c:if test="${ep < diaryMaxPage}">
                <a href="adminPage.do?menu=${menu}&diaryPage=${ep+1}&searchDiv=${searchDiv}&searchWord=${searchWord}#section3" class="page-link">&gt;</a>
              </c:if>
            </c:if>
          </div>
        </div>
      </c:if>
    </div>
  </main>

  <script>
    var cp = "${pageContext.request.contextPath}";

    $(document).ready(function() {
      if (typeof lucide !== 'undefined')
        lucide.createIcons();
    });

    $(document).on('keydown', function(e) {
      if (e.key === 'Escape' || e.keyCode === 27) {
        if ($('#detailModal').is(':visible'))
          closeModal();
      }
    });

    function closeModal() {
      $('#detailModal').hide();
    }

    function toggleAll(obj, target) {
      $("." + target).prop("checked", $(obj).is(":checked"));
    }

    function openReportModal(reportContent, diaryContent, dSid, cSid, fSid) {
        function getValid(val) {
            if (!val || val === 'null' || val === '0' || val === 0 || val === 'undefined') return "";
            return String(val).trim();
        }
        var diarySid = getValid(dSid);
        var commentSid = getValid(cSid);
        var famousSid = getValid(fSid);

        console.log("매칭 분석 -> 일기ID:", diarySid, "댓글ID:", commentSid, "명언ID:", famousSid);

        var detailUrl = "";
        var buttonText = "";

        // 명언 관련 링크 생성
        if (famousSid !== "") {
            detailUrl = cp + "/famous/getFamousDetail.do?famousSid=" + famousSid;
            buttonText = (commentSid !== "") ? "신고된 댓글의 명언 보기" : "원본 명언 보기";
        } 
        // 일기 관련 링크 생성
        else if (diarySid !== "") {
            detailUrl = cp + "/diary/doSelectOne.do?diarySid=" + diarySid;
            buttonText = (commentSid !== "") ? "신고된 댓글의 일기 보기" : "원본 일기 보기";
        }

        var html = '<div style="padding:13px; background:#fff1f2; border-radius:10px; margin-bottom:15px;">'
                 + '<b>신고 사유 : </b><span style="color: #ef4444; font-weight: bold;">' + (reportContent || "사유 없음") + '</span></div>'
                 + '<div style="padding:15px; background:#f8fafc; border-radius:10px; border: 1px solid #e2e8f0; margin-bottom:15px;">'
                 + '<b style="color: #64748b; font-size: 0.9rem;">대상 본문 :</b>'
                 + '<pre style="white-space:pre-wrap; margin-top:8px;">' + (diaryContent || "내용 없음") + '</pre></div>';

        if (detailUrl !== "") {
            html += '<a href="' + detailUrl + '" target="_blank" class="btn-search" style="display:block; text-align:center; padding: 12px; background-color: #3b82f6; color: white; border-radius: 10px; text-decoration: none; font-weight: bold;">' + buttonText + '</a>';
        } else {
            html += '<div style="text-align:center; color:#94a3b8; padding:10px; border:1px dashed #cbd5e1;">원본 데이터를 찾을 수 없습니다.</div>';
        }

        $('#modalBody').html(html);
        $('#detailModal').css('display', 'flex');
    }

    function openDiaryModal(title, sub, content, diarySid) {
      $('#modalTitle').text(sub || "상세 정보");
      var html = '<div style="padding:15px; background:#f8fafc; border-radius:10px; border: 1px solid #e2e8f0;"><pre style="white-space:pre-wrap;">'
          + (content || "내용 없음")
          + '</pre></div>'
          + '<a href="' + cp + '/diary/doSelectOne.do?diarySid=' + diarySid
          + '" target="_blank" class="btn-search" style="display:block; text-align:center; margin-top:15px; text-decoration:none;">게시글 바로가기</a>';
      $('#modalBody').html(html);
      $('#detailModal').css('display', 'flex');
    }

    async function deleteSelected() {
        const checkedBoxes = $(".report-chk:checked");
        if (checkedBoxes.length === 0) return alert("선택된 항목이 없습니다.");
        if (!confirm(`선택한 ${checkedBoxes.length}건을 일괄 삭제하시겠습니까?`)) return;

        let successCount = 0;
        let failCount = 0; // 오타 수정 완료

        for (let i = 0; i < checkedBoxes.length; i++) {
            const $chk = $(checkedBoxes[i]);
            const id = $chk.val();
            try {
                await $.ajax({
                    type: "POST",
                    url: cp + "/admin/doDeleteReport.do",
                    data: {
                        reportSid: id,
                        commentSid: $chk.data('csid') || 0,
                        diarySid: $chk.data('dsid') || 0,
                        famousSid: $chk.data('fsid') || 0
                    }
                });
                successCount++;
            } catch (err) {
                failCount++;
            }
        }
        alert(`성공: ${successCount}건 / 실패: ${failCount}건`);
        location.reload();
    }

    function deleteOneReport(rSid, cSid, dSid, fSid) {
      if (!confirm("정말 처리하시겠습니까?"))
        return;
      $.ajax({
        type : "POST",
        url : cp + "/admin/doDeleteReport.do",
        data : {
          reportSid : rSid,
          commentSid : cSid,
          diarySid : dSid,
          famousSid : fSid
        },
        success : function() {
          alert("처리되었습니다.");
          location.reload();
        },
        error : function() {
          alert("오류 발생");
        }
      });
    }

    function deleteOne(type, id) {
      if (!confirm("정말 처리하시겠습니까?"))
        return;
      var url = cp + "/admin/doDelete" + type.charAt(0).toUpperCase() + type.slice(1) + ".do";
      var data = (type === 'user') ? { userId : id } : { diarySid : id };
      $.ajax({
        type : "POST",
        url : url,
        data : data
      }).done(function(res) {
        alert(res);
        location.reload();
      });
    }

    function doLogout() {
      if (confirm("로그아웃 하시겠습니까?"))
        location.href = cp + "/user/doLogout.do";
    }
  </script>
</body>
</html>