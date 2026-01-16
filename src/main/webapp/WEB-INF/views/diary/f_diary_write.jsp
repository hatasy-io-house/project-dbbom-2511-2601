<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>명언일기 | 작성하기</title>
    <script src="https://unpkg.com/lucide@latest"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/cmn/jquery.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/f_diary_write.css"/>
    <!-- <link rel="stylesheet" href="../css/common.css" /> -->

	<script>
	document.addEventListener("DOMContentLoaded", () => {

    	  // Lucide 아이콘 초기화
    	  if (typeof lucide !== "undefined") {
    	    lucide.createIcons();
    	  }

    	  // 메뉴 탭 클릭 이벤트
    	  const tabButtons = document.querySelectorAll(".tab-btn");
    	  tabButtons.forEach((button) => {
    	    button.addEventListener("click", () => {
    	      tabButtons.forEach((btn) =>
    	        btn.setAttribute("aria-selected", "false")
    	      );
    	      button.setAttribute("aria-selected", "true");
    	    });
    	  });

    	  // 일기 등록 버튼 이벤트
    	  document.getElementById("savefDiary").addEventListener("click", () => {
    	    const titleInput = document.querySelector("#diaryTitle");
    	    const contentInput = document.querySelector("#diaryContent");

    	    const title = titleInput.value.trim();
    	    const content = contentInput.value.trim();

    	    // 제목 검사
    	    if (title === "") {
    	      alert("제목을 입력해주세요");
    	      titleInput.focus();
    	      return;
    	    }

    	    // 내용 검사
    	    if (content === "") {
    	      alert("내용을 작성해주세요");
    	      contentInput.focus();
    	      return;
    	    }

    	    // 공개/비공개
    	    const diaryStatus = document.querySelector(
    	      'input[name="diaryStatus"]:checked'
    	    )?.value || "N";

				const showFamous = document.querySelector('input[name="showFamous"]:checked')?.value === "true";
				const param = {
					diaryTitle: title,
					diaryContent: content,
					diaryStatus: diaryStatus,
					diaryCategory: 10, // 임시값 또는 선택값
					regId: loginUserId, // 임시값 또는 실제 로그인 사용자 ID
					showFamous: showFamous
				};

				$.ajax({
					url: "/ehr/diary/diarySave.do",
					type: "POST",
					data: param,
					dataType: "json",
					success: function(res) {
						if(res.flag === 1){
							alert(res.message);
							if(showFamous && res.famousVO){
								// 명언 보기 선택 시 end 페이지로 이동 (명언 정보 전달)
								<%-- sessionStorage.setItem("famousVO", JSON.stringify(res.famousVO)); --%>
								    location.href = "/ehr/diary/fDiaryEnd.do?famousSid=" + res.famousVO.famousSid;
							}else{
								// 명언 안보기면 리스트로 이동
								
								location.href = "/ehr/diary/diaryList.do";
							}
						}else{
							alert("실패: " + res.message);
						}
					},
					error: function() {
						alert("통신 실패");
					}
				});

				// 입력값 초기화
				titleInput.value = "";
				contentInput.value = "";

				document
					.querySelectorAll('input[name="diaryStatus"]')
					.forEach((radio) => (radio.checked = false));


    	  });
    	});

    </script>
  <jsp:include page="/WEB-INF/views/main/menu.jsp" />
  </head>
  <body>
    <main class="container">
      <div class="card diary-card" style="margin-top: 20px">
        <div class="diary-st">
          <span class="icon-circle">
            <i data-lucide="quote"></i>
          </span>
          <span class="diary-title-text">오늘의 흔적</span>
        </div>

        <div class="diary-header flex-between">
          <input
            type="text"
            class="diary-title"
			id="diaryTitle" name="diaryTitle"
            placeholder="제목을 입력하세요"
          />
        </div>

        <textarea
          class="diary-content"
		  id="diaryContent" name="diaryContent"
          placeholder="오늘의 일기를 작성해보세요"
        ></textarea>

        <div class="diary-footer">
					<div class="radio-group">
						<label class="radio-label">
							<input type="radio" name="diaryStatus" value="Y" /> 공개
						</label>
						<label class="radio-label">
							<input type="radio" name="diaryStatus" value="N" /> 비공개
						</label>
					</div>
					<div class="radio-group" style="margin-top:10px;">
						<label class="radio-label">
							<input type="radio" name="showFamous" value="true"  /> 명언 보기
						</label>
						<label class="radio-label">
							<input type="radio" name="showFamous" value="false" checked/> 명언 안보기
						</label>
					</div>
					<button class="diary-btn" id="savefDiary" type="button">등록</button>
        </div>
      </div>
    </main>

    <script src="https://unpkg.com/lucide@latest"></script>


    <script>
      lucide.createIcons();
    </script>
  </body>
</html>
