<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My WebApp - 서비스 개요</title>
    <style>
        /* CSS 스타일 정의 */
        .container {
            width: 800px;
            margin: 20px auto;
            padding: 10px;
            background-color: #e0e0e0; /* 회색 배경 */
            border: 1px solid #c0c0c0;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
        }

        .blue-box {
            background-color: #4a90e2;
            color: white;
            padding: 15px;
            margin-bottom: 10px;
            text-align: left; /* 텍스트가 왼쪽 정렬되도록 수정 */
            border: 1px solid #3a7bd5;
            box-sizing: border-box;
            line-height: 1.6;
        }
        
        /* 상단 헤더/메뉴 스타일 */
        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .header-top-right {
            background-color: #4a90e2;
            color: white;
            padding: 5px 10px;
            border: 1px solid #3a7bd5;
            font-size: 0.9em;
        }

        .main-menu {
            display: flex;
            justify-content: space-around;
            text-align: center;
            font-weight: bold;
        }
        
        .menu-item {
            cursor: pointer; /* 클릭 가능하도록 커서 추가 */
        }
        
        .menu-item:hover {
            text-decoration: underline;
        }
        
        /* 세부 항목 스타일 (맞춤형 일기, 자유로운 공유, 통계) */
        .detail-box {
            background-color: #4a90e2;
            color: white;
            padding: 15px;
            margin-top: 20px;
            border: 1px solid #3a7bd5;
            box-sizing: border-box;
            line-height: 1.5;
        }
        
        .detail-box h4 {
            margin-top: 0;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .section-separator {
            margin: 10px 0;
            border-top: 1px solid #e0e0e0; /* 섹션 구분선 */
        }
        
        .text-left {
            text-align: left;
        }
        
        .text-center {
            text-align: center;
        }

    </style>
</head>
<body>

    <div class="container">
        
        <div class="header-top">
            <div class="text-left">내면의 흔적</div>
            <div class="header-top-right">회원가입/로그인</div>
        </div>

        <div class="blue-box main-menu">
            <div class="text-center">메뉴</div>
            <div class="text-center menu-group">
                <span class="menu-item" onclick="location.href='summaryPage.jsp'">개요</span> /
                <span class="menu-item">공지사항</span> /
                <span class="menu-item">게시판</span>
            </div>
        </div>

        <div class="blue-box">
            저희 **내면의 흔적**은 당신의 **모든 감정**을 존중하고 기록하는 곳입니다.
            <br>괴로움, 지침, 힘듦 같은 무거운 날의 감정은 물론, 행복과 감사로 가득 찬 특별한 순간까지.
            <br>삶에서 만나는 모든 감정의 파도를 솔직하게 기록할 수 있습니다.
            <div style="height: 10px;"></div>
            부담 없이 찾아와 일기를 작성하는 것만으로 마음의 안정을 얻고, 스스로를 돌아볼 수 있습니다.
            <br> "**내면의 흔적**"에서 당신의 감정을 솔직하게 마주하고, 마음의 평온을 찾아보세요.
        </div>

        <div class="detail-box">
            
            <h4>다양한 감정 맞춤형 일기</h4>
            그날의 기분에 따라 일기를 선택하고 글을 써보세요.
            <br>기쁨, 슬픔, 설렘, 스트레스 등 다양한 감정을 쉽게 기록하고, 감정별로 일기를 분류할 수 있습니다.
            
            <div class="section-separator"></div>

            <h4>자유로운 공유</h4>
            기록을 혼자 간직하거나, 공감하고 싶은 사람들과 자유롭게 이야기를 나누세요.
            <br>친구 커뮤니티와 감정을 공유하며 서로 위로와 격려를 주고받을 수 있습니다.
            
            <div class="section-separator"></div>

            <h4>맞춤형 통계와 리마인더</h4>
            일기 작성 빈도, 감정 변화, 즐겨 쓰는 키워드 등을 시각화해 나의 일기 습관을 쉽게 
            <br>확인할 수 있으며, 잊지 않고 기록하도록 리마인더 알림 기능도 제공합니다.

        </div>

    </div>
    
</body>
</html>