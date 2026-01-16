// javascript/board.js
document.addEventListener("DOMContentLoaded", () => {
    console.log("📝 Board JS Loaded");
    
    // (예시) 게시글 클릭 시 이벤트
    const rows = document.querySelectorAll('.board-row');
    rows.forEach(row => {
        row.addEventListener('click', () => {
            console.log("게시글 클릭됨!");
            // 나중에 상세 페이지 이동 로직 작성
        });
    });
});