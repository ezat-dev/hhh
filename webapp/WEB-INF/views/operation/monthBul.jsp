<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>월별불량현황</title>
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
.container2 {
	display: flex;
	justify-content: space-between;
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

/* ========== 차트/리스트 카드 (기존 배치/높이는 그대로, 색상만 재도장) ========== */
#monthBulChart {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 10px;
    box-sizing: border-box;
}
.container,
.container2 {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 8px;
    overflow: hidden;
    margin-bottom: 12px;
}
#tab1.tabulator,
#sub.tabulator {
    border: none;
    font-size: 12px;
}
#tab1 .tabulator-header,
#sub .tabulator-header {
    background: linear-gradient(135deg, #2B6CB0, #3182CE);
    border-bottom: none;
}
#tab1 .tabulator-col,
#sub .tabulator-col {
    background: transparent;
    border-right: 1px solid rgba(255,255,255,.15);
}
#tab1 .tabulator-col.tabulator-sortable:hover,
#sub .tabulator-col.tabulator-sortable:hover {
    background: rgba(255,255,255,.08);
}
#tab1 .tabulator-col-title,
#sub .tabulator-col-title {
    color: #ffffff;
    font-weight: 700;
}
#tab1 .tabulator-col .tabulator-header-filter input,
#sub .tabulator-col .tabulator-header-filter input {
    border: none;
    border-radius: 5px;
    padding: 4px 6px;
    font-size: 11px;
    background: rgba(255,255,255,.92);
    box-sizing: border-box;
}
#tab1 .tabulator-col .tabulator-header-filter input:focus,
#sub .tabulator-col .tabulator-header-filter input:focus {
    outline: none;
    background: #ffffff;
    box-shadow: 0 0 0 2px rgba(255,255,255,.6);
}
#tab1 .tabulator-row,
#sub .tabulator-row {
    border-bottom: 1px solid #EDF2F7;
    transition: background-color .12s;
}
#tab1 .tabulator-row.tabulator-row-even,
#sub .tabulator-row.tabulator-row-even {
    background-color: #F7FAFC;
}
#tab1 .tabulator-row:hover,
#sub .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#tab1 .tabulator-row.row_select,
#sub .tabulator-row.row_select {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#tab1 .tabulator-cell,
#sub .tabulator-cell {
    border: 1px solid #E2E8F0;
    color: #2D3748;
}
#tab1 .tabulator-footer,
#sub .tabulator-footer {
    background: #F7FAFC;
    border-top: 1px solid #E2E8F0;
    padding: 8px 12px;
}
#tab1 .tabulator-footer .tabulator-calcs-holder,
#sub .tabulator-footer .tabulator-calcs-holder {
    background: #EBF8FF !important;
    border-top: none;
    border-bottom: 1px solid #BEE3F8;
    color: #2B6CB0;
    font-weight: 700;
}
#tab1 .tabulator-page,
#sub .tabulator-page {
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    background: #ffffff;
    color: #2D3748;
    min-width: 30px;
    height: 28px;
    padding: 0 8px;
    font-size: 12px;
    font-weight: 600;
}
#tab1 .tabulator-page.active,
#sub .tabulator-page.active {
    background: #3182CE;
    border-color: #2B6CB0;
    color: #ffffff;
}
#tab1 .tabulator-page:not(:disabled):hover,
#sub .tabulator-page:not(:disabled):hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
    color: #2B6CB0;
    cursor: pointer;
}

.spareModal {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 수직 중앙 */
    left: 50%; /* 수평 중앙 */
    display : none;
    transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
    z-index: 1000; /* 다른 요소 위에 표시 */
}
.header {
    display: flex; /* 플렉스 박스 사용 */
    justify-content: center; /* 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    margin-bottom: 10px; /* 상단 여백 */
    background-color: #33363d; /* 배경색 */
    height: 50px; /* 높이 */
    color: white; /* 글자색 */
    font-size: 20px; /* 글자 크기 */
    text-align: center; /* 텍스트 정렬 */
}
#editPop {
    background: #ffffff;
    border: 1px solid #000000;
    width: 500px; /* 가로 길이 고정 */
    height: 650px; /* 세로 길이 고정 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
    margin: 20px auto; /* 중앙 정렬 */
    padding: 20px;
    border-radius: 5px; /* 모서리 둥글게 */
    overflow-y: auto; /* 세로 스크롤 추가 */
}

.insideTable {
    width: 100%; /* 테이블 너비 100% */
    border-collapse: collapse; /* 테두리 겹침 제거 */
}

.insideTable th,
.insideTable td {
    padding: 8px; /* 셀 패딩 */
    border: 1px solid #ccc; /* 셀 경계선 */
    vertical-align: middle; /* 수직 정렬 */
}

.insideTable th {
    background: #f0f0f0; /* 헤더 배경색 */
}

.basic, .rp-input, .form-control {
    width: calc(100% - 12px); /* 너비 조정 */
    padding: 5px; /* 내부 여백 */
    border: 1px solid #949494; /* 경계선 색상 */
    border-radius: 3px; /* 둥근 모서리 */
}

.basic[readonly] {
    background-color: #f9f9f9; /* 읽기 전용 필드 색상 */
}

textarea {
    width: 100%; /* 너비 100% */
    padding: 5px; /* 내부 여백 */
    border: 1px solid #949494; /* 경계선 색상 */
    border-radius: 3px; /* 둥근 모서리 */
}

.findImage {
    display: flex; /* 플렉스 박스 사용 */
    align-items: center; /* 수직 정렬 */
}

.findImage input[type="file"] {
    margin-right: 10px; /* 오른쪽 여백 */
}

.img-rounded {
    border-radius: 5px; /* 둥근 모서리 */
}

.imgArea {
    width: 100%; /* 이미지 영역 너비 */
    height: 100px; /* 이미지 영역 높이 */
    border: 1px solid #ddd; /* 경계선 */
    margin-bottom: 10px; /* 하단 여백 */
}

.imgArea img {
    width: 100%; /* 이미지 너비 */
    height: 100%; /* 이미지 높이 */
    object-fit: cover; /* 이미지 비율 유지 */
}
.btnSaveClose {
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	gap: 20px; /* 버튼 사이 여백 */
	margin-top: 30px; /* 모달 내용과의 간격 */
	margin-bottom: 20px; /* 모달 하단과 버튼 사이 간격  */
}
.btnSaveClose button {
	width: 100px;
	height: 35px;
	background-color: #FFD700; /* 기본 배경 - 노란색 */
	color: black;
	border: 2px solid #FFC107; /* 노란 테두리 */
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	line-height: 35px;
	margin: 0 10px;
	margin-top: 10px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

/* 저장 버튼 호버 시 */
.btnSaveClose .save:hover {
	background-color: #FFC107;
	transform: scale(1.05);
}

/* 닫기 버튼 - 회색 톤 */
.btnSaveClose .close {
	background-color: #A9A9A9;
	color: black;
	border: 2px solid #808080;
}

/* 닫기 버튼 호버 시 */
.btnSaveClose .close:hover {
	background-color: #808080;
	transform: scale(1.05);
}
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -1270px;
}

.box1 select{
	width: 5%
}  
.box1 select{
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

.box1 select:focus {
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
        
        
		<label class="daylabel">년도 : </label>
		<select id="sdate" class="sdate" style="font-size: 16px;">
		  <option value="2013">2013</option>
		  <option value="2014">2014</option>
		  <option value="2015">2015</option>
		  <option value="2016">2016</option>
		  <option value="2017">2017</option>
		  <option value="2018">2018</option>
		  <option value="2019">2019</option>
		  <option value="2020">2020</option>
		  <option value="2021">2021</option>
		  <option value="2022">2022</option>
		  <option value="2023">2023</option>
		  <option value="2024">2024</option>
		  <option value="2025">2025</option>
		  <option value="2026">2026</option>
		  <option value="2027">2027</option>
		  <option value="2028">2028</option>
		  <option value="2029">2029</option>
		  <option value="2030">2030</option>
		  <option value="2031">2031</option>
		  <option value="2032">2032</option>
		  <option value="2033">2033</option>
		  <option value="2034">2034</option>
		  <option value="2035">2035</option>
		  <option value="2036">2036</option>
		  <option value="2037">2037</option>
		  <option value="2038">2038</option>
		  <option value="2039">2039</option>
		  <option value="2040">2040</option>
		  <option value="2041">2041</option>
		  <option value="2042">2042</option>
		  <option value="2043">2043</option>
		  <option value="2044">2044</option>
		  <option value="2045">2045</option>
		  <option value="2046">2046</option>
		  <option value="2047">2047</option>
		  <option value="2048">2048</option>
		  <option value="2049">2049</option>
		  <option value="2050">2050</option>
		</select>
		
			
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getMonthBulList(); getMonthBulSubList(); loadMonthBulChart();">
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
    <div id="monthBulChart" style="width: 100%; height: 400px; margin-top: 20px;"></div>
    	<h4>불량유형별</h4>
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
		<h4>항목</h4>
		<div class="container2">
			<div id="sub" class="tabulator"></div>
		</div>
	</main>
	
	
	
	





	    
<script>
	//전역변수
	let now_page_code = "g07";
    var cutumTable;	
    var sdate = $("#sdate").val();
    $(function() {
    	 var sdate = $("#sdate").val();
		getMonthBulList();
		getMonthBulSubList();
		/* getMonthBulSubList(); */
	});

	
	
	//이벤트
	//함수
function getMonthBulList(){
	userTable = new Tabulator("#tab1", {
	    height:"180px",
	    layout:"fitColumns",
	    selectable:true,
	    tooltips:true,
	    selectableRangeMode:"click",
	    reactiveData:true,
	    headerHozAlign:"center",
	    ajaxConfig:"POST",
	    ajaxLoader:false,
	    ajaxURL:"/tkheat/operation/monthBul/getMonthBulList",
	    ajaxParams:{"sdate": $("#sdate").val()},
	    placeholder:"조회된 데이터가 없습니다.",
	    pagination:"local",
	    paginationSize:20,
	    paginationSizeSelector:[20,50,100,500,1000],
	    paginationCounter:"rows",
	    ajaxResponse:function(url, params, response){
			$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
	        return response.data ? response.data : response;
	    },
	    columns:[
	        {title:"불량항목", field:"werr_gubn", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", headerSort:false},	
	        {title:"1월", field:"m1", sorter:"int", width:120, hozAlign:"center", bottomCalc:"sum", headerSort:false},     
			{title:"2월", field:"m2", sorter:"int", width:120, hozAlign:"center", bottomCalc:"sum", headerSort:false}, 
			{title:"3월", field:"m3", sorter:"int", width:120, hozAlign:"center", bottomCalc:"sum", headerSort:false},
	        {title:"4월", field:"m4", sorter:"int", width:120, hozAlign:"center", bottomCalc:"sum", headerSort:false},		        
	        {title:"5월", field:"m5", sorter:"int", width:100, hozAlign:"center", bottomCalc:"sum", headerSort:false},
	        {title:"6월", field:"m6", sorter:"int", width:100, hozAlign:"center", bottomCalc:"sum", headerSort:false},
	        {title:"7월", field:"m7", sorter:"int", width:100, hozAlign:"center", bottomCalc:"sum", headerSort:false},	
	        {title:"8월", field:"m8", sorter:"int", width:100, hozAlign:"center", bottomCalc:"sum", headerSort:false},  	
	        {title:"9월", field:"m9", sorter:"int", width:100, hozAlign:"center", bottomCalc:"sum", headerSort:false},	
		    {title:"10월", field:"m10", sorter:"int", width:100, hozAlign:"center", bottomCalc:"sum", headerSort:false},	
			{title:"11월", field:"m11", sorter:"int", width:100, hozAlign:"center", bottomCalc:"sum", headerSort:false},
			{title:"12월", field:"m12", sorter:"int", width:100, hozAlign:"center", bottomCalc:"sum", headerSort:false},
			{
				title:"평균", field:"average_SUM", sorter:"number", width:100, hozAlign:"center", headerSort:false,
				bottomCalc:"sum",
				bottomCalcFormatter:function(cell){
					const value = cell.getValue();
					return value ? Math.round(value) : 0;
				}
			},
	    ],
	    rowFormatter:function(row){
		    row.getElement().style.fontWeight = "600";
		},
		rowClick:function(e, row){
			$("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(){
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









	

function getMonthBulSubList(){
	subTable = new Tabulator("#sub", {
	    height:"165px",
	    layout:"fitColumns",
	    selectable:true,
	    tooltips:true,
	    selectableRangeMode:"click",
	    reactiveData:true,
	    headerHozAlign:"center",
	    ajaxConfig:"POST",
	    ajaxLoader:false,
	    ajaxURL:"/tkheat/operation/monthBul/getMonthBulSubList",
	    ajaxParams:{"sdate": $("#sdate").val()},
	    placeholder:"조회된 데이터가 없습니다.",
	    pagination:"local",
	    paginationSize:20,
	    paginationSizeSelector:[20,50,100,500,1000],
	    paginationCounter:"rows",
	    ajaxResponse:function(url, params, response){
			$("#sub .tabulator-col.tabulator-sortable").css("height","55px");
	        return response.data ? response.data : response;
	    },
	    columns:[
	        {title:"항목", field:"quantityItem", sorter:"string", width:120, hozAlign:"center",headerSort: false, headerFilter:"input"},
	        
	        {title:"1월", field:"m1", sorter:"number", width:100, hozAlign:"right", headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"2월", field:"m2", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"3월", field:"m3", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"4월", field:"m4", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"5월", field:"m5", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"6월", field:"m6", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"7월", field:"m7", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"8월", field:"m8", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"9월", field:"m9", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"10월", field:"m10", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"11월", field:"m11", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"12월", field:"m12", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	        {title:"평균", field:"average_SUM", sorter:"number", width:100, hozAlign:"right",headerSort: false,
				formatter:"money", formatterParams:{decimal: ".", thousand: ",", precision: 0},
				bottomCalc:"sum", bottomCalcFormatter:"money",
				bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
			},
	    ],
	    rowFormatter:function(row){
		    row.getElement().style.fontWeight = "600";
		},
		rowClick:function(e, row){
			$("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(){
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


	function loadMonthBulChart() {
	    $.ajax({
	        type: "POST",
	        url: "/tkheat/operation/monthBul/getMonthBulChartData",
	        data: { sdate: $("#sdate").val() },
	        success: function (result) {
	            if (!result || result.length === 0) {
	                Highcharts.chart('monthBulChart', {
	                    title: { text: '데이터가 없습니다.' }
	                });
	                return;
	            }

	            // 여러 불량항목을 각각의 시리즈로 표시
	            const categories = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
	            const seriesData = result.map(item => {
	                return {
	                    name: item.werr_gubn,
	                    data: [
	                        item.m1 || 0, item.m2 || 0, item.m3 || 0, item.m4 || 0,
	                        item.m5 || 0, item.m6 || 0, item.m7 || 0, item.m8 || 0,
	                        item.m9 || 0, item.m10 || 0, item.m11 || 0, item.m12 || 0
	                    ]
	                };
	            });

	            Highcharts.chart('monthBulChart', {
	                chart: {
	                    type: 'column'
	                },
	                title: {
	                    text: '월별 불량현황'
	                },
	                xAxis: {
	                    categories: categories,
	                    title: { text: '월' }
	                },
	                yAxis: {
	                    title: { text: '불량 건수' }
	                },
	                tooltip: {
	                    shared: true,
	                    pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>'
	                },
	                series: seriesData
	            });
	        },
	        error: function (xhr, status, error) {
	            console.error("차트 데이터를 불러오는 중 오류 발생:", error);
	        }
	    });
	}
		


	 /* Highcharts.chart('monthBulChart', {
	    chart: {
	        type: 'column'
	    },
	    title: {
	        text: '월별불량현황 그래프'
	    },
	    accessibility: {
	        announceNewData: {
	            enabled: true
	        }
	    },
	    xAxis: {
	        type: 'category'
	    },
	    yAxis: {
	        title: {
	            text: 'Total percent market share'
	        }

	    },
	    legend: {
	        enabled: false
	    },
	    plotOptions: {
	        series: {
	            borderWidth: 0,
	            dataLabels: {
	                enabled: true,
	                format: '{point.y:.1f}%'
	            }
	        }
	    },
	    tooltip: {
	        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
	        pointFormat: '<span style="color:{point.color}">{point.name}</span>: ' +
	            '<b>{point.y:.2f}%</b> of total<br/>'
	    },
	    series: [
	        {
	            name: 'Browsers',
	            colorByPoint: true,
	            data: [
	                {
	                    name: '1월',
	                    y: 63.06,
	                    drilldown: 'Chrome'
	                },
	                {
	                    name: '2월',
	                    y: 19.84,
	                    drilldown: 'Safari'
	                },
	                {
	                    name: '3월',
	                    y: 4.18,
	                    drilldown: 'Firefox'
	                },
	                {
	                    name: '4월',
	                    y: 4.12,
	                    drilldown: 'Edge'
	                },
	                {
	                    name: '5월',
	                    y: 2.33,
	                    drilldown: 'Opera'
	                },
	                {
	                    name: '6월',
	                    y: 0.45,
	                    drilldown: 'Internet Explorer'
	                },
	                {
	                    name: '7월',
	                    y: 1.582,
	                    drilldown: null
	                },
	                {
	                    name: '8월',
	                    y: 1.582,
	                    drilldown: null
	                },
	                {
	                    name: '9월',
	                    y: 1.582,
	                    drilldown: null
	                },
	                {
	                    name: '10월',
	                    y: 1.582,
	                    drilldown: null
	                },
	                {
	                    name: '11월',
	                    y: 1.582,
	                    drilldown: null
	                },
	                {
	                    name: '12월',
	                    y: 1.582,
	                    drilldown: null
	                },
	            ]
	        }
	    ],
	    drilldown: {
	        breadcrumbs: {
	            position: {
	                align: 'right'
	            }
	        },
	        series: [
	            
	        ]
	    }
	}); */

	

    </script>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

	</body>
</html>
