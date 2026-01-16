/**
 * [공통] URL 파라미터 추출 (신고 팝업용)
 */
const urlParams = new URLSearchParams(window.location.search);
const reportType = urlParams.get('type'); 
const reportId = urlParams.get('id');

document.addEventListener("DOMContentLoaded", () => {
    // 1. Lucide 아이콘 초기화 (공통)
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }

    // 2. 게시글 상세 페이지 전용 로직
    if (document.getElementById('likeBtn')) {
        initLikeButton();
        initCommentSection();
    }

    // 3. 신고 팝업 페이지 전용 로직
    if (document.querySelector('.btn-close') || document.querySelector('.btn-submit')) {
        initReportPopupLogic();
    }
});



/**
 * [상세페이지] 게시글 추천 버튼 동작
 */
function initLikeButton() {
    const likeBtn = document.getElementById('likeBtn');
    const likeCount = document.getElementById('likeCount');
    let isLiked = false;

    if (!likeBtn) return;

    likeBtn.addEventListener('click', () => {
        let currentCount = parseInt(likeCount.innerText);
        const heartIcon = likeBtn.querySelector('i');

        if (!isLiked) {
            currentCount++;
            likeBtn.classList.add('active');
            if (heartIcon) heartIcon.style.fill = "white";
            isLiked = true;
            showLikeEffect();
        } else {
            currentCount--;
            likeBtn.classList.remove('active');
            if (heartIcon) heartIcon.style.fill = "none";
            isLiked = false;
        }
        likeCount.innerText = currentCount;
    });
}

/**
 * [상세페이지] 댓글 섹션 초기화 (엔터키 이벤트)
 */
function initCommentSection() {
    const commentInput = document.getElementById('commentInput');
    if (!commentInput) return;

    commentInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            addComment();
        }
    });
}

/**
 * [상세페이지] 실시간 댓글 추가
 */
function addComment() {
    const input = document.getElementById('commentInput');
    const list = document.getElementById('commentList');
    const countLabel = document.getElementById('commentCount');

    if (!input.value.trim()) {
        alert("댓글 내용을 입력해주세요.");
        input.focus();
        return;
    }

    const tempId = Date.now(); 
    const newCommentWrapper = document.createElement('div');
    newCommentWrapper.className = 'comment-wrapper';
    newCommentWrapper.id = `comment-${tempId}`;
    
    // 카드 스타일 적용 (실선 제거 및 배경색/여백 설정)
    newCommentWrapper.style.background = "#f8fafc";
    newCommentWrapper.style.borderRadius = "12px";
    newCommentWrapper.style.padding = "20px";
    newCommentWrapper.style.marginBottom = "16px";
    newCommentWrapper.style.border = "none";
    
    const now = new Date();
    const timeStr = `${now.getMonth() + 1}.${now.getDate()} ${now.getHours()}:${now.getMinutes()}`;

    newCommentWrapper.innerHTML = `
        <div class="comment-item">
            <div class="comment-content">
                <span class="comment-user" style="font-weight: bold; color: #1e293b;">나(기록하는사람) <small style="font-weight:normal; color:#94a3b8; margin-left:8px;">${timeStr}</small></span>
                <p class="comment-text" style="margin: 10px 0; color: #334155;">${escapeHtml(input.value)}</p>
                <div class="edit-form" style="display:none; gap:8px; margin-top:8px;">
                    <input type="text" class="edit-input" style="flex:1; padding:8px; border:1px solid #e2e8f0; border-radius:6px;">
                    <button class="btn-save" style="padding:4px 12px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;">저장</button>
                    <button class="btn-cancel" style="padding:4px 12px; background:#94a3b8; color:white; border:none; border-radius:4px; cursor:pointer;">취소</button>
                </div>
            </div>
            <div class="comment-actions" style="display: flex; gap: 12px; margin-top: 12px;">
                <button class="btn-action-text btn-like-comment" onclick="toggleCommentLike(this)" style="font-size:13px; color:#64748b; background:none; border:none; cursor:pointer; padding:0;">
                    좋아요 <span class="like-count">0</span>
                </button>
                <button class="btn-action-text" onclick="showEditForm(this)" style="font-size:13px; color:#64748b; background:none; border:none; cursor:pointer; padding:0;">수정</button>
                <button class="btn-action-text" onclick="reportContent('comment', ${tempId})" style="font-size:13px; color:#64748b; background:none; border:none; cursor:pointer; padding:0;">신고</button>
                <button class="btn-action-text" onclick="deleteComment(${tempId})" style="font-size:13px; color:#ef4444; background:none; border:none; cursor:pointer; padding:0;">삭제</button>
            </div>
        </div>
    `;

    // 애니메이션 효과
    newCommentWrapper.style.opacity = "0";
    newCommentWrapper.style.transform = "translateY(-10px)";
    list.prepend(newCommentWrapper);

    setTimeout(() => {
        newCommentWrapper.style.transition = "all 0.3s ease";
        newCommentWrapper.style.opacity = "1";
        newCommentWrapper.style.transform = "translateY(0)";
    }, 10);

    if (countLabel) countLabel.innerText = parseInt(countLabel.innerText) + 1;
    input.value = "";
}

/**
 * [상세페이지] 댓글 삭제 (애니메이션 포함)
 */
function deleteComment(commentId) {
    if (!confirm("댓글을 정말로 삭제하시겠습니까?")) return;

    const commentElement = document.getElementById(`comment-${commentId}`);
    const countLabel = document.getElementById('commentCount');

    if (commentElement) {
        commentElement.style.opacity = "0";
        commentElement.style.transform = "translateX(20px)";
        commentElement.style.transition = "all 0.3s ease";

        setTimeout(() => {
            commentElement.remove();
            if (countLabel) {
                const currentCount = parseInt(countLabel.innerText);
                if (currentCount > 0) countLabel.innerText = currentCount - 1;
            }
        }, 300);
    }
}

/**
 * [상세페이지] 댓글 좋아요 토글 (1인 1회)
 */
function toggleCommentLike(button) {
    const likeCountSpan = button.querySelector('.like-count');
    let count = parseInt(likeCountSpan.innerText);

    if (button.classList.contains('active')) {
        button.classList.remove('active');
        button.style.color = "#64748b"; // 기본색
        button.style.fontWeight = "normal";
        count--;
    } else {
        button.classList.add('active');
        button.style.color = "#3b82f6"; // 파란색 강조
        button.style.fontWeight = "bold";
        count++;
    }
    likeCountSpan.innerText = count;
}

/**
 * [상세페이지] 수정 폼 노출 및 저장
 */
function showEditForm(button) {
    const item = button.closest('.comment-item');
    const textP = item.querySelector('.comment-text');
    const editForm = item.querySelector('.edit-form');
    const editInput = item.querySelector('.edit-input');

    editInput.value = textP.innerText;
    textP.style.display = 'none';
    editForm.style.display = 'flex';

    editForm.querySelector('.btn-save').onclick = () => {
        if (!editInput.value.trim()) return;
        textP.innerText = editInput.value;
        textP.style.display = 'block';
        editForm.style.display = 'none';
    };

    editForm.querySelector('.btn-cancel').onclick = () => {
        textP.style.display = 'block';
        editForm.style.display = 'none';
    };
}

/**
 * [상세페이지] 대댓글(답글) 등록
 */
function addReply(commentId) {
    const form = document.getElementById(`replyForm-${commentId}`);
    const input = form.querySelector('.reply-input');
    const replyList = document.getElementById(`replies-${commentId}`);

    if (!input.value.trim()) {
        alert("답글 내용을 입력해주세요.");
        return;
    }

    const replyItem = document.createElement('div');
    replyItem.className = 'reply-item';
    replyItem.style.cssText = "margin-top: 10px; padding: 10px; background: #f8fafc; border-radius: 8px; border-left: 3px solid #cbd5e1;";

    replyItem.innerHTML = `
        <span class="comment-user" style="font-size:12px; font-weight:bold;">↳ 나의 답글</span>
        <p class="comment-text" style="font-size:14px; margin: 4px 0;">${escapeHtml(input.value)}</p>
        <button onclick="this.parentElement.remove()" style="font-size:11px; color:#ef4444; background:none; border:none; cursor:pointer;">삭제</button>
    `;

    replyList.appendChild(replyItem);
    input.value = "";
    form.style.display = 'none';
}

/**
 * [상세페이지] 답글 폼 토글
 */
function toggleReplyForm(commentId) {
    const form = document.getElementById(`replyForm-${commentId}`);
    if (form) {
        const isHidden = form.style.display === 'none';
        form.style.display = isHidden ? 'flex' : 'none';
        if (isHidden) {
            const input = form.querySelector('input');
            if (input) input.focus();
        }
    }
}

/**
 * [상세페이지] 신고 팝업 열기
 */
function reportContent(type, id) {
    const reportPageUrl = "../html/reportpage.html";
    const popupWidth = 500;
    const popupHeight = 600;
    const left = (window.screen.width / 2) - (popupWidth / 2);
    const top = (window.screen.height / 2) - (popupHeight / 2);
    
    const windowFeatures = `width=${popupWidth},height=${popupHeight},left=${left},top=${top},scrollbars=yes`;
    const urlWithParams = `${reportPageUrl}?type=${type}&id=${id}`;

    window.open(urlWithParams, "reportPopup", windowFeatures);
}

/**
 * [팝업페이지] 신고 팝업 동작 로직
 */
function initReportPopupLogic() {
    const btnClose = document.querySelector('.btn-close');
    const btnSubmit = document.querySelector('.btn-submit');

    if (btnClose) {
        btnClose.addEventListener('click', () => window.close());
    }

    if (btnSubmit) {
        btnSubmit.addEventListener('click', () => {
            const detail = document.querySelector('.textarea-box').value;
            if (!detail.trim()) {
                alert("상세 사유를 입력해주세요.");
                return;
            }
            alert(`신고가 정상적으로 접수되었습니다.\n(대상: ${reportType}, ID: ${reportId})`);
            window.close();
        });
    }
}

/**
 * 공통 유틸리티 함수
 */
function escapeHtml(text) {
    const map = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' };
    return text.replace(/[&<>"']/g, function(m) { return map[m]; });
}

function showLikeEffect() {
    console.log("게시글을 추천했습니다!");
}