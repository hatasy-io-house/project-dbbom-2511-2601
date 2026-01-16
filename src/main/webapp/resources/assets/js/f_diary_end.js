// document.addEventListener("DOMContentLoaded", () => {
//   const summaryArea = document.getElementById("summaryArea");

//   // 1. Lucide 아이콘 초기화 (DOM 로드 후 실행)
//   if (typeof lucide !== "undefined") {
//     lucide.createIcons();
//   }

//   // 2. 탭 전환 기능
//   const tabButtons = document.querySelectorAll(".tab-btn");
//   const tabContents = document.querySelectorAll(".tab-content");

//   tabButtons.forEach((button) => {
//     button.addEventListener("click", () => {
//       const targetTab = button.getAttribute("data-tab");

//       // 2-1. 버튼 활성화 상태 업데이트 (ARIA 속성 활용)
//       tabButtons.forEach((btn) => btn.setAttribute("aria-selected", "false"));
//       button.setAttribute("aria-selected", "true");

//       // 2-2. 탭 내용 표시/숨김 업데이트
//       tabContents.forEach((content) => {
//         content.classList.remove("active");
//         if (content.id === targetTab) {
//           content.classList.add("active");
//         }
//       });
//     });
//   });
// });
// summaryArea.innerHTML = `
//   <p>하루의 감정이 복잡하게 얽혀 있었어요.</p>
//   <p>그래도 스스로를 돌아보는 시간이 되었어요.</p>
//   <p>조금은 가벼워진 마음으로 하루를 마무리합니다.</p>
// `;
