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
	    
<script>
//========== 전역변수 ==========
let now_page_code = "h04";  // ✅ 페이지 코드 (필수)
var chimTable;
var isEditMode = false;
var selectedRowData = null;

// ========== 페이지 로드 ==========
$(function(){
    // ✅ 권한 체크 실행
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
    
    if (!img) {
        img = $(this).siblings('.img-preview').find('img')[0];
    }
    
    img.title = selectedFile.name;

    reader.onload = function(event) {
        img.src = event.target.result;
    };
    reader.readAsDataURL(selectedFile);
});

// ========== 모달 열기 (입력) ==========
$('.insert-button').on('click', function() {
    isEditMode = false;
    selectedRowData = null;
    $('#chimStandardForm')[0].reset();
    
    // 이미지 초기화
    $('#prev_previewId1, #prev_previewId3, #prev_previewId7').attr('src', '/tkheat/css/image/no_image.png');
    $('#fileLink').attr('href', '#').text('');
    
    // 기본값 설정
    $('#wstd_t40').val('1');
    
    // 버튼 상태
    $('.btn-delete, #btnSaveAs').hide();
    
    // 모달 중앙 정렬
    $('.chim-modal').css({
        'left': '50%',
        'top': '50%',
        'transform': 'translate(-50%, -50%)'
    });
    
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
    if ($(e.target).hasClass('modal-close-btn') || $(e.target).closest('.modal-close-btn').length) {
        return;
    }
    
    isDragging = true;
    const modal = $('.chim-modal');
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
        
        $('.chim-modal').css({
            left: (modalLeft + dx) + 'px',
            top: (modalTop + dy) + 'px'
        });
    }
});

$(document).on('mouseup', function() {
    isDragging = false;
});

// ========== 침탄로 리스트 조회 ==========
function getChimStandardList(){
    console.log("🔄 getChimStandardList 시작");
    
    // 기존 테이블 완전히 제거
    if (chimTable) {
        chimTable.destroy();
        chimTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    chimTable = new Tabulator("#tab1", {
        height:"730px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/management/chimStandardInsert/getChimStandardList",
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
            
            const data = response.data ? response.data : response;
            console.log("📊 데이터 개수:", data.length);
            
            return data;
        },

        columns:[
            {title:"NO", field:"idx", sorter:"int", width:80, hozAlign:"center"},
            {title:"고객명", field:"corp_name", sorter:"string", width:160, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"품명", field:"prod_name", sorter:"string", width:240, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"도번/품번", field:"prod_no", sorter:"string", width:220, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"재질", field:"prod_jai", sorter:"int", width:240, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"단가", field:"prod_dang", sorter:"int", width:200, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"설비", field:"fac_name", sorter:"string", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"공정", field:"tech_te", sorter:"int", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"", field:"wstd_code", visible:false},
        ],

        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },

        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
        },

        // ✅ 더블클릭 이벤트에 권한 체크 추가
        rowDblClick:function(e, row){
            // 수정 권한 체크
            const permission = userPermissions?.[now_page_code];
            
            if (!['U', 'D'].includes(permission)) {
                alert("수정 권한이 없습니다.");
                console.log("⚠️ 더블클릭 차단 - 현재 권한:", permission);
                return false;
            }
            
            console.log("✅ 더블클릭(수정) 권한 확인 완료");
            
            var data = row.getData();
            selectedRowData = data;
            isEditMode = true;
            getChimStandardDetail(data.wstd_code);
            
            // ✅ 버튼 표시 제어
            if (permission === 'D') {
                // 삭제 권한: 저장, 다른이름저장, 삭제 모두 표시
                $("#btnSave, #btnSaveAs, .btn-delete").show();
                console.log("✅ 모든 버튼 표시 (삭제 권한)");
            } else if (permission === 'U') {
                // 수정 권한: 저장, 다른이름저장만 표시
                $("#btnSave, #btnSaveAs").show();
                $(".btn-delete").hide();
                console.log("✅ 저장/다른이름저장 버튼만 표시 (수정 권한)");
            }
        },
    });
    
    console.log("✅ Tabulator 생성 완료");
}

// ========== 침탄로 상세 조회 ==========
function getChimStandardDetail(wstd_code){
    $.ajax({
        url:"/tkheat/management/chimStandardInsert/getChimStandardDetail",
        type:"post",
        dataType:"json",
        data:{
            "wstd_code":wstd_code
        },
        success:function(result){
            console.log("📄 상세 데이터:", result);
            const d = result.data;
            
            // 폼 초기화
            $('#chimStandardForm')[0].reset();
            
            // 기본 데이터 바인딩
            for(let key in d){
                $("[name='"+key+"']").val(d[key]);
            }

            // 이미지 초기화
            $("#prev_previewId1, #prev_previewId3, #prev_previewId7").attr("src", "/tkheat/css/image/no_image.png");
            $("#fileLink").attr("href", "#").text("");
            
            // 단취사진
            if (d.wstd_chim_file_name1) {
                const path = "/tkPrint/사진/침탄로작업표준/" + d.wstd_chim_file_name1;
                $("#prev_previewId1").attr("src", path);
            }
            
            // 사진-3
            if (d.wstd_chim_file_name2) {
                const path = "/tkPrint/사진/침탄로작업표준/" + d.wstd_chim_file_name2;
                $("#prev_previewId3, #prev_previewId7").attr("src", path);
            }

            // 도면파일
            if (d.drawing_file_name) {
                const path = "/tkPrint/사진/침탄로작업표준/" + d.drawing_file_name;
                $("#fileLink").attr("href", path).text(d.drawing_file_name);
            }

            // 모달 열기
            $('.modal-overlay, .chim-modal').addClass('active');
        },
        error: function(xhr, status, error) {
            console.error("❌ 상세 조회 오류:", error);
        }
    });
}

// ========== 제품 검색 모달 ==========
function openProductListModal() {
    document.getElementById('productListModal').style.display = 'flex';

    let productListTable = new Tabulator("#productListTabulator", {
        height:"450px",
        layout:"fitColumns",
        selectable:true,
        ajaxURL:"/tkheat/management/productInsert/productList",
        ajaxConfig:"POST",
        ajaxParams:{
            "corp_name": "",
            "prod_code": "",
        },
        ajaxResponse:function(url, params, response){
            console.log("🔍 제품 검색 결과:", response);
            return response.data;
        },    
        columns:[
            {title:"NO", field:"idx", width:80, hozAlign:"center"},
            {title:"거래처", field:"corp_name", width:120, hozAlign:"center"},
            {title:"품명", field:"prod_name", width:120, hozAlign:"center",visible:false},
            {title:"품번", field:"prod_no", width:150, hozAlign:"center"},
            {title:"규격", field:"prod_gyu", width:100, hozAlign:"center"},
            {title:"재질", field:"prod_jai", width:200, hozAlign:"center"},
            {title:"공정", field:"tech_te", width:200, hozAlign:"center"},
            {title:"표면경도", field:"prod_pg", width:200, hozAlign:"center"},
            {title:"심부경도", field:"prod_sg", width:200, hozAlign:"center"},
            {title:"경화깊이", field:"prod_gd2", width:200, hozAlign:"center"},
            {title:"경화깊이1", field:"prod_gd1", width:200, hozAlign:"center"},
            {title:"경화깊이2", field:"prod_gd3", width:200, hozAlign:"center"},
        ],
        rowDblClick:function(e, row){
            let data = row.getData();
            
            // 제품 정보 바인딩
            $('#corp_name').val(data.corp_name);
            $('#prod_code').val(data.prod_code);
            $('#prod_danj').val(data.prod_danj);
            $('#prod_no').val(data.prod_no);
            $('#prod_name').val(data.prod_name);
            $('#prod_jai').val(data.prod_jai);
            $('#prod_dang').val(data.prod_dang);
            $('#prod_pwsno').val(data.prod_pwsno);
            $('#tech_te').val(data.tech_te);
            $('#prod_do').val(data.prod_do);
            $('#prod_refno').val(data.prod_refno);
            $('#prod_gyu').val(data.prod_gyu);
            $('#prod_kijong').val(data.prod_kijong);
            $('#prod_pg').val(data.prod_pg);
            $('#prod_sg').val(data.prod_sg);
            $('#prod_e1').val(data.prod_e1);
            $('#prod_e3').val(data.prod_e3);
            $('#prod_khecd').val(data.prod_khecd);
            $('#prod_khtcd').val(data.prod_khtcd);
            $('#prod_gd1').val(data.prod_gd1);
            $('#prod_gd2').val(data.prod_gd2);
            $('#prod_gd5').val(data.prod_gd5);
            
            document.getElementById('productListModal').style.display = 'none';
        }
    });
}

function closeProductListModal() {
    document.getElementById('productListModal').style.display = 'none';
}

// ========== 저장 ==========
function save() {
    console.log("💾 save() 함수 시작");
    
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
    
    var formData = new FormData($("#chimStandardForm")[0]);

    let confirmMsg = "";

    if (isEditMode && selectedRowData && selectedRowData.wstd_code) {
        formData.append("mode", "update");
        formData.append("wstd_code", selectedRowData.wstd_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
        formData.delete("wstd_code");
    }

    if (!confirm(confirmMsg)) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/chimStandardInsert/chimStandardInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 저장 완료:", result);
            alert("저장 되었습니다.");
            
            // 모달 닫기
            $('.modal-overlay, .chim-modal').removeClass('active');
            
            // 모달 위치 초기화
            $('.chim-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 폼 초기화
            $('#chimStandardForm')[0].reset();
            isEditMode = false;
            selectedRowData = null;
            
            // 테이블 리로드
            setTimeout(function() {
                console.log("🔄 테이블 리로드 시작");
                getChimStandardList();
            }, 300);
        },
        error: function(xhr, status, error) {
            console.error("❌ 저장 오류:", error);
            console.error("응답:", xhr.responseText);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 다른이름으로 저장 ==========
function saveAs() {
    console.log("💾 saveAs() 함수 시작");
    
    // ✅ 권한 체크 (등록 권한 필요)
    const permission = userPermissions?.[now_page_code];
    
    if (!['I', 'U', 'D'].includes(permission)) {
        alert("등록 권한이 없습니다.");
        console.log("⚠️ 다른이름으로 저장 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("✅ 다른이름으로 저장 권한 확인 완료");
    
    var formData = new FormData($("#chimStandardForm")[0]);
    formData.append("mode", "insert");
    formData.delete("wstd_code");
    
    if (!confirm("다른 이름으로 저장하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/chimStandardInsert/chimStandardInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 다른이름 저장 완료:", result);
            alert("다른 이름으로 저장되었습니다.");
            
            $('.modal-overlay, .chim-modal').removeClass('active');
            
            $('.chim-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 폼 초기화
            $('#chimStandardForm')[0].reset();
            isEditMode = false;
            selectedRowData = null;
            
            setTimeout(function() {
                getChimStandardList();
            }, 300);
        },
        error: function(xhr, status, error) {
            console.error("❌ 다른이름 저장 오류:", error);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 삭제 ==========
function deleteChim() {
    console.log("🗑️ deleteChim() 함수 시작");
    
    // ✅ 권한 체크 (삭제 권한 필요)
    const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("⚠️ 삭제 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("✅ 삭제 권한 확인 완료");
    
    if (!selectedRowData || !selectedRowData.wstd_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }

    if (!confirm("삭제하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/chimStandardInsert/chimStandardDelete",
        type: "POST",
        data: {
            wstd_code: selectedRowData.wstd_code
        },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay, .chim-modal').removeClass('active');
                
                // 모달 위치 초기화
                $('.chim-modal').css({
                    'left': '50%',
                    'top': '50%',
                    'transform': 'translate(-50%, -50%)'
                });
                
                // 폼 초기화
                $('#chimStandardForm')[0].reset();
                isEditMode = false;
                selectedRowData = null;
                
                setTimeout(function() {
                    getChimStandardList();
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

// ========== 엑셀 다운로드 ==========
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "침탄로작업표준_" + today + ".xlsx";
    chimTable.download("xlsx", filename, { sheetName: "침탄로작업표준" });
});

// ========== 단취방법 계산 ==========
window.fn_Calc = function() {
    var wstd_t32 = document.getElementById("wstd_t32");
    var wstd_t33 = document.getElementById("wstd_t33");
    var wstd_t41 = document.getElementById("wstd_t41");
    var wstd_t42 = document.getElementById("wstd_t42");
    var wstd_t44 = document.getElementById("wstd_t44");
    var wstd_t40 = document.getElementById("wstd_t40");
    var wstd_t43 = document.getElementById("wstd_t43");
    var wstd_t51 = document.getElementById("wstd_t51");
    var wstd_t52 = document.getElementById("wstd_t52");
    var wstd_t87 = document.getElementById("wstd_t87");

    var wstd_t40_val = wstd_t40 ? Number(fn_rtnnumber(wstd_t40.value)) : 1;

    if (
        wstd_t32.value !== "" && wstd_t33.value !== "" &&
        wstd_t41.value !== "" && wstd_t42.value !== "" &&
        wstd_t44.value !== "" && wstd_t87.value !== ""
    ) {
        // 단취수량 계산
        var calc_t43 = 
            Number(fn_rtnnumber(wstd_t32.value)) *
            Number(fn_rtnnumber(wstd_t33.value)) *
            Number(fn_rtnnumber(wstd_t41.value)) *
            Number(fn_rtnnumber(wstd_t42.value)) +
            Number(fn_rtnnumber(wstd_t87.value));

        wstd_t43.value = fn_addComma(calc_t43);

        // 제품무게/ch 계산
        var calc_t51 = calc_t43 * wstd_t40_val;
        wstd_t51.value = fn_addComma(calc_t51.toFixed(2));

        // 총단중/ch 계산
        var calc_t52 = Number(fn_rtnnumber(wstd_t44.value)) + calc_t51;
        wstd_t52.value = fn_addComma(calc_t52.toFixed(1));
    } else {
        wstd_t43.value = "";
        wstd_t51.value = "";
        wstd_t52.value = "";
    }
};

window.fn_addComma = function(n) {
    if (isNaN(n)) return 0;
    var reg = /(^[+-]?\d+)(\d{3})/;
    n = n.toString();
    while (reg.test(n)) {
        n = n.replace(reg, '$1' + ',' + '$2');
    }
    return n;
};

window.fn_rtnnumber = function(n) {
    if (typeof n !== "string") return n;
    return n.replace(/,/g, "");
};

// ========== 이미지 미리보기 함수 ==========
function previewImage(input, previewId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#prev_' + previewId).attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

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
