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

.tabulator .tabulator-cell {
	white-space: normal !important;
	word-break: break-word;
	text-align: center;
}

/* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main {
    flex: 1;
    min-height: 0;
    width: 100%;
    display: flex;
    padding: 8px;
    overflow: hidden;
}

/* ========== 상단 도구바 ========== */
.tab {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 0 14px;
}
.button-container .select-button,
.button-container .insert-button,
.button-container .excel-button,
.button-container .printer-button,
.button-container .delete {
    height: 34px;
    border: 1px solid #E2E8F0;
    border-radius: 8px;
    background: #F0F4F8;
    transition: background-color .13s, border-color .13s;
}
.button-container .select-button:hover,
.button-container .insert-button:hover,
.button-container .excel-button:hover,
.button-container .printer-button:hover,
.button-container .delete:hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
}

/* ========== 리스트 카드 영역 ========== */
.container {
    display: flex;
    flex: 1;
    min-height: 0;
    flex-direction: column;
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 8px;
    overflow: hidden;
}

/* ========== Tabulator 리스트 ========== */
#tab1.tabulator {
    flex: 1;
    min-height: 0;
    width: 100%;
    min-width: 0;
    border: none;
    font-size: 12px;
}
#tab1 .tabulator-header {
    background: linear-gradient(135deg, #2B6CB0, #3182CE);
    border-bottom: none;
}
#tab1 .tabulator-col {
    background: transparent;
    border-right: 1px solid rgba(255,255,255,.15);
}
#tab1 .tabulator-col.tabulator-sortable:hover {
    background: rgba(255,255,255,.08);
}
#tab1 .tabulator-col-title {
    color: #ffffff;
    font-weight: 700;
}
#tab1 .tabulator-col .tabulator-header-filter input {
    border: none;
    border-radius: 5px;
    padding: 4px 6px;
    font-size: 11px;
    background: rgba(255,255,255,.92);
    box-sizing: border-box;
}
#tab1 .tabulator-row {
    border-bottom: 1px solid #EDF2F7;
    transition: background-color .12s;
}
#tab1 .tabulator-row.tabulator-row-even {
    background-color: #F7FAFC;
}
#tab1 .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#tab1 .tabulator-row.row_select,
#tab1 .tabulator-row.tabulator-selected {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#tab1 .tabulator-cell {
    border: 1px solid #E2E8F0;
    color: #2D3748;
}

/* ========== 페이지네이션 (직관적으로 개선) ========== */
#tab1 .tabulator-footer {
    background: #F7FAFC;
    border-top: 1px solid #E2E8F0;
    padding: 8px 12px;
}
#tab1 .tabulator-paginator {
    display: inline-flex;
    align-items: center;
    gap: 6px;
}
#tab1 .tabulator-page-size {
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    padding: 4px 8px;
    font-size: 12px;
    background: #ffffff;
    color: #2D3748;
    cursor: pointer;
    margin: 0;
}
#tab1 .tabulator-page-size:focus {
    outline: none;
    border-color: #3182CE;
}
#tab1 .tabulator-pages {
    display: flex;
    gap: 4px;
    margin: 0;
}
#tab1 .tabulator-page {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    background: #ffffff;
    color: #2D3748;
    min-width: 30px;
    height: 28px;
    padding: 0 8px;
    font-size: 12px;
    font-weight: 600;
    margin: 0;
    transition: background-color .13s, border-color .13s, color .13s;
}
#tab1 .tabulator-page.active {
    background: #3182CE;
    border-color: #2B6CB0;
    color: #ffffff;
}
#tab1 .tabulator-page:not(:disabled):hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
    color: #2B6CB0;
    cursor: pointer;
}
#tab1 .tabulator-page:disabled {
    opacity: .4;
    cursor: not-allowed;
}

 .box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -1240px;
}
.box1 input{
	width: 5%
}  
.box1 input{
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

.box1 input:focus {
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
		<label class="daylabel">일자 : </label>
		<input type="month" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off">
	</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getPJaegoStatusList();">
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
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>
	    
	    
<script>


	

	//전역변수
	let now_page_code = "a03";
    var cutumTable;	
    var sdate = $("#sdate").val();
	//로드
	$(function(){
		getPJaegoStatusList();
	});

	//이벤트
	//함수
	function getPJaegoStatusList(){
		
		userTable = new Tabulator("#tab1", {
		    tableBuilt:function(){ this.redraw(true); },
		    height:"100%",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    headerSort:false,
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/product/pjaegoStatus/getPJaegoStatusList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"sdate": $("#sdate").val(),
			    },
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
	        paginationSize:20,
	        paginationSizeSelector:[20,50,100,500,1000],
	        paginationCounter:"rows",
	        headerFilterPlaceholder: "",
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				return response.data ? response.data : []; 
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:40,
		        	hozAlign:"center"},
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"품명", field:"prod_name", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},     
				{title:"규격", field:"prod_gyu", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"}, 
				{title:"품번", field:"prod_no", sorter:"string", width:150,
				    hozAlign:"center", headerFilter:"input"}, 
		        {title:"재질", field:"prod_jai", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},		        
		        {title:"공정", field:"tech_te", sorter:"string", width:50,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"단위", field:"prod_danw", sorter:"string", width:50,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"단가", field:"prod_dang", sorter:"string", width:50,
			        hozAlign:"center", headerFilter:"input"},	
		        {title:"단중", field:"prod_danj", sorter:"string", width:50,
		        	hozAlign:"center", headerFilter:"input"},  	
		        {title:"전월재고", field:"pjai_pre", sorter:"int", width:50,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"당월입고", field:"pjai_ip", sorter:"int", width:50,
				    hozAlign:"center", headerFilter:"input"},	
				{title:"당월출고수", field:"pjai_ch", sorter:"int", width:65,
				    hozAlign:"center", headerFilter:"input"},
				{title:"전산재고수", field:"pjai_jai", sorter:"int", width:65,
					hozAlign:"center", headerFilter:"input"},
			    {title:"전산재고중량", field:"pjai_jai_j", sorter:"int", width:65,
					hozAlign:"center", headerFilter:"input"},
 			    {title:"전산금액", field:"pjai_jai_mon", sorter:"int", width:50,
					hozAlign:"center", headerFilter:"input"},
				{title:"조정수량", field:"pjai_jo", sorter:"int", width:50,
					hozAlign:"center", headerFilter:"input"},
				{title:"조정중량", field:"pjai_jo_j", sorter:"int", width:50,
					hozAlign:"center", headerFilter:"input"},
				{title:"실재고수", field:"pjai_real", sorter:"int", width:50,
					hozAlign:"center", headerFilter:"input"},
				{title:"실재고중량", field:"pjai_real_j", sorter:"int", width:50,
					hozAlign:"center", headerFilter:"input"},
				{title:"실재고금액", field:"pjai_real_mon", sorter:"int", width:50,
					hozAlign:"center", headerFilter:"input"},
				{title:"비고", field:"och_bigo", sorter:"int", width:50,
					hozAlign:"center", headerFilter:"input"},
				{title:"영업담당자", field:"corp_business", sorter:"int", width:50,
					hozAlign:"center", headerFilter:"input"},	
					{title:"날짜", field:"pjai_mnth", sorter:"String", width:50,
						hozAlign:"center", headerFilter:"input"},					
				    
		    ],
		    rowFormatter:function(row){
			    row.getElement().style.fontWeight = "600";
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
    <script>
	    window.addEventListener('DOMContentLoaded', () => {
		    const today = new Date();
		    const year = today.getFullYear();
		    const month = String(today.getMonth() + 1).padStart(2, '0');
		    const day = String(today.getDate()).padStart(2, '0');
		    const formattedToday = `${year}-${month}-${day}`;
		
		   
		    document.getElementById('sdate').value = formattedToday;
		    document.getElementById('edate').value = formattedToday;
		});
    </script>

	</body>
</html>
