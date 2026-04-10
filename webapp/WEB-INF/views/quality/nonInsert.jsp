<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부적합등록</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
    <style>
/* ========== 기본 스타일 ========== */
.main { width: 98%; }
.container { display: flex; justify-content: space-between; }
.tabulator { width: 100%; max-width: 100%; overflow-x: hidden !important; }
.tabulator .tabulator-cell { white-space: normal !important; word-break: break-word; text-align: center; }
.row_select { background-color: #9ABCEA !important; }
.box1 {
    display: flex; justify-content: right; align-items: center;
    width: 1500px; margin-left: -1030px; gap: 10px;
}
.box1 select { width: 5%; }
.box1 input[type="date"] {
    width: 150px; padding: 5px 10px; font-size: 16px;
    border: 1px solid #ccc; border-radius: 6px;
    background-color: #f9f9f9; color: #333;
    outline: none; transition: border 0.3s ease;
}
.box1 input[type="date"]:focus { border: 1px solid #007bff; background-color: #fff; }
.box1 label, .box1 input { margin-right: 10px; }

/* ========== 모달 오버레이 ========== */
.modal-overlay {
    display: none; position: fixed;
    top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0,0,0,0.5); z-index: 999;
}
.modal-overlay.active { display: block; }

/* ========== 부적합 모달 컨테이너 ========== */
.non-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
}
.non-modal.active { display: block; }

.non-insert-box {
    width: 1100px; max-width: 95vw;
    max-height: 95vh;
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    overflow: hidden; display: flex; flex-direction: column;
}

/* ========== 모달 헤더 ========== */
.non-header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 8px 16px;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white; font-size: 15px; font-weight: 700; cursor: move;
    flex-shrink: 0;
}
.header-close-btn {
    background: none; border: none; color: white;
    font-size: 22px; cursor: pointer;
    width: 26px; height: 26px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 4px; transition: all 0.3s;
}
.header-close-btn:hover { background: rgba(255,255,255,0.2); transform: rotate(90deg); }

/* ========== 모달 본문 ========== */
.non-modal-body {
    flex: 1; overflow-y: auto; overflow-x: hidden;
    background: #f5f7fa;
    padding: 8px 10px;
    max-height: calc(95vh - 90px);
}
.non-modal-body::-webkit-scrollbar { width: 5px; }
.non-modal-body::-webkit-scrollbar-track { background: #e0e0e0; }
.non-modal-body::-webkit-scrollbar-thumb { background: #999; border-radius: 4px; }

/* ========== 섹션 ========== */
.non-section {
    background: white; border-radius: 6px;
    padding: 6px 10px;
    margin-bottom: 5px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.non-section:last-child { margin-bottom: 0; }
.non-section-title {
    font-size: 11px; font-weight: 700; color: #2c3e50;
    margin-bottom: 5px;
    padding-bottom: 4px;
    border-bottom: 1px solid #e9ecef;
}

/* ========== 기본 행/열 레이아웃 ========== */
.non-row {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 6px; margin-bottom: 5px;
}
.non-row:last-child { margin-bottom: 0; }
.non-row-3 { grid-template-columns: repeat(3,1fr); }
.non-row-4 { grid-template-columns: repeat(4,1fr); }
.non-col { display: flex; flex-direction: column; gap: 2px; }
.non-col-full { grid-column: 1/-1; display: flex; flex-direction: column; gap: 2px; }
.non-col label, .non-col-full label {
    font-size: 10px; font-weight: 600; color: #495057;
}

/* ========== 입력 필드 ========== */
.non-col input[type="text"],
.non-col input[type="date"],
.non-col select,
.non-col-full input[type="text"],
.non-col-full textarea {
    width: 100%;
    padding: 3px 7px;
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 11px;
    box-sizing: border-box; transition: all 0.2s;
    height: 26px;
}
.non-col input[type="checkbox"] {
    width: 16px; height: 16px; cursor: pointer; margin-top: 4px;
}
.non-col input:focus, .non-col select:focus,
.non-col-full input:focus, .non-col-full textarea:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.non-col input[readonly], .non-col-full input[readonly] {
    background: #f1f3f5; cursor: not-allowed;
}
.non-col select {
    cursor: pointer; appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat; background-position: right 8px center; padding-right: 26px;
}
textarea {
    resize: vertical; height: 36px;
    min-height: unset; font-family: inherit;
}

/* ========== 검색 버튼이 있는 입력 ========== */
.input-with-button { display: flex; gap: 5px; }
.input-with-button input { flex: 1; }
.btn-search {
    padding: 3px 10px; border: 1px solid #4dabf7; border-radius: 4px;
    background: #4dabf7; color: white;
    font-size: 11px; font-weight: 600; cursor: pointer;
    white-space: nowrap; transition: all 0.2s;
}
.btn-search:hover { background: #339af0; }

/* ========== 다중 선택 ========== */
.multi-select { display: flex; gap: 5px; }
.multi-select select { flex: 1; }

/* ========== 이미지 업로드 영역 ========== */
.image-upload-area {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 8px; margin-top: 6px;
}
.image-upload-col { display: flex; flex-direction: column; gap: 4px; }
.image-upload-col label { font-size: 10px; font-weight: 600; color: #495057; }
.image-upload-col input[type="file"] {
    padding: 3px; border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer;
}
.img-preview {
    width: 100%; height: 100px;
    border: 2px dashed #ced4da; border-radius: 5px;
    display: flex; align-items: center; justify-content: center;
    background: #f8f9fa; overflow: hidden;
}
.img-preview img { max-width: 100%; max-height: 100%; object-fit: contain; }

/* ========== 유효성점검 특별 레이아웃 ========== */
.validity-row {
    display: grid; grid-template-columns: 50px 1fr;
    gap: 6px; margin-bottom: 5px;
    align-items: center;
}
.validity-row:last-child { margin-bottom: 0; }
.validity-label { font-size: 10px; font-weight: 600; color: #495057; text-align: center; }
.validity-fields { display: flex; gap: 5px; flex-wrap: nowrap; }
.validity-fields input {
    padding: 3px 6px; border: 1px solid #ced4da; border-radius: 3px;
    font-size: 11px; box-sizing: border-box; transition: all 0.2s;
    height: 24px;
}
.validity-fields input[type="date"] { width: 110px; }
.validity-fields input[type="text"] { width: 70px; }
.validity-fields .long-input { flex: 1; min-width: 120px; }
.validity-fields input:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}

/* ========== 파일 입력 ========== */
.file-input {
    margin-top: 4px; padding: 3px;
    border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer; width: 100%;
}

/* ========== 모달 푸터 ========== */
.non-modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 8px; padding: 7px 16px;
    background: white; border-top: 1px solid #dee2e6;
    flex-shrink: 0;
}
.non-modal-footer button {
    min-width: 80px; height: 30px;
    border: none; border-radius: 4px;
    font-size: 12px; font-weight: 700; cursor: pointer; transition: all 0.3s;
}
.save    { background: linear-gradient(135deg,#51cf66,#37b24d); color: white; }
.save:hover { background: linear-gradient(135deg,#40c057,#2f9e44); transform: translateY(-1px); }
.btn-delete { background: linear-gradient(135deg,#ff6b6b,#fa5252); color: white; }
.btn-delete:hover { background: linear-gradient(135deg,#f03e3e,#e03131); transform: translateY(-1px); }
.close   { background: linear-gradient(135deg,#868e96,#495057); color: white; }
.close:hover { background: linear-gradient(135deg,#6c757d,#343a40); transform: translateY(-1px); }

/* ========== 거래처 검색 모달 ========== */
#corpListModal {
    position: fixed; top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0,0,0,0.6);
    display: none; align-items: center; justify-content: center; z-index: 9999;
}
#corpListModal.active { display: flex; }
.modal-content {
    background: white; padding: 15px; border-radius: 8px;
    width: 90%; max-width: 1000px; position: relative;
}
.modal-header {
    display: flex; justify-content: space-between; align-items: center;
    font-weight: bold; font-size: 16px;
    margin-bottom: 10px; padding-bottom: 8px;
    border-bottom: 2px solid #e9ecef;
}
.modal-close { cursor: pointer; font-size: 22px; }

.corp-modal-overlay {
    position: fixed; top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0,0,0,0.6);
    display: none; align-items: center; justify-content: center; z-index: 10000;
}
.corp-modal-content {
    background: white; padding: 15px; border-radius: 8px;
    width: 90%; max-width: 1200px;
    max-height: 90vh; overflow: hidden;
    display: flex; flex-direction: column;
}
.corp-modal-header {
    display: flex; flex-direction: column; gap: 6px;
    margin-bottom: 10px; padding-bottom: 10px;
    border-bottom: 2px solid #e9ecef;
}
.corp-modal-search { display: flex; gap: 6px; align-items: center; }
.corp-modal-search input[type="date"],
.corp-modal-search input[type="text"] {
    padding: 4px 8px; border: 1px solid #ced4da; border-radius: 4px; font-size: 12px;
}
.corp-modal-search input[type="date"] { width: 130px; }
.corp-modal-search input[type="text"] { width: 130px; }
.btn-corp-search {
    padding: 4px 12px; border: 1px solid #4dabf7; border-radius: 4px;
    background: #4dabf7; color: white; font-size: 12px; font-weight: 600;
    cursor: pointer; transition: all 0.2s;
}
.btn-corp-search:hover { background: #339af0; }
.corp-modal-title-area { display: flex; justify-content: space-between; align-items: center; }
.corp-modal-title { font-weight: bold; font-size: 16px; color: #2c3e50; }
.modal-close {
    cursor: pointer; font-size: 24px; color: #495057;
    line-height: 1; transition: all 0.3s;
}
.modal-close:hover { color: #212529; transform: rotate(90deg); }
#corpListTabulator { flex: 1; overflow: auto; }

/* ========== 타뷸레이터 헤더 ========== */
.tabulator .tabulator-col { height: 55px !important; }
.tabulator .tabulator-col .tabulator-col-content {
    height: 100%; display: flex; flex-direction: column; justify-content: space-between;
}
.tabulator .tabulator-header-filter input::placeholder { color: transparent; }

/* ========== 반응형 ========== */
@media (max-width: 1200px) {
    .non-insert-box { width: 95vw; }
    .non-row, .non-row-3, .non-row-4 { grid-template-columns: repeat(2,1fr); }
    .image-upload-area { grid-template-columns: 1fr; }
    .validity-row { grid-template-columns: 1fr; }
    .validity-label { text-align: left; }
}
@media (max-width: 768px) {
    .non-row, .non-row-3, .non-row-4 { grid-template-columns: 1fr; }
}
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
		<label class="daylabel">기간 : </label>
		<input type="date" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off"> ~ 
		<input type="date" class="edate" id="edate" style="font-size: 16px;" autocomplete="off">
		
			
	</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getNonInsertList();">
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
	
	
<form autocomplete="off" method="post" id="nonInsertForm" name="nonInsertForm" enctype="multipart/form-data">
    <div class="modal-overlay"></div>
    
    <div class="non-modal">
        <div class="non-insert-box">
            <!-- 헤더 -->
            <div class="non-header">
                부적합등록
                <button type="button" class="header-close-btn">&times;</button>
            </div>
            
            <!-- 본문 -->
            <div class="non-modal-body">
                <!-- 기본정보 섹션 -->
                <div class="non-section">
                    <div class="non-section-title">기본정보</div>

                    <div class="non-row non-row-3">
                        <div class="non-col">
                            <label>거래처</label>
                            <div class="input-with-button">
                                <input type="text" id="corp_name" name="corp_name" readonly>
                                <button type="button" class="btn-search" onclick="openCorpListModal();">검색</button>
                            </div>
                        </div>
                        <div class="non-col">
                            <label>품명</label>
                            <input type="text" id="prod_name" name="prod_name" readonly>
                        </div>
                        <div class="non-col">
                            <label>품번</label>
                            <input type="text" id="prod_no" name="prod_no" readonly>
                        </div>
                    </div>

                    <div class="non-row non-row-3">
                        <div class="non-col">
                            <label>작성일자</label>
                            <input type="date" id="werr_date" name="werr_date">
                        </div>
                        <div class="non-col">
                            <label>발생일자</label>
                            <input type="text" id="werr_wdate" name="werr_wdate" class="date js-datepicker">
                        </div>
                        <div class="non-col">
                            <label>발생자</label>
                            <input type="text" id="werr_user" name="werr_user">
                        </div>
                    </div>

                    <div class="non-row non-row-4">
                        <div class="non-col">
                            <label>금액</label>
                            <input type="text" id="werr_mon" name="werr_mon">
                        </div>
                        <div class="non-col">
                            <label>생산수량</label>
                            <input type="text" id="werr_amnt" name="werr_amnt" value="0">
                        </div>
                        <div class="non-col">
                            <label>설비</label>
                            <input type="text" id="fac_name" name="fac_name" readonly>
                        </div>
                        <div class="non-col">
                            <label>열처리LOT</label>
                            <input type="text" id="tech_te" name="tech_te" readonly>
                        </div>
                    </div>

                    <input type="hidden" id="ilbo_code" name="ilbo_code" value="0">
                    <input type="hidden" id="ilbo_no" name="ilbo_no" value="0">
                    <input type="hidden" id="werr_code" name="werr_code" value="0">
                    <input type="hidden" id="ilbo_lot" name="ilbo_lot">
                    <input type="hidden" id="werr_lot" name="werr_lot">
                    <input type="hidden" id="werr_yu" name="werr_yu">
                </div>

                <!-- 부적합등록 섹션 -->
                <div class="non-section">
                    <div class="non-section-title">부적합등록</div>

                    <div class="non-row non-row-4">
                        <div class="non-col">
                            <label>알림</label>
                            <input type="checkbox" id="werr_alert" name="werr_alert" checked>
                        </div>
                        <div class="non-col">
                            <label>부서</label>
                            <select id="werr_buso" name="werr_buso">
                                <option value=""></option>
                                <option value="생산">생산</option>
                                <option value="품질">품질</option>
                                <option value="영업">영업</option>
                                <option value="관리">관리</option>
                            </select>
                        </div>
                        <div class="non-col">
                            <label>불량구분</label>
                            <div class="multi-select">
                                <select id="werr_gubn" name="werr_gubn">
                                    <option selected>찍힘</option>
                                    <option>외관(이물)</option>
                                    <option>외관(발청)</option>
                                    <option>외관(조도)</option>
                                    <option>경도</option>
                                    <option>경화깊이</option>
                                    <option>조직</option>
                                    <option>크랙</option>
                                    <option>사양오적용(혼입)</option>
                                    <option>변형</option>
                                </select>
                                <select id="werr_inoutgubn" name="werr_inoutgubn">
                                    <option selected>사내</option>
                                    <option>사외</option>
                                </select>
                            </div>
                        </div>
                        <div class="non-col">
                            <label>조치구분</label>
                            <select id="werr_jgubn" name="werr_jgubn">
                                <option>재작업</option>
                                <option>폐기</option>
                                <option>업체통보후납품</option>
                                <option>별도관리(보관)</option>
                                <option>기타</option>
                            </select>
                        </div>
                    </div>

                    <div class="non-row non-row-3">
                        <div class="non-col">
                            <label>불량내용</label>
                            <textarea id="werr_gnote" name="werr_gnote"></textarea>
                        </div>
                        <div class="non-col">
                            <label>발생원인 및 원인분석</label>
                            <textarea id="werr_case" name="werr_case"></textarea>
                        </div>
                        <div class="non-col">
                            <label>대책수립 및 대책실시</label>
                            <textarea id="werr_jnote" name="werr_jnote"></textarea>
                            <input type="file" name="werr_fname" id="werr_fname" class="file-input">
                        </div>
                    </div>

                    <div class="image-upload-area">
                        <div class="image-upload-col">
                            <label>개선전</label>
                            <input type="file" name="imageFile1" onchange="previewImage(this,'previewId1')">
                            <div class="img-preview" id="previewId1">
                                <img id="prev_previewId1" src="/resources/images/noimage_01.gif" alt="개선전">
                            </div>
                        </div>
                        <div class="image-upload-col">
                            <label>개선후</label>
                            <input type="file" name="imageFile2" onchange="previewImage(this,'previewId2')">
                            <div class="img-preview" id="previewId2">
                                <img id="prev_previewId2" src="/resources/images/noimage_01.gif" alt="개선후">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 유효성점검 섹션 -->
                <div class="non-section">
                    <div class="non-section-title">유효성점검</div>

                    <div class="validity-row">
                        <label class="validity-label">1차</label>
                        <div class="validity-fields">
                            <input type="date" id="check_date_a" name="check_date_a" placeholder="확인일자">
                            <input type="text" id="werr_user1" name="werr_user1" placeholder="확인자">
                            <input type="text" id="werr_note1" name="werr_note1" placeholder="점검내용" class="long-input">
                            <input type="text" id="werr_bigo1" name="werr_bigo1" placeholder="비고">
                        </div>
                    </div>

                    <div class="validity-row">
                        <label class="validity-label">2차</label>
                        <div class="validity-fields">
                            <input type="date" id="check_date_b" name="check_date_b" placeholder="확인일자">
                            <input type="text" id="werr_user2" name="werr_user2" placeholder="확인자">
                            <input type="text" id="werr_note2" name="werr_note2" placeholder="점검내용" class="long-input">
                            <input type="text" id="werr_bigo2" name="werr_bigo2" placeholder="비고">
                        </div>
                    </div>

                    <div class="validity-row">
                        <label class="validity-label">3차</label>
                        <div class="validity-fields">
                            <input type="date" id="check_date_c" name="check_date_c" placeholder="확인일자">
                            <input type="text" id="werr_user3" name="werr_user3" placeholder="확인자">
                            <input type="text" id="werr_note3" name="werr_note3" placeholder="점검내용" class="long-input">
                            <input type="text" id="werr_bigo3" name="werr_bigo3" placeholder="비고">
                        </div>
                    </div>
                </div>
            </div>

            <!-- 푸터 버튼 -->
            <div class="non-modal-footer">
                <button type="button" class="btn-delete" onclick="deleteNon();" style="display:none;">삭제</button>
                <button type="button" class="save">저장</button>
                <button type="button" class="close">닫기</button>
            </div>
        </div>
    </div>
</form>



	      
			   <!-- 거래처 검색 모달 -->
		<div id="corpListModal" class="corp-modal-overlay" style="display: none;">
		    <div class="corp-modal-content">
		        <div class="corp-modal-header">
		            <div class="corp-modal-search">
		                <input type="date" class="subsdate" id="subsdate" style="font-size: 14px;">
		                <span>~</span>
		                <input type="date" class="subedate" id="subedate" style="font-size: 14px;">
		                <input type="text" id="subilbo_lot" placeholder="LOT 번호">
		                <button type="button" class="btn-corp-search" onclick="openCorpListModalData();">조회</button>
		            </div>
		            <div class="corp-modal-title-area">
		                <span class="corp-modal-title">부적합등록 검색</span>
		                <span class="modal-close">&times;</span>
		            </div>
		        </div>
		        <div id="corpListTabulator" style="height: 450px;"></div>
		    </div>
		</div>
	    
<script>
//========== 전역변수 ==========
let now_page_code = "f02";
var nonTable;
var isEditMode = false;
var selectedRowData = null;

// ========== 페이지 로드 ==========
$(function(){
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    
    var tdate = todayDate();
    var ydate = yesterDate();
    var beforeMonth = beforeMonthDate();
    
    $("#sdate").val(ydate);
    $("#edate").val(tdate);
    $("#subsdate").val(beforeMonth);
    $("#subedate").val(tdate);
    getNonInsertList();

    // ★ 모달 열기/닫기 이벤트 - 중복 방지를 위해 페이지 로드 시 1회만 등록
    const insertButton = document.querySelector('.insert-button');
    const nonModal     = document.querySelector('.non-modal');
    const modalOverlay = document.querySelector('.modal-overlay');
    const closeButton  = document.querySelector('.close');
    const headerCloseBtn = document.querySelector('.header-close-btn');

    insertButton.addEventListener('click', function() {
        isEditMode = false;
        selectedRowData = null;
        
        $('#nonInsertForm')[0].reset();
        
        $('#prev_previewId1').attr('src', '/resources/images/noimage_01.gif');
        $('#prev_previewId2').attr('src', '/resources/images/noimage_01.gif');
        
        $('#ilbo_code').val('0');
        $('#ilbo_no').val('0');
        $('#werr_code').val('0');
        $('#werr_amnt').val('0');
        $('#werr_mon').val('0');
        
        // ★ 작성일자 오늘날짜 기본값
        const today = new Date();
        const todayStr = today.getFullYear() + '-' +
            String(today.getMonth() + 1).padStart(2, '0') + '-' +
            String(today.getDate()).padStart(2, '0');
        $('#werr_date').val(todayStr);
        
        // ★ 부서 기본값 품질
        $('#werr_buso').val('품질');
        
        nonModal.style.left = '50%';
        nonModal.style.top = '50%';
        nonModal.style.transform = 'translate(-50%, -50%)';
        
        modalOverlay.classList.add('active');
        nonModal.classList.add('active');
        
        $('.btn-delete').hide();
    });

    closeButton.addEventListener('click', function() {
        modalOverlay.classList.remove('active');
        nonModal.classList.remove('active');
    });

    headerCloseBtn.addEventListener('click', function() {
        modalOverlay.classList.remove('active');
        nonModal.classList.remove('active');
    });

    // ★ 저장 버튼 중복 방지
    $('.save').off('click').on('click', function() {
        save();
    });
});

// ========== 부적합등록 리스트 조회 ==========
function getNonInsertList(){
    if (nonTable) {
        nonTable.destroy();
        nonTable = null;
    }
    $('#tab1').empty();
    
    nonTable = new Tabulator("#tab1", {
        height:"730px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
        headerSort:false,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/quality/nonInsert/getNonInsertList",
        ajaxParams:{
            "sdate": $("#sdate").val(),
            "edate": $("#edate").val(),
        },
        placeholder:"조회된 데이터가 없습니다.",
        pagination:"local",
        paginationSize:20,
        paginationSizeSelector:[20,50,100,500,1000],
        paginationCounter:"rows",
        headerFilterPlaceholder: "",
        columnDefaults: { headerSort: false },  // ★ 헤더소트 통일

        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
            return response.data ? response.data : [];
        },
        
        columns:[
            {title:"검사일",    field:"werr_date", sorter:"string", width:120, hozAlign:"center", frozen:true},
            {title:"거래처",    field:"corp_name", sorter:"string", width:230, hozAlign:"center", headerFilter:"input"},
            {title:"품명",      field:"prod_name", sorter:"string", width:250, hozAlign:"center", headerFilter:"input"},
            {title:"품번",      field:"prod_no",   sorter:"string", width:240, hozAlign:"center", headerFilter:"input"},
            {title:"열처리LOT", field:"ilbo_lot",  sorter:"string", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"유형",      field:"werr_gubn", sorter:"string", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"수량",      field:"werr_amnt", sorter:"int",    width:140, hozAlign:"center", headerFilter:"input"},
            {title:"금액",      field:"werr_mon",  sorter:"int",    width:100, hozAlign:"center", headerFilter:"input"},
            {title:"코드",      field:"werr_code", width:200,       hozAlign:"center", visible:false},
        ],
        
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },
        
        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
        },
        
        rowDblClick:function(e, row){
            if (window.disableRowDblClick) {
                alert("수정 권한이 없습니다.");
                return false;
            }
            
            const permission = userPermissions?.[now_page_code];
            if (!['U', 'D'].includes(permission)) {
                alert("수정 권한이 없습니다.");
                return false;
            }

            var data = row.getData();
            selectedRowData = data;
            isEditMode = true;
            
            nonInsertDetail(data.werr_code);

            // ★ 삭제버튼 한 번만 처리
            if (permission === 'D') {
                $('.btn-delete').show();
            } else {
                $('.btn-delete').hide();
            }
        },
    });
}

// ========== 부적합등록 상세 조회 ==========
function nonInsertDetail(werr_code){
    $.ajax({
        url:"/tkheat/quality/nonInsert/nonInsertDetail",
        type:"post",
        dataType:"json",
        data:{ "werr_code": werr_code },
        success:function(result){
            var allData = result.data;
            
            $('#nonInsertForm')[0].reset();
            
            for(let key in allData){
                const value = allData[key];
                const $element = $("[name='"+key+"']");
                
                if ($element.length) {
                    const safeValue = (value === null || value === undefined) ? '' : value;
                    
                    if ($element.attr('type') === 'checkbox') {
                        $element.prop('checked', value === 'Y' || value === true);
                    } else if ($element.attr('type') === 'date') {
                        if (safeValue && safeValue !== '') {
                            $element.val(safeValue.replace(/[./]/g, '-').substring(0, 10));
                        }
                    } else {
                        $element.val(safeValue);
                    }
                }
            }
            
            if (allData.imageFile1Path) {
                $('#prev_previewId1').attr('src', allData.imageFile1Path);
            }
            if (allData.imageFile2Path) {
                $('#prev_previewId2').attr('src', allData.imageFile2Path);
            }
            
            $('.modal-overlay').addClass('active');
            $('.non-modal').addClass('active');
        },
        error: function(xhr, status, error) {
            console.error("❌ 상세 조회 오류:", error);
            alert("데이터를 불러오는 중 오류가 발생했습니다.");
        }
    });
}

// ========== 저장 ==========
function save() {
    // ★ 중복 클릭 방지
    if ($('.save').prop('disabled')) return;
    $('.save').prop('disabled', true);

    console.log("💾 save() 함수 시작");

    const permission = userPermissions?.[now_page_code];
    
    if (!isEditMode) {
        if (!['I', 'U', 'D'].includes(permission)) {
            alert("등록 권한이 없습니다.");
            $('.save').prop('disabled', false);
            return false;
        }
    } else {
        if (!['U', 'D'].includes(permission)) {
            alert("수정 권한이 없습니다.");
            $('.save').prop('disabled', false);
            return false;
        }
    }
    
    var formData = new FormData($("#nonInsertForm")[0]);
    let confirmMsg = "";
    
    if (isEditMode && selectedRowData && selectedRowData.werr_code) {
        formData.append("mode", "update");
        formData.append("werr_code", selectedRowData.werr_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
    }
    
    if (!$("#werr_amnt").val()) formData.set("werr_amnt", "0");
    if (!$("#werr_mon").val())  formData.set("werr_mon",  "0");
    
    formData.delete("werr_alert");
    formData.append("werr_alert", $("#werr_alert").is(":checked") ? "Y" : "N");
    
    const dateFields = ['werr_date', 'werr_wdate', 'check_date_a', 'check_date_b', 'check_date_c'];
    dateFields.forEach(field => {
        if (!$("#" + field).val()) formData.delete(field);
    });
    
    const hiddenFields = ['ilbo_code', 'ilbo_no', 'werr_code', 'ilbo_lot', 'werr_lot', 'werr_yu'];
    hiddenFields.forEach(field => {
        const value = $("#" + field).val();
        if (!value || value === '' || value === 'null' || value === 'undefined') {
            formData.delete(field);
            if (field === 'ilbo_code' || field === 'ilbo_no') {
                formData.append(field, "0");
            }
        }
    });
    
    if (!$('#werr_fname')[0].files.length)              formData.delete('werr_fname');
    if (!$('input[name="imageFile1"]')[0].files.length) formData.delete('imageFile1');
    if (!$('input[name="imageFile2"]')[0].files.length) formData.delete('imageFile2');
    
    if (!confirm(confirmMsg)) {
        $('.save').prop('disabled', false);  // ★ 취소 시 다시 활성화
        return;
    }
    
    $.ajax({
        url: "/tkheat/quality/nonInsert/nonInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 저장 완료:", result);
            $('.save').prop('disabled', false);  // ★ 완료 후 활성화
            alert("저장 되었습니다.");
            
            $('.modal-overlay').removeClass('active');
            $('.non-modal').removeClass('active');
            $('.non-modal').css({ 'left':'50%', 'top':'50%', 'transform':'translate(-50%, -50%)' });
            
            $('#nonInsertForm')[0].reset();
            isEditMode = false;
            selectedRowData = null;
            
            setTimeout(function() { getNonInsertList(); }, 300);
        },
        error: function(xhr, status, error) {
            console.error("❌ 저장 오류:", xhr.status, error);
            $('.save').prop('disabled', false);  // ★ 오류 시 활성화
            
            let errorMsg = "저장 중 오류가 발생했습니다.";
            if (xhr.status === 400) errorMsg += "\n\n[400] 필수 입력 항목을 확인해주세요.";
            else if (xhr.status === 500) errorMsg += "\n\n[500] 서버 내부 오류가 발생했습니다.";
            alert(errorMsg);
        }
    });
}

// ========== 삭제 ==========
function deleteNon() {
    const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        return false;
    }
    
    if (!selectedRowData || !selectedRowData.werr_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }
    
    if (!confirm("삭제하시겠습니까?")) return;
    
    $.ajax({
        url: "/tkheat/quality/nonInsert/deleteNon",
        type: "POST",
        data: { werr_code: selectedRowData.werr_code },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay').removeClass('active');
                $('.non-modal').removeClass('active');
                setTimeout(function() { getNonInsertList(); }, 300);
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

// ========== 거래처 검색 모달 열기 ==========
function openCorpListModal(){
    document.getElementById('corpListModal').style.display = 'flex';
    openCorpListModalData();
}

function closeCorpListModal() {
    document.getElementById('corpListModal').style.display = 'none';
}

// ========== 거래처 검색 리스트 ==========
function openCorpListModalData() {
    if (window.facListTable) {
        window.facListTable.destroy();
        window.facListTable = null;
    }
    $('#corpListTabulator').empty();
    
    window.facListTable = new Tabulator("#corpListTabulator", {
        height:"450px",
        layout:"fitColumns",
        selectable:true,
        columnDefaults: { headerSort: false },
        headerFilterPlaceholder: "",
        pagination:"local",
        paginationSize:20,
        paginationSizeSelector:[20,50,100,500,1000],
        paginationCounter:"rows",
        ajaxURL:"/tkheat/quality/nonInsert/getNonCorpList",
        ajaxConfig:"POST",
        ajaxParams:{
            "fac_code":  $("#fac_code").val()  || 0,
            "ord_code":  $("#ord_code").val()  || 0,
            "prod_code": $("#prod_code").val() || 0,
            "ilbo_code": $("#ilbo_code").val() || 0,
            "ilbo_no":   $("#ilbo_no").val()   || 0,
            "corp_code": $("#corp_code").val() || 0,
            "ilbo_lot":  $("#subilbo_lot").val(),
            "sdate":     $("#subsdate").val(),
            "edate":     $("#subedate").val()
        },
        ajaxResponse:function(url, params, response){
            return response.data;
        },
        columns:[
            {title:"NO",       field:"idx",       width:40,  hozAlign:"center"},
            {title:"입고일",    field:"ord_date",  width:100, hozAlign:"center", headerFilter:"input"},
            {title:"생산일",    field:"ilbo_date", width:100, hozAlign:"center", headerFilter:"input"},
            {title:"거래처",    field:"corp_name", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"품명",      field:"prod_name", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"품번",      field:"prod_no",   width:150, hozAlign:"center", headerFilter:"input"},
            {title:"공정",      field:"tech_te",   width:80,  hozAlign:"center", headerFilter:"input"},
            {title:"설비",      field:"fac_name",  width:100, hozAlign:"center", headerFilter:"input"},
            {title:"수량",      field:"ilbo_su",   width:60,  hozAlign:"center"},
            {title:"고객LOT",   field:"ord_lot",   width:80,  hozAlign:"center", headerFilter:"input"},
            {title:"열처리LOT", field:"ilbo_lot",  width:100, hozAlign:"center", headerFilter:"input"},
            {title:"ord_code",  field:"ord_code",  width:200, hozAlign:"center", visible:false},
            {title:"fac_code",  field:"fac_code",  width:200, hozAlign:"center", visible:false},
            {title:"prod_code", field:"prod_code", width:200, hozAlign:"center", visible:false},
            {title:"ilbo_code", field:"ilbo_code", width:200, hozAlign:"center", visible:false},
            {title:"ilbo_no",   field:"ilbo_no",   width:200, hozAlign:"center", visible:false},
            {title:"corp_code", field:"corp_code", width:200, hozAlign:"center", visible:false},
        ],
        rowClick:function(e, row){
            $("#corpListTabulator .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
        },
        rowDblClick:function(e, row){
            let data = row.getData();
            
            document.getElementById('werr_wdate').value = data.ilbo_date || '';
            document.getElementById('corp_name').value  = data.corp_name || '';
            document.getElementById('prod_name').value  = data.prod_name || '';
            document.getElementById('prod_no').value    = data.prod_no   || '';
            document.getElementById('fac_name').value   = data.fac_name  || '';
            document.getElementById('ilbo_lot').value   = data.ilbo_lot  || '';
            document.getElementById('tech_te').value    = data.tech_te   || '';
            
            $('#ilbo_code').val(data.ilbo_code || 0);
            $('#ilbo_no').val(data.ilbo_no     || 0);
            
            closeCorpListModal();
        }
    });
}

// ========== 모달 외부 클릭 시 닫기 ==========
$(document).on('click', '#corpListModal', function(e) {
    if (e.target.id === 'corpListModal') closeCorpListModal();
});

$(document).on('click', '.modal-close', function() {
    closeCorpListModal();
});

// ========== 드래그 기능 ==========
const modal  = document.querySelector('.non-modal');
const header = document.querySelector('.non-header');

header.addEventListener('mousedown', function(e) {
    if (e.target.classList.contains('header-close-btn') || e.target.closest('.header-close-btn')) return;
    
    const rect = modal.getBoundingClientRect();
    modal.style.left      = rect.left + 'px';
    modal.style.top       = rect.top  + 'px';
    modal.style.transform = 'none';
    
    let offsetX = e.clientX - rect.left;
    let offsetY = e.clientY - rect.top;
    
    function moveModal(e) {
        modal.style.left = (e.clientX - offsetX) + 'px';
        modal.style.top  = (e.clientY - offsetY) + 'px';
    }
    function stopMove() {
        window.removeEventListener('mousemove', moveModal);
        window.removeEventListener('mouseup',   stopMove);
    }
    window.addEventListener('mousemove', moveModal);
    window.addEventListener('mouseup',   stopMove);
});

// ========== 이미지 미리보기 ==========
function previewImage(input, previewId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#prev_' + previewId).attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

// ========== 엑셀 다운로드 ==========
$(".excel-button").off('click').on('click', function() {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    nonTable.download("xlsx", "부적합등록_" + today + ".xlsx", { sheetName: "부적합등록" });
});
    </script>
    

	</body>
</html>
