// report.js

// 문서가 로딩된 후 버튼 이벤트 연결
document.addEventListener("DOMContentLoaded", () => {
  // [신고하기] 폼 submit 이벤트 가로채기 (AJAX 전송)
  const reportForm = document.getElementById("reportForm");
  if (reportForm) {
    reportForm.addEventListener("submit", function(e) {
      e.preventDefault();
      const formData = new FormData(reportForm);
      const params = new URLSearchParams();
      for (const [key, value] of formData.entries()) {
        params.append(key, value);
      }
      fetch(reportForm.action, {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: params
      })
      .then(response => response.json())
      .then(data => {
        if (data.result) {
          alert("신고되었습니다");
          window.close();
        } else {
          alert(data.msg);
        }
      })
      .catch(() => {
        alert("신고 처리 중 오류가 발생했습니다.");
      });
    });
  }

  // [닫기] 버튼 찾기 & 클릭 이벤트 연결
  const closeBtn = document.querySelector(".btn-close");
  if (closeBtn) {
    closeBtn.addEventListener("click", () => {
      window.close();
    });
  }
});

// 기존 submitReport 함수는 더 이상 사용하지 않음
