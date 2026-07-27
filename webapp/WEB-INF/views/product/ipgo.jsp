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
	width:100%;
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

/* ========== 레이아웃 (세로 스크롤 방지) ========== */
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
.container {
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
#tab1.tabulator {
	flex: 1;
	min-height: 0;
	max-height: none;
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
	row-gap: 6px;
}

.box1 input{
	font-size:12pt;
}
.box1 select{
	font-size:12pt;
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
.search_margin_left,
.margin_left {
	margin-left: 0 !important;
}
.datetimepicker_date,
.search_input,
.search_select,
.box1 select,
.box1 input[type="text"],
.box1 input[type="number"] {
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
.box1 input:focus {
	border-color: #3182CE;
	background-color: #fff;
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
.ipgoModal,
.orderPrintStatusModal,
.orderReportModal {
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
.ipgoModal .detail,
.orderPrintStatusModal .detail {
	background: #f5f7fa;
	padding: 10px 14px;
}
.orderReportModal {
	flex-direction: column;
	padding: 14px;
	gap: 10px;
	box-sizing: border-box;
}
.orderPrintStatusModal .j_container[style*="justify-content:end"],
.orderReportModal .j_container[style*="justify-content:end"] {
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

/*입고등록 모달*/
.ipgoModal{
	width:1400px;
	height:745px;
	flex-direction: column;
}

.ipgoModal .detail {
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
.ipgoModal #tabuData{
	flex: 1;
	min-height: 0;
}

.ipgoModal .j_container{
	display:flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}

.ipgoModal .j_row1{
	display:flex;
	align-items: center;
	gap: 8px;
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

.ipgoModal .iRowBtn2{
	display:block;
	cursor:pointer;
	width:120px;
	height:30px;
	font-size:12pt;
}

.ipgoModal .iRowLabel{
	display:block;
	width:120px;
	height:20px;
	text-align:center;
	margin-bottom:2px;
	font-size:12pt;
}

.ipgoModal .iRowLabel2{
	display:block;
	width:120px;
	height:24px;
	text-align:left;
	margin-bottom:7px;
	font-size:12pt;
	margin-left:10px;
}

.ipgoModal .iRowInput{
	/*display:flex;*/
	width:120px !important;
	height:20px;
	font-size:12pt;
	text-align:center;
}

.ipgoModal .iRowInput2{
	display:block;
	width:120px !important;
	height:20px;
	font-size:12pt;
	text-align:center;
	margin-bottom:5px;
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

/* 저장/닫기 버튼 호버 시 */
.btnSaveClose .save:hover {
	background: linear-gradient(135deg, #40c057, #2f9e44);
	transform: translateY(-1px);
}
.btnSaveClose .close:hover {
	background: linear-gradient(135deg, #6c757d, #343a40);
	transform: translateY(-1px);
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
	width:390px;
	height:200px;
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
	width:850px;
	height:800px;
}

.search_input{
 font-size: 12pt; 
 width:100px !important;
}

.search_select{
 font-size: 12pt; 
 width:120px !important;
}

.search_margin_left{
 margin-left:5px;
}


.datetimepicker_date{
	width: 100px !important;
	text-align:center;
}

.orderPrintStatusModal .j_row1 button{
	width:100px;
	height:40px;
	font-size:16pt;
}

.orderReportModal .j_row1 button{
	width:100px;
	height:40px;
	font-size:16pt;
}

    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
		<p class="tabP" style="font-size: 20px; margin-left: 20px; color: white; font-weight: 800;"></p>
		<form id="searchForm" name="searchForm">
			<div class="j_container">
				<label class="daylabel">입고일</label>
				<input type="text" name="sdate" id="sdate" class="datetimepicker_date">
				~
				<input type="text" name="edate" id="edate" class="datetimepicker_date">
				<label class="daylabel">거래처명</label>
				<input type="text" name="corp_name" id="s_corp_name" class="search_input">
				<label class="daylabel">품명</label>
				<input type="text" name="prod_name" id="s_prod_name" class="search_input">
				<label class="daylabel">품번</label>
				<input type="text" name="prod_no" id="s_prod_no" class="search_input">
				<label class="daylabel">입고/타각LOT</label>
				<input type="text" name="ord_lot" id="s_ordlot" class="search_input">
				<select name="ord_print_gb" id="ord_print_gb" class="search_select">
					<option value="1">열처리 수주서</option>
					<option value="2">열후TAG</option>
					<option value="3">입고현황표</option>
				</select>
			</div>
			<div class="j_container">
				<div class="j_row">
					<label class="daylabel">제품구분</label>
					<select name="prod_gubn" id="s_prod_gubn" class="search_select">
						<option value="">전체</option>
						<option value="양산">양산</option>
						<option value="개발">개발</option>
					</select>
					<label class="daylabel">규격</label>
					<input type="text" name="prod_gyu" id="s_prod_gyu" class="search_input">
					<label class="daylabel">재질</label>
					<input type="text" name="prod_jai" id="s_prod_jai" class="search_input">
					<label class="daylabel">공정</label>
					<select name="tech_te" id="s_tech_te" class="search_select">

					</select>
					<label class="daylabel">담당자</label>
					<input type="text" name="ord_name" id="s_ord_name" class="search_input">
					<label class="daylabel">수주NO</label>
					<input type="number" name="ord_code" id="s_ord_code" class="search_input" value="0">
				</div>
			</div>
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
			<form action="" id="searchAddForm" autocomplete="off">
				<div class="j_container">
					<label class="daylabel">입고일</label>
					<input type="text" class="ord_date datetimepicker_date" id="s_ord_date">
					<label class="daylabel">거래처명</label>
					<input type="text" name="corp_name" id="sa_corp_name" class="search_input">
					<label class="daylabel">품명</label>
					<input type="text" name="prod_name" id="sa_prod_name" class="search_input">
					<label class="daylabel">품번</label>
					<input type="text" name="prod_no" id="sa_prod_no" class="search_input">
					<label class="daylabel">제품구분</label>
					<select name="prod_gubn" id="sa_prod_gubn" class="search_select">
						<option value="">전체</option>
						<option value="양산">양산</option>
						<option value="개발">개발</option>
					</select>
					<label class="daylabel">규격</label>
					<input type="text" name="prod_gyu" id="sa_prod_gyu" class="search_input">
					<label class="daylabel">재질</label>
					<input type="text" name="prod_jai" id="sa_prod_jai" class="search_input">
					<label class="daylabel">공정</label>
					<input type="text" name="tech_te" id="sa_prod_jai" class="search_input">
					<button class="iRowBtn margin_left" type="button" onclick="getIpgoAddData();">검색</button>
				</div>
			</form>
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
	let now_page_code = "a01";

	//로드
	$(function(){
		
		var tdate = todayDate();

		$("#sdate").val(tdate);
		$("#edate").val(tdate);
		
		//모달창 입고일
		$("#s_ord_date").val(tdate);
		
		//전체 거래처목록 조회
		getIpgoData();
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
    				var fileUrl = "/tkPrint/ipgoPdf/"+result.heatData;
                    $("#orderReport").attr("src",fileUrl);
                    orderReportModal.style.display = "flex";
					
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
	
	$("#searchForm input").on("keydown", function(e){
		if(e.key == 'Enter'){
			e.preventDefault();
			getIpgoList();
		}
	});
	
	$("#searchAddForm input").on("keydown", function(e){
		if(e.key == 'Enter'){
			e.preventDefault();
			getIpgoAddData();
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
	
	
	function getIpgoList(){
		var searchForm = new FormData($("#searchForm")[0]);

		//출력 등으로 재조회되어도 체크박스 선택이 풀리지 않도록, 조회 전 선택된 항목을 기억해뒀다가 재조회 후 복원
		var selectedOrdCodes = ipgoListTable.getSelectedData().map(function(d){ return d.ord_code; });

		$.ajax({
			url:"/tkheat/product/ipgo/getIpgoList",
			type:"post",
			dataType:"json",
	        contentType: false,
	        processData: false,
			data:searchForm,
			success:function(result){
				ipgoListTable.setData(result.data).then(function(){
					if(selectedOrdCodes.length > 0){
						ipgoListTable.getRows().forEach(function(row){
							if(selectedOrdCodes.indexOf(row.getData().ord_code) !== -1){
								row.select();
							}
						});
					}
				});
			}
		});
	}
	
	
	var isUpdating = false;
	function getIpgoData(){
		
		ipgoListTable = new Tabulator("#tab1", {
		    tableBuilt:function(){ this.redraw(true); },
		    height:"100%",
		    layout:"fitColumns",
		    //체크박스는 formatter:"rowSelection"이 change 이벤트로 자체 처리함.
		    //selectable:true(기본값)면 행 전체에 클릭리스너가 걸려 편집 가능한 셀(박스수량 등)을 클릭만 해도 체크박스가 같이 토글됨.
		    //"highlight"는 그 자동 토글만 막고 체크박스 자체 선택 동작은 그대로 유지함.
		    selectable:"highlight",
		    tooltips:true,
//		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",

/*		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/product/ipgo/getIpgoList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"sdate": $("#sdate").val(),
		    	"edate": $("#edate").val(),
			    },
*/		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
		    paginationSize:20,
		    paginationSizeSelector:[20,50,100,500,1000],
		    paginationCounter:"rows",
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		    	{formatter:"rowSelection", titleFormatter:"rowSelection", width:40, headerSort:false,
		    		cellClick:function(e, cell){
		    			cell.getRow().toggleSelect();
		    		}
		    	},
/*
				{	headerSort:false,
		    		formatter:beforePrintIcon, width:60, title:"열처리</br>수주서",cellClick:function(e, cell){
		    			if(cell.getRow().getData().ord_code != null){
		    				var ord_code = cell.getRow().getData().ord_code;
//		    				alert("작업로트 " + jisi_lot_view);
		    				var fileUrl = "/tkPrint/열처리수주서/"+ord_code+".pdf";
		                    $("#orderReport").attr("src",fileUrl);
		                    orderReportModal.style.display = "flex";
		    			}
		    		}
				},
*/
/*
				{	headerSort:false,
		    		formatter:afterPrintIcon, width:60, title:"열후</br>TAG",cellClick:function(e, cell){
		    			if(cell.getRow().getData().ord_code != null){
		    				var ord_code = cell.getRow().getData().ord_code;
//		    				alert("작업로트 " + jisi_lot_view);
		    				var fileUrl = "/tkPrint/열후TAG/"+ord_code+".pdf";
		                    $("#orderReport").attr("src",fileUrl);
		                    orderReportModal.style.display = "flex";
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
		                    orderReportModal.style.display = "flex";
		    			}
		    		}
				},
*/
		        {title:"NO", field:"idx", sorter:"int", width:30,
		        	hozAlign:"center", headerSort:false},
		        {title:"출력", field:"ord_prn", sorter:"string", width:30,
			        hozAlign:"center", headerSort:false},	
			    {title:"수주NO", field:"ord_code", sorter:"string", width:80,
				    hozAlign:"center"},
				{title:"입고일", field:"ord_date", sorter:"string", width:60,
				    hozAlign:"center",  headerSort:false,
				    editor:dateEditor}, 
				{title:"출고예정", field:"ord_nap", sorter:"string", width:60,
				    hozAlign:"center",  headerSort:false,
				    editor:dateEditor}, 
		        {title:"거래처", field:"corp_name", sorter:"string", width:90,
		        	hozAlign:"center", headerSort:false},		        
		        {title:"품명", field:"prod_name", sorter:"string", width:100,
		        	hozAlign:"center",  headerSort:false},
		        {title:"품번", field:"prod_no", sorter:"string", width:120,
		        	hozAlign:"center",  headerSort:false},
		        {title:"규격", field:"prod_gyu", sorter:"string", width:80,
			        hozAlign:"center",  headerSort:false},	
		        {title:"재질", field:"prod_jai", sorter:"int", width:80,
		        	hozAlign:"center",  headerSort:false},  	
		        {title:"공정", field:"tech_te", sorter:"int", width:60,
			        hozAlign:"center",  headerSort:false,
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
				{title:"입고/타각LOT", field:"ord_lot", sorter:"int", width:65,
					hozAlign:"center",  headerSort:false,
					editor:"input"
				},	
				
				{title:"수입검사", field:"itst_wp", sorter:"int", width:40,
					hozAlign:"center",  headerSort:false,
					editor:"input"
				},
				{title:"담당자", field:"ord_name", sorter:"int", width:60,
					hozAlign:"center",  headerSort:false,
					editor:"input"
				},
				{title:"선입", field:"ord_sunip", sorter:"int", width:45,
					hozAlign:"center",  headerSort:false,
					editor:"select",
					editorParams:{
						values:["선입1","선입2","선입3","선입4","선입5"]
					}
				},
				{title:"비고", field:"ord_bigo", sorter:"int", width:60,
					hozAlign:"center",  headerSort:false,
					editor:"input"
				},
				{title:"표면경도", field:"prod_pg", sorter:"int", width:70,
					hozAlign:"center",  headerSort:false},
				{title:"경화깊이", field:"prod_cd", sorter:"int", width:70,
					hozAlign:"center",  headerSort:false},
				{title:"심부경도", field:"prod_sg", sorter:"int", width:80,
					hozAlign:"center",  headerSort:false},
				{title:"화합물층", field:"prod_e1", sorter:"int", width:60,
					hozAlign:"center",  headerSort:false},
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    row.getElement().style.fontWeight = "600";

			    if(data.ord_prn == 0){
				    row.getElement().style.backgroundColor = "#FAED7D";
			    }else{
			    	row.getElement().style.backgroundColor = "#FFFFFF";
			    }
			},
			rowClick:function(e, row){

			    // 모든 행 색상 초기화
			    $("#tab1 div.row_select").removeClass("row_select");

			    // 클릭한 행만 색상 변경
			    row.getElement().classList.add("row_select");
			    
			    e.stopPropagation();
				
			},
			cellEdited: function(cell) {
				if(isUpdating) return;
				
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
		        		
			        	var latestData = cell.getRow().getData(); // ★ success 시점 최신값
		        		var ord_su = latestData.ord_su;
		        		var ord_danj = latestData.ord_danj;
		        		
		        		var ord_amnt = 0;
		        		if(ord_su != 0){
		        			ord_amnt = ord_su * ord_danj;
		        		}
		        		isUpdating = true;
		        		cell.getRow().getCell("ord_amnt").setValue(ord_amnt.toFixed(2));
		        		isUpdating = false;

				        // 편집이 끝난 후 아래 행 같은 열로 이동 + 편집 시작
				        setTimeout(function() {
				            var nextRow = cell.getRow().getNextRow();
				            if (nextRow) {
				                var field = cell.getField(); // 현재 열 field명
				                var nextCell = nextRow.getCell(field);
				                nextCell.edit(true); // true = 즉시 편집모드 진입
				            }
				        }, 100); // setTimeout으로 현재 편집 완료 후 실행
//			        	getIpgoList();
			        }
			    });
			    

			    
			}
		});		
	}

	function getIpgoAddData(){
		var searchAddForm = new FormData($("#searchAddForm")[0]);
		
		$.ajax({
			url:"/tkheat/product/ipgo/getIpgoAddList",
			type:"post",
			dataType:"json",
	        contentType: false,
	        processData: false,
			data:searchAddForm,
			success:function(result){
				
				ipgoAddTable.setData(result.data);
			}
		});
	}
	
	function getIpgoAddDataList(){
		
		ipgoAddTable = new Tabulator("#tabuData", {
		    tableBuilt:function(){ this.redraw(true); },
		    height:"100%",
		    layout:"fitColumns",
		    //체크박스는 formatter:"rowSelection"이 change 이벤트로 자체 처리함.
		    //selectable:true(기본값)면 Tabulator가 행 전체에 클릭리스너를 걸어 셀 편집을 위해 클릭만 해도 체크박스가 같이 토글됨.
		    //"highlight"는 그 자동 토글 리스너만 막고 체크박스 자체 선택 동작(및 선택 개수 제한 없음)은 그대로 유지함.
		    selectable:"highlight",
		    tooltips:true,
//		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",			
		    headerSort:false,
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tabuData .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    rowSelectionChanged:function(data, rows){
		        
		        // 전체 초기화
		        ipgoAddTable.getRows().forEach(function(row){
		            row.getElement().style.backgroundColor = "";
		        });

		        // 선택된 행만 색 변경
		        rows.forEach(function(row){
		            row.getElement().style.backgroundColor = "#d0ebff"; // 원하는 색
		        });
		    },
		    columns:[
			    {formatter:"rowSelection", titleFormatter:"rowSelection",
			    	hozAlign:"center", width:30, headerSort:false			    
		        },			    	
		        {title:"제품단중", field:"prod_danj", sorter:"string", width:100,
			        hozAlign:"center", visible:false},	
			    {title:"제품코드", field:"prod_code", sorter:"string", width:100,
				    hozAlign:"center", visible:false},     
				{title:"수주NO", field:"ord_code", sorter:"string", width:120,
				    hozAlign:"center", visible:false}, 
				{title:"거래처", field:"corp_name", sorter:"string", width:150,
				    hozAlign:"center", }, 
		        {title:"품명", field:"prod_name", sorter:"string", width:160,
		        	hozAlign:"center", },
		        {title:"품번", field:"prod_no", sorter:"string", width:100,
		        	hozAlign:"center", },
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
			        hozAlign:"center", },	
		        {title:"재질", field:"prod_jai", sorter:"int", width:100,
		        	hozAlign:"center", },  	
		        {title:"공정", field:"tech_te", sorter:"int", width:80,
			        hozAlign:"center", },	
			    {title:"표면경도", field:"prod_pg", sorter:"int", width:90,
				    hozAlign:"center", },	
				{title:"심부경도", field:"prod_sg", sorter:"int", width:90,
				    hozAlign:"center", },
				{title:"경화깊이", field:"prod_cd", sorter:"int", width:90,
					hozAlign:"center", },
				{title:"단위", field:"prod_danw", sorter:"int", width:60,
					hozAlign:"center", headerSort:false},	
				{title:"박스수량", field:"prod_boxsu", sorter:"int", width:70,
					hozAlign:"center", headerSort:false,editor:true,
		            mutatorData: function(value, data) {
		                return 1; // 값이 없으면 1
		            }
				},
				{title:"수량", field:"ord_su", sorter:"int", width:60,
					hozAlign:"center", headerSort:false,editor:true,
		            mutatorData: function(value, data) {
		                return 1; // 값이 없으면 1
		            }
				},
				{title:"ROWS*", field:"ord_row", sorter:"int", width:60,
					hozAlign:"center", headerSort:false,editor:true,
		            mutatorData: function(value, data) {
		                return 1; // 값이 없으면 1
		            }
				},
				{title:"단가", field:"prod_dang", sorter:"int", width:80,
					hozAlign:"center", headerSort:false},
		    ],
		    rowFormatter:function(row){
			    row.getElement().style.fontWeight = "600";
			},
			cellEdited: function(cell) {

		        // 편집이 끝난 후 아래 행 같은 열로 이동 + 편집 시작
		        setTimeout(function() {
		            var nextRow = cell.getRow().getNextRow();
		            if (nextRow) {
		                var field = cell.getField(); // 현재 열 field명
		                var nextCell = nextRow.getCell(field);
		                nextCell.edit(true); // true = 즉시 편집모드 진입
		            }
		        }, 100); // setTimeout으로 현재 편집 완료 후 실행
			}

		});		
	}
	
	
	
	//입고저장
	function save(){
		//ipgoAddTable
		//tabuData
		
		
		var ipgoData = ipgoAddTable.getSelectedData();
		
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
		getIpgoAddData();
		getIpgoAddDataList();
		ipgoModal.style.display = 'flex'; // 모달 표시
	});

	function closeBtn(){
		ipgoModal.style.display = 'none'; // 모달 숨김
	}


	

    </script>

	</body>
</html>
