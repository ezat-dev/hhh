<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>알람내역</title>
<link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
<link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
<style>
.main { width:98%; }
.tab {
	background:#ffffff;
	border:1px solid #E2E8F0;
	border-radius:10px;
	box-shadow:0 1px 4px rgba(0,0,0,.06);
	padding:10px 14px;
	margin-bottom:10px;
}
.container {
	display:flex;
	justify-content:space-between;
	background:#ffffff;
	border:1px solid #E2E8F0;
	border-radius:10px;
	box-shadow:0 1px 4px rgba(0,0,0,.06);
	padding:10px;
}
.tabulator { width:100%; max-width:100%; max-height:900px; overflow-x:hidden !important; }
.row_select { background-color:#9ABCEA !important; }
.box1 { display:flex; justify-content:right; align-items:center; width:1500px; margin-left:-1050px; }
.box1 label { font-size:12px; font-weight:600; color:#495057; margin-right:10px; }
.box1 input[type="date"] {
	height:30px;
	padding:0 8px;
	font-size:12px;
	border:1px solid #ccc;
	border-radius:6px;
	background-color:#f9f9f9;
	color:#333;
	outline:none;
	box-sizing:border-box;
	transition:border-color .2s ease, background-color .2s ease;
	margin-right:10px;
}
.box1 input[type="date"]:focus { border-color:#3182CE; background-color:#fff; }

.button-container .select-button,
.button-container .insert-button,
.button-container .excel-button,
.button-container .printer-button {
	height:34px;
	border:1px solid #E2E8F0;
	border-radius:8px;
	background:#F0F4F8;
	transition:background-color .13s, border-color .13s;
}
.button-container .select-button:hover,
.button-container .insert-button:hover,
.button-container .excel-button:hover,
.button-container .printer-button:hover {
	background:#EBF8FF;
	border-color:#BEE3F8;
}

/* ========== 알람내역 리스트 ========== */
#alarmHistoryList.tabulator {
	border:1px solid #E2E8F0;
	border-radius:8px;
	font-size:12px;
}
#alarmHistoryList .tabulator-header {
	background: linear-gradient(135deg, #2B6CB0, #3182CE);
	border-bottom:none;
}
#alarmHistoryList .tabulator-col {
	background:transparent;
	border-right:1px solid rgba(255,255,255,.15);
}
#alarmHistoryList .tabulator-col.tabulator-sortable:hover {
	background:rgba(255,255,255,.08);
}
#alarmHistoryList .tabulator-col-title {
	color:#ffffff;
	font-weight:700;
}
#alarmHistoryList .tabulator-col .tabulator-header-filter input {
	border:none;
	border-radius:5px;
	padding:4px 6px;
	font-size:11px;
	background:rgba(255,255,255,.92);
	box-sizing:border-box;
}
#alarmHistoryList .tabulator-row {
	border-bottom:1px solid #EDF2F7;
	transition:background-color .12s;
}
#alarmHistoryList .tabulator-row.tabulator-row-even {
	background-color:#F7FAFC;
}
#alarmHistoryList .tabulator-row:hover {
	background-color:#EBF8FF !important;
	box-shadow: inset 0 0 0 1px #3182CE;
}
#alarmHistoryList .tabulator-row.row_select {
	background-color:#BEE3F8 !important;
	box-shadow: inset 0 0 0 2px #2B6CB0;
}
#alarmHistoryList .tabulator-cell {
	white-space:normal !important;
	word-break:break-word;
	text-align:center;
	border:1px solid #E2E8F0;
	color:#2D3748;
}
#alarmHistoryList .tabulator-footer {
	background:#F7FAFC;
	border-top:1px solid #E2E8F0;
	padding:8px 12px;
}
#alarmHistoryList .tabulator-page {
	border:1px solid #E2E8F0;
	border-radius:6px;
	background:#ffffff;
	color:#2D3748;
	min-width:30px;
	height:28px;
	padding:0 8px;
	font-size:12px;
	font-weight:600;
}
#alarmHistoryList .tabulator-page.active {
	background:#3182CE;
	border-color:#2B6CB0;
	color:#ffffff;
}
#alarmHistoryList .tabulator-page:not(:disabled):hover {
	background:#EBF8FF;
	border-color:#BEE3F8;
	color:#2B6CB0;
	cursor:pointer;
}
</style>
</head>
<body>
<div class="tab">
    <div class="box1">
        <label>기간 : </label>
        <input type="date" id="startDate" autocomplete="off"> ~ 
        <input type="date" id="endDate" autocomplete="off">
    </div>
    <div class="button-container">
        <button class="select-button">조회</button>
        <button class="insert-button">입력</button>
        <button class="excel-button">엑셀</button>
        <button class="printer-button">보고서출력</button>
    </div>
</div>

<main class="main">
    <div class="container">
        <div id="alarmHistoryList" class="tabulator"></div>
    </div>
</main>

<script>
let now_page_code = "d04";
var alarmHistory;

$(function() {
    var now = new Date();
    var year = now.getFullYear();
    var month = checkDate(now.getMonth()+1);
    var date = checkDate(now.getDate());
    $("#endDate").val(year+"-"+month+"-"+date);

    var before = new Date();
    before.setDate(before.getDate()-1);
    $("#startDate").val(before.getFullYear()+"-"+checkDate(before.getMonth()+1)+"-"+checkDate(before.getDate()));

    $(".select-button").click(function(){
        loadAlarmHistory();
    });

    loadAlarmHistory();
});

function checkDate(i) { return i <= 9 ? "0"+i : i; }

function loadAlarmHistory(){
    var sdateTime = $("#startDate").val()+" 00:00:00";
    var edateTime = $("#endDate").val()+" 23:59:59";

    if(alarmHistory){
        alarmHistory.setData("/tkheat/monitoring/alarmHistory1", { sdateTime: sdateTime, edateTime: edateTime });
        return;
    }

    alarmHistory = new Tabulator("#alarmHistoryList", {
        height:"550px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        ajaxConfig:"POST",
        ajaxURL:"/tkheat/monitoring/alarmHistory1",
        ajaxParams:{ sdateTime: sdateTime, edateTime: edateTime },
        ajaxResponse:function(url, params, response){
            return response.data;
        },
        placeholder:"조회된 데이터가 없습니다.",
        paginationSize:20,
        columns:[
            {title:"발생시간", field:"regtime", sorter:"string", width:170, hozAlign:"center"},
            {title:"알람내용", field:"a_comment", sorter:"string", width:260, hozAlign:"center", headerFilter:"input"},
            {title:"지역", field:"a_hogi", sorter:"string", width:160, hozAlign:"center", headerFilter:"input"},
            {title:"상태", field:"displayValue", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"해제시간", field:"releaseTime", sorter:"string", width:200, hozAlign:"center"}
        ]
    });
}

// ========== 엑셀 다운로드 ==========
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "알람내역_" + today + ".xlsx";
    alarmHistory.download("xlsx", filename, { sheetName: "알람내역" });
});
</script>
</body>
</html>
