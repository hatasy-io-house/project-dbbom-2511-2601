// 아이콘 렌더링 실행
lucide.createIcons();

// [탭 전환 기능 스크립트]
function switchCustomTab(targetId, event) {
  // 1. 모든 탭 내용 숨기기
  const contents = document.querySelectorAll(".wf-tab-content");
  contents.forEach((content) => content.classList.remove("active"));

  // 2. 모든 탭 버튼 활성화 상태 제거
  const buttons = document.querySelectorAll(".wf-tab-btn");
  buttons.forEach((btn) => {
    btn.classList.remove("active");
    // 아이콘 색상 초기화 (비활성 상태)
    const icon = btn.querySelector("i");
    if (icon) icon.style.color = "#999";
  });

  // 3. 선택된 탭 내용 보이기 & 버튼 활성화
  document.getElementById(targetId).classList.add("active");
  event.currentTarget.classList.add("active");

  // 활성화된 버튼의 아이콘 색상 변경
  const activeIcon = event.currentTarget.querySelector("i");
  if (activeIcon) activeIcon.style.color = "#4a90e2";

  // 아이콘 다시 렌더링 (동적 변경 시 필요할 수 있음)
  lucide.createIcons();
}
