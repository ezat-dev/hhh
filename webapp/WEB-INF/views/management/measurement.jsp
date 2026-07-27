<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>측정기기등록</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>     
    <style>
/* ========== 기존 스타일 유지 ========== */
.container { display: flex; justify-content: space-between; }

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

/* ========== 측정기기 모달 컨테이너 ========== */
.measurement-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    width: 900px; max-width: 95vw;
    max-height: 95vh;              /* ★ 90 → 95vh */
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    z-index: 1000; overflow: hidden;
}
.measurement-modal.active { display: flex; flex-direction: column; }

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

/* ========== 컨텐츠 래퍼 ========== */
.modal-content-wrapper {
    display: grid; grid-template-columns: 2fr 1fr;
    gap: 8px; height: 100%;        /* ★ 15px → 8px */
}

/* ========== 왼쪽/오른쪽 영역 ========== */
.modal-left, .modal-right {
    display: flex; flex-direction: column;
    gap: 5px;                      /* ★ 10px → 5px */
}

/* ========== 섹션 ========== */
.field-section {
    background: white; border-radius: 6px;
    padding: 6px 10px;             /* ★ 12px 15px → 6px 10px */
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}
.section-title {
    margin: 0 0 5px 0;             /* ★ 10px → 5px */
    font-size: 11px; font-weight: 700; color: #2c3e50;
    padding-bottom: 4px;           /* ★ 6px → 4px */
    border-bottom: 1px solid #e9ecef;
}

/* ========== 필드 행/열 ========== */
.field-row {
    display: grid; grid-template-columns: repeat(3,1fr);
    gap: 6px; margin-bottom: 5px;  /* ★ 10px→6px, 8px→5px */
}
.field-row:last-child { margin-bottom: 0; }
.field-col { display: flex; flex-direction: column; gap: 2px; } /* ★ 4px → 2px */
.field-col-full { grid-column: 1/-1; display: flex; flex-direction: column; gap: 2px; }
.field-col label, .field-col-full label {
    font-size: 10px; font-weight: 600; color: #495057; /* ★ 12px → 10px */
}
.req { color: #dc3545; margin-left: 2px; }

/* ========== 입력 필드 ========== */
.field-col input[type="text"],
.field-col input[type="date"],
.field-col select,
.field-col-full input[type="text"],
.field-col-full textarea {
    width: 100%;
    padding: 3px 7px;              /* ★ 6px 10px → 3px 7px */
    border: 1px solid #ced4da; border-radius: 3px;
    font-size: 11px;               /* ★ 12px → 11px */
    box-sizing: border-box; transition: all 0.2s;
    height: 26px;                  /* ★ 고정 높이 */
}
.field-col input:focus, .field-col select:focus,
.field-col-full input:focus, .field-col-full textarea:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.field-col input[readonly], .field-col-full input[readonly] {
    background: #f1f3f5; cursor: not-allowed;
}
.field-col select {
    cursor: pointer; appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat; background-position: right 6px center; padding-right: 20px;
}
textarea {
    resize: vertical; height: 44px; /* ★ min-height 60px → 44px 고정 */
    min-height: unset; font-family: inherit;
}

/* ========== 이미지 업로드 ========== */
.img-upload-area { display: flex; flex-direction: column; gap: 4px; }
.img-upload-area input[type="file"] {
    padding: 3px; border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer;
}
.img-upload-area input[type="file"]::-webkit-file-upload-button {
    padding: 3px 8px; border: none; border-radius: 3px;
    background: #4dabf7; color: white;
    font-size: 10px; font-weight: 600; cursor: pointer; margin-right: 5px;
}

.img-preview {
    width: 100%; height: 180px;    /* ★ 250px → 180px */
    border: 2px dashed #ced4da; border-radius: 5px;
    display: flex; align-items: center; justify-content: center;
    background: #f8f9fa; overflow: hidden; transition: all 0.3s;
}
.img-preview-large { height: 220px; } /* ★ 300px → 220px */
.img-preview:hover { border-color: #4dabf7; background: #e7f5ff; }
.img-preview img { max-width: 100%; max-height: 100%; object-fit: contain; }

.btn-img-delete {
    padding: 3px 8px; border: 1px solid #ff6b6b; border-radius: 3px;
    background: white; color: #ff6b6b;
    font-size: 10px; font-weight: 600; cursor: pointer; transition: all 0.3s;
}
.btn-img-delete:hover { background: #ff6b6b; color: white; }

/* ========== 파일 업로드 ========== */
.file-upload-area { display: flex; flex-direction: column; gap: 4px; }
.file-upload-area input[type="file"] {
    padding: 3px; border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer;
}

/* ========== 모달 푸터 ========== */
.modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 8px; padding: 7px 16px;   /* ★ 12px 20px → 7px 16px */
    background: white; border-top: 1px solid #dee2e6; flex-shrink: 0;
}
.modal-footer button {
    min-width: 80px; height: 30px; /* ★ 100px 36px → 80px 30px */
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
@media (max-width: 1000px) { .measurement-modal { width: 95vw; } }
@media (max-width: 1200px) {
    .modal-content-wrapper { grid-template-columns: 1.5fr 1fr; }
    .field-row { grid-template-columns: repeat(2,1fr); }
}
@media (max-width: 900px) { .modal-content-wrapper { grid-template-columns: 1fr; } }
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="button-container">
        <button class="select-button">
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
        <button class="printer-button">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
       보고서출력     
        </button>
    </div>
</div>
    
    
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>
	
	
<form autocomplete="off" method="post" class="corrForm" id="measurementForm" name="measurementForm" enctype="multipart/form-data">
    <input type="hidden" id="ter_code" name="ter_code" value="-1">
    <input type="hidden" id="type" name="type" value="tester">
    
    <div class="modal-overlay"></div>
    
    <div class="measurement-modal">
        <!-- 헤더 -->
        <div class="modal-header">
            <h2>측정기기등록</h2>
            <button type="button" class="modal-close-btn">&times;</button>
        </div>
        
        <!-- 본문 -->
        <div class="modal-body">
            <div class="modal-content-wrapper">
                <!-- 왼쪽: 입력 필드 -->
                <div class="modal-left">
                    <!-- 기본정보 -->
                    <div class="field-section">
                        <h3 class="section-title">기본정보</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>측정기기명 <span class="req">*</span></label>
                                <input type="text" id="ter_name" name="ter_name">
                            </div>
                            <div class="field-col">
                                <label>측정기기번호</label>
                                <input type="text" id="ter_no" name="ter_no">
                            </div>
                            <div class="field-col">
                                <label>제조회사</label>
                                <input type="text" id="ter_maker" name="ter_maker">
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>모델명</label>
                                <input type="text" id="ter_model" name="ter_model">
                            </div>
                            <div class="field-col">
                                <label>제조일자</label>
                                <input type="text" id="ter_mdate" name="ter_mdate" class="js-datepicker" readonly>
                            </div>
                            <div class="field-col">
                                <label>S/N</label>
                                <input type="text" id="ter_sn" name="ter_sn">
                            </div>
                        </div>
                    </div>

                    <!-- 구입정보 -->
                    <div class="field-section">
                        <h3 class="section-title">구입정보</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>구입회사</label>
                                <input type="text" id="ter_buy" name="ter_buy">
                            </div>
                            <div class="field-col">
                                <label>구입일자</label>
                                <input type="text" id="ter_bdate" name="ter_bdate" class="js-datepicker" readonly>
                            </div>
                            <div class="field-col">
                                <label>구입금액</label>
                                <input type="text" id="ter_bmon" name="ter_bmon">
                            </div>
                        </div>
                    </div>

                    <!-- 사용정보 -->
                    <div class="field-section">
                        <h3 class="section-title">사용정보</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>용도</label>
                                <input type="text" id="ter_yong" name="ter_yong">
                            </div>
                            <div class="field-col">
                                <label>측정기기종류</label>
                                <input type="text" id="ter_kind" name="ter_kind">
                            </div>
                            <div class="field-col">
                                <label>설치장소</label>
                                <input type="text" id="ter_place" name="ter_place">
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>상태</label>
                                <select id="ter_use" name="ter_use">
                                    <option>사용</option>
                                    <option>폐기</option>
                                    <option>매각</option>
                                </select>
                            </div>
                            <div class="field-col">
                                <label>상태비고</label>
                                <input type="text" id="ter_ubigo" name="ter_ubigo">
                            </div>
                            <div class="field-col"></div>
                        </div>
                    </div>

                    <!-- 관리정보 -->
                    <div class="field-section">
                        <h3 class="section-title">관리정보</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>관리자(정)</label>
                                <input type="text" id="ter_ma1" name="ter_ma1">
                            </div>
                            <div class="field-col">
                                <label>관리자(부)</label>
                                <input type="text" id="ter_man2" name="ter_man2">
                            </div>
                            <div class="field-col">
                                <label>검교정주기</label>
                                <select id="ter_gum" name="ter_gum">
                                    <option value="분기(120)">분기(120)</option>
                                    <option value="반년(182)">반년(182)</option>
                                    <option value="년간(362)">년간(362)</option>
                                    <option value="2년간(730)">2년간(730)</option>
                                </select>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>최종검교정일</label>
                                <input type="date" id="ter_end_gum" name="ter_end_gum" onfocusout="set_ter_next_gum();">
                            </div>
                            <div class="field-col">
                                <label>차기검교정일</label>
                                <input type="date" id="ter_next_gum" name="ter_next_gum">
                            </div>
                            <div class="field-col"></div>
                        </div>
                    </div>

                    <!-- 전력정보 -->
                    <div class="field-section">
                        <h3 class="section-title">전력정보</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>사용전압</label>
                                <input type="text" id="ter_v" name="ter_v">
                            </div>
                            <div class="field-col">
                                <label>사용전류</label>
                                <input type="text" id="ter_a" name="ter_a">
                            </div>
                            <div class="field-col">
                                <label>사용전력</label>
                                <input type="text" id="ter_kw" name="ter_kw">
                            </div>
                        </div>
                    </div>

                    <!-- 비고 -->
                    <div class="field-section">
                        <h3 class="section-title">비고</h3>
                        <div class="field-row">
                            <div class="field-col-full">
                                <label>비고</label>
                                <textarea id="ter_bigo" name="ter_bigo" rows="3"></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 오른쪽: 이미지 및 파일 -->
                <div class="modal-right">
                    <!-- 측정기기 사진 -->
                    <div class="field-section">
                        <h3 class="section-title">측정기기 사진</h3>
                        <div class="img-upload-area">
                            <input type="file" id="imgInput0" class="imgInputClass" name="file_url" accept="image/*">
                            <div class="img-preview img-preview-large">
                                <img id="img0" src="/tkheat/css/image/no_image.png" alt="측정기기사진">
                            </div>
                            <button type="button" class="btn-img-delete" onclick="imageDelete(this)">이미지 삭제</button>
                        </div>
                    </div>

                    <!-- 첨부파일 -->
                    <div class="field-section">
                        <h3 class="section-title">첨부파일</h3>
                        <div class="file-upload-area">
                            <input type="file" name="file1" id="file1" accept=".xls,.xlsx,.hwp,.hwpx,.pdf,.jpeg,.jpg,.png">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 푸터 (버튼) -->
        <div class="modal-footer">
            <button type="button" class="btn-delete" onclick="deleteMea();" style="display:none;">삭제</button>
            <button type="button" class="btn-save" onclick="save();">저장</button>
            <button type="button" class="btn-cancel">닫기</button>
        </div>
    </div>
</form>
	    
<script>
//========== 전역변수 ==========
let now_page_code = "h07";
var measureTable;
var isEditMode = false;
var selectedRowData = null;

// ========== 페이지 로드 ==========
$(function(){
	if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    getMeasureList();
});

// ========== 파일 미리보기 ==========
$('.imgInputClass').change(function(event){
    var selectedFile = event.target.files[0];
    if (!selectedFile) return;
    
    var reader = new FileReader();
    
    reader.onload = function(event) {
        $('#img0').attr('src', event.target.result);
    };
    
    reader.readAsDataURL(selectedFile);
});

// ========== 모달 열기 (입력) ==========
$('.insert-button').on('click', function() {
    isEditMode = false;
    selectedRowData = null;
    $('#measurementForm')[0].reset();
    
    // 이미지 초기화
    $('#img0').attr('src', '/tkheat/css/image/no_image.png');
    
    // 기본값 설정
    $('#ter_code').val('-1');
    
    // 버튼 상태
    $('.btn-delete').hide();
    
    // 모달 중앙 정렬
    $('.measurement-modal').css({
        'left': '50%',
        'top': '50%',
        'transform': 'translate(-50%, -50%)'
    });
    
    $('.modal-overlay, .measurement-modal').addClass('active');
});

// ========== 모달 닫기 ==========
$('.modal-close-btn, .btn-cancel').on('click', function() {
    $('.modal-overlay, .measurement-modal').removeClass('active');
});

// ========== 모달 드래그 ==========
let isDragging = false;
let startX, startY, modalLeft, modalTop;

$('.measurement-modal .modal-header').on('mousedown', function(e) {
    if ($(e.target).hasClass('modal-close-btn') || $(e.target).closest('.modal-close-btn').length) {
        return;
    }
    
    isDragging = true;
    const modal = $('.measurement-modal');
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
        
        $('.measurement-modal').css({
            left: (modalLeft + dx) + 'px',
            top: (modalTop + dy) + 'px'
        });
    }
});

$(document).on('mouseup', function() {
    isDragging = false;
});

// ========== 측정기기 리스트 조회 ==========
function getMeasureList(){
    // 기존 테이블 완전히 제거
    if (measureTable) {
        measureTable.destroy();
        measureTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    measureTable = new Tabulator("#tab1", {
        height:"100%",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/management/measurement/measureList",
        ajaxParams:{},
        placeholder:"조회된 데이터가 없습니다.",
        pagination:"local",
        paginationSize:20,
        paginationSizeSelector:[20,50,100,500,1000],
        paginationCounter:"rows",
        headerFilterPlaceholder: "",
        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
            console.log("📊 서버 응답:", response);
            return response.data ? response.data : [];
        },

        columns:[
            {title:"NO", field:"idx", sorter:"int", width:60, hozAlign:"center"},
            {title:"상태", field:"ter_use", sorter:"string", width:90, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"측정기기명", field:"ter_name", sorter:"string", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"측정기기번호", field:"ter_code", sorter:"string", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"최근검교정날짜", field:"ter_end_gum", sorter:"string", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"차기검교정날짜", field:"ter_next_gum", sorter:"int", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"검교정주기", field:"ter_gum", sorter:"int", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"모델명", field:"ter_model", sorter:"int", width:120, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"구입회사", field:"ter_buy", sorter:"int", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"구입일", field:"ter_bdate", sorter:"int", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"구입금액", field:"ter_bmon", sorter:"int", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
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
            measureDetail(data.ter_code);
            
            // 삭제 버튼 표시 여부 (권한 체크)
            const permission = userPermissions?.[now_page_code];
            if (permission === 'D') {
                $('.btn-delete').show();
            } else {
                $('.btn-delete').hide();
            }
        },
    });
    
    console.log("✅ Tabulator 생성 완료");
}

// ========== 측정기기 상세 조회 ==========
function measureDetail(ter_code){
    $.ajax({
        url:"/tkheat/management/getMeasurmentDetail",
        type:"post",
        dataType:"json",
        data:{
            "ter_code":ter_code
        },
        success:function(result){
            console.log("📄 상세 데이터:", result);
            const d = result.data;
            
            // 폼 초기화
            $('#measurementForm')[0].reset();
            
            // 기본 데이터 바인딩
            for(let key in d){
                $("#measurementForm [name='"+key+"']").val(d[key]);
            }

            // 이미지 초기화
            $("#img0").attr("src", "/tkheat/css/image/no_image.png");

            // 이미지 로드
            if (d.file_name) {
                console.log("원본 파일명:", d.file_name);
                const path = "/tkPrint/사진/측정기기관리/" + d.file_name;
                console.log("path:", path);
                $("#img0").attr("src", path);
            }

            // 모달 열기
            $('.modal-overlay, .measurement-modal').addClass('active');
        },
        error: function(xhr, status, error) {
            console.error("❌ 상세 조회 오류:", error);
        }
    });
}

// ========== 저장 ==========
function save() {
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
    var formData = new FormData($("#measurementForm")[0]);

    let confirmMsg = "";

    if (isEditMode && selectedRowData && selectedRowData.ter_code) {
        formData.append("mode", "update");
        formData.append("ter_code", selectedRowData.ter_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
        formData.delete("ter_code");
    }

    if (!confirm(confirmMsg)) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/measurement/measureInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 저장 완료:", result);
            alert("저장 되었습니다.");
            
            // 모달 닫기
            $('.modal-overlay, .measurement-modal').removeClass('active');
            
            // 모달 위치 초기화
            $('.measurement-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 테이블 리로드
            setTimeout(function() {
                console.log("🔄 테이블 리로드 시작");
                getMeasureList();
            }, 300);
        },
        error: function(xhr, status, error) {
            console.error("❌ 저장 오류:", error);
            console.error("응답:", xhr.responseText);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 삭제 ==========
function deleteMea() {
	// ✅ 권한 체크
    const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("⚠️ 삭제 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("✅ 삭제 권한 확인 완료");
    if (!selectedRowData || !selectedRowData.ter_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }

    if (!confirm("삭제하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/measurement/measureDelete",
        type: "POST",
        data: {
            ter_code: selectedRowData.ter_code
        },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay, .measurement-modal').removeClass('active');
                
                setTimeout(function() {
                    getMeasureList();
                }, 300);
            } else {
                alert("삭제 중 오류가 발생했습니다: " + result.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("❌ 삭제 오류:", error);
            alert("삭제 요청 중 오류가 발생했습니다.");
        }
    });
}

// ========== 이미지 삭제 ==========
function imageDelete(button) {
    if (confirm("이미지를 삭제하시겠습니까?")) {
        $('#img0').attr('src', '/tkheat/css/image/no_image.png');
        $('#imgInput0').val('');
        alert("이미지가 삭제되었습니다.");
    }
}

// ========== 엑셀 다운로드 ==========
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "측정기기관리_" + today + ".xlsx";
    measureTable.download("xlsx", filename, { sheetName: "측정기기관리" });
});

// ========== 차기검교정일 자동계산 (있는 경우) ==========
function set_ter_next_gum() {
    const endGum = $('#ter_end_gum').val();
    const gumCycle = $('#ter_gum').val();
    
    if (!endGum || !gumCycle) return;
    
    // 검교정주기에서 숫자만 추출 (예: "년간(362)" → 362)
    const days = parseInt(gumCycle.match(/\d+/)[0]);
    
    // 날짜 계산
    const endDate = new Date(endGum);
    endDate.setDate(endDate.getDate() + days);
    
    // YYYY-MM-DD 형식으로 변환
    const nextGum = endDate.toISOString().split('T')[0];
    $('#ter_next_gum').val(nextGum);
}

    </script>
	</body>
</html>
