<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비가동정보</title>
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

/* ========== 비가동 모달 컨테이너 ========== */
.bega-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
}
.bega-modal.active { display: block; }

.bega-insert-box {
    width: 900px; max-width: 95vw;
    max-height: 95vh;              /* ★ 90 → 95vh */
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    overflow: hidden; display: flex; flex-direction: column;
}

/* ========== 모달 헤더 ========== */
.bega-header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 8px 16px;             /* ★ 15px 25px → 8px 16px */
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
.bega-modal-body {
    flex: 1; overflow-y: auto; overflow-x: hidden;
    background: #f5f7fa;
    padding: 8px 10px;             /* ★ 20px → 8px 10px */
    max-height: calc(95vh - 90px);
}
.bega-modal-body::-webkit-scrollbar { width: 5px; }
.bega-modal-body::-webkit-scrollbar-track { background: #e0e0e0; }
.bega-modal-body::-webkit-scrollbar-thumb { background: #999; border-radius: 4px; }

/* ========== 섹션 ========== */
.bega-section {
    background: white; border-radius: 6px;
    padding: 6px 10px;             /* ★ 15px 20px → 6px 10px */
    margin-bottom: 5px;            /* ★ 15px → 5px */
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.bega-section:last-child { margin-bottom: 0; }
.bega-section-title {
    font-size: 11px; font-weight: 700; color: #2c3e50;
    margin-bottom: 5px;            /* ★ 12px → 5px */
    padding-bottom: 4px;           /* ★ 8px → 4px */
    border-bottom: 1px solid #e9ecef;
}

/* ========== 기본 행/열 레이아웃 ========== */
.bega-row {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 6px; margin-bottom: 5px;  /* ★ 12px→6px, 10px→5px */
}
.bega-row:last-child { margin-bottom: 0; }
.bega-col { display: flex; flex-direction: column; gap: 2px; }
.bega-col-full { grid-column: 1/-1; display: flex; flex-direction: column; gap: 2px; }
.bega-col label, .bega-col-full label {
    font-size: 10px; font-weight: 600; color: #495057;
}

/* ========== 입력 필드 ========== */
.bega-col input[type="text"],
.bega-col input[type="date"],
.bega-col-full input[type="text"],
.bega-col-full textarea {
    width: 100%;
    padding: 3px 7px;              /* ★ 8px 12px → 3px 7px */
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 11px;               /* ★ 13px → 11px */
    box-sizing: border-box; transition: all 0.2s;
    height: 26px;                  /* ★ 고정 높이 */
}
.bega-col input:focus,
.bega-col-full input:focus,
.bega-col-full textarea:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.bega-col input[readonly], .bega-col-full input[readonly] {
    background: #f1f3f5; cursor: not-allowed;
}
textarea {
    resize: vertical; height: 44px;
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

/* ========== 설비중지시간 그리드 ========== */
.stop-time-grid {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 6px;                      /* ★ 10px → 6px */
}
.stop-time-item {
    display: flex; align-items: center; gap: 5px; /* ★ 8px → 5px */
}
.stop-time-item label {
    min-width: 100px;              /* ★ 120px → 100px */
    font-size: 10px; font-weight: 600; color: #495057;
}
.stop-time-item input {
    flex: 1;
    padding: 3px 7px;              /* ★ 8px 12px → 3px 7px */
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 11px; box-sizing: border-box; transition: all 0.2s;
    height: 26px;
}
.stop-time-item input:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.stop-time-item.total {
    grid-column: 1/-1; background: #f8f9fa;
    padding: 5px; border-radius: 4px; /* ★ 8px → 5px */
}
.stop-time-item.total label { font-weight: 700; color: #2c3e50; }
.stop-time-item.total input { background: white; font-weight: 700; color: #2c3e50; }

/* ========== 모달 푸터 ========== */
.bega-modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 8px; padding: 7px 16px;   /* ★ 15px 20px → 7px 16px */
    background: white; border-top: 1px solid #dee2e6;
    flex-shrink: 0;
}
.bega-modal-footer button {
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

/* ========== 설비검색 모달 ========== */
.fac-modal-overlay {
    position: fixed; top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0,0,0,0.6);
    display: none; align-items: center; justify-content: center; z-index: 10000;
}
.fac-modal-content {
    background: white; padding: 15px; border-radius: 8px;
    width: 90%; max-width: 1000px;
    max-height: 90vh; overflow: hidden;
    display: flex; flex-direction: column;
}
.fac-modal-header {
    display: flex; justify-content: space-between; align-items: center;
    font-weight: bold; font-size: 16px;
    margin-bottom: 10px; padding-bottom: 8px;
    border-bottom: 2px solid #e9ecef;
}
.fac-modal-title { color: #2c3e50; }
.modal-close {
    cursor: pointer; font-size: 24px; color: #495057;
    line-height: 1; transition: all 0.3s;
}
.modal-close:hover { color: #212529; transform: rotate(90deg); }
#facListTabulator { flex: 1; overflow: auto; }

/* ========== 반응형 ========== */
@media (max-width: 1000px) {
    .bega-insert-box { width: 95vw; }
    .bega-row { grid-template-columns: 1fr; }
    .stop-time-grid { grid-template-columns: 1fr; }
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
        <button class="select-button" onclick="getBegaInsertList();">
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
	    
	    
 <form autocomplete="off" method="post" id="begaInsertForm" name="begaInsertForm">
    <div class="modal-overlay"></div>
    
    <div class="bega-modal">
        <div class="bega-insert-box">
            <!-- 헤더 -->
            <div class="bega-header">
                설비비가동등록
                <button type="button" class="header-close-btn">&times;</button>
            </div>
            
            <!-- 본문 -->
            <div class="bega-modal-body">
                <!-- 기본정보 섹션 -->
                <div class="bega-section">
                    <div class="bega-section-title">기본정보</div>
                    
                    <div class="bega-row">
                        <div class="bega-col">
                            <label>설비</label>
                            <div class="input-with-button">
                                <input type="hidden" id="fac_code" name="fac_code">
                                <input type="text" id="fac_name" name="fac_name" readonly>
                                <button type="button" class="btn-search" onclick="openFacListModal();">설비검색</button>
                            </div>
                        </div>
                        <div class="bega-col">
                            <label>일자</label>
                            <input type="date" id="fstp_date" name="fstp_date">
                        </div>
                    </div>
                    
                    <div class="bega-row">
                        <div class="bega-col">
                            <label>계획시간(분)</label>
                            <input type="text" id="fstp_plan" name="fstp_plan" value="1440">
                        </div>
                        <div class="bega-col">
                            <label>투입시간(분)</label>
                            <input type="text" id="fstp_tu" name="fstp_tu" value="1440">
                        </div>
                    </div>
                    
                    <div class="bega-row">
                        <div class="bega-col">
                            <label>준비시간(분)</label>
                            <input type="text" id="fstp_stby" name="fstp_stby">
                        </div>
                        <div class="bega-col"></div>
                    </div>
                </div>

                <!-- 설비중지시간 섹션 -->
                <div class="bega-section">
                    <div class="bega-section-title">설비중지시간(분)</div>
                    
                    <div class="stop-time-grid">
                        <div class="stop-time-item">
                            <label>ITEM변경</label>
                            <input type="text" id="fstp_01" name="fstp_01" value="0">
                        </div>
                        <div class="stop-time-item">
                            <label>물량부족</label>
                            <input type="text" id="fstp_02" name="fstp_02" value="0">
                        </div>
                        <div class="stop-time-item">
                            <label>설비이상(기계)</label>
                            <input type="text" id="fstp_03" name="fstp_03" value="0">
                        </div>
                        <div class="stop-time-item">
                            <label>설비이상(전기)</label>
                            <input type="text" id="fstp_04" name="fstp_04" value="0">
                        </div>
                        <div class="stop-time-item">
                            <label>교육</label>
                            <input type="text" id="fstp_05" name="fstp_05" value="0">
                        </div>
                        <div class="stop-time-item">
                            <label>교대</label>
                            <input type="text" id="fstp_06" name="fstp_06" value="0">
                        </div>
                        <div class="stop-time-item">
                            <label>식사</label>
                            <input type="text" id="fstp_07" name="fstp_07" value="0">
                        </div>
                        <div class="stop-time-item">
                            <label>휴식</label>
                            <input type="text" id="fstp_08" name="fstp_08" value="0">
                        </div>
                        <div class="stop-time-item">
                            <label>기타</label>
                            <input type="text" id="fstp_09" name="fstp_09" value="0">
                        </div>
                        <div class="stop-time-item total">
                            <label>계</label>
                            <input type="text" id="fstp_10" name="fstp_10" value="0" readonly>
                        </div>
                    </div>
                </div>

                <!-- TOTAL현황 섹션 -->
                <div class="bega-section">
                    <div class="bega-section-title">TOTAL 현황</div>
                    
                    <div class="bega-row">
                        <div class="bega-col">
                            <label>실가동시간(분)</label>
                            <input type="text" id="fstp_sil" name="fstp_sil" readonly>
                        </div>
                        <div class="bega-col">
                            <label>인원</label>
                            <input type="text" id="fstp_man" name="fstp_man">
                        </div>
                    </div>
                    
                    <div class="bega-row">
                        <div class="bega-col">
                            <label>M-Hr</label>
                            <input type="text" id="fstp_mhr" name="fstp_mhr" readonly>
                        </div>
                        <div class="bega-col"></div>
                    </div>
                    
                    <div class="bega-row">
                        <div class="bega-col-full">
                            <label>비고</label>
                            <textarea id="fstp_bigo" name="fstp_bigo" rows="3"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 푸터 버튼 -->
            <div class="bega-modal-footer">
                <button type="button" class="btn-delete" onclick="deleteBega();" style="display:none;">삭제</button>
                <button type="button" class="save">저장</button>
                <button type="button" class="close">닫기</button>
            </div>
        </div>
    </div>
</form>

<!-- 설비검색 모달 -->
<div id="facListModal" class="fac-modal-overlay" style="display: none;">
    <div class="fac-modal-content">
        <div class="fac-modal-header">
            <span class="fac-modal-title">설비 리스트</span>
            <span class="modal-close" onclick="closeFacListModal()">&times;</span>
        </div>
        <div id="facListTabulator" style="height: 500px;"></div>
    </div>
</div>


	<script>
	// ========== 전역변수 ==========
	let now_page_code = "e02";
	var begaTable;
	var isEditMode = false;
	var selectedRowData = null;

	// ========== 페이지 로드 ==========
	$(function() {
		if (typeof userInfoList === 'function') {
	        userInfoList(now_page_code);
	    }
	    var tdate = todayDate();
	    var ydate = yesterDate();
	    
	    $("#sdate").val(ydate);
	    $("#edate").val(tdate);
	    getBegaInsertList();
	    
	    // ========== 자동 계산 이벤트 바인딩 ==========
	    // 1~9 입력창 변화 감지
	    $("#fstp_01, #fstp_02, #fstp_03, #fstp_04, #fstp_05, #fstp_06, #fstp_07, #fstp_08, #fstp_09").on("input", function() {
	        updateSum();
	    });
	    
	    // 계획, 준비시간, 인원 변화 감지
	    $("#fstp_plan, #fstp_stby, #fstp_man").on("input", function() {
	        updateSil();
	    });
	});

	// ========== 비가동등록 리스트 조회 ==========
	function getBegaInsertList() {
	    // 기존 테이블 완전히 제거
	    if (begaTable) {
	        begaTable.destroy();
	        begaTable = null;
	    }
	    
	    // DOM 초기화
	    $('#tab1').empty();
	    
	    begaTable = new Tabulator("#tab1", {
	        height:"730px",
	        layout:"fitColumns",
	        selectable:true,
	        tooltips:true,
	        headerSort:false,
	        selectableRangeMode:"click",
	        reactiveData:true,
	        headerHozAlign:"center",
	        ajaxConfig:"POST",
	        ajaxLoader:false,
	        ajaxURL:"/tkheat/preservation/begaInsert/getBegaInsertList",
	        ajaxParams:{
	            "sdate": $("#sdate").val(),
	            "edate": $("#edate").val(),
	        },
	        placeholder:"조회된 데이터가 없습니다.",
	        pagination:"local",
	        paginationSize:20,
	        paginationSizeSelector:[20,50,100,500,1000],
	        paginationCounter:"rows",
	        
	        ajaxResponse:function(url, params, response){
	            $("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
	            console.log("📊 서버 응답:", response);
	            return response.data ? response.data : [];
	        },
	        
	        columns:[
	            {title:"NO", field:"idx", sorter:"int", width:80, hozAlign:"center"},
	            {title:"일자", field:"fstp_date", sorter:"string", width:120, hozAlign:"center"},
	            {title:"설비명", field:"fac_name", sorter:"string", width:120, hozAlign:"center"},
	            {title:"계획시간(분)", field:"fstp_plan", sorter:"string", width:120, hozAlign:"center"},
	            {title:"투입시간(분)", field:"fstp_tu", sorter:"string", width:120, hozAlign:"center"},
	            {title:"준비시간(분)", field:"fstp_stby", sorter:"string", width:120, hozAlign:"center"},
	            {title:"ITEM변경", field:"fstp_01", sorter:"string", width:100, hozAlign:"center"},
	            {title:"물량부족", field:"fstp_02", sorter:"string", width:100, hozAlign:"center"},
	            {title:"설비이상(기계)", field:"fstp_03", sorter:"string", width:120, hozAlign:"center"},
	            {title:"설비이상(전기)", field:"fstp_04", sorter:"string", width:120, hozAlign:"center"},
	            {title:"교육", field:"fstp_05", sorter:"string", width:80, hozAlign:"center"},
	            {title:"교대", field:"fstp_06", sorter:"string", width:80, hozAlign:"center"},
	            {title:"식사", field:"fstp_07", sorter:"string", width:80, hozAlign:"center"},
	            {title:"휴식", field:"fstp_08", sorter:"string", width:80, hozAlign:"center"},
	            {title:"기타", field:"fstp_09", sorter:"string", width:80, hozAlign:"center"},
	            {title:"비가동코드", field:"fstp_code", width:200, hozAlign:"center", visible:false},
	            {title:"비고", field:"fstp_bigo", width:200, hozAlign:"center", visible:false},
	            {title:"계", field:"fstp_10", width:200, hozAlign:"center", visible:false},
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
	            console.log("더블클릭 데이터:", selectedRowData.fstp_code);
	            $('#begaInsertForm')[0].reset();
	            
	            begaInsertDetail(data.fstp_code);
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

	// ========== 비가동등록 상세 조회 ==========
	function begaInsertDetail(fstp_code){
	    $.ajax({
	        url:"/tkheat/preservation/begaInsert/begaInsertDetail",
	        type:"post",
	        dataType:"json",
	        data:{
	            "fstp_code":fstp_code
	        },
	        success:function(result){
	            console.log("📄 상세 데이터:", result);
	            var allData = result.data;
	            
	            // ✅ 폼 초기화
	            $('#begaInsertForm')[0].reset();
	            
	            // ✅ 데이터 바인딩
	            for(let key in allData){
	                const value = allData[key];
	                const $element = $("#begaInsertForm [name='"+key+"']");
	                
	                if ($element.length) {
	                    const safeValue = (value === null || value === undefined) ? '' : value;
	                    
	                    if ($element.attr('type') === 'date') {
	                        if (safeValue && safeValue !== '') {
	                            const formattedDate = safeValue.replace(/[./]/g, '-').substring(0, 10);
	                            $element.val(formattedDate);
	                        }
	                    } else {
	                        $element.val(safeValue);
	                    }
	                }
	            }
	            
	            // ✅ 자동 계산 실행
	            updateSum();
	            updateSil();
	            
	            // 모달 열기
	            $('.modal-overlay').addClass('active');
	            $('.bega-modal').addClass('active');
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
	    
	    var formData = new FormData($("#begaInsertForm")[0]);
	    let confirmMsg = "";
	    
	    if (isEditMode && selectedRowData && selectedRowData.fstp_code) {
	        formData.append("mode", "update");
	        formData.append("fstp_code", selectedRowData.fstp_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }
	    
	    // ✅ 숫자 필드 빈값 처리
	    const numericFields = [
	        'fstp_plan', 'fstp_tu', 'fstp_stby', 'fstp_01', 'fstp_02', 'fstp_03', 
	        'fstp_04', 'fstp_05', 'fstp_06', 'fstp_07', 'fstp_08', 'fstp_09', 
	        'fstp_10', 'fstp_sil', 'fstp_man', 'fstp_mhr'
	    ];
	    
	    numericFields.forEach(field => {
	        const value = $("#" + field).val();
	        if (!value || value === '' || value === 'null') {
	            formData.set(field, "0");
	        }
	    });
	    
	    // ✅ 날짜 필드 빈값 처리
	    const dateValue = $("#fstp_date").val();
	    if (!dateValue || dateValue === '') {
	        alert("일자를 입력해주세요.");
	        $("#fstp_date").focus();
	        return;
	    }
	    
	    // ✅ 설비 필수 체크
	    if (!$("#fac_code").val() || $("#fac_code").val() === '') {
	        alert("설비를 선택해주세요.");
	        return;
	    }
	    
	    console.log("=== 전송 데이터 확인 ===");
	    for (let pair of formData.entries()) {
	        console.log(pair[0] + ': ' + pair[1]);
	    }
	    
	    if (!confirm(confirmMsg)) return;
	    
	    $.ajax({
	        url: "/tkheat/preservation/begaInsert/begaInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	            console.log("💾 저장 완료:", result);
	            alert("저장 되었습니다.");
	            
	            $('.modal-overlay').removeClass('active');
	            $('.bega-modal').removeClass('active');
	            
	            // 모달 위치 초기화
	            $('.bega-modal').css({
	                'left': '50%',
	                'top': '50%',
	                'transform': 'translate(-50%, -50%)'
	            });
	            
	            // 폼 초기화
	            $('#begaInsertForm')[0].reset();
	            isEditMode = false;
	            selectedRowData = null;
	            
	            setTimeout(function() {
	                getBegaInsertList();
	            }, 300);
	        },
	        error: function(xhr, status, error) {
	            console.error("❌ 저장 오류:", xhr.status, error);
	            console.error("응답 텍스트:", xhr.responseText);
	            alert("저장 중 오류가 발생했습니다.");
	        }
	    });
	}

	// ========== 삭제 ==========
	function deleteBega() {

		const permission = userPermissions?.[now_page_code];
	    
	    if (permission !== 'D') {
	        alert("삭제 권한이 없습니다.");
	        console.log("삭제 권한 없음 - 현재 권한:", permission);
	        return false;
	    }
	    console.log("삭제 권한 확인 완료");
	    
	    if (!selectedRowData || !selectedRowData.fstp_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }
	    
	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }
	    
	    $.ajax({
	        url: "/tkheat/preservation/begaInsert/begaDelete",
	        type: "POST",
	        data: {
	            fstp_code: selectedRowData.fstp_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $('.modal-overlay').removeClass('active');
	                $('.bega-modal').removeClass('active');
	                
	                setTimeout(function() {
	                    getBegaInsertList();
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

	// ========== 설비검색 모달 ==========
	function openFacListModal() {
	    document.getElementById('facListModal').style.display = 'flex';
	    
	    // 기존 테이블 제거
	    if (window.facListTable) {
	        window.facListTable.destroy();
	        window.facListTable = null;
	    }
	    
	    $('#facListTabulator').empty();
	    
	    window.facListTable = new Tabulator("#facListTabulator", {
	        height:"450px",
	        layout:"fitColumns",
	        selectable:true,
	        ajaxURL:"/tkheat/management/facInsert/getFacList",
	        ajaxConfig:"POST",
	        ajaxParams:{
	            "fac_code": "",
	            "fac_name": "",
	            "fac_no": "",
	        },
	        ajaxResponse:function(url, params, response){
	            console.log("📊 설비 검색 응답:", response);
	            return response.data;
	        },
	        columns:[
	            {title:"설비NO", field:"fac_no", width:120, hozAlign:"center"},
	            {title:"설비코드", field:"fac_code", width:120, hozAlign:"center", visible:false},
	            {title:"설비명", field:"fac_name", width:150, hozAlign:"center"},
	            {title:"규격", field:"fac_gyu", width:100, hozAlign:"center"},
	            {title:"형식", field:"fac_hyun", width:200, hozAlign:"center"},
	            {title:"용도", field:"fac_yong", width:200, hozAlign:"center"},
	        ],
	        rowClick:function(e, row){
	            $("#facListTabulator .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
	            row.getElement().classList.add("row_select");
	        },
	        rowDblClick:function(e, row){
	            let data = row.getData();
	            
	            console.log("선택된 설비:", data);
	            document.getElementById('fac_code').value = data.fac_code || '';
	            document.getElementById('fac_name').value = data.fac_name || '';
	            
	            closeFacListModal();
	        }
	    });
	}

	function closeFacListModal() {
	    document.getElementById('facListModal').style.display = 'none';
	}

	// ========== 자동 계산 함수들 ==========
	// 합계 계산 (fstp_01 ~ fstp_09 → fstp_10)
	function updateSum() {
	    let sum = 0;
	    for(let i=1; i<=9; i++) {
	        let val = parseInt($("#fstp_0" + i).val()) || 0;
	        sum += val;
	    }
	    $("#fstp_10").val(sum);
	}

	// 실가동시간 계산 (계획시간 - 준비시간)
	function updateSil() {
	    let plan = parseInt($("#fstp_plan").val()) || 0;
	    let stby = parseInt($("#fstp_stby").val()) || 0;
	    
	    let sil = plan - stby;
	    if(sil < 0) sil = 0;
	    
	    $("#fstp_sil").val(sil);
	    updateMhr(); // 실가동시간 계산 후 M-Hr도 업데이트
	}

	// M-Hr 계산 (실가동시간 / 60 / 인원)
	function updateMhr() {
	    let sil = parseInt($("#fstp_sil").val()) || 0;
	    let man = parseFloat($("#fstp_man").val()) || 0;
	    
	    if(man > 0) {
	        let mhr = (sil / 60 / man).toFixed(2);
	        $("#fstp_mhr").val(mhr);
	    } else {
	        $("#fstp_mhr").val("");
	    }
	}

	// ========== 드래그 기능 ==========
	const modal = document.querySelector('.bega-modal');
	const header = document.querySelector('.bega-header');

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
	const begaModal = document.querySelector('.bega-modal');
	const modalOverlay = document.querySelector('.modal-overlay');
	const closeButton = document.querySelector('.close');
	const headerCloseBtn = document.querySelector('.header-close-btn');

	insertButton.addEventListener('click', function() {
	    isEditMode = false;
	    selectedRowData = null;
	    
	    // ✅ 폼 완전 초기화
	    $('#begaInsertForm')[0].reset();
	    
	    // ✅ 기본값 설정
	    $('#fstp_plan').val('1440');
	    $('#fstp_tu').val('1440');
	    $('#fstp_01').val('0');
	    $('#fstp_02').val('0');
	    $('#fstp_03').val('0');
	    $('#fstp_04').val('0');
	    $('#fstp_05').val('0');
	    $('#fstp_06').val('0');
	    $('#fstp_07').val('0');
	    $('#fstp_08').val('0');
	    $('#fstp_09').val('0');
	    $('#fstp_10').val('0');
	    
	    // 중앙 정렬
	    begaModal.style.left = '50%';
	    begaModal.style.top = '50%';
	    begaModal.style.transform = 'translate(-50%, -50%)';
	    
	    modalOverlay.classList.add('active');
	    begaModal.classList.add('active');
	    
	    $('.btn-delete').hide();
	});

	closeButton.addEventListener('click', function() {
	    modalOverlay.classList.remove('active');
	    begaModal.classList.remove('active');
	});

	headerCloseBtn.addEventListener('click', function() {
	    modalOverlay.classList.remove('active');
	    begaModal.classList.remove('active');
	});

	// ========== 저장 버튼 ==========
	$('.save').click(function() {
	    save();
	});

	// ========== 엑셀 다운로드 ==========
	$(".excel-button").click(function () {
	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "비가동정보_" + today + ".xlsx";
	    begaTable.download("xlsx", filename, { sheetName: "비가동정보" });
	});

	// ========== 외부 클릭 시 모달 닫기 ==========
	$(document).on('click', '#facListModal', function(e) {
	    if (e.target.id === 'facListModal') {
	        closeFacListModal();
	    }
	});

    </script>
    
    

	</body>
</html>
