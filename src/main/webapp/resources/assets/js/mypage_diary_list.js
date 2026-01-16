document.addEventListener("DOMContentLoaded", () => {
  // 1️⃣ 전역 변수 설정
  let diaryData = {}; // 서버에서 받아온 실제 일기 데이터를 저장할 공간

  // 2️⃣ 카테고리 숫자 매핑 (DB 값 기준: 10, 20, 30, 40)
  const diaryTypeClass = {
    "10": "purple", // 명언일기
    "20": "green", // 행운일기
    "30": "yellow",  // 감사일기
    "40": "blue"    // 성찰일기 (하늘색)
  };

  const calendar = document.getElementById("calendar");
  const monthText = document.getElementById("currentMonthText"); // JSP에 id="currentMonthText" 확인
  
  // 현재 날짜 기준으로 초기화
  let currentYear = new Date().getFullYear();
  let currentMonth = new Date().getMonth() + 1;

  /**
   * 3️⃣ 서버에서 월별 일기 데이터 가져오기 (AJAX)
   */
  async function fetchMonthData(year, month) {
    const monthStr = `${year}-${String(month).padStart(2, "0")}`;
    
    $.ajax({
      type: "GET",
      url: "/ehr/diary/selectMonthDiary.do", // 프로젝트 Context Path에 맞춰 수정 필요
      data: { "diaryUploadDate": monthStr },
      dataType: "json",
      success: function(res) {
        diaryData = {}; // 데이터 초기화
        
        // 서버에서 온 데이터(res)를 diaryData 객체에 날짜별로 정리
        res.forEach(item => {
          const date = item.diaryUploadDate; // DB에서 포맷팅된 'YYYY-MM-DD'
          if (!diaryData[date]) diaryData[date] = [];
          
          diaryData[date].push({
            sid: item.diarySid,  // <-- 이 부분이 추가되어야 5번 함수에서 이동할 때 사용 가능합니다!
            title: item.diaryTitle,
            type: String(item.diaryCategory),
            content: item.diaryContent
          });
        });
        
        // 데이터를 모두 정리한 후 달력을 렌더링
        renderCalendar(year, month);
      },
      error: function(xhr, status, error) {
        console.error("일기 데이터를 불러오는 중 오류 발생:", error);
        // 오류가 나더라도 달력은 그려줌
        renderCalendar(year, month);
      }
    });
  }

  /**
   * 4️⃣ 달력 렌더링 함수
   */
  function renderCalendar(year, month) {
    if (!calendar) return;
    if (monthText) monthText.textContent = `${year}년 ${month}월`;

    calendar.innerHTML = ""; 

    const firstDay = new Date(year, month - 1, 1).getDay();
    const lastDate = new Date(year, month, 0).getDate();

    // 빈 칸 생성
    for (let i = 0; i < firstDay; i++) {
      const emptyDiv = document.createElement("div");
      emptyDiv.className = "day empty"; 
      calendar.appendChild(emptyDiv);
    }

    // 날짜 생성
    for (let day = 1; day <= lastDate; day++) {
      const dateStr = `${year}-${String(month).padStart(2, "0")}-${String(day).padStart(2, "0")}`;
      const div = document.createElement("div");
      div.className = "day";
      div.textContent = day;

      // 해당 날짜에 일기가 있으면 강조 표시
      if (diaryData[dateStr]) {
        div.classList.add("has-diary");
      }

      div.addEventListener("click", () => selectDate(dateStr, div));
      calendar.appendChild(div);
    }
    
    // 월 이동 시 오른쪽 영역 초기화
    const list = document.getElementById("diaryTypeList");
    const contentArea = document.getElementById("diaryContent");
    if(list) list.innerHTML = "<p class='no-data'>날짜를 선택하세요</p>";
    if(contentArea) contentArea.textContent = "달력에서 날짜를 선택하면 일기 내용이 여기에 표시됩니다.";
  }


/**
   * 5️⃣ 날짜 선택 시 일기 제목 목록 표시 (핵심 변경 부분)
   */
  function selectDate(date, element) {
    document.querySelectorAll(".day").forEach(d => d.classList.remove("active"));
    element.classList.add("active");

    const selectedDateElem = document.getElementById("selectedDate");
    if (selectedDateElem) selectedDateElem.textContent = date;

    const list = document.getElementById("diaryTypeList");
    list.innerHTML = ""; 

    if (diaryData[date]) {
      diaryData[date].forEach(diary => {
        const li = document.createElement("li");
        li.className = "diary-item-container";
        
        const colorClass = diaryTypeClass[diary.type] || "blue"; 
        
        // [변경 포인트] 구조를 diary-btn-group으로 묶어 하나의 알약 모양 버튼 세트로 만듦
        li.innerHTML = `
          <div class="diary-btn-group">
            <button class="diary-item-btn ${colorClass}" title="${diary.title}">
              ${diary.title}
            </button>
            <button class="diary-move-btn">
              <span>상세</span>
              <i data-lucide="arrow-right" style="width: 14px; height: 14px;"></i>
            </button>
          </div>
        `;

        // 왼쪽 제목 버튼 클릭 시: 하단에 미리보기 내용 표시
        const titleBtn = li.querySelector(".diary-item-btn");
        titleBtn.addEventListener("click", () => {
          list.querySelectorAll(".diary-item-btn").forEach(btn => btn.classList.remove("selected"));
          titleBtn.classList.add("selected");
          
          const contentArea = document.getElementById("diaryContent");
          if(contentArea) {
              contentArea.textContent = diary.content;
              contentArea.style.whiteSpace = "pre-wrap"; 
          }
        });

        // 오른쪽 '상세보기' 버튼 클릭 시: 상세 페이지(SelectOne)로 이동
        const moveBtn = li.querySelector(".diary-move-btn");
        moveBtn.addEventListener("click", (e) => {
          e.stopPropagation(); // 부모 요소인 li나 제목 버튼으로 클릭 이벤트가 전달되는 것을 막음
          if(confirm("해당 일기 상세 페이지로 이동하시겠습니까?")) {
              location.href = `/ehr/diary/doSelectOne.do?diarySid=${diary.sid}`;
          }
        });

        list.appendChild(li);
      });
      // 동적으로 생성된 아이콘 활성화
      if (window.lucide) lucide.createIcons();
    } else {
      list.innerHTML = "<p class='no-data'>작성된 일기가 없습니다.</p>";
      const contentArea = document.getElementById("diaryContent");
      if(contentArea) contentArea.textContent = "해당 날짜에 기록된 내용이 없습니다.";
    }
  }

  /**
   * 6️⃣ 월 이동 버튼 이벤트 리스너
   */
  document.getElementById("prevMonth").addEventListener("click", () => {
    currentMonth--;
    if (currentMonth < 1) { currentMonth = 12; currentYear--; }
    fetchMonthData(currentYear, currentMonth);
  });

  document.getElementById("nextMonth").addEventListener("click", () => {
    currentMonth++;
    if (currentMonth > 12) { currentMonth = 1; currentYear++; }
    fetchMonthData(currentYear, currentMonth);
  });

  // 초기 실행: 현재 월의 데이터를 가져옴
  fetchMonthData(currentYear, currentMonth);
  
  // Lucide 아이콘 렌더링
  if (window.lucide) {
    lucide.createIcons();
  }
});