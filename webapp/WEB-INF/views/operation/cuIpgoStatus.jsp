<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>거래처별 입출고현황</title>
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

        <!-- 🔹 기간 + 버튼 -->
        <div class="box1">
            <label>기간 :</label>
            <input type="date" id="sdate" autocomplete="off"> ~ 
            <input type="date" id="edate" autocomplete="off">
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

        <!-- 🔹 출고현황 -->
        <div class="container">
            <div id="tab2" class="tabulator"></div>
        </div>

    </div>

<script>
    var tab1, tab2;

    $(function(){
        var tdate = todayDate();
        var ydate = yesterDate();
        $("#sdate").val(ydate);
        $("#edate").val(tdate);

        getCuIpgoStatusList();
        getCuChulgoStatusList();
    });

    // 거래처별 입고현황
    function getCuIpgoStatusList(){
        tab1 = new Tabulator("#tab1", {
            height:"300px",
            layout:"fitColumns",
            ajaxConfig:"POST",
            ajaxURL:"/tkheat/operation/cuIpgoStatus/getCuIpgoStatusList",
            ajaxParams:{
                "sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
            },
            placeholder:"조회된 데이터가 없습니다.",
            paginationSize:20,
            ajaxResponse:function(url, params, response){
                $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
                return response.data;
            },
            columns:[
                {title:"NO", field:"idx", sorter:"int", width:130, hozAlign:"center"},
                {title:"입고일", field:"ord_date", sorter:"string", width:340, hozAlign:"center", headerFilter:"input"},
                {title:"거래처명", field:"corp_name", sorter:"string", width:340, hozAlign:"center", headerFilter:"input"},
                {title:"수주금액", field:"ord_mon", sorter:"number", width:340, hozAlign:"center", headerFilter:"input",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}}
            ],
        });
    }

    // 거래처별 출고현황
    function getCuChulgoStatusList(){
        tab2 = new Tabulator("#tab2", {
            height:"300px",
            layout:"fitColumns",
            ajaxConfig:"POST",
            ajaxURL:"/tkheat/operation/cuChulgoStatus/getCuChulgoStatusList",
            ajaxParams:{
                "sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
            },
            placeholder:"조회된 데이터가 없습니다.",
            paginationSize:20,
            ajaxResponse:function(url, params, response){
                $("#tab2 .tabulator-col.tabulator-sortable").css("height","55px");
                return response.data;
            },
            columns:[
                {title:"NO", field:"idx", sorter:"int", width:130, hozAlign:"center"},
                {title:"출고일", field:"och_date", sorter:"string", width:340, hozAlign:"center", headerFilter:"input"},
                {title:"거래처명", field:"corp_name", sorter:"string", width:340, hozAlign:"center", headerFilter:"input"},
                {title:"매출금액", field:"och_mon", sorter:"number", width:340, hozAlign:"center", headerFilter:"input",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}}
            ],
        });
    }

    // 기간 재조회
    function reloadTables(){
        tab1.setData("/tkheat/operation/cuIpgoStatus/getCuIpgoStatusList", {
            sdate: $("#sdate").val(),
            edate: $("#edate").val()
        });
        tab2.setData("/tkheat/operation/cuChulgoStatus/getCuChulgoStatusList", {
            sdate: $("#sdate").val(),
            edate: $("#edate").val()
        });
    }
</script>
</body>
</html>
