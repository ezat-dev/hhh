<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품별재고현황</title>
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
    
    
    </style>
    
    
    <body>
    
    <div class="tab">
    
    <div class="button-container">
        <button class="select-button">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button">
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
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>
	    
	    
<script>
	//전역변수
    var cutumTable;	

	//로드
	$(function(){
		//전체 거래처목록 조회
		getPJaegoStatusList();
	});

	//이벤트
	//함수
	function getPJaegoStatusList(){
		
		userTable = new Tabulator("#tab1", {
		    height:"750px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/product/pjaegoStatus/getPJaegoStatusList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"품명", field:"prod_name", sorter:"string", width:120,
				    hozAlign:"center"},     
				{title:"규격", field:"prod_gyu", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"품번", field:"prod_no", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"재질", field:"prod_jai", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"공정", field:"tech_te", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"단위", field:"prod_danw", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"단가", field:"prod_dang", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"단중", field:"prod_danj", sorter:"int", width:100,
		        	hozAlign:"center"},  	
		        {title:"전월재고", field:"pjai_pre", sorter:"int", width:100,
			        hozAlign:"center"},	
			    {title:"당월입고", field:"pjai_ip", sorter:"int", width:100,
				    hozAlign:"center"},	
				{title:"당월출고수", field:"pjai_ch", sorter:"int", width:100,
				    hozAlign:"center"},
				{title:"전산재고수", field:"pjai_jai", sorter:"int", width:100,
					hozAlign:"center"},
			    {title:"전산재고중량", field:"pjai_jai_j", sorter:"int", width:100,
					hozAlign:"center"},
 			    {title:"전산금액", field:"pjai_jai_mon", sorter:"int", width:100,
					hozAlign:"center"},
				{title:"조정수량", field:"pjai_jo", sorter:"int", width:100,
					hozAlign:"center"},
				{title:"조정중량", field:"pjai_jo_j", sorter:"int", width:100,
					hozAlign:"center"},
				{title:"실재고수", field:"pjai_real", sorter:"int", width:100,
					hozAlign:"center"},
				{title:"실재고중량", field:"pjai_real_j", sorter:"int", width:100,
					hozAlign:"center"},
				{title:"실재고금액", field:"pjai_real_mon", sorter:"int", width:100,
					hozAlign:"center"},
				{title:"비고", field:"och_bigo", sorter:"int", width:100,
					hozAlign:"center"},
				{title:"영업담당자", field:"corp_business", sorter:"int", width:100,
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
