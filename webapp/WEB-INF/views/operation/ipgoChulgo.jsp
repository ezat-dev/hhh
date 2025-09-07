<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>거래처별출고현황</title>
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
        <button class="select-button" onclick="getChulgoAddList();">
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
        <button class="printer-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
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
    var cutumTable;	

	//로드
	$(function(){
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		getChulgoAddList();
	});

	//이벤트
	//함수
	function getChulgoAddList() {

			chulgoAddTable = new Tabulator(
					"#tab1",
					{
						height : "550px",
						layout : "fitColumns",
						selectable : true, //로우 선택설정
						tooltips : true,
						selectableRangeMode : "click",
						reactiveData : true,
						headerHozAlign : "center",
						ajaxConfig : "POST",
						ajaxLoader : false,
						ajaxURL : "/tkheat/product/chulgo/getChulgoAddList",
						ajaxProgressiveLoad : "scroll",
						ajaxParams : {
							"sdate" : $("#sdate").val(),
							"edate" : $("#edate").val(),
						},
						placeholder : "조회된 데이터가 없습니다.",
						paginationSize : 20,
						ajaxResponse : function(url, params, response) {
							$("#tabuData .tabulator-col.tabulator-sortable")
									.css("height", "55px");
							return response; //return the response data to tabulator
						},
						columns:[
					        {title:"제품단중", field:"prod_danj", sorter:"string", width:100,
						        hozAlign:"center", headerFilter:"input"},	
						    {title:"제품코드", field:"prod_code", sorter:"string", width:100,
							    hozAlign:"center", headerFilter:"input", visible:false},     
							{title:"수주NO", field:"ord_code", sorter:"string", width:120,
							    hozAlign:"center", headerFilter:"input", visible:false}, 
							{title:"거래처", field:"corp_name", sorter:"string", width:150,
							    hozAlign:"center", headerFilter:"input"}, 
					        {title:"품명", field:"prod_name", sorter:"string", width:100,
					        	hozAlign:"center", headerFilter:"input"},
					        {title:"품번", field:"prod_no", sorter:"string", width:100,
					        	hozAlign:"center", headerFilter:"input"},
					        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
						        hozAlign:"center", headerFilter:"input"},	
					        {title:"재질", field:"prod_jai", sorter:"string", width:100,
					        	hozAlign:"center", headerFilter:"input"},  	
					        {title:"공정", field:"tech_te", sorter:"string", width:80,
						        hozAlign:"center", headerFilter:"input"},	
						    {title:"표면경도", field:"prod_pg", sorter:"string", width:100,
							    hozAlign:"center", headerFilter:"input"},	
							{title:"심부경도", field:"prod_sg", sorter:"string", width:100,
							    hozAlign:"center", headerFilter:"input"},
							{title:"경화깊이", field:"prod_cd", sorter:"string", width:100,
								hozAlign:"center", headerFilter:"input"},
							{title:"단위", field:"prod_danw", sorter:"string", width:80,
								hozAlign:"center", headerFilter:"input"},	
							{title:"박스수량", field:"prod_boxsu", sorter:"string", width:100,
								hozAlign:"center", headerFilter:"input"},	
							{title:"수량", field:"ord_su", sorter:"string", width:100,
								hozAlign:"center", headerFilter:"input"},
							{title:"ROWS*", field:"ord_row", sorter:"int", width:100,
								hozAlign:"center", headerFilter:"input"},
							{title:"단가", field:"prod_dang", sorter:"int", width:100,
								hozAlign:"center", headerFilter:"input"},],
						rowFormatter : function(row) {
							var data = row.getData();

							row.getElement().style.fontWeight = "700";
							row.getElement().style.backgroundColor = "#FFFFFF";
						},
						rowClick : function(e, row) {

							$(
									"#tabuData .tabulator-tableHolder > .tabulator-table > .tabulator-row")
									.each(
											function(index, item) {

												if ($(this).hasClass(
														"row_select")) {
													$(this).removeClass(
															'row_select');
													row.getElement().className += " row_select";
												} else {
													$(
															"#tabuData div.row_select")
															.removeClass(
																	"row_select");
													row.getElement().className += " row_select";
												}
											});

							var rowData = row.getData();

						},
					});
		}

	

    </script>

	</body>
</html>
