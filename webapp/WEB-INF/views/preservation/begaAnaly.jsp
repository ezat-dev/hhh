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
			<div class="container">
				<div class="list-title">가동율 상세</div>
				<div id="tab1" class="tabulator"></div>
			</div>
			<div class="container">
				<div class="list-title">작업현황</div>
				<div id="tab2" class="tabulator"></div>
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

		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		searchBegaAnaly();
	});

	//이벤트
	//함수
	function searchBegaAnaly(){
		getBegaAnalyList();
		getBegaWorkStatusList();
	}

	//설비별 가동율 막대그래프 (낮은 순 정렬 + 구간별 색상)
	function renderRunRateChart(data){
		if(!data){ data = []; }

		var sorted = data.slice().sort(function(a, b){
			return (parseFloat(b.RunRate) || 0) - (parseFloat(a.RunRate) || 0);
		});

		var categories = sorted.map(function(d){ return d.fac_name; });
		var values = sorted.map(function(d){ return parseFloat(d.RunRate) || 0; });

		Highcharts.chart("runRateChart", {
			chart:{ type:"bar" },
			title:{ text:"설비별 가동율(%)", style:{ fontSize:"14px" } },
			xAxis:{ categories:categories, labels:{ style:{ fontSize:"11px" } } },
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
		        return response.data ? response.data : response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"설비", field:"fac_name", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"가동시간(분)", field:"fstp_tu", sorter:"int", width:120,
				    hozAlign:"center"},     
				{title:"비가동시간(분)", field:"fstp_10", sorter:"int", width:120,
				    hozAlign:"center"}, 
				{title:"가동율(%)", field:"RunRate", sorter:"int", width:150,
				    hozAlign:"center"},  
					    
				    
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
		});
	}

	//시:분 형식으로 표시 (yyyy-MM-dd HH:mm:ss -> HH:mm)
	function formatDateTimeShort(value){
		if(!value){ return ""; }
		var s = String(value).trim();
		if(s.indexOf("1900-01-01") === 0){ return "-"; }
		var parts = s.split(" ");
		if(parts.length < 2){ return s; }
		return parts[0] + " " + parts[1].substring(0,5);
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

	function getBegaWorkStatusList(){
		workStatusTable = new Tabulator("#tab2", {
		    height:"100%",
		    layout:"fitColumns",
		    selectable:true,
		    tooltips:true,
		    headerSort:false,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/preservation/begaAnaly/getBegaWorkStatusList",
		    ajaxParams:{"sdate" : $("#sdate").val(),
				"edate" : $("#edate").val()},
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
		    paginationSize:20,
		    paginationSizeSelector:[20,50,100,500,1000],
		    paginationCounter:"rows",
		    ajaxResponse:function(url, params, response){
				$("#tab2 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response.data ? response.data : response;
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:70,
		        	hozAlign:"center"},
		        {title:"설비", field:"fac_name", sorter:"string", width:110,
			        hozAlign:"center"},
			    {title:"작업수", field:"work_cnt", sorter:"int", width:90,
				    hozAlign:"center"},
				{title:"작업중량", field:"work_jung", sorter:"int", width:100,
				    hozAlign:"center"},
				{title:"작업시작시간", field:"work_strt", sorter:"string", width:150,
				    hozAlign:"center", formatter:function(cell){
						return formatDateTimeShort(cell.getValue());
					}},
				{title:"종료시간", field:"work_end", sorter:"string", width:150,
				    hozAlign:"center", formatter:function(cell){
						return formatDateTimeShort(cell.getValue());
					}},
				{title:"총작업시간", field:"work_time", sorter:"int", width:130,
				    hozAlign:"center", formatter:function(cell){
						return formatWorkTime(cell.getValue());
					}},
		    ],
		    rowFormatter:function(row){
			    row.getElement().style.fontWeight = "600";
			},
			rowClick:function(e, row){
				$("#tab2 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
					if($(this).hasClass("row_select")){
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#tab2 div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";
					}
				});
			},
		});
	}


    </script>

	</body>
</html>
