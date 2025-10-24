<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>년간매출현황</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
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
        <button class="select-button" onclick="getYearSaleList(); yearChart();">
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
		
		<input type="text" id="corp_name" class="corp_name" style="font-size: 16px; display: none;">
		<div id="yearChart" style="width: 100%; height: 400px; margin-top: 20px;"></div>
		
	</main>
	    
	    
<script>
	//전역변수
    var cutumTable;	
    var sdate = $("#sdate").val();
	//로드
	$(function(){
		//전체 거래처목록 조회
		getYearSaleList();
	});

	//이벤트
	//함수
	function getYearSaleList() {

    userTable = new Tabulator("#tab1", {
        height: "350px",
        layout: "fitColumns",
        selectable: true,
        tooltips: true,
        selectableRangeMode: "click",
        reactiveData: true,
        headerHozAlign: "center",
        ajaxConfig: "POST",
        ajaxLoader: false,
        ajaxURL: "/tkheat/operation/yearSale/getYearSaleList",
        ajaxProgressiveLoad: "scroll",
        ajaxParams: { "sdate": $("#sdate").val() },
        placeholder: "조회된 데이터가 없습니다.",
        paginationSize: 20,
        ajaxResponse: function (url, params, response) {
            $("#tab1 .tabulator-col.tabulator-sortable").css("height", "29px");

            let dataList = [];

           
            if (Array.isArray(response)) {
                dataList = response;
            } else if (Array.isArray(response.data)) {
                dataList = response.data;
            } else if (Array.isArray(response.list)) {
                dataList = response.list;
            } else {
                return response;
            }

            const monthlyTotals = {
                mm1: 0, mm2: 0, mm3: 0, mm4: 0,
                mm5: 0, mm6: 0, mm7: 0, mm8: 0,
                mm9: 0, mm10: 0, mm11: 0, mm12: 0
            };

            dataList.forEach(item => {
                for (let key in monthlyTotals) {
                    monthlyTotals[key] += item[key] || 0;
                }
            });

            drawTotalChart(monthlyTotals);

            return response; 
        },

        columns: [
            { title: "NO", field: "idx", sorter: "int", width: 60, hozAlign: "center" },
            { title: "업체명", field: "corp_name", sorter: "string", width: 120, hozAlign: "center" },

            // 1월 ~ 12월
            { title: "1월", field: "mm1", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "2월", field: "mm2", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "3월", field: "mm3", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "4월", field: "mm4", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "5월", field: "mm5", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "6월", field: "mm6", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "7월", field: "mm7", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "8월", field: "mm8", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "9월", field: "mm9", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "10월", field: "mm10", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "11월", field: "mm11", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
            { title: "12월", field: "mm12", sorter: "int", width: 100, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },

       
            { title: "합계", field: "mm_total", sorter: "int", width: 180, hozAlign: "center", 
              formatter: "money", formatterParams: { decimal: ".", thousand: ",", precision: 0 }, 
              bottomCalc: "sum", bottomCalcFormatter: "money", bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 } },
        ],
        rowFormatter: function (row) {
            var data = row.getData();
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

            const rowData = row.getData();
            const corp_name = rowData.corp_name;

            
            if (corp_name) {
                yearChart(corp_name);
            }
        },
    });
}





	function yearChart(corp_name) {

		console.log(corp_name);
		
	    $.ajax({
	        type: "POST",
	        url: "/tkheat/operation/yearSale/getYearData",
	        data: {
	            sdate: $("#sdate").val(),
	            corp_name: corp_name 
	        },
	        success: function (result) {
	            if (!result || result.length === 0) {
	                Highcharts.chart('yearChart', {
	                    title: { text: '데이터가 없습니다.' }
	                });
	                return;
	            }

	            const categories = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];

	            const seriesData = result.map(item => {
	                return {
	                    name: item.corp_name,
	                    data: [
	                        item.mm1 || 0, item.mm2 || 0, item.mm3 || 0, item.mm4 || 0,
	                        item.mm5 || 0, item.mm6 || 0, item.mm7 || 0, item.mm8 || 0,
	                        item.mm9 || 0, item.mm10 || 0, item.mm11 || 0, item.mm12 || 0
	                    ]
	                };
	            });

	            Highcharts.chart('yearChart', {
	                chart: { type: 'column' },
	                title: { text: corp_name + ' 월별 매출 차트' },
	                xAxis: {
	                    categories: categories,
	                    title: { text: '월' }
	                },
	                yAxis: {
	                    title: { text: '매출 (원)' }
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


	function drawTotalChart(monthlyTotals) {
	    const categories = ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'];
	    const data = [
	        monthlyTotals.mm1, monthlyTotals.mm2, monthlyTotals.mm3,
	        monthlyTotals.mm4, monthlyTotals.mm5, monthlyTotals.mm6,
	        monthlyTotals.mm7, monthlyTotals.mm8, monthlyTotals.mm9,
	        monthlyTotals.mm10, monthlyTotals.mm11, monthlyTotals.mm12
	    ];

	    Highcharts.chart('yearChart', {
	        chart: { type: 'column' },
	        title: { text: '전체 거래처 월별 매출 합계' },
	        xAxis: {
	            categories: categories,
	            title: { text: '월' }
	        },
	        yAxis: {
	            title: { text: '매출 (원)' }
	        },
	        tooltip: {
	            shared: true,
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>'
	        },
	        series: [{
	            name: '전체 합계',
	            data: data
	        }]
	    });
	}
		



	//엑셀 다운로드
	$(".excel-button").click(function () {
	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "연간매출현황_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "연간매출현황" });
	});

    </script>

	</body>
</html>
