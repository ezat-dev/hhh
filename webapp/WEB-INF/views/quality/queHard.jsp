<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>소입경도현황</title>
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
/* 헤더 컬럼 높이 고정 */
.tabulator .tabulator-col {
    height: 55px !important;
}

/* 헤더 필터 input 위치 고정 */
.tabulator .tabulator-col .tabulator-col-content {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
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
        <button class="select-button" onclick="getQueHardList();">
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
	let now_page_code = "f05";
    var cutumTable;	

	//로드
	$(function(){
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		getQueHardList();
	});

	//이벤트
	//함수
	function getQueHardList(){
		
		userTable = new Tabulator("#tab1", {
		    height:"730px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/quality/queHard/getQueHardList",
		    ajaxProgressiveLoad:"scroll",
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
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				console.log("📊 서버 응답:", response);
	            
	            const data = response.data ? response.data : response;
	            console.log("📊 데이터 개수:", data.length);
	            
	            return data;
		    },
		    columns:[
		        {title:"준비코드", field:"juckjaecode", sorter:"string", width:90,
			        hozAlign:"center", headerFilter:"input", headerSort:false},	
			    {title:"작업일", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input", headerSort:false},     
				{title:"시작", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input", headerSort:false}, 
				{title:"종료", field:"ilbo_end", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input", headerSort:false}, 
		        {title:"LOTNO", field:"ilbo_lot", sorter:"string", width:110,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},		        
		        {title:"작업자", field:"user_name", sorter:"string", width:80,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},
		        {title:"품명", field:"prod_name", sorter:"string", width:170,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},
		        {title:"품번", field:"prod_no", sorter:"string", width:110,
			        hozAlign:"center", headerFilter:"input", headerSort:false},	
		        {title:"규격", field:"prod_gyu", sorter:"string", width:90,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},  	
		        {title:"재질", field:"prod_jai", sorter:"string", width:90,
			        hozAlign:"center", headerFilter:"input", headerSort:false},	
			        { 
			        	  title: "표면경도", field: "prod_pg", sorter: "string", width: 90,
			        	  hozAlign: "center", headerFilter: "input", headerSort:false,
			        	  formatter: function(cell) {
			        	    const el = cell.getElement();
			        	    el.style.backgroundColor = "#fff599"; // 연노랑
			        	    el.style.fontWeight = "bold";
			        	    return cell.getValue();
			        	  }
			        	},
			        	{ 
			        		  title: "판정", field: "ilbo_okng", sorter: "string", width: 80,
			        		  hozAlign: "center", headerFilter: "input", headerSort:false,
			        		  formatter: function(cell) {
			        		    const el = cell.getElement();
			        		    const value = cell.getValue();

			        		    el.style.fontWeight = "bold";

			        		    if (value === "합격") {
			        		      el.style.backgroundColor = "#3498db"; // 파란색
			        		      el.style.color = "#fff"; // 흰색 글자
			        		    } else if (value === "불합격") {
			        		      el.style.backgroundColor = "#e74c3c"; // 빨간색
			        		      el.style.color = "#fff"; // 흰색 글자
			        		    } else if (value === "대기") {
			        		      el.style.backgroundColor = "#f1c40f"; // 노란색
			        		      el.style.color = "#000"; // 검정 글자
			        		    } else {
			        		      el.style.backgroundColor = "#ffffff"; // 기본 흰색
			        		      el.style.color = "#000";
			        		    }

			        		    return value;
			        		  }
			        		},

				{title:"x1", field:"ilbo_pg1", sorter:"String", width:70,
					hozAlign:"center", headerFilter:"input", headerSort:false},
			    {title:"x2", field:"ilbo_pg2", sorter:"String", width:70,
					hozAlign:"center", headerFilter:"input", headerSort:false},
 			    {title:"x3", field:"ilbo_pg3", sorter:"String", width:70,
					hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"x4", field:"ilbo_pg4", sorter:"String", width:70,
					hozAlign:"center", headerFilter:"input", headerSort:false},
	 			{title:"x5", field:"ilbo_pg5", sorter:"String", width:70,
				    hozAlign:"center", headerFilter:"input", headerSort:false},	
				    
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowClick:function(e, row){

				$("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#tab1 div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});

				var rowData = row.getData();
				
			},
		});		
	}
	

    </script>

	</body>
</html>
