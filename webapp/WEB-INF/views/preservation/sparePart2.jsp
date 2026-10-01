<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SparePart관리(V2)</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>
   <style>
/* ========== 기본 레이아웃 ========== */
.main {
    width: 98%;
    padding: 8px;
}

/* ========== KPI 카드 ========== */
.kpi-row {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
    margin-bottom: 10px;
}
.kpi-card {
    background: white;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    padding: 12px 16px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    text-align: center;
}
.kpi-lbl { font-size: 11px; color: #718096; margin-bottom: 4px; }
.kpi-val { font-size: 24px; font-weight: 800; }

/* ========== 서브탭(재고현황/입출고이력) ========== */
.sp2-tabs { display:flex; gap:6px; margin-bottom:10px; }
.sp2-tab  {
    padding:7px 20px; border-radius:8px; border:1px solid #E2E8F0;
    background:#F0F4F8; font-size:13px; font-weight:700;
    cursor:pointer; transition:all .13s; color:#4A5568;
}
.sp2-tab.active { background:#3182CE; color:#fff; border-color:#2B6CB0; }

/* ========== 필터 바 ========== */
.sp2-filter-bar { display:flex; gap:8px; flex-wrap:wrap; align-items:center; margin-bottom:10px; }
.sp2-filter-bar select,
.sp2-filter-bar input[type="text"],
.sp2-filter-bar input[type="date"] {
    height: 32px; border:1px solid #ced4da; border-radius:6px; padding:0 8px; font-size:12px;
}

/* ========== 레이아웃 ========== */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main { flex: 1; min-height: 0; display: flex; flex-direction: column; overflow: hidden; }
#tab-stock, #tab-history { flex: 1; min-height: 0; display: flex; flex-direction: column; overflow: hidden; }

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
.button-container .in-button,
.button-container .out-button,
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
.button-container .in-button:hover,
.button-container .out-button:hover,
.button-container .delete:hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
}

/* ========== Tabulator ========== */
#tab1.tabulator, #tab2.tabulator {
    flex: 1; min-height: 0; border: none; font-size: 12px;
}
#tab1 .tabulator-header, #tab2 .tabulator-header {
    background: linear-gradient(135deg, #2B6CB0, #3182CE);
    border-bottom: none;
}
#tab1 .tabulator-col, #tab2 .tabulator-col { background: transparent; border-right: 1px solid rgba(255,255,255,.15); }
#tab1 .tabulator-col-title, #tab2 .tabulator-col-title { color: #ffffff; font-weight: 700; }
#tab1 .tabulator-row, #tab2 .tabulator-row { border-bottom: 1px solid #EDF2F7; }
#tab1 .tabulator-row.tabulator-row-even, #tab2 .tabulator-row.tabulator-row-even { background-color: #F7FAFC; }
#tab1 .tabulator-row:hover, #tab2 .tabulator-row:hover { background-color: #EBF8FF !important; }
#tab1 .tabulator-cell, #tab2 .tabulator-cell { border: 1px solid #E2E8F0; color: #2D3748; }
.row_select { background-color: #ffd700 !important; color: #000; }

/* ========== 뱃지 ========== */
.badge { display:inline-block; padding:2px 9px; border-radius:20px; font-size:11px; font-weight:700; white-space:nowrap; }
.b-ok   { background:#E6FFFA; color:#2C7A7B; border:1px solid #9AE6B4; }
.b-low  { background:#FFFAF0; color:#DD6B20; border:1px solid #FBD38D; }
.b-none { background:#FFF5F5; color:#C53030; border:1px solid #FEB2B2; }
.b-in   { background:#EBF8FF; color:#2B6CB0; border:1px solid #BEE3F8; }
.b-out  { background:#FFF5F5; color:#C53030; border:1px solid #FEB2B2; }

/* ========== 모달 ========== */
.modal-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,.45); z-index:999; }
.modal-overlay.active { display:block; }
.sp2-modal { display:none; position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); z-index:1000; }
.sp2-modal.active { display:block; }
.sp2-box {
    width:480px; max-width:95vw; max-height:90vh; background:white; border-radius:8px;
    box-shadow:0 10px 50px rgba(0,0,0,.3); overflow:hidden; display:flex; flex-direction:column;
}
.sp2-header {
    display:flex; justify-content:space-between; align-items:center; padding:10px 20px;
    background:linear-gradient(135deg,#2c3e50,#34495e); color:white; font-size:17px; font-weight:700; cursor:move;
}
.sp2-header.in-header  { background:linear-gradient(135deg,#2B6CB0,#3182CE); }
.sp2-header.out-header { background:linear-gradient(135deg,#c05621,#dd6b20); }
.header-close-btn { background:none; border:none; color:white; font-size:22px; cursor:pointer; width:26px; height:26px; }
.sp2-body { padding:16px 18px; background:#f5f7fa; overflow-y:auto; }
.sp2-row { display:grid; grid-template-columns:repeat(2,1fr); gap:10px; margin-bottom:10px; }
.sp2-row:last-child { margin-bottom:0; }
.sp2-row .full { grid-column:1/-1; }
.sp2-col { display:flex; flex-direction:column; gap:4px; }
.sp2-col label { font-size:12px; font-weight:600; color:#495057; }
.sp2-col input, .sp2-col select {
    padding:6px 10px; border:1px solid #ced4da; border-radius:4px; font-size:12px; width:100%; box-sizing:border-box;
}
.sp2-footer { display:flex; justify-content:center; gap:8px; padding:10px 15px; background:white; border-top:1px solid #dee2e6; }
.sp2-footer button { min-width:90px; height:34px; border:none; border-radius:4px; font-size:13px; font-weight:700; cursor:pointer; }
.sp2-save  { background:linear-gradient(135deg,#51cf66,#37b24d); color:white; }
.sp2-save-out { background:linear-gradient(135deg,#dd6b20,#c05621); color:white; }
.sp2-del   { background:linear-gradient(135deg,#ff6b6b,#fa5252); color:white; }
.sp2-close { background:linear-gradient(135deg,#868e96,#495057); color:white; }
</style>
</head>
<body>
    <div class="tab">
        <div class="button-container">
            <button class="select-button" id="btnSelect">
                <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
                조회
            </button>
            <button class="in-button" id="btnIn">
                <img src="/tkheat/css/image/insert-icon.png" alt="in" class="button-image">
                입고 등록
            </button>
            <button class="out-button" id="btnOut">
                <img src="/tkheat/css/image/insert-icon.png" alt="out" class="button-image">
                사용 등록
            </button>
            <button class="insert-button" id="btnAdd">
                <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
                부품 등록
            </button>
            <button class="excel-button" id="btnExcel">
                <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
                엑셀
            </button>
        </div>
    </div>

    <main class="main">
        <!-- KPI 요약 -->
        <div class="kpi-row">
            <div class="kpi-card">
                <div class="kpi-lbl">전체 품목</div>
                <div class="kpi-val" id="kTotal" style="color:#3182CE">0</div>
            </div>
            <div class="kpi-card">
                <div class="kpi-lbl">재고없음</div>
                <div class="kpi-val" id="kNone" style="color:#C53030">0</div>
            </div>
            <div class="kpi-card">
                <div class="kpi-lbl">재고 부족</div>
                <div class="kpi-val" id="kLow" style="color:#DD6B20">0</div>
            </div>
            <div class="kpi-card">
                <div class="kpi-lbl">정상</div>
                <div class="kpi-val" id="kOk" style="color:#2C7A7B">0</div>
            </div>
        </div>

        <!-- 서브탭 -->
        <div class="sp2-tabs">
            <button class="sp2-tab active" id="tabBtnStock">재고 현황</button>
            <button class="sp2-tab" id="tabBtnHistory">입출고 이력</button>
        </div>

        <!-- ══ 재고 현황 ══ -->
        <div id="tab-stock">
            <div class="sp2-filter-bar">
                <select id="fCategory">
                    <option value="">전체 카테고리</option>
                    <option>히터</option><option>열전대</option><option>O2센서</option>
                    <option>팬모터</option><option>밸브</option><option>필터</option><option>기타</option>
                </select>
                <input type="text" id="fKeyword" placeholder="품번·품명 검색">
            </div>
            <div id="tab1" class="tabulator"></div>
        </div>

        <!-- ══ 입출고 이력 ══ -->
        <div id="tab-history" style="display:none">
            <div class="sp2-filter-bar">
                <select id="hType">
                    <option value="">전체</option>
                    <option value="IN">입고</option>
                    <option value="OUT">사용</option>
                </select>
                <input type="date" id="hFrom">
                ~
                <input type="date" id="hTo">
            </div>
            <div id="tab2" class="tabulator"></div>
        </div>
    </main>

    <!-- ========== 부품 등록/수정 모달 ========== -->
    <div class="modal-overlay" id="partsOverlay"></div>
    <form autocomplete="off" id="sp2PartsForm">
        <div class="sp2-modal" id="partsModal">
            <div class="sp2-box">
                <div class="sp2-header">
                    <span id="partsModalTitle">부품 등록</span>
                    <button type="button" class="header-close-btn" id="partsCloseBtn">&times;</button>
                </div>
                <div class="sp2-body">
                    <div class="sp2-row">
                        <div class="sp2-col">
                            <label>부품번호 *</label>
                            <input type="text" id="mSpp2No" name="spp2_no" placeholder="예) HT-001">
                        </div>
                        <div class="sp2-col">
                            <label>품명 *</label>
                            <input type="text" id="mSpp2Name" name="spp2_name" placeholder="예) 히터 엘리먼트 3kW">
                        </div>
                    </div>
                    <div class="sp2-row">
                        <div class="sp2-col">
                            <label>카테고리</label>
                            <select id="mSpp2Category" name="spp2_category">
                                <option>히터</option><option>열전대</option><option>O2센서</option>
                                <option>팬모터</option><option>밸브</option><option>필터</option><option>기타</option>
                            </select>
                        </div>
                        <div class="sp2-col">
                            <label>단위</label>
                            <input type="text" id="mSpp2Unit" name="spp2_unit" value="EA">
                        </div>
                    </div>
                    <div class="sp2-row">
                        <div class="sp2-col full">
                            <label>적용 설비</label>
                            <input type="text" id="mSpp2Equipment" name="spp2_equipment" placeholder="예) 열처리로 전계열">
                        </div>
                    </div>
                    <div class="sp2-row">
                        <div class="sp2-col">
                            <label>최소재고 (EA)</label>
                            <input type="number" id="mSpp2MinStock" name="spp2_min_stock" value="1" min="0">
                        </div>
                        <div class="sp2-col">
                            <label>교체주기 (개월, 0=없음)</label>
                            <input type="number" id="mSpp2ReplaceCycle" name="spp2_replace_cycle" value="0" min="0">
                        </div>
                    </div>
                </div>
                <div class="sp2-footer">
                    <button type="button" class="sp2-del" id="partsDelBtn" style="display:none;">삭제</button>
                    <button type="button" class="sp2-save" id="partsSaveBtn">저장</button>
                    <button type="button" class="sp2-close" id="partsCloseBtn2">닫기</button>
                </div>
            </div>
        </div>
    </form>

    <!-- ========== 입고 등록 모달 ========== -->
    <form autocomplete="off" id="sp2InForm">
        <div class="sp2-modal" id="inModal">
            <div class="sp2-box" style="width:420px;">
                <div class="sp2-header in-header">
                    📦 입고 등록
                    <button type="button" class="header-close-btn" id="inCloseBtn">&times;</button>
                </div>
                <div class="sp2-body">
                    <div class="sp2-row">
                        <div class="sp2-col full">
                            <label>부품 *</label>
                            <select id="inPartNo" name="spp2_no"></select>
                        </div>
                    </div>
                    <div class="sp2-row">
                        <div class="sp2-col">
                            <label>입고 수량 *</label>
                            <input type="number" id="inQty" name="sph2_qty" min="1" value="1">
                        </div>
                        <div class="sp2-col">
                            <label>담당자</label>
                            <input type="text" id="inUserName" name="sph2_username" placeholder="성명">
                        </div>
                    </div>
                    <div class="sp2-row">
                        <div class="sp2-col full">
                            <label>작업내용</label>
                            <input type="text" id="inWorkDesc" name="sph2_workdesc" placeholder="예) 신규 입고, 정기 발주">
                        </div>
                    </div>
                </div>
                <div class="sp2-footer">
                    <button type="button" class="sp2-save" id="inSaveBtn">저장</button>
                    <button type="button" class="sp2-close" id="inCloseBtn2">닫기</button>
                </div>
            </div>
        </div>
    </form>

    <!-- ========== 사용 등록 모달 ========== -->
    <form autocomplete="off" id="sp2OutForm">
        <div class="sp2-modal" id="outModal">
            <div class="sp2-box" style="width:420px;">
                <div class="sp2-header out-header">
                    🔧 사용 등록
                    <button type="button" class="header-close-btn" id="outCloseBtn">&times;</button>
                </div>
                <div class="sp2-body">
                    <div class="sp2-row">
                        <div class="sp2-col full">
                            <label>부품 *</label>
                            <select id="outPartNo" name="spp2_no"></select>
                        </div>
                    </div>
                    <div class="sp2-row">
                        <div class="sp2-col">
                            <label>사용 수량 *</label>
                            <input type="number" id="outQty" name="sph2_qty" min="1" value="1">
                        </div>
                        <div class="sp2-col">
                            <label>담당자</label>
                            <input type="text" id="outUserName" name="sph2_username" placeholder="성명">
                        </div>
                    </div>
                    <div class="sp2-row">
                        <div class="sp2-col">
                            <label>사용 설비</label>
                            <input type="text" id="outEquipment" name="sph2_equipment" placeholder="예) 열처리로 1호기">
                        </div>
                        <div class="sp2-col">
                            <label>작업내용</label>
                            <input type="text" id="outWorkDesc" name="sph2_workdesc" placeholder="예) 히터 교체">
                        </div>
                    </div>
                </div>
                <div class="sp2-footer">
                    <button type="button" class="sp2-save-out" id="outSaveBtn">사용 처리</button>
                    <button type="button" class="sp2-close" id="outCloseBtn2">닫기</button>
                </div>
            </div>
        </div>
    </form>

<script>
let now_page_code = "e09";
var sp2Table;
var sp2HisTable;
var sp2PartsCache = [];
var sp2IsEditMode = false;
var sp2SelectedRow = null;

//========== 페이지 로드 ==========
$(function(){
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    initTables();
    getSparePart2List();

    $("#fCategory, #fKeyword").on("change keydown", function(e){
        if(e.type === "change" || e.key === "Enter"){ getSparePart2List(); }
    });
    $("#hFrom, #hTo, #hType").on("change", function(){ getSparePart2HisList(); });

    const today = new Date();
    const y = today.getFullYear(), m = String(today.getMonth()+1).padStart(2,'0');
    $("#hFrom").val(y+"-"+m+"-01");
    $("#hTo").val(today.toISOString().slice(0,10));
});

$("#btnSelect").on("click", function(){ getSparePart2List(); });
$("#tabBtnStock").on("click", function(){ showSp2Tab('stock', this); });
$("#tabBtnHistory").on("click", function(){ showSp2Tab('history', this); });

function showSp2Tab(id, btn){
    $("#tab-stock").css("display", id === 'stock' ? '' : 'none');
    $("#tab-history").css("display", id === 'history' ? '' : 'none');
    $(".sp2-tab").removeClass("active");
    $(btn).addClass("active");
    if(id === 'history'){ getSparePart2HisList(); }
}

//========== 테이블 초기화(1회) ==========
function initTables(){
    sp2Table = new Tabulator("#tab1", {
        height:"100%",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        headerSort:false,
        selectableRangeMode:"click",
        reactiveData:false,
        headerHozAlign:"center",
        placeholder:"조회된 데이터가 없습니다.",
        pagination:"local",
        paginationSize:20,
        paginationSizeSelector:[20,50,100,500,1000],
        paginationCounter:"rows",
        columns:[
            {title:"NO", field:"idx", width:50, hozAlign:"center", formatter:function(cell){ return cell.getRow().getPosition(true); }},
            {title:"부품번호", field:"spp2_no", width:120, hozAlign:"center"},
            {title:"품명", field:"spp2_name", width:180, hozAlign:"left"},
            {title:"카테고리", field:"spp2_category", width:90, hozAlign:"center"},
            {title:"적용설비", field:"spp2_equipment", width:150, hozAlign:"left"},
            {title:"단위", field:"spp2_unit", width:60, hozAlign:"center"},
            {title:"최소재고", field:"spp2_min_stock", width:80, hozAlign:"center"},
            {title:"교체주기", field:"spp2_replace_cycle", width:80, hozAlign:"center",
                formatter:function(cell){ var v = cell.getValue(); return (v && v > 0) ? (v+"개월") : "—"; }},
            {title:"총입고", field:"total_in", width:80, hozAlign:"center"},
            {title:"총사용", field:"total_out", width:80, hozAlign:"center"},
            {title:"현재고", field:"current_stock", width:80, hozAlign:"center",
                formatter:function(cell){
                    var v = cell.getValue();
                    var status = cell.getRow().getData().stock_status;
                    var color = status === "재고없음" ? "#C53030" : (status === "부족" ? "#DD6B20" : "#2C7A7B");
                    cell.getElement().style.color = color;
                    cell.getElement().style.fontWeight = "700";
                    return v;
                }},
            {title:"상태", field:"stock_status", width:90, hozAlign:"center",
                formatter:function(cell){
                    var v = cell.getValue();
                    var cls = v === "재고없음" ? "b-none" : (v === "부족" ? "b-low" : "b-ok");
                    return "<span class='badge "+cls+"'>"+v+"</span>";
                }}
        ],
        rowFormatter:function(row){ row.getElement().style.fontWeight = "600"; },
        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
            sp2SelectedRow = row.getData();
        },
        rowDblClick:function(e, row){
            const permission = userPermissions?.[now_page_code];
            if (!['U','D'].includes(permission)) { alert("수정 권한이 없습니다."); return; }
            openPartsModal(row.getData());
        }
    });

    sp2HisTable = new Tabulator("#tab2", {
        height:"100%",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        headerSort:false,
        selectableRangeMode:"click",
        reactiveData:false,
        headerHozAlign:"center",
        placeholder:"조회된 데이터가 없습니다.",
        pagination:"local",
        paginationSize:20,
        paginationSizeSelector:[20,50,100,500,1000],
        paginationCounter:"rows",
        columns:[
            {title:"NO", field:"idx", width:50, hozAlign:"center", formatter:function(cell){ return cell.getRow().getPosition(true); }},
            {title:"일시", field:"sph2_reg_date", width:150, hozAlign:"center"},
            {title:"구분", field:"sph2_type", width:70, hozAlign:"center",
                formatter:function(cell){
                    var v = cell.getValue();
                    return v === "IN" ? "<span class='badge b-in'>입고</span>" : "<span class='badge b-out'>사용</span>";
                }},
            {title:"부품번호", field:"spp2_no", width:110, hozAlign:"center"},
            {title:"품명", field:"spp2_name", width:160, hozAlign:"left"},
            {title:"카테고리", field:"spp2_category", width:90, hozAlign:"center"},
            {title:"수량", field:"sph2_qty", width:70, hozAlign:"center",
                formatter:function(cell){
                    var row = cell.getRow().getData();
                    var v = cell.getValue();
                    return row.sph2_type === "IN"
                        ? "<span style='color:#2B6CB0;font-weight:700'>+"+v+"</span>"
                        : "<span style='color:#C53030;font-weight:700'>-"+v+"</span>";
                }},
            {title:"설비", field:"sph2_equipment", width:130, hozAlign:"left"},
            {title:"작업내용", field:"sph2_workdesc", width:180, hozAlign:"left"},
            {title:"담당자", field:"sph2_username", width:80, hozAlign:"center"},
            {title:"관리", field:"sph2_idx", width:70, hozAlign:"center",
                formatter:function(){ return "<button type='button' class='sp2-his-del-btn' style='padding:2px 8px;font-size:11px;border-radius:4px;border:1px solid #E2E8F0;background:none;cursor:pointer;'>삭제</button>"; },
                cellClick:function(e, cell){
                    const permission = userPermissions?.[now_page_code];
                    if (permission !== 'D') { alert("삭제 권한이 없습니다."); return; }
                    var d = cell.getRow().getData();
                    if(!confirm("이 이력을 삭제하시겠습니까?\n재고 수량이 자동으로 재계산됩니다.")) return;
                    $.ajax({
                        url:"/tkheat/preservation/sparePart2/sparePart2HisDelete",
                        type:"post", dataType:"json",
                        data:{ sph2_idx: d.sph2_idx },
                        success:function(result){
                            if(result.status === "success"){
                                getSparePart2HisList();
                                getSparePart2List();
                            }else{
                                alert("삭제 중 오류가 발생했습니다: " + result.message);
                            }
                        }
                    });
                }}
        ],
        rowFormatter:function(row){ row.getElement().style.fontWeight = "600"; }
    });
}

//========== 재고 현황 조회 ==========
function getSparePart2List(){
    $.ajax({
        url:"/tkheat/preservation/sparePart2/getSparePart2List",
        type:"post", dataType:"json",
        data:{ category: $("#fCategory").val(), keyword: $("#fKeyword").val() },
        success:function(result){
            sp2PartsCache = result.data || [];
            sp2Table.setData(sp2PartsCache);
            updatePartsSelect();

            var none=0, low=0, ok=0;
            sp2PartsCache.forEach(function(r){
                if(r.stock_status === "재고없음") none++;
                else if(r.stock_status === "부족") low++;
                else ok++;
            });
            $("#kTotal").text(sp2PartsCache.length);
            $("#kNone").text(none);
            $("#kLow").text(low);
            $("#kOk").text(ok);
        }
    });
}

function updatePartsSelect(){
    var opts = sp2PartsCache.map(function(p){
        return "<option value='"+esc(p.spp2_no)+"'>"+esc(p.spp2_no)+" — "+esc(p.spp2_name)+"</option>";
    }).join("");
    $("#inPartNo, #outPartNo").html(opts);
}

//========== 입출고 이력 조회 ==========
function getSparePart2HisList(){
    $.ajax({
        url:"/tkheat/preservation/sparePart2/getSparePart2HisList",
        type:"post", dataType:"json",
        data:{ type: $("#hType").val(), fromDt: $("#hFrom").val(), toDt: $("#hTo").val() },
        success:function(result){
            sp2HisTable.setData(result.data || []);
        }
    });
}

//========== 부품 등록/수정 모달 ==========
function openPartsModal(rowData){
    sp2IsEditMode = !!rowData;
    sp2SelectedRow = rowData || null;
    $("#partsModalTitle").text(rowData ? "부품 수정" : "부품 등록");
    $("#sp2PartsForm")[0].reset();

    if(rowData){
        $("#mSpp2No").val(rowData.spp2_no).prop("readonly", true);
        $("#mSpp2Name").val(rowData.spp2_name);
        $("#mSpp2Category").val(rowData.spp2_category);
        $("#mSpp2Equipment").val(rowData.spp2_equipment);
        $("#mSpp2Unit").val(rowData.spp2_unit || "EA");
        $("#mSpp2MinStock").val(rowData.spp2_min_stock);
        $("#mSpp2ReplaceCycle").val(rowData.spp2_replace_cycle);
        var permission = userPermissions?.[now_page_code];
        $("#partsDelBtn").toggle(permission === 'D');
    }else{
        $("#mSpp2No").val("").prop("readonly", false);
        $("#mSpp2Unit").val("EA");
        $("#mSpp2MinStock").val("1");
        $("#mSpp2ReplaceCycle").val("0");
        $("#partsDelBtn").hide();
    }

    $("#partsOverlay").addClass("active");
    $("#partsModal").addClass("active");
    registerModalOpen('sparePart2-main', closePartsModal);
}
function closePartsModal(){
    registerModalClose('sparePart2-main');
    $("#partsOverlay").removeClass("active");
    $("#partsModal").removeClass("active");
}

$("#btnAdd").on("click", function(){
    const permission = userPermissions?.[now_page_code];
    if (!['I','U','D'].includes(permission)) { alert("등록 권한이 없습니다."); return; }
    openPartsModal(null);
});
$("#partsCloseBtn, #partsCloseBtn2").on("click", closePartsModal);

$("#partsSaveBtn").on("click", function(){
    const permission = userPermissions?.[now_page_code];
    if (sp2IsEditMode) {
        if (!['U','D'].includes(permission)) { alert("수정 권한이 없습니다."); return; }
    } else {
        if (!['I','U','D'].includes(permission)) { alert("등록 권한이 없습니다."); return; }
    }

    var spp2_no = $("#mSpp2No").val().trim();
    var spp2_name = $("#mSpp2Name").val().trim();
    if(!spp2_no || !spp2_name){ alert("부품번호와 품명은 필수입니다."); return; }
    if(!confirm(sp2IsEditMode ? "수정하시겠습니까?" : "저장하시겠습니까?")) return;

    $.ajax({
        url:"/tkheat/preservation/sparePart2/sparePart2Save",
        type:"post", dataType:"json",
        data:{
            mode: sp2IsEditMode ? "update" : "insert",
            spp2_no: spp2_no,
            spp2_name: spp2_name,
            spp2_category: $("#mSpp2Category").val(),
            spp2_equipment: $("#mSpp2Equipment").val().trim(),
            spp2_unit: $("#mSpp2Unit").val().trim() || "EA",
            spp2_min_stock: $("#mSpp2MinStock").val() || 0,
            spp2_replace_cycle: $("#mSpp2ReplaceCycle").val() || 0
        },
        success:function(result){
            if(result.status !== "success"){ alert(result.message || "저장 실패"); return; }
            alert("저장 되었습니다.");
            closePartsModal();
            getSparePart2List();
        }
    });
});

$("#partsDelBtn").on("click", function(){
    const permission = userPermissions?.[now_page_code];
    if (permission !== 'D') { alert("삭제 권한이 없습니다."); return; }
    if(!sp2SelectedRow || !sp2SelectedRow.spp2_no) return;
    if(!confirm("["+sp2SelectedRow.spp2_no+"] 부품을 삭제하시겠습니까?\n관련 입출고 이력도 함께 삭제됩니다.")) return;

    $.ajax({
        url:"/tkheat/preservation/sparePart2/sparePart2Delete",
        type:"post", dataType:"json",
        data:{ spp2_no: sp2SelectedRow.spp2_no },
        success:function(result){
            if(result.status !== "success"){ alert(result.message || "삭제 실패"); return; }
            alert("삭제되었습니다.");
            closePartsModal();
            getSparePart2List();
        }
    });
});

//========== 입고 모달 ==========
function openInModal(){
    if(sp2PartsCache.length === 0){ alert("먼저 부품을 등록하세요."); return; }
    $("#sp2InForm")[0].reset();
    $("#inQty").val("1");
    $("#inWorkDesc").val("신규 입고");
    if(sp2SelectedRow) $("#inPartNo").val(sp2SelectedRow.spp2_no);
    $("#inModal").addClass("active");
    registerModalOpen('sparePart2-in', closeInModal);
}
function closeInModal(){
    registerModalClose('sparePart2-in');
    $("#inModal").removeClass("active");
}
$("#btnIn").on("click", function(){
    const permission = userPermissions?.[now_page_code];
    if (!['I','U','D'].includes(permission)) { alert("등록 권한이 없습니다."); return; }
    openInModal();
});
$("#inCloseBtn, #inCloseBtn2").on("click", closeInModal);
$("#inSaveBtn").on("click", function(){
    var qty = parseInt($("#inQty").val());
    if(!qty || qty < 1){ alert("수량을 1 이상 입력하세요."); return; }
    $.ajax({
        url:"/tkheat/preservation/sparePart2/sparePart2HisSave",
        type:"post", dataType:"json",
        data:{
            spp2_no: $("#inPartNo").val(),
            sph2_type: "IN",
            sph2_qty: qty,
            sph2_workdesc: $("#inWorkDesc").val().trim(),
            sph2_username: $("#inUserName").val().trim()
        },
        success:function(result){
            if(result.status !== "success"){ alert(result.message || "저장 실패"); return; }
            closeInModal();
            getSparePart2List();
        }
    });
});

//========== 사용 모달 ==========
function openOutModal(){
    if(sp2PartsCache.length === 0){ alert("먼저 부품을 등록하세요."); return; }
    $("#sp2OutForm")[0].reset();
    $("#outQty").val("1");
    if(sp2SelectedRow) $("#outPartNo").val(sp2SelectedRow.spp2_no);
    $("#outModal").addClass("active");
    registerModalOpen('sparePart2-out', closeOutModal);
}
function closeOutModal(){
    registerModalClose('sparePart2-out');
    $("#outModal").removeClass("active");
}
$("#btnOut").on("click", function(){
    const permission = userPermissions?.[now_page_code];
    if (!['I','U','D'].includes(permission)) { alert("등록 권한이 없습니다."); return; }
    openOutModal();
});
$("#outCloseBtn, #outCloseBtn2").on("click", closeOutModal);
$("#outSaveBtn").on("click", function(){
    var qty = parseInt($("#outQty").val());
    if(!qty || qty < 1){ alert("수량을 1 이상 입력하세요."); return; }
    var partNo = $("#outPartNo").val();
    var part = sp2PartsCache.find(function(p){ return p.spp2_no === partNo; });
    if(part && part.current_stock < qty){
        if(!confirm("현재 재고("+part.current_stock+")보다 많은 수량입니다. 계속 진행하시겠습니까?")) return;
    }
    $.ajax({
        url:"/tkheat/preservation/sparePart2/sparePart2HisSave",
        type:"post", dataType:"json",
        data:{
            spp2_no: partNo,
            sph2_type: "OUT",
            sph2_qty: qty,
            sph2_equipment: $("#outEquipment").val().trim(),
            sph2_workdesc: $("#outWorkDesc").val().trim(),
            sph2_username: $("#outUserName").val().trim()
        },
        success:function(result){
            if(result.status !== "success"){ alert(result.message || "저장 실패"); return; }
            closeOutModal();
            getSparePart2List();
        }
    });
});

//========== 엑셀 다운로드 ==========
$("#btnExcel").on("click", function(){
    const data1 = sp2Table ? sp2Table.getData() : [];
    const columns1 = sp2Table ? sp2Table.getColumnDefinitions() : [];
    const ws = XLSX.utils.aoa_to_sheet([]);
    let rowIndex = 0;

    if(data1.length > 0){
        const headers1 = columns1.filter(c => c.visible !== false).map(col => col.title);
        const fields1 = columns1.filter(c => c.visible !== false).map(col => col.field);
        XLSX.utils.sheet_add_aoa(ws, [["[SparePart관리(V2) 재고현황]"]], { origin: rowIndex++ });
        XLSX.utils.sheet_add_aoa(ws, [headers1], { origin: rowIndex++ });
        const rows1 = data1.map(row => fields1.map(f => row[f] || ''));
        XLSX.utils.sheet_add_aoa(ws, rows1, { origin: rowIndex });
        rowIndex += rows1.length;
    }

    const maxCols = columns1.length;
    ws['!cols'] = Array.from({ length: maxCols }, () => ({ wch: 16 }));

    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "SparePart관리V2");
    const today = new Date().toISOString().slice(0,10).replace(/-/g,"");
    XLSX.writeFile(wb, "SparePart관리V2_"+today+".xlsx");
});

//========== 모달 드래그(공통) ==========
function makeModalDraggable(headerSel, modalSel){
    const header = document.querySelector(headerSel);
    const modal = document.querySelector(modalSel);
    if(!header || !modal) return;
    header.addEventListener('mousedown', function(e){
        if (e.target.classList.contains('header-close-btn') || e.target.closest('.header-close-btn')) return;
        const rect = modal.getBoundingClientRect();
        modal.style.left = rect.left + 'px';
        modal.style.top = rect.top + 'px';
        modal.style.transform = 'none';
        let offsetX = e.clientX - rect.left;
        let offsetY = e.clientY - rect.top;
        function moveModal(e){
            modal.style.left = (e.clientX - offsetX) + 'px';
            modal.style.top = (e.clientY - offsetY) + 'px';
        }
        function stopMove(){
            window.removeEventListener('mousemove', moveModal);
            window.removeEventListener('mouseup', stopMove);
        }
        window.addEventListener('mousemove', moveModal);
        window.addEventListener('mouseup', stopMove);
    });
}
makeModalDraggable('#partsModal .sp2-header', '#partsModal');
makeModalDraggable('#inModal .sp2-header', '#inModal');
makeModalDraggable('#outModal .sp2-header', '#outModal');

function esc(s){ return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
</script>
</body>
</html>
