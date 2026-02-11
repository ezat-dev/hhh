<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알람내역</title>
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
		<input type="date" class="startDate" id="startDate" style="font-size: 16px;" autocomplete="off"> ~ 
		<input type="date" class="endDate" id="endDate" style="font-size: 16px;" autocomplete="off">		
	</div>
    
    <div class="button-container">
        <button class="select-button" onclick="alarmRanking1();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
            조회
           
        </button>
        <button class="insert-button">
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
			<div id="alarmHistoryList" class="tabulator"></div>
		</div>
	</main>
	    
	    
<script>
//전역변수
		let now_page_code = "d06";
		var alarmHistory;
		
		window.alarmRanking1 = function(){
		    var sdateTime = $("#startDate").val() + " 00:00:00";
		    var edateTime = $("#endDate").val() + " 23:59:59";
		
		    if(alarmHistory){
		        alarmHistory.setData("/tkheat/monitoring/alarmRanking1", {sdateTime:sdateTime, edateTime:edateTime});
		        return;
		    }
		
		    alarmHistory = new Tabulator("#alarmHistoryList", {
		        height:"550px",
		        layout:"fitColumns",
		        selectable:true,
		        tooltips:true,
		        ajaxConfig:"POST",
		        ajaxURL:"/tkheat/monitoring/alarmRanking1",
		        ajaxParams:{sdateTime:sdateTime, edateTime:edateTime},
		        ajaxResponse:function(url, params, response){
		            return response.data;
		        },
		        placeholder:"조회된 데이터가 없습니다.",
		        paginationSize:20,
		        headerFilterPlaceholder: "",
		        columns:[
		            {title:"PLC주소", field:"a_addr", sorter:"string", width:160, hozAlign:"center", headerFilter:"input"},
		            {title:"알람내용", field:"a_comment", sorter:"string", width:500, hozAlign:"center", headerFilter:"input"},
		            {title:"지역", field:"a_hogi", sorter:"string", width:500, hozAlign:"center", headerFilter:"input"},
		            {title:"알람발생 수", field:"alarmcount", sorter:"string", width:200, hozAlign:"center", headerFilter:"input"}
		        ]
		    });
		};
		
		$(function(){
		    var now = new Date();
		    var year = now.getFullYear();
		    var month = checkDate(now.getMonth()+1);
		    var date = checkDate(now.getDate());
		    $("#endDate").val(year+"-"+month+"-"+date);
		
		    var before = new Date();
		    before.setDate(before.getDate()-1);
		    $("#startDate").val(before.getFullYear()+"-"+checkDate(before.getMonth()+1)+"-"+checkDate(before.getDate()));
		
		    alarmRanking1();
		});
		
		function checkDate(i){ return i<=9?"0"+i:i; }


</script>

	</body>
</html>
