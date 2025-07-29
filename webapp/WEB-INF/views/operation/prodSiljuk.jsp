<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품별작업실적</title>
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
        <button class="select-button" onclick="getProdSiljukList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
            
        </button>
        <button class="printer-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
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
		getProdSiljukList();
	});

	//이벤트
	//함수
	function getProdSiljukList() {

    userTable = new Tabulator("#tab1", {
        height: "750px",
        layout: "fitColumns",
        selectable: true,
        tooltips: true,
        selectableRangeMode: "click",
        reactiveData: true,
        headerHozAlign: "center",
        ajaxConfig: "POST",
        ajaxLoader: false,
        ajaxURL: "/tkheat/operation/prodSiljuk/getProdSiljukList",
        ajaxProgressiveLoad: "scroll",
        ajaxParams: {
            "sdate": $("#sdate").val(),
            "edate": $("#edate").val(),
        },
        placeholder: "조회된 데이터가 없습니다.",
        paginationSize: 20,
        ajaxResponse: function (url, params, response) {
            $("#tab1 .tabulator-col.tabulator-sortable").css("height", "55px");
            return response;
        },
        columns: [
            { title: "NO", field: "idx", sorter: "int", width: 80, hozAlign: "center" },
            { title: "거래처명", field: "corp_name", sorter: "string", width: 170, hozAlign: "center", headerFilter: "input" },
            { title: "품명", field: "prod_name", sorter: "string", width: 270, hozAlign: "center", headerFilter: "input" },
            { title: "품번", field: "prod_no", sorter: "string", width: 240, hozAlign: "center", headerFilter: "input" },
            {
                title: "수량",
                field: "ilbo_su",
                sorter: "number",
                width: 200,
                hozAlign: "center",
                headerFilter: "input",
                bottomCalc: "sum",
                formatter: "money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalcFormatter: "money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {
                title: "중량",
                field: "ilbo_jung",
                sorter: "number",
                width: 200,
                hozAlign: "center",
                headerFilter: "input",
                bottomCalc: "sum",
                formatter: "money",
                formatterParams: { decimal: ".", thousand: ",", precision: 2 },
                bottomCalcFormatter: "money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 2 }
            },
            {
                title: "단가",
                field: "ord_dang",
                sorter: "number",
                width: 200,
                hozAlign: "center",
                headerFilter: "input",
                formatter: "money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {
                title: "금액",
                field: "ilbo_mon",
                sorter: "number",
                width: 200,
                hozAlign: "center",
                headerFilter: "input",
                bottomCalc: "sum",
                formatter: "money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalcFormatter: "money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
        ],
        rowFormatter: function (row) {
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },
        rowClick: function (e, row) {
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function (index, item) {
                if ($(this).hasClass("row_select")) {
                    $(this).removeClass('row_select');
                    row.getElement().className += " row_select";
                } else {
                    $("#tab1 div.row_select").removeClass("row_select");
                    row.getElement().className += " row_select";
                }
            });

            var rowData = row.getData();
        },
    });
}

	 //엑셀 다운로드
	$(".excel-button").click(function () {
	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "제품별작업실적_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "제품별작업실적" });
	});

    </script>

	</body>
</html>
