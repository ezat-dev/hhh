<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>침탄로작업표준</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>     
    
    <style>
    /* ========== 기본 스타일 ========== */
.main { width: 98%; }
.container { display: flex; justify-content: space-between; }
.box1 {
    display: flex; justify-content: right; align-items: center;
    width: 1500px; margin-left: -940px; gap: 10px;
}

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

/* ========== 제품/도면 모달용 ========== */
#productListModal.modal-overlay,
#drawingFileModal.modal-overlay {
    display: flex; align-items: center; justify-content: center; z-index: 1100;
}
#productListModal .modal-content,
#drawingFileModal .modal-content {
    background: white; padding: 15px; border-radius: 8px;
    width: 90%; max-width: 1000px; position: relative; z-index: 1101;
}
#productListModal .modal-header,
#drawingFileModal .modal-header {
    display: flex; justify-content: space-between;
    font-weight: bold; font-size: 16px; margin-bottom: 8px;
}
#productListModal .modal-close,
#drawingFileModal .modal-close { cursor: pointer; font-size: 22px; }

/* ========== 침탄로 모달 컨테이너 ========== */
.chim-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    width: 1200px; max-width: 95vw;
    max-height: 95vh;              /* ★ 90 → 95vh */
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    z-index: 1000; overflow: hidden;
}
.chim-modal.active { display: flex; flex-direction: column; }

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
    padding: 6px 8px;              /* ★ 15px → 6px 8px */
}
.modal-body::-webkit-scrollbar { width: 5px; }
.modal-body::-webkit-scrollbar-track { background: #e0e0e0; }
.modal-body::-webkit-scrollbar-thumb { background: #999; border-radius: 4px; }
.modal-body::-webkit-scrollbar-thumb:hover { background: #666; }

/* ========== 컨텐츠 래퍼 ========== */
.modal-content-wrapper {
    display: grid; grid-template-columns: 2.2fr 1fr;
    gap: 8px; height: 100%;        /* ★ 15px → 8px */
}

/* ========== 왼쪽/오른쪽 영역 ========== */
.modal-left, .modal-right {
    display: flex; flex-direction: column;
    gap: 5px;                      /* ★ 10px → 5px */
}

/* ========== 섹션 ========== */
.field-row-4 {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 5px;
    margin-bottom: 4px;
}
.field-row-4:last-child { margin-bottom: 0; }

.field-section {
    background: white; border-radius: 5px;
    padding: 5px 10px;             /* ★ 10px 15px → 5px 10px */
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.section-title {
    margin: 0 0 4px 0;             /* ★ 8px → 4px */
    font-size: 11px; font-weight: 700; color: #2c3e50;
    padding-bottom: 3px;           /* ★ 6px → 3px */
    border-bottom: 1px solid #e9ecef;
}

/* ========== 제품 이미지 미리보기 ========== */
.product-image-preview {
    width: 100%; height: 60px;     /* ★ 80px → 60px */
    border: 2px dashed #ced4da; border-radius: 6px;
    display: flex; align-items: center; justify-content: center;
    background: #f8f9fa; margin-bottom: 5px; overflow: hidden;
}
.product-image-preview img { max-width: 100%; max-height: 100%; object-fit: contain; }

/* ========== 필드 행/열 ========== */
.field-row {
    display: grid; grid-template-columns: repeat(3,1fr);
    gap: 5px; margin-bottom: 4px;  /* ★ 8px→5px, 6px→4px */
}
.field-row:last-child { margin-bottom: 0; }
.field-col { display: flex; flex-direction: column; gap: 2px; }
.field-col-full { grid-column: 1/-1; display: flex; flex-direction: column; gap: 2px; }
.field-col label, .field-col-full label {
    font-size: 10px; font-weight: 600; color: #495057;
}
.req { color: #dc3545; margin-left: 2px; }

/* ========== 입력 필드 ========== */
.field-col input[type="text"],
.field-col select,
.field-col-full input[type="text"],
.field-col-full textarea {
    width: 100%;
    padding: 3px 6px;              /* ★ 5px 8px → 3px 6px */
    border: 1px solid #ced4da; border-radius: 3px;
    font-size: 11px; box-sizing: border-box; transition: all 0.2s;
    height: 24px;                  /* ★ 고정 높이 */
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

/* ========== 검색 버튼 포함 입력 ========== */
.input-with-btn { display: flex; gap: 3px; }
.input-with-btn input { flex: 1; }
.btn-search {
    padding: 2px 8px; border: none; border-radius: 3px;
    background: #4dabf7; color: white;
    font-size: 10px; font-weight: 600; cursor: pointer; white-space: nowrap;
}
.btn-search:hover { background: #339af0; }

/* ========== 공정 테이블 ========== */
.process-table-wrapper { overflow-x: auto; margin-bottom: 5px; }
.process-table { width: 100%; border-collapse: collapse; font-size: 10px; }
.process-table th, .process-table td {
    border: 1px solid #dee2e6; padding: 3px 4px; text-align: center;
}
.process-table thead th { background: #f1f3f5; font-weight: 700; color: #495057; }
.process-table tbody th {
    background: #f8f9fa; font-weight: 600;
    text-align: left; padding-left: 6px;
}
.process-table input {
    width: 100%; padding: 2px 4px;
    border: 1px solid #ced4da; border-radius: 2px;
    font-size: 10px; box-sizing: border-box;
}
.process-table input:focus { outline: none; border-color: #4dabf7; }

/* ========== 개정이력 테이블 ========== */
.revision-table { width: 100%; border-collapse: collapse; font-size: 10px; }
.revision-table th, .revision-table td {
    border: 1px solid #dee2e6; padding: 3px 5px; text-align: center;
}
.revision-table thead th { background: #f1f3f5; font-weight: 700; color: #495057; }
.revision-table td:first-child { font-weight: 600; }
.revision-table input {
    width: 100%; padding: 2px 4px;
    border: 1px solid #ced4da; border-radius: 2px;
    font-size: 10px; box-sizing: border-box;
}

/* ========== 이미지 업로드 ========== */
.img-upload-area { display: flex; flex-direction: column; gap: 4px; }
.img-upload-area input[type="file"] {
    padding: 3px; border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer;
}
.img-upload-area input[type="file"]::-webkit-file-upload-button {
    padding: 2px 6px; border: none; border-radius: 3px;
    background: #4dabf7; color: white;
    font-size: 10px; font-weight: 600; cursor: pointer; margin-right: 4px;
}

.img-preview {
    width: 100%; height: 90px;     /* ★ 120px → 90px */
    border: 2px dashed #ced4da; border-radius: 5px;
    display: flex; align-items: center; justify-content: center;
    background: #f8f9fa; overflow: hidden; transition: all 0.3s;
}
.img-preview-small { height: 70px; } /* ★ 100px → 70px */
.img-preview:hover { border-color: #4dabf7; background: #e7f5ff; }
.img-preview img { max-width: 100%; max-height: 100%; object-fit: contain; }

/* ========== 파일 업로드 ========== */
.file-upload-area { display: flex; flex-direction: column; gap: 4px; }
.file-upload-area input[type="file"] {
    padding: 3px; border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer;
}
.file-upload-area a {
    display: inline-block; padding: 3px 6px; font-size: 10px;
    color: #4dabf7; text-decoration: none; word-break: break-all;
}

/* ========== 단취방법 계산 테이블 ========== */
.calc-table { width: 100%; border-collapse: collapse; font-size: 10px; }
.calc-table td { border: 1px solid #dee2e6; padding: 3px 5px; }
.calc-label {
    background: #f8f9fa; font-weight: 600;
    text-align: left; padding-left: 6px !important; width: 90px;
}
.calc-section-title {
    background: #e9ecef; font-weight: 700;
    text-align: center; padding: 4px !important;
}
.calc-table input {
    width: 100%; padding: 2px 4px;
    border: 1px solid #ced4da; border-radius: 2px;
    font-size: 10px; box-sizing: border-box; text-align: right;
}
.calc-table input[readonly] { background: #f1f3f5; cursor: not-allowed; }

/* ========== 모달 푸터 ========== */
.modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 6px; padding: 7px 16px;   /* ★ 12px 20px → 7px 16px */
    background: white; border-top: 1px solid #dee2e6; flex-shrink: 0;
}
.modal-footer button {
    min-width: 80px; height: 30px; /* ★ 100px 36px → 80px 30px */
    border: none; border-radius: 4px;
    font-size: 12px; font-weight: 700; cursor: pointer; transition: all 0.3s;
}
.btn-save    { background: linear-gradient(135deg,#51cf66,#37b24d); color: white; }
.btn-save:hover { background: linear-gradient(135deg,#40c057,#2f9e44); transform: translateY(-1px); }
.btn-saveas  { background: linear-gradient(135deg,#4dabf7,#339af0); color: white; }
.btn-saveas:hover { background: linear-gradient(135deg,#339af0,#1c7ed6); transform: translateY(-1px); }
.btn-delete  { background: linear-gradient(135deg,#ff6b6b,#fa5252); color: white; }
.btn-delete:hover { background: linear-gradient(135deg,#f03e3e,#e03131); transform: translateY(-1px); }
.btn-cancel  { background: linear-gradient(135deg,#868e96,#495057); color: white; }
.btn-cancel:hover { background: linear-gradient(135deg,#6c757d,#343a40); transform: translateY(-1px); }

/* ========== 반응형 ========== */
@media (max-width: 1300px) { .chim-modal { width: 95vw; } }  /* ★ 1800 → 1300 */
@media (max-width: 1400px) { .modal-content-wrapper { grid-template-columns: 1.8fr 1fr; } }
@media (max-width: 1200px) { .field-row { grid-template-columns: repeat(2,1fr); } }
@media (max-width: 900px)  { .modal-content-wrapper { grid-template-columns: 1fr; } }

    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
		<!-- <label class="daylabel">고객명 :</label>
		<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">품명 :</label>
		<input type="text" class="prod_name" id="prod_name" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">도번/품번 :</label>
		<input type="text" class="prod_no" id="prod_no" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">설비 :</label>
		<input type="text" class="fac_name" id="fac_name" style="font-size: 16px; autocomplete="off"> -->			
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getChimStandardList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
            
        </button>
        <button class="printer-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
            
        </button>
    </div>
</div>
    
    
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>




<form autocomplete="off" method="post" class="corrForm" id="chimStandardForm" name="chimStandardForm" enctype="multipart/form-data">
    <input type="hidden" name="type" value="standard" />
    
    <div class="modal-overlay"></div>
    
    <div class="chim-modal">
        <!-- 헤더 -->
        <div class="modal-header">
            <h2>침탄로표준등록</h2>
            <button type="button" class="modal-close-btn">&times;</button>
        </div>
        
        <!-- 본문 -->
        <div class="modal-body">
            <div class="modal-content-wrapper">
                <!-- 왼쪽: 입력 필드 -->
                <div class="modal-left">
                    <!-- 제품정보 -->
                    <div class="field-section">
                        <h3 class="section-title">제품정보</h3>
                        <div class="product-image-preview">
                            <img id="prev_previewId7" src="/tkheat/css/image/no_image.png" alt="제품사진">
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>고객명 <span class="req">*</span></label>
                                <div class="input-with-btn">
                                    <input type="text" id="corp_name" name="corp_name" readonly>
                                    <input type="hidden" id="prod_code" name="prod_code">
									<input type="hidden" id="prod_drawing_file_name" name="prod_drawing_file_name">
                                    <button type="button" class="btn-search" onclick="openProductListModal();">검색</button>
                                </div>
                            </div>
                            <div class="field-col">
                                <label>단중(g)</label>
                                <input type="text" id="prod_danj" name="prod_danj" readonly>
                            </div>
                            <div class="field-col">
                                <label>도번/품번</label>
                                <input type="text" id="prod_no" name="prod_no" readonly>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>품명</label>
                                <input type="text" id="prod_name" name="prod_name" readonly>
                            </div>
                            <div class="field-col">
                                <label>재질</label>
                                <input type="text" id="prod_jai" name="prod_jai" readonly>
                            </div>
                            <div class="field-col">
                                <label>단가</label>
                                <input type="text" id="prod_dang" name="prod_dang" readonly>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>주문번호</label>
                                <input type="text" id="prodC_cno" name="prodC_cno" readonly>
                            </div>
                            <div class="field-col">
                                <label>PWS No.</label>
                                <input type="text" id="prod_pwsno" name="prod_pwsno" readonly>
                            </div>
                            <div class="field-col">
                                <label>공정</label>
                                <input type="text" id="tech_te" name="tech_te" readonly>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>도면/공정도</label>
                                <input type="text" id="prod_do" name="prod_do" readonly>
                            </div>
                            <div class="field-col">
                                <label>Ref No.</label>
                                <input type="text" id="prod_refno" name="prod_refno" readonly>
                            </div>
                            <div class="field-col">
                                <label>검사규격</label>
                                <input type="text" id="prod_gyu" name="prod_gyu" readonly>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>기종</label>
                                <input type="text" id="prod_kijong" name="prod_kijong" readonly>
                            </div>
                            <div class="field-col"></div>
                            <div class="field-col"></div>
                        </div>
                        <input type="hidden" id="prod_appear" name="prod_appear">
                        <input type="hidden" id="prod_transform" name="prod_transform">
                        <input type="hidden" id="prod_cd" name="prod_cd">
                    </div>
                    
                    <!-- 요구규격 -->
					<div class="field-section">
					    <h3 class="section-title">요구규격</h3>
					    <!-- 첫번째줄 3칸 -->
					    <div class="field-row">
					        <div class="field-col">
					            <label>표면경도</label>
					            <input type="text" id="prod_pg" name="prod_pg" readonly>
					        </div>
					        <div class="field-col">
					            <label>심부경도</label>
					            <input type="text" id="prod_sg" name="prod_sg" readonly>
					        </div>
					        <div class="field-col">
					            <label>금속조직</label>
					            <input type="text" id="prod_e1" name="prod_e1" readonly>
					        </div>
					    </div>
					    <!-- 두번째줄 4칸 -->
					    <div class="field-row-4">
					        <div class="field-col">
					            <label>변형량</label>
					            <input type="text" id="prod_e3" name="prod_e3" readonly>
					        </div>
					        <div class="field-col">
					            <label>경화깊이</label>
					            <input type="text" id="prod_gd1" name="prod_gd1" readonly>
					        </div>
					        <div class="field-col">
					            <label>기준</label>
					            <input type="text" id="prod_gd2" name="prod_gd2" readonly>
					        </div>
					        <div class="field-col">
					            <label>경화깊이 범위</label>
					            <input type="text" id="prod_gd5" name="prod_gd5" readonly placeholder="~">
					        </div>
					    </div>
					    <input type="hidden" id="prod_pg3" name="prod_pg3">
					    <input type="hidden" id="prod_sg3" name="prod_sg3">
					    <input type="hidden" id="prod_e5" name="prod_e5">
					    <input type="hidden" id="prod_ra" name="prod_ra">
					    <input type="hidden" id="prod_pgs" name="prod_pgs">
					</div>
                    
                    <!-- 전세척 -->
					<div class="field-section">
					    <h3 class="section-title">전세척</h3>
					    <div class="field-row-4">
					        <div class="field-col">
					            <label>설비</label>
					            <select id="fac_code1" name="fac_code1">
					                <option value="15">진공세정기 2호기</option>
					            </select>
					        </div>
					        <div class="field-col">
					            <label>온도</label>
					            <input type="text" id="wstd_n01" name="wstd_n01">
					        </div>
					        <div class="field-col">
					            <label>시간</label>
					            <input type="text" id="wstd_n02" name="wstd_n02">
					        </div>
					        <div class="field-col">
					            <label>농도</label>
					            <input type="text" id="wstd_t66" name="wstd_t66">
					        </div>
					    </div>
					</div>
                    
                    <!-- 공정 (테이블) -->
                    <div class="field-section">
                        <h3 class="section-title">공정</h3>
                        <div class="process-table-wrapper">
                            <table class="process-table">
                                <thead>
                                    <tr>
                                        <th>구분</th>
                                        <th>예열</th>
                                        <th>침탄</th>
                                        <th>확산</th>
                                        <th>강온</th>
                                        <th>균열</th>
                                        <th>Oil</th>
                                        <th>교반기</th>
                                        <th>냉각시간</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>온도[℃]</th>
                                        <td><input type="text" id="wstd_gj11" name="wstd_gj11"></td>
                                        <td><input type="text" id="wstd_gj12" name="wstd_gj12"></td>
                                        <td><input type="text" id="wstd_gj13" name="wstd_gj13"></td>
                                        <td><input type="text" id="wstd_gj14" name="wstd_gj14"></td>
                                        <td><input type="text" id="wstd_gj15" name="wstd_gj15"></td>
                                        <td><input type="text" id="wstd_gj16" name="wstd_gj16"></td>
                                        <td><input type="text" id="wstd_gj17" name="wstd_gj17"></td>
                                        <td><input type="text" id="wstd_gj18" name="wstd_gj18"></td>
                                    </tr>
                                    <tr>
                                        <th>시간[분]</th>
                                        <td><input type="text" id="wstd_gj21" name="wstd_gj21"></td>
                                        <td><input type="text" id="wstd_gj22" name="wstd_gj22"></td>
                                        <td><input type="text" id="wstd_gj23" name="wstd_gj23"></td>
                                        <td><input type="text" id="wstd_gj24" name="wstd_gj24"></td>
                                        <td><input type="text" id="wstd_gj25" name="wstd_gj25"></td>
                                        <td><input type="text" id="wstd_gj26" name="wstd_gj26"></td>
                                        <td><input type="text" id="wstd_gj27" name="wstd_gj27"></td>
                                        <td><input type="text" id="wstd_gj28" name="wstd_gj28"></td>
                                    </tr>
                                    <tr>
                                        <th>cp%</th>
                                        <td><input type="text" id="wstd_gj31" name="wstd_gj31"></td>
                                        <td><input type="text" id="wstd_gj32" name="wstd_gj32"></td>
                                        <td><input type="text" id="wstd_gj33" name="wstd_gj33"></td>
                                        <td><input type="text" id="wstd_gj34" name="wstd_gj34"></td>
                                        <td><input type="text" id="wstd_gj35" name="wstd_gj35"></td>
                                        <td><input type="text" id="wstd_gj36" name="wstd_gj36"></td>
                                        <td><input type="text" id="wstd_gj37" name="wstd_gj37"></td>
                                        <td><input type="text" id="wstd_gj38" name="wstd_gj38"></td>
                                    </tr>
                                    <!-- <tr>
                                        <th>RX[㎥/Hr]</th>
                                        <td><input type="text" id="wstd_gj39" name="wstd_gj39"></td>
                                        <td><input type="text" id="wstd_gj42" name="wstd_gj42"></td>
                                        <td><input type="text" id="wstd_gj43" name="wstd_gj43"></td>
                                        <td><input type="text" id="wstd_gj44" name="wstd_gj44"></td>
                                        <td><input type="text" id="wstd_gj45" name="wstd_gj45"></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th>LPG</th>
                                        <td><input type="text" id="wstd_gj49" name="wstd_gj49"></td>
                                        <td><input type="text" id="wstd_gj52" name="wstd_gj52"></td>
                                        <td><input type="text" id="wstd_gj53" name="wstd_gj53"></td>
                                        <td><input type="text" id="wstd_gj54" name="wstd_gj54"></td>
                                        <td><input type="text" id="wstd_gj55" name="wstd_gj55"></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th>CH3OH[cc/Hr]</th>
                                        <td><input type="text" id="wstd_gj59" name="wstd_gj59"></td>
                                        <td><input type="text" id="wstd_gj62" name="wstd_gj62"></td>
                                        <td><input type="text" id="wstd_gj63" name="wstd_gj63"></td>
                                        <td><input type="text" id="wstd_gj64" name="wstd_gj64"></td>
                                        <td><input type="text" id="wstd_gj65" name="wstd_gj65"></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th>N2[㎥/Hr]</th>
                                        <td><input type="text" id="wstd_gj69" name="wstd_gj69"></td>
                                        <td><input type="text" id="wstd_gj72" name="wstd_gj72"></td>
                                        <td><input type="text" id="wstd_gj73" name="wstd_gj73"></td>
                                        <td><input type="text" id="wstd_gj74" name="wstd_gj74"></td>
                                        <td><input type="text" id="wstd_gj75" name="wstd_gj75"></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th>NH3[Nl/min]</th>
                                        <td><input type="text" id="wstd_gj79" name="wstd_gj79"></td>
                                        <td><input type="text" id="wstd_gj82" name="wstd_gj82"></td>
                                        <td><input type="text" id="wstd_gj83" name="wstd_gj83"></td>
                                        <td><input type="text" id="wstd_gj84" name="wstd_gj84"></td>
                                        <td><input type="text" id="wstd_gj85" name="wstd_gj85"></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr> -->
                                    <tr>
                                        <th>수량</th>
                                        <td><input type="text" id="wstd_gjsu" name="wstd_gjsu"></td>
                                        <td colspan="7"></td>
                                    </tr>
                                    <tr>
                                        <th>rpm</th>
                                        <td><input type="text" id="wstd_gjrpm" name="wstd_gjrpm"></td>
                                        <td colspan="7"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="field-row" style="margin-top: 10px;">
                            <div class="field-col-full">
                                <label>비고</label>
                                <input type="text" id="wstd_worknote" name="wstd_worknote">
                            </div>
                        </div>
                        
                        <div class="field-row">
                            <div class="field-col">
                                <label>설비</label>
                                <select id="fac_code" name="fac_code">
                                    <option value="5">고주파 1호기(폐기)</option>
                                    <option value="6">고주파 2호기 (폐기)</option>
                                    <option value="9">고주파 5호기</option>
                                    <option value="21">급수시설</option>
                                    <option value="10">변성로 1호기</option>
                                    <option value="11">변성로 2호기</option>
                                    <option value="12">쇼트 1호기</option>
                                    <option value="13">쇼트 2호기</option>
                                    <option value="14">쇼트 3호기</option>
                                    <option value="19">쇼트 4호기</option>
                                    <option value="20">전기시설</option>
                                    <option value="15">진공세정기 2호기</option>
                                    <option value="1">침탄로 1호기</option>
                                    <option value="2">침탄로 2호기</option>
                                    <option value="3">침탄로 3호기</option>
                                    <option value="4">침탄로 4호기</option>
                                    <option value="18">침탄로 5호기</option>
                                    <option value="22">콤프레샤</option>
                                    <option value="16">템퍼링기 1호기</option>
                                    <option value="17">템퍼링기 2호기</option>
                                </select>
                            </div>
                            <div class="field-col">
                                <label>보고서 유형</label>
                                <select id="reportType" name="report_type">
                                    <option value="QT1">QT-Tempering</option>
                                    <option value="QT2">QT-1차,2차 Tempering</option>
                                    <option value="QT3">QT-심냉처리</option>
                                    <option value="QT4">QT-응력제거</option>
                                    <option value="CH1">침탄-Tempering</option>
                                    <option value="CH2">침탄-1차,2차 Tempering</option>
                                    <option value="CH3">침탄-중간검사교정</option>
                                    <option value="CH4">침탄-Marking</option>
                                </select>
                            </div>
                            <div class="field-col"></div>
                        </div>
                    </div>
                    
                    <!-- 후세척 -->
					<div class="field-section">
					    <h3 class="section-title">후세척</h3>
					    <div class="field-row-4">
					        <div class="field-col">
					            <label>설비</label>
					            <select id="facCode2" name="fac_code2">
					                <option value="15">진공세정기 2호기</option>
					            </select>
					        </div>
					        <div class="field-col">
					            <label>온도</label>
					            <input type="text" id="wstd_n03" name="wstd_n03">
					        </div>
					        <div class="field-col">
					            <label>시간</label>
					            <input type="text" id="wstd_n04" name="wstd_n04">
					        </div>
					        <div class="field-col">
					            <label>농도</label>
					            <input type="text" id="wstd_t67" name="wstd_t67">
					        </div>
					    </div>
					</div>
                    
                    <!-- 템퍼링 -->
                    <div class="field-section">
                        <h3 class="section-title">템퍼링</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>1차 온도</label>
                                <input type="text" id="wstd_ready" name="wstd_ready">
                            </div>
                            <div class="field-col">
                                <label>1차 시간</label>
                                <input type="text" id="wstd_worktime" name="wstd_worktime">
                            </div>
                            <div class="field-col">
                                <label>1차 비고</label>
                                <input type="text" id="wstd_t62" name="wstd_t62">
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>2차 온도</label>
                                <input type="text" id="wstd_t63" name="wstd_t63">
                            </div>
                            <div class="field-col">
                                <label>2차 시간</label>
                                <input type="text" id="wstd_t64" name="wstd_t64">
                            </div>
                            <div class="field-col">
                                <label>2차 비고</label>
                                <input type="text" id="wstd_t65" name="wstd_t65">
                            </div>
                        </div>
                    </div>
<!-- 후처리 -->
                    <div class="field-section">
                        <h3 class="section-title">후처리</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>후처리 수량</label>
                                <input type="text" id="wstd_gj97" name="wstd_gj97">
                            </div>
                            <div class="field-col">
                                <label>설비</label>
                                <select id="fac_code3" name="fac_code3">
                                    <option value="12">쇼트 1호기</option>
                                    <option value="13">쇼트 2호기</option>
                                    <option value="14">쇼트 3호기</option>
                                    <option value="19">쇼트 4호기</option>
                                </select>
                            </div>
                            <div class="field-col">
                                <label>1차처리</label>
                                <input type="text" id="wstd_gj98" name="wstd_gj98">
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>1차 압력</label>
                                <input type="text" id="wstd_gj99" name="wstd_gj99">
                            </div>
                            <div class="field-col">
                                <label>2차처리</label>
                                <input type="text" id="wstd_gj100" name="wstd_gj100">
                            </div>
                            <div class="field-col">
                                <label>2차 압력</label>
                                <input type="text" id="wstd_gj101" name="wstd_gj101">
                            </div>
                        </div>
                    </div>
                    
                    <!-- 심냉처리 -->
                    <div class="field-section">
                        <h3 class="section-title">심냉처리</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>예냉온도</label>
                                <input type="text" id="wstd_t68" name="wstd_t68">
                            </div>
                            <div class="field-col">
                                <label>예냉시간</label>
                                <input type="text" id="wstd_t69" name="wstd_t69">
                            </div>
                            <div class="field-col">
                                <label>심냉온도</label>
                                <input type="text" id="wstd_t70" name="wstd_t70">
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>심냉시간</label>
                                <input type="text" id="wstd_t71" name="wstd_t71">
                            </div>
                            <div class="field-col">
                                <label>방냉후실온</label>
                                <input type="text" id="wstd_t72" name="wstd_t72">
                            </div>
                            <div class="field-col">
                                <label>비고</label>
                                <input type="text" id="wstd_t73" name="wstd_t73">
                            </div>
                        </div>
                    </div>
                    
                    <!-- 개정이력 -->
                    <div class="field-section">
                        <h3 class="section-title">개정이력</h3>
                        <table class="revision-table">
                            <thead>
                                <tr>
                                    <th>NO</th>
                                    <th>개정일자</th>
                                    <th>사유</th>
                                    <th>확인</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td><input type="text" id="wstd_g11" name="wstd_g11"></td>
                                    <td><input type="text" id="wstd_g12" name="wstd_g12"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td><input type="text" id="wstd_g21" name="wstd_g21"></td>
                                    <td><input type="text" id="wstd_g22" name="wstd_g22"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td><input type="text" id="wstd_g31" name="wstd_g31"></td>
                                    <td><input type="text" id="wstd_g32" name="wstd_g32"></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td><input type="text" id="wstd_g41" name="wstd_g41"></td>
                                    <td><input type="text" id="wstd_g42" name="wstd_g42"></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- 오른쪽: 이미지 및 단취방법 -->
                <div class="modal-right">
                    <!-- 단취사진 -->
                    <div class="field-section">
                        <h3 class="section-title">단취사진</h3>
                        <div class="img-upload-area">
                            <input type="file" id="imgInput0" class="imgInputClass" name="wstd_chim_file_url1" accept="image/*" onchange="previewImage(this,'previewId1')">
                            <div class="img-preview img-preview-small">
                                <img id="prev_previewId1" src="/tkheat/css/image/no_image.png" alt="단취사진">
                            </div>
                        </div>
                    </div>
                    
                    <!-- 도면 -->
                    <div class="field-section">
                        <h3 class="section-title">도면</h3>
                        <div class="file-upload-area">
                            <input type="file" name="drawing_file_url" accept=".pdf">
                            <a href="#" id="fileLink" onclick="openDrawingModal(event)"></a>
                        </div>
                    </div>
                    
                    <!-- 사진-3 -->
                    <div class="field-section">
                        <h3 class="section-title">사진-3</h3>
                        <div class="img-upload-area">
                            <input type="file" id="imgInput1" class="imgInputClass" name="wstd_chim_file_url2" accept="image/*" onchange="previewImage(this,'previewId3')">
                            <div class="img-preview img-preview-small">
                                <img id="prev_previewId3" src="/tkheat/css/image/no_image.png" alt="사진-3">
                            </div>
                        </div>
                    </div>
                    
                    <!-- 단취방법 -->
                    <div class="field-section">
                        <h3 class="section-title">단취방법</h3>
                        <table class="calc-table">
                            <tbody>
                                <tr>
                                    <td class="calc-label">EA/줄(판)</td>
                                    <td colspan="2">
                                        <input type="text" id="wstd_t32" name="wstd_t32" onchange="fn_Calc()">
                                    </td>
                                    <td>이하</td>
                                </tr>
                                <tr>
                                    <td class="calc-label">줄(판)/단</td>
                                    <td colspan="3">
                                        <input type="text" id="wstd_t33" name="wstd_t33" onchange="fn_Calc()">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="calc-label">단/Tray</td>
                                    <td>
                                        <input type="text" id="wstd_t41" name="wstd_t41" onchange="fn_Calc()">
                                    </td>
                                    <td>Tray차지</td>
                                    <td>
                                        <input type="text" id="wstd_t42" name="wstd_t42" onchange="fn_Calc()">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="calc-label">추가수량</td>
                                    <td colspan="3">
                                        <input type="text" id="wstd_t87" name="wstd_t87" onchange="fn_Calc()">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="calc-label">단취수량</td>
                                    <td colspan="2">
                                        <input type="text" id="wstd_t43" name="wstd_t43" readonly>
                                    </td>
                                    <td>EA/CH</td>
                                </tr>
                                <tr>
                                    <td class="calc-label">Jig무게</td>
                                    <td colspan="2">
                                        <input type="text" id="wstd_t44" name="wstd_t44" onchange="fn_Calc()">
                                    </td>
                                    <td>kg</td>
                                </tr>
                                <tr>
                                    <td class="calc-label">제품무게/ch</td>
                                    <td colspan="2">
                                        <input type="text" id="wstd_t51" name="wstd_t51" readonly>
                                    </td>
                                    <td>kg</td>
                                </tr>
                                <tr>
                                    <td class="calc-label">총단중/ch</td>
                                    <td colspan="2">
                                        <input type="text" id="wstd_t52" name="wstd_t52" readonly>
                                    </td>
                                    <td>kg</td>
                                </tr>
                                <tr>
                                    <td colspan="4" class="calc-section-title">단취시 유의사항</td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        ● <input type="text" id="wstd_t53" name="wstd_t53">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        ● <input type="text" id="wstd_t54" name="wstd_t54">
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        ● <input type="text" id="wstd_t30" name="wstd_t30">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="calc-label">단중</td>
                                    <td colspan="2">
                                        <input type="text" id="wstd_t40" name="wstd_t40" value="1" onchange="fn_Calc()">
                                    </td>
                                    <td>kg</td>
                                </tr>
                            </tbody>
                        </table>
                        <input type="hidden" id="wstd_t34" name="wstd_t34">
                        <input type="hidden" id="wstd_t50" name="wstd_t50">
                        <input type="hidden" id="wstd_t55" name="wstd_t55">
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 푸터 (버튼) -->
        <div class="modal-footer">
            <button type="button" class="btn-delete" onclick="deleteChim();" style="display:none;">삭제</button>
            <button type="button" class="btn-save" onclick="save();">저장</button>
            <button type="button" class="btn-saveas" id="btnSaveAs" onclick="saveAs();" style="display:none;">다른이름저장</button>
            <button type="button" class="btn-cancel">닫기</button>
        </div>
    </div>
</form>
 
 
 
 <!-- (검색버튼) 팝업창 -->
	<div id="productListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">제품 리스트</span> <span class="modal-close" onclick="closeProductListModal();">&times;</span>
			</div>
			<div id="productListTabulator" style="height: 500px;"></div>
		</div>
	</div>
	    
	  	  <!-- pdf 미리보기 모달창 -->  
<div id="drawingFileModal" class="modal-overlay" style="display: none;">
    <div class="modal-content" style="max-width: 90%; height: 90%;">
        <div class="modal-header">
            <span class="modal-title">도면 파일: <span id="drawingFileName"></span></span> 
            <span class="modal-close" onclick="closeDrawingModal()">&times;</span>
        </div>
        <div class="modal-body" style="height: calc(100% - 60px);">
            <iframe id="pdfViewer" src="" frameborder="0" width="100%" height="100%"></iframe>
        </div>
    </div>
</div>  


<!-- 이미지 확대 오버레이 -->
<div id="imgZoomOverlay" style="
    display:none; position:fixed;
    top:0; left:0; width:100%; height:100%;
    background:rgba(0,0,0,0.8);
    z-index:9999;
    align-items:center; justify-content:center;
    cursor:pointer;
    pointer-events:none;
">
    <img id="imgZoomTarget" src="" style="
        max-width:80vw; max-height:80vh;
        object-fit:contain;
        border-radius:6px;
        box-shadow:0 0 30px rgba(255,255,255,0.2);
        pointer-events:none;
    ">
</div>


	    
<script>
//========== 전역변수 ==========
let now_page_code = "h04";
var chimTable;
var productListTable = null;
var isEditMode = false;
var selectedRowData = null;

// ========== 페이지 로드 ==========
$(function(){
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    getChimStandardList();
});

// ========== 파일 미리보기 ==========
$('.imgInputClass').change(function(event){
    var selectedFile = event.target.files[0];
    if (!selectedFile) return;
    var reader = new FileReader();
    var img = $(this).parent().find('img')[0];
    if (!img) img = $(this).siblings('.img-preview').find('img')[0];
    img.title = selectedFile.name;
    reader.onload = function(event) { img.src = event.target.result; };
    reader.readAsDataURL(selectedFile);
});

// ========== 모달 열기 (입력) ==========
$('.insert-button').on('click', function() {
    isEditMode = false;
    selectedRowData = null;
    $('#chimStandardForm')[0].reset();
    $('#prev_previewId1, #prev_previewId3, #prev_previewId7').attr('src', '/tkheat/css/image/no_image.png');
    $('#fileLink').attr('href', '#').text('');
    $('#prod_drawing_file_name').val('');
    $('#wstd_t40').val('1');
    $('.btn-delete, #btnSaveAs').hide();
    $('.chim-modal').css({ 'left':'50%', 'top':'50%', 'transform':'translate(-50%, -50%)' });
    $('.modal-overlay, .chim-modal').addClass('active');
});

// ========== 모달 닫기 ==========
$('.modal-close-btn, .btn-cancel').on('click', function() {
    $('.modal-overlay, .chim-modal').removeClass('active');
});

// ========== 모달 드래그 ==========
let isDragging = false;
let startX, startY, modalLeft, modalTop;

$('.chim-modal .modal-header').on('mousedown', function(e) {
    if ($(e.target).hasClass('modal-close-btn') || $(e.target).closest('.modal-close-btn').length) return;
    isDragging = true;
    const modal = $('.chim-modal');
    const offset = modal.offset();
    startX = e.pageX; startY = e.pageY;
    modalLeft = offset.left; modalTop = offset.top;
    modal.css('transform', 'none');
    e.preventDefault();
});
$(document).on('mousemove', function(e) {
    if (isDragging) {
        $('.chim-modal').css({
            left: (modalLeft + (e.pageX - startX)) + 'px',
            top:  (modalTop  + (e.pageY - startY)) + 'px'
        });
    }
});
$(document).on('mouseup', function() { isDragging = false; });

// ========== 침탄로 리스트 조회 ==========
function getChimStandardList(){
    if (chimTable) { chimTable.destroy(); chimTable = null; }
    $('#tab1').empty();

    chimTable = new Tabulator("#tab1", {
        height:"100%", layout:"fitColumns", selectable:true,
        tooltips:true, selectableRangeMode:"click", reactiveData:true,
        headerHozAlign:"center", ajaxConfig:"POST", ajaxLoader:false,
        ajaxURL:"/tkheat/management/chimStandardInsert/getChimStandardList",
        ajaxParams:{},
        placeholder:"조회된 데이터가 없습니다.",
        pagination:"local", paginationSize:20,
        paginationSizeSelector:[20,50,100,500,1000],
        paginationCounter:"rows", headerFilterPlaceholder:"",
        columnDefaults: { headerSort: false },

        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
            const data = response.data ? response.data : response;
            return data;
        },

        columns:[
            {title:"NO",       field:"idx",       sorter:"int",    width:80,  hozAlign:"center"},
            {title:"고객명",    field:"corp_name", sorter:"string", width:160, hozAlign:"center", headerFilter:"input"},
            {title:"품명",      field:"prod_name", sorter:"string", width:240, hozAlign:"center", headerFilter:"input"},
            {title:"도번/품번", field:"prod_no",   sorter:"string", width:220, hozAlign:"center", headerFilter:"input"},
            {title:"재질",      field:"prod_jai",  sorter:"int",    width:240, hozAlign:"center", headerFilter:"input"},
            {title:"단가",      field:"prod_dang", sorter:"int",    width:200, hozAlign:"center", headerFilter:"input"},
            {title:"설비",      field:"fac_name",  sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"공정",      field:"tech_te",   sorter:"int",    width:150, hozAlign:"center", headerFilter:"input"},
            {title:"",          field:"wstd_code", visible:false},
        ],

        rowFormatter:function(row){
            row.getElement().style.fontWeight = "600";
        },
        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
        },
        rowDblClick:function(e, row){
            const permission = userPermissions?.[now_page_code];
            if (!['U', 'D'].includes(permission)) {
                alert("수정 권한이 없습니다.");
                return false;
            }
            var data = row.getData();
            selectedRowData = data;
            isEditMode = true;
            getChimStandardDetail(data.wstd_code);
            if (permission === 'D') {
                $("#btnSave, #btnSaveAs, .btn-delete").show();
            } else if (permission === 'U') {
                $("#btnSave, #btnSaveAs").show();
                $(".btn-delete").hide();
            }
        },
    });
}

// ========== 침탄로 상세 조회 ==========
function getChimStandardDetail(wstd_code){
    $.ajax({
        url:"/tkheat/management/chimStandardInsert/getChimStandardDetail",
        type:"post", dataType:"json",
        data:{ "wstd_code": wstd_code },
        success:function(result){
            const d = result.data;
            $('#chimStandardForm')[0].reset();

            for(let key in d){
                const val = (d[key] === null || d[key] === undefined) ? '' : d[key];
                const $el = $("[name='" + key + "']");
                if ($el.length) $el.val(val);
            }

            // 이미지 초기화
            $("#prev_previewId1, #prev_previewId3, #prev_previewId7").attr("src", "/tkheat/css/image/no_image.png");
            $("#fileLink").attr("href", "#").text("");

            // 단취사진 (침탄로 직접 업로드)
            if (d.wstd_chim_file_name1) {
                $("#prev_previewId1").attr("src", "/tkPrint/사진/침탄로작업표준/" + d.wstd_chim_file_name1);
            }
            // 사진-3 (침탄로 직접 업로드)
            if (d.wstd_chim_file_name2) {
                $("#prev_previewId3").attr("src", "/tkPrint/사진/침탄로작업표준/" + d.wstd_chim_file_name2);
            }

            // ★ 제품 이미지 연동 (제품등록에서 가져옴)
            if (d.prod_product_file_name && d.prod_product_file_name !== '') {
                $("#prev_previewId7").attr("src", "/tkPrint/사진/제품등록/" + d.prod_product_file_name);
            }

            // ★ 도면 우선순위 처리
            if (d.drawing_file_name && d.drawing_file_name !== '') {
                const path = "/tkPrint/사진/침탄로작업표준/" + d.drawing_file_name;
                $("#fileLink").attr("href", path).text(d.drawing_file_name);
            } else if (d.prod_drawing_file_name && d.prod_drawing_file_name !== '') {
                const path = "/tkPrint/사진/제품등록/" + d.prod_drawing_file_name;
                $("#fileLink").attr("href", path).text(d.prod_drawing_file_name);
            }

            $('.modal-overlay, .chim-modal').addClass('active');
        },
        error: function(xhr, status, error) {
            console.error("❌ 상세 조회 오류:", error);
            alert("데이터를 불러오는 중 오류가 발생했습니다.");
        }
    });
}

// ========== 제품 검색 모달 ==========
function openProductListModal() {
    document.getElementById('productListModal').style.display = 'flex';

    if (productListTable) { productListTable.destroy(); productListTable = null; }
    $('#productListTabulator').empty();

    productListTable = new Tabulator("#productListTabulator", {
        height:"450px", layout:"fitColumns", selectable:true,
        columnDefaults: { headerSort: false },
        headerFilterPlaceholder:"",
        ajaxURL:"/tkheat/management/productInsert/productList",
        ajaxConfig:"POST",
        ajaxParams:{ "corp_name":"", "prod_code":"" },
        ajaxResponse:function(url, params, response){ return response.data; },
        columns:[
            {title:"NO",      field:"idx",      width:40,  hozAlign:"center"},
            {title:"거래처",   field:"corp_name",width:120, hozAlign:"center", headerFilter:"input"},
            {title:"품명",     field:"prod_name",width:140, hozAlign:"center", headerFilter:"input"},
            {title:"품번",     field:"prod_no",  width:120, hozAlign:"center", headerFilter:"input"},
            {title:"규격",     field:"prod_gyu", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"재질",     field:"prod_jai", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"공정",     field:"tech_te",  width:60,  hozAlign:"center", headerFilter:"input"},
            {title:"표면경도", field:"prod_pg",  width:60,  hozAlign:"center"},
            {title:"심부경도", field:"prod_sg",  width:60,  hozAlign:"center"},
            {title:"경화깊이", field:"prod_gd2", width:60,  hozAlign:"center"},
            {title:"경화깊이1",field:"prod_gd1", width:60,  hozAlign:"center"},
            {title:"경화깊이2",field:"prod_gd3", width:60,  hozAlign:"center"},
        ],
        rowDblClick:function(e, row){
            let data = row.getData();

            $('#corp_name').val(data.corp_name     || '');
            $('#prod_code').val(data.prod_code     || '');
            $('#prod_danj').val(data.prod_danj     || '');
            $('#prod_no').val(data.prod_no         || '');
            $('#prod_name').val(data.prod_name     || '');
            $('#prod_jai').val(data.prod_jai       || '');
            $('#prod_dang').val(data.prod_dang     || '');
            $('#prodC_cno').val(data.prod_cno      || '');
            $('#prod_pwsno').val(data.prod_pwsno   || '');
            $('#tech_te').val(data.tech_te         || '');
            $('#prod_do').val(data.prod_do         || '');
            $('#prod_refno').val(data.prod_refno   || '');
            $('#prod_gyu').val(data.prod_gyu       || '');
            $('#prod_kijong').val(data.prod_kijong || '');
            $('#prod_pg').val(data.prod_pg         || '');
            $('#prod_sg').val(data.prod_sg         || '');
            $('#prod_e1').val(data.prod_e1         || '');
            $('#prod_e3').val(data.prod_e3         || '');
            $('#prod_gd1').val(data.prod_gd1       || '');
            $('#prod_gd2').val(data.prod_gd2       || '');
            $('#prod_gd5').val(data.prod_gd5       || '');

            // ★ 제품 이미지 연동
            if (data.product_file_name && data.product_file_name !== 'no_image.png') {
                $('#prev_previewId7').attr('src', '/tkPrint/사진/제품등록/' + data.product_file_name);
            } else {
                $('#prev_previewId7').attr('src', '/tkheat/css/image/no_image.png');
            }

            // ★ 도면 연동
            if (data.drawing_file_name && data.drawing_file_name !== '') {
                $('#prod_drawing_file_name').val(data.drawing_file_name);
                const path = '/tkPrint/사진/제품등록/' + data.drawing_file_name;
                $('#fileLink').attr('href', path).text(data.drawing_file_name);
            } else {
                $('#prod_drawing_file_name').val('');
                $('#fileLink').attr('href', '#').text('');
            }

            document.getElementById('productListModal').style.display = 'none';
        }
    });
}

function closeProductListModal() {
    document.getElementById('productListModal').style.display = 'none';
}

// ========== 저장 ==========
function save() {
    if ($('.btn-save').prop('disabled')) return;
    $('.btn-save').prop('disabled', true);

    const permission = userPermissions?.[now_page_code];
    if (!isEditMode) {
        if (!['I', 'U', 'D'].includes(permission)) {
            alert("등록 권한이 없습니다.");
            $('.btn-save').prop('disabled', false);
            return false;
        }
    } else {
        if (!['U', 'D'].includes(permission)) {
            alert("수정 권한이 없습니다.");
            $('.btn-save').prop('disabled', false);
            return false;
        }
    }

    var formData = new FormData($("#chimStandardForm")[0]);
    let confirmMsg = "";

    if (isEditMode && selectedRowData && selectedRowData.wstd_code) {
        formData.append("mode", "update");
        formData.append("wstd_code", selectedRowData.wstd_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        formData.delete("wstd_code");
        confirmMsg = "저장하시겠습니까?";
    }

    if (!confirm(confirmMsg)) {
        $('.btn-save').prop('disabled', false);
        return;
    }

    $.ajax({
        url: "/tkheat/management/chimStandardInsert/chimStandardInsertSave",
        type: "POST", data: formData,
        contentType: false, processData: false, dataType: "json",
        success: function(result) {
            $('.btn-save').prop('disabled', false);
            alert("저장 되었습니다.");
            $('.modal-overlay, .chim-modal').removeClass('active');
            $('.chim-modal').css({ 'left':'50%', 'top':'50%', 'transform':'translate(-50%, -50%)' });
            $('#chimStandardForm')[0].reset();
            isEditMode = false; selectedRowData = null;
            setTimeout(function() { getChimStandardList(); }, 300);
        },
        error: function(xhr, status, error) {
            $('.btn-save').prop('disabled', false);
            console.error("❌ 저장 오류:", error);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 다른이름으로 저장 ==========
function saveAs() {
    const permission = userPermissions?.[now_page_code];
    if (!['I', 'U', 'D'].includes(permission)) {
        alert("등록 권한이 없습니다.");
        return false;
    }
    var formData = new FormData($("#chimStandardForm")[0]);
    formData.append("mode", "insert");
    formData.delete("wstd_code");
    if (!confirm("다른 이름으로 저장하시겠습니까?")) return;

    $.ajax({
        url: "/tkheat/management/chimStandardInsert/chimStandardInsertSave",
        type: "POST", data: formData,
        contentType: false, processData: false, dataType: "json",
        success: function(result) {
            alert("다른 이름으로 저장되었습니다.");
            $('.modal-overlay, .chim-modal').removeClass('active');
            $('.chim-modal').css({ 'left':'50%', 'top':'50%', 'transform':'translate(-50%, -50%)' });
            $('#chimStandardForm')[0].reset();
            isEditMode = false; selectedRowData = null;
            setTimeout(function() { getChimStandardList(); }, 300);
        },
        error: function(xhr, status, error) {
            console.error("❌ 다른이름 저장 오류:", error);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 삭제 ==========
function deleteChim() {
    const permission = userPermissions?.[now_page_code];
    if (permission !== 'D') { alert("삭제 권한이 없습니다."); return false; }
    if (!selectedRowData || !selectedRowData.wstd_code) { alert("삭제할 대상을 선택하세요."); return; }
    if (!confirm("삭제하시겠습니까?")) return;

    $.ajax({
        url: "/tkheat/management/chimStandardInsert/chimStandardDelete",
        type: "POST", data: { wstd_code: selectedRowData.wstd_code }, dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay, .chim-modal').removeClass('active');
                $('.chim-modal').css({ 'left':'50%', 'top':'50%', 'transform':'translate(-50%, -50%)' });
                $('#chimStandardForm')[0].reset();
                isEditMode = false; selectedRowData = null;
                setTimeout(function() { getChimStandardList(); }, 300);
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

// ========== 엑셀 다운로드 ==========
$(".excel-button").off('click').on('click', function() {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    chimTable.download("xlsx", "침탄로작업표준_" + today + ".xlsx", { sheetName: "침탄로작업표준" });
});

// ========== 단취방법 계산 ==========
window.fn_Calc = function() {
    var t32  = document.getElementById("wstd_t32");
    var t33  = document.getElementById("wstd_t33");
    var t41  = document.getElementById("wstd_t41");
    var t42  = document.getElementById("wstd_t42");
    var t44  = document.getElementById("wstd_t44");
    var t40  = document.getElementById("wstd_t40");
    var t43  = document.getElementById("wstd_t43");
    var t51  = document.getElementById("wstd_t51");
    var t52  = document.getElementById("wstd_t52");
    var t87  = document.getElementById("wstd_t87");
    var t40v = t40 ? Number(fn_rtnnumber(t40.value)) : 1;

    if (t32.value && t33.value && t41.value && t42.value && t44.value && t87.value) {
        var c43 = Number(fn_rtnnumber(t32.value)) * Number(fn_rtnnumber(t33.value)) *
                  Number(fn_rtnnumber(t41.value)) * Number(fn_rtnnumber(t42.value)) +
                  Number(fn_rtnnumber(t87.value));
        t43.value = fn_addComma(c43);
        var c51 = c43 * t40v;
        t51.value = fn_addComma(c51.toFixed(2));
        t52.value = fn_addComma((Number(fn_rtnnumber(t44.value)) + c51).toFixed(1));
    } else {
        t43.value = ""; t51.value = ""; t52.value = "";
    }
};
window.fn_addComma = function(n) {
    if (isNaN(n)) return 0;
    n = n.toString();
    var reg = /(^[+-]?\d+)(\d{3})/;
    while (reg.test(n)) n = n.replace(reg, '$1,$2');
    return n;
};
window.fn_rtnnumber = function(n) {
    if (typeof n !== "string") return n;
    return n.replace(/,/g, "");
};

// ========== 이미지 미리보기 ==========
function previewImage(input, previewId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) { $('#prev_' + previewId).attr('src', e.target.result); };
        reader.readAsDataURL(input.files[0]);
    }
}

//========== 이미지 확대 ==========
$(document).on('mouseenter', '.img-preview img, .product-image-preview img', function() {
    const src = $(this).attr('src');
    if (!src || src.includes('no_image.png')) return;
    $('#imgZoomTarget').attr('src', src);
    $('#imgZoomOverlay').css('display', 'flex');
});

$(document).on('mouseleave', '.img-preview img, .product-image-preview img', function() {
    $('#imgZoomOverlay').css('display', 'none');
    $('#imgZoomTarget').attr('src', '');
});

// 오버레이 클릭 시 닫기
$('#imgZoomOverlay').on('click', function() {
    $(this).css('display', 'none');
    $('#imgZoomTarget').attr('src', '');
});

// ========== PDF 미리보기 ==========
function openDrawingModal(event) {
    event.preventDefault();
    const fileLink = $("#fileLink");
    const filePath = fileLink.attr("href");
    const fileName = fileLink.text();
    if (!filePath || filePath === "#" || fileName === "") {
        alert("저장된 도면 파일이 없습니다.");
        return;
    }
    $("#drawingFileName").text(fileName);
    $("#pdfViewer").attr("src", filePath);
    $('#drawingFileModal').css('display', 'flex');
}
function closeDrawingModal() {
    $('#drawingFileModal').css('display', 'none');
    $("#pdfViewer").attr("src", "");
}
</script>

	</body>
</html>
