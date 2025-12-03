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
.container { display:flex; justify-content:space-between; }
.tabulator { width:100%; max-width:100%; max-height:900px; overflow-x:hidden !important; }
.tabulator .tabulator-cell { white-space:normal !important; word-break:break-word; text-align:center; }
.row_select { background-color:#9ABCEA !important; }
.box1 { display:flex; justify-content:right; align-items:center; width:1500px; margin-left:-1050px; }
.box1 input[type="date"] { width:150px; padding:5px 10px; font-size:16px; border:1px solid #ccc; border-radius:6px; background:#f9f9f9; color:#333; }
.box1 input[type="date"]:focus { border:1px solid #007bff; background:#fff; }
.box1 label, .box1 input { margin-right:10px; }
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
</script>
</body>
</html>
