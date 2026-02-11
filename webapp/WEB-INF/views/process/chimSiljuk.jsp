<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>침탄작업실적</title>
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
        <button class="select-button" onclick="getChimSiljukList();">
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
//========== 전역변수 ==========
let now_page_code = "c02";  // ✅ 페이지 코드 (조회 전용)
var chimSiljukTable;

//========== 페이지 로드 ==========
$(function(){
    // ✅ 권한 체크 실행 (조회 전용이므로 now_page_code만 선언)
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    
    var tdate = todayDate();
    var ydate = yesterDate();
    
    $("#sdate").val(ydate);
    $("#edate").val(tdate);
    
    getChimSiljukList();
});

//========== 침탄작업실적 조회 ==========
function getChimSiljukList(){
    console.log("🔄 getChimSiljukList 시작");
    
    // 기존 테이블 완전히 제거
    if (chimSiljukTable) {
        chimSiljukTable.destroy();
        chimSiljukTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    chimSiljukTable = new Tabulator("#tab1", {
        height:"750px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        headerSort:false,
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/process/chimSiljuk/getChimSiljukList",
        ajaxParams:{
            "sdate": $("#sdate").val(),
            "edate": $("#edate").val(),
        },
        placeholder:"조회된 데이터가 없습니다.",
        pagination:"local",
        paginationSize:20,
        paginationSizeSelector:[20,50,100,500,1000],
        paginationCounter:"rows",
        headerFilterPlaceholder: "",
        
        // ✅ 핵심 수정: ajaxResponse에서 데이터 배열 추출
        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
            console.log("📊 서버 응답:", response);
            console.log("📊 응답 타입:", typeof response);
            console.log("📊 response.data 존재:", !!response.data);
            
            // ✅ 데이터 추출 로직 개선
            let data;
            
            if (Array.isArray(response)) {
                // 응답이 이미 배열인 경우
                data = response;
            } else if (response.data && Array.isArray(response.data)) {
                // response.data가 배열인 경우
                data = response.data;
            } else if (typeof response === 'object') {
                // 응답이 객체인데 data 속성이 없는 경우
                console.warn("⚠️ 응답이 객체이지만 data 속성이 없습니다. 빈 배열 반환");
                data = [];
            } else {
                // 그 외의 경우
                console.error("❌ 예상치 못한 응답 형식:", response);
                data = [];
            }
            
            console.log("📊 추출된 데이터:", data);
            console.log("📊 데이터 개수:", data.length);
            
            return data;
        },
        
        columns:[
            {title:"NO", field:"idx", sorter:"number", width:40, hozAlign:"center"},
            {title:"작업일", field:"ilbo_strt", sorter:"string", width:60, hozAlign:"center", headerFilter:"input"},	
            {title:"준비코드", field:"ilbo_code", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},     
            {title:"수주NO", field:"ord_code", sorter:"number", width:80, hozAlign:"center", headerFilter:"input"}, 
            {title:"설비", field:"fac_name", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"}, 
            {title:"생산LOT", field:"ilbo_lot", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},		        
            {title:"시작", field:"ilbo_strt", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},
            {title:"완료", field:"ilbo_end", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},
            {title:"입고LOT", field:"ord_lot", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},	
            {title:"거래처", field:"corp_name", sorter:"string", width:130, hozAlign:"center", headerFilter:"input"},  	
            {title:"품명", field:"prod_name", sorter:"string", width:130, hozAlign:"center", headerFilter:"input"},	
            {title:"품번", field:"prod_no", sorter:"string", width:130, hozAlign:"center", headerFilter:"input"},	
            {title:"규격", field:"prod_gyu", sorter:"string", width:130, hozAlign:"center", headerFilter:"input"},
            {title:"재질", field:"prod_jai", sorter:"string", width:130, hozAlign:"center", headerFilter:"input"},
            {title:"작업량", field:"ilbo_su", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},
            {title:"작업자", field:"user_name", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},
            {title:"담당자", field:"ord_name", sorter:"string", width:80, hozAlign:"center", headerFilter:"input"},		
        ],
        
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },
        
        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
            
            var rowData = row.getData();
            console.log("선택된 행:", rowData);
        },
    });
    
    console.log("✅ Tabulator 생성 완료");
}

// ✅ 조회 버튼 클릭 시 테이블 리로드
function reloadTable() {
    chimSiljukTable.setData("/tkheat/process/chimSiljuk/getChimSiljukList", {
        sdate: $("#sdate").val(),
        edate: $("#edate").val()
    });
}

// ✅ 엑셀 다운로드
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "침탄작업실적_" + today + ".xlsx";
    chimSiljukTable.download("xlsx", filename, { sheetName: "침탄작업실적" });
});
</script>

	</body>
</html>
