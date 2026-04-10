<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수입검사</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
    <style>
/* ========== 기본 스타일 ========== */
.main { width: 98%; }
.container { display: flex; justify-content: space-between; }
.tabulator { width: 100%; max-width: 100%; max-height: 900px; overflow-x: hidden !important; }
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

/* ========== 수입검사 모달 컨테이너 ========== */
.suip-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
}
.suip-modal.active { display: block; }

.suip-insert-box {
    width: 900px; max-width: 95vw;
    max-height: 98vh;              /* ★ 90 → 95vh */
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    overflow: hidden; display: flex; flex-direction: column;
}

/* ========== 모달 헤더 ========== */
.suip-header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 8px 16px;             /* ★ 15px 25px → 8px 16px */
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white; font-size: 15px; font-weight: 700; cursor: move;
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
.suip-modal-body {
    flex: 1; overflow-y: auto; overflow-x: hidden;
    background: #f5f7fa;
    padding: 8px 10px;             /* ★ 20px → 8px 10px */
    max-height: calc(98vh - 90px); /* ★ 700px → 동적 계산 */
}
.suip-modal-body::-webkit-scrollbar { width: 5px; }
.suip-modal-body::-webkit-scrollbar-track { background: #e0e0e0; }
.suip-modal-body::-webkit-scrollbar-thumb { background: #999; border-radius: 4px; }

/* ========== 섹션 ========== */
.suip-section {
    background: white; border-radius: 6px;
    padding: 6px 10px;             /* ★ 15px 20px → 6px 10px */
    margin-bottom: 5px;            /* ★ 15px → 5px */
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.suip-section:last-child { margin-bottom: 0; }
.suip-section-title {
    font-size: 11px; font-weight: 700; color: #2c3e50;
    margin-bottom: 5px;            /* ★ 12px → 5px */
    padding-bottom: 4px;           /* ★ 8px → 4px */
    border-bottom: 1px solid #e9ecef;
}

/* ========== 기본 행/열 레이아웃 ========== */
.suip-row {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 6px; margin-bottom: 5px;  /* ★ 12px→6px, 10px→5px */
}
.suip-row:last-child { margin-bottom: 0; }
.suip-col { display: flex; flex-direction: column; gap: 2px; } /* ★ 5px → 2px */
.suip-col label { font-size: 10px; font-weight: 600; color: #495057; } /* ★ 13px → 10px */

/* ========== 입력 필드 ========== */
.suip-col input[type="text"],
.suip-col input[type="date"],
.suip-col select {
    width: 100%;
    padding: 3px 7px;              /* ★ 8px 12px → 3px 7px */
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 11px;               /* ★ 13px → 11px */
    box-sizing: border-box; transition: all 0.2s;
    height: 26px;                  /* ★ 고정 높이 */
}
.suip-col input:focus, .suip-col select:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.suip-col select {
    cursor: pointer; appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat; background-position: right 8px center; padding-right: 26px;
}

/* ========== 검사내용 특별 레이아웃 ========== */
.inspection-row {
    display: grid; grid-template-columns: 60px 1fr; /* ★ 80px → 60px */
    gap: 6px; margin-bottom: 5px;  /* ★ 10px→6px, 10px→5px */
    align-items: center;
}
.inspection-row:last-child { margin-bottom: 0; }
.inspection-label {
    font-size: 11px; font-weight: 600; color: #495057; /* ★ 13px → 11px */
    text-align: right;
}
.inspection-fields { display: flex; gap: 4px; flex-wrap: nowrap; } /* ★ 6px → 4px */

.inspection-fields input[type="text"],
.inspection-fields select {
    padding: 3px 5px;              /* ★ 6px 8px → 3px 5px */
    border: 1px solid #ced4da; border-radius: 3px;
    font-size: 11px; box-sizing: border-box; transition: all 0.2s;
    height: 24px;                  /* ★ 고정 높이 */
}
.inspection-fields input[type="text"]:first-child,
.inspection-fields input[type="text"]:nth-child(2) {
    width: 100px;                  /* ★ 120px → 100px */
}
.inspection-fields select,
.inspection-fields .small-input {
    width: 52px;                   /* ★ 60px → 52px */
    flex-shrink: 0;
}
.inspection-fields input:focus, .inspection-fields select:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.inspection-fields select {
    cursor: pointer; appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat; background-position: right 4px center; padding-right: 16px;
}

/* ========== 모달 푸터 ========== */
.suip-modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 8px; padding: 7px 16px;   /* ★ 15px 20px → 7px 16px */
    background: white; border-top: 1px solid #dee2e6;
}
.suip-modal-footer button {
    min-width: 80px; height: 30px; /* ★ 100px 38px → 80px 30px */
    border: none; border-radius: 4px;
    font-size: 12px; font-weight: 700; cursor: pointer; transition: all 0.3s;
}
.save    { background: linear-gradient(135deg,#51cf66,#37b24d); color: white; }
.save:hover { background: linear-gradient(135deg,#40c057,#2f9e44); transform: translateY(-1px); }
.btn-delete { background: linear-gradient(135deg,#ff6b6b,#fa5252); color: white; }
.btn-delete:hover { background: linear-gradient(135deg,#f03e3e,#e03131); transform: translateY(-1px); }
.close   { background: linear-gradient(135deg,#868e96,#495057); color: white; }
.close:hover { background: linear-gradient(135deg,#6c757d,#343a40); transform: translateY(-1px); }

/* ========== OK/NG 셀렉트 ========== */
.ok-ng-select {
    width: 52px !important; flex-shrink: 0;
    text-align: center; font-weight: bold;
    cursor: pointer; border-radius: 3px; transition: background-color 0.2s;
}
.ok-ng-select.ng-selected {
    background-color: #ff6b6b !important;
    color: white !important; border-color: #fa5252 !important;
}

/* ========== 타뷸레이터 헤더 ========== */
.tabulator .tabulator-col { height: 55px !important; }
.tabulator .tabulator-col .tabulator-col-content {
    height: 100%; display: flex; flex-direction: column; justify-content: space-between;
}

/* ========== 반응형 ========== */
@media (max-width: 1000px) {
    .suip-insert-box { width: 95vw; }
    .suip-row { grid-template-columns: 1fr; }
    .inspection-row { grid-template-columns: 1fr; }
    .inspection-label { text-align: left; }
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
        <button class="select-button" onclick="getSuipList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
        <button class="insert-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
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
	    
	    
	    <form autocomplete="off" method="post" name="suipForm" id="suipForm">
    <div class="modal-overlay"></div>
    
    <div class="suip-modal">
        <div class="suip-insert-box">
            <!-- 헤더 -->
            <div class="suip-header">
                수입검사
                <button type="button" class="header-close-btn">&times;</button>
            </div>
            
            <!-- 본문 -->
            <div class="suip-modal-body">
                <!-- 입고정보 섹션 -->
                <div class="suip-section">
                    <div class="suip-section-title">입고정보</div>
                    
                    <div class="suip-row">
                        <div class="suip-col">
                            <label>검사일</label>
                            <input type="date" id="itst_date" name="itst_date">
                        </div>
                        <div class="suip-col">
                            <label>최종판정</label>
                            <select id="itst_wp" name="itst_wp">
                                <option selected>합격</option>
                                <option>불합격</option>
                                <option>부적합</option>
                                <option>보류</option>
                                <option>검사대기</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="suip-row">
                        <div class="suip-col">
                            <label>거래처</label>
                            <input type="text" id="corp_code" name="corp_code" value="(주)동양">
                        </div>
                        <div class="suip-col">
                            <label>품번</label>
                            <input type="text" id="prod_no" name="prod_no" value="MHB0143-R0-60">
                        </div>
                    </div>
                    
                    <div class="suip-row">
                        <div class="suip-col">
                            <label>품명</label>
                            <input type="text" id="prod_name" name="prod_name" value="M5ZR1 허브1&2단">
                        </div>
                        <div class="suip-col">
                            <label>재질</label>
                            <input type="text" id="prod_jai" name="prod_jai" value="SCR420">
                        </div>
                    </div>
                    
                    <div class="suip-row">
                        <div class="suip-col">
                            <label>입고량</label>
                            <input type="text" id="ord_su" name="ord_su" value="369">
                        </div>
                        <div class="suip-col">
                            <label>입고LOT</label>
                            <input type="text" id="ord_lot" name="ord_lot">
                        </div>
                    </div>
                </div>

                <!-- 검사내용 섹션 -->
                <div class="suip-section">
                    <div class="suip-section-title">검사내용</div>
                    
                    <!-- 외관 검사 -->
			    <div class="inspection-row">
			        <label class="inspection-label">외관</label>
			        <div class="inspection-fields">
			            <input type="text" id="itst_wn" name="itst_wn" value="외관" placeholder="항목">
			            <input type="text" id="itst_ws" name="itst_ws" value="녹없을것" placeholder="기준">
			            <select id="itst_w1" name="itst_w1" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_w2" name="itst_w2" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_w3" name="itst_w3" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_w4" name="itst_w4" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_w5" name="itst_w5" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			        </div>
			    </div>
			    
			    <!-- 가공칩 -->
			    <div class="inspection-row">
			        <label class="inspection-label">가공칩</label>
			        <div class="inspection-fields">
			            <input type="text" id="itst_05n" name="itst_05n" value="가공칩" placeholder="항목">
			            <input type="text" id="itst_05s" name="itst_05s" value="가공칩없을것" placeholder="기준">
			            <select id="itst_051" name="itst_051" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_052" name="itst_052" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_053" name="itst_053" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_054" name="itst_054" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_055" name="itst_055" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			        </div>
			    </div>
			    
			    <!-- 이물질 -->
			    <div class="inspection-row">
			        <label class="inspection-label">이물질</label>
			        <div class="inspection-fields">
			            <input type="text" id="itst_03n" name="itst_03n" value="이물질" placeholder="항목">
			            <input type="text" id="itst_03s" name="itst_03s" value="이물질없을것" placeholder="기준">
			            <select id="itst_031" name="itst_031" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_032" name="itst_032" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_033" name="itst_033" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_034" name="itst_034" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_035" name="itst_035" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			        </div>
			    </div>
			    
			    <!-- 찍힘 -->
			    <div class="inspection-row">
			        <label class="inspection-label">찍힘</label>
			        <div class="inspection-fields">
			            <input type="text" id="itst_01n" name="itst_01n" value="찍힘" placeholder="항목">
			            <input type="text" id="itst_01s" name="itst_01s" value="찍힘없을것" placeholder="기준">
			            <select id="itst_011" name="itst_011" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_012" name="itst_012" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_013" name="itst_013" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_014" name="itst_014" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			            <select id="itst_015" name="itst_015" class="ok-ng-select"><option>OK</option><option>NG</option></select>
			        </div>
			    </div>
                    
                    <!-- 치수1 -->
                    <div class="inspection-row">
                        <label class="inspection-label">치수1</label>
                        <div class="inspection-fields">
                            <input type="text" id="itst_06n" name="itst_06n" placeholder="MIN">
                            <input type="text" id="itst_06s" name="itst_06s" placeholder="MAX">
                            <input type="text" id="itst_061" name="itst_061" class="small-input">
                            <input type="text" id="itst_062" name="itst_062" class="small-input">
                            <input type="text" id="itst_063" name="itst_063" class="small-input">
                            <input type="text" id="itst_064" name="itst_064" class="small-input">
                            <input type="text" id="itst_065" name="itst_065" class="small-input">
                        </div>
                    </div>
                    
                    <!-- 치수2 -->
                    <div class="inspection-row">
                        <label class="inspection-label">치수2</label>
                        <div class="inspection-fields">
                            <input type="text" id="itst_07n" name="itst_07n" placeholder="MIN">
                            <input type="text" id="itst_07s" name="itst_07s" placeholder="MAX">
                            <input type="text" id="itst_071" name="itst_071" class="small-input">
                            <input type="text" id="itst_072" name="itst_072" class="small-input">
                            <input type="text" id="itst_073" name="itst_073" class="small-input">
                            <input type="text" id="itst_074" name="itst_074" class="small-input">
                            <input type="text" id="itst_075" name="itst_075" class="small-input">
                        </div>
                    </div>
                    
                    <!-- 치수3 -->
                    <div class="inspection-row">
                        <label class="inspection-label">치수3</label>
                        <div class="inspection-fields">
                            <input type="text" id="itst_08n" name="itst_08n" placeholder="MIN">
                            <input type="text" id="itst_08s" name="itst_08s" placeholder="MAX">
                            <input type="text" id="itst_081" name="itst_081" class="small-input">
                            <input type="text" id="itst_082" name="itst_082" class="small-input">
                            <input type="text" id="itst_083" name="itst_083" class="small-input">
                            <input type="text" id="itst_084" name="itst_084" class="small-input">
                            <input type="text" id="itst_085" name="itst_085" class="small-input">
                        </div>
                    </div>
                    
                    <!-- 치수4 -->
                    <div class="inspection-row">
                        <label class="inspection-label">치수4</label>
                        <div class="inspection-fields">
                            <input type="text" id="itst_04n" name="itst_04n" placeholder="MIN">
                            <input type="text" id="itst_04s" name="itst_04s" placeholder="MAX">
                            <input type="text" id="itst_041" name="itst_041" class="small-input">
                            <input type="text" id="itst_042" name="itst_042" class="small-input">
                            <input type="text" id="itst_043" name="itst_043" class="small-input">
                            <input type="text" id="itst_044" name="itst_044" class="small-input">
                            <input type="text" id="itst_045" name="itst_045" class="small-input">
                        </div>
                    </div>
                    
                    <!-- 치수5 -->
                    <div class="inspection-row">
                        <label class="inspection-label">치수5</label>
                        <div class="inspection-fields">
                            <input type="text" id="itst_02n" name="itst_02n" placeholder="MIN">
                            <input type="text" id="itst_02s" name="itst_02s" placeholder="MAX">
                            <input type="text" id="itst_021" name="itst_021" class="small-input">
                            <input type="text" id="itst_022" name="itst_022" class="small-input">
                            <input type="text" id="itst_023" name="itst_023" class="small-input">
                            <input type="text" id="itst_024" name="itst_024" class="small-input">
                            <input type="text" id="itst_025" name="itst_025" class="small-input">
                        </div>
                    </div>
                </div>

                <!-- 검사정보 섹션 -->
                <div class="suip-section">
                    <div class="suip-section-title">검사정보</div>
                    
                    <div class="suip-row">
                        <div class="suip-col">
                            <label>검사자</label>
                            <input type="text" id="itst_p" name="itst_p" value="최균홍">
                        </div>
                        <div class="suip-col">
                            <label>비고</label>
                            <input type="text" id="itst_bigo" name="itst_bigo">
                        </div>
                    </div>
                    
                    <div class="suip-row">
                        <div class="suip-col">
                            <label>샘플수</label>
                            <input type="text" id="itst_su" name="itst_su" value="5EA">
                        </div>
                        <div class="suip-col">
                            <label>검사내역</label>
                            <input type="text" id="itst_test" name="itst_test">
                        </div>
                    </div>
                    
                    <div class="suip-row">
                        <div class="suip-col">
                            <label>불량수</label>
                            <input type="text" id="itst_poor" name="itst_poor">
                        </div>
                        <div class="suip-col"></div>
                    </div>
                </div>
            </div>
            
            
            
            <!-- 푸터 버튼 -->
            <div class="suip-modal-footer">
<!--                 <button type="button" class="btn-delete" onclick="deleteSuip();" style="display:none;">삭제</button> -->
                <button type="button" class="save">저장</button>
                <button type="button" class="close">닫기</button>
            </div>
        </div>
    </div>
</form>
	    
<script>
//========== 전역변수 ==========
let now_page_code = "f01";
var suipTable;
var isEditMode = false;
var selectedRowData = null;

// ========== 페이지 로드 ==========
$(function(){
	if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    var tdate = todayDate();
    var ydate = yesterDate();
    
    $("#sdate").val(ydate);
    $("#edate").val(tdate);
    getSuipList();
});

// ========== 수입검사 리스트 조회 ==========
function getSuipList(){
    // 기존 테이블 완전히 제거
    if (suipTable) {
        suipTable.destroy();
        suipTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    suipTable = new Tabulator("#tab1", {
        height:"730px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/quality/suip/getSuipList",
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
            {title:"NO", field:"idx", sorter:"int", width:80, hozAlign:"center"},
            {title:"검사일", field:"itst_date", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"입고일", field:"ord_date", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"거래처", field:"corp_name", sorter:"string", width:200, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"거래처코드", field:"corp_code", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", visible:false},
            {title:"품명", field:"prod_name", sorter:"string", width:200, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"품번", field:"prod_no", sorter:"string", width:200, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"규격", field:"prod_gyu", sorter:"string", width:200, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"재질", field:"prod_jai", sorter:"string", width:200, hozAlign:"center", headerFilter:"input", headerSort:false},
            {title:"불량수", field:"itst_poor", sorter:"string", width:100, hozAlign:"center", headerFilter:"input"},
            {
                title:"판정",
                field:"itst_wp",
                sorter:"string",
                width:100,
                hozAlign:"center",
                headerSort:false ,
                headerFilter:"input",
                formatter:function(cell, formatterParams, onRendered){
                    const value = cell.getValue();
                    const el = cell.getElement();
                    
                    if(value === "합격"){
                        el.style.backgroundColor = "#a3d8f4";
                    } else if(value === "불합격"){
                        el.style.backgroundColor = "#f4a3a3";
                    } else {
                        el.style.backgroundColor = "";
                    }
                    return value;
                }
            },
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
            console.log("더블클릭 데이터:", selectedRowData.itst_code);
            $('#suipForm')[0].reset();
            
            suipDetail(data.itst_code);
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

// ========== 수입검사 상세 조회 ==========
function suipDetail(itst_code){
    $.ajax({
        url:"/tkheat/quality/suip/suipDetail",
        type:"post",
        dataType:"json",
        data:{
            "itst_code":itst_code
        },
        success:function(result){
            var allData = result.data;
            
            for(let key in allData){
                const lowerKey = key.toLowerCase();
                if(lowerKey === 'itst_date'){
                    const formattedDate = allData[key]?.replace(/[./]/g, '-').substring(0,10);
                    $("#suipForm [name='itst_date']").val(formattedDate);
                    continue;
                }
                $("#suipForm [name='"+lowerKey+"']").val(allData[key]);
            }

            applyNgStyle();    // ★ 추가 - 상세 로드 후 색상 적용

            $('.modal-overlay').addClass('active');
            $('.suip-modal').addClass('active');
        },
        error: function(xhr, status, error) {
            console.error("❌ 상세 조회 오류:", error);
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
    
    var formData = new FormData($("#suipForm")[0]);
    
    let confirmMsg = "";
    
    if (isEditMode && selectedRowData && selectedRowData.itst_code) {
        formData.append("mode", "update");
        formData.append("itst_code", selectedRowData.itst_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
    }
    
    if (!confirm(confirmMsg)) {
        return;
    }
    
    $.ajax({
        url: "/tkheat/quality/suip/suipSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 저장 완료:", result);
            alert("저장 되었습니다.");
            
            // ✅ 수정: .suipModal → .suip-modal
            $('.modal-overlay').removeClass('active');
            $('.suip-modal').removeClass('active');
            
            // 모달 위치 초기화
            $('.suip-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 테이블 리로드
            setTimeout(function() {
                console.log("🔄 테이블 리로드 시작");
                getSuipList();
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
function deleteSuip() {

	const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("삭제 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("삭제 권한 확인 완료");
    
    if (!selectedRowData || !selectedRowData.itst_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }
    
    if (!confirm("삭제하시겠습니까?")) {
        return;
    }
    
    $.ajax({
        url: "/tkheat/quality/suip/suipDelete",
        type: "POST",
        data: {
            itst_code: selectedRowData.itst_code
        },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay').removeClass('active');
                $('.suip-modal').removeClass('active');
                
                setTimeout(function() {
                    getSuipList();
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


//===== OK/NG 셀렉트 변경 감지 - 최종판정 자동 변경 =====
$(document).on("change", ".ok-ng-select", function(){
    const val = $(this).val();

    // NG 선택 시 빨간색 표시
    if(val === "NG"){
        $(this).addClass("ng-selected");
    } else {
        $(this).removeClass("ng-selected");
    }

    // 하나라도 NG면 최종판정 자동 불합격
    checkAutoJudge();
});

function checkAutoJudge(){
    let hasNG = false;
    $(".ok-ng-select").each(function(){
        if($(this).val() === "NG"){
            hasNG = true;
            return false; // break
        }
    });

    if(hasNG){
        $("#itst_wp").val("불합격");
    } else {
        // 전부 OK면 합격으로 복원
        $("#itst_wp").val("합격");
    }
}

function applyNgStyle(){
    $(".ok-ng-select").each(function(){
        if($(this).val() === "NG"){
            $(this).addClass("ng-selected");
        } else {
            $(this).removeClass("ng-selected");
        }
    });
}


// ========== 드래그 기능 ==========
const modal = document.querySelector('.suip-modal');
const header = document.querySelector('.suip-header');

header.addEventListener('mousedown', function(e) {
    // X 버튼 클릭 시 드래그 방지
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
const suipModal = document.querySelector('.suip-modal');
const modalOverlay = document.querySelector('.modal-overlay');
const closeButton = document.querySelector('.close');
const headerCloseBtn = document.querySelector('.header-close-btn');

insertButton.addEventListener('click', function() {
    isEditMode = false;
    $('#suipForm')[0].reset();
    
    // 중앙 정렬
    suipModal.style.left = '50%';
    suipModal.style.top = '50%';
    suipModal.style.transform = 'translate(-50%, -50%)';
    
    modalOverlay.classList.add('active');
    suipModal.classList.add('active');
    
    $('.btn-delete').hide();
});

closeButton.addEventListener('click', function() {
    modalOverlay.classList.remove('active');
    suipModal.classList.remove('active');
});

headerCloseBtn.addEventListener('click', function() {
    modalOverlay.classList.remove('active');
    suipModal.classList.remove('active');
});

// ========== 저장 버튼 ==========
$('.save').click(function() {
    save();
});

// ========== 엑셀 다운로드 ==========
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "수입검사_" + today + ".xlsx";
    suipTable.download("xlsx", filename, { sheetName: "수입검사" });
});
    </script>

	</body>
</html>
