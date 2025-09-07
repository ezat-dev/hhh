<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>입고관리</title>
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
/*	width: 880px;
	margin-left: -620px;
	margin-left: -21%;*/
}


.box1 input{
	width : 24%;
	font-size:12pt;
}
.box1 select{
	width : 26%;
	font-size:12pt;
}         

.ipgoModal {
	position: fixed; /* 화면에 고정 */
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20010; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.header {
	display: flex; /* 플렉스 박스 사용 */
	justify-content: center; /* 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	margin-bottom: 10px; /* 상단 여백 */
	background-color: #33363d; /* 배경색 */
	height: 50px; /* 높이 */
	color: white; /* 글자색 */
	font-size: 20px; /* 글자 크기 */
	text-align: center; /* 텍스트 정렬 */
}
.btnSaveClose {
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	gap: 20px; /* 버튼 사이 여백 */
	margin-top: 30px; /* 모달 내용과의 간격 */
	margin-bottom: 20px; /* 모달 하단과 버튼 사이 간격  */
}
.btnSaveClose button {
	width: 100px;
	height: 35px;
	background-color: #FFD700; /* 기본 배경 - 노란색 */
	color: black;
	border: 2px solid #FFC107; /* 노란 테두리 */
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	line-height: 35px;
	margin: 0 10px;
	margin-top: 10px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

/* 저장 버튼 호버 시 */
.btnSaveClose .save:hover {
	background-color: #FFC107;
	transform: scale(1.05);
}

/* 닫기 버튼 - 회색 톤 */
.btnSaveClose .close {
	background-color: #A9A9A9;
	color: black;
	border: 2px solid #808080;
}

/* 닫기 버튼 호버 시 */
.btnSaveClose .close:hover {
	background-color: #808080;
	transform: scale(1.05);
}
/*
input[type="date"] {
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
*/
.tabulator-col-title > input[type='checkbox']{
	width:20px;
	height:20px;
}

.tabulator-cell > input[type='checkbox']{
	width:20px;
	height:20px;
}

.orderPrintStatusModal {
	position: fixed; /* 화면에 고정 */
	width:350px;
	height:150px;	
	top: 50%; /* 수직 중앙 */
	left: 40%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20010; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.j_container{
	display:flex;
/*	border-radius: 6px;
    border: 1px solid gray*/	
}

.j_row1{
	display:flex;
	margin-top:4px;
}

.j_h_div{
	width:130px;
}

.orderReportModal {
	position: fixed; /* 화면에 고정 */
	width:850px;
	height:800px;
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20010; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.search_input{
 font-size: 12pt; 
 width:90px;
}


    </style>
    
    
    <body>
    
    
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 20px; color: white; font-weight: 800;"></p>
		<form action="">
			<label class="daylabel">입고일 :</label>
			<input type="date" name="sdate" id="sdate">
			~
			<input type="date" name="edate" id="edate">
			<select name="ord_print_gb" id="ord_print_gb" class="search_input">
				<option value="1">열처리 수주서</option>
				<option value="2">열후TAG</option>
				<option value="3">입고현황표</option>
			</select>
		</form>	
	</div>
	
    
    <div class="button-container">
        <button class="select-button" onclick="getIpgoList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
        </button>
        <button class="delete">
            <img src="/tkheat/css/image/delete-icon.png" alt="delete" class="button-image">
        </button>
        <button class="printer-button">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">            
        </button>
    </div>
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>
	    
<!-- 다이얼로그 -->
<div class="ipgoModal">    
	<div class="detail">
		<div class="header">
		입고등록
		</div>
		<div class="setRow">
			<label class="daylabel">입고일 :</label>
			<input type="date" class="ord_date" id="s_ord_date" 
				style="font-size: 12pt;" autocomplete="off">		
		</div>		
		<div id="tabuData"></div>
	</div>
	
    <div class="btnSaveClose">
            <button class="save" type="button" onclick="save();">저장</button>
            <button class="close" type="button" onclick="closeBtn();">닫기</button>
    </div>	
</div>

<!-- 열처리수주서, 열후TAG, 입고현황표 출력중 모달 -->
<div class="orderPrintStatusModal">
	<div class="detail">
		<div class="header">
			<span style="display:inline-block; width:150px;" class="ordPrint1">열처리 수주서</span>
			<span style="display:inline-block; width:150px;" class="ordPrint2">열후TAG</span>
			<span style="display:inline-block; width:150px;" class="ordPrint3">입고현황표</span>
		</div>
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<span style="display:inline-block; width:350px;" class="ordPrint1">열처리수주서 파일 생성중입니다....</span>
					<span style="display:inline-block; width:350px;" class="ordPrint2">열후TAG 파일 생성중입니다....</span>
					<span style="display:inline-block; width:350px;" class="ordPrint3">입고현황표 파일 생성중입니다....</span>
					<br />
					<span style="display:inline-block; width:350px;">생성완료시 팝업창이 닫힙니다.</span>
				</div>
			</div>
		</div>
	</div>
	
	
	    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="orderPrintStatusClose iRowBtn margin_left" type="button" onclick="orderPrintStatusCloseBtn();">닫기</button>
		</div>
    </div>	
</div>
<!-- 열처리작업 저장 모달 -->
<div class="orderReportModal">
	<div class="j_container">
		<iframe src="" frameborder="0" width="800" height="700" id="orderReport">
		</iframe>	
	</div>
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="orderReportClose iRowBtn margin_left" type="button" onclick="orderReportCloseBtn();">닫기</button>
		</div>
    </div>
</div>
<script>


	//전역변수
    var cutumTable;	
	let now_page_code = "a02";

	//로드
	$(function(){
		
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		
		//모달창 입고일
		$("#s_ord_date").val(tdate);
		
		//전체 거래처목록 조회
		getIpgoList();		
		
	});

	//이벤트
	$(".printer-button").on("click", function(){
		
		var ord_print_gb = $("#ord_print_gb").val();
		
		if(ord_print_gb == 1){
			$(".ordPrint1").css("display","inline-block");
			$(".ordPrint2").css("display","none");
			$(".ordPrint3").css("display","none");
		}else if(ord_print_gb == 2){
			$(".ordPrint1").css("display","none");
			$(".ordPrint2").css("display","inline-block");
			$(".ordPrint3").css("display","none");
		}else if(ord_print_gb == 3){
			$(".ordPrint1").css("display","none");
			$(".ordPrint2").css("display","none");
			$(".ordPrint3").css("display","inline-block");
		}
		
		var selectArray = ipgoListTable.getSelectedData();
		
		orderPrintStatusModal.style.display = "block";
		
		//체크한 데이터만 조회
		if(ipgoListTable.getSelectedData().length > 0){
			
			var selectArray = ipgoListTable.getSelectedData();
			var ordCodeArray = new Array();
			
			for(var i=0; i<selectArray.length; i++){
				
				if(selectArray[i].ord_code != null){
					//작업번호가 다를경우 alert창
					ordCodeArray.push(selectArray[i].ord_code);	
				}

			}

			$.ajax({
				url:"/tkheat/product/ipgo/ipgoListPrint",
				type:"post",
				dataType:"json",
				traditional: true,
				data:{
					"ord_code_array":ordCodeArray,
					"ord_print_gb":ord_print_gb
				},
				success:function(result){
					
					orderPrintStatusCloseBtn();
					getIpgoList();
				}
			});

		}		

	});
	
	$(".delete").on("click",function(){
		
		var selectArray = ipgoListTable.getSelectedData();
		
		//체크한 데이터만 조회
		if(ipgoListTable.getSelectedData().length > 0){
			
			if(confirm("선택한 행을 삭제하시겠습니까?")){

				var selectArray = ipgoListTable.getSelectedData();
				var ordCodeArray = new Array();
				
				for(var i=0; i<selectArray.length; i++){
					
					if(selectArray[i].ord_code != null){
						//작업번호가 다를경우 alert창
						ordCodeArray.push(selectArray[i].ord_code);	
					}
	
				}
	
				$.ajax({
					url:"/tkheat/product/ipgo/ipgoListDelete",
					type:"post",
					dataType:"json",
					traditional: true,
					data:{
						"ord_code_array":ordCodeArray
					},
					success:function(result){
						getIpgoList();
					}
				});
			}
		}else{
			alert("삭제할 행을 선택해주십시오!!");
			return false;
		}
		
	});
	
	//함수
	var beforePrintIcon = function(cell, formatterParams){ //plain text value
	var icon = "";
		if(cell.getRow().getData().ord_before_file_yn != 0){
			icon = "<img src='/tkheat/css/image/folder-icon.png' alt='forder' class='button-image'></img>";
		}
		return icon;
	};
	var afterPrintIcon = function(cell, formatterParams){ //plain text value
	var icon = "";
		if(cell.getRow().getData().ord_after_file_yn != 0){
			icon = "<img src='/tkheat/css/image/folder-icon.png' alt='forder' class='button-image'></img>";
		}
		return icon;
	};
	var managePrintIcon = function(cell, formatterParams){ //plain text value
	var icon = "";
		if(cell.getRow().getData().ord_manage_file_yn != 0){
			icon = "<img src='/tkheat/css/image/folder-icon.png' alt='forder' class='button-image'></img>";
		}
		return icon;
	};
	
	var dateEditor = function(cell, onRendered, success, cancel){
	    //cell - the cell component for the editable cell
	    //onRendered - function to call when the editor has been rendered
	    //success - function to call to pass thesuccessfully updated value to Tabulator
	    //cancel - function to call to abort the edit and return to a normal cell

	    //create and style input
	    var cellValue = cell.getValue();
	    
	    input = document.createElement("input");

	    input.setAttribute("type", "date");

	    input.style.padding = "4px";
	    input.style.width = "100%";
	    input.style.boxSizing = "border-box";

	    input.value = cellValue;

	    onRendered(function(){
	        input.focus();
	        input.style.height = "100%";
	    });

	    function onChange(){
	        if(input.value != cellValue){
	        	if(input.value != ""){
	            	success(input.value);
	        	}else{
	        		cancel();	
	        	}
	        }else{
	            cancel();
	        }
	    }

	    //submit new value on blur or change
	    input.addEventListener("blur", onChange);

	    //submit new value on enter
	    input.addEventListener("keydown", function(e){
	        if(e.keyCode == 13){
	            onChange();
	        }

	        if(e.keyCode == 27){
	            cancel();
	        }
	    });

	    return input;
	};	
	
	
	
	
	function getIpgoList(){
		
		ipgoListTable = new Tabulator("#tab1", {
		    height:"750px",
		    layout:"fitColumns",
//		    selectable:true,	//로우 선택설정
		    tooltips:true,
//		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/product/ipgo/getIpgoList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"sdate": $("#sdate").val(),
		    	"edate": $("#edate").val(),
			    },
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		    	{formatter:"rowSelection", titleFormatter:"rowSelection", width:40, headerSort:false,
		    		cellClick:function(e, cell){
//		    			cell.getRow().toggleSelect();
		    		}
		    	},		    	
				{	headerSort:false,
		    		formatter:beforePrintIcon, width:60, title:"열처리</br>수주서",cellClick:function(e, cell){
		    			if(cell.getRow().getData().ord_code != null){
		    				var ord_code = cell.getRow().getData().ord_code;
//		    				alert("작업로트 " + jisi_lot_view);
		    				var fileUrl = "/tkPrint/열처리수주서/"+ord_code+".pdf";
		                    $("#orderReport").attr("src",fileUrl);
		                    orderReportModal.style.display = "block";
		    			}
		    		}
				},
/*
				{	headerSort:false,
		    		formatter:afterPrintIcon, width:60, title:"열후</br>TAG",cellClick:function(e, cell){
		    			if(cell.getRow().getData().ord_code != null){
		    				var ord_code = cell.getRow().getData().ord_code;
//		    				alert("작업로트 " + jisi_lot_view);
		    				var fileUrl = "/tkPrint/열후TAG/"+ord_code+".pdf";
		                    $("#orderReport").attr("src",fileUrl);
		                    orderReportModal.style.display = "block";
		    			}
		    		}
				},
				{	headerSort:false,
		    		formatter:managePrintIcon, width:60, title:"입고</br>현황표",cellClick:function(e, cell){
		    			if(cell.getRow().getData().ord_code != null){
		    				var ord_code = cell.getRow().getData().ord_code;
//		    				alert("작업로트 " + jisi_lot_view);
		    				var fileUrl = "/tkPrint/입고현황표/"+ord_code+".pdf";
		                    $("#orderReport").attr("src",fileUrl);
		                    orderReportModal.style.display = "block";
		    			}
		    		}
				},
*/
		        {title:"NO", field:"idx", sorter:"int", width:30,
		        	hozAlign:"center", headerSort:false},
		        {title:"출력", field:"ord_prn", sorter:"string", width:30,
			        hozAlign:"center", headerSort:false},	
			    {title:"수주NO", field:"ord_code", sorter:"string", width:85,
				    hozAlign:"center", headerFilter:"input"},
				{title:"입고일", field:"ord_date", sorter:"string", width:100,
				    hozAlign:"center",  headerSort:false,
				    editor:dateEditor}, 
				{title:"출고예정", field:"ord_nap", sorter:"string", width:100,
				    hozAlign:"center",  headerSort:false,
				    editor:dateEditor}, 
		        {title:"거래처", field:"corp_name", sorter:"string", width:100,
		        	hozAlign:"center", headerSort:false, headerFilter:"input"},		        
		        {title:"품명", field:"prod_name", sorter:"string", width:100,
		        	hozAlign:"center",  headerSort:false, headerFilter:"input"},
		        {title:"품번", field:"prod_no", sorter:"string", width:120,
		        	hozAlign:"center",  headerSort:false, headerFilter:"input"},
		        {title:"규격", field:"prod_gyu", sorter:"string", width:80,
			        hozAlign:"center",  headerSort:false, headerFilter:"input"},	
		        {title:"재질", field:"prod_jai", sorter:"int", width:80,
		        	hozAlign:"center",  headerSort:false, headerFilter:"input"},  	
		        {title:"공정", field:"tech_te", sorter:"int", width:60,
			        hozAlign:"center",  headerSort:false, headerFilter:"select",
			    	headerFilterParams:{
			    		values:{
			    			"":"전체",
			    			"침탄":"침탄",
			    			"QT":"QT"
			    		}
			    	}    
		        },	
		        
			    {title:"단위", field:"ord_danw", sorter:"int", width:40,
				    hozAlign:"center",  headerSort:false},	
				{title:"박스수량", field:"ord_boxsu", sorter:"int", width:70,
				    hozAlign:"center",  headerSort:false,
				    editor:"input"
				},
				{title:"단중", field:"ord_danj", sorter:"int", width:60,
				    hozAlign:"center",  headerSort:false,
				    editor:"input"
				},
				{title:"수량", field:"ord_su", sorter:"int", width:40,
					hozAlign:"center",  headerSort:false,
					editor:"input"
				},
				{title:"중량", field:"ord_amnt", sorter:"int", width:50,
					hozAlign:"center",  headerSort:false
				},	
				{title:"입고/<br/>타각LOT", field:"ord_lot", sorter:"int", width:65,
					hozAlign:"center",  headerSort:false,
					editor:"input"
				},	
				
				{title:"수입<br/>검사", field:"itst_wp", sorter:"int", width:40,
					hozAlign:"center",  headerSort:false,
					editor:"input"
				},
				{title:"담당자", field:"ord_name", sorter:"int", width:60,
					hozAlign:"center",  headerSort:false,
					editor:"input", headerFilter:"input"
				},
				{title:"선입", field:"ord_sunip", sorter:"int", width:45,
					hozAlign:"center",  headerSort:false,
					editor:"select",
					editorParams:{
						values:["선입1","선입2","선입3","선입4","선입5"]
					}
				},
				{title:"비고", field:"ord_bigo", sorter:"int", width:80,
					hozAlign:"center",  headerSort:false,
					editor:"input"
				},
				{title:"표면경도", field:"prod_pg", sorter:"int", width:80,
					hozAlign:"center",  headerSort:false},
				{title:"경화깊이", field:"prod_cd", sorter:"int", width:80,
					hozAlign:"center",  headerSort:false},
				{title:"심부경도", field:"prod_sg", sorter:"int", width:80,
					hozAlign:"center",  headerSort:false},
				{title:"화합물층", field:"prod_e1", sorter:"int", width:80,
					hozAlign:"center",  headerSort:false},
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    row.getElement().style.fontWeight = "700";
			    
			    if(data.ord_prn == 0){				    
				    row.getElement().style.backgroundColor = "#FAED7D";	
			    }else{
			    	row.getElement().style.backgroundColor = "#FFFFFF";
			    }
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
			cellEdited: function(cell) {
			    var cell_field = cell.getField(); 
			    var cell_value = cell.getValue(); 
			    var rowData = cell.getRow().getData(); 
			    var cell_code = rowData.ord_code; 

			    $.ajax({
			        url: "/tkheat/product/ipgo/getIpgoList/update",
			        type: "POST",
			        dataType:"json",			        
			        data: {
			        	"cell_field":cell_field,
			        	"cell_value":cell_value,
			        	"cell_code":cell_code
			        },
			        success: function(result) {
			        	getIpgoList();
			        }
			    });
			}
		});		
	}

	function getIpgoAddList(){
		
		ipgoAddTable = new Tabulator("#tabuData", {
		    height:"550px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,		    
		    ajaxURL:"/tkheat/product/ipgo/getIpgoAddList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"sdate": $("#sdate").val(),
		    	"edate": $("#edate").val(),
			    },
			headerSort:false,
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tabuData .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    rowSelectionChanged:function(data, rows){
		    	//rows - array of row components for the selected rows in order of selection
		        //data - array of data objects for the selected rows in order of selection
		        //여기에 이벤트 정의
		        
//		        console.log(rows);
		        if(data.length != 0){
		        	console.log(data);
		        	ipgoData = data;
		        }
		    },		    
		    columns:[
			    {formatter:"rowSelection", titleFormatter:"rowSelection",
			    	hozAlign:"center", width:30,
				    headerSort:false, cellClick:function(e, cell){
			        }
		        },			    	
		        {title:"제품단중", field:"prod_danj", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input", visible:false},	
			    {title:"제품코드", field:"prod_code", sorter:"string", width:100,
				    hozAlign:"center", headerFilter:"input", visible:false},     
				{title:"수주NO", field:"ord_code", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input", visible:false}, 
				{title:"거래처", field:"corp_name", sorter:"string", width:150,
				    hozAlign:"center", headerFilter:"input"}, 
		        {title:"품명", field:"prod_name", sorter:"string", width:160,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"품번", field:"prod_no", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input"},	
		        {title:"재질", field:"prod_jai", sorter:"int", width:100,
		        	hozAlign:"center", headerFilter:"input"},  	
		        {title:"공정", field:"tech_te", sorter:"int", width:80,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"표면경도", field:"prod_pg", sorter:"int", width:100,
				    hozAlign:"center", headerFilter:"input"},	
				{title:"심부경도", field:"prod_sg", sorter:"int", width:100,
				    hozAlign:"center", headerFilter:"input"},
				{title:"경화깊이", field:"prod_cd", sorter:"int", width:100,
					hozAlign:"center", headerFilter:"input"},
				{title:"단위", field:"prod_danw", sorter:"int", width:60,
					hozAlign:"center", headerFilter:"input", headerSort:false},	
				{title:"박스수량", field:"prod_boxsu", sorter:"int", width:70,
					hozAlign:"center", headerFilter:"input", headerSort:false,editor:true},	
				{title:"수량", field:"ord_su", sorter:"int", width:60,
					hozAlign:"center", headerFilter:"input", headerSort:false,editor:true},
				{title:"ROWS*", field:"ord_row", sorter:"int", width:60,
					hozAlign:"center", headerFilter:"input", headerSort:false,editor:true},
				{title:"단가", field:"prod_dang", sorter:"int", width:80,
					hozAlign:"center", headerFilter:"input", headerSort:false},
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowClick:function(e, row){

				$("#tabuData .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#tabuData div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});

				var rowData = row.getData();
				
			},
		});		
	}
	
	var ipgoData = new Array();
	
	//입고저장
	function save(){
		//ipgoAddTable
		//tabuData
		console.log("저장버튼");
		console.log(ipgoData);
		
		if(ipgoData.length >= 1){
			
	//		var workSetDataSend = JSON.stringify(workSetTable.getData());
			
			var ordDate = $("#s_ord_date").val();
			
			var sendObj = {
					"ipgoData": ipgoData,
					"ordDate":ordDate
			}
			
			
			$.ajax({
				url:"/tkheat/product/ipgo/ipgoAdd",
				type:"post",
				contentType: false,
				processData: false,			
				dataType:"json",
				data:JSON.stringify(sendObj),
				success:function(result){
					console.log(result);
					
					ipgoData = new Array();
					closeBtn();
					getIpgoList();
				},error: function(xhr, status, status) {
					console.log(xhr);
					console.log(status);
					console.log(status);
	            }
			});
		}else{
			alert("입고등록할 제품을 선택하세요.");
		}
		
	}

	function orderPrintStatusCloseBtn(){
		orderPrintStatusModal.style.display = 'none'; // 모달 숨김
	}

	function orderReportCloseBtn(){
		orderReportModal.style.display = 'none'; // 모달 숨김
	}
	
//모달기능	
	const header = document.querySelector('.header'); // 헤더를 드래그할 요소로 사용
	const insertButton = document.querySelector('.insert-button');
	const ipgoModal = document.querySelector('.ipgoModal');
	const orderPrintStatusModal = document.querySelector('.orderPrintStatusModal');
	const orderReportModal = document.querySelector('.orderReportModal');
	const closeButton = document.querySelector('.close');

	
	header.addEventListener('mousedown', function(e) {
		// transform 제거를 위한 초기 위치 설정
		const rect = ipgoModal.getBoundingClientRect();
		ipgoModal.style.left = rect.left + 'px';
		ipgoModal.style.top = rect.top + 'px';
		ipgoModal.style.transform = 'none'; // 중앙 정렬 해제

		let offsetX = e.clientX - rect.left;
		let offsetY = e.clientY - rect.top;

		function moveModal(e) {
			ipgoModal.style.left = (e.clientX - offsetX) + 'px';
			ipgoModal.style.top = (e.clientY - offsetY) + 'px';
		}

		function stopMove() {
			window.removeEventListener('mousemove', moveModal);
			window.removeEventListener('mouseup', stopMove);
		}

		window.addEventListener('mousemove', moveModal);
		window.addEventListener('mouseup', stopMove);
	});


	insertButton.addEventListener('click', function() {
		getIpgoAddList();
		ipgoModal.style.display = 'block'; // 모달 표시
	});

	function closeBtn(){
		ipgoModal.style.display = 'none'; // 모달 숨김
	}


	

    </script>

	</body>
</html>
