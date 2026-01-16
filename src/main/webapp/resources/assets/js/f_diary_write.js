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

    	    const param = {
    	      diaryTitle: title,
    	      diaryContent: content,
    	      diaryStatus: diaryStatus,
    	      diaryCategory: 10, // 임시값 또는 선택값
    	      regId: "user01" // 임시값 또는 실제 로그인 사용자 ID
    	    };

    	    $.ajax({
    	      url: "/ehr/diary/diarySave.do",
    	      type: "POST",
    	      data: param,
    	      dataType: "json",
    	      success: function(res) {
    	        if(res.flag === 1){
    	          alert(res.message);
    	          location.href = "/ehr/diary/diaryList.do";
    	        }else{
    	          alert("실패: " + res.message);
    	        }
    	      },
    	      error: function() {
    	        alert("통신 실패");
    	      }
    	    });

    	    alert("일기가 등록되었습니다!");

    	    // 입력값 초기화
    	    titleInput.value = "";
    	    contentInput.value = "";

    	    document
    	      .querySelectorAll('input[name="diaryStatus"]')
    	      .forEach((radio) => (radio.checked = false));


    	  });
    	});
