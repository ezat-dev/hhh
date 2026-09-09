<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품별재고현황</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
    <style>

.tabulator .tabulator-cell {
	white-space: normal !important;
	word-break: break-word;
	text-align: center;
}

/* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main {
    flex: 1;
    min-height: 0;
    width: 100%;
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
    padding: 0 14px;
}
.button-container .select-button,
.button-container .insert-button,
.button-container .excel-button,
.button-container .printer-button,
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
    width: 100%;
    min-width: 0;
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
#tab1 .tabulator-col .tabulator-header-filter input {
    border: none;
    border-radius: 5px;
    padding: 4px 6px;
    font-size: 11px;
    background: rgba(255,255,255,.92);
    box-sizing: border-box;
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

/* ========== 페이지네이션 (직관적으로 개선) ========== */
#tab1 .tabulator-footer {
    background: #F7FAFC;
    border-top: 1px solid #E2E8F0;
    padding: 8px 12px;
}
#tab1 .tabulator-paginator {
    display: inline-flex;
    align-items: center;
    gap: 6px;
}
#tab1 .tabulator-page-size {
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    padding: 4px 8px;
    font-size: 12px;
    background: #ffffff;
    color: #2D3748;
    cursor: pointer;
    margin: 0;
}
#tab1 .tabulator-page-size:focus {
    outline: none;
    border-color: #3182CE;
}
#tab1 .tabulator-pages {
    display: flex;
    gap: 4px;
    margin: 0;
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
    transition: background-color .13s, border-color .13s, color .13s;
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
#tab1 .tabulator-page:disabled {
    opacity: .4;
    cursor: not-allowed;
}

 .box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -380px;
}
.box1 input{
	width: 5%
}  
.box1 input{
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

.box1 input:focus {
	border: 1px solid #007bff;
	background-color: #fff;
}  
.box1 label,
.box1 input {
	margin-right: 10px; /* 요소 사이 간격 */
}   
     
    
    </style>
    
    
    <body>

    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
		<label class="daylabel">입고일 : </label>
		<input type="date" id="dan_ipgo_sdate" style="font-size: 16px;" autocomplete="off"> ~
		<input type="date" id="dan_ipgo_edate" style="font-size: 16px;" autocomplete="off">
		<label class="daylabel margin_left">거래처</label>
		<input type="text" id="dan_ipgo_cname" style="font-size: 16px;" autocomplete="off">
		<label class="daylabel margin_left">품명</label>
		<input type="text" id="dan_ipgo_pname" style="font-size: 16px;" autocomplete="off">
		<label class="daylabel margin_left">품번</label>
		<input type="text" id="dan_ipgo_pno" style="font-size: 16px;" autocomplete="off">
	</div>

    <div class="button-container">
        <button class="select-button" onclick="getPJaegoStatusList();">
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
	    
	    
<script>


	

	//전역변수
	let now_page_code = "a03";
    var userTable;

	//로드
	$(function(){
		//단취(적재) 모달의 "입고이력조회"와 동일하게, 아직 소진 안 된 입고 LOT 기준 최근 1주일치를 기본으로 조회
		$("#dan_ipgo_sdate").val(beforeWeekDate());
		$("#dan_ipgo_edate").val(todayDate());
		getPJaegoStatusList();
	});

	//이벤트
	//함수
	function getPJaegoStatusList(){

		userTable = new Tabulator("#tab1", {
		    tableBuilt:function(){ this.redraw(true); },
		    height:"100%",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    headerSort:false,
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
	        paginationSize:20,
	        paginationSizeSelector:[20,50,100,500,1000],
	        paginationCounter:"rows",
		    columns:[
		        {title:"NO", formatter:"rownum", width:40, hozAlign:"center", headerSort:false},
		        {title:"수주번호", field:"ord_code", sorter:"string", width:100, hozAlign:"center"},
		        {title:"입고일", field:"ord_input_view", sorter:"string", width:100, hozAlign:"center"},
		        {title:"거래처", field:"corp_name", sorter:"string", width:140, hozAlign:"left"},
		        {title:"품명", field:"prod_name", sorter:"string", width:240, hozAlign:"left"},
		        {title:"품번", field:"prod_no", sorter:"string", width:140, hozAlign:"left"},
		        {title:"입고수량", field:"ord_su", sorter:"string", width:80, hozAlign:"center"},
		        {title:"단취기준수량", field:"wstd_t43", sorter:"string", width:100, hozAlign:"center",
			        formatter:function(cell){
			        	var value = cell.getValue();
			        	if(value == 0){
			        		return "<span style='color:#ff0000; font-weight:bold;'>" + value + "</span>";
			        	}else{
			        		return value;
			        	}
			        }},
		        {title:"단취완료수량", field:"danch_su", sorter:"string", width:100, hozAlign:"center"},
		        {title:"잔량", field:"danch_remain_su", sorter:"string", width:80, hozAlign:"center"},
		    ],
		    rowFormatter:function(row){
			    row.getElement().style.fontWeight = "600";
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

		var searchObj = {
			"dan_ipgo_cname":$("#dan_ipgo_cname").val(),
			"dan_ipgo_pname":$("#dan_ipgo_pname").val(),
			"dan_ipgo_pno":$("#dan_ipgo_pno").val(),
			"dan_ipgo_sdate":$("#dan_ipgo_sdate").val(),
			"dan_ipgo_edate":$("#dan_ipgo_edate").val()
		};

		$.ajax({
			url:"/tkheat/workilbo/danch/ipgoList",
			type:"post",
			dataType:"json",
			traditional: true,
			data:{
				"danchSettingDataList":"[]",
				"searchObjParam":JSON.stringify(searchObj)
			},
			success:function(result){
				userTable.setData(result.data);
			}
		});
	}

	// ========== 엑셀 다운로드 ==========
	$(".excel-button").click(function () {
	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "제품별재고현황_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "제품별재고현황" });
	});

    </script>

	</body>
</html>
