<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품등록</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %> 
    <style>
/* ========== 기존 스타일 유지 ========== */
.main { width: 98%; }
.container { display: flex; justify-content: space-between; }
.box1 {
    display: flex; justify-content: right; align-items: center;
    width: 1000px; margin-left: -250px; gap: 10px;
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

#cutumListModal.modal-overlay,
#drawingFileModal.modal-overlay {
    display: flex; align-items: center; justify-content: center;
    z-index: 1100; background: rgba(0,0,0,0.6);
}
#cutumListModal .modal-content,
#drawingFileModal .modal-content {
    background: white; padding: 15px; border-radius: 8px;
    width: 90%; max-width: 1000px; position: relative;
    z-index: 1101; box-shadow: 0 10px 60px rgba(0,0,0,0.5);
}
#cutumListModal .modal-header,
#drawingFileModal .modal-header {
    display: flex; justify-content: space-between; align-items: center;
    font-weight: bold; font-size: 16px;
    margin-bottom: 10px; padding-bottom: 8px;
    border-bottom: 2px solid #e9ecef;
}
#cutumListModal .modal-close,
#drawingFileModal .modal-close {
    cursor: pointer; font-size: 22px; color: #495057; transition: color 0.3s;
}
#cutumListModal .modal-close:hover,
#drawingFileModal .modal-close:hover { color: #dc3545; }

/* ========== 제품 모달 컨테이너 ========== */
.product-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    width: 1600px; max-width: 95vw;
    max-height: 95vh;          /* ★ 90 → 95vh */
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    z-index: 1000; overflow: hidden;
}
.product-modal.active { display: flex; flex-direction: column; }

/* ========== 모달 헤더 ========== */
.modal-header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 10px 18px;        /* ★ 15px 25px → 10px 18px */
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white; cursor: move; flex-shrink: 0;
}
.modal-header h2 { margin: 0; font-size: 17px; font-weight: 700; }
.modal-close-btn {
    background: none; border: none; color: white;
    font-size: 24px; cursor: pointer;
    width: 28px; height: 28px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 4px; transition: all 0.3s;
}
.modal-close-btn:hover { background: rgba(255,255,255,0.2); transform: rotate(90deg); }

/* ========== 모달 본문 ========== */
.modal-body {
    flex: 1; overflow-y: auto; overflow-x: hidden;
    background: #f5f7fa;
    padding: 8px;              /* ★ 15px → 8px */
}
.modal-body::-webkit-scrollbar { width: 6px; }
.modal-body::-webkit-scrollbar-track { background: #e0e0e0; }
.modal-body::-webkit-scrollbar-thumb { background: #999; border-radius: 4px; }
.modal-body::-webkit-scrollbar-thumb:hover { background: #666; }

/* ========== 컨텐츠 래퍼 ========== */
.modal-content-wrapper {
    display: grid; grid-template-columns: 2.5fr 1fr;
    gap: 8px;                  /* ★ 15px → 8px */
    height: 100%;
}

/* ========== 왼쪽/오른쪽 영역 ========== */
.modal-left, .modal-right {
    display: flex; flex-direction: column;
    gap: 6px;                  /* ★ 10px → 6px */
}

/* ========== 섹션 ========== */
.field-section {
    background: white; border-radius: 6px;
    padding: 7px 10px;         /* ★ 10px 15px → 7px 10px */
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}
.section-title {
    margin: 0 0 5px 0;         /* ★ 8px → 5px */
    font-size: 12px;           /* ★ 14px → 12px */
    font-weight: 700; color: #2c3e50;
    padding-bottom: 4px;       /* ★ 6px → 4px */
    border-bottom: 1px solid #e9ecef; /* ★ 2px → 1px */
}

/* ========== 필드 행/열 ========== */
.field-row {
    display: grid; grid-template-columns: repeat(3,1fr);
    gap: 6px;                  /* ★ 8px → 6px */
    margin-bottom: 4px;        /* ★ 6px → 4px */
}
.field-row:last-child { margin-bottom: 0; }
.field-col { display: flex; flex-direction: column; gap: 2px; } /* ★ 3px → 2px */
.field-col-full { grid-column: 1/-1; display: flex; flex-direction: column; gap: 2px; }

.field-col label, .field-col-full label {
    font-size: 10px;           /* ★ 11px → 10px */
    font-weight: 600; color: #495057;
}
.req { color: #dc3545; margin-left: 2px; }

/* ========== 입력 필드 ========== */
.field-col input[type="text"],
.field-col input[type="date"],
.field-col input[type="number"],
.field-col select,
.field-col-full input[type="text"],
.field-col-full textarea,
.modal-right textarea {
    width: 100%;
    padding: 3px 6px;          /* ★ 5px 8px → 3px 6px */
    border: 1px solid #ced4da; border-radius: 3px;
    font-size: 11px; box-sizing: border-box; transition: all 0.2s;
}
.field-col input:focus, .field-col select:focus,
.field-col-full input:focus, .field-col-full textarea:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.field-col select {
    cursor: pointer; appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat; background-position: right 6px center; padding-right: 22px;
}
textarea { resize: vertical; min-height: 32px; font-family: inherit; line-height: 1.3; } /* ★ 40px → 32px */

/* ========== 검색 버튼 포함 입력 ========== */
.input-with-btn { display: flex; gap: 3px; }
.input-with-btn input { flex: 1; }
.btn-search {
    padding: 3px 8px; border: none; border-radius: 3px;
    background: #4dabf7; color: white;
    font-size: 10px; font-weight: 600; cursor: pointer; white-space: nowrap;
}
.btn-search:hover { background: #339af0; }

/* ========== 기호 버튼 포함 입력 ========== */
.input-with-symbols { display: flex; gap: 2px; align-items: center; }
.input-with-symbols input { flex: 1; }
.btn-symbol {
    padding: 2px 6px; border: 1px solid #ced4da; border-radius: 3px;
    background: white; font-size: 10px; cursor: pointer; transition: all 0.2s;
}
.btn-symbol:hover { background: #e9ecef; border-color: #adb5bd; }

/* ========== SPEC 그리드 ========== */
.spec-grid {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 6px; margin-bottom: 5px; /* ★ 8px → 5px */
}
.spec-item { display: flex; flex-direction: column; gap: 2px; }
.spec-item label { font-size: 10px; font-weight: 600; color: #495057; }
.spec-inputs { display: flex; align-items: center; gap: 3px; }
.spec-inputs select {
    width: 65px; padding: 3px 4px;
    border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer;
}
.spec-inputs input {
    width: 46px; padding: 3px 4px;
    border: 1px solid #ced4da; border-radius: 3px; font-size: 10px;
}
.spec-inputs span { font-size: 10px; color: #6c757d; }

/* ========== 경화깊이 입력 ========== */
.depth-inputs { display: flex; align-items: center; gap: 3px; flex-wrap: wrap; }
.depth-inputs select {
    padding: 3px 4px; border: 1px solid #ced4da; border-radius: 3px; font-size: 10px;
}
.depth-inputs input {
    padding: 3px 4px; border: 1px solid #ced4da; border-radius: 3px; font-size: 10px;
}
.depth-inputs span { font-size: 10px; color: #6c757d; }

/* ========== 수입검사 그리드 ========== */
.inspection-grid { display: grid; grid-template-columns: repeat(2,1fr); gap: 4px; }
.inspection-row { display: flex; align-items: center; gap: 3px; }
.inspection-row label { font-size: 10px; font-weight: 600; color: #495057; min-width: 44px; }
.inspection-row input {
    width: 54px; padding: 3px 4px;
    border: 1px solid #ced4da; border-radius: 3px; font-size: 10px;
}
.inspection-row span { font-size: 10px; color: #6c757d; }

/* ========== 공정 체크 그리드 ========== */
.process-check-grid { display: grid; grid-template-columns: repeat(4,1fr); gap: 5px; }
.process-item { display: flex; align-items: center; gap: 3px; }
.process-item input[type="checkbox"] { width: 14px; height: 14px; cursor: pointer; }
.process-item label { font-size: 11px; cursor: pointer; margin: 0; }

/* ========== 이미지 업로드 ========== */
.img-upload-area { display: flex; flex-direction: column; gap: 4px; }
.img-upload-area input[type="file"] {
    padding: 3px; border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer;
}
.img-upload-area input[type="file"]::-webkit-file-upload-button {
    padding: 3px 6px; border: none; border-radius: 3px;
    background: #4dabf7; color: white;
    font-size: 10px; font-weight: 600; cursor: pointer; margin-right: 4px;
}
.img-upload-area input[type="file"]::-webkit-file-upload-button:hover { background: #339af0; }

.img-preview {
    width: 100%; height: 200px;  /* ★ 240px → 200px */
    border: 2px dashed #ced4da; border-radius: 6px;
    display: flex; align-items: center; justify-content: center;
    background: #f8f9fa; overflow: hidden; transition: all 0.3s;
}
.img-preview-small { height: 110px; } /* ★ 140px → 110px */
.img-preview:hover { border-color: #4dabf7; background: #e7f5ff; }
.img-preview img { max-width: 100%; max-height: 100%; object-fit: contain; }

.file-link {
    display: inline-block; padding: 3px 6px; font-size: 10px;
    color: #4dabf7; text-decoration: none;
    border: 1px solid #4dabf7; border-radius: 3px; transition: all 0.3s;
}
.file-link:hover { background: #4dabf7; color: white; }

.btn-clear {
    padding: 3px 8px; border: 1px solid #dc3545; border-radius: 3px;
    background: white; color: #dc3545;
    font-size: 10px; font-weight: 600; cursor: pointer; transition: all 0.3s;
}
.btn-clear:hover { background: #dc3545; color: white; }

/* ========== 파일 업로드 영역 ========== */
.file-upload-area { display: flex; flex-direction: column; gap: 4px; }
.file-upload-area input[type="file"] {
    padding: 3px; border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer;
}
.file-upload-area a {
    display: inline-block; padding: 3px 6px; font-size: 10px;
    color: #4dabf7; text-decoration: none; word-break: break-all;
}
.file-upload-area a:hover { text-decoration: underline; }

/* ========== 모달 푸터 ========== */
.modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 6px;
    padding: 8px 16px;         /* ★ 12px 20px → 8px 16px */
    background: white; border-top: 1px solid #dee2e6; flex-shrink: 0;
}
.modal-footer button {
    min-width: 80px;           /* ★ 90px → 80px */
    height: 32px;              /* ★ 36px → 32px */
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
@media (max-width: 1700px) { .product-modal { width: 1400px; } }
@media (max-width: 1500px) {
    .product-modal { width: 95vw; }
    .modal-content-wrapper { grid-template-columns: 2fr 1fr; }
}
@media (max-width: 1200px) {
    .field-row { grid-template-columns: repeat(2,1fr); }
    .spec-grid { grid-template-columns: 1fr; }
}
@media (max-width: 900px) {
    .modal-content-wrapper { grid-template-columns: 1fr; }
    .field-row { grid-template-columns: 1fr; }
}
</style>
    
    
    <body>
    
    <div class="tab">
    
    <div class="box1">
           <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
        	<!-- <label class="daylabel">업체명 :</label>
			<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off"> -->
			<!-- <label class="daylabel">업체명 :</label>
			<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off">
			
			<label class="daylabel">품명 :</label>
			<input type="text" class="prod_name" id="prod_name" style="font-size: 16px;" autocomplete="off">
			
			<label class="daylabel">품번 :</label>
			<input type="text" class="prod_no" id="prod_no" style="font-size: 16px;" autocomplete="off">
			
			<label class="daylabel">규격 :</label>
			<input type="text" class="prod_gyu" id="prod_gyu" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">재질 :</label>
			<input type="text" class="prod_jai" id="prod_jai" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">표면경도 :</label>
			<input type="text" class="prod_pg" id="prod_pg" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">경화깊이 :</label>
			<input type="text" class="prod_gd3" id="prod_gd3" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">심부경도 :</label>
			<input type="text" class="prod_sg" id="prod_sg" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">공정 :</label>
			<select id="tech_te" name="tech_te" class="basic valPost valClean">
                  
                    <option value="">전체</option>
                    
                    <option value="A08">가스산질화</option>
                  
                    <option value="A11">가스연질화</option>
                  
                    <option value="A12">가스질화</option>
                  
                    <option value="A13">기타</option>
                  
                    <option value="A14">염욕질화</option>
                  
                    <option value="A15">외주품</option>
                  
                    <option value="A16">이온질화</option>
                  
                    <option value="A17">진공열처리</option>
                  
                    <option value="A18">침류질화</option>
                  
                    <option value="A20">침탄</option>
                  
                    <option value="A21">침탄질화</option>
                  
                    <option value="A27">침탄PQ</option>
                  
                    <option value="A30">템퍼링</option>
                  
                    <option value="A31">템퍼링기타</option>
                  
                    <option value="A32">Annearling</option>
                  
                    <option value="A33">Case-Vc</option>
                  
                    <option value="A34">Normalizing</option>
                  
                    <option value="A35">PLASOX</option>
                  
                    <option value="B16">PQ</option>
                  
                    <option value="B17">QT</option>
                  
                    <option value="B38">VT침탄</option>
                  
                </select>
			 -->
			
			
			</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getProductList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
            
        </button>
        <button class="printer-button">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
            
        </button>
    </div>
    
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>


<form autocomplete="off" method="post" class="corrForm" id="productInsertForm" name="productInsertForm" enctype="multipart/form-data">
    
    <div class="modal-overlay"></div>
    
    <div class="product-modal">
        <!-- 헤더 -->
        <div class="modal-header">
            <h2>제품등록</h2>
            <button type="button" class="modal-close-btn">&times;</button>
        </div>
        
        <!-- 본문 -->
        <div class="modal-body">
            <div class="modal-content-wrapper">
                <!-- 왼쪽: 입력 필드 -->
                <div class="modal-left">
                    <!-- 기본 정보 -->
                    <div class="field-section">
                        <h3 class="section-title">기본 정보</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>등록일</label>
                                <input type="date" id="prod_date" name="prod_date">
                            </div>
                            <div class="field-col">
                                <label>구분</label>
                                <select id="prod_gubn" name="prod_gubn">
                                    <option>양산</option>
                                    <option>개발</option>
                                </select>
                            </div>
                            <div class="field-col">
                                <label>거래처</label>
                                <div class="input-with-btn">
                                    <input type="text" id="corp_name" name="corp_name" readonly>
                                    <input type="hidden" id="corp_code" name="corp_code">
                                    <button type="button" class="btn-search" onclick="openCutumModal();">검색</button>
                                </div>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>품명 <span class="req">*</span></label>
                                <input type="text" id="prod_name" name="prod_name" placeholder="품명">
                            </div>
                            <div class="field-col">
                                <label>품번</label>
                                <input type="text" id="prod_no" name="prod_no" placeholder="품번">
                            </div>
                            <div class="field-col">
                                <label>관리번호</label>
                                <input type="text" id="prod_cno" name="prod_cno" placeholder="관리번호">
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>모델명</label>
                                <input type="text" id="prod_model" name="prod_model" placeholder="모델명">
                            </div>
                            <div class="field-col">
                                <label>재질</label>
                                <input type="text" id="prod_jai" name="prod_jai" placeholder="재질">
                            </div>
                            <div class="field-col">
                                <label>규격</label>
                                <div class="input-with-symbols">
                                    <input type="text" id="prod_gyu" name="prod_gyu" placeholder="규격">
                                    <button type="button" class="btn-symbol" onclick="$('#prod_gyu').val($('#prod_gyu').val()+'Φ');">Φ</button>
                                    <button type="button" class="btn-symbol" onclick="$('#prod_gyu').val($('#prod_gyu').val()+'X');">X</button>
                                    <button type="button" class="btn-symbol" onclick="$('#prod_gyu').val($('#prod_gyu').val()+'L');">L</button>
                                </div>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>단중(kg)</label>
                                <input type="text" id="prod_danj" name="prod_danj" placeholder="단중">
                            </div>
                            <div class="field-col">
                                <label>단가</label>
                                <input type="text" id="prod_dang" name="prod_dang" value="0">
                            </div>
                            <div class="field-col">
                                <label>단위</label>
                                <select id="prod_danw" name="prod_danw">
                                    <option>EA</option>
                                    <option>CH</option>
                                    <option>KG</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 공정 정보 -->
                    <div class="field-section">
                        <h3 class="section-title">공정 정보</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>공정</label>
                                <select id="tech_no" name="tech_no">
                                    <option value="A08">PIT로-가스산질화(A08)</option>
                                    <option value="A11">PIT로-가스질화(A11)</option>
                                    <option value="A12">PIT로-가스연질화(A12)</option>
                                    <option value="A13">PIT로-Annearling(A13)</option>
                                    <option value="A14">PIT로-Normalizing(A14)</option>
                                    <option value="A15">PIT로-기타(A15)</option>
                                    <option value="A16">Box Type-QT(A16)</option>
                                    <option value="A17">Box Type-침탄(A17)</option>
                                    <option value="A18">Box Type-침탄질화(A18)</option>
                                    <option value="A20">Box Type-가스연질화(A20)</option>
                                    <option value="A21">Box Type-Normalizing(A21)</option>
                                    <option value="A27">이온질화-이온질화(A27)</option>
                                    <option value="A30">Salt로-염욕질화(A30)</option>
                                    <option value="A31">Box Type-Case-Vc(A31)</option>
                                    <option value="A32">PIT로-Normalizing(A32)</option>
                                    <option value="A33">Box Type-VC침탄(A33)</option>
                                    <option value="A34">Box Type-가스질화(A34)</option>
                                    <option value="A35">PIT로-침류질화(A35)</option>
                                    <option value="B16">템퍼링로-템퍼링(B16)</option>
                                    <option value="B17">템퍼링로-템퍼링기타(B17)</option>
                                    <option value="B38">진공로-진공열처리(B38)</option>
                                    <option value="B39">이온질화-PLASOX(B39)</option>
                                    <option value="B40">진공로-Annearling(B40)</option>
                                    <option value="B41">진공로-Normalizing(B41)</option>
                                    <option value="B42">진공로-기타(B42)</option>
                                    <option value="C01">PQ-PQ(C01)</option>
                                    <option value="C02">PQ-외주품(C02)</option>
                                    <option value="C03">PQ-침탄PQ(C03)</option>
                                </select>
                            </div>
                            <div class="field-col">
                                <label>공정순서</label>
                                <input type="text" id="tech_seq" name="tech_seq" placeholder="공정순서">
                            </div>
                            <div class="field-col">
                                <label>공정패턴</label>
                                <input type="number" id="tech_pattern" name="tech_pattern" placeholder="패턴">
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>박스당수량</label>
                                <input type="text" id="prod_boxsu" name="prod_boxsu" placeholder="수량">
                            </div>
                            <div class="field-col">
                                <label>포장방법</label>
                                <input type="text" id="prod_danch" name="prod_danch" placeholder="포장방법">
                            </div>
                            <div class="field-col">
                                <label>BOX TYPE</label>
                                <select id="prod_box" name="prod_box">
                                    <option>A</option>
                                    <option>B</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 품질 정보 -->
                    <div class="field-section">
                        <h3 class="section-title">품질 정보</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>열처리곡선</label>
                                <select id="prod_snp" name="prod_snp">
                                    <option>불요</option>
                                    <option>필요</option>
                                </select>
                            </div>
                            <div class="field-col">
                                <label>방청유</label>
                                <select id="prod_bangch" name="prod_bangch">
                                    <option>필요없음</option>
                                    <option>수용성</option>
                                    <option>유용성</option>
                                    <option>기타</option>
                                </select>
                            </div>
                            <div class="field-col">
                                <label>후처리</label>
                                <select id="prod_vnyl" name="prod_vnyl">
                                    <option>불요</option>
                                    <option>쇼트SHOT-H</option>
                                    <option>쇼트SHOT-T</option>
                                    <option>쇼트SHOT-A</option>
                                    <option>센딩SAND-A</option>
                                    <option>센딩SAND-index</option>
                                    <option>센딩SAND-T</option>
                                    <option>센딩SAND-conveyer</option>
                                </select>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>시편제목</label>
                                <select id="prod_pad" name="prod_pad">
                                    <option>본품</option>
                                    <option>대체시편</option>
                                    <option>시편절단(본품절단)</option>
                                    <option>시편필요없음</option>
                                </select>
                            </div>
                            <div class="field-col">
                                <label>업종</label>
                                <select id="prod_upjong" name="prod_upjong">
                                    <option>자동차</option>
                                    <option>선박</option>
                                    <option>유압</option>
                                    <option>방산</option>
                                    <option>기타</option>
                                </select>
                            </div>
                            <div class="field-col">
                                <label>성적서</label>
                                <select id="prod_plt" name="prod_plt">
                                    <option>필요</option>
                                    <option>불필요</option>
                                </select>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col-full">
                                <label>제품실재고 현황</label>
                                <input type="text" id="prod_realjai" name="prod_realjai" placeholder="재고현황">
                            </div>
                        </div>
                    </div>
                    
                    <!-- SPEC 정보 -->
                    <div class="field-section">
                        <h3 class="section-title">SPEC 정보</h3>
                        
                        <!-- 경도 정보 -->
                        <div class="spec-grid">
                            <div class="spec-item">
                                <label>표면경도</label>
                                <div class="spec-inputs">
                                    <select id="prod_pg" name="prod_pg">
                                        <option>HRC</option><option>HV</option><option>HS</option><option>HRA</option><option>HRB</option><option>HB</option><option>HR15N</option><option>HR30N</option><option>HR45N</option>
                                    </select>
                                    <input type="text" id="prod_pg1" name="prod_pg1" placeholder="MIN">
                                    <span>~</span>
                                    <input type="text" id="prod_pg2" name="prod_pg2" placeholder="MAX">
                                </div>
                            </div>
                            <div class="spec-item">
                                <label>소입경도</label>
                                <div class="spec-inputs">
                                    <select id="prod_si" name="prod_si">
                                        <option>HRC</option><option>HV</option><option>HS</option><option>HRA</option><option>HRB</option><option>HB</option><option>HR15N</option><option>HR30N</option><option>HR45N</option>
                                    </select>
                                    <input type="text" id="prod_si1" name="prod_si1" placeholder="MIN">
                                    <span>~</span>
                                    <input type="text" id="prod_si2" name="prod_si2" placeholder="MAX">
                                </div>
                            </div>
                        </div>
                        
                        <div class="spec-grid">
                            <div class="spec-item">
                                <label>소려경도</label>
                                <div class="spec-inputs">
                                    <select id="prod_sr" name="prod_sr">
                                        <option>HRC</option><option>HV</option><option>HS</option><option>HRA</option><option>HRB</option><option>HB</option><option>HR15N</option><option>HR30N</option><option>HR45N</option>
                                    </select>
                                    <input type="text" id="prod_sr1" name="prod_sr1" placeholder="MIN">
                                    <span>~</span>
                                    <input type="text" id="prod_sr2" name="prod_sr2" placeholder="MAX">
                                </div>
                            </div>
                            <div class="spec-item">
                                <label>심부경도</label>
                                <div class="spec-inputs">
                                    <select id="prod_sg" name="prod_sg">
                                        <option>HRC</option><option>HV</option><option>HRA</option><option>HRB</option><option>HB</option>
                                    </select>
                                    <input type="text" id="prod_sg1" name="prod_sg1" placeholder="MIN">
                                    <span>~</span>
                                    <input type="text" id="prod_sg2" name="prod_sg2" placeholder="MAX">
                                </div>
                            </div>
                        </div>
                        
                        <!-- 경화깊이 -->
                        <div class="field-row">
                            <div class="field-col-full">
                                <label>경화깊이</label>
                                <div class="depth-inputs">
                                    <select id="prod_gd1" name="prod_gd1">
                                        <option>유효경화</option><option>전경화</option>
                                    </select>
                                    <select id="prod_gd3" name="prod_gd3">
                                        <option>HV</option><option>HRC</option>
                                    </select>
                                    <input type="text" id="prod_gd2" name="prod_gd2" placeholder="기준" style="width:60px;">
                                    <span>기준,</span>
                                    <input type="text" id="prod_gd4" name="prod_gd4" placeholder="MIN" style="width:60px;">
                                    <span>~</span>
                                    <input type="text" id="prod_gd5" name="prod_gd5" placeholder="MAX" style="width:60px;">
                                </div>
                            </div>
                        </div>
                        
                        <!-- 기타 SPEC -->
                        <div class="field-row">
                            <div class="field-col">
                                <label>화합물층 깊이</label>
                                <div class="spec-inputs">
                                    <select id="prod_whadeep" name="prod_whadeep">
                                        <option>㎛</option><option>㎜</option>
                                    </select>
                                    <input type="text" id="prod_e1" name="prod_e1" placeholder="MIN">
                                    <span>~</span>
                                    <input type="text" id="prod_e2" name="prod_e2" placeholder="MAX">
                                </div>
                            </div>
                            <div class="field-col">
                                <label>연마여유(mm)</label>
                                <input type="text" id="prod_polish" name="prod_polish" value="0">
                            </div>
                        </div>
                        
                        <div class="field-row">
                            <div class="field-col">
                                <label>금속조직</label>
                                <input type="text" id="prod_gj" name="prod_gj" placeholder="금속조직">
                            </div>
                            <div class="field-col">
                                <label>변형량</label>
                                <input type="text" id="prod_bh" name="prod_bh" placeholder="변형량">
                            </div>
                        </div>
                        
                        <div class="field-row">
                            <div class="field-col-full">
                                <label>비고</label>
                                <textarea id="prod_note" name="prod_note" rows="2" placeholder="비고"></textarea>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 수입검사 -->
                    <div class="field-section">
                        <h3 class="section-title">수입검사</h3>
                        <div class="inspection-grid">
                            <div class="inspection-row">
                                <label>치수1</label>
                                <input type="text" id="prod_chisu1n" name="prod_chisu1n" placeholder="MIN">
                                <span>~</span>
                                <input type="text" id="prod_chisu1s" name="prod_chisu1s" placeholder="MAX">
                            </div>
                            <div class="inspection-row">
                                <label>치수2</label>
                                <input type="text" id="prod_chisu2n" name="prod_chisu2n" placeholder="MIN">
                                <span>~</span>
                                <input type="text" id="prod_chisu2s" name="prod_chisu2s" placeholder="MAX">
                            </div>
                            <div class="inspection-row">
                                <label>치수3</label>
                                <input type="text" id="prod_chisu3n" name="prod_chisu3n" placeholder="MIN">
                                <span>~</span>
                                <input type="text" id="prod_chisu3s" name="prod_chisu3s" placeholder="MAX">
                            </div>
                            <div class="inspection-row">
                                <label>치수4</label>
                                <input type="text" id="prod_chisu4n" name="prod_chisu4n" placeholder="MIN">
                                <span>~</span>
                                <input type="text" id="prod_chisu4s" name="prod_chisu4s" placeholder="MAX">
                            </div>
                            <div class="inspection-row">
                                <label>치수5</label>
                                <input type="text" id="prod_chisu5n" name="prod_chisu5n" placeholder="MIN">
                                <span>~</span>
                                <input type="text" id="prod_chisu5s" name="prod_chisu5s" placeholder="MAX">
                            </div>
                        </div>
                    </div>
                    
                    <!-- 공정 체크 -->
                    <div class="field-section">
                        <h3 class="section-title">공정 체크</h3>
                        <div class="process-check-grid">
                            <div class="process-item">
                                <input type="checkbox" id="prod_fac1" name="prod_fac1">
                                <label for="prod_fac1">전세정</label>
                            </div>
                            <div class="process-item">
                                <input type="checkbox" id="prod_fac2" name="prod_fac2">
                                <label for="prod_fac2">방탄</label>
                            </div>
                            <div class="process-item">
                                <input type="checkbox" id="prod_fac3" name="prod_fac3">
                                <label for="prod_fac3">침탄</label>
                            </div>
                            <div class="process-item">
                                <input type="checkbox" id="prod_fac4" name="prod_fac4">
                                <label for="prod_fac4">고주파</label>
                            </div>
                            <div class="process-item">
                                <input type="checkbox" id="prod_fac5" name="prod_fac5">
                                <label for="prod_fac5">후세정</label>
                            </div>
                            <div class="process-item">
                                <input type="checkbox" id="prod_fac6" name="prod_fac6">
                                <label for="prod_fac6">템퍼링</label>
                            </div>
                            <div class="process-item">
                                <input type="checkbox" id="prod_fac7" name="prod_fac7">
                                <label for="prod_fac7">쇼트</label>
                            </div>
                            <div class="process-item">
                                <input type="checkbox" id="prod_fac8" name="prod_fac8">
                                <label for="prod_fac8">후처리</label>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 오른쪽: 이미지 및 도면 -->
                <div class="modal-right">
                    <div class="field-section">
                        <h3 class="section-title">제품 이미지</h3>
                        <div class="img-upload-area">
                            <input type="file" id="imgInput0" class="imgInputClass" name="product_file_url" accept="image/*">
                            <div class="img-preview">
                                <img id="img0" src="/tkheat/css/image/no_image.png" alt="제품이미지">
                            </div>
                            <a href="" class="aphoto file-link" download="">다운로드</a>
                        </div>
                    </div>
                    
                    <div class="field-section">
                        <h3 class="section-title">외형사진</h3>
                        <div class="img-upload-area">
                            <input type="file" id="imgInput1" class="imgInputClass" name="apperance_file_url" accept="image/*">
                            <div class="img-preview img-preview-small">
                                <img id="img1" src="/tkheat/css/image/no_image.png" alt="외형사진">
                            </div>
                            <button type="button" class="btn-clear" onclick="$('#img1').attr('src', '/tkheat/css/image/no_image.png'); $('#imgInput1').val('');">X</button>
                        </div>
                    </div>
                    
                    <div class="field-section">
                        <h3 class="section-title">열처리공정</h3>
                        <div class="img-upload-area">
                            <input type="file" id="imgInput2" class="imgInputClass" name="heat_file_url" accept="image/*">
                            <div class="img-preview img-preview-small">
                                <img id="img2" src="/tkheat/css/image/no_image.png" alt="열처리공정">
                            </div>
                            <button type="button" class="btn-clear" onclick="$('#img2').attr('src', '/tkheat/css/image/no_image.png'); $('#imgInput2').val('');">X</button>
                        </div>
                    </div>
                    
                    <div class="field-section">
                        <h3 class="section-title">도면파일</h3>
                        <div class="file-upload-area">
                            <input type="file" id="file" name="drawing_file_url">
                            <button type="button" class="btn-clear" onclick="$('#fileLink').text('');">X</button>
                            <a href="#" id="fileLink" onclick="openDrawingModal(event)"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 푸터 (버튼) -->
        <div class="modal-footer">
            <button type="button" class="btn-delete" onclick="deleteProduct();" style="display:none;">삭제</button>
            <button type="button" class="btn-save" onclick="save();">저장</button>
            <button type="button" class="btn-saveas" id="btnSaveAs" onclick="saveAsNew();" style="display:none;">다른이름저장</button>
            <button type="button" class="btn-cancel">닫기</button>
        </div>
    </div>
</form>
	    
	    
	    
	    <!-- 거래처(검색버튼) 팝업창 -->
	<div id="cutumListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">거래처 리스트</span> <span class="modal-close" onclick="closeCutumListModal()">&times;</span>
			</div>
			<div id="cutumListTabulator" style="height: 500px;"></div>
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
let now_page_code = "h01";  // ✅ 페이지 코드 (필수)
var productTable;
var isEditMode = false;
var selectedRowData = null;

// ========== 페이지 로드 ==========
$(function(){
    // ✅ 권한 체크 실행
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    getProductList();
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
    $('#productInsertForm')[0].reset();
    $('#img0, #img1, #img2').attr('src', '/tkheat/css/image/no_image.png');
    $('.aphoto, .bphoto, .cphoto, #fileLink').attr('href', '').text('');
    $('.btn-delete, #btnSaveAs').hide();
    
    // 숫자 필드 기본값 설정
    $('#prod_dang, #prod_danj, #prod_boxsu, #prod_polish, #tech_pattern').val('0');
    
    // 모달 중앙 정렬
    $('.product-modal').css({
        'left': '50%',
        'top': '50%',
        'transform': 'translate(-50%, -50%)'
    });
    
    $('.modal-overlay, .product-modal').addClass('active');
});

// ========== 모달 닫기 ==========
$('.modal-close-btn, .btn-cancel').on('click', function() {
    $('.modal-overlay, .product-modal').removeClass('active');
});

// ========== 모달 드래그 ==========
let isDragging = false;
let startX, startY, modalLeft, modalTop;

$('.product-modal .modal-header').on('mousedown', function(e) {
    if ($(e.target).hasClass('modal-close-btn') || $(e.target).closest('.modal-close-btn').length) {
        return;
    }
    
    isDragging = true;
    const modal = $('.product-modal');
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
        
        $('.product-modal').css({
            left: (modalLeft + dx) + 'px',
            top: (modalTop + dy) + 'px'
        });
    }
});

$(document).on('mouseup', function() {
    isDragging = false;
});

// ========== 제품 리스트 조회 ==========
function getProductList(){
    console.log("🔄 getProductList 시작");
    
    // 기존 테이블 완전히 제거
    if (productTable) {
        productTable.destroy();
        productTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    productTable = new Tabulator("#tab1", {
        height:"740px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/management/productInsert/productList",
        ajaxParams:{"corp_name": $("#corp_name").val()},
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
            {title:"제품", field:"product_file_name", width:70, hozAlign:"center", headerSort:false, formatter:"image",
                cssClass:"rp-img-popup",
                formatterParams:{height:"18px", width:"18px", urlPrefix:"/tkPrint/사진/제품등록/"}, 
                cellMouseEnter:function(e, cell){ 
                    if(typeof productImage === 'function') {
                        productImage(cell.getValue());
                    }
                } 
            },
            {title:"NO", field:"idx", sorter:"int", width:50, hozAlign:"center"},
            {title:"코드", field:"prod_code", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", visible:false},	
            {title:"등록일", field:"prod_date", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", headerSort:false},     
            {title:"거래처명", field:"corp_name", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", headerSort:false}, 
            {title:"품명", field:"prod_name", sorter:"string", width:150, hozAlign:"center", headerFilter:"input", headerSort:false}, 
            {title:"품번", field:"prod_no", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", headerSort:false},		        
            {title:"규격", field:"prod_gyu", sorter:"string", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"재질", field:"prod_jai", sorter:"string", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"공정", field:"tech_te", sorter:"string", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},	
            {title:"단중", field:"prod_danj", sorter:"int", width:70, hozAlign:"center", headerFilter:"input", headerSort:false},  	
            {title:"단위", field:"prod_danw", sorter:"int", width:70, hozAlign:"center", headerFilter:"input", headerSort:false},	
            {title:"단가(EA)", field:"prod_dang", sorter:"int", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},	
            {title:"단가(kG)", field:"prod_dang", sorter:"int", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"표면경도", field:"prod_pg", sorter:"int", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"경화깊이", field:"prod_gd3", sorter:"int", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"심부경도", field:"prod_sg", sorter:"int", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
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
            productInsertDetail(data.prod_code);
            
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

// ========== 제품 상세 조회 ==========
function productInsertDetail(prod_code) {
    $.ajax({
        url: "/tkheat/management/productInsert/productInsertDetail",
        type: "post",
        dataType: "json",
        data: { "prod_code": prod_code },
        success: function (result) {
            const d = result.data;

            // 폼 초기화
            $('#productInsertForm')[0].reset();

            // 기본 데이터 바인딩
            for (let key in d) {
                if (key === "prod_date") {
                    $("[name='" + key + "']").val(d[key].substring(0, 10));
                } else if (key.startsWith("prod_fac")) {
                    const checkbox = $("#" + key);
                    if (checkbox.length) {
                        const val = d[key] || "";
                        checkbox.prop("checked", val.includes("1"));
                    }
                } else {
                    $("[name='" + key + "']").val(d[key]);
                }
            }

            // 이미지 초기화
            $("#img0, #img1, #img2").attr("src", "/tkheat/css/image/no_image.png");
            $(".aphoto, .bphoto, .cphoto").attr("href", "").text("");

            // 제품 사진
            if (d.product_file_name) {
                const path = "/tkPrint/사진/제품등록/" + d.product_file_name;
                $("#img0").attr("src", path);
                $(".aphoto").attr("href", path).text(d.product_file_name);
            }

            // 외형 사진
            if (d.apperance_file_name) {
                const path = "/tkPrint/사진/제품등록/" + d.apperance_file_name;
                $("#img1").attr("src", path);
                $(".bphoto").attr("href", path).text(d.apperance_file_name);
            }

            // 열처리 사진
            if (d.heat_file_name) {
                const path = "/tkPrint/사진/제품등록/" + d.heat_file_name;
                $("#img2").attr("src", path);
                $(".cphoto").attr("href", path).text(d.heat_file_name);
            }

            // 도면파일
            if (d.drawing_file_name) {
                const path = "/tkPrint/사진/제품등록/" + d.drawing_file_name;
                $("#fileLink").attr("href", path).text(d.drawing_file_name);
            }

            // 모달 열기
            $('.modal-overlay, .product-modal').addClass('active');
        },
        error: function (xhr, status, error) {
            console.error("제품 상세 조회 오류:", error);
        }
    });
}

// ========== 거래처 검색 모달 ==========
function openCutumModal() {
    document.getElementById('cutumListModal').style.display = 'flex';

    let cutumListTable = new Tabulator("#cutumListTabulator", {
        height:"450px",
        layout:"fitColumns",
        selectable:true,
        ajaxURL:"/tkheat/management/cutumInsert/cutumInsertList",
        ajaxConfig:"POST",
        ajaxParams:{
            "corp_name": "",
            "corp_plc": "",
            "corp_gubn": "",
            "corp_mast": "",
            "corp_code": "",   
        },
        ajaxResponse:function(url, params, response){
            return response.data;
        },    
        columns:[
            {title:"구분ID", field:"corp_gubn", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"거래처명", field:"corp_name", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"사업자번호", field:"corp_no", sorter:"string", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"거래처코드", field:"corp_code", width:120, hozAlign:"center", visible:false},	
        ],
        rowDblClick:function(e, row){
            let data = row.getData();
            document.getElementById('corp_name').value = data.corp_name;
            document.getElementById('corp_code').value = data.corp_code;
            document.getElementById('cutumListModal').style.display = 'none';
        }
    });
}

function closeCutumListModal() {
    document.getElementById('cutumListModal').style.display = 'none';
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
    
    // 숫자 필드 검증
    const numericFields = ['prod_dang', 'prod_danj', 'prod_boxsu', 'prod_polish', 'tech_pattern'];
    numericFields.forEach(field => {
        const value = $('#' + field).val();
        if (value === '' || value === null || isNaN(value)) {
            $('#' + field).val('0');
        }
    });

    // 체크박스 처리
    const checkboxFields = ["prod_fac1", "prod_fac2", "prod_fac3", "prod_fac4", "prod_fac5", "prod_fac6", "prod_fac7", "prod_fac8"];
    
    checkboxFields.forEach(field => {
        $("#hidden_" + field).remove();
    });
    
    checkboxFields.forEach(field => {
        const checked = $("#" + field).is(":checked");
        $("<input>").attr({
            type: "hidden",
            id: "hidden_" + field,
            name: field,
            value: checked ? "1" : "0"
        }).appendTo("#productInsertForm");
    });

    var formData = new FormData($("#productInsertForm")[0]);

    let confirmMsg = "";
    if (isEditMode && selectedRowData && selectedRowData.prod_code) {
        formData.append("mode", "update");
        formData.append("prod_code", selectedRowData.prod_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
        formData.delete("prod_code");
    }

    if (!confirm(confirmMsg)) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/productInsert/productInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (result) {
            console.log("💾 저장 완료:", result);
            
            // ✅ 모달 닫기
            $('.modal-overlay, .product-modal').removeClass('active');
            
            // ✅ 모달 위치 초기화
            $('.product-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // ✅ 폼 초기화
            $('#productInsertForm')[0].reset();
            isEditMode = false;
            selectedRowData = null;
            
            // ✅ 테이블 리로드 먼저
            console.log("🔄 테이블 리로드 시작");
            getProductList();
            
            // ✅ 알림은 약간 지연 후 표시
            setTimeout(function() {
                alert("저장 되었습니다.");
            }, 200);
        },
        error: function (xhr, status, error) {
            console.error("❌ 저장 오류:", error);
            console.error("응답:", xhr.responseText);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 다른이름으로 저장 ==========
function saveAsNew() {
    console.log("💾 saveAsNew() 함수 시작");
    
    // ✅ 권한 체크 (등록 권한 필요)
    const permission = userPermissions?.[now_page_code];
    
    if (!['I', 'U', 'D'].includes(permission)) {
        alert("등록 권한이 없습니다.");
        console.log("⚠️ 다른이름으로 저장 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("✅ 다른이름으로 저장 권한 확인 완료");
    
    const checkboxFields = ["prod_fac1", "prod_fac2", "prod_fac3", "prod_fac4", "prod_fac5", "prod_fac6", "prod_fac7", "prod_fac8"];
    
    checkboxFields.forEach(field => {
        $("#hidden_" + field).remove();
    });
    
    checkboxFields.forEach(field => {
        const checked = $("#" + field).is(":checked");
        $("<input>").attr({
            type: "hidden",
            id: "hidden_" + field,
            name: field,
            value: checked ? "1" : "0"
        }).appendTo("#productInsertForm");
    });

    var formData = new FormData($("#productInsertForm")[0]);
    formData.append("mode", "insert");
    formData.delete("prod_code");

    if (!confirm("현재 데이터를 바탕으로 새 제품을 등록하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/productInsert/productInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (result) {
            console.log("💾 다른이름 저장 완료:", result);
            
            // ✅ 모달 닫기
            $('.modal-overlay, .product-modal').removeClass('active');
            
            // ✅ 모달 위치 초기화
            $('.product-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // ✅ 폼 초기화
            $('#productInsertForm')[0].reset();
            isEditMode = false;
            selectedRowData = null;
            
            // ✅ 테이블 리로드 먼저
            console.log("🔄 테이블 리로드 시작");
            getProductList();
            
            // ✅ 알림은 약간 지연 후 표시
            setTimeout(function() {
                alert("새로운 제품으로 저장되었습니다.");
            }, 200);
        },
        error: function (xhr, status, error) {
            console.error("❌ 다른이름 저장 오류:", error);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 삭제 ==========
function deleteProduct() {
    console.log("🗑️ deleteProduct() 함수 시작");
    
    // ✅ 권한 체크 (삭제 권한 필요)
    const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("⚠️ 삭제 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("✅ 삭제 권한 확인 완료");
    
    if (!selectedRowData || !selectedRowData.prod_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }

    if (!confirm("삭제하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/productInsert/productDelete",
        type: "POST",
        data: { prod_code: selectedRowData.prod_code },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                console.log("✅ 삭제 완료");
                
                // ✅ 모달 닫기
                $('.modal-overlay, .product-modal').removeClass('active');
                
                // ✅ 모달 위치 초기화
                $('.product-modal').css({
                    'left': '50%',
                    'top': '50%',
                    'transform': 'translate(-50%, -50%)'
                });
                
                // ✅ 폼 초기화
                $('#productInsertForm')[0].reset();
                isEditMode = false;
                selectedRowData = null;
                
                // ✅ 테이블 리로드 먼저
                console.log("🔄 테이블 리로드 시작");
                getProductList();
                
                // ✅ 알림은 약간 지연 후 표시
                setTimeout(function() {
                    alert("삭제되었습니다.");
                }, 200);
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
    const filename = "제품등록_" + today + ".xlsx";
    productTable.download("xlsx", filename, { sheetName: "제품등록" });
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
