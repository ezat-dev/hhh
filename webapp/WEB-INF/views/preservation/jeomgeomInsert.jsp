<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비점검기준등록</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
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

/* ========== 점검기준 모달 컨테이너 ========== */
.jg-modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
}

.jg-modal.active {
    display: block;
}

.jg-insert-box {
    width: 600px;
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
.jg-header {
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
.jg-modal-body {
    flex: 1;
    overflow-y: auto;
    overflow-x: hidden;
    background: #f5f7fa;
    padding: 20px;
    max-height: 700px;
}

.jg-modal-body::-webkit-scrollbar {
    width: 8px;
}

.jg-modal-body::-webkit-scrollbar-track {
    background: #e0e0e0;
}

.jg-modal-body::-webkit-scrollbar-thumb {
    background: #999;
    border-radius: 4px;
}

/* ========== 섹션 ========== */
.jg-section {
    background: white;
    border-radius: 8px;
    padding: 15px 20px;
    margin-bottom: 15px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.jg-section:last-child {
    margin-bottom: 0;
}

.jg-section-title {
    font-size: 15px;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 12px;
    padding-bottom: 8px;
    border-bottom: 2px solid #e9ecef;
}

/* ========== 기본 행/열 레이아웃 ========== */
.jg-row {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
    margin-bottom: 10px;
}

.jg-row:last-child {
    margin-bottom: 0;
}

.jg-col {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.jg-col-full {
    grid-column: 1 / -1;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.jg-col label,
.jg-col-full label {
    font-size: 13px;
    font-weight: 600;
    color: #495057;
}

/* ========== 입력 필드 ========== */
.jg-col input[type="text"],
.jg-col input[type="file"],
.jg-col select,
.jg-col-full input[type="text"],
.jg-col-full input[type="file"] {
    padding: 8px 12px;
    border: 1px solid #ced4da;
    border-radius: 5px;
    font-size: 13px;
    box-sizing: border-box;
    transition: all 0.3s;
}

.jg-col input[type="text"],
.jg-col select,
.jg-col-full input[type="text"] {
    width: 100%;
}

.jg-col input:focus,
.jg-col select:focus,
.jg-col-full input:focus {
    outline: none;
    border-color: #4dabf7;
    box-shadow: 0 0 0 3px rgba(77, 171, 247, 0.1);
}

.jg-col input[readonly],
.jg-col input[disabled],
.jg-col-full input[readonly] {
    background: #f1f3f5;
    cursor: not-allowed;
}

.jg-col select {
    cursor: pointer;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 10px center;
    padding-right: 32px;
}

/* ========== 파일 입력 ========== */
.jg-col-full input[type="file"] {
    padding: 6px;
    cursor: pointer;
}

.file-name-display {
    margin-top: 8px;
    background: #f8f9fa;
    color: #6c757d;
    font-style: italic;
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

/* ========== 모달 푸터 ========== */
.jg-modal-footer {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    padding: 15px 20px;
    background: white;
    border-top: 1px solid #dee2e6;
}

.jg-modal-footer button {
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

/* ========== 설비검색 모달 ========== */
.fac-modal-overlay {
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

.fac-modal-content {
    background: white;
    padding: 20px;
    border-radius: 8px;
    width: 90%;
    max-width: 1000px;
    max-height: 90vh;
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

.fac-modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
    font-size: 18px;
    margin-bottom: 15px;
    padding-bottom: 10px;
    border-bottom: 2px solid #e9ecef;
}

.fac-modal-title {
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

#facListTabulator {
    flex: 1;
    overflow: auto;
}

/* ========== 이미지 미리보기 모달 ========== */
.drawing-modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.8);
    display: none;
    align-items: center;
    justify-content: center;
    z-index: 10001;
}

.drawing-modal-content {
    background: white;
    padding: 20px;
    border-radius: 8px;
    width: 80%;
    max-width: 1200px;
    max-height: 90vh;
    display: flex;
    flex-direction: column;
}

.drawing-modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    padding-bottom: 10px;
    border-bottom: 2px solid #e9ecef;
}

.drawing-modal-title {
    font-weight: bold;
    font-size: 18px;
    color: #2c3e50;
}

.drawing-modal-body {
    flex: 1;
    overflow: auto;
    display: flex;
    align-items: center;
    justify-content: center;
}

.drawing-modal-body img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

/* ========== 반응형 ========== */
@media (max-width: 700px) {
    .jg-insert-box {
        width: 95vw;
    }
    
    .jg-row {
        grid-template-columns: 1fr;
    }
} 
    </style>
    
    
    <body>
    
    <div class="tab">
    
    <div class="button-container">
        <!-- <button class="select-button">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button> -->
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
	
	
<form method="post" id="jeomgeomInsertForm" name="jeomgeomInsertForm" enctype="multipart/form-data">
    <div class="modal-overlay"></div>
    
    <div class="jg-modal">
        <div class="jg-insert-box">
            <!-- 헤더 -->
            <div class="jg-header">
                설비점검기준등록
                <button type="button" class="header-close-btn">&times;</button>
            </div>
            
            <!-- 본문 -->
            <div class="jg-modal-body">
                <!-- 설비정보 섹션 -->
                <div class="jg-section">
                    <div class="jg-section-title">설비정보</div>
                    
                    <div class="jg-row">
                        <div class="jg-col">
                            <label>설비그룹</label>
                            <input type="text" id="chs_no" name="chs_no" readonly>
                        </div>
                        <div class="jg-col">
                            <label>설비번호</label>
                            <input type="text" id="fac_no" name="fac_no" disabled>
                        </div>
                    </div>
                    
                    <div class="jg-row">
                        <div class="jg-col-full">
                            <label>설비</label>
                            <div class="input-with-button">
                                <input type="hidden" id="fac_code" name="fac_code">
                                <input type="text" id="fac_name" name="fac_name" disabled>
                                <button type="button" class="btn-search" onclick="openFacListModal();">검색</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 점검기준 섹션 -->
                <div class="jg-section">
                    <div class="jg-section-title">점검기준</div>
                    
                    <div class="jg-row">
                        <div class="jg-col">
                            <label>점검주기</label>
                            <select id="chs_gubn" name="chs_gubn">
                                <option>일상</option>
                                <option>주간</option>
                                <option>월간</option>
                                <option>분기</option>
                                <option>반기</option>
                                <option>수시</option>
                                <option>공정순회</option>
                            </select>
                        </div>
                        <div class="jg-col">
                            <label>구분</label>
                            <select id="chs_gubn_detail" name="chs_gubn_detail">
                                <option>주간</option>
                                <option>야간</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="jg-row">
                        <div class="jg-col">
                            <label>순번</label>
                            <input type="text" id="chs_sort" name="chs_sort">
                        </div>
                        <div class="jg-col">
                            <label>단위</label>
                            <input type="text" id="chs_dawn" name="chs_dawn">
                        </div>
                    </div>
                    
                    <div class="jg-row">
                        <div class="jg-col">
                            <label>하한</label>
                            <input type="text" id="chs_min" name="chs_min">
                        </div>
                        <div class="jg-col">
                            <label>상한</label>
                            <input type="text" id="chs_max" name="chs_max">
                        </div>
                    </div>
                    
                    <div class="jg-row">
                        <div class="jg-col-full">
                            <label>점검항목</label>
                            <input type="text" id="chs_hang" name="chs_hang">
                        </div>
                    </div>
                    
                    <div class="jg-row">
                        <div class="jg-col-full">
                            <label>기준방법</label>
                            <input type="text" id="chs_kijun" name="chs_kijun">
                        </div>
                    </div>
                    
                    <div class="jg-row">
                        <div class="jg-col-full">
                            <label>점검방법</label>
                            <input type="text" id="chs_chkmethod" name="chs_chkmethod">
                        </div>
                    </div>
                    
                    <div class="jg-row">
                        <div class="jg-col-full">
                            <label>조치방법</label>
                            <input type="text" id="chs_stepmethod" name="chs_stepmethod">
                        </div>
                    </div>
                </div>

                <!-- 이미지 섹션 -->
                <div class="jg-section">
                    <div class="jg-section-title">첨부파일</div>
                    
                    <div class="jg-row">
                        <div class="jg-col-full">
                            <label>이미지</label>
                            <input type="file" id="chs_img" name="image_url" accept="image/*">
                            <input type="text" id="chs_img_name_display" class="file-name-display" readonly placeholder="선택된 파일 없음">
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 푸터 버튼 -->
            <div class="jg-modal-footer">
                <button type="button" class="btn-delete" onclick="deleteJeomgeom();" style="display:none;">삭제</button>
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

<!-- 이미지 미리보기 모달 -->
<div id="drawingFileModal" class="drawing-modal-overlay" style="display: none;">
    <div class="drawing-modal-content">
        <div class="drawing-modal-header">
            <span class="drawing-modal-title">이미지: <span id="drawingFileName"></span></span>
            <span class="modal-close" onclick="closeDrawingModal()">&times;</span>
        </div>
        <div class="drawing-modal-body">
            <img id="imageViewer" src="" alt="미리보기">
        </div>
    </div>
</div>
<script>
//========== 전역변수 ==========
let now_page_code = "e05";
var jgTable;
var isEditMode = false;
var selectedRowData = null;

// ========== 페이지 로드 ==========
$(function(){
	if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    getJeomgeomInsertList();
});

// ========== 설비점검기준등록 리스트 조회 ==========
function getJeomgeomInsertList(){
    // 기존 테이블 완전히 제거
    if (jgTable) {
        jgTable.destroy();
        jgTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    jgTable = new Tabulator("#tab1", {
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
        ajaxURL:"/tkheat/preservation/jeomgeomInsert/getJeomgeomInsertList",
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
            {title:"NO", field:"idx", sorter:"int", width:80, hozAlign:"center"},
            {title:"설비그룹", field:"chs_no", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {
                title: "설비공정종류",
                field: "tech_ht",
                editor: "list",
                editorParams: {
                    values: {
                        "이온질화": "이온질화",
                        "진공로": "진공로",
                        "템퍼링로": "템퍼링로",
                        "Box Type": "Box Type",
                        "PIT로": "PIT로",
                        "PQ": "PQ",
                        "Salt로": "Salt로"
                    },
                    clearable: true
                },
                headerFilter: true,
                headerFilterParams: {
                    values: {
                        "이온질화": "이온질화",
                        "진공로": "진공로",
                        "템퍼링로": "템퍼링로",
                        "Box Type": "Box Type",
                        "PIT로": "PIT로",
                        "PQ": "PQ",
                        "Salt로": "Salt로",
                        "": ""
                    },
                    clearable: true
                }
            },
            {title:"설비", field:"fac_name", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"점검주기", field:"chs_gubn", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"순번", field:"chs_sort", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},
            {title:"점검항목", field:"chs_hang", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"기준방법", field:"chs_kijun", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"점검방법", field:"chs_chkmethod", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"조치방법", field:"chs_stepmethod", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"하한", field:"chs_min", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},
            {title:"상한", field:"chs_max", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},
            {title:"단위", field:"chs_danw", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},
            {
                title:"사진", 
                field:"chs_img", 
                width:100,
                hozAlign:"center", 
                formatter:"image",
                cssClass:"rp-img-popup",
                formatterParams:{
                    height:"30px", 
                    width:"30px",
                    urlPrefix:"/tkPrint/사진/설비점검기준등록/"
                }, 
                cellClick:function(e, cell){ 
                    if(cell.getValue()) {
                        openDrawingModal(e, cell.getValue());
                    }
                }
            },
            {title:"chs_code", field:"chs_code", sorter:"int", width:100, hozAlign:"center", visible:false}
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
            console.log("더블클릭 데이터:", selectedRowData.chs_code);
            $('#jeomgeomInsertForm')[0].reset();
            
            jeomgeomInsertDetail(data.chs_code);
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

// ========== 설비점검기준 상세 조회 ==========
function jeomgeomInsertDetail(chs_code){
    $.ajax({
        url:"/tkheat/preservation/jeomgeomInsert/jeomgeomInsertDetail",
        type:"post",
        dataType:"json",
        data:{
            "chs_code":chs_code
        },
        success:function(result){
            console.log("📄 상세 데이터:", result);
            var allData = result.data;
            
            // ✅ 폼 초기화
            $('#jeomgeomInsertForm')[0].reset();
            
            // ✅ 데이터 바인딩
            for(let key in allData){
                const value = allData[key];
                const $element = $("input[name='"+key+"']");
                const $select = $("select[name='"+key+"']");
                
                if ($element.length) {
                    const safeValue = (value === null || value === undefined) ? '' : value;
                    $element.val(safeValue);
                } else if ($select.length) {
                    const safeValue = (value === null || value === undefined) ? '' : value;
                    $select.val(safeValue);
                }
            }
            
            // ✅ 파일명 표시
            if (allData.chs_img) {
                $("#chs_img_name_display").val(allData.chs_img);
            } else {
                $("#chs_img_name_display").val("");
            }
            
            // 모달 열기
            $('.modal-overlay').addClass('active');
            $('.jg-modal').addClass('active');
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
    
    var formData = new FormData($("#jeomgeomInsertForm")[0]);
    let confirmMsg = "";
    
    if (isEditMode && selectedRowData && selectedRowData.chs_code) {
        formData.append("mode", "update");
        formData.append("chs_code", selectedRowData.chs_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
    }
    
    // ✅ 필수 입력 검증
    if (!$("#fac_code").val() || $("#fac_code").val() === '') {
        alert("설비를 선택해주세요.");
        return;
    }
    
    if (!$("#chs_hang").val() || $("#chs_hang").val() === '') {
        alert("점검항목을 입력해주세요.");
        $("#chs_hang").focus();
        return;
    }
    
    // ✅ 숫자 필드 빈값 처리
    ['chs_sort', 'chs_min', 'chs_max'].forEach(field => {
        const value = $("#" + field).val();
        if (!value || value === '') {
            formData.set(field, "0");
        }
    });
    
    // ✅ 파일이 없을 때 파일 필드 제거
    if (!$('#chs_img')[0].files.length) {
        formData.delete('image_url');
    }
    
    console.log("=== 전송 데이터 확인 ===");
    for (let pair of formData.entries()) {
        console.log(pair[0] + ': ' + pair[1]);
    }
    
    if (!confirm(confirmMsg)) return;
    
    $.ajax({
        url: "/tkheat/preservation/jeomgeomInsert/jeomgeomInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 저장 완료:", result);
            alert("저장 되었습니다.");
            
            $('.modal-overlay').removeClass('active');
            $('.jg-modal').removeClass('active');
            
            // 모달 위치 초기화
            $('.jg-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 폼 초기화
            $('#jeomgeomInsertForm')[0].reset();
            isEditMode = false;
            selectedRowData = null;
            
            setTimeout(function() {
                getJeomgeomInsertList();
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
function deleteJeomgeom() {

	const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("삭제 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("삭제 권한 확인 완료");
    
    if (!selectedRowData || !selectedRowData.chs_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }
    
    if (!confirm("삭제하시겠습니까?")) {
        return;
    }
    
    $.ajax({
        url: "/tkheat/preservation/jeomgeomInsert/jeomgeomDelete",
        type: "POST",
        data: {
            chs_code: selectedRowData.chs_code
        },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay').removeClass('active');
                $('.jg-modal').removeClass('active');
                
                setTimeout(function() {
                    getJeomgeomInsertList();
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
            {title:"설비코드", field:"fac_code", width:120, hozAlign:"center", visible:false},
            {title:"설비명", field:"fac_name", width:150, hozAlign:"center"},
            {title:"설비번호", field:"fac_no", width:120, hozAlign:"center"},
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
            document.getElementById('fac_no').value = data.fac_no || '';
            
            closeFacListModal();
        }
    });
}

function closeFacListModal() {
    document.getElementById('facListModal').style.display = 'none';
}

// ========== 이미지 미리보기 모달 ==========
function openDrawingModal(event, fileName) {
    event.preventDefault();
    const FILE_PREFIX_PATH = "/tkPrint/사진/설비점검기준등록/";
    
    if (!fileName) {
        alert("저장된 파일이 없습니다.");
        return;
    }
    
    const filePath = FILE_PREFIX_PATH + fileName;
    
    $("#drawingFileName").text(fileName);
    $("#imageViewer").attr("src", filePath);
    
    $('#drawingFileModal').css('display', 'flex');
}

function closeDrawingModal() {
    $('#drawingFileModal').hide();
    $("#imageViewer").attr("src", "");
}

// ========== 파일 선택 시 파일명 표시 ==========
$('#chs_img').on('change', function() {
    const fileName = this.files[0] ? this.files[0].name : '선택된 파일 없음';
    $('#chs_img_name_display').val(fileName);
});

// ========== 드래그 기능 ==========
const modal = document.querySelector('.jg-modal');
const header = document.querySelector('.jg-header');

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
const jgModal = document.querySelector('.jg-modal');
const modalOverlay = document.querySelector('.modal-overlay');
const closeButton = document.querySelector('.close');
const headerCloseBtn = document.querySelector('.header-close-btn');

insertButton.addEventListener('click', function() {
    isEditMode = false;
    selectedRowData = null;
    
    // ✅ 폼 완전 초기화
    $('#jeomgeomInsertForm')[0].reset();
    
    // ✅ 파일명 표시 초기화
    $('#chs_img_name_display').val('선택된 파일 없음');
    
    // 중앙 정렬
    jgModal.style.left = '50%';
    jgModal.style.top = '50%';
    jgModal.style.transform = 'translate(-50%, -50%)';
    
    modalOverlay.classList.add('active');
    jgModal.classList.add('active');
    
    $('.btn-delete').hide();
});

closeButton.addEventListener('click', function() {
    modalOverlay.classList.remove('active');
    jgModal.classList.remove('active');
});

headerCloseBtn.addEventListener('click', function() {
    modalOverlay.classList.remove('active');
    jgModal.classList.remove('active');
});

// ========== 저장 버튼 ==========
$('.save').click(function() {
    save();
});

// ========== 엑셀 다운로드 ==========
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "설비점검기준등록_" + today + ".xlsx";
    jgTable.download("xlsx", filename, { sheetName: "설비점검기준등록" });
});

// ========== 외부 클릭 시 모달 닫기 ==========
$(document).on('click', '#facListModal', function(e) {
    if (e.target.id === 'facListModal') {
        closeFacListModal();
    }
});

$(document).on('click', '#drawingFileModal', function(e) {
    if (e.target.id === 'drawingFileModal') {
        closeDrawingModal();
    }
});
    </script>

	</body>
</html>
