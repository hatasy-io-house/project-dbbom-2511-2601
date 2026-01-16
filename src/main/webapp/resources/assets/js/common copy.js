/* javascript/common.js - 경로 문제 해결 버전 */

document.addEventListener("DOMContentLoaded", () => {
  // 1. Lucide 아이콘 실행
  if (window.lucide) {
    lucide.createIcons();
  }

  // 2. 현재 페이지의 '파일 이름'만 추출합니다. (예: /html/notice.html -> notice.html)
  // 주소창에 경로가 아무리 복잡하게 찍혀도 마지막 파일명만 가져옵니다.
  const currentFile = window.location.pathname.split("/").pop();

  // 3. 모든 탭 버튼(.tab-btn)을 가져옵니다.
  const tabButtons = document.querySelectorAll(".tab-list .tab-btn");

  tabButtons.forEach((btn) => {
    const href = btn.getAttribute("href");

    // href가 없거나 #인 경우는 건너뜁니다.
    if (!href || href === "#") return;

    // 4. 버튼에 적힌 링크에서도 '파일 이름'만 추출합니다.
    // (예: ../html/notice.html -> notice.html)
    const linkFile = href.split("/").pop();

    // 5. 파일 이름이 서로 똑같다면 active 클래스 추가 (파란색 변경)
    if (currentFile === linkFile) {
      btn.classList.add("active");
    }

    // 6. [게시판 예외 처리]
    // 현재 보고 있는 파일이 'board_'로 시작하고 (예: board_quotes.html)
    // 탭 버튼의 목적지가 'board_diary.html' (게시판 메인 탭)이라면 활성화
    if (currentFile.startsWith("board_") && linkFile === "board_diary.html") {
      btn.classList.add("active");
    }
  });

  console.log("Common JS Loaded & Tabs Activated (File Match Mode)");
  
});
