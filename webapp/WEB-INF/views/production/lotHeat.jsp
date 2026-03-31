<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>lot추적 관리(열처리LOT)</title>
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
.container2 {
	display: flex;
	justify-content: space-between;
}
.container3 {
	display: flex;
	justify-content: space-between;
}
.container4 {
	display: flex;
	justify-content: space-between;
}
.container5 {
	display: flex;
	justify-content: space-between;
}
.container6 {
	display: flex;
	justify-content: space-between;
}
.container, .container2, .container3, .container5, .container6 {
        border-bottom: 1px solid #ccc; /* 회색 실선 */
        padding-bottom: 20px;
        margin-bottom: 20px;
    }

    h3 {
        margin-top: 40px;
        margin-bottom: 10px;
        font-weight: bold;
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
        <button class="select-button" onclick="getLotHeatList();">
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
    	<h3>작업실적</h3>
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
		<h3>입고</h3>
		<div class="container2">
			<div id="tab2" class="tabulator"></div>
		</div>
		<h3>적재</h3>
		<div class="container3">
			<div id="tab3" class="tabulator"></div>
		</div>
		<h3>침탄</h3>
		<div class="container5">
			<div id="tab5" class="tabulator"></div>
		</div>
		<h3>출고</h3>
		<div class="container6">
			<div id="tab6" class="tabulator"></div>
		</div>
	</main>
	    
	    
<script>
	//전역변수
	let now_page_code = "b05";
    var cutumTable;	

	//로드
	$(function(){
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		//전체 거래처목록 조회
		getLotHeatList();
	});

	//이벤트
	//함수
	function getLotHeatList(){
		userTable = new Tabulator("#tab1", {
		    height:"300px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    headerSort:false,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		     ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/production/lotHeat/getLotHeatList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{"sdate" : $("#sdate").val(),
				"edate" : $("#edate").val(),},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		    	{title:"수주NO", field:"ord_code", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"작업일", field:"ilbo_strt", sorter:"string", width:120,
					hozAlign:"center"},     
		        {title:"적재코드", field:"juckjaecode", sorter:"string", width:120,
			        hozAlign:"center"},    
				{title:"거래처", field:"corp_name", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"품명", field:"prod_name", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"품번", field:"prod_no", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"입고일", field:"ord_date", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"열처리LOT", field:"ilbo_lot", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"수량", field:"ilbo_su", sorter:"int", width:100,
		        	hozAlign:"center"},  	
		        {title:"비고", field:"och_bigo", sorter:"int", width:100,
			        hozAlign:"center"},	
			    {title:"ilbo_pc", field:"ilbo_pc", sorter:"int", width:100,
				    hozAlign:"center", visible:false},        
				    
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

				if(rowData.ord_code){
					getLotHeatIpgoList(rowData.ord_code);
			    }
				if(rowData.ilbo_pc){
					getLotHeatJuckList(rowData.ilbo_pc);
			    }
				if(rowData.ilbo_pc){
					getLotHeatChimList(rowData.ilbo_pc);
			    }
				if(rowData.ord_code){
					getLotIpgoChulList(rowData.ord_code);
			    }
				
			},
		});		
	}


	
	//입고
	function getLotHeatIpgoList(ord_code){
		userTable = new Tabulator("#tab2", {
		    height:"180px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    headerSort:false,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		     ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/production/lotHeat/getLotHeatIpgoList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{ord_code : ord_code},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"수주NO", field:"ord_code", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"입고일", field:"ord_date", sorter:"string", width:120,
				    hozAlign:"center"},     
				{title:"입고/타각LOT", field:"ord_lot", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"단위", field:"ord_danw", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"수량", field:"ord_su", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"단가", field:"ord_dang", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"금액", field:"ord_mon", sorter:"string", width:100,
		        	hozAlign:"center"},
				    
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


	
	// 적재
	function getLotHeatJuckList(ilbo_pc){
		userTable = new Tabulator("#tab3", {
		    height:"180px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    headerSort:false,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		     ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/production/lotHeat/getLotHeatJuckList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{ilbo_pc : ilbo_pc},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"적재코드", field:"juckjaecode", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"입고일", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center"},     
				{title:"시작", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"종료", field:"ilbo_end", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"수량", field:"ilbo_su", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"작업자", field:"user_name", sorter:"string", width:100,
		        	hozAlign:"center"},
				    
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


	function getLotHeatChimList(ilbo_pc){
		userTable = new Tabulator("#tab5", {
		    height:"180px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    headerSort:false,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		     ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/production/lotHeat/getLotHeatChimList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{ilbo_pc : ilbo_pc},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		    	{ title: "적재코드", field: "juckjaecode", width: 120, hozAlign: "center" },
		    	  { title: "작업일", field: "ilbo_strt", width: 120, hozAlign: "center" },
		    	  { title: "수량", field: "ilbo_su", width: 120, hozAlign: "center" },
		    	  { title: "시작", field: "ilbo_strt", width: 150, hozAlign: "center" },
		    	  { title: "종료", field: "ilbo_end", width: 120, hozAlign: "center" },
		    	  { title: "LOT NO", field: "ilbo_lot", width: 100, hozAlign: "center" },
		    	  { title: "작업자", field: "user_name", width: 100, hozAlign: "center" },

		    	  {
		    	    title: "승온",
		    	    columns: [
		    	      { title: "온도", field: "ilbo_g11", width: 80, hozAlign: "center" },
		    	      { title: "시간", field: "ilbo_g12", width: 80, hozAlign: "center" },
		    	      { title: "CP", field: "ilbo_ms", width: 80, hozAlign: "center" },
		    	    ],
		    	  },
		    	  {
		    	    title: "균열(No1)",
		    	    columns: [
		    	      { title: "온도", field: "ilbo_g34", width: 80, hozAlign: "center" },
		    	      { title: "시간", field: "ilbo_g35", width: 80, hozAlign: "center" },
		    	      { title: "CP", field: "ilbo_mp", width: 80, hozAlign: "center" },
		    	    ],
		    	  },
		    	  {
		    	    title: "침탄",
		    	    columns: [
		    	      { title: "온도", field: "ilbo_g23", width: 80, hozAlign: "center" },
		    	      { title: "시간", field: "ilbo_g24", width: 80, hozAlign: "center" },
		    	      { title: "CP", field: "ilbo_g25", width: 80, hozAlign: "center" },
		    	    ],
		    	  },
		    	  {
		    	    title: "확산",
		    	    columns: [
		    	      { title: "온도", field: "ilbo_p26", width: 80, hozAlign: "center" },
		    	      { title: "시간", field: "ilbo_g26", width: 80, hozAlign: "center" },
		    	      { title: "CP", field: "ilbo_g27", width: 80, hozAlign: "center" },
		    	    ],
		    	  },
		    	  {
		    	    title: "강온",
		    	    columns: [
		    	    	{ title: "온도", field: "ilbo_g31", width: 80, hozAlign: "center" },
			    	    { title: "시간", field: "ilbo_g32", width: 80, hozAlign: "center" },
			    	    { title: "CP", field: "ilbo_g33", width: 80, hozAlign: "center" },
		    	    ],
		    	  },
		    	  {
			    	title: "균열(No2)",
			    	columns: [
			    		{ title: "온도", field: "ilbo_cm", width: 80, hozAlign: "center" },
			    	    { title: "시간", field: "ilbo_g41", width: 80, hozAlign: "center" },
			    	    { title: "CP", field: "ilbo_g42", width: 80, hozAlign: "center" },
			    	],
			      },
		    	  {
		    	    title: "소입",
		    	    columns: [
		    	      { title: "온도", field: "ilbo_g21", width: 80, hozAlign: "center" },
		    	      { title: "시간", field: "ilbo_g22", width: 80, hozAlign: "center" },
		    	    ],
		    	  },
		    	  { title: "교반속도", field: "ilbo_g13", width: 100, hozAlign: "center" },
		    	  {
			    	    title: "검사",
			    	    columns: [
			    	      { title: "x1", field: "ilbo_pg1", width: 80, hozAlign: "center" },
			    	      { title: "x2", field: "ilbo_pg2", width: 80, hozAlign: "center" },
			    	      { title: "x3", field: "ilbo_pg3", width: 80, hozAlign: "center" },
			    	      { title: "x4", field: "ilbo_pg4", width: 80, hozAlign: "center" },
			    	      { title: "x5", field: "ilbo_pg5", width: 80, hozAlign: "center" },
			    	    ],
			    	  },
				    
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



	


	function getLotIpgoChulList(ord_code){
		userTable = new Tabulator("#tab6", {
		    height:"180px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    headerSort:false,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		     ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/production/lotIpgo/getLotIpgoChulList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{ord_code:ord_code},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"수주NO", field:"ord_code", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"거래처", field:"corp_name", sorter:"string", width:120,
				    hozAlign:"center"},     
				{title:"품명", field:"prod_name", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"품번", field:"prod_no", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"입고일", field:"ord_date", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"LOT NO", field:"ord_lot", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"출고일", field:"och_date", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"수량", field:"och_su", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"중량", field:"och_amnt", sorter:"int", width:100,
		        	hozAlign:"center"},  	
		        {title:"비고", field:"och_bigo", sorter:"int", width:100,
			        hozAlign:"center"},
				    
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
