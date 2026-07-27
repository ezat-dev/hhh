<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>월매출현황(마감)</title>
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
.legend {
  position: absolute;
  top: 20px;
  right: 190px;
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 6px;
  padding: 10px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
  
  display: flex;         
  gap: 12px;              
}

.legend-item {
  display: flex;
  align-items: center;
  margin: 0;               
}

.legend-color {
  width: 14px;
  height: 14px;
  border-radius: 2px;
  margin-right: 6px;
}

    .color-red        { background: #e74c3c;        }
    .color-orange     { background: #e67e22;     }
    .color-yellow     { background: #f1c40f;     }
    .color-lightgreen { background: #2ecc71; }
        
   #dataList .tabulator-tableHolder .tabulator-row {
    height: 37px !important;
     font-size: 17px !important;
  }

  #dataList .tabulator-tableHolder .tabulator-cell {
    line-height: 37px !important;
     font-size: 17px !important;
  }

  #dataList .tabulator-tableHolder .tabulator-header .tabulator-col {
    height: 37px !important;
    line-height: 37px !important;
     font-size: 17px !important;
  }
      .custom-progress {
      background: #f0f0f0;
      border-radius: 4px;
      overflow: hidden;
      height: 27px;
      position: relative;
      box-shadow: inset 0 1px 3px rgba(0,0,0,0.2);
    }
    .custom-progress .bar {
      height: 100%;
      border-radius: 4px;
      transition: width 0.5s ease-in-out;
    }
    /* 값 범위별 색상 */
    .bar.color-red { background: #e74c3c; }
    .bar.color-orange { background: #e67e22; }
    .bar.color-yellow { background: #f1c40f; }
    .bar.color-lightgreen { background: #2ecc71; }
    .custom-progress .label {
      position: absolute;
      width: 100%;
      text-align: center;
      font-size: 17px;
      font-weight: bold;
      color: #333;
      top: 0;
      left: 0;
      line-height: 19px;
    }
 .box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -960px;
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

/* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main {
    flex: 1;
    min-height: 0;
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
#tab1 .tabulator-col .tabulator-header-filter input:focus {
    outline: none;
    background: #ffffff;
    box-shadow: 0 0 0 2px rgba(255,255,255,.6);
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
#tab1 .tabulator-footer .tabulator-calcs-holder {
    background: #EBF8FF !important;
    border-top: none;
    border-bottom: 1px solid #BEE3F8;
    color: #2B6CB0;
    font-weight: 700;
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
    </style>
    
    
    <body>
    
    <div class="tab">
     <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
        
		<label class="daylabel">입출고기간 : </label>
		<input type="month" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off">
		
		<label class="daylabel">거래처 :</label>
		<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off">
		
			
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getMonthSaleList();">
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
	let now_page_code = "g06";
    var cutumTable;	
    var sdate = $("#sdate").val();
	//로드
	$(function(){
		//전체 거래처목록 조회
		getMonthSaleList();
	});

	//이벤트
	//함수
	function getMonthSaleList(){
		if (!document.getElementById('progress-styles')) {
    	    const style = document.createElement('style');
    	    style.id = 'progress-styles';
    	    style.innerHTML = `
    	      .custom-progress { background: #f0f0f0; border-radius: 4px; overflow: hidden; height: 27px; position: relative; box-shadow: inset 0 1px 3px rgba(0,0,0,0.2); }
    	      .custom-progress .bar { height: 100%; border-radius: 4px; transition: width 0.5s ease-in-out; }
    	      .bar.color-red { background: #e74c3c; }
    	      .bar.color-orange { background: #e67e22; }
    	      .bar.color-yellow { background: #f1c40f; }
    	      .bar.color-lightgreen { background: #2ecc71; }
    	      .custom-progress .label { position: absolute; width: 100%; text-align: center; font-size: 16px; font-weight: bold; color: #333; top: -4; left: 0; line-height: 16px; }
    	    `;
    	    document.head.appendChild(style);
    	  }

    	  // 퍼센트 포맷터 정의: 범위별 색상 적용
    	  var percentFormatter = function(cell, formatterParams, onRendered) {
    	    var value = cell.getValue() || 0;
    	    var colorClass = value <= 25 ? 'color-red'
    	                   : value <= 50 ? 'color-orange'
    	                   : value <= 75 ? 'color-yellow'
    	                   : 'color-lightgreen';
    	    var wrapper = document.createElement('div');
    	    wrapper.className = 'custom-progress';

    	    var bar = document.createElement('div');
    	    bar.className = 'bar ' + colorClass;
    	    bar.style.width = value + '%';
    	    wrapper.appendChild(bar);

    	    var label = document.createElement('div');
    	    label.className = 'label';
    	    label.textContent = value + '%';
    	    wrapper.appendChild(label);

    	    return wrapper;
    	  };
		
		userTable = new Tabulator("#tab1", {
		    height:"100%",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/operation/monthSale/getMonthSaleList",
		    ajaxParams:{"sdate": $("#sdate").val(),
		    	"corp_name": $("#corp_name").val(),
		    	"prod_name": $("#prod_name").val(),
		    	"prod_no": $("#prod_no").val(),
		    	"prod_gubn": $("#prod_gubn").val(),
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
		    	{title:"NO", field:"idx", sorter:"int", width:80, hozAlign:"center"},
		        {title:"마감월", field:"och_ma", sorter:"string", width:120, hozAlign:"center", headerSort:false},	
		        {title:"출고일", field:"och_date", sorter:"string", width:120, hozAlign:"center", headerSort:false},     
		        {title:"거래처", field:"corp_name", sorter:"string", width:140, hozAlign:"center", headerFilter:"input", headerSort:false}, 
		        {title:"품명", field:"prod_name", sorter:"string", width:160, hozAlign:"center", headerFilter:"input", headerSort:false}, 
		        {title:"품번", field:"prod_no", sorter:"string", width:160, hozAlign:"center", headerFilter:"input", headerSort:false},		        
		        {title:"LOT NO", field:"och_lot", sorter:"string", width:100, hozAlign:"center", headerSort:false},
		        
		        {title:"수량", field:"och_su", sorter:"int", width:110, hozAlign:"center",
		            formatter: "money", 
		            formatterParams: { decimal: ".", thousand: ",", precision: 0 },
		            bottomCalc:"sum", 
		            bottomCalcFormatter:"money", 
		            bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
		        },

		        {title:"단가", field:"och_dang", sorter:"int", width:110, hozAlign:"center",
		            formatter: "money", 
		            formatterParams: { decimal: ".", thousand: ",", precision: 0 }
		        },

		        {title:"공급가액", field:"och_mon", sorter:"int", width:130, hozAlign:"center",
		            formatter: "money", 
		            formatterParams: { decimal: ".", thousand: ",", precision: 0 },
		            bottomCalc:"sum", 
		            bottomCalcFormatter:"money", 
		            bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
		        },  	

		        {title:"부가세", field:"och_mon_tax", sorter:"int", width:130, hozAlign:"center",
		            formatter: "money", 
		            formatterParams: { decimal: ".", thousand: ",", precision: 0 },
		            bottomCalc:"sum", 
		            bottomCalcFormatter:"money", 
		            bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
		        },

		        {title:"합계금액", field:"och_mon_total", sorter:"int", width:130, hozAlign:"center",
		            formatter: "money", 
		            formatterParams: { decimal: ".", thousand: ",", precision: 0 },
		            bottomCalc:"sum", 
		            bottomCalcFormatter:"money", 
		            bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
		        },
				
				    
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();

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

	</body>
</html>
