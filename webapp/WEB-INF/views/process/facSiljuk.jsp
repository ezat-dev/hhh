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



/* 그룹 헤더 스타일 조정 */
.tabulator .tabulator-row.tabulator-group {
    min-height: 30px !important;  /* 그룹 헤더 최소 높이 */
}

.tabulator .tabulator-row.tabulator-group .tabulator-group-toggle {
    margin-right: 8px;
}

/* 스크롤바 스타일 */
.tabulator .tabulator-tableholder {
    overflow-y: auto !important;
    max-height: 750px;
}

/* 스크롤바 커스텀 (선택사항) */
.tabulator .tabulator-tableholder::-webkit-scrollbar {
    width: 10px;
}

.tabulator .tabulator-tableholder::-webkit-scrollbar-track {
    background: #f1f1f1;
}

.tabulator .tabulator-tableholder::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 5px;
}

.tabulator .tabulator-tableholder::-webkit-scrollbar-thumb:hover {
    background: #555;
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
let now_page_code = "c06";
var userTable;	

//로드
$(function(){
    var tdate = todayDate();
    var ydate = yesterDate();
    
    $("#sdate").val(ydate);
    $("#edate").val(tdate);
    getFacSiljukList();
});

function getFacSiljukList() {
    if (userTable) {
        userTable.destroy();
    }
    
    userTable = new Tabulator("#tab1", {
        height: "750px",  
        layout: "fitColumns",
        selectable: true,
        tooltips: true,
        selectableRangeMode: "click",
        reactiveData: true,
        headerHozAlign: "center",

        ajaxURL: "/tkheat/process/facSiljuk/getFacSiljukList",
        ajaxConfig: "POST",
        ajaxParams: {
            sdate: $("#sdate").val(),
            edate: $("#edate").val()
        },
        ajaxLoader: false,
        placeholder: "조회된 데이터가 없습니다.",

        ajaxResponse: function(url, params, response){
            console.log("========== 서버 응답 전체 ==========");
            console.log(response);
            
            if (response.data && response.data.length > 0) {
                console.log("========== 첫 번째 데이터 ==========");
                console.log(response.data[0]);
                console.log("▶ fac_name:", response.data[0].fac_name);
                console.log("▶ ilbo_lot:", response.data[0].ilbo_lot);
            }
            
            return response.data;
        },

        pagination: false,
        movableColumns: true,

        
        groupBy: ["fac_name", "ilbo_lot"],
        groupStartOpen: [false, false], 
        
        
        groupHeader: [
            function(value, count, data, group){
                console.log("▶ 1단계 그룹 value:", value, "타입:", typeof value);
                
                const displayValue = value || '미지정';
                
                return '<div style="font-weight:bold; font-size:15px; color:#fff; padding:8px 12px; ' +
                       'background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); ' +
                       'border-left: 5px solid #4c51bf; line-height:1.3; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">' +
                       '설비명: ' + displayValue + 
                       ' <span style="color:#e0e7ff; font-size:13px; margin-left:8px;">(' + count + '건)</span>' +
                       '</div>';
            },
            function(value, count, data, group){
                console.log("▶ 2단계 그룹 value:", value, "타입:", typeof value);
                
                const displayValue = value || '미지정';
                
                return '<div style="font-weight:600; font-size:14px; color:#2d3748; padding:6px 12px; ' +
                       'margin-left:30px; background:#e6f7ff; ' +
                       'border-left: 4px solid #1890ff; line-height:1.3; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">' +
                       '생산 LOT: ' + displayValue + 
                       ' <span style="color:#718096; font-size:12px; margin-left:8px;">(' + count + '건)</span>' +
                       '</div>';
            }
        ],

        
        groupToggleElement: "header",  
        
        
        groupClick: function(e, group){
            group.toggle();  
        },

        columns: [
            {title:"생산LOT", field:"ilbo_lot", sorter:"string", width:100, hozAlign:"center"},
            {title:"작업코드", field:"ilbo_code", sorter:"string", width:90, hozAlign:"center"},     
            {title:"설비명", field:"fac_name", sorter:"string", width:110, hozAlign:"center"},
            {title:"거래처", field:"corp_name", sorter:"string", width:120, hozAlign:"center"}, 
            {title:"품명", field:"prod_name", sorter:"string", width:180, hozAlign:"center"},
            {title:"품번", field:"prod_no", sorter:"string", width:120, hozAlign:"center"},
            {
                title:"시작", 
                field:"ilbo_strt", 
                sorter:"string", 
                width:100, 
                hozAlign:"center",
                formatter: function(cell) {
                    const value = cell.getValue();
                    if (!value) return '-';
                    return value.split('.')[0];
                }
            },
            {
                title:"종료", 
                field:"ilbo_end", 
                sorter:"string", 
                width:100, 
                hozAlign:"center",
                formatter: function(cell) {
                    const value = cell.getValue();
                    if (!value) return '';
                    // .000 제거
                    return value.replace(/\.\d{3}$/, '');
                }
            },
                    {title:"소요시간(분)", field:"time", sorter:"string", width:120, hozAlign:"center"},
                    {title:"작업수량", field:"ilbo_su", sorter:"string", width:150, hozAlign:"center"},
                    {
                        title:"중량", 
                        field:"ilbo_jung", 
                        sorter:"string", 
                        width:100, 
                        hozAlign:"center",
                        formatter: function(cell) {
                            const value = cell.getValue();
                            if (!value || isNaN(value)) return value;
                            return Math.round(parseFloat(value)).toLocaleString('ko-KR');
                        }
                    },
                    {title:"단위", field:"ord_danw", sorter:"string", width:70, hozAlign:"center"},
                    {
                        title:"단가", 
                        field:"ord_dang", 
                        sorter:"string", 
                        width:150, 
                        hozAlign:"center",
                        formatter: function(cell) {
                            const value = cell.getValue();
                            if (!value || isNaN(value)) return value;
                            return Math.floor(Number(value)).toLocaleString('ko-KR');
                        }
                    },
                    {
                        title:"금액", 
                        field:"mon", 
                        sorter:"string", 
                        width:100, 
                        hozAlign:"center",
                        formatter: function(cell) {
                            const value = cell.getValue();
                            if (!value || isNaN(value)) return value;
                            return Number(value).toLocaleString('ko-KR');
                        }
                    },
                ],

                rowFormatter: function(row){
                    row.getElement().style.fontWeight = "700";
                    row.getElement().style.backgroundColor = "#FFFFFF";
                },

                rowClick: function(e, row){
                    $("#tab1 .tabulator-row").removeClass("row_select");
                    row.getElement().classList.add("row_select");

                    const rowData = row.getData();
                    console.log("✅ 선택된 행:", rowData);
                }
            });
        }
    </script>

	</body>
</html>
