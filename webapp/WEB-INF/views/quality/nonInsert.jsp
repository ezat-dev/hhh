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
.main {
    width: 98%;
}

.container {
    display: flex;
    justify-content: space-between;
}

.tabulator {
    width: 100%;
    max-width: 100%;
    overflow-x: hidden !important;
}

.tabulator .tabulator-cell {
    white-space: normal !important;
    word-break: break-word;
    text-align: center;
}

.row_select {
    background-color: #9ABCEA !important;
}

.box1 {
    display: flex;
    justify-content: right;
    align-items: center;
    width: 1500px;
    margin-left: -1030px;
    gap: 10px;
}

.box1 select {
    width: 5%;
}

.box1 input[type="date"] {
    width: 150px;
    padding: 5px 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #f9f9f9;
    color: #333;
    outline: none;
    transition: border 0.3s ease;
}

.box1 input[type="date"]:focus {
    border: 1px solid #007bff;
    background-color: #fff;
}

.box1 label,
.box1 input {
    margin-right: 10px;
}

/* ========== 모달 오버레이 ========== */
.modal-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999;
}

.modal-overlay.active {
    display: block;
}

/* ========== 부적합 모달 컨테이너 ========== */
.non-modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
}

.non-modal.active {
    display: block;
}

.non-insert-box {
    width: 1100px;
    max-width: 95vw;
    max-height: 90vh;
    background: white;
    border-radius: 10px;
    box-shadow: 0 10px 50px rgba(0, 0, 0, 0.3);
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

/* ========== 모달 헤더 ========== */
.non-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 25px;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white;
    font-size: 20px;
    font-weight: 700;
    cursor: move;
}

.header-close-btn {
    background: none;
    border: none;
    color: white;
    font-size: 28px;
    cursor: pointer;
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 4px;
    transition: all 0.3s;
}

.header-close-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: rotate(90deg);
}

/* ========== 모달 본문 ========== */
.non-modal-body {
    flex: 1;
    overflow-y: auto;
    overflow-x: hidden;
    background: #f5f7fa;
    padding: 20px;
    max-height: 700px;
}

.non-modal-body::-webkit-scrollbar {
    width: 8px;
}

.non-modal-body::-webkit-scrollbar-track {
    background: #e0e0e0;
}

.non-modal-body::-webkit-scrollbar-thumb {
    background: #999;
    border-radius: 4px;
}

/* ========== 섹션 ========== */
.non-section {
    background: white;
    border-radius: 8px;
    padding: 15px 20px;
    margin-bottom: 15px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.non-section:last-child {
    margin-bottom: 0;
}

.non-section-title {
    font-size: 15px;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 12px;
    padding-bottom: 8px;
    border-bottom: 2px solid #e9ecef;
}

/* ========== 기본 행/열 레이아웃 ========== */
.non-row {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
    margin-bottom: 10px;
}

.non-row:last-child {
    margin-bottom: 0;
}

.non-col {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.non-col-full {
    grid-column: 1 / -1;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.non-col label,
.non-col-full label {
    font-size: 13px;
    font-weight: 600;
    color: #495057;
}

/* ========== 입력 필드 ========== */
.non-col input[type="text"],
.non-col input[type="date"],
.non-col input[type="checkbox"],
.non-col select,
.non-col-full input[type="text"],
.non-col-full textarea {
    padding: 8px 12px;
    border: 1px solid #ced4da;
    border-radius: 5px;
    font-size: 13px;
    box-sizing: border-box;
    transition: all 0.3s;
}

.non-col input[type="text"],
.non-col input[type="date"],
.non-col select,
.non-col-full input[type="text"],
.non-col-full textarea {
    width: 100%;
}

.non-col input[type="checkbox"] {
    width: 20px;
    height: 20px;
    cursor: pointer;
}

.non-col input:focus,
.non-col select:focus,
.non-col-full input:focus,
.non-col-full textarea:focus {
    outline: none;
    border-color: #4dabf7;
    box-shadow: 0 0 0 3px rgba(77, 171, 247, 0.1);
}

.non-col input[readonly],
.non-col-full input[readonly] {
    background: #f1f3f5;
    cursor: not-allowed;
}

.non-col select {
    cursor: pointer;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 10px center;
    padding-right: 32px;
}

textarea {
    resize: vertical;
    min-height: 60px;
    font-family: inherit;
}

/* ========== 검색 버튼이 있는 입력 ========== */
.input-with-button {
    display: flex;
    gap: 8px;
}

.input-with-button input {
    flex: 1;
}

.btn-search {
    padding: 8px 16px;
    border: 1px solid #4dabf7;
    border-radius: 5px;
    background: #4dabf7;
    color: white;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
    white-space: nowrap;
}

.btn-search:hover {
    background: #339af0;
    transform: translateY(-1px);
}

/* ========== 다중 선택 ========== */
.multi-select {
    display: flex;
    gap: 8px;
}

.multi-select select {
    flex: 1;
}

/* ========== 이미지 업로드 영역 ========== */
.image-upload-area {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
    margin-top: 15px;
}

.image-upload-col {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.image-upload-col label {
    font-size: 13px;
    font-weight: 600;
    color: #495057;
}

.image-upload-col input[type="file"] {
    padding: 6px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 12px;
    cursor: pointer;
}

.img-preview {
    width: 100%;
    height: 200px;
    border: 2px dashed #ced4da;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f8f9fa;
    overflow: hidden;
}

.img-preview img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

/* ========== 유효성점검 특별 레이아웃 ========== */
.validity-row {
    display: grid;
    grid-template-columns: 60px 1fr;
    gap: 10px;
    margin-bottom: 10px;
    align-items: center;
}

.validity-row:last-child {
    margin-bottom: 0;
}

.validity-label {
    font-size: 13px;
    font-weight: 600;
    color: #495057;
    text-align: center;
}

.validity-fields {
    display: flex;
    gap: 8px;
    flex-wrap: wrap;
}

.validity-fields input {
    padding: 6px 10px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 12px;
    box-sizing: border-box;
    transition: all 0.3s;
}

.validity-fields input[type="date"] {
    width: 140px;
}

.validity-fields input[type="text"] {
    width: 100px;
}

.validity-fields .long-input {
    flex: 1;
    min-width: 200px;
}

.validity-fields input:focus {
    outline: none;
    border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77, 171, 247, 0.1);
}

/* ========== 파일 입력 ========== */
.file-input {
    margin-top: 8px;
    padding: 6px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 12px;
    cursor: pointer;
}

/* ========== 모달 푸터 ========== */
.non-modal-footer {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    padding: 15px 20px;
    background: white;
    border-top: 1px solid #dee2e6;
}

.non-modal-footer button {
    min-width: 100px;
    height: 38px;
    border: none;
    border-radius: 5px;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s;
}

.save {
    background: linear-gradient(135deg, #51cf66, #37b24d);
    color: white;
}

.save:hover {
    background: linear-gradient(135deg, #40c057, #2f9e44);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(64, 192, 87, 0.3);
}

.btn-delete {
    background: linear-gradient(135deg, #ff6b6b, #fa5252);
    color: white;
}

.btn-delete:hover {
    background: linear-gradient(135deg, #f03e3e, #e03131);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(240, 62, 62, 0.3);
}

.close {
    background: linear-gradient(135deg, #868e96, #495057);
    color: white;
}

.close:hover {
    background: linear-gradient(135deg, #6c757d, #343a40);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
}

/* ========== 제품 검색 모달 ========== */
#corpListModal {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.6);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 9999;
}

#corpListModal.active {
    display: flex;
}

.modal-content {
    background: white;
    padding: 20px;
    border-radius: 8px;
    width: 90%;
    max-width: 1000px;
    position: relative;
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
    font-size: 18px;
    margin-bottom: 15px;
    padding-bottom: 10px;
    border-bottom: 2px solid #e9ecef;
}

.modal-close {
    cursor: pointer;
    font-size: 24px;
}

/* ========== 반응형 ========== */
@media (max-width: 1200px) {
    .non-insert-box {
        width: 95vw;
    }
    
    .non-row {
        grid-template-columns: 1fr;
    }
    
    .image-upload-area {
        grid-template-columns: 1fr;
    }
    
    .validity-row {
        grid-template-columns: 1fr;
    }
    
    .validity-label {
        text-align: left;
    }
}
    
    
    
    
    /* ========== 거래처 검색 모달 ========== */
.corp-modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.6);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 10000;
}

.corp-modal-content {
    background: white;
    padding: 20px;
    border-radius: 8px;
    width: 90%;
    max-width: 1200px;
    max-height: 90vh;
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

.corp-modal-header {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-bottom: 15px;
    padding-bottom: 15px;
    border-bottom: 2px solid #e9ecef;
}

.corp-modal-search {
    display: flex;
    gap: 8px;
    align-items: center;
}

.corp-modal-search input[type="date"],
.corp-modal-search input[type="text"] {
    padding: 6px 10px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 13px;
}

.corp-modal-search input[type="date"] {
    width: 140px;
}

.corp-modal-search input[type="text"] {
    width: 150px;
}

.btn-corp-search {
    padding: 6px 16px;
    border: 1px solid #4dabf7;
    border-radius: 4px;
    background: #4dabf7;
    color: white;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
}

.btn-corp-search:hover {
    background: #339af0;
}

.corp-modal-title-area {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.corp-modal-title {
    font-weight: bold;
    font-size: 18px;
    color: #2c3e50;
}

.modal-close {
    cursor: pointer;
    font-size: 28px;
    color: #495057;
    line-height: 1;
    transition: all 0.3s;
}

.modal-close:hover {
    color: #212529;
    transform: rotate(90deg);
}

#corpListTabulator {
    flex: 1;
    overflow: auto;
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
	
	
<form method="post" id="nonInsertForm" name="nonInsertForm" enctype="multipart/form-data">
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
                    
                    <div class="non-row">
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
                    </div>
                    
                    <div class="non-row">
                        <div class="non-col">
                            <label>품번</label>
                            <input type="text" id="prod_no" name="prod_no" readonly>
                        </div>
                        <div class="non-col">
                            <label>금액</label>
                            <input type="text" id="werr_mon" name="werr_mon">
                        </div>
                    </div>
                    
                    <div class="non-row">
                        <div class="non-col">
                            <label>작성일자</label>
                            <input type="date" id="werr_date" name="werr_date">
                        </div>
                        <div class="non-col">
                            <label>발생일자</label>
                            <input type="text" id="werr_wdate" name="werr_wdate" class="date js-datepicker">
                        </div>
                    </div>
                    
                    <div class="non-row">
                        <div class="non-col">
                            <label>발생자</label>
                            <input type="text" id="werr_user" name="werr_user">
                        </div>
                        <div class="non-col">
                            <label>보고자</label>
                            <input type="text" id="werr_rep" name="werr_rep" value="admin">
                        </div>
                    </div>
                    
                    <div class="non-row">
                        <div class="non-col">
                            <label>생산수량</label>
                            <input type="text" id="werr_amnt" name="werr_amnt" value="0">
                        </div>
                        <div class="non-col">
                            <label>설비</label>
                            <input type="text" id="fac_name" name="fac_name" readonly>
                        </div>
                    </div>
                    
                    <div class="non-row">
                        <div class="non-col">
                            <label>열처리LOT</label>
                            <input type="text" id="tech_te" name="tech_te">
                        </div>
                        <div class="non-col"></div>
                    </div>
                    
                    <!-- Hidden Fields -->
                    <input type="hidden" id="ilbo_code" name="ilbo_code" value="0">
                    <input type="hidden" id="ilbo_no" name="ilbo_no" value="0">
                    <input type="hidden" id="werr_code" name="werr_code" value="0">
                    <input type="hidden" id="ilbo_lot" name="ilbo_lot">
                    <input type="hidden" id="werr_lot" name="werr_lot">
                    <input type="hidden" id="werr_yu" name="werr_yu">
                </div>

                <!-- 불량정보 섹션 -->
                <div class="non-section">
                    <div class="non-section-title">부적합등록</div>
                    
                    <div class="non-row">
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
                    </div>
                    
                    <div class="non-row">
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
                    
                    <div class="non-row">
                        <div class="non-col-full">
                            <label>불량내용</label>
                            <textarea id="werr_gnote" name="werr_gnote" rows="3"></textarea>
                        </div>
                    </div>
                    
                    <div class="non-row">
                        <div class="non-col-full">
                            <label>발생원인 및 원인분석</label>
                            <textarea id="werr_case" name="werr_case" rows="3"></textarea>
                        </div>
                    </div>
                    
                    <div class="non-row">
                        <div class="non-col-full">
                            <label>대책수립 및 대책실시</label>
                            <textarea id="werr_jnote" name="werr_jnote" rows="4"></textarea>
                            <input type="file" name="werr_fname" id="werr_fname" class="file-input">
                        </div>
                    </div>
                    
                    <!-- 이미지 업로드 영역 -->
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
                    
                    <!-- 1차 -->
                    <div class="validity-row">
                        <label class="validity-label">1차</label>
                        <div class="validity-fields">
                            <input type="date" id="check_date_a" name="check_date_a" placeholder="확인일자">
                            <input type="text" id="werr_user1" name="werr_user1" placeholder="확인자">
                            <input type="text" id="werr_note1" name="werr_note1" placeholder="점검내용" class="long-input">
                            <input type="text" id="werr_bigo1" name="werr_bigo1" placeholder="비고">
                        </div>
                    </div>
                    
                    <!-- 2차 -->
                    <div class="validity-row">
                        <label class="validity-label">2차</label>
                        <div class="validity-fields">
                            <input type="date" id="check_date_b" name="check_date_b" placeholder="확인일자">
                            <input type="text" id="werr_user2" name="werr_user2" placeholder="확인자">
                            <input type="text" id="werr_note2" name="werr_note2" placeholder="점검내용" class="long-input">
                            <input type="text" id="werr_bigo2" name="werr_bigo2" placeholder="비고">
                        </div>
                    </div>
                    
                    <!-- 3차 -->
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
		                <span class="corp-modal-title">제품 검색</span>
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
});

// ========== 부적합등록 리스트 조회 ==========
function getNonInsertList(){
    // 기존 테이블 완전히 제거
    if (nonTable) {
        nonTable.destroy();
        nonTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    nonTable = new Tabulator("#tab1", {
        height:"750px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
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
        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px"); 
            console.log("📊 서버 응답:", response);
            return response.data ? response.data : [];
        },
        
        columns:[
            {title:"검사일", field:"werr_date", sorter:"string", width:120, hozAlign:"center", frozen:true},
            {title:"거래처", field:"corp_name", sorter:"string", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"품명", field:"prod_name", sorter:"string", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"품번", field:"prod_no", sorter:"string", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"열처리LOT", field:"ilbo_lot", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"유형", field:"werr_gubn", sorter:"string", width:100, hozAlign:"center", headerFilter:"input"},
            {title:"수량", field:"werr_amnt", sorter:"int", width:140, hozAlign:"center", headerFilter:"input"},
            {title:"금액", field:"werr_mon", sorter:"int", width:100, hozAlign:"center", headerFilter:"input"},
            {title:"코드", field:"werr_code", width:200, hozAlign:"center", visible:false},
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
            
            var data = row.getData();
            selectedRowData = data;
            isEditMode = true;
            console.log("더블클릭 데이터:", selectedRowData.werr_code);
            $('#nonInsertForm')[0].reset();
            
            nonInsertDetail(data.werr_code);
            $('.btn-delete').show();

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

// ========== 부적합등록 상세 조회 ==========
// ========== 상세 조회 함수 수정 ==========
function nonInsertDetail(werr_code){
    $.ajax({
        url:"/tkheat/quality/nonInsert/nonInsertDetail",
        type:"post",
        dataType:"json",
        data:{
            "werr_code":werr_code
        },
        success:function(result){
            console.log("📄 상세 데이터:", result);
            var allData = result.data;
            
            // ✅ 폼 초기화
            $('#nonInsertForm')[0].reset();
            
            // ✅ 데이터 바인딩
            for(let key in allData){
                const value = allData[key];
                const $element = $("[name='"+key+"']");
                
                if ($element.length) {
                    // null이나 undefined를 빈 문자열로 변환
                    const safeValue = (value === null || value === undefined) ? '' : value;
                    
                    if ($element.attr('type') === 'checkbox') {
                        $element.prop('checked', value === 'Y' || value === true);
                    } else if ($element.attr('type') === 'date') {
                        // 날짜 포맷 처리 (YYYY-MM-DD)
                        if (safeValue && safeValue !== '') {
                            const formattedDate = safeValue.replace(/[./]/g, '-').substring(0, 10);
                            $element.val(formattedDate);
                        }
                    } else {
                        $element.val(safeValue);
                    }
                }
            }
            
            // ✅ 이미지 미리보기 처리 (서버에 저장된 이미지 경로가 있다면)
            if (allData.imageFile1Path) {
                $('#prev_previewId1').attr('src', allData.imageFile1Path);
            }
            if (allData.imageFile2Path) {
                $('#prev_previewId2').attr('src', allData.imageFile2Path);
            }
            
            // 모달 열기
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

	const permission = userPermissions?.[now_page_code];
    
    // 저장함수
    if (!isEditMode) {
        if (!['I', 'U', 'D'].includes(permission)) {
            alert("등록 권한이 없습니다.");
            console.log("등록 권한 없음 - 현재 권한:", permission);
            return false;
        }
        console.log("등록 권한 확인 완료");
    } 
    // 수정함수
    else {
        if (!['U', 'D'].includes(permission)) {
            alert("수정 권한이 없습니다.");
            console.log("수정 권한 없음 - 현재 권한:", permission);
            return false;
        }
        console.log("수정 권한 확인 완료");
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
    
    // ✅ 수량/금액 빈값 처리
    if (!$("#werr_amnt").val() || $("#werr_amnt").val() === '') {
        formData.set("werr_amnt", "0");
    }
    if (!$("#werr_mon").val() || $("#werr_mon").val() === '') {
        formData.set("werr_mon", "0");
    }
    
    // ✅ 체크박스 처리
    formData.delete("werr_alert");
    formData.append("werr_alert", $("#werr_alert").is(":checked") ? "Y" : "N");
    
    // ✅ 날짜 필드 빈값 체크 및 제거
    const dateFields = ['werr_date', 'werr_wdate', 'check_date_a', 'check_date_b', 'check_date_c'];
    dateFields.forEach(field => {
        const value = $("#" + field).val();
        if (!value || value === '') {
            formData.delete(field);
        }
    });
    
    // ✅ Hidden 필드 빈값 처리
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
    
    // ✅ 파일 필드 빈값 제거
    if (!$('#werr_fname')[0].files.length) {
        formData.delete('werr_fname');
    }
    if (!$('input[name="imageFile1"]')[0].files.length) {
        formData.delete('imageFile1');
    }
    if (!$('input[name="imageFile2"]')[0].files.length) {
        formData.delete('imageFile2');
    }
    
    // ✅ 디버깅용 로그
    console.log("=== 전송 데이터 확인 ===");
    for (let pair of formData.entries()) {
        console.log(pair[0] + ': ' + pair[1]);
    }
    
    if (!confirm(confirmMsg)) return;
    
    $.ajax({
        url: "/tkheat/quality/nonInsert/nonInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 저장 완료:", result);
            alert("저장 되었습니다.");
            
            $('.modal-overlay').removeClass('active');
            $('.non-modal').removeClass('active');
            
            // 모달 위치 초기화
            $('.non-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 폼 초기화
            $('#nonInsertForm')[0].reset();
            isEditMode = false;
            selectedRowData = null;
            
            setTimeout(function() {
                getNonInsertList();
            }, 300);
        },
        error: function(xhr, status, error) {
            console.error("❌ 저장 오류:", xhr.status, error);
            console.error("응답 텍스트:", xhr.responseText);
            
            // 더 자세한 에러 메시지
            let errorMsg = "저장 중 오류가 발생했습니다.";
            if (xhr.status === 400) {
                errorMsg += "\n\n[400 에러] 서버가 요청을 이해할 수 없습니다.";
                errorMsg += "\n필수 입력 항목을 확인해주세요.";
            } else if (xhr.status === 500) {
                errorMsg += "\n\n[500 에러] 서버 내부 오류가 발생했습니다.";
            }
            
            alert(errorMsg);
        }
    });
}

// ========== 삭제 ==========
function deleteNon() {

	const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("삭제 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("삭제 권한 확인 완료");
    
    if (!selectedRowData || !selectedRowData.werr_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }
    
    if (!confirm("삭제하시겠습니까?")) {
        return;
    }
    
    $.ajax({
        url: "/tkheat/quality/nonInsert/deleteNon",
        type: "POST",
        data: {
            werr_code: selectedRowData.werr_code
        },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay').removeClass('active');
                $('.non-modal').removeClass('active');
                
                setTimeout(function() {
                    getNonInsertList();
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

//========== 거래처 검색 모달 열기 ==========
function openCorpListModal(){
    document.getElementById('corpListModal').style.display = 'flex';
    openCorpListModalData();
}

// ========== 거래처 검색 모달 닫기 ==========
function closeCorpListModal() {
    document.getElementById('corpListModal').style.display = 'none';
}

// ========== 거래처 검색 리스트 ==========
function openCorpListModalData() {
    // 기존 테이블 제거
    if (window.facListTable) {
        window.facListTable.destroy();
        window.facListTable = null;
    }
    
    $('#corpListTabulator').empty();
    
    window.facListTable = new Tabulator("#corpListTabulator", {
        height:"450px",
        layout:"fitColumns",
        selectable:true,
        ajaxURL:"/tkheat/quality/nonInsert/getNonCorpList",
        ajaxConfig:"POST",
        ajaxParams:{
            "fac_code": $("#fac_code").val() || 0,
            "ord_code": $("#ord_code").val() || 0,
            "prod_code": $("#prod_code").val() || 0,
            "ilbo_code": $("#ilbo_code").val() || 0,
            "ilbo_no": $("#ilbo_no").val() || 0,
            "corp_code": $("#corp_code").val() || 0,
            "ilbo_lot": $("#subilbo_lot").val(),
            "sdate": $("#subsdate").val(),
            "edate": $("#subedate").val()
        },
        ajaxResponse:function(url, params, response){
            console.log("📊 거래처 검색 응답:", response);
            return response.data;
        },
        columns:[
            {title:"NO", field:"idx", width:80, hozAlign:"center"},
            {title:"입고일", field:"ord_date", width:120, hozAlign:"center"},
            {title:"생산일", field:"ilbo_date", width:120, hozAlign:"center"},
            {title:"거래처", field:"corp_name", width:150, hozAlign:"center"},
            {title:"품명", field:"prod_name", width:100, hozAlign:"center"},
            {title:"품번", field:"prod_no", width:200, hozAlign:"center"},
            {title:"공정", field:"tech_te", width:200, hozAlign:"center"},
            {title:"설비", field:"fac_name", width:200, hozAlign:"center"},
            {title:"수량", field:"ilbo_su", width:200, hozAlign:"center"},
            {title:"고객LOT", field:"ord_lot", width:200, hozAlign:"center"},
            {title:"열처리LOT", field:"ilbo_lot", width:200, hozAlign:"center"},
            {title:"ord_code", field:"ord_code", width:200, hozAlign:"center", visible:false},
            {title:"fac_code", field:"fac_code", width:200, hozAlign:"center", visible:false},
            {title:"prod_code", field:"prod_code", width:200, hozAlign:"center", visible:false},
            {title:"ilbo_code", field:"ilbo_code", width:200, hozAlign:"center", visible:false},
            {title:"ilbo_no", field:"ilbo_no", width:200, hozAlign:"center", visible:false},
            {title:"corp_code", field:"corp_code", width:200, hozAlign:"center", visible:false},
        ],
        rowClick:function(e, row){
            $("#corpListTabulator .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
        },
        rowDblClick:function(e, row){
            let data = row.getData();
            
            console.log("선택된 데이터:", data);
            
            // 데이터 채우기
            document.getElementById('werr_wdate').value = data.ilbo_date || '';
            document.getElementById('corp_name').value = data.corp_name || '';
            document.getElementById('prod_name').value = data.prod_name || '';
            document.getElementById('prod_no').value = data.prod_no || '';
            document.getElementById('fac_name').value = data.fac_name || '';
            document.getElementById('ilbo_lot').value = data.ilbo_lot || '';
            document.getElementById('tech_te').value = data.tech_te || '';
            
            // Hidden 필드도 채우기
            $('#ilbo_code').val(data.ilbo_code || 0);
            $('#ilbo_no').val(data.ilbo_no || 0);
            
            // 모달 닫기
            closeCorpListModal();
        }
    });
}

// ========== 모달 외부 클릭 시 닫기 ==========
$(document).on('click', '#corpListModal', function(e) {
    if (e.target.id === 'corpListModal') {
        closeCorpListModal();
    }
});

// ========== X 버튼 클릭 ==========
$(document).on('click', '.modal-close', function() {
    closeCorpListModal();
});

// ========== 드래그 기능 ==========
const modal = document.querySelector('.non-modal');
const header = document.querySelector('.non-header');

header.addEventListener('mousedown', function(e) {
    if (e.target.classList.contains('header-close-btn') || e.target.closest('.header-close-btn')) {
        return;
    }
    
    const rect = modal.getBoundingClientRect();
    modal.style.left = rect.left + 'px';
    modal.style.top = rect.top + 'px';
    modal.style.transform = 'none';
    
    let offsetX = e.clientX - rect.left;
    let offsetY = e.clientY - rect.top;
    
    function moveModal(e) {
        modal.style.left = (e.clientX - offsetX) + 'px';
        modal.style.top = (e.clientY - offsetY) + 'px';
    }
    
    function stopMove() {
        window.removeEventListener('mousemove', moveModal);
        window.removeEventListener('mouseup', stopMove);
    }
    
    window.addEventListener('mousemove', moveModal);
    window.addEventListener('mouseup', stopMove);
});

// ========== 모달 열기/닫기 ==========
const insertButton = document.querySelector('.insert-button');
const nonModal = document.querySelector('.non-modal');
const modalOverlay = document.querySelector('.modal-overlay');
const closeButton = document.querySelector('.close');
const headerCloseBtn = document.querySelector('.header-close-btn');

//========== 입력 버튼 클릭 수정 ==========
insertButton.addEventListener('click', function() {
    isEditMode = false;
    selectedRowData = null;
    
    // ✅ 폼 완전 초기화
    $('#nonInsertForm')[0].reset();
    
    // ✅ 이미지 초기화
    $('#prev_previewId1').attr('src', '/resources/images/noimage_01.gif');
    $('#prev_previewId2').attr('src', '/resources/images/noimage_01.gif');
    
    // ✅ Hidden 필드 초기화
    $('#ilbo_code').val('0');
    $('#ilbo_no').val('0');
    $('#werr_code').val('0');
    $('#werr_amnt').val('0');
    $('#werr_mon').val('0');
    
    // 중앙 정렬
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

// ========== 저장 버튼 ==========
$('.save').click(function() {
    save();
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
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "부적합등록_" + today + ".xlsx";
    nonTable.download("xlsx", filename, { sheetName: "부적합등록" });
});
    </script>
    

	</body>
</html>
