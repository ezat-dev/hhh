<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>출고관리</title>
<link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
<link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp"%>
<style>
.main {
	width: 98%;
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

.row_select {
	background-color: #9ABCEA !important;
}


.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -620px;
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


.chulgoModal {
	position: fixed; /* 화면에 고정 */
	width:1600px;
	height:750px;	
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

.j_container{
	display:flex;
/*	border-radius: 6px;
    border: 1px solid gray*/	
}

.j_row1{
	display:flex;
	margin-top:1px;
}


.iRowHLabel{
	display:block;
	width:120px;
	height:28px;
	text-align:center;
	margin-bottom:2px;
	font-size:12pt;
}

.iRowHInput{
	display:block;
	width:120px !important;
	height:28px;
	font-size:12pt;
	text-align:center;
}

.iRowBtn{
	display:block;
	cursor:pointer;
	width:128px !important;
	height:29px;
	font-size:12pt;
}

.font_10pt{
	font-size:10pt;
}

.margin_left{
	margin-left:5px;
}

</style>
<body>

	<div class="tab">
	<div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
        
		<label class="daylabel">일자 : </label>
		<input type="text" class="sdate datetimepicker_date" id="sdate" style="font-size: 16px;" autocomplete="off"> ~ 
		<input type="text" class="edate datetimepicker_date" id="edate" style="font-size: 16px;" autocomplete="off">
		
		<label class="daylabel">제품구분 : </label>
		<select id="prod_gubn">
			<option value="">전체</option>
			<option value="양산">양산</option>
			<option value="개발">개발</option>
		</select>
		
		<label class="daylabel">거래명세서 출력 : </label>
		<select id="report_type">
			<option value="거래명세서-일반">거래명세서-일반</option>
			<option value="거래명세서-A4">거래명세서-A4</option>
			<option value="거래명세서-일반_2">거래명세서-일반_2</option>
			<option value="거래명세서-A4_2">거래명세서-A4_2</option>
			<option value="거래명세서-제품별">거래명세서-제품별</option>
		</select>
			
	</div>

		<div class="button-container">
			<button class="select-button" onclick="getChulgoData();">
				<img src="/tkheat/css/image/search-icon.png" alt="select"
					class="button-image">

			</button>
			<button class="insert-button">
				<img src="/tkheat/css/image/insert-icon.png" alt="insert"
					class="button-image">

			</button>
			<button class="excel-button">
				<img src="/tkheat/css/image/excel-icon.png" alt="excel"
					class="button-image">

			</button>
			<button class="printer-button">
				<img src="/tkheat/css/image/printer-icon.png" alt="printer"
					onclick="report();"
					class="button-image">

			</button>
		</div>
	</div>
	<main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>


	<div class="chulgoModal">
		<div class="detail">
			<div class="header">출고등록</div>
			<div class="j_container">
				<form autocomplete="off">
					<div class="j_container">
						<label class="font_10pt">*V표 선택을 한 제품만 출고 됩니다.&nbsp;</label>
						<label for="">출고일 :</label>
						<input type="text" class="och_date datetimepicker_date" id="och_date" style="font-size: 12pt; width:120px;">
						<label class="font_10pt">&nbsp;&nbsp;출고대기잔량 :</label>
						<input type="number" class="och_jan" id="och_jan" style="font-size: 12pt; width:120px;" value="0">
						<label class="font_10pt">&nbsp;&nbsp;*단위가 EA일때만 적용됨&nbsp;&nbsp;</label>
						<label class="margin_left">입고일 :</label>
						<input type="text" class="ord_sdate datetimepicker_date" id="ord_sdate" style="font-size: 12pt; width:120px;">
						~
						<input type="text" class="ord_edate datetimepicker_date" id="ord_edate" style="font-size: 12pt; width:120px;">&nbsp;&nbsp;
						<button class="iRowBtn margin_left" style="width:80px !important;" type="button" onclick="getChulgoAddData();">조회</button>
						
						<input type="checkbox" id="och_calc" name="och_calc" class="iRowInput"
							style="width:30px !important;" checked/>
						<label for="" class="iRowLabel">자동계산</label>
										
					</div>
				</form>	
			</div>
			<div id="tabuData"></div>
		</div>

	    <div class="j_container" style="justify-content:end;">
	    	<div class="j_row1">	
				<button class="save iRowBtn margin_left" type="button" onclick="ochSave();">저장</button>
				<button class="close iRowBtn margin_left" type="button" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>


	<script>
		//전역변수
		var cutumTable;

		//로드
		$(function() {
			var tdate = todayDate();
			var ydate = yesterDate();

			var bforeWeek = beforeWeekDate();
			
			$("#sdate").val(ydate);
			$("#edate").val(tdate);
			
			
			$("#ord_sdate").val(bforeWeek);
			$("#ord_edate").val(tdate);
			$("#och_date").val(tdate);
			
			
			getChulgoData();
			getChulgoList();
		});

		//이벤트
		//함수
		
		function getChulgoData(){
			$.ajax({
				url:"/tkheat/product/chulgo/getChulgoList",
				type:"post",
				dataType:"json",
				data:{
					"sdate" : $("#sdate").val(),
					"edate" : $("#edate").val(),
					"prod_gubn" : $("#prod_gubn").val()					
				},success:function(result){
					chulgoTable.setData(result.data);
				}
			});
		}
		
		var dateEditor = function(cell, onRendered, success, cancel){
		    //cell - the cell component for the editable cell
		    //onRendered - function to call when the editor has been rendered
		    //success - function to call to pass thesuccessfully updated value to Tabulator
		    //cancel - function to call to abort the edit and return to a normal cell

		    //create and style input
		    var cellValue = cell.getValue();
		    
		    input = document.createElement("input");

		    
		    input.setAttribute("type", "text");
		    input.className = "datetimepicker_date";

		    input.style.padding = "4px";
		    input.style.width = "100%";
		    input.style.boxSizing = "border-box";

		    input.value = cellValue;

		    onRendered(function(){
		    	datePickerDate();   	
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
		
		var monthEditor = function(cell, onRendered, success, cancel){
		    //cell - the cell component for the editable cell
		    //onRendered - function to call when the editor has been rendered
		    //success - function to call to pass thesuccessfully updated value to Tabulator
		    //cancel - function to call to abort the edit and return to a normal cell

		    //create and style input
		    var cellValue = cell.getValue();
		    
		    input = document.createElement("input");

		    
		    input.setAttribute("type", "text");
		    input.className = "datetimepicker_month";

		    input.style.padding = "4px";
		    input.style.width = "100%";
		    input.style.boxSizing = "border-box";

		    input.value = cellValue;

		    onRendered(function(){
		    	datePickerMonth();   	
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

		
	var chulgoTable;
	function getChulgoList() {

		chulgoTable = new Tabulator("#tab1",{
			height : "750px",
			layout : "fitColumns",
			selectable : true, //로우 선택설정
			tooltips : true,
			selectableRangeMode : "click",
			reactiveData : true,
			headerHozAlign : "center",
			ajaxConfig : "POST",
			ajaxLoader : false,
			placeholder : "조회된 데이터가 없습니다.",
			paginationSize : 20,
			headerFilterPlaceholder: "",
			ajaxResponse : function(url, params, response) {
				$("#tab1 .tabulator-col.tabulator-sortable").css("height", "30px");
					return response; //return the response data to tabulator
			},
		    cellEditing:function(cell){
		    	userEditing = true;
		    },
		    cellEdited:function(cell){
		    	
		    	
		    	
		    	if(userEditing){
					var rowData = cell.getRow().getData();
					var och_su = rowData.och_sh;
					var och_amnt = rowData.amnt;
					var och_mon = rowData.och_mon;
					//add 모달에는 있는데 리스트에는 없어서 주석처리(26-02-10)
				/*
		    		if(cell.getField() == "och_su"){
		    			if(rowData.ord_danw == "KG"){
							alert("단위가 KG일때는 중량만 수정 가능합니다.");
							cell.getRow().getCell("och_su").setValue(rowData.jaego_su);
							return false;			    				
		    			}else{
							if(rowData.jaego_su < cell.getValue()){
								alert("입고수보다 큽니다");
								cell.getRow().getCell("och_su").setValue(rowData.jaego_su);
								return false;
							}			    				
		    			}							
					}else if(cell.getField() == "och_amnt"){
						if(rowData.ord_danw != "KG"){
							alert("단위가 EA,CH일때는 수량만 수정 가능합니다.");
							cell.getRow().getCell("och_amnt").setValue(rowData.jaego_amnt);
							return false;
						}else{
							if(rowData.jaego_amnt < cell.getValue()){
								alert("입고중량보다 큽니다");
								cell.getRow().getCell("och_amnt").setValue(rowData.jaego_amnt);
								return false;
							}
						}							
					}
		    		*/
		    		
		    		och_mon = ( Number(rowData.och_dang) * ((rowData.prod_danw=="KG")? Number(rowData.och_amnt) : Number(rowData.och_su)) ).toFixed(0);
		    		cell.getRow().getCell("och_mon").setValue(och_mon);
		    		
		    		setChulgoUpdateData(cell.getRow().getData());
		    	}
		    },
			columns : [
				{title : "NO",field : "idx",sorter : "int",width : 40,hozAlign : "center", headerSort:false}, 
				{title : "och_no",field : "och_no",sorter : "int",width : 40,hozAlign : "center", headerSort:false, visible:false}, 
				{title : "출력",field:"och_prn",sorter:"string",width:40,hozAlign:"center",headerFilter:"input", headerSort:false},
				{title : "입고일",field : "ord_date",sorter : "string",width : 80,hozAlign : "center",headerFilter : "input", headerSort:false}, 
				{title : "출고일",field : "och_date",sorter : "string",width : 80,hozAlign : "center",
					headerFilter : "input", headerSort:false, editor:dateEditor
				}, 
				{title : "수주수량",field : "ord_su",sorter : "int",width : 100,hozAlign : "center",
					headerFilter : "input", headerSort:false, visible:false}, 
				{title : "수주No",field : "ord_code",sorter : "string",width : 100,hozAlign : "center",
					headerFilter : "input", headerSort:false}, 
				{title : "거래처",field : "corp_name",sorter : "string",width : 120,hozAlign : "center",
						headerFilter : "input", headerSort:false}, 
				{title : "품명",field : "prod_name",sorter : "string",width : 100,hozAlign : "center",
						headerFilter : "input", headerSort:false}, 
				{title : "품번",field : "prod_no",sorter : "string",width : 100,hozAlign : "center",
						headerFilter : "input", headerSort:false}, 
				{title : "재질",field : "prod_jai",sorter : "string",width : 100,hozAlign : "center",
						headerFilter : "input", headerSort:false}, 
				{title : "규격",field : "prod_gyu",sorter : "int",width : 100,hozAlign : "center",
						headerFilter : "input", headerSort:false}, 
				{title : "공정",field : "tech_te",sorter : "int",width : 100,hozAlign : "center",
						headerFilter : "input", headerSort:false}, 
				{title : "입고/타각LOT",field : "och_lot",sorter : "int",width : 100,hozAlign : "center",
						headerFilter : "input", headerSort:false}, 
				{title : "단위",field : "prod_danw",sorter : "int",width : 40,hozAlign : "center",
						headerFilter : "input", headerSort:false}, 
				{title : "출고수량",field : "och_su",sorter : "int",width : 50,hozAlign : "center",
						headerFilter : "input", headerSort:false, editor:"input"
				}, 
				{title : "출고중량",field : "och_amnt",sorter : "int",width : 50,hozAlign : "center",
						headerFilter : "input", headerSort:false, editor:"input"
				}, 
				{title : "금액",field : "och_mon",sorter : "int",width : 60,hozAlign : "center",
					headerFilter : "input", headerSort:false, editor:"input"
				}, 
				{title : "단가",field : "och_dang",sorter : "int",width : 50,hozAlign : "center",
					headerFilter : "input", headerSort:false, editor:"input"
				}, 
				{title : "단중",field : "prod_danj",sorter : "int",width : 50,hozAlign : "center",
					headerFilter : "input", headerSort:false}, 
				{title : "마감월",field : "och_ma",sorter : "string",width : 80,hozAlign : "center",
						headerFilter : "input", headerSort:false, editor:monthEditor
				}, 
				{title : "비고",field : "och_bigo",sorter : "int",width : 80,hozAlign : "center",
					headerFilter : "input", headerSort:false, editor:"input"
				},
			],
			rowFormatter : function(row) {
				var data = row.getData();

				row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowClick : function(e, row) {

			$("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(
				function(index, item) {

					if ($(this).hasClass("row_select")) {
						$(this).removeClass('row_select');
							row.getElement().className += " row_select";
					} else {
						$("#tab1 div.row_select").removeClass("row_select");
							row.getElement().className += " row_select";
					}
				});

				var rowData = row.getData();

			},
		});
	}

	function setChulgoUpdateData(rowData){
		
		var sendObj = {
			"chulgoData": rowData
		}
		
		$.ajax({
			url:"/tkheat/product/chulgo/chulgoUpdate",
			type:"post",
			contentType: false,
			processData: false,			
			dataType:"json",
			data:JSON.stringify(sendObj),
			success:function(result){
				getChulgoData();
			},error: function(xhr, status, status) {
				console.log(xhr);
				console.log(status);
				console.log(status);
            }
		});

		
	}


		function getChulgoAddData(){
			var sdate = $("#ord_sdate").val();
			var edate = $("#ord_edate").val();
			
			$("#och_calc").prop("checked",true);
			
			$.ajax({
				url:"/tkheat/product/chulgo/getChulgoAddList",
				type:"post",
				dataType:"json",
				data:{
					"sdate":sdate,
					"edate":edate
				},
				success:function(result){
					chulgoAddTable.setData(result.data);
				}
			});
		}
		
		let userEditing = false;
		
		//출고등록(입고리스트) 모달
		function getChulgoAddList() {

			chulgoAddTable = new Tabulator("#tabuData",{
				height : "550px",
				layout : "fitColumns",
				tooltips : true,
				selectableRangeMode : "click",
				reactiveData : true,
				headerHozAlign : "center",
				ajaxConfig : "POST",
				ajaxLoader : false,
				placeholder : "조회된 데이터가 없습니다.",
				paginationSize : 20,
				headerFilterPlaceholder: "",
			    rowSelectionChanged:function(data, rows){
			    	if(data.length != 0){
			        	
			        	userEditing = false;
			        	var jan = $("#och_jan").val();
			        	var rowData = data[data.length-1];
			        	
			        	
			        	if(rowData.ord_danw == "EA"){
			        		if(jan == 0){
			        			var och_su = rowData.och_su;
			        			rows[rows.length-1].getCell("och_mon").setValue((och_su * rowData.ord_dang).toFixed(1));
			        			rows[rows.length-1].getCell("och_su").setValue(och_su);
			        			rows[rows.length-1].getCell("och_amnt").setValue((och_su * rowData.ord_danj).toFixed(1));
			        			$("#och_jan").val(0);			        			
			        		}else if(jan > rowData.och_su){
			        			var och_su = rowData.och_su;
			        			var jValue = jan - och_su;
			        			
			        			$("#och_jan").val(jValue);
			        			
			        			rows[rows.length-1].getCell("och_mon").setValue((och_su * rowData.ord_dang).toFixed(1));
			        			rows[rows.length-1].getCell("och_amnt").setValue((och_su * rowData.ord_danj).toFixed(1));
			        		}else{
			        			var jValue = jan;
			        			var och_su = jValue;
			        			rows[rows.length-1].getCell("och_mon").setValue((och_su * rowData.ord_dang).toFixed(1));
			        			rows[rows.length-1].getCell("och_su").setValue(jValue);
			        			rows[rows.length-1].getCell("och_amnt").setValue((och_su * rowData.ord_danj).toFixed(1));
			        			$("#och_jan").val(0);
			        		}
			        	}
			        	
			        	//마감월 지정
			        	var now = new Date();
			        	var magam_date = new Date();
			        	var och_ma;
			        	var och_date1 = $("#och_date").val();
			        	
			        	if(rowData.corp_gyul2 == null || rowData.corp_gyul2 == ""){
			        		magam_date = new Date(now.getFullYear(), now.getMonth(), 1);
			        	}else{
			        		magan_date = new Date(now.getFullYear(), now.getMonth(), rowData.corp_gyul2);
			        	}
			        	
			        	if(rowData.corp_gyul2 == null || rowData.corp_gyul2 == ""){
			        		/*거래처 마감일의 값이 없을 경우, 출고일을 마감일로 설정*/
			        		och_ma = new Date(och_date1);
			        	}else{
			        		if(och_date1 <= magam_date){
			        			/*거래처 등록에 저장된 값이 31인 경우에 한하여, 31일이 없는 달은 그냥 30일로 생각하고 현재 달을 입력.*/
			        			och_ma = new Date(now);
			        		}else if(och_date1 > magam_date && now.getMonth() == 11){
								/*출고일 > 마감일이면서 마감월이 12일 경우, 한달을 더해줄때 다음년도 1월이 되니까 년도를 다음년도로 세팅해줘야함*/
								now.setFullYear(now.getFullYear()+1);
								now.setMonth(0); /*참고사항: new date().format으로 하면 달이 정상적으로 찍히는데 꼭 getMonth로만 가져오면 변수에 넣어주면 0~11로 표시됨*/
								och_ma = new Date(now);
			        		}else{
								/*거래처 마감일 < 출고날짜 일 경우, 현재달에서 +1해서 마감월을 세팅*/
								now.setMonth(now.getMonth()+1);
								och_ma = new Date(now);			        			
			        		}
			        	}
			        	
			        	
			        	rows[rows.length-1].getCell("och_ma").setValue(och_ma.getFullYear()+"-"+paddingZero(och_ma.getMonth()+1));
			        	
			    	}
			    },
			    cellEditing:function(cell){
			    	userEditing = true;
			    },
			    cellEdited:function(cell){
			    	
			    	if(userEditing){
						var autoCalc = $("#och_calc").is(":checked");
						var rowData = cell.getRow().getData();
						var och_su = 0;
						var och_amnt = 0;
						var och_mon = 0;
						
						
						
						if(autoCalc){
				    		if(cell.getField() == "och_su"){
				    			if(rowData.ord_danw == "KG"){
									alert("단위가 KG일때는 중량만 수정 가능합니다.");
									cell.getRow().getCell("och_su").setValue(rowData.jaego_su);
									return false;			    				
				    			}else{
									if(rowData.jaego_su < cell.getValue()){
										alert("입고수보다 큽니다");
										cell.getRow().getCell("och_su").setValue(rowData.jaego_su);
										return false;
									}			    				
				    			}							
							}else if(cell.getField() == "och_amnt"){
								if(rowData.ord_danw != "KG"){
									alert("단위가 EA,CH일때는 수량만 수정 가능합니다.");
									cell.getRow().getCell("och_amnt").setValue(rowData.jaego_amnt);
									return false;
								}else{
									if(rowData.jaego_amnt < cell.getValue()){
										alert("입고중량보다 큽니다");
										cell.getRow().getCell("och_amnt").setValue(rowData.jaego_amnt);
										return false;
									}
								}							
							}
				    		
				    		if(cell.getField() == "och_su"){
				    			och_amnt = (rowData.ord_danj * cell.getValue()).toFixed(2);			    			
				    		}else if(cell.getField() == "och_amnt"){
				    			och_su = (rowData.och_amnt / rowData.ord_danj).toFixed(0);
				    		}
				    		
				    		if(cell.getField() == "och_mon"){
				    			return false;
				    		}else{
				    			och_mon = ( Number(rowData.ord_dang) * ((rowData.ord_danw=="KG")? Number(rowData.och_amnt) : Number(rowData.och_su)) ).toFixed(0);
				    			cell.getRow().getCell("och_mon").setValue(och_mon);
				    		}
				    	}
			    	}
			    },
				ajaxResponse : function(url, params, response) {
					$("#tabuData .tabulator-col.tabulator-sortable").css("height", "55px");
						return response; //return the response data to tabulator
				},
				columns:[
			    {formatter:"rowSelection", titleFormatter:"rowSelection", width:40, headerSort:false,
			    	cellClick:function(e, cell){
			    		
			    	}
			    },
				{title:"입고코드", field:"ord_code", sorter:"string", width:80,
				hozAlign:"center", headerFilter:"input", headerSort:false},	
				{title:"입고일", field:"ord_date", sorter:"string", width:80,
				hozAlign:"center", headerFilter:"input"},
				{title:"거래처", field:"corp_name", sorter:"string", width:100,
				hozAlign:"center", headerFilter:"input", headerSort:false}, 
				{title:"품명", field:"prod_name", sorter:"string", width:100,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"품번", field:"prod_no", sorter:"string", width:100,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"재질", field:"prod_jai", sorter:"string", width:80,
				hozAlign:"center", headerFilter:"input", headerSort:false},  	
				{title:"규격", field:"prod_gyu", sorter:"string", width:80,
				hozAlign:"center", headerFilter:"input", headerSort:false},	
				{title:"공정", field:"tech_te", sorter:"string", width:60,
				hozAlign:"center", headerFilter:"input", headerSort:false},	
				{title:"입고/타각LOT", field:"ord_lot", sorter:"string", width:70,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"단위", field:"ord_danw", sorter:"string", width:40,
				hozAlign:"center", headerFilter:"input", headerSort:false},	
				{title:"단가", field:"ord_dang", sorter:"int", width:50,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"단중", field:"ord_danj", sorter:"int", width:50,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"입고수", field:"ord_su", sorter:"int", width:50,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"입고중량", field:"ord_amnt", sorter:"int", width:50,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"생산수", field:"ilbo_su", sorter:"int", width:50,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"생산중량", field:"ilbo_jung", sorter:"int", width:50,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"재고수", field:"jaego_su", sorter:"int", width:50,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"재고중량", field:"jaego_jung", sorter:"int", width:60,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"출고수", field:"och_su", sorter:"int", width:50,
				hozAlign:"center", headerFilter:"input", headerSort:false, editor:"input"
				},
				{title:"출고중량", field:"och_amnt", sorter:"int", width:60,
				hozAlign:"center", headerFilter:"input", headerSort:false, editor:"input"
				},
				{title:"금액", field:"och_mon", sorter:"int", width:80,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"비고", field:"och_bigo", sorter:"int", width:100,
				hozAlign:"center", headerFilter:"input", headerSort:false, editor:"input"},
				{title:"마감월", field:"och_ma", sorter:"int", width:60,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				],
				rowFormatter : function(row) {
					var data = row.getData();

					row.getElement().style.fontWeight = "700";
					row.getElement().style.backgroundColor = "#FFFFFF";
				},
				rowClick : function(e, row) {

					$("#tabuData .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(
						function(index, item) {
						if ($(this).hasClass("row_select")) {
							$(this).removeClass('row_select');
							row.getElement().className += " row_select";
						} else {
							$("#tabuData div.row_select").removeClass("row_select");
							row.getElement().className += " row_select";
						}
					});

					var rowData = row.getData();

				},
			});
		}
		
		
		function ochSave(){
			if(chulgoAddTable.getSelectedData().length > 0){

				var ochDate = $("#och_date").val();
				
				var sendObj = {
					"chulgoData": chulgoAddTable.getSelectedData(),
					"ochDate":ochDate
				}
				
				console.log(sendObj);
				
				$.ajax({
					url:"/tkheat/product/chulgo/chulgoAdd",
					type:"post",
					contentType: false,
					processData: false,			
					dataType:"json",
					data:JSON.stringify(sendObj),
					success:function(result){
						closeBtn();
						getChulgoData();
					},error: function(xhr, status, status) {
						console.log(xhr);
						console.log(status);
						console.log(status);
		            }
				});
			}else{
				alert("출고등록할 제품을 선택하세요.");
			}
		}
		
	    function report() {
	        if ($("#reportType").val() == "거래명세서-일반") {
	            var ochNoList = jQuery(maingrid).jqGrid('getGridParam', 'selarrrow');
	            if (ochNoList == "") ochNoList = jQuery(maingrid).jqGrid('getDataIDs');

	            setPlusOCH_PRN(ochNoList);
	            changeColorGridRowCheckPrintReport();

	            var url = "TradePortfolioChulgo3?ochNoList=" + ochNoList;
	            var mywin = window.open(url, '_win', 'toolbar=yes,location=no,status=yes,menubar=yes,scroll bars=yes,resizable=yes,width=1000,height=800,top=0,left =100');
	            mywin.focus();

	        } else if ($("#reportType").val() == "거래명세서-A4") {
	            if (confirm("보고서를 출력하시겠습니까?")) {
	                var ochNoList = jQuery(maingrid).jqGrid('getGridParam', 'selarrrow');
	                if (ochNoList == "") ochNoList = jQuery(maingrid).jqGrid('getDataIDs');

	                setPlusOCH_PRN(ochNoList);
	                changeColorGridRowCheckPrintReport();

	                var url = "tradePortfolio3A4?ochNoList=" + ochNoList;
	                var mywin = window.open(url, '_win', 'toolbar=yes,location=no,status=yes,menubar=yes,scroll bars=yes,resizable=yes,width=1000,height=800,top=0,left =100');
	                mywin.focus();
	            } else {
	                jAlert('출력이 취소되었습니다.');
	            }
	        } else if ($("#reportType").val() == "거래명세서-일반_2") {
	            if (confirm("보고서를 출력하시겠습니까?")) {
	                var ochNoList = jQuery(maingrid).jqGrid('getGridParam', 'selarrrow');
	                if (ochNoList == "") ochNoList = jQuery(maingrid).jqGrid('getDataIDs');

	                setPlusOCH_PRN(ochNoList);
	                changeColorGridRowCheckPrintReport();

	                var url = "TradePortfolioChulgo3_2?ochNoList=" + ochNoList;
	                var mywin = window.open(url, '_win', 'toolbar=yes,location=no,status=yes,menubar=yes,scroll bars=yes,resizable=yes,width=1000,height=800,top=0,left =100');
	                mywin.focus();
	            } else {
	                jAlert('출력이 취소되었습니다.');
	            }
	        } else if ($("#reportType").val() == "거래명세서-A4_2") {
	            if (confirm("보고서를 출력하시겠습니까?")) {
	                var ochNoList = jQuery(maingrid).jqGrid('getGridParam', 'selarrrow');
	                if (ochNoList == "") ochNoList = jQuery(maingrid).jqGrid('getDataIDs');

	                setPlusOCH_PRN(ochNoList);
	                changeColorGridRowCheckPrintReport();

	                var url = "tradePortfolio3A4_2?ochNoList=" + ochNoList;
	                var mywin = window.open(url, '_win', 'toolbar=yes,location=no,status=yes,menubar=yes,scroll bars=yes,resizable=yes,width=1000,height=800,top=0,left =100');
	                mywin.focus();
	            } else {
	                jAlert('출력이 취소되었습니다.');
	            }
	        } else if ($("#reportType").val() == "거래명세서-제품별")
	        {
	            var ochNoList = jQuery(maingrid).jqGrid('getGridParam', 'selarrrow');
	            if (ochNoList == "") ochNoList = jQuery(maingrid).jqGrid('getDataIDs');

	            setPlusOCH_PRN(ochNoList);
	            changeColorGridRowCheckPrintReport();

	            var url = "TradePortfolioChulgo_prod?ochNoList=" + ochNoList;
	            var mywin = window.open(url, '_win', 'toolbar=yes,location=no,status=yes,menubar=yes,scroll bars=yes,resizable=yes,width=1000,height=800,top=0,left =100');
	            mywin.focus();
	        }
	    }

		
		function closeBtn(){
			chulgoModal.style.display = 'none'; // 모달 숨김
		}
		
		//모달기능	
		const header = document.querySelector('.header'); // 헤더를 드래그할 요소로 사용
		const insertButton = document.querySelector('.insert-button');
		const chulgoModal = document.querySelector('.chulgoModal');
		const closeButton = document.querySelector('.close');

		header.addEventListener('mousedown', function(e) {
			// transform 제거를 위한 초기 위치 설정
			const rect = chulgoModal.getBoundingClientRect();
			chulgoModal.style.left = rect.left + 'px';
			chulgoModal.style.top = rect.top + 'px';
			chulgoModal.style.transform = 'none'; // 중앙 정렬 해제

			let offsetX = e.clientX - rect.left;
			let offsetY = e.clientY - rect.top;

			function moveModal(e) {
				chulgoModal.style.left = (e.clientX - offsetX) + 'px';
				chulgoModal.style.top = (e.clientY - offsetY) + 'px';
			}

			function stopMove() {
				window.removeEventListener('mousemove', moveModal);
				window.removeEventListener('mouseup', stopMove);
			}

			window.addEventListener('mousemove', moveModal);
			window.addEventListener('mouseup', stopMove);
		});

		insertButton.addEventListener('click', function() {
			getChulgoAddList();
			chulgoModal.style.display = 'block'; // 모달 표시
		});

		closeButton.addEventListener('click', function() {
			chulgoModal.style.display = 'none'; // 모달 숨김
		});
	</script>

</body>
</html>
