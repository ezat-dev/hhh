<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비가동율분석</title>
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
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -1050px;
}

.box1 select{
	width: 5%
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
	margin-right: 10px; /* 요소 사이 간격 */
}

/* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main {
    flex: 1;
    min-height: 0;
    display: flex;
    flex-direction: column;
    gap: 8px;
    padding: 8px;
    overflow: hidden;
}

/* ========== 가동율 차트 카드 ========== */
.chart-card {
    flex-shrink: 0;
    height: 260px;
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 8px 12px;
    box-sizing: border-box;
}
#runRateChart {
    width: 100%;
    height: 100%;
}

/* ========== 하단 리스트 2단 배치 ========== */
.lists-row {
    flex: 1;
    min-height: 0;
    display: flex;
    gap: 8px;
}
.lists-row .container {
    flex: 1;
    min-width: 0;
    display: flex;
    flex-direction: column;
    min-height: 0;
}
.lists-row .container.wide {
    flex: 2;
}
.lists-row .container.narrow {
    flex: 1;
}

/* ========== 선택 설비 평균 패널 ========== */
.avg-summary {
    flex: 1;
    min-height: 0;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 10px;
}
.avg-empty {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #A0AEC0;
    font-size: 13px;
    text-align: center;
    padding: 20px;
}
.avg-names {
    font-size: 12px;
    color: #4A5568;
    background: #F7FAFC;
    border: 1px solid #E2E8F0;
    border-radius: 8px;
    padding: 8px 10px;
    word-break: break-all;
}
.avg-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
}
.avg-card {
    background: #F7FAFC;
    border: 1px solid #E2E8F0;
    border-radius: 8px;
    padding: 10px 12px;
}
.avg-label {
    font-size: 12px;
    color: #718096;
    margin-bottom: 4px;
}
.avg-value {
    font-size: 18px;
    font-weight: 700;
    color: #2B6CB0;
}
.lists-row .container > .tabulator {
    flex: 1;
    min-height: 0;
}
.list-title {
    flex-shrink: 0;
    font-size: 13px;
    font-weight: 700;
    color: #2D3748;
    margin: 0 0 6px 2px;
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
#tab1.tabulator, #tab2.tabulator {
    flex: 1;
    min-height: 0;
    border: none;
    font-size: 12px;
}
#tab1 .tabulator-header, #tab2 .tabulator-header {
    background: linear-gradient(135deg, #2B6CB0, #3182CE);
    border-bottom: none;
}
#tab1 .tabulator-col, #tab2 .tabulator-col {
    background: transparent;
    border-right: 1px solid rgba(255,255,255,.15);
}
#tab1 .tabulator-col.tabulator-sortable:hover, #tab2 .tabulator-col.tabulator-sortable:hover {
    background: rgba(255,255,255,.08);
}
#tab1 .tabulator-col-title, #tab2 .tabulator-col-title {
    color: #ffffff;
    font-weight: 700;
}
#tab1 .tabulator-col .tabulator-header-filter input, #tab2 .tabulator-col .tabulator-header-filter input {
    border: none;
    border-radius: 5px;
    padding: 4px 6px;
    font-size: 11px;
    background: rgba(255,255,255,.92);
    box-sizing: border-box;
}
#tab1 .tabulator-col .tabulator-header-filter input:focus, #tab2 .tabulator-col .tabulator-header-filter input:focus {
    outline: none;
    background: #ffffff;
    box-shadow: 0 0 0 2px rgba(255,255,255,.6);
}
#tab1 .tabulator-row, #tab2 .tabulator-row {
    border-bottom: 1px solid #EDF2F7;
    transition: background-color .12s;
}
#tab1 .tabulator-row.tabulator-row-even, #tab2 .tabulator-row.tabulator-row-even {
    background-color: #F7FAFC;
}
#tab1 .tabulator-row:hover, #tab2 .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#tab1 .tabulator-row.row_select,
#tab2 .tabulator-row.row_select,
#tab1 .tabulator-row.tabulator-selected,
#tab2 .tabulator-row.tabulator-selected {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#tab1 .tabulator-cell, #tab2 .tabulator-cell {
    border: 1px solid #E2E8F0;
    color: #2D3748;
}

/* ========== 페이지네이션 (직관적으로 개선) ========== */
#tab1 .tabulator-footer, #tab2 .tabulator-footer {
    background: #F7FAFC;
    border-top: 1px solid #E2E8F0;
    padding: 8px 12px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
}
#tab1 .tabulator-paginator, #tab2 .tabulator-paginator {
    display: flex;
    align-items: center;
    gap: 6px;
}
#tab1 .tabulator-page-size, #tab2 .tabulator-page-size {
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    padding: 4px 8px;
    font-size: 12px;
    background: #ffffff;
    color: #2D3748;
    cursor: pointer;
    margin: 0;
}
#tab1 .tabulator-page-size:focus, #tab2 .tabulator-page-size:focus {
    outline: none;
    border-color: #3182CE;
}
#tab1 .tabulator-pages, #tab2 .tabulator-pages {
    display: flex;
    gap: 4px;
    margin: 0;
}
#tab1 .tabulator-page, #tab2 .tabulator-page {
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
#tab1 .tabulator-page.active, #tab2 .tabulator-page.active {
    background: #3182CE;
    border-color: #2B6CB0;
    color: #ffffff;
}
#tab1 .tabulator-page:not(:disabled):hover, #tab2 .tabulator-page:not(:disabled):hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
    color: #2B6CB0;
    cursor: pointer;
}
#tab1 .tabulator-page:disabled, #tab2 .tabulator-page:disabled {
    opacity: .4;
    cursor: not-allowed;
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
        <button class="select-button" onclick="searchBegaAnaly();">
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
		<div class="chart-card">
			<div id="runRateChart"></div>
		</div>
		<div class="lists-row">
			<div class="container wide">
				<div class="list-title">가동율 상세</div>
				<div id="tab1" class="tabulator"></div>
			</div>
			<div class="container narrow">
				<div class="list-title">선택 설비 평균</div>
				<div id="begaAvgSummary" class="avg-summary">
					<div class="avg-empty">가동율 상세에서 설비를 체크하면 선택한 설비들의 평균치가 표시됩니다.</div>
				</div>
			</div>
		</div>
	</main>
	    
	    
<script>
	//전역변수
	let now_page_code = "e03";
    var cutumTable;	

  //로드
	$(function() {
		var tdate = todayDate();
		var ydate = yesterDate();

		$("#sdate").val(tdate);
		$("#edate").val(tdate);
		searchBegaAnaly();
	});

	//이벤트
	//함수
	function searchBegaAnaly(){
		getBegaAnalyList();
	}

	//설비별 가동율 막대그래프 (침탄로1~5호기, 템퍼링1~2호기 고정 순서)
	function renderRunRateChart(data){
		if(!data){ data = []; }

		var categories = data.map(function(d){ return "[" + d.gubn + "] " + d.fac_name; });
		var values = data.map(function(d){ return parseFloat(d.RunRate) || 0; });

		Highcharts.chart("runRateChart", {
			chart:{ type:"bar" },
			title:{ text:"설비별 가동율(%)", style:{ fontSize:"14px" } },
			xAxis:{ categories:categories, reversed:true, labels:{ style:{ fontSize:"11px" } } },
			yAxis:{
				min:0, max:100, tickInterval:10,
				title:{ text:null },
				plotLines:[
					{ value:70, color:"#e74c3c", width:1, dashStyle:"Dash" },
					{ value:90, color:"#2ecc71", width:1, dashStyle:"Dash" }
				]
			},
			legend:{ enabled:false },
			tooltip:{ valueSuffix:"%" },
			plotOptions:{
				bar:{
					dataLabels:{ enabled:true, format:"{y}%" },
					zones:[
						{ value:70, color:"#e74c3c" },
						{ value:90, color:"#f1c40f" },
						{ color:"#2ecc71" }
					]
				}
			},
			credits:{ enabled:false },
			series:[{ name:"가동율", data:values }]
		});
	}

	function getBegaAnalyList(){
		userTable = new Tabulator("#tab1", {
		    height:"100%",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    headerSort:false,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/preservation/begaAnaly/getBegaAnalyList",
		    ajaxParams:{"sdate" : $("#sdate").val(),
				"edate" : $("#edate").val()},
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
		    paginationSize:20,
		    paginationSizeSelector:[20,50,100,500,1000],
		    paginationCounter:"rows",
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
				renderRunRateChart(response.data ? response.data : response);
				setTimeout(updateBegaAvgSummary, 0);
		        return response.data ? response.data : response; //return the response data to tabulator
		    },
		    columns:[
		        {formatter:"rowSelection", titleFormatter:"rowSelection", hozAlign:"center",
		        	headerSort:false, width:36, download:false, cellClick:function(e, cell){
		        		cell.getRow().toggleSelect();
		        	}},
		        {title:"NO", field:"idx", sorter:"int", width:60,
		        	hozAlign:"center"},
		        {title:"구분", field:"gubn", sorter:"string", width:70,
			        hozAlign:"center"},
		        {title:"설비", field:"fac_name", sorter:"string", width:100,
			        hozAlign:"center"},
			    {title:"전체시간", field:"total_time", sorter:"int", width:90,
				    hozAlign:"center", formatter:function(cell){
						return formatWorkTime(cell.getValue());
					}},
			    {title:"가동시간", field:"run_time", sorter:"int", width:90,
				    hozAlign:"center", formatter:function(cell){
						return formatWorkTime(cell.getValue());
					}},
				{title:"가동율(%)", field:"RunRate", sorter:"number", width:80,
				    hozAlign:"center"},
				{title:"자연비가동", field:"idle_natural", sorter:"int", width:90,
				    hozAlign:"center", formatter:function(cell){
						return formatWorkTime(cell.getValue());
					}},
				{title:"등록비가동", field:"idle_registered", sorter:"int", width:90,
				    hozAlign:"center", formatter:function(cell){
						return formatWorkTime(cell.getValue());
					}},
				{title:"총비가동", field:"idle_total", sorter:"int", width:90,
				    hozAlign:"center", formatter:function(cell){
						return formatWorkTime(cell.getValue());
					}},
				{title:"비가동율(%)", field:"idle_rate", sorter:"number", width:90,
				    hozAlign:"center"},
				{title:"작업수", field:"work_cnt", sorter:"int", width:70,
				    hozAlign:"center"},
				{title:"작업중량", field:"work_jung", sorter:"number", width:90,
				    hozAlign:"center", formatter:function(cell){
						var v = parseFloat(cell.getValue());
						return isNaN(v) ? "-" : Math.round(v);
					}},
				{title:"총작업시간", field:"work_time", sorter:"int", width:100,
				    hozAlign:"center", formatter:function(cell){
						return formatWorkTime(cell.getValue());
					}},
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();

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

				var rowData = row.getData();

			},
			rowSelectionChanged:function(data, rows){
				updateBegaAvgSummary();
			},
		});
	}

	//선택된 설비들의 평균치를 "선택 설비 평균" 패널에 표시
	function updateBegaAvgSummary(){
		var box = $("#begaAvgSummary");
		var rows = (userTable && userTable.getSelectedData) ? userTable.getSelectedData() : [];

		if(!rows || rows.length === 0){
			box.html('<div class="avg-empty">가동율 상세에서 설비를 체크하면 선택한 설비들의 평균치가 표시됩니다.</div>');
			return;
		}

		var n = rows.length;
		var sum = { RunRate:0, idle_rate:0, work_cnt:0, work_jung:0, work_time:0 };
		rows.forEach(function(r){
			sum.RunRate    += parseFloat(r.RunRate)    || 0;
			sum.idle_rate  += parseFloat(r.idle_rate)  || 0;
			sum.work_cnt   += parseFloat(r.work_cnt)   || 0;
			sum.work_jung  += parseFloat(r.work_jung)  || 0;
			sum.work_time  += parseFloat(r.work_time)  || 0;
		});

		var names = rows.map(function(r){ return r.fac_name; }).join(", ");

		var html = '';
		html += '<div class="avg-names">선택 설비 (' + n + '개) : ' + names + '</div>';
		html += '<div class="avg-grid">';
		html += begaAvgCard('평균 가동율', (sum.RunRate / n).toFixed(2) + '%');
		html += begaAvgCard('평균 비가동율', (sum.idle_rate / n).toFixed(2) + '%');
		html += begaAvgCard('평균 작업수', Math.round(sum.work_cnt / n) + '건');
		html += begaAvgCard('평균 작업중량', Math.round(sum.work_jung / n));
		html += begaAvgCard('평균 총작업시간', formatWorkTime(Math.round(sum.work_time / n)));
		html += '</div>';

		box.html(html);
	}

	function begaAvgCard(label, value){
		return '<div class="avg-card"><div class="avg-label">' + label + '</div><div class="avg-value">' + value + '</div></div>';
	}

	//분 -> N시간 M분 형식으로 표시
	function formatWorkTime(minutes){
		var m = parseInt(minutes);
		if(isNaN(m) || m < 0){ return "-"; }
		var h = Math.floor(m / 60);
		var mm = m % 60;
		if(h > 0){
			return h + "시간 " + mm + "분";
		}
		return mm + "분";
	}

	// ========== 엑셀 다운로드 ==========
	$(".excel-button").click(function () {
	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "설비가동율분석_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "설비가동율분석" });
	});

    </script>

	</body>
</html>
