<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작업자등록</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
    <%@include file="../include/pluginpage.jsp" %>
    
<style>
/* ========== 기본 스타일 ========== */
.main { width: 98%; }
.container { display: flex; justify-content: space-between; }
/* 헤더 컬럼 높이 고정 */
.tabulator .tabulator-col {
    height: 55px !important;
}

/* 헤더 필터 input 위치 고정 */
.tabulator .tabulator-col .tabulator-col-content {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
.box1 {
    display: flex; justify-content: right; align-items: center;
    width: 1500px; margin-left: -350px; gap: 10px;
}
.box1 label { font-size: 14px; font-weight: 600; color: white; }
.box1 input[type="text"] {
    width: 100px; padding: 5px 10px; font-size: 14px;
    border: 1px solid #ccc; border-radius: 6px;
    background-color: #f9f9f9; color: #333;
    outline: none; transition: border 0.3s ease;
}
.box1 input[type="text"]:focus { border: 1px solid #007bff; background-color: #fff; }
.row_select { background-color: #9ABCEA !important; }

/* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main {
    flex: 1;
    min-height: 0;
    display: flex;
    padding: 8px;
    overflow: hidden;
}

/* ========== 상단 도구바 ========== */
.tab {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 0 14px;
}
.button-container .select-button,
.button-container .insert-button,
.button-container .excel-button,
.button-container .printer-button,
.button-container .delete {
    height: 34px;
    border: 1px solid #E2E8F0;
    border-radius: 8px;
    background: #F0F4F8;
    transition: background-color .13s, border-color .13s;
}
.button-container .select-button:hover,
.button-container .insert-button:hover,
.button-container .excel-button:hover,
.button-container .printer-button:hover,
.button-container .delete:hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
}

/* ========== 리스트 카드 영역 ========== */
.container {
    flex: 1;
    min-height: 0;
    flex-direction: column;
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 8px;
    overflow: hidden;
}

/* ========== Tabulator 리스트 ========== */
#tab1.tabulator {
    flex: 1;
    min-height: 0;
    border: none;
    font-size: 12px;
}
#tab1 .tabulator-header {
    background: linear-gradient(135deg, #2B6CB0, #3182CE);
    border-bottom: none;
}
#tab1 .tabulator-col {
    background: transparent;
    border-right: 1px solid rgba(255,255,255,.15);
}
#tab1 .tabulator-col.tabulator-sortable:hover {
    background: rgba(255,255,255,.08);
}
#tab1 .tabulator-col-title {
    color: #ffffff;
    font-weight: 700;
}
#tab1 .tabulator-col .tabulator-header-filter input {
    border: none;
    border-radius: 5px;
    padding: 4px 6px;
    font-size: 11px;
    background: rgba(255,255,255,.92);
    box-sizing: border-box;
}
#tab1 .tabulator-col .tabulator-header-filter input:focus {
    outline: none;
    background: #ffffff;
    box-shadow: 0 0 0 2px rgba(255,255,255,.6);
}
#tab1 .tabulator-row {
    border-bottom: 1px solid #EDF2F7;
    transition: background-color .12s;
}
#tab1 .tabulator-row.tabulator-row-even {
    background-color: #F7FAFC;
}
#tab1 .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#tab1 .tabulator-row.row_select,
#tab1 .tabulator-row.tabulator-selected {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#tab1 .tabulator-cell {
    border: 1px solid #E2E8F0;
    color: #2D3748;
}

/* ========== 페이지네이션 (직관적으로 개선) ========== */
#tab1 .tabulator-footer {
    background: #F7FAFC;
    border-top: 1px solid #E2E8F0;
    padding: 8px 12px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
}
#tab1 .tabulator-paginator {
    display: flex;
    align-items: center;
    gap: 6px;
}
#tab1 .tabulator-page-size {
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    padding: 4px 8px;
    font-size: 12px;
    background: #ffffff;
    color: #2D3748;
    cursor: pointer;
    margin: 0;
}
#tab1 .tabulator-page-size:focus {
    outline: none;
    border-color: #3182CE;
}
#tab1 .tabulator-pages {
    display: flex;
    gap: 4px;
    margin: 0;
}
#tab1 .tabulator-page {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    background: #ffffff;
    color: #2D3748;
    min-width: 30px;
    height: 28px;
    padding: 0 8px;
    font-size: 12px;
    font-weight: 600;
    margin: 0;
    transition: background-color .13s, border-color .13s, color .13s;
}
#tab1 .tabulator-page.active {
    background: #3182CE;
    border-color: #2B6CB0;
    color: #ffffff;
}
#tab1 .tabulator-page:not(:disabled):hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
    color: #2B6CB0;
    cursor: pointer;
}
#tab1 .tabulator-page:disabled {
    opacity: .4;
    cursor: not-allowed;
}

/* ========== 모달 오버레이 ========== */
.modal-overlay {
    display: none; position: fixed;
    top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0,0,0,0.5); z-index: 999;
}
.modal-overlay.active { display: block; }

/* ========== 모달 컨테이너 ========== */
.user-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    width: 800px; max-width: 95vw;
    max-height: 95vh;              /* ★ 90 → 95vh */
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    z-index: 1000; overflow: hidden;
}
.user-modal.active { display: flex; flex-direction: column; }

/* ========== 모달 헤더 ========== */
.modal-header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 8px 16px;             /* ★ 15px 25px → 8px 16px */
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white; cursor: move; flex-shrink: 0;
}
.modal-header h2 { margin: 0; font-size: 15px; font-weight: 700; }
.modal-close-btn {
    background: none; border: none; color: white;
    font-size: 22px; cursor: pointer;
    width: 26px; height: 26px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 4px; transition: all 0.3s;
}
.modal-close-btn:hover { background: rgba(255,255,255,0.2); transform: rotate(90deg); }

/* ========== 모달 본문 ========== */
.modal-body {
    flex: 1; overflow-y: auto; overflow-x: hidden;
    background: #f5f7fa;
    padding: 8px 10px;             /* ★ 15px → 8px 10px */
}
.modal-body::-webkit-scrollbar { width: 5px; }
.modal-body::-webkit-scrollbar-track { background: #e0e0e0; }
.modal-body::-webkit-scrollbar-thumb { background: #999; border-radius: 4px; }
.modal-body::-webkit-scrollbar-thumb:hover { background: #666; }

/* ========== 섹션 ========== */
.field-section {
    background: white; border-radius: 6px;
    padding: 8px 12px;             /* ★ 12px 15px → 8px 12px */
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    margin-bottom: 6px;            /* ★ 12px → 6px */
}
.field-section:last-child { margin-bottom: 0; }
.section-title {
    margin: 0 0 6px 0;             /* ★ 10px → 6px */
    font-size: 12px; font-weight: 700; color: #2c3e50;
    padding-bottom: 4px;           /* ★ 8px → 4px */
    border-bottom: 1px solid #e9ecef;
}

/* ========== 필드 행/열 ========== */
.field-row {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 8px; margin-bottom: 6px;  /* ★ 10px→8px, 8px→6px */
}
.field-row:last-child { margin-bottom: 0; }
.field-col { display: flex; flex-direction: column; gap: 2px; } /* ★ 4px → 2px */
.field-col-full { grid-column: 1/-1; display: flex; flex-direction: column; gap: 2px; }
.field-col label, .field-col-full label {
    font-size: 11px; font-weight: 600; color: #495057; /* ★ 12px → 11px */
}
.req { color: #dc3545; margin-left: 2px; }

/* ========== 입력 필드 ========== */
.field-col input[type="text"],
.field-col input[type="date"],
.field-col input[type="password"],
.field-col-full input[type="text"],
.field-col-full textarea {
    width: 100%;
    padding: 4px 8px;              /* ★ 6px 10px → 4px 8px */
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 12px;               /* ★ 13px → 12px */
    box-sizing: border-box; transition: all 0.2s;
    height: 28px;                  /* ★ 고정 높이 */
}
.field-col input:focus,
.field-col-full input:focus,
.field-col-full textarea:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
textarea {
    resize: vertical;
    height: 44px;                  /* ★ min-height 50px → 44px 고정 */
    min-height: unset;
    font-family: inherit; line-height: 1.4;
}

/* ========== 모달 푸터 ========== */
.modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 8px; padding: 8px 16px;   /* ★ 12px 20px → 8px 16px */
    background: white; border-top: 1px solid #dee2e6; flex-shrink: 0;
}
.modal-footer button {
    min-width: 85px; height: 32px; /* ★ 100px 38px → 85px 32px */
    border: none; border-radius: 4px;
    font-size: 12px; font-weight: 700; cursor: pointer; transition: all 0.3s;
}
.btn-save    { background: linear-gradient(135deg,#51cf66,#37b24d); color: white; }
.btn-save:hover { background: linear-gradient(135deg,#40c057,#2f9e44); transform: translateY(-1px); }
.btn-delete  { background: linear-gradient(135deg,#ff6b6b,#fa5252); color: white; }
.btn-delete:hover { background: linear-gradient(135deg,#f03e3e,#e03131); transform: translateY(-1px); }
.btn-cancel  { background: linear-gradient(135deg,#868e96,#495057); color: white; }
.btn-cancel:hover { background: linear-gradient(135deg,#6c757d,#343a40); transform: translateY(-1px); }

/* ========== 반응형 ========== */
@media (max-width: 900px) { .field-row { grid-template-columns: 1fr; } }
</style>
</head>

<body>
    
<div class="tab">
    <!-- <div class="box1">
        <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
        <label class="daylabel">부서 :</label>
        <input type="text" class="user_buso" id="user_buso" style="font-size: 14px;" autocomplete="off">
            
        <label class="daylabel">직책 :</label>
        <input type="text" class="user_jick" id="user_jick" style="font-size: 14px;" autocomplete="off">
            
        <label class="daylabel">이름 :</label>
        <input type="text" class="user_name" id="user_name" style="font-size: 14px;" autocomplete="off">
    </div> -->
    <div class="button-container">
        <button class="select-button" onclick="getAllUserList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
            조회
        </button>
        <button class="insert-button">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
            입력 
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
            엑셀    
        </button>
    </div>
</div>

<main class="main">
    <div class="container">
        <div id="tab1" class="tabulator"></div>
    </div>
</main>

<!-- 모달 폼 -->
<form autocomplete="off" method="post" class="userForm" id="userInsertForm" name="userInsertForm">
    <input type="hidden" id="user_code" name="user_code" />
    
    <div class="modal-overlay"></div>
    
    <div class="user-modal">
        <!-- 헤더 -->
        <div class="modal-header">
            <h2>작업자등록</h2>
            <button type="button" class="modal-close-btn">&times;</button>
        </div>
        
        <!-- 본문 -->
        <div class="modal-body">
            <!-- 기본 정보 -->
            <div class="field-section">
                <h3 class="section-title">기본 정보</h3>
                <div class="field-row">
                    <div class="field-col">
                        <label>사원번호 <span class="req">*</span></label>
                        <input type="text" id="user_no" name="user_no" placeholder="사원번호">
                    </div>
                    <div class="field-col">
                        <label>이름 <span class="req">*</span></label>
                        <input type="text" id="user_name" name="user_name" placeholder="이름">
                    </div>
                </div>
                <div class="field-row">
                    <div class="field-col">
                        <label>부서</label>
                        <input type="text" id="user_buso" name="user_buso" placeholder="부서">
                    </div>
                    <div class="field-col">
                        <label>직책</label>
                        <input type="text" id="user_jick" name="user_jick" placeholder="직책">
                    </div>
                </div>
                <div class="field-row">
                    <div class="field-col">
                        <label>입사일</label>
                        <input type="date" id="user_jdate" name="user_jdate">
                    </div>
                    <div class="field-col">
                        <label>퇴사일</label>
                        <input type="date" id="user_odate" name="user_odate">
                    </div>
                </div>
            </div>
            
            <!-- 계정 정보 -->
            <div class="field-section">
                <h3 class="section-title">계정 정보</h3>
                <div class="field-row">
                    <div class="field-col">
                        <label>아이디 <span class="req">*</span></label>
                        <input type="text" id="user_id" name="user_id" placeholder="아이디">
                    </div>
                    <div class="field-col">
                        <label>패스워드 <span class="req">*</span></label>
                        <input type="password" id="user_pwd" name="user_pwd" placeholder="패스워드">
                    </div>
                </div>
            </div>
            
            <!-- 연락처 정보 -->
            <div class="field-section">
                <h3 class="section-title">연락처 정보</h3>
                <div class="field-row">
                    <div class="field-col-full">
                        <label>휴대전화</label>
                        <input type="text" id="user_phone" name="user_phone" placeholder="휴대전화">
                    </div>
                </div>
                <div class="field-row">
                    <div class="field-col-full">
                        <label>주소</label>
                        <input type="text" id="user_add" name="user_add" placeholder="주소">
                    </div>
                </div>
            </div>
            
            <!-- 비고 -->
            <div class="field-section">
                <h3 class="section-title">비고</h3>
                <div class="field-row">
                    <div class="field-col-full">
                        <textarea id="user_bigo" name="user_bigo" rows="3" placeholder="비고"></textarea>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 푸터 (버튼) -->
        <div class="modal-footer">
            <button type="button" class="btn-delete" onclick="deleteUser();" style="display:none;">삭제</button>
            <button type="button" class="btn-save" onclick="saveUser();">저장</button>
            <button type="button" class="btn-cancel">닫기</button>
        </div>
    </div>
</form>

<script>
// 전역변수
let now_page_code = "h05";
var userTable;
var isEditMode = false;
var selectedRowData = null;

// 로드
$(function(){
	if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    getAllUserList();
});

// 전체 사용자목록 조회
function getAllUserList(){
    // ✅ 기존 테이블 완전히 제거
    if (userTable) {
        try {
            userTable.destroy();
        } catch(e) {
            console.log("테이블 destroy 오류 무시:", e);
        }
        $("#tab1").empty();
    }
    
    // ✅ 딜레이 후 테이블 생성
    setTimeout(function() {
        userTable = new Tabulator("#tab1", {
            height:"100%",
            layout:"fitColumns",
            selectable:true,
            tooltips:true,
            selectableRangeMode:"click",
            selectableRows:true,
            reactiveData:true,
            headerHozAlign:"center",
            ajaxConfig:"POST",
            ajaxLoader:false,
            ajaxURL:"/tkheat/management/authority/userList",
            ajaxParams:{
                "user_buso": "",
                "user_jick": "",
                "user_name": ""
            },
            placeholder:"조회된 데이터가 없습니다.",
            pagination:"local",
            paginationSize:20,
            paginationSizeSelector:[20,50,100,500,1000],
            paginationCounter:"rows",
            headerFilterPlaceholder: "",
            ajaxResponse:function(url, params, response){
                $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
                return response.data ? response.data : response;
            },
            columns:[
                {title:"NO", field:"idx", sorter:"int", width:80, hozAlign:"center"},
                {title:"사원번호", field:"user_no", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", headerSort:false},
                {title:"부서", field:"user_buso", sorter:"string", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
                {title:"직책", field:"user_jick", sorter:"string", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
                {title:"성명", field:"user_name", sorter:"string", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
                {title:"입사일", field:"user_jdate", sorter:"string", width:150, hozAlign:"center", headerSort:false},
                {title:"퇴사", field:"user_ret", sorter:"string", width:80, hozAlign:"center", visible:false},
            ],
            rowFormatter:function(row){
                row.getElement().style.fontWeight = "600";
            },
            rowClick:function(e, row){
                $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
                row.getElement().classList.add("row_select");
            },
            rowDblClick:function(e, row){
                // 수정 권한 체크
                if (window.disableRowDblClick) {
                    alert("수정 권한이 없습니다.");
                    return false;
                }
                
                var data = row.getData();
                selectedRowData = data;
                isEditMode = true;
                userInsertDetail(data.user_code);
                
                // 삭제 버튼 표시 여부 (권한 체크)
                const permission = userPermissions?.[now_page_code];
                if (permission === 'D') {
                    $('.btn-delete').show();
                } else {
                    $('.btn-delete').hide();
                }
            },
        });
    }, 200);
}

// 사용자 상세 조회
function userInsertDetail(user_code){
    $.ajax({
        url:"/tkheat/management/authority/userDetail",
        type:"post",
        dataType:"json",
        data:{"user_code":user_code},
        success:function(result){
            var allData = result.data;
            
            for(let key in allData){
                $("#userInsertForm [name='"+key+"']").val(allData[key]);
            }

            if(allData.user_jdate) {
                $('#user_jdate').val(allData.user_jdate.substring(0, 10));
            }
            
            if(allData.user_odate) {
                const odateStr = allData.user_odate.substring(0, 10);
                if(odateStr === '1900-01-01') {
                    $('#user_odate').val('');
                } else {
                    $('#user_odate').val(odateStr);
                }
            }

            $('.modal-overlay, .user-modal').addClass('active');
        }
    });
}

// 입력 버튼 클릭
$('.insert-button').on('click', function() {
    isEditMode = false;
    selectedRowData = null;
    $('#userInsertForm')[0].reset();
    $('.btn-delete').hide();
    $('.modal-overlay, .user-modal').addClass('active');
    const today = new Date();
    const todayStr = today.getFullYear() + '-' +
        String(today.getMonth() + 1).padStart(2, '0') + '-' +
        String(today.getDate()).padStart(2, '0');
    $('#user_jdate').val(todayStr);
});

// 모달 닫기
$('.modal-close-btn, .btn-cancel').on('click', function() {
    $('.modal-overlay, .user-modal').removeClass('active');
});

// 모달 드래그
let isDragging = false;
let startX, startY, modalLeft, modalTop;

$('.modal-header').on('mousedown', function(e) {
    if ($(e.target).hasClass('modal-close-btn') || $(e.target).closest('.modal-close-btn').length) {
        return;
    }
    
    isDragging = true;
    const modal = $('.user-modal');
    const offset = modal.offset();
    
    startX = e.pageX;
    startY = e.pageY;
    modalLeft = offset.left;
    modalTop = offset.top;
    
    modal.css('transform', 'none');
    
    e.preventDefault();
});

$(document).on('mousemove', function(e) {
    if (isDragging) {
        const dx = e.pageX - startX;
        const dy = e.pageY - startY;
        
        $('.user-modal').css({
            left: (modalLeft + dx) + 'px',
            top: (modalTop + dy) + 'px'
        });
    }
});

$(document).on('mouseup', function() {
    isDragging = false;
});

// 저장 함수
function saveUser() {
	// ✅ 권한 체크
    const permission = userPermissions?.[now_page_code];
    
    // 신규 등록인 경우
    if (!isEditMode) {
        if (!['I', 'U', 'D'].includes(permission)) {
            alert("등록 권한이 없습니다.");
            console.log("⚠️ 등록 권한 없음 - 현재 권한:", permission);
            return false;
        }
        console.log("✅ 등록 권한 확인 완료");
    } 
    // 수정인 경우
    else {
        if (!['U', 'D'].includes(permission)) {
            alert("수정 권한이 없습니다.");
            console.log("⚠️ 수정 권한 없음 - 현재 권한:", permission);
            return false;
        }
        console.log("✅ 수정 권한 확인 완료");
    }
    const odateValue = $('#user_odate').val();
    
    let finalOdateValue;
    let user_ret_val;
    
    if (!odateValue || odateValue.trim() === '') {
        finalOdateValue = '1900-01-01';
        user_ret_val = 0;
    } else if (odateValue === '1900-01-01') {
        finalOdateValue = '1900-01-01';
        user_ret_val = 0;
    } else {
        finalOdateValue = odateValue;
        user_ret_val = 1;
    }
    
    const userData = {
        user_no: $('#user_no').val(),
        user_name: $('#user_name').val(),
        user_buso: $('#user_buso').val(),
        user_jick: $('#user_jick').val(),
        user_jdate: $('#user_jdate').val(),
        user_odate: finalOdateValue,
        user_id: $('#user_id').val(),
        user_pwd: $('#user_pwd').val(),
        user_phone: $('#user_phone').val(),
        user_add: $('#user_add').val(),
        user_bigo: $('#user_bigo').val(),
        user_ret: user_ret_val
    };

    let confirmMsg = "";

    if (isEditMode && selectedRowData && selectedRowData.user_code) {
        userData.user_code = selectedRowData.user_code;
        confirmMsg = "수정하시겠습니까?";
    } else {
        confirmMsg = "저장하시겠습니까?";
    }

    if (!confirm(confirmMsg)) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/userinsert/save",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(userData),
        dataType: "json",
        success: function(result) {
            alert(result.message || "저장 되었습니다.");
            $('.modal-overlay, .user-modal').removeClass('active');
            
            $('.user-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // ✅ 테이블 새로고침
            getAllUserList();
        },
        error: function(xhr, status, error) {
            console.error("저장 오류:", error);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// 삭제
function deleteUser() {
	// ✅ 권한 체크
    const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("⚠️ 삭제 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("✅ 삭제 권한 확인 완료");
    if (!selectedRowData || !selectedRowData.user_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }

    if (!confirm("삭제하시겠습니까?")) return;

    $.ajax({
        url: "/tkheat/management/userinsert/delete",
        type: "POST",
        data: {user_code: selectedRowData.user_code},
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay, .user-modal').removeClass('active');
                
                $('.user-modal').css({
                    'left': '50%',
                    'top': '50%',
                    'transform': 'translate(-50%, -50%)'
                });
                
                getAllUserList();
            } else {
                alert("삭제 중 오류가 발생했습니다: " + result.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("삭제 오류:", error);
        }
    });
}

// 엑셀 다운로드
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "작업자등록_" + today + ".xlsx";
    userTable.download("xlsx", filename, { sheetName: "작업자등록" });
});
</script>

</body>
</html>