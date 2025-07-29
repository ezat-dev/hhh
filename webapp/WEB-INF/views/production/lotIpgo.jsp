<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>lot추적 관리(입고)</title>
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
	margin-left: -240px;
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
.box1 input[type="text"] {
	width: 80px;
	padding: 5px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	color: #333;
	outline: none;
	transition: border 0.3s ease;
}

.box1 input[type="text"]:focus {
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
		
		<!-- <label class="daylabel">수주 NO : </label>
		<input type="text" class="ord_code" id="ord_code" style="font-size: 16px;" autocomplete="off"> -->	
		
		<label class="daylabel">거래처 : </label>
		<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off">
		
		<label class="daylabel">품명 : </label>
		<input type="text" class="prod_name" id="prod_name" style="font-size: 16px;" autocomplete="off">
		
		<label class="daylabel">품번 : </label>
		<input type="text" class="prod_no" id="prod_no" style="font-size: 16px;" autocomplete="off">
		
		<label class="daylabel">규격 : </label>
		<input type="text" class="prod_gyu" id="prod_gyu" style="font-size: 16px;" autocomplete="off">
		
		<label class="daylabel">재질 : </label>
		<input type="text" class="prod_jai" id="prod_jai" style="font-size: 16px;" autocomplete="off">	
	</div>
	
	
	
    <div class="button-container">
        <button class="select-button" onclick="getLotIpgoList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
            
        </button>
        <button class="printer-button">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
            
        </button>
    </div>
</div>
    <main class="main">
    	<h3>입고</h3>
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
		<h3>준비</h3>
		<div class="container2">
			<div id="tab2" class="tabulator"></div>
		</div>
		<h3>침탄</h3>
		<div class="container3">
			<div id="tab3" class="tabulator"></div>
		</div>
		<h3>템퍼링</h3>
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
    var cutumTable;	

	//로드
	$(function(){
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		//전체 거래처목록 조회
		getLotIpgoList();
	});

	//이벤트
	//함수
	function getLotIpgoList(){
		userTable = new Tabulator("#tab1", {
		    height:"300px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		     ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/production/lotIpgo/getLotIpgoList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{"sdate" : $("#sdate").val(),
				"edate" : $("#edate").val(),
				"corp_name" : $("#corp_name").val(),
				"prod_name" : $("#prod_name").val(),
				"prod_no" : $("#prod_no").val(),
				"prod_gyu" : $("#prod_gyu").val(),
				"prod_jai" : $("#prod_jai").val(),},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:60,
		        	hozAlign:"center"},
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"영업담당자", field:"corp_business", sorter:"string", width:120,
				    hozAlign:"center"},     
				{title:"수주NO", field:"ord_code", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"품명", field:"prod_name", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"품번", field:"prod_no", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"재질", field:"prod_jai", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"입고일", field:"ord_date", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"업체LOT", field:"ord_lot", sorter:"int", width:100,
		        	hozAlign:"center"},  	
		        {title:"단위", field:"ord_danw", sorter:"int", width:100,
			        hozAlign:"center"},	
			    {title:"수량", field:"ord_su", sorter:"int", width:100,
				    hozAlign:"center"},	
				{title:"단가", field:"ord_dang", sorter:"int", width:100,
				    hozAlign:"center"},
				{title:"금액", field:"ord_mon", sorter:"int", width:100,
					hozAlign:"center"},
			    {title:"비고", field:"ord_bigo", sorter:"int", width:100,
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

				if(rowData.ord_code){
					getLotIpgoReadyList(rowData.ord_code);
			    }
				if(rowData.ord_code){
					getLotIpgoChimList(rowData.ord_code);
			    }
				if(rowData.ord_code){
					getLotIpgoTemList(rowData.ord_code);
			    }
				if(rowData.ord_code){
					getLotIpgoChulList(rowData.ord_code);
			    }
				
			},
		});		
	}

	function getLotIpgoReadyList(ord_code){
		userTable = new Tabulator("#tab2", {
		    height:"180px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		     ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/production/lotIpgo/getLotIpgoReadyList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{ord_code:ord_code},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"준비코드", field:"ilbo_code", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"작업일", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center"},     
				{title:"시작", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"종료", field:"ilbo_end", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"수량", field:"ilbo_su", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"중량", field:"ilbo_jung", sorter:"string", width:100,
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


	function getLotIpgoChimList(ord_code){
		userTable = new Tabulator("#tab3", {
		    height:"180px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		     ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/production/lotIpgo/getLotIpgoChimList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{ord_code:ord_code},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		    	{ title: "준비", field: "ilbo_pc", width: 120, hozAlign: "center" },
		    	  { title: "LOT NO", field: "ilbo_lot", width: 120, hozAlign: "center" },
		    	  { title: "시작", field: "ilbo_strt", width: 120, hozAlign: "center" },
		    	  { title: "종료", field: "ilbo_end", width: 150, hozAlign: "center" },
		    	  { title: "설비", field: "fac_name", width: 120, hozAlign: "center" },
		    	  { title: "작업자", field: "user_name", width: 100, hozAlign: "center" },
		    	  { title: "수량", field: "ilbo_su", width: 100, hozAlign: "center" },
		    	  { title: "중량", field: "ilbo_jung", width: 100, hozAlign: "center" },

		    	  {
		    	    title: "예열",
		    	    columns: [
		    	      { title: "온도", field: "ilbo_g43", width: 80, hozAlign: "center" },
		    	      { title: "시간", field: "ilbo_g42", width: 80, hozAlign: "center" },
		    	      { title: "CP", field: "", width: 80, hozAlign: "center" },
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
		    	      { title: "온도", field: "ilbo_pg6", width: 80, hozAlign: "center" },
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
		    	  /* {
		    	    title: "균열",
		    	    columns: [
		    	      { title: "온도", field: "ILBO_G21", width: 80, hozAlign: "center" },
		    	      { title: "시간", field: "ILBO_G22", width: 80, hozAlign: "center" },
		    	      { title: "CP", field: "", width: 80, hozAlign: "center" },
		    	    ],
		    	  }, */
		    	  {
		    	    title: "OIL",
		    	    columns: [
		    	      { title: "온도", field: "ilbo_g34", width: 80, hozAlign: "center" },
		    	    ],
		    	  },
		    	  /* {
		    	    title: "교반기",
		    	    columns: [
		    	      { title: "온도", field: "", width: 80, hozAlign: "center" },
		    	      { title: "시간", field: "", width: 80, hozAlign: "center" },
		    	      { title: "CP", field: "", width: 80, hozAlign: "center" },
		    	    ],
		    	  },
		    	  {
		    	    title: "냉각",
		    	    columns: [
		    	      { title: "온도", field: "", width: 80, hozAlign: "center" },
		    	      { title: "시간", field: "", width: 80, hozAlign: "center" },
		    	      { title: "CP", field: "", width: 80, hozAlign: "center" },
		    	    ],
		    	  }, */
				    
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



	function getLotIpgoTemList(ord_code){
		userTable = new Tabulator("#tab5", {
		    height:"180px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		     ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/production/lotIpgo/getLotIpgoTemList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{ord_code:ord_code},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"준비", field:"ilbo_pc", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"LOT NO", field:"ilbo_lot", sorter:"string", width:120,
				    hozAlign:"center"},     
				{title:"시작", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"종료", field:"ilbo_end", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"설비", field:"fac_name", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"작업자", field:"user_name", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"수량", field:"ilbo_su", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"중량", field:"ilbo_jung", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"온도", field:"ilbo_g11", sorter:"int", width:100,
		        	hozAlign:"center"},  	
		        {title:"시간", field:"ilbo_g12", sorter:"int", width:100,
			        hozAlign:"center"},	
			    {title:"차수", field:"ilbo_cm", sorter:"int", width:100,
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


	function getLotIpgoChulList(ord_code){
		userTable = new Tabulator("#tab6", {
		    height:"180px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
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
