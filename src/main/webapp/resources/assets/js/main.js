// document.addEventListener("DOMContentLoaded", () => {
//   // 1. 감사 일기(gratitude) 카드 찾기
//   const gratitudeCard = document.querySelector(".diary-card.gratitude");

//   // 2. 카드가 있으면 클릭 이벤트 연결
//   if (gratitudeCard) {
//     // 마우스 올렸을 때 손가락 모양 (CSS 보완)
//     gratitudeCard.style.cursor = "pointer";

//     gratitudeCard.addEventListener("click", () => {
//       // 3. 팝업 열기 함수 실행
//       // openReportPopup();
//     });
//   }
// });

// function openReportPopup() {
//   const popupWidth = 600;
//   const popupHeight = 550;

//   // 화면 중앙 위치 계산
//   const popupX = window.screen.width / 2 - popupWidth / 2;
//   const popupY = window.screen.height / 2 - popupHeight / 2;

//   const options = `status=no, height=${popupHeight}, width=${popupWidth}, left=${popupX}, top=${popupY}, resizable=no`;

//   // ★ 주의: 방금 성공하셨던 파일 경로를 그대로 쓰세요!
//   // (같은 폴더면 "reportpage.html", 폴더가 다르면 "../html/reportpage.html")
//   window.open("../html/reportpage.html", "ReportWindow", options);
// }
