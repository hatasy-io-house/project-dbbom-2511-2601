<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pcwk.ehr.user.domain.UserVO"%>
<%
    // 세션에서 로그인 정보 가져오기
    UserVO loginUser = (UserVO) session.getAttribute("loginUser");
    
    // 데이터 안전하게 추출
    String userId    = (loginUser != null) ? loginUser.getUserId() : "";
    String userName  = (loginUser != null) ? loginUser.getUserName() : "";
    String userEmail = (loginUser != null) ? loginUser.getUserEmail() : "";
    String nickname  = (loginUser != null) ? loginUser.getNickname() : "";
    String userIntro = (loginUser != null) ? loginUser.getUserIntro() : "";
   
    String displayName = (nickname != null && !nickname.isEmpty()) ? nickname : userId;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>내면의 흔적 - 마이페이지</title>

<script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/mypage.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/js/mypage_diary_list.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/mypage_diary_list.css" />
<style>
    .withdraw-box { text-align: center; padding: 40px 20px; }
    .withdraw-warning { background: #fff5f5; border: 1px solid #feb2b2; padding: 20px; border-radius: 8px; margin-bottom: 25px; color: #c53030; }
    .withdraw-warning ul { text-align: left; display: inline-block; margin-top: 10px; }
    .btn-withdraw-final { background-color: #e53e3e; color: white; border: none; padding: 12px 24px; border-radius: 6px; cursor: pointer; font-weight: bold; transition: 0.3s; }
    .btn-withdraw-final:hover { background-color: #c53030; }
    
    /* 비밀번호 변경 폼 스타일 전용 */
    .user-edit-form .form-row small { display: block; margin-top: 5px; color: #e53e3e; }
    
		    /* 비밀번호 변경 폼 스타일 수정 */
		.user-edit-form .form-row {
		    flex-wrap: wrap; /* 내부 요소가 넘치면 다음 줄로 넘어가도록 설정 */
		    align-items: center;
		}
		
		.user-edit-form .form-row label {
		    flex: 0 0 120px; /* 라벨 너비 고정 (기존 스타일에 맞춰 조절하세요) */
		}
		
		.user-edit-form .form-row input {
		    flex: 1; /* 인풋이 남은 공간 차지 */
		}
		
		.user-edit-form .form-row small {
		    display: block;
		    width: 100%; /* 너비를 100%로 주어 강제로 다음 줄로 이동 */
		    margin-top: 5px;
		    margin-left: 120px; /* 라벨 너비만큼 왼쪽 여백을 주어 인풋 아래에 맞춤 */
		    font-size: 0.85em;
					/* 신규 이동 버튼 스타일 */
		}
</style>
</head>

<body>
    <jsp:include page="/WEB-INF/views/main/menu.jsp" />

    <main class="container">

        <div class="tab-content mypage-content">
            <div class="wf-container">
                <section class="wf-card wf-profile-header">
                    <div class="wf-user-info-group">
                        <div class="wf-profile-img"></div>
                        <div class="wf-user-info">
                            <h2><%=displayName%></h2>
                            <p><i data-lucide="quote" size="12" style="margin-right: 5px; color: #999"></i> 
                               <span id="displayIntro"><%= (userIntro != null && !userIntro.isEmpty()) ? userIntro : "오늘도 나를 돌아보는 시간, 참 소중해요." %></span>
                            </p>
                        </div>
                    </div>
                    <div class="wf-stats-group">
										    <div class="wf-stat-card">
										        <i data-lucide="book" size="20" color="#4A90E2"></i> 
										        <span class="wf-stat-label">총 일기 수</span> 
										        <span class="wf-stat-value">${not empty totalCount ? totalCount : 0}</span>
										    </div>
										    <div class="wf-stat-card">
										        <i data-lucide="calendar-check" size="20" color="#2ECC71"></i> 
										        <span class="wf-stat-label">이번 달 작성</span> 
										        <span class="wf-stat-value">${not empty monthCount ? monthCount : 0}</span>
										    </div>
										</div>
                </section>

                <section>
                    <div class="wf-tab-menu">
                        <button class="wf-tab-btn active" onclick="switchCustomTab('my-diary', event)">
                            <i data-lucide="book-open-text" size="18"></i> 내 일기
                        </button>
                        <button class="wf-tab-btn" onclick="switchCustomTab('my-info', event)">
                            <i data-lucide="user-cog" size="18"></i> 내 정보 관리
                        </button>
                        <button class="wf-tab-btn" onclick="switchCustomTab('change-password', event)">
                            <i data-lucide="lock" size="18"></i> 비밀번호 변경
                        </button>
                        <button class="wf-tab-btn" onclick="switchCustomTab('withdraw-user', event)" style="color: #e53e3e;">
                            <i data-lucide="user-minus" size="18"></i> 회원탈퇴
                        </button>
                    </div>

                    <div class="wf-card wf-content-box">
                        <div id="my-diary" class="wf-tab-content active">
                            <div class="content-header">
                                <div class="content-title"><i data-lucide="history" color="#4A90E2"></i> 나의 일기목록</div>
                            </div>
                            <div class="diary-container">
                                <div class="diary-top-card">
                                    <div class="calendar">
                                        <div class="calendar-header flex-center" style="gap: 20px; margin-bottom: 25px;">
																				    <button type="button" id="prevMonth" class="month-btn">
																				        <i data-lucide="chevron-left"></i>
																				    </button>
																				    
																				    <h3 id="currentMonthText">2025년 11월</h3>
																				    
																				    <button type="button" id="nextMonth" class="month-btn">
																				        <i data-lucide="chevron-right"></i>
																				    </button>
																				</div>
                                        <div class="calendar-grid" id="calendar"></div>
                                    </div>
                                    <div class="diary-list">
                                        <h3 id="selectedDate">날짜를 선택하세요</h3>
                                        <ul id="diaryTypeList"></ul>
                                    </div>
                                </div>
                                <div class="diary-content-card">
                                    <p id="diaryContent">일기를 선택하면 내용이 표시됩니다 :)</p>
                                </div>
                            </div>
                        </div>

                        <div id="my-info" class="wf-tab-content">
                            <div class="content-header">
                                <div class="content-title"><i data-lucide="settings" color="#4A90E2"></i> 계정 및 정보 설정</div>
                            </div>
                            <form class="user-edit-form" id="userEditForm">
                                <div class="form-row"><label>아이디</label> <input type="text" value="<%=userId%>" readonly /></div>
                                <div class="form-row">
                                    <label>닉네임</label>
                                    <div class="inline-row">
                                        <input type="text" id="nickname" name="nickname" value="<%=nickname%>" />
                                        <button type="button" class="check-btn" onclick="checkNickname()">중복확인</button>
                                    </div>
                                    <small id="nicknameMsg"></small>
                                </div>
                                <div class="form-row">
                                    <label>자기소개</label>
                                    <textarea id="intro" name="userIntro" rows="3"><%=userIntro%></textarea>
                                </div>
                                <div class="form-row"><label>이름</label> <input type="text" value="<%=userName%>" readonly /></div>
                                <div class="form-row"><label>이메일</label> <input type="email" value="<%=userEmail%>" readonly /></div>
                                <div class="form-actions"><button type="submit" class="save-btn">정보 수정</button></div>
                            </form>
                        </div>

                        <%-- (이전 코드 동일) --%>

												<div id="change-password" class="wf-tab-content">
												    <div class="content-header">
												        <div class="content-title"><i data-lucide="shield-check" color="#4A90E2"></i> 비밀번호 변경</div>
												    </div>
												    <form class="user-edit-form" id="pwChangeForm">
												        <div class="form-row">
												            <label>기존 비밀번호</label>
												            <input type="password" id="oldPw" name="oldPw" placeholder="현재 비밀번호를 입력하세요" required />
												        </div>
												        <div class="form-row">
												            <label>새 비밀번호</label>
												            <input type="password" id="newPw" name="newPw" placeholder="새 비밀번호를 입력하세요" required />
												        </div>
												        
												        <div class="form-row" style="margin-bottom: 0;">
												            <label>새 비밀번호 확인</label>
												            <input type="password" id="newPwConfirm" placeholder="새 비밀번호를 다시 입력하세요" required />
												        </div>
												        <div class="form-row" style="min-height: 20px; padding-top: 0;">
												            <div style="flex: 0 0 120px;"></div> <small id="pwMatchMsg" style="display: block; transition: all 0.3s;"></small>
												        </div>
												
												        <div class="form-actions">
												            <button type="button" id="btnUpdatePw" class="save-btn">비밀번호 변경</button>
												        </div>
												    </form>
												</div>

<%-- (이하 스크립트 코드 동일) --%>

                        <div id="withdraw-user" class="wf-tab-content">
                            <div class="content-header">
                                <div class="content-title"><i data-lucide="user-x" color="#e53e3e"></i> 회원 탈퇴 안내</div>
                            </div>
                            <div class="withdraw-box">
                                <div class="withdraw-warning">
                                    <strong>정말로 탈퇴하시겠습니까?</strong><br>
                                    <ul>
                                        <li>탈퇴 시 모든 데이터와 활동 내역이 즉시 삭제됩니다.</li>
                                        <li>삭제된 데이터는 복구되지 않습니다.</li>
                                    </ul>
                                </div>
                                <button type="button" class="btn-withdraw-final" id="doWithdraw">회원 탈퇴하기</button>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <footer>
        <div class="container">
            <p>© 2024 내면의 흔적. All rights reserved.</p>
        </div>
    </footer>

    <script>
$(document).ready(function() {
    lucide.createIcons();

    // 1. 비밀번호 변경 로직
    $('#btnUpdatePw').on('click', function() {
        let oldPw = $('#oldPw').val();
        let newPw = $('#newPw').val();
        let confirmPw = $('#newPwConfirm').val();

        if(!oldPw) { alert("기존 비밀번호를 입력하세요."); return; }
        if(!newPw) { alert("새 비밀번호를 입력하세요."); return; }
        if(newPw !== confirmPw) {
            alert("새 비밀번호 재입력이 일치하지 않습니다.");
            return;
        }

        if(!confirm("비밀번호를 변경하시겠습니까?")) return;

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/user/doUpdatePwAjax.do",
            data: { "oldPw": oldPw, "newPw": newPw },
            dataType: "json",
            success: function(res) {
                alert(res.message);
                if(res.flag == 1) {
                    location.reload(); 
                }
            },
            error: function() { alert("서버 통신 오류가 발생했습니다."); }
        });
    });

    // 2. 실시간 비밀번호 일치 확인
    $('#newPwConfirm').on('keyup', function() {
        if($('#newPw').val() === $(this).val()) {
            $('#pwMatchMsg').text("비밀번호가 일치합니다.").css("color", "green");
        } else {
            $('#pwMatchMsg').text("비밀번호가 일치하지 않습니다.").css("color", "#e53e3e");
        }
    });
    
    // 3. 내 정보 수정 로직 (AJAX)
    $('#userEditForm').on('submit', function(e) {
        e.preventDefault(); 

        let nickname = $('#nickname').val();
        let intro = $('#intro').val();

        if(!nickname) {
            alert("닉네임을 입력해주세요.");
            return;
        }

        if(!confirm("정보를 수정하시겠습니까?")) return;

        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/user/doUpdateInfoAjax.do",
            data: {
                "nickname": nickname,
                "userIntro": intro
            },
            dataType: "json",
            success: function(res) {
                alert(res.message);
                if(res.flag == 1) {
                    location.reload(); 
                }
            },
            error: function() {
                alert("서버 통신 오류가 발생했습니다.");
            }
        });
    });
}); // document.ready 종료

// --- 함수 정의 영역 (ready 바깥에 두는 것이 관리하기 편합니다) ---

// 닉네임 중복 체크 함수
function checkNickname() {
    let nickname = $('#nickname').val();
    if(!nickname) {
        alert("중복 확인을 할 닉네임을 입력하세요.");
        return;
    }
    // 현재는 알림창만 띄움 (추후 AJAX 연동 가능)
    alert("사용 가능한 닉네임입니다.");
} // 여기서 }); 가 아니라 } 로 끝나야 합니다.

// 탭 전환 함수
function switchCustomTab(tabId, event) {
    $('.wf-tab-content').removeClass('active');
    $('.wf-tab-btn').removeClass('active');

    $('#' + tabId).addClass('active');
    $(event.currentTarget).addClass('active');
}
</script>
</body>
</html>