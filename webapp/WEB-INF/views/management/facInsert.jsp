<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비등록</title>
    <link rel="stylesheet" href="/tkheat/css/management/facInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
	<%@include file="../include/pluginpage.jsp" %>    
<style>
/* ========== 기본 스타일 ========== */
.main { width: 98%; }
.container { display: flex; justify-content: space-between; }
.box1 {
    display: flex; justify-content: right; align-items: center;
    width: 1500px; margin-left: -1050px; gap: 10px;
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

/* ========== 모달 컨테이너 ========== */
.fac-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    width: 1200px; max-width: 95vw;
    max-height: 95vh;              /* ★ 90 → 95vh */
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    z-index: 1000; overflow: hidden;
}
.fac-modal.active { display: flex; flex-direction: column; }

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
    display: grid;
    grid-template-columns: 2.2fr 1fr;
    gap: 8px;                      /* ★ 15px → 8px */
    height: 100%;
}

/* ========== 왼쪽/오른쪽 영역 ========== */
.modal-left, .modal-right {
    display: flex; flex-direction: column;
    gap: 5px;                      /* ★ 12px → 5px */
}

/* ========== 섹션 ========== */
.field-section {
    background: white; border-radius: 5px;
    padding: 5px 10px;             /* ★ 12px 15px → 5px 10px */
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.section-title {
    margin: 0 0 4px 0;             /* ★ 10px → 4px */
    font-size: 11px; font-weight: 700; color: #2c3e50;
    padding-bottom: 3px;           /* ★ 8px → 3px */
    border-bottom: 1px solid #e9ecef;
}

/* ========== 필드 행/열 ========== */
.field-row {
    display: grid; grid-template-columns: repeat(3,1fr);
    gap: 6px;                      /* ★ 10px → 6px */
    margin-bottom: 4px;            /* ★ 8px → 4px */
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
.field-col-full textarea,
.modal-right textarea {
    width: 100%;
    padding: 3px 7px;              /* ★ 6px 10px → 3px 7px */
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 11px;               /* ★ 13px → 11px */
    box-sizing: border-box; transition: all 0.2s;
    height: 26px;                  /* ★ 고정 높이 */
}
.field-col input:focus, .field-col select:focus,
.field-col-full input:focus, .field-col-full textarea:focus,
.modal-right textarea:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.field-col select, .field-col-full select {
    cursor: pointer; appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat; background-position: right 6px center; padding-right: 20px;
}

/* ========== textarea 별도 처리 ========== */
.field-col-full textarea,
.modal-right textarea {
    height: 36px;                  /* ★ 고정 높이 - 스크롤 생겨도 내용 보임 */
    min-height: unset; resize: none;
    font-family: inherit; line-height: 1.3;
}

/* ========== 특이사항 textarea (오른쪽 더 크게) ========== */
#fac_unus {
    height: 100px;                 /* ★ 오른쪽 특이사항은 여유있게 */
}

/* ========== 유닛 입력 ========== */
.input-with-unit { display: flex; align-items: center; gap: 4px; }
.input-with-unit input { flex: 1; }
.input-with-unit span { font-size: 11px; font-weight: 600; color: #6c757d; white-space: nowrap; }

/* ========== 체크박스 ========== */
.checkbox-field { display: flex; align-items: center; gap: 5px; padding: 3px 0; }
.checkbox-field input[type="checkbox"] { width: 14px; height: 14px; cursor: pointer; }
.checkbox-field label { cursor: pointer; margin: 0; font-size: 11px; }

/* ========== 이미지 업로드 ========== */
.img-upload-area { display: flex; flex-direction: column; gap: 5px; }
.img-upload-area input[type="file"] {
    padding: 3px; border: 1px solid #ced4da; border-radius: 4px;
    font-size: 10px; cursor: pointer;
}
.img-upload-area input[type="file"]::-webkit-file-upload-button {
    padding: 3px 8px; border: none; border-radius: 3px;
    background: #4dabf7; color: white;
    font-size: 10px; font-weight: 600; cursor: pointer; margin-right: 6px;
}
.img-upload-area input[type="file"]::-webkit-file-upload-button:hover { background: #339af0; }

.img-preview {
    width: 100%; height: 200px;    /* ★ 280px → 200px */
    border: 2px dashed #ced4da; border-radius: 6px;
    display: flex; align-items: center; justify-content: center;
    background: #f8f9fa; overflow: hidden; transition: all 0.3s;
}
.img-preview:hover { border-color: #4dabf7; background: #e7f5ff; }
.img-preview img { max-width: 100%; max-height: 100%; object-fit: contain; }

/* ========== 모달 푸터 ========== */
.modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 8px; padding: 7px 16px;   /* ★ 12px 20px → 7px 16px */
    background: white; border-top: 1px solid #dee2e6; flex-shrink: 0;
}
.modal-footer button {
    min-width: 80px; height: 30px; /* ★ 100px 38px → 80px 30px */
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
@media (max-width: 1600px) {
    .fac-modal { width: 1300px; }
    .modal-content-wrapper { grid-template-columns: 2fr 1fr; }
}
@media (max-width: 1400px) {
    .fac-modal { width: 95vw; }
    .field-row { grid-template-columns: repeat(2,1fr); }
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
        
        
		<!-- <label class="daylabel">설비NO :</label>
		<input type="text" class="fac_no" id="fac_no" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">설비명 :</label>
		<input type="text" class="fac_name" id="fac_name" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">설비현황표 :</label>
		<input type="text" class="" id="" style="font-size: 16px;" autocomplete="off"> -->
			
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getFacList();">
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
	    
	    
	<form autocomplete="off" method="post" class="corrForm" id="facInsertForm" name="facInsertForm" enctype="multipart/form-data">
    <input type="hidden" name="type" value="facility" />
    
    <div class="modal-overlay"></div>
    
    <div class="fac-modal">
        <!-- 헤더 -->
        <div class="modal-header">
            <h2>설비등록</h2>
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
                                <label>설비번호 <span class="req">*</span></label>
                                <input type="text" id="fac_no" name="fac_no" placeholder="설비번호">
                            </div>
                            <div class="field-col">
                                <label>설비명 <span class="req">*</span></label>
                                <input type="text" id="fac_name" name="fac_name" placeholder="설비명">
                            </div>
                            <div class="field-col">
                                <label>규격</label>
                                <select id="fac_gyu" name="fac_gyu">
                                    <option value="">선택</option>
                                    <option>가스질화</option>
                                    <option>이온질화</option>
                                    <option>침탄</option>
                                    <option>VC</option>
                                    <option>PQ</option>
                                    <option>TEMPERING</option>
                                    <option>진공</option>
                                    <option>세척기</option>
                                    <option>후처리</option>
                                    <option>기타</option>
                                </select>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>형식</label>
                                <input type="text" id="fac_hyun" name="fac_hyun" placeholder="형식">
                            </div>
                            <div class="field-col">
                                <label>용도</label>
                                <input type="text" id="fac_yong" name="fac_yong" placeholder="용도">
                            </div>
                            <div class="field-col">
                                <label>설비종류</label>
                                <select id="tech_no" name="tech_no">
                                    <option value="">선택</option>
                                    <option value="A08">PIT로(A08)</option>
                                    <option value="A11">PIT로(A11)</option>
                                    <option value="A12">PIT로(A12)</option>
                                    <option value="A13">PIT로(A13)</option>
                                    <option value="A14">PIT로(A14)</option>
                                    <option value="A15">PIT로(A15)</option>
                                    <option value="A16">Box Type(A16)</option>
                                    <option value="A17">Box Type(A17)</option>
                                    <option value="A18">Box Type(A18)</option>
                                    <option value="A20">Box Type(A20)</option>
                                    <option value="A21">Box Type(A21)</option>
                                    <option value="A27">이온질화(A27)</option>
                                    <option value="A30">Salt로(A30)</option>
                                    <option value="A31">Box Type(A31)</option>
                                    <option value="A32">PIT로(A32)</option>
                                    <option value="A33">Box Type(A33)</option>
                                    <option value="A34">Box Type(A34)</option>
                                    <option value="A35">PIT로(A35)</option>
                                    <option value="B16">템퍼링로(B16)</option>
                                    <option value="B17">템퍼링로(B17)</option>
                                    <option value="B38">진공로(B38)</option>
                                    <option value="B39">이온질화(B39)</option>
                                    <option value="B40">진공로(B40)</option>
                                    <option value="B41">진공로(B41)</option>
                                    <option value="B42">진공로(B42)</option>
                                    <option value="C01">PQ(C01)</option>
                                    <option value="C02">PQ(C02)</option>
                                    <option value="C03">PQ(C03)</option>
                                </select>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>관리자(정)</label>
                                <input type="text" id="fac_man1" name="fac_man1" placeholder="정">
                            </div>
                            <div class="field-col">
                                <label>관리자(부)</label>
                                <input type="text" id="fac_man2" name="fac_man2" placeholder="부">
                            </div>
                            <div class="field-col">
                                <label>사용부서</label>
                                <input type="text" id="fac_lot" name="fac_lot" placeholder="사용부서">
                            </div>
                        </div>
                        <div class="field-row">
						    <div class="field-col">
						        <label>제조번호</label>
						        <input type="text" id="fac_e1" name="fac_e1" placeholder="제조번호">
						    </div>
						    <div class="field-col">
						        <label>설치장소</label>
						        <input type="text" id="fac_plc" name="fac_plc" placeholder="설치장소">
						    </div>
						    <div class="field-col"></div>
						</div>
                    </div>
                    
                    <!-- 구매/제조 정보 -->
                    <div class="field-section">
                        <h3 class="section-title">구매/제조 정보</h3>
                        <div class="field-row">
                            <div class="field-col">
                                <label>제조사 국적</label>
                                <input type="text" id="fac_e2" name="fac_e2" placeholder="국적">
                            </div>
                            <div class="field-col">
                                <label>제조회사</label>
                                <input type="text" id="fac_make" name="fac_make" placeholder="제조회사">
                            </div>
                            <div class="field-col">
                                <label>구입처</label>
                                <input type="text" id="fac_cBuy" name="fac_cBuy" placeholder="구입처">
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>유지보수업체</label>
                                <input type="text" id="fac_e3" name="fac_e3" placeholder="유지보수업체">
                            </div>
                            <div class="field-col">
                                <label>도입시기</label>
                                <input type="text" id="fac_buy" name="fac_buy" class="js-datepicker" placeholder="YYYY-MM-DD">
                            </div>
                            <div class="field-col">
                                <label>제조일자</label>
                                <input type="text" id="fac_mday" name="fac_mday" class="js-datepicker" placeholder="YYYY-MM-DD">
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col">
                                <label>구입가격</label>
                                <div class="input-with-unit">
                                    <input id="fac_mon" name="fac_mon" class="form-input" type="text" placeholder="0" value="0" />
                                    <span>만원</span>
                                </div>
                            </div>
                            <div class="field-col">
                                <label>실적 및 현황 출력</label>
                                <div class="checkbox-field">
                                    <input type="checkbox" id="fac_dan" name="fac_dan" checked>
                                    <label for="fac_dan">출력</label>
                                </div>
                            </div>
                            <div class="field-col"></div>
                        </div>
                    </div>
                    
                    <!-- 운영 정보 -->
                    <div class="field-section">
					    <h3 class="section-title">운영 정보</h3>
					    <div class="field-row">
					        <div class="field-col">
					            <label>처리용량</label>
					            <input type="text" id="fac_able" name="fac_able" placeholder="처리용량">
					        </div>
					        <div class="field-col">
					            <label>가동기준시간</label>
					            <input type="text" id="fac_time" name="fac_time" placeholder="가동기준시간">
					        </div>
					        <div class="field-col">
					            <label>점검주기</label>
					            <input type="text" id="fac_test" name="fac_test" placeholder="점검주기">
					        </div>
					    </div>
					</div>
                    
                    <!-- 상세 정보 -->
                    <div class="field-section">
                        <h3 class="section-title">상세 정보</h3>
                        <div class="field-row">
                            <div class="field-col-full">
                                <label>주변설비 및 관련사항</label>
                                <textarea id="fac_e4" name="fac_e4" rows="2" placeholder="주변설비 및 관련사항"></textarea>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col-full">
                                <label>비고</label>
                                <textarea id="fac_bigo" name="fac_bigo" rows="2" placeholder="비고"></textarea>
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-col-full">
                                <label>설비점검 주의사항</label>
                                <textarea id="fac_cau" name="fac_cau" rows="2" placeholder="주의사항"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 오른쪽: 이미지 및 특이사항 -->
                <div class="modal-right">
                    <div class="field-section">
                        <h3 class="section-title">이미지</h3>
                        <div class="img-upload-area">
                            <input type="file" id="imgInput0" class="imgInputClass" name="fac_file_url" accept="image/*" onchange="previewImage(this,'previewId')">
                            <div class="img-preview" id="previewId">
                                <img id="img0" src="/tkheat/css/image/no_image.png" alt="설비이미지">
                            </div>
                        </div>
                    </div>
                    
                    <div class="field-section">
                        <h3 class="section-title">특이사항</h3>
                        <textarea id="fac_unus" name="fac_unus" rows="5" placeholder="특이사항 입력"></textarea>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 푸터 (버튼) -->
        <div class="modal-footer">
            <button type="button" class="btn-delete" onclick="deleteFac();" style="display:none;">삭제</button>
            <button type="button" class="btn-save" onclick="save();">저장</button>
            <button type="button" class="btn-cancel">닫기</button>
        </div>
    </div>
</form>
	    
	    
	    
	    
	    
<script>
//전역변수
let now_page_code = "h03";
var cutumTable;	
var isEditMode = false;
var selectedRowData = null;

//로드
$(function(){
	if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    getFacList();
});

// 파일 미리보기
function previewImage(input, previewId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#img0').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

$('.insert-button').on('click', function() {
    isEditMode = false;
    selectedRowData = null;
    $('#facInsertForm')[0].reset();
    $('#img0').attr('src', '/tkheat/css/image/no_image.png');
    $('.btn-delete').hide();
    $('.modal-overlay, .fac-modal').addClass('active');
});

// 모달 닫기
$('.modal-close-btn, .btn-cancel').on('click', function() {
    $('.modal-overlay, .fac-modal').removeClass('active');
});

// 모달 드래그
let isDragging = false;
let startX, startY, modalLeft, modalTop;

$('.modal-header').on('mousedown', function(e) {
    if ($(e.target).hasClass('modal-close-btn') || $(e.target).closest('.modal-close-btn').length) {
        return;
    }
    
    isDragging = true;
    const modal = $('.fac-modal');
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
        
        $('.fac-modal').css({
            left: (modalLeft + dx) + 'px',
            top: (modalTop + dy) + 'px'
        });
    }
});

$(document).on('mouseup', function() {
    isDragging = false;
});


function getFacList(){
    userTable = new Tabulator("#tab1", {
        height:"730px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        selectableRows:true,
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/management/facInsert/getFacList",
        ajaxProgressiveLoad:"scroll",
        ajaxParams:{
            "fac_no": $("#fac_no").val(),
            "fac_name": $("#fac_name").val(),
            "fac_code":"",
        },
        placeholder:"조회된 데이터가 없습니다.",
        paginationSize:20,
        headerFilterPlaceholder: "",
        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
            return response;
        },
        columns:[
            {title:"NO", field:"fac_code", sorter:"int", width:80, hozAlign:"center"},
            {title:"설비NO", field:"fac_no", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"설비명", field:"fac_name", sorter:"string", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"규격", field:"fac_gyu", sorter:"string", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"형식", field:"fac_hyun", sorter:"string", width:200, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"용도", field:"fac_yong", sorter:"int", width:200, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"설치장소", field:"fac_plc", sorter:"int", width:200, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"능력", field:"fac_able", sorter:"int", width:120, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"제작사", field:"fac_make", sorter:"int", width:150, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"구매처", field:"fac_cbuy", sorter:"int", width:100, hozAlign:"center", headerFilter:"input", headerSort:false},   
            {title:"이미지", field:"fac_file_name", width:100, hozAlign:"center", headerSort:false, formatter:"image",
                cssClass:"rp-img-popup",
                formatterParams:{
                    height:"18px", width:"18px",
                    urlPrefix:"/tkPrint/사진/설비등록/"
                },   
                cellMouseEnter:function(e, cell){ productImage(cell.getValue());} 
            },		
        ],
        rowFormatter:function(row){
            var data = row.getData();
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
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
            facInsertDetail(data.fac_code);
            
            // 삭제 버튼 표시 여부 (권한 체크)
            const permission = userPermissions?.[now_page_code];
            if (permission === 'D') {
                $('.btn-delete').show();
            } else {
                $('.btn-delete').hide();
            }
        },
    });		
}

function facInsertDetail(fac_code){
    $.ajax({
        url:"/tkheat/management/facInsert/facInsertDetail",
        type:"post",
        dataType:"json",
        data:{"fac_code":fac_code},
        success:function(result){
            var allData = result.data;
            
            for(let key in allData){
                $("#facInsertForm [name='"+key+"']").val(allData[key]);
            }

            $('#img0').attr("src", "/tkheat/css/image/no_image.png");

            if (allData.fac_file_name) {
                const path = "/tkPrint/사진/설비등록/" + allData.fac_file_name;
                $('#img0').attr("src", path);
            }

            $('.modal-overlay, .fac-modal').addClass('active');
        }
    });
}

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
    // ✅ 숫자 필드 검증 및 변환
    const numericFields = ['fac_mon'];
    numericFields.forEach(field => {
        const value = $('#' + field).val();
        if (value === '' || value === null || isNaN(value)) {
            $('#' + field).val('0');
        }
    });

    var formData = new FormData($("#facInsertForm")[0]);

    let confirmMsg = "";

    if (isEditMode && selectedRowData && selectedRowData.fac_code) {
        formData.append("mode", "update");
        formData.append("fac_code", selectedRowData.fac_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
        formData.delete("fac_code");
    }

    if (!confirm(confirmMsg)) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/facInsert/facInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("✅ 저장 성공:", result);
            alert("저장 되었습니다.");
            $('.modal-overlay, .fac-modal').removeClass('active');
            
            // 모달 중앙 정렬 복원
            $('.fac-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 테이블 새로고침
            if (userTable) {
                userTable.destroy();
            }
            getFacList();
        },
        error: function(xhr, status, error) {
            console.error("저장 오류:", error);
            console.error("응답:", xhr.responseText);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

function deleteFac() {
	// ✅ 권한 체크
    const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("⚠️ 삭제 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("✅ 삭제 권한 확인 완료");
    if (!selectedRowData || !selectedRowData.fac_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }

    if (!confirm("삭제하시겠습니까?")) return;

    $.ajax({
        url: "/tkheat/management/facInsert/facDelete",
        type: "POST",
        data: {fac_code: selectedRowData.fac_code},
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay, .fac-modal').removeClass('active');
                getFacList();
            } else {
                alert("삭제 중 오류가 발생했습니다: " + result.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("삭제 오류:", error);
        }
    });
}

$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "설비등록_" + today + ".xlsx";
    userTable.download("xlsx", filename, { sheetName: "설비등록" });
});
	
    </script>

	</body>
</html>
