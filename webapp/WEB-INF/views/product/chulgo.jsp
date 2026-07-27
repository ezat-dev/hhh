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
.tabulator {
	width: 100%;
	max-width: 100%;
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

#tabuData .tabulator-row.tabulator-selected,
#tabuData .tabulator-row.tabulator-selected.tabulator-row-even,
#tabuData .tabulator-row.tabulator-selected:hover {
	background-color: #FFD966 !important;
}

/* ========== 레이아웃 (세로 스크롤 방지) ========== */
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
.container {
	flex: 1;
	min-height: 0;
	display: flex;
	flex-direction: column;
	background: #ffffff;
	border: 1px solid #E2E8F0;
	border-radius: 10px;
	box-shadow: 0 1px 4px rgba(0,0,0,.06);
	padding: 8px;
	overflow: hidden;
}
#tab1.tabulator {
	flex: 1;
	min-height: 0;
	max-height: none;
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
#tab1 .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#tab1 .tabulator-row.row_select {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#tab1 .tabulator-cell {
	border: 1px solid #E2E8F0;
	color: #2D3748;
}
#tab1 .tabulator-footer {
	background: #F7FAFC;
	border-top: 1px solid #E2E8F0;
	padding: 8px 12px;
}
#tab1 .tabulator-page {
	border: 1px solid #E2E8F0;
	border-radius: 6px;
	background: #ffffff;
	color: #2D3748;
	min-width: 30px;
	height: 28px;
	padding: 0 8px;
	font-size: 12px;
	font-weight: 600;
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

.box1 {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}

/* ========== 상단 도구바 (다른 페이지 날짜검색/검색창과 통일) ========== */
.tab {
	background: #ffffff;
	border: 1px solid #E2E8F0;
	border-radius: 10px;
	box-shadow: 0 1px 4px rgba(0,0,0,.06);
	padding: 10px 14px;
}
.j_container {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}
.j_row {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}
.daylabel {
	font-size: 12px;
	font-weight: 600;
	color: #495057;
	white-space: nowrap;
}
/* nbsp로 간격 맞추던 옛 방식 대체 (gap이 대신 처리) */
.margin_left {
	margin-left: 0 !important;
}
.datetimepicker_date,
.search_input,
.search_select,
.box1 select,
.box1 input[type="text"],
.box1 input[type="number"],
.chulgoModal select,
.chulgoModal input[type="text"],
.chulgoModal input[type="number"] {
	height: 30px;
	padding: 0 8px;
	font-size: 12px !important;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	color: #333;
	outline: none;
	box-sizing: border-box;
	transition: border-color .2s ease, background-color .2s ease;
}
.datetimepicker_date:focus,
.search_input:focus,
.search_select:focus,
.box1 select:focus,
.box1 input:focus,
.chulgoModal select:focus,
.chulgoModal input:focus {
	border-color: #3182CE;
	background-color: #fff;
}
.datetimepicker_date {
	width: 100px !important;
	text-align: center;
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

/* ========== 모달 (management 쪽 모달과 동일한 톤) ========== */
.chulgoModal,
.chulgoPrintStatusModal,
.chulgoReportModal {
	position: fixed;
	top: 50%;
	left: 50%;
	display: none;
	transform: translate(-50%, -50%);
	z-index: 20010;
	border: none;
	border-radius: 12px;
	background-color: white;
	box-shadow: 0 10px 50px rgba(0,0,0,0.3);
	overflow: hidden;
}
.chulgoModal {
	width: 1600px;
	height: 750px;
	flex-direction: column;
}
.header {
	display: flex;
	justify-content: center;
	align-items: center;
	background: linear-gradient(135deg, #2c3e50, #34495e);
	height: 50px;
	color: white;
	font-size: 18px;
	font-weight: 700;
	text-align: center;
	cursor: move;
}
.chulgoModal .detail,
.chulgoPrintStatusModal .detail {
	background: #f5f7fa;
	padding: 10px 14px;
}
.chulgoModal .detail {
	flex: 1;
	min-height: 0;
	overflow-y: auto;
	overflow-x: hidden;
	display: flex;
	flex-direction: column;
	gap: 8px;
}
/* 목록(#tabuData)이 남는 세로공간을 모두 흡수하도록 하여, 검색줄 등 정적 콘텐츠
   때문에 생기던 모달 레벨의 불필요한 스크롤을 없앰. 행이 많아 넘칠 때는
   타뷸레이터가 자체적으로 스크롤을 보여줌(모달 레벨 스크롤과는 별개) */
.chulgoModal #tabuData{
	flex: 1;
	min-height: 0;
}
.chulgoPrintStatusModal {
	width: 390px;
	height: 200px;
}
.chulgoReportModal {
	width: 850px;
	height: 800px;
	flex-direction: column;
	padding: 14px;
	gap: 10px;
	box-sizing: border-box;
}
.chulgoPrintStatusModal .j_container[style*="justify-content:end"],
.chulgoReportModal .j_container[style*="justify-content:end"] {
	padding: 0 14px 14px;
}
.btnSaveClose {
	display: flex;
	justify-content: center;
	gap: 12px;
	padding: 14px 0;
	background: #ffffff;
	border-top: 1px solid #E2E8F0;
	margin: 0;
}
.btnSaveClose button {
	width: 100px;
	height: 36px;
	border: none;
	border-radius: 6px;
	font-weight: 700;
	text-align: center;
	cursor: pointer;
	line-height: 36px;
	margin: 0;
	transition: transform .2s ease, box-shadow .2s ease;
}
.btnSaveClose .save {
	background: linear-gradient(135deg, #51cf66, #37b24d);
	color: white;
}
.btnSaveClose .close {
	background: linear-gradient(135deg, #868e96, #495057);
	color: white;
	border: none;
}
.btnSaveClose .save:hover {
	background: linear-gradient(135deg, #40c057, #2f9e44);
	transform: translateY(-1px);
}
.btnSaveClose .close:hover {
	background: linear-gradient(135deg, #6c757d, #343a40);
	transform: translateY(-1px);
}

.chulgoModal .j_container {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}
.chulgoModal .j_row1 {
	display: flex;
	align-items: center;
	gap: 8px;
}

.j_h_div{
	width:130px;
}

.iRowBtn{
	display: inline-flex;
	align-items: center;
	justify-content: center;
	cursor:pointer;
	width:70px;
	height:32px;
	font-size:12px;
	font-weight: 600;
	border: 1px solid #E2E8F0;
	border-radius: 6px;
	background: #F0F4F8;
	color: #2D3748;
	transition: background-color .13s, border-color .13s;
}
.iRowBtn:hover {
	background: #EBF8FF;
	border-color: #BEE3F8;
}

.font_10pt{
	font-size:10pt;
	color: #718096;
}

.tabulator-col-title > input[type='checkbox']{
	width:20px;
	height:20px;
}

.tabulator-cell > input[type='checkbox']{
	width:20px;
	height:20px;
}

/* ========== 모달 내 리스트(#tabuData) ========== */
#tabuData.tabulator {
	border: 1px solid #E2E8F0;
	border-radius: 8px;
	font-size: 12px;
}
#tabuData .tabulator-header {
	background: linear-gradient(135deg, #2B6CB0, #3182CE);
	border-bottom: none;
}
#tabuData .tabulator-col {
	background: transparent;
	border-right: 1px solid rgba(255,255,255,.15);
}
#tabuData .tabulator-col-title {
	color: #ffffff;
	font-weight: 700;
}
#tabuData .tabulator-row {
	border-bottom: 1px solid #EDF2F7;
	transition: background-color .12s;
}
#tabuData .tabulator-row.tabulator-row-even {
	background-color: #F7FAFC;
}
#tabuData .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#tabuData .tabulator-cell {
	border: 1px solid #E2E8F0;
	color: #2D3748;
}
#tabuData .tabulator-footer {
	background: #F7FAFC;
	border-top: 1px solid #E2E8F0;
	padding: 6px 10px;
}
#tabuData .tabulator-page {
	border: 1px solid #E2E8F0;
	border-radius: 6px;
	background: #ffffff;
	color: #2D3748;
	min-width: 26px;
	height: 24px;
	padding: 0 6px;
	font-size: 11px;
	font-weight: 600;
}
#tabuData .tabulator-page.active {
	background: #3182CE;
	border-color: #2B6CB0;
	color: #ffffff;
}
#tabuData .tabulator-page:not(:disabled):hover {
	background: #EBF8FF;
	border-color: #BEE3F8;
	color: #2B6CB0;
	cursor: pointer;
}

</style>
<body>

	<div class="tab">
	<div class="box1">
		<label class="daylabel">일자</label>
		<input type="text" class="sdate datetimepicker_date" id="sdate" autocomplete="off">
		~
		<input type="text" class="edate datetimepicker_date" id="edate" autocomplete="off">

		<label class="daylabel">제품구분</label>
		<select id="prod_gubn">
			<option value="">전체</option>
			<option value="양산">양산</option>
			<option value="개발">개발</option>
		</select>

		<label class="daylabel">거래명세서 출력</label>
		<select id="report_type" style="width:140px;">
			<option value="1">거래명세서-일반</option>
			<option value="5">거래명세서-제품별</option>
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
	        <button class="delete" onclick="setChulgoDelete();">
	            <img src="/tkheat/css/image/delete-icon.png" alt="delete" class="button-image">
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
						<label class="font_10pt">*V표 선택을 한 제품만 출고 됩니다.</label>
						<label class="daylabel">출고일</label>
						<input type="text" class="och_date datetimepicker_date" id="och_date" style="width:120px;">
						<label class="daylabel">출고대기잔량</label>
						<input type="number" class="och_jan" id="och_jan" style="width:120px;" value="0">
						<label class="font_10pt">*단위가 EA일때만 적용됨</label>
						<label class="daylabel">입고일</label>
						<input type="text" class="ord_sdate datetimepicker_date" id="ord_sdate" style="width:120px;">
						~
						<input type="text" class="ord_edate datetimepicker_date" id="ord_edate" style="width:120px;">
						<button class="iRowBtn" style="width:80px;" type="button" onclick="getChulgoAddData();">조회</button>

						<input type="checkbox" id="och_calc" name="och_calc" class="iRowInput"
							style="width:30px !important;" checked/>
						<label for="" class="iRowLabel">자동계산</label>
					</div>
				</form>	
			</div>
			<div id="tabuData"></div>
		</div>

	    <div class="btnSaveClose">
			<button class="save" type="button" onclick="ochSave();">저장</button>
			<button class="close" type="button" onclick="window.close();">닫기</button>
		</div>
	</div>
<!-- 거래명세서-일반,A4, ...등등 출력중 모달 -->
<div class="chulgoPrintStatusModal">
	<div class="detail">
		<div class="header">
			<span style="display:inline-block; width:180px;" class="chulgoPrint1">거래명세서-일반</span>
			<span style="display:inline-block; width:180px;" class="chulgoPrint5">거래명세서-제품별</span>
		</div>
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<span style="display:inline-block; width:350px;" class="chulgoPrint1">거래명세서-일반 파일 생성중입니다....</span>
					<span style="display:inline-block; width:350px;" class="chulgoPrint5">거래명세서-제품별 파일 생성중입니다....</span>
					<br />
					<span style="display:inline-block; width:350px;">생성완료시 팝업창이 닫힙니다.</span>
				</div>
			</div>
		</div>
	</div>
	
	
	    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="orderPrintStatusClose iRowBtn margin_left" type="button" onclick="chulgoPrintStatusCloseBtn();">닫기</button>
		</div>
    </div>	
</div>

	
	<!-- 거래명세서 표현 모달 -->
	<div class="chulgoReportModal">
		<div class="j_container">
			<iframe src="" frameborder="0" width="800" height="700" id="chulgoReport">
			</iframe>	
		</div>
	    <div class="j_container" style="justify-content:end;">
	    	<div class="j_row1">
				<button class="chulgoReportClose iRowBtn margin_left" type="button" onclick="chulgoReportCloseBtn();">닫기</button>
			</div>
	    </div>
	</div>


	<script>
		//전역변수
		var cutumTable;

		//로드
		$(function() {
			var tdate = todayDate();

			var bforeWeek = beforeWeekDate();

			$("#sdate").val(tdate);
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
			//출력/저장/삭제 등으로 재조회되어도 체크박스 선택이 풀리지 않도록, 조회 전 선택된 항목을 기억해뒀다가 재조회 후 복원
			var selectedOchCodes = chulgoTable.getSelectedData().map(function(d){ return d.och_code; });

			$.ajax({
				url:"/tkheat/product/chulgo/getChulgoList",
				type:"post",
				dataType:"json",
				data:{
					"sdate" : $("#sdate").val(),
					"edate" : $("#edate").val(),
					"prod_gubn" : $("#prod_gubn").val()
				},success:function(result){
					chulgoTable.setData(result.data).then(function(){
						if(selectedOchCodes.length > 0){
							chulgoTable.getRows().forEach(function(row){
								if(selectedOchCodes.indexOf(row.getData().och_code) !== -1){
									row.select();
								}
							});
						}
					});
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

		
		var userEditing = false;
		var chulgoRowCalcState = new Map();
		var chulgoTable;
		function getChulgoList() {

			chulgoTable = new Tabulator("#tab1",{
				tableBuilt : function(){ this.redraw(true); },
				height : "100%",
				layout : "fitColumns",
				//체크박스는 formatter:"rowSelection"이 change 이벤트로 자체 처리함.
				//selectable:true(기본값)면 행 전체에 클릭리스너가 걸려 편집 가능한 셀(단가/비고 등)을 클릭만 해도 체크박스가 같이 토글됨.
				//"highlight"는 그 자동 토글만 막고 체크박스 자체 선택 동작은 그대로 유지함.
				selectable : "highlight", //로우 선택설정
				tooltips : true,
				selectableRangeMode : "click",
				reactiveData : true,
				headerHozAlign : "center",
				headerFilterPlaceholder: "",
				ajaxConfig : "POST",
				ajaxLoader : false,
				placeholder : "조회된 데이터가 없습니다.",
				pagination : "local",
				paginationSize : 20,
				paginationSizeSelector : [20,50,100,500,1000],
				paginationCounter : "rows",
				ajaxResponse : function(url, params, response) {
					$("#tab1 .tabulator-col.tabulator-sortable").css("height", "30px");
						return response; //return the response data to tabulator
				},
				cellEditing:function(cell){
					userEditing = true;
				},
			    cellEdited:function(cell){

			    	if(userEditing){
			    		var field = cell.getField();
						var rowData = cell.getRow().getData();
						
				        var prod_danw = rowData.prod_danw;           // 단위 (KG / EA / CH)
				        var och_su    = parseFloat(rowData.och_su)   || 0;  // 출고수량
				        var och_amnt  = parseFloat(rowData.och_amnt) || 0;  // 출고중량
				        var och_dang  = parseFloat(rowData.och_dang) || 0;  // 단가
				        var prod_danj = parseFloat(rowData.prod_danj) || 0; // 단중
						
				        // ① 출고수량 수정 → 출고중량, 금액 재계산
				        if (field === "och_su") {
				            var newAmnt = (och_su * prod_danj).toFixed(2);
				            var newMon  = (och_dang * och_su).toFixed(0);

				            isUpdating = true;
				            cell.getRow().getCell("och_amnt").setValue(newAmnt);
				            cell.getRow().getCell("och_mon").setValue(newMon);
				            isUpdating = false;
				        }
				        // ② 출고중량 수정 → 금액 재계산 (단위 KG일 때)
				        else if (field === "och_amnt") {
				            var newMon = (och_dang * och_amnt).toFixed(0);

				            isUpdating = true;
				            cell.getRow().getCell("och_mon").setValue(newMon);
				            isUpdating = false;
				        }
				        // ③ 단가 수정 → 금액 재계산
				        else if (field === "och_dang") {
				            // 단위에 따라 금액 기준 다름
				            var base   = (prod_danw === "KG") ? och_amnt : och_su;
				            var newMon = (och_dang * base).toFixed(0);

				            isUpdating = true;
				            cell.getRow().getCell("och_mon").setValue(newMon);
				            isUpdating = false;
				        }
				        // ④ 금액 직접 수정 → 단가 역산
				        else if (field === "och_mon") {
				            var base    = (prod_danw === "KG") ? och_amnt : och_su;
				            var newDang = (base !== 0) ? (parseFloat(rowData.och_mon) / base).toFixed(0) : 0;

				            isUpdating = true;
				            isUpdating = false;
				        }
			    		
			    		setChulgoUpdateData(cell.getRow().getData());
			    		
				        setTimeout(function() {
				            var nextRow = cell.getRow().getNextRow();
				            if (nextRow) {
				                var field = cell.getField(); // 현재 열 field명
				                var nextCell = nextRow.getCell(field);
				                nextCell.edit(true); // true = 즉시 편집모드 진입
				            }
				        }, 100); // setTimeout으로 현재 편집 완료 후 실행	
			    	}
			    },
				columns : [
			    	{formatter:"rowSelection", titleFormatter:"rowSelection", width:40, headerSort:false,
			    		cellClick:function(e, cell){
			    			cell.getRow().toggleSelect();
			    		}
			    	},
					{title : "NO",field : "idx",sorter : "int",width : 40,hozAlign : "center", headerSort:false}, 
					{title : "och_no",field : "och_no",sorter : "int",width : 40,hozAlign : "center", headerSort:false, visible:false}, 
					{title : "och_code",field : "och_code",sorter : "int",width : 40,hozAlign : "center", headerSort:false, visible:false}, 
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
					{title : "비고",field : "och_bigo",sorter : "int",width : 100,hozAlign : "center",
						headerFilter : "input", headerSort:false, editor:"input"
					},
					{title : "출력횟수",field : "och_prn",sorter : "int",width : 80,hozAlign : "center",
						headerFilter : "input", headerSort:false, visible:false
					},
				],
				rowFormatter : function(row) {
					var data = row.getData();
					row.getElement().style.fontWeight = "600";

				    if(data.och_prn == 0){
					    row.getElement().style.backgroundColor = "#FAED7D";
				    }else{
				    	row.getElement().style.backgroundColor = "#FFFFFF";
				    }
				},
				rowClick : function(e, row) {

				    // 모든 행 색상 초기화
				    $("#tab1 div.row_select").removeClass("row_select");

				    // 클릭한 행만 색상 변경
				    row.getElement().classList.add("row_select");
				    
				    e.stopPropagation();

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
				
//					getChulgoData();
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
				
		//출고등록(입고리스트) 모달
		function getChulgoAddList() {

			chulgoAddTable = new Tabulator("#tabuData",{
				tableBuilt : function(){ this.redraw(true); },
				height : "100%",
				layout : "fitColumns",
				tooltips : true,
				selectableRangeMode : "click",
				reactiveData : true,
				headerHozAlign : "center",
				headerFilterPlaceholder: "",
				ajaxConfig : "POST",
				ajaxLoader : false,
				placeholder : "조회된 데이터가 없습니다.",
				pagination : "local",
				paginationSize : 20,
				paginationSizeSelector : [20,50,100,500,1000],
				paginationCounter : "rows",
			    rowSelectionChanged:function(data, rows){
			    	userEditing = false;

			    	var currentRows = new Set(rows);

			    	//체크 해제된 행: 이전엔 계산이 적용되어 있었는데 지금은 선택 목록에서 빠짐 -> 출고대기잔량/마감월 원복
			    	chulgoRowCalcState.forEach(function(state, row){
			    		if(!currentRows.has(row)){
			    			var jan = parseFloat($("#och_jan").val()) || 0;
			    			$("#och_jan").val(jan + state.appliedSu);
			    			row.getCell("och_ma").setValue("");
			    			chulgoRowCalcState.delete(row);
			    		}
			    	});

			    	//새로 체크된 행에만 계산 적용 (이미 처리된 행은 건너뜀)
			    	rows.forEach(function(row){
			    		if(chulgoRowCalcState.has(row)){ return; }

			    		var rowData = row.getData();
			    		var jan = parseFloat($("#och_jan").val()) || 0;
			    		var appliedSu = 0;

			    		if(rowData.ord_danw == "EA"){
			    			if(jan == 0){
			    				var och_su = rowData.och_su;
			    				row.getCell("och_mon").setValue((och_su * rowData.ord_dang).toFixed(1));
			    				row.getCell("och_su").setValue(och_su);
			    				row.getCell("och_amnt").setValue((och_su * rowData.ord_danj).toFixed(1));
			    				$("#och_jan").val(0);
			    				appliedSu = 0;
			    			}else if(jan > rowData.och_su){
			    				var och_su = rowData.och_su;
			    				var jValue = jan - och_su;

			    				$("#och_jan").val(jValue);

			    				row.getCell("och_mon").setValue((och_su * rowData.ord_dang).toFixed(1));
			    				row.getCell("och_amnt").setValue((och_su * rowData.ord_danj).toFixed(1));
			    				appliedSu = och_su;
			    			}else{
			    				var jValue = jan;
			    				var och_su = jValue;
			    				row.getCell("och_mon").setValue((och_su * rowData.ord_dang).toFixed(1));
			    				row.getCell("och_su").setValue(jValue);
			    				row.getCell("och_amnt").setValue((och_su * rowData.ord_danj).toFixed(1));
			    				$("#och_jan").val(0);
			    				appliedSu = jValue;
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

			    		row.getCell("och_ma").setValue(och_ma.getFullYear()+"-"+paddingZero(och_ma.getMonth()+1));

			    		chulgoRowCalcState.set(row, { appliedSu: appliedSu });
			    	});
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
				{title:"품번", field:"prod_no", sorter:"string", width:70,
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
				{title:"비고", field:"och_bigo", sorter:"string", width:80,
				hozAlign:"center", headerFilter:"input", headerSort:false, editor:"input"},
				{title:"마감월", field:"och_ma", sorter:"int", width:60,
				hozAlign:"center", headerFilter:"input", headerSort:false},
				],
				rowFormatter : function(row) {
					row.getElement().style.fontWeight = "600";
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
		
	    function report(){
	    	
	    	if(chulgoTable.getSelectedData().length <= 0){
	    		alert("거래명세서를 출력할 제품을 선택하세요.");
	    		return false;
	    	}
	    	
			var chulgo_print_gb = $("#report_type").val();

			if(chulgo_print_gb == 1){
				$(".chulgoPrint1").css("display","inline-block");
				$(".chulgoPrint5").css("display","none");
			}else if(chulgo_print_gb == 5){
				$(".chulgoPrint1").css("display","none");
				$(".chulgoPrint5").css("display","inline-block");
			}
			
			chulgoPrintStatusModal.style.display = "block";
				
			var sendObj = {
				"chulgo_print_gb":chulgo_print_gb,
				"chulgoData": chulgoTable.getSelectedData()
			}
			
			$.ajax({
				url:"/tkheat/product/chulgo/chulgoReport",
				type:"post",
				contentType: false,
				processData: false,			
				dataType:"json",
				data:JSON.stringify(sendObj),
				success:function(result){
	   				var fileUrl = result.fileName;
                    $("#chulgoReport").attr("src",fileUrl);
                    chulgoReportModal.style.display = "flex";
					
                    chulgoPrintStatusCloseBtn();
					getChulgoData();
					
				},error: function(xhr, status, status) {
					console.log(xhr);
					console.log(status);
					console.log(status);
	            }
			});

	    }

	    
	    function setChulgoDelete(){
	    	if(!confirm("선택한 출고항목을 삭제하시겠습니까?")){
	    		return false;
	    	}
	    	
	    	var deleteData = chulgoTable.getSelectedData();
	    	
			if(deleteData.length <= 0){
				alert("삭제할 항목을 선택하세요.");
				return false;
			}
			
			var sendObj = {
				"chulgoData": deleteData
			}
			
			$.ajax({
				url:"/tkheat/product/chulgo/chulgoDelete",
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
		
		function closeBtn(){
			chulgoModal.style.display = 'none'; // 모달 숨김
		}

		function chulgoPrintStatusCloseBtn(){
			chulgoPrintStatusModal.style.display = 'none'; // 모달 숨김
		}

		function chulgoReportCloseBtn(){
			chulgoReportModal.style.display = 'none'; // 모달 숨김
		}
		
		//모달기능	
		const header = document.querySelector('.header'); // 헤더를 드래그할 요소로 사용
		const insertButton = document.querySelector('.insert-button');
		const chulgoModal = document.querySelector('.chulgoModal');
		const closeButton = document.querySelector('.close');
		const chulgoPrintStatusModal = document.querySelector('.chulgoPrintStatusModal');
		const chulgoReportModal = document.querySelector('.chulgoReportModal');

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
			chulgoModal.style.display = 'flex'; // 모달 표시
		});

		closeButton.addEventListener('click', function() {
			chulgoModal.style.display = 'none'; // 모달 숨김
		});
	</script>

</body>
</html>
