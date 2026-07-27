<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비별작업실적</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
<script src="https://unpkg.com/tabulator-tables@5.4.4/dist/js/tabulator.min.js"></script>
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

#tab1 {
    height: 750px;
    overflow-y: auto;
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
#tab1 .tabulator-col .tabulator-header-filter input:focus {
    outline: none;
    background: #ffffff;
    box-shadow: 0 0 0 2px rgba(255,255,255,.6);
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
    display: flex;
    align-items: center;
    justify-content: flex-end;
}
#tab1 .tabulator-paginator {
    display: flex;
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
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
		<label class="daylabel">기간 : </label>
		<input type="date" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off"> ~ 
		<input type="date" class="edate" id="edate" style="font-size: 16px;" autocomplete="off">
		
		<!-- <select id="fac_name" name="fac_name" class="basic" style="width: 100%">
				<option value="">전체</option>

				<option value="고주파 1호기(폐기)">고주파 1호기(폐기)</option>

				<option value="고주파 2호기 (폐기)">고주파 2호기 (폐기)</option>

				<option value="고주파 5호기">고주파 5호기</option>

				<option value="급수시설">급수시설</option>

				<option value="변성로 1호기">변성로 1호기</option>

				<option value="변성로 2호기">변성로 2호기</option>

				<option value="쇼트 1호기">쇼트 1호기</option>

				<option value="쇼트 2호기">쇼트 2호기</option>

				<option value="쇼트 3호기">쇼트 3호기</option>

				<option value="쇼트 4호기">쇼트 4호기</option>

				<option value="전기시설">전기시설</option>

				<option value="진공세정기 2호기">진공세정기 2호기</option>

				<option value="침탄로 1호기">침탄로 1호기</option>

				<option value="침탄로 2호기">침탄로 2호기</option>

				<option value="침탄로 3호기">침탄로 3호기</option>

				<option value="침탄로 4호기">침탄로 4호기</option>

				<option value="침탄로 5호기">침탄로 5호기</option>

				<option value="콤프레샤">콤프레샤</option>

				<option value="템퍼링기 1호기">템퍼링기 1호기</option>

				<option value="템퍼링기 2호기">템퍼링기 2호기</option>

			</select> -->
		<!-- <label class="daylabel">설비명 : </label>
		<input type="text" class="corp_name" id="corp_name" style="font-size: 16px; autocomplete="off">
		
		<label class="daylabel">품명 : </label>
		<input type="text" class="prod_name" id="prod_name" style="font-size: 16px; autocomplete="off">
		
		<label class="daylabel">재질 : </label>
		<input type="text" class="prod_jai" id="prod_jai" style="font-size: 16px; autocomplete="off">
		
		<label class="daylabel">제품구분 : </label>
		<input type="text" class="prod_gubn" id="prod_gubn" style="font-size: 16px; autocomplete="off">
		
		<label class="daylabel">품번 : </label>
		<input type="text" class="prod_no" id="prod_no" style="font-size: 16px; autocomplete="off">
		
		<label class="daylabel">규격 : </label>
		<input type="text" class="prod_gyu" id="prod_gyu" style="font-size: 16px; autocomplete="off">
				
		<label class="daylabel">담당자 : </label>
		<input type="text" class="ord_name" id="ord_name" style="font-size: 16px; autocomplete="off"> -->
			
	</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getFacSiljukList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
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
	    
	    
<script>
	//전역변수
    var cutumTable;	

	//로드
	$(function(){
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		getFacSiljukList();
	});

	//이벤트
	//함수
	function getFacSiljukList() {
    userTable = new Tabulator("#tab1", {
        height: "100%",
        layout: "fitColumns",
        selectable: true,
        tooltips: true,
        selectableRangeMode: "click",
        reactiveData: true,
        headerHozAlign: "center",
        virtualDom: true,

        ajaxURL: "/tkheat/process/facSiljuk/getFacSiljukList",
        ajaxConfig: "POST",
        ajaxParams: {
            sdate: $("#sdate").val(),
            edate: $("#edate").val()
        },
        ajaxLoader: false,
        placeholder: "조회된 데이터가 없습니다.",

        ajaxResponse: function(url, params, response){
        	console.log(response.data);
        	return response.data || [];
        },

        pagination: "local",
        paginationSize: 20,
        paginationSizeSelector: [20, 50, 100, 500, 1000],
        paginationCounter: "rows",
        movableColumns: true,

        // ✅ 설비명 → 생산LOT 그룹핑
        groupBy: ["fac_name", "ilbo_lot"],

        // ✅ 그룹 펼침 상태: 상위는 열고, 하위는 닫힘
        groupStartOpen: [true, false],

        // ✅ 그룹 헤더 표현
	     groupHeader:[
		    function(value, count, data, group){
		        if(group.getField() === "fac_name"){
		            let sum_su = data.reduce((acc, row) => acc + (parseFloat((row.ilbo_su || "0").toString().replace(/,/g, "")) || 0), 0);
		            let sum_wt = data.reduce((acc, row) => acc + (parseFloat((row.ilbo_wt || "0").toString().replace(/,/g, "")) || 0), 0);
		            let sum_amt = data.reduce((acc, row) => acc + (parseFloat((row.ilbo_amt || "0").toString().replace(/,/g, "")) || 0), 0);
		            let sum_time = data.reduce((acc, row) => acc + (parseFloat((row.ilbo_time || "0").toString().replace(/,/g, "")) || 0), 0);
		
		            return "설비명: " + value + 
		                " (총 " + count + "개)" +
		                " 작업수량합: " + sum_su.toLocaleString() +
		                " / 중량합: " + sum_wt.toLocaleString() +
		                " / 금액합: " + sum_amt.toLocaleString() +
		                " / 소요시간합: " + sum_time.toLocaleString();
		        }
		
		        if(group.getField() === "ilbo_lot"){
		            let sum_su = data.reduce((acc, row) => acc + (parseFloat((row.ilbo_su || "0").toString().replace(/,/g, "")) || 0), 0);
		            let sum_wt = data.reduce((acc, row) => acc + (parseFloat((row.ilbo_wt || "0").toString().replace(/,/g, "")) || 0), 0);
		            let sum_amt = data.reduce((acc, row) => acc + (parseFloat((row.ilbo_amt || "0").toString().replace(/,/g, "")) || 0), 0);
		
		            return "생산LOT: " + value +
		                " - 작업수량합: " + sum_su.toLocaleString() +
		                " / 중량합: " + sum_wt.toLocaleString() +
		                " / 금액합: " + sum_amt.toLocaleString();
		        }
		    }
		],
	
	
	        groupToggleElement: "header",
	
	        // ✅ LOT 기준 정렬
	        initialSort: [
	            {column:"fac_name", dir:"asc"},
	            {column:"ilbo_lot", dir:"asc"}
        ],

        columns: [
            {title:"생산LOT", field:"ilbo_lot", sorter:"string", width:100, hozAlign:"center"},	
            {title:"작업코드", field:"ilbo_code", sorter:"string", width:90, hozAlign:"center"},     
            {title:"설비명", field:"fac_name", sorter:"string", width:110, hozAlign:"center"}, 
            {title:"거래처", field:"corp_name", sorter:"string", width:120, hozAlign:"center"}, 
            {title:"품명", field:"prod_name", sorter:"string", width:180, hozAlign:"center"},		        
            {title:"품번", field:"prod_no", sorter:"string", width:120, hozAlign:"center"},
            {title:"시작", field:"ilbo_strt", sorter:"string", width:100, hozAlign:"center"},
            {title:"종료", field:"ilbo_end", sorter:"string", width:100, hozAlign:"center"},	
            {title:"소요시간(분)", field:"time", sorter:"string", width:120, hozAlign:"center"},	
            {title:"작업수량", field:"ilbo_su", sorter:"string", width:150, hozAlign:"center"},	
            {title:"중량", field:"ilbo_jung", sorter:"string", width:100, hozAlign:"center"},
            {title:"단위", field:"ord_danw", sorter:"string", width:70, hozAlign:"center"},
            {title:"단가", field:"ord_dang", sorter:"string", width:150, hozAlign:"center"},
            {title:"금액", field:"mon", sorter:"string", width:100, hozAlign:"center"},
        ],

        rowFormatter: function(row){
            row.getElement().style.fontWeight = "600";
        },

        rowClick: function(e, row){
            $("#tab1 .tabulator-row").removeClass("row_select");
            row.getElement().classList.add("row_select");

            const rowData = row.getData();
            // rowData 처리 가능
        }
    });
}






	

    </script>

	</body>
</html>
