<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>템퍼링작업실적</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>
    <style>

.main{
	width:98%;
}
.container {
	display: flex;
	justify-content: space-between;
}
.tabulator {
	width: 100%;
	max-width: 100%;
	max-height: 900px;
	overflow-x: hidden !important;
}
.tabulator .tabulator-cell {
	white-space: normal !important;
	word-break: break-word;
	text-align: center;
}
.row_select{
	background-color:#9ABCEA !important;
}
.box1 {
	display: flex;
	align-items: center;
	flex-wrap: wrap;
	gap: 8px;
}
.daylabel {
	font-size: 12px;
	font-weight: 600;
	color: #495057;
	white-space: nowrap;
}
/* 작업지시(적재/열처리/템퍼링) 메뉴의 검색줄과 동일한 크기/톤으로 통일 */
.datetimepicker_date,
.search_input,
.box1 select,
.box1 input[type="text"],
.box1 input[type="number"] {
	height: 30px;
	padding: 0 8px;
	font-size: 12px !important;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	color: #333;
	outline: none;
	box-sizing: border-box;
	transition: border-color .2s ease, background-color .2s ease;
}
.datetimepicker_date:focus,
.search_input:focus,
.box1 select:focus,
.box1 input:focus {
	border-color: #3182CE;
	background-color: #fff;
}
.datetimepicker_date {
	width: 140px !important;
	text-align: center;
}
.search_input {
	width: 140px !important;
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
    padding: 8px 14px;
}
.button-container .select-button,
.button-container .insert-button,
.button-container .excel-button,
.button-container .printer-button,
.button-container .select-hogi-button,
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
.button-container .select-hogi-button:hover,
.button-container .delete:hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
}

/* ========== 리스트 카드 영역 ========== */
.container {
    display: flex;
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
#tab1 .tabulator-footer {
    background: #F7FAFC;
    border-top: 1px solid #E2E8F0;
    padding: 8px 12px;
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
    </style>


    <body>

    <div class="tab">
    <div class="box1">
		<label class="daylabel">작업일 :</label>
		<input type="text" id="s_all_sdate" class="datetimepicker_date">
		~
		<input type="text" id="s_all_edate" class="datetimepicker_date">
		<label class="daylabel">거래처 :</label>
		<input type="text" id="s_all_corp_name" class="search_input">
		<label class="daylabel">품명 :</label>
		<input type="text" id="s_all_prod_name" class="search_input">
		<label class="daylabel">품번 :</label>
		<input type="text" id="s_all_prod_no" class="search_input">
		<label class="daylabel">단취코드 :</label>
		<input type="text" id="s_all_ilbo_code" class="search_input" style="width:90px;">
		<label class="daylabel">수주번호 :</label>
		<input type="text" id="s_all_ord_code" class="search_input" style="width:90px;">
	</div>

    <div class="button-container">
        <button class="select-button" onclick="getTemSiljukList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
        엑셀
        </button>
    </div>
</div>
    <div class="tab">
    <div class="button-container" style="margin-left:0;">
        <button class="select-hogi-button select-button" type="button" onclick="selectHogiBtn(0);" id="selectHogi0">
            전체호기
        </button>
        <button class="select-hogi-button select-button" type="button" onclick="selectHogiBtn(16);" id="selectHogi16">
            템퍼링 1호기
        </button>
        <button class="select-hogi-button select-button" type="button" onclick="selectHogiBtn(17);" id="selectHogi17">
            템퍼링 2호기
        </button>
	</div>
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>
	<input type="number" id="s_fac_code" value="0" style="display:none;" />


<script>
//전역변수
let now_page_code = "c03";
var temSiljukTable;

//로드
$(function(){
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }

	var tdate = todayDate();
	var ydate = yesterDate();

	$("#s_all_sdate").val(ydate);
	$("#s_all_edate").val(tdate);
	getTemSiljukList();
});

//템퍼링작업실적 조회 (작업지시-템퍼링 메뉴와 동일한 리스트를 조회전용으로 표시)
function getTemSiljukList(){

	if(temSiljukTable){
		temSiljukTable.destroy();
		temSiljukTable = null;
	}

	temSiljukTable = new Tabulator("#tab1", {
	    height:"100%",
	    layout:"fitColumns",
	    selectable:true,
	    tooltips:true,
	    selectableRangeMode:"click",
	    reactiveData:false,
	    headerHozAlign:"center",
	    headerSort:false,
	    ajaxConfig:"POST",
	    ajaxLoader:false,
	    ajaxURL:"/tkheat/workilbo/tf/allList",
	    ajaxParams:{
	    	"s_sdate": $("#s_all_sdate").val(),
            "s_edate": $("#s_all_edate").val(),
            "s_corp_name": $("#s_all_corp_name").val(),
            "s_prod_name": $("#s_all_prod_name").val(),
            "s_prod_no": $("#s_all_prod_no").val(),
            "s_fac_code": $("#s_fac_code").val(),
            "s_ilbo_code": $("#s_all_ilbo_code").val(),
            "s_ord_code": $("#s_all_ord_code").val()
		},
	    placeholder:"조회된 데이터가 없습니다.",
	    pagination:"local",
	    paginationSize:20,
	    paginationSizeSelector:[20,50,100,500,1000],
	    paginationCounter:"rows",
        headerFilterPlaceholder: "",
	    ajaxResponse:function(url, params, response){
			$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
			return response.data ? response.data : response;
	    },
	    columns:[
	        {title:"NO", formatter:"rownum", width:40, hozAlign:"center", headerSort:false},
	        {title:"적재코드", field:"danch_barcode", sorter:"string", width:100, hozAlign:"center"},
	        {title:"작업일", field:"ilbo_strt_date", sorter:"string", width:60,
		        hozAlign:"center",
		        formatter:function(cell){
		        	var value = cell.getValue();
		        	if(!value) return "";
		        	return value.substring(5,10);
		        }
	        },
	        {title:"설비", field:"fac_no", sorter:"string", width:80, hozAlign:"center"},
	        {title:"생산LOT", field:"ilbo_lot", sorter:"string", width:120, hozAlign:"center"},
	        {title:"시작", field:"ilbo_strt_time", sorter:"string", width:60, hozAlign:"center"},
	        {title:"종료", field:"ilbo_end_time", sorter:"string", width:60, hozAlign:"center"},
	        {title:"입고일", field:"ord_input_view", sorter:"string", width:100, hozAlign:"center"},
	        {title:"거래처", field:"corp_name", sorter:"string", width:140, hozAlign:"left"},
	        {title:"품명", field:"prod_name", sorter:"string", width:240, hozAlign:"left"},
	        {title:"품번", field:"prod_no", sorter:"string", width:140, hozAlign:"left"},
	        {title:"규격", field:"prod_gyu", sorter:"string", width:100, hozAlign:"left"},
	        {title:"재질", field:"prod_jai", sorter:"string", width:100, hozAlign:"left"},
	        {title:"수량", field:"ilbo_su", sorter:"string", width:60, hozAlign:"right"},
	        {title:"중량", field:"ilbo_jung", sorter:"string", width:80, hozAlign:"right"},
	        {title:"비고", field:"ilbo_bigo", sorter:"string", width:100, hozAlign:"center"},
	    ],
	    rowFormatter:function(row){
		    var data = row.getData();
		    var ilbo_end = data.ilbo_end;
		    if(ilbo_end == "1900-01-01 00:00"){
		    	row.getElement().style.backgroundColor = "#FAED7D";
		    }else{
		    	row.getElement().style.backgroundColor = "#FFFFFF";
		    }
		},
		rowClick:function(e, row){
			$("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
				if($(this).hasClass("row_select")){
					$(this).removeClass('row_select');
					row.getElement().className += " row_select";
				}else{
					$("#tab1 div.row_select").removeClass("row_select");
					row.getElement().className += " row_select";
				}
			});
		},
	});
}

function selectHogiBtn(hogi){
	var hogiArray = [0,16,17];

	for(var i=0; i<hogiArray.length; i++){
		if(hogiArray[i] == hogi){
			$("#selectHogi"+hogi).css({"background-color":"#BEE3F8","border-color":"#3182CE","color":"#1A365D"});
		}else{
			$("#selectHogi"+hogiArray[i]).css({"background-color":"#F0F4F8","border-color":"#E2E8F0","color":"#2D3748"});
		}
	}

	$("#s_fac_code").val(hogi);
	getTemSiljukList();
}

// ========== 엑셀 다운로드 ==========
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "템퍼링작업실적_" + today + ".xlsx";
    temSiljukTable.download("xlsx", filename, { sheetName: "템퍼링작업실적" });
});

    </script>

	</body>
</html>
