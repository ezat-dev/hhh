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
var alarmHistory;

//로드
$(function(){
    var now = new Date();
	var year = now.getFullYear();
	var month = checkDate(now.getMonth()+1);
	var date = checkDate(now.getDate());

	$("#endDate").val(year+"-"+month+"-"+date);
	
	
	var before = new Date();
	before.setFullYear(before.getFullYear(), before.getMonth(), before.getDate()-1);

	var b_year = before.getFullYear();
	var b_month = checkDate(before.getMonth()+1);
	var b_date = checkDate(before.getDate());
	
	$("#startDate").val(b_year+"-"+b_month+"-"+b_date);

	alarmRanking1();
});
//이벤트

//함수
	function checkDate(i) {
		var result;
	 	if(i<=9){
	 		result = "0"+i;
		}else{
			result = i;
		}
	   	return result;
	}

function alarmRanking1(){
	
	var sdate = $("#startDate").val();
	var edate = $("#endDate").val();
	
	var sdateTime = sdate+" 00:00:00";
	var edateTime = edate+" 23:59:59";
	
	alarmHistory = new Tabulator("#alarmHistoryList", {
		    height:"550px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/monitoring/alarmRanking1",
		    ajaxProgressiveLoad:"scroll",			    			    
		    ajaxParams:{
		    	"sdateTime":sdateTime,
		    	"edateTime":edateTime
		    },
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
		        //url - the URL of the request
		        //params - the parameters passed with the request
		        //response - the JSON object returned in the body of the response.
				$("#alarmHistoryList .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
//			    {title:"고유번호", field:"idx"},
		        {title:"태그명", field:"tagname", sorter:"string", width:160,
		        	hozAlign:"center"},
		        {title:"알람명", field:"alarmdesc", sorter:"string", width:500,
		        	hozAlign:"center"},
		        	 {title:"알람명", field:"alarmdesc", sorter:"string", width:500,
			        	hozAlign:"center"},
			        {title:"알람발생 수", field:"alarmcount", sorter:"string", width:200,
			        	hozAlign:"center"}
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    row.getElement().style.fontWeight = "700";
			    if(data.success_chk == "N" || data.success_chk == "" || data.success_chk == null){
				 	row.getElement().style.backgroundColor = "#F6F6F6";
				}else{
					row.getElement().style.backgroundColor = "#E4F7BA";
				}
			},
			rowClick:function(e, row){

				$("#alarmHistoryList .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
					
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#alarmHistoryList div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	


					}
				});
			}
		});
	}

//다이얼로그

</script>

	</body>
</html>
