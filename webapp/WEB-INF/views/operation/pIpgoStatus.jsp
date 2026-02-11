<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제품별 입고 현황</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <%@include file="../include/pluginpage.jsp" %> 
    <style>
      .main {
            width: 98%;
            margin: 0 auto;
        }
        .container {
            margin-bottom: 50px;
        }
        .tab-title {
            font-size: 22px;
            font-weight: 700;
            margin: 20px 0;
            color: #333;
        }
        /* 🔹 기간/버튼 영역 */
        .box1 {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin: 15px 0;
        }
        .box1 label,
        .box1 input {
            margin-right: 10px;
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
        .button-container {
    display: flex;
    justify-content: flex-end;  /* 오른쪽 정렬 */
    align-items: center;
    gap: 8px; /* 버튼 사이 간격 */
    margin-right: 20px; /* 오른쪽 여백 (원하는 만큼) */
}
        .button-container button {
            margin-left: 5px;
        }

        /* 🔹 Tabulator 테이블 */
        #tab1, #tab2 {
            width: 100%;
            min-width: 1200px;   /* 최소 크기 확보 */
            max-height: 900px;
        }
        .tabulator .tabulator-cell {
            white-space: normal !important;
            word-break: break-word;
            text-align: center;
        }
        .row_select {
            background-color: #9ABCEA !important;
        }

    </style>
</head>
<body>
    <div class="main">

        <!-- 🔹 기간 선택 공통 영역 -->
        <div class="box1">
            <label>기간 :</label>
            <input type="date" id="sdate"> ~ 
            <input type="date" id="edate">
            <div class="button-container">
                <button class="select-button" onclick="reloadTables()">
                    <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image"> 조회
                </button>
                <button class="insert-button" disabled style="opacity:0.5; cursor:not-allowed; filter:grayscale(100%)">
                    <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image"> 입력
                </button>
                <button class="excel-button">
                    <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image"> 엑셀
                </button>
                <button class="printer-button" disabled style="opacity:0.5; cursor:not-allowed; filter:grayscale(100%)">
                    <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image"> 보고서출력
                </button>
            </div>
        </div>

        <!-- 🔹 입고현황 -->
        <div class="container">
            <div id="tab1" class="tabulator"></div>
        </div>


    </div>

<script>
let now_page_code = "g01";  // ✅ 페이지 코드 (조회 전용)
var tab1;

$(function(){
    var tdate = todayDate();
    var ydate = yesterDate();
    $("#sdate").val(ydate);
    $("#edate").val(tdate);

    getPIpgoStatusList();
});

// 입고현황
function getPIpgoStatusList(){
    // 기존 테이블 제거
    if (tab1) {
        tab1.destroy();
        tab1 = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    tab1 = new Tabulator("#tab1", {
        height:"750px",
        layout:"fitColumns",
        ajaxConfig:"POST",
        ajaxURL:"/tkheat/operation/pIpgoStatus/getPIpgoStatusList",
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
        
        ajaxResponse: function (url, params, response) {
            $("#tab1 .tabulator-col.tabulator-sortable").css("height", "55px");
            console.log("📊 서버 응답:", response);
            
            const data = response.data ? response.data : response;
            console.log("📊 데이터 개수:", data.length);
            
            return data;
        },
        
        columns:[
            {title:"NO", field:"idx", width:80, hozAlign:"center"},
            {title:"입고일", field:"ord_date", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"거래처명", field:"corp_name", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"품명", field:"prod_name", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"품번", field:"prod_no", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"수량", field:"ord_su", hozAlign:"center", 
                formatter:"money", formatterParams:{thousand:",", precision:0},
                bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{thousand:",", precision:0}},
            {title:"단가", field:"prod_dang", hozAlign:"center", 
                formatter:"money", formatterParams:{thousand:",", precision:0}},
            {title:"금액", field:"ord_mon", hozAlign:"center", 
                formatter:"money", formatterParams:{thousand:",", precision:0},
                bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{thousand:",", precision:0}},
        ],
        
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },
        
        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
        },
    });
}

// 기간 변경 후 테이블 다시 조회
function reloadTables(){
    tab1.setData("/tkheat/operation/pIpgoStatus/getPIpgoStatusList", {
        sdate: $("#sdate").val(),
        edate: $("#edate").val()
    });
}

// 엑셀 다운로드
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "제품별입고현황_" + today + ".xlsx";
    tab1.download("xlsx", filename, { sheetName: "제품별입고현황" });
});
</script>
</body>
</html>
