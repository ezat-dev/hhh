<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>작업지시</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
    <style>

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
#workTabu.tabulator {
	flex: 1;
	min-height: 0;
	max-height: none;
	width: 100%;
	min-width: 0;
	border: none;
	font-size: 12px;
}
#workTabu .tabulator-header {
	background: linear-gradient(135deg, #2B6CB0, #3182CE);
	border-bottom: none;
}
#workTabu .tabulator-col {
	background: transparent;
	border-right: 1px solid rgba(255,255,255,.15);
}
#workTabu .tabulator-col.tabulator-sortable:hover {
	background: rgba(255,255,255,.08);
}
#workTabu .tabulator-col-title {
	color: #ffffff;
	font-weight: 700;
}
#workTabu .tabulator-col .tabulator-header-filter input {
	border: none;
	border-radius: 5px;
	padding: 4px 6px;
	font-size: 11px;
	background: rgba(255,255,255,.92);
	box-sizing: border-box;
}
#workTabu .tabulator-row {
	border-bottom: 1px solid #EDF2F7;
	transition: background-color .12s;
}
#workTabu .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#workTabu .tabulator-row.row_select {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#workTabu .tabulator-cell {
	border: 1px solid #E2E8F0;
	color: #2D3748;
}
#workTabu .tabulator-footer {
	background: #F7FAFC;
	border-top: 1px solid #E2E8F0;
	padding: 8px 12px;
}
#workTabu .tabulator-page {
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
#workTabu .tabulator-page.active {
	background: #3182CE;
	border-color: #2B6CB0;
	color: #ffffff;
}
#workTabu .tabulator-page:not(:disabled):hover {
	background: #EBF8FF;
	border-color: #BEE3F8;
	color: #2B6CB0;
	cursor: pointer;
}

/* ========== 상단 도구바 ========== */
.tab {
	background: #ffffff;
	border: 1px solid #E2E8F0;
	border-radius: 10px;
	box-shadow: 0 1px 4px rgba(0,0,0,.06);
	padding: 10px 14px;
}
.box1 {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}
.j_container {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}
.j_row1 {
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
/* nbsp/inline-style로 간격 맞추던 옛 방식 대체 (gap이 대신 처리) */
.margin_left {
	margin-left: 0 !important;
}
.datetimepicker_date,
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
.box1 select:focus,
.box1 input:focus {
	border-color: #3182CE;
	background-color: #fff;
}
.datetimepicker_date {
	width: 100px !important;
	text-align: center;
}
/* 검색영역(box1)의 날짜/텍스트 입력은 기존 140px 폭 유지 */
.box1 .datetimepicker_date {
	width: 140px !important;
}
.box1 input[type="text"] {
	width: 140px;
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

.iRowBtn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	width: 70px;
	height: 32px;
	font-size: 12px;
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

/* ========== 모달 공통 (product/ipgo·chulgo 모달과 동일한 톤) ========== */
.workDanModal,
.workDanIpgoModal,
.workDanSunipModal,
.processOrderStatusModal,
.processOrderReportModal {
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
.workDanIpgoModal,
.workDanSunipModal {
	z-index: 20011;
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

/*단취작업 등록 모달*/
.workDanModal{
	width:1500px;
	height:680px;
	flex-direction: column;
	overflow: hidden;
}

/* 폼 영역(#workDanForm)만 스크롤 처리 -> 헤더와 저장/닫기 버튼은 항상 고정으로 보이고,
   내용이 모달 높이를 넘칠 때만 폼 내부에서만 스크롤이 생기도록 함 (모달 전체에 불필요한 스크롤/콘텐츠 잘림 방지) */
.workDanModal #workDanForm{
	flex: 1;
	min-height: 0;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
}
/* 목록(#workDanTabu)이 남는 세로공간을 모두 흡수하도록 하여, 폼 내부 정적 콘텐츠 때문에
   생기던 불필요한 스크롤을 없앰. 목록 자체의 행이 많아 넘칠 때는 타뷸레이터가 알아서
   자체 스크롤을 보여줌(모달/폼 레벨 스크롤과는 별개) */
.workDanModal .setRow{
	flex: 1;
	min-height: 0;
	display: flex;
	flex-direction: column;
}
.workDanModal #workDanTabu{
	flex: 1;
	min-height: 0;
}

.workDanModal .j_container,
.workDanIpgoModal .j_container,
.workDanSunipModal .j_container{
	display:flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}

.workDanModal .j_row1,
.workDanIpgoModal .j_row1,
.workDanSunipModal .j_row1{
	display:flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}

.workDanModal .iRowBtn,
.workDanIpgoModal .iRowBtn,
.workDanSunipModal .iRowBtn{
	display:block;
	cursor:pointer;
	width:70px;
	height:30px;
	font-size:12px;
}

.workDanModal .iRowBtn2{
	display:block;
	cursor:pointer;
	width:130px;
	height:30px;
	font-size:12px;
	border: 1px solid #E2E8F0;
	border-radius: 6px;
	background: #F0F4F8;
	color: #2D3748;
	transition: background-color .13s, border-color .13s;
}
.workDanModal .iRowBtn2:hover{
	background: #EBF8FF;
	border-color: #BEE3F8;
}

.workDanModal .iRowLabel,
.workDanIpgoModal .iRowLabel,
.workDanSunipModal .iRowLabel{
	display:block;
	width:120px;
	height:30px;
	text-align:center;
	margin-bottom:2px;
	font-size:12pt;
}

.workDanModal .iRowLabel2{
	display:block;
	width:130px;
	height:24px;
	text-align:left;
	margin-bottom:8px;
	font-size:12pt;
	margin-left:10px;
}

.workDanModal .iRowInput{
	/*display:flex;*/
	width:120px !important;
	height:24px;
	font-size:12pt;
	text-align:center;
}

.workDanModal .iRowInput_180,
.workDanIpgoModal .iRowInput_180,
.workDanSunipModal .iRowInput_180{
	/*display:flex;*/
	width:180px !important;
	height:24px;
	font-size:12pt;
	text-align:center;
}

.workDanModal .iRowInput2{
	display:block;
	width:120px !important;
	height:24px;
	font-size:12pt;
	text-align:center;
	margin-bottom:8px;
}

/* 모달 내 입력요소 공통 톤(테두리/배경/포커스) */
.workDanModal input[type="text"],
.workDanModal input[type="password"],
.workDanModal select,
.workDanIpgoModal input[type="text"],
.workDanIpgoModal select,
.workDanSunipModal input[type="text"],
.workDanSunipModal select {
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	outline: none;
	box-sizing: border-box;
	transition: border-color .2s ease, background-color .2s ease;
}
.workDanModal input[type="text"]:focus,
.workDanModal input[type="password"]:focus,
.workDanModal select:focus,
.workDanIpgoModal input[type="text"]:focus,
.workDanIpgoModal select:focus,
.workDanSunipModal input[type="text"]:focus,
.workDanSunipModal select:focus {
	border-color: #3182CE;
	background-color: #fff;
}

/*단취-입고이력 조회모달(작업대기 리스트)*/
.workDanIpgoModal{
	width:1200px;
	height:780px;
	flex-direction: column;
}
/* 검색줄 라벨(거래처/품명/품번)이 120px 고정폭이라 인풋+버튼까지 합치면 모달 폭을 살짝
   넘겨서 조회버튼만 다음 줄로 밀려나던 문제 -> 라벨을 텍스트 크기에 맞게 축소 */
.workDanIpgoModal .iRowLabel,
.workDanSunipModal .iRowLabel{
	width:auto;
	min-width:0;
	padding:0 2px;
}

/* 헤더+검색폼+리스트를 스크롤 영역으로 묶어서 닫기 버튼이 항상 하단에 고정되어 보이도록 함 */
.workDanIpgoModal .detail {
	flex: 1;
	min-height: 0;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
	gap: 8px;
}
/* 목록(#workDanIpgoTabu)이 남는 세로공간을 모두 흡수하도록 하여, 검색줄 등 정적 콘텐츠
   때문에 생기던 모달 레벨의 불필요한 스크롤을 없앰. 행이 많아 넘칠 때는 타뷸레이터가
   자체적으로 스크롤을 보여줌(모달 레벨 스크롤과는 별개) */
.workDanIpgoModal .detail > .j_container:last-of-type,
.workDanIpgoModal .setRow{
	flex: 1;
	min-height: 0;
	display: flex;
	flex-direction: column;
}
.workDanIpgoModal #workDanIpgoTabu{
	flex: 1;
	min-height: 0;
}

.workDanIpgoModal .iRowInput{
	/*display:flex;*/
	width:140px !important;
	height:24px;
	font-size:12pt;
	text-align:center;
}

/*단취-입고 선입리스트 모달 (미사용/미완성 - 시각적 통일만 적용, 기능 미구현 상태 유지)*/
.workDanSunipModal{
	width:1200px;
	height:750px;
	flex-direction: column;
}

.tabulator-header > .tabulator-headers > .tabulator-col{
	height:30px !important;
}


.tabulator {
	font-size: 11pt;
	font-weight: 700;
}

.tabulator-header > .tabulator-headers > .tabulator-col > .tabulator-col-content > .tabulator-col-title-holder > .tabulator-col-title{
	font-size: 12pt !important;
}

.tabulator-col-title > input[type='checkbox']{
	width:20px;
	height:20px;
}

.tabulator-cell > input[type='checkbox']{
	width:20px;
	height:20px;
}

.tabulator-edit-select-list {
    display: block !important;
    z-index: 30000 !important;
    background: white !important;
    border: 1px solid #ccc !important;
}

/*말줄임표*/
.ellipsis-cell .tabulator-cell-value {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* ========== 모달 내 리스트(#workDanTabu, #workDanIpgoTabu) ========== */
#workDanTabu.tabulator,
#workDanIpgoTabu.tabulator {
	border: 1px solid #E2E8F0;
	border-radius: 8px;
	font-size: 12px;
}
#workDanTabu .tabulator-header,
#workDanIpgoTabu .tabulator-header {
	background: linear-gradient(135deg, #2B6CB0, #3182CE);
	border-bottom: none;
}
#workDanTabu .tabulator-col,
#workDanIpgoTabu .tabulator-col {
	background: transparent;
	border-right: 1px solid rgba(255,255,255,.15);
}
#workDanTabu .tabulator-col-title,
#workDanIpgoTabu .tabulator-col-title {
	color: #ffffff;
	font-weight: 700;
}
#workDanTabu .tabulator-row,
#workDanIpgoTabu .tabulator-row {
	border-bottom: 1px solid #EDF2F7;
	transition: background-color .12s;
}
#workDanTabu .tabulator-row.tabulator-row-even,
#workDanIpgoTabu .tabulator-row.tabulator-row-even {
	background-color: #F7FAFC;
}
#workDanTabu .tabulator-row:hover,
#workDanIpgoTabu .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#workDanTabu .tabulator-cell,
#workDanIpgoTabu .tabulator-cell {
	border: 1px solid #E2E8F0;
	color: #2D3748;
}
#workDanTabu .tabulator-footer,
#workDanIpgoTabu .tabulator-footer {
	background: #F7FAFC;
	border-top: 1px solid #E2E8F0;
	padding: 6px 10px;
}
#workDanTabu .tabulator-page,
#workDanIpgoTabu .tabulator-page {
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
#workDanTabu .tabulator-page.active,
#workDanIpgoTabu .tabulator-page.active {
	background: #3182CE;
	border-color: #2B6CB0;
	color: #ffffff;
}
#workDanTabu .tabulator-page:not(:disabled):hover,
#workDanIpgoTabu .tabulator-page:not(:disabled):hover {
	background: #EBF8FF;
	border-color: #BEE3F8;
	color: #2B6CB0;
	cursor: pointer;
}

.processOrderStatusModal {
	width:350px;
	height:150px;
}

.processOrderReportModal {
	width:850px;
	height:800px;
	flex-direction: column;
	padding: 14px;
	gap: 10px;
	box-sizing: border-box;
}

.tabulator-row.tabulator-selected .indicator-cell::before {
    content: "▶";
    font-size: 11pt;
}


    </style>
    <body>
    
    <div class="tab">
    <div class="box1">
		<form action="" autocomplete="off">
			<div class="j_container">
				<label class="daylabel">작업일 :</label>
				<input type="text" id="s_all_sdate" class="datetimepicker_date">
				~
				<input type="text" id="s_all_edate" class="datetimepicker_date">
				<label class="daylabel">거래처 :</label>
				<input type="text" id="s_all_corp_name">
				<label class="daylabel">품명 :</label>
				<input type="text" id="s_all_prod_name">
				<label class="daylabel">품번 :</label>
				<input type="text" id="s_all_prod_no">
			</div>
		</form>
	</div>
    <div class="button-container">
        <button class="select-button">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           검색
        </button>
<!--         
        <button class="insert-button" id="jAddBtn">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          	단취등록
        </button>
 -->
        <button class="insert-button" onclick="workDanModalOpen();">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
            신규
        </button>
        <button class="delete" id="workDeleteBtn">
            <img src="/tkheat/css/image/delete-icon.png" alt="delete" class="button-image">
            삭제
        </button>
        
        <button class="printer-button" id="processPrintBtn">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
			 공정이동표            
        </button>
<!--  
        <button class="printer-button" id="checkPrintBtn">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
			 체크시트            
        </button>
-->
    </div>
</div>
<main class="main">
	<div class="container">
		<div id="workTabu"></div>
	</div>
</main>
	    
<!-- 다이얼로그 -->

<!-- 단취작업 모달 -->
<div class="workDanModal">
	<div class="detail">
		<div class="header">
		단취작업 등록
		</div>
	</div>
	
		<form id="workDanForm" name="workDanForm" autocomplete="off">
			<div class="j_container">
				<!-- 수주no 바코드스캔 후 적용과 입고이력을 조회한다음 추가하는 방법 2가지 -->				
				<label for="" class="iRowLabel">수주NO</label>
				<input type="text" id="danch_ord_code" name="danch_ord_code" class="iRowInput_180" autocomplete="off"/>
				<button class="iRowBtn2 margin_left" type="button" onclick="getWorkDanIpgoDataBarcodeScan();">수주NO조회</button>
				<button class="workHDataBtn iRowBtn2 margin_left" type="button" onclick="workDanIpgoModalOpen();">입고이력조회</button>
				<label for="" class="margin_left iRowLabel">총 작업수량</label>
				<input type="text" name="danch_total_cnt" class="iRowInput" value="0" disabled="disabled"/>			
				<label for="" class="margin_left iRowLabel">단취 기준수량</label>
				<input type="text" name="danch_std_cnt" class="iRowInput" value="0" disabled="disabled"/>			
				<label for="" class="margin_left iRowLabel">선입선출제외</label>
				<input type="checkbox" id="danch_sunip_chk" name="danch_sunip_chk" class="iRowInput"
					style="width:40px !important;"/>
				<input type="password" id="danch_sunip_chk_pw" name="danch_sunip_chk_pw" class="iRowInput margin_left" autocomplete="new-password"/>
									
			</div>	
	
		<hr />
			<div class="setRow">
				<div id="workDanTabu"></div>
			</div>
			<hr />
		<div class="j_container" style="justify-content:center; font-size:14pt;">
			<div class="j_row1">*등록정보*</div>						
		</div>
		<hr />
		<div class="j_container">				
			<div class="j_row1">
				<div class="j_div">
					<label for="user_code" class="iRowLabel">작업자</label>
					<select name="user_code" class="iRowInput" style="height:30px;"></select>						
				</div>
				
				
				<div class="j_div">
					<label for="wstd_t32" class="iRowLabel margin_left" style="width:240px;">작업시작</label>
					<input type="text" name="ilbo_strt" class="iRowInput margin_left datetimepicker_datetime" style="width:240px !important; height:25px;"/>
				</div>
				
				<div class="j_div" style="width:80px;">
					<label for="" class="iRowLabel margin_left"></label>
					<button class="iRowBtn margin_left" type="button" 
					onclick="sdateTimeSetBtn('danchStart');"
					style="display:inline-block;">시작</button>
				</div>
				
				<div class="j_div">
					<label for="wstd_t32" class="iRowLabel margin_left" style="width:240px;">작업종료</label>
					<input type="text" name="ilbo_end" class="iRowInput margin_left datetimepicker_datetime" style="width:240px !important; height:25px;"/>
				</div>
				
				<div class="j_div" style="width:80px;">
					<label for="" class="iRowLabel margin_left"></label>
					<button class="iRowBtn margin_left" type="button" onclick="sdateTimeSetBtn('danchEnd');"
					style="display:inline-block;">종료</button>						
				</div>
				
			</div>
		</div>		
		<hr />
		<div class="j_container" style="justify-content:center; font-size:14pt;">
			<div class="j_row1">*적재방법*</div>			
		</div>
		<hr />
		
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_div">
					<label for="wstd_t32" class="iRowLabel2">1줄/1판</label>
					<label for="wstd_t33" class="iRowLabel2">줄/단</label>
					<label for="wstd_t41" class="iRowLabel2">단/Tray</label>
					<label for="wstd_t87" class="iRowLabel2">추가수량</label>
					<label for="wstd_t43" class="iRowLabel2">적재수량</label>
				</div>
				<div class="j_div">
					<input type="text" name="wstd_t32" class="iRowInput2"/>					
					<input type="text" name="wstd_t33" class="iRowInput2"/>
					<input type="text" name="wstd_t41" class="iRowInput2"/>
					<input type="text" name="wstd_t87" class="iRowInput2"/>	
					<input type="text" name="wstd_t43" class="iRowInput2"/>					
				</div>
			</div>
			
			<div class="j_row1">
				<div class="j_div">
					<label for="wstd_t44" class="iRowLabel2">Jig중량(kg)</label>
					<label for="wstd_t51" class="iRowLabel2">제품중량(kg)</label>
					<label for="wstd_t52" class="iRowLabel2">총중량(kg)</label>
				</div>
				<div class="j_div">
					<input type="text" name="wstd_t44" class="iRowInput2"/>
					<input type="text" name="wstd_t51" class="iRowInput2"/>
					<input type="text" name="wstd_t52" class="iRowInput2"/>	
				</div>
			</div>
			
			<div class="j_row1">
				<div class="j_div">
					<label for="wstd_t53" class="iRowLabel2">적재주의사항-1</label>
					<label for="wstd_t54" class="iRowLabel2">적재주의사항-2</label>
					<label for="wstd_t30" class="iRowLabel2">적재주의사항-3</label>
					<label for="" class="iRowLabel2">치구불량</label>
					<label for="" class="iRowLabel2">비고</label>
				</div>
				<div class="j_div">
					<input type="text" name="wstd_t53" class="iRowInput2"/>				
					<input type="text" name="wstd_t54" class="iRowInput2"/>	
					<input type="text" class="iRowInput2"/>
					<input type="text" name="wstd_t30" class="iRowInput2"/>
					<input type="text" class="iRowInput2"/>
				</div>
			</div>
			
			
			<div class="j_row1">
				<div class="j_div">
					<label for="wstd_t53" class="iRowLabel2">제품사진</label>
				</div>
				
				<div class="j_div">
					<!-- 제품사진, 단취사진 img -->
					<img src="" alt="" name="product_file_name" style="width:150px; height:150px;"/>
				</div>
				<div class="j_div">
					<label for="wstd_t53" class="iRowLabel2">단취사진</label>
				</div>
				
				<div class="j_div">
					<!-- 제품사진, 단취사진 img -->
					<img src="" alt="" name="wstd_chim_file_name1" style="width:150px; height:150px;"/>
				</div>
			</div>

			
			
		</div>
		
	</form>
	
	<hr />

    <div class="btnSaveClose">
		<button class="save" type="button" onclick="workDanModalSave();">저장</button>
		<button class="close" type="button" onclick="workDanModalClose();">닫기</button>
    </div>
</div>


<!-- 입고이력 -->
<div class="workDanIpgoModal">
	<div class="detail">
		<div class="header">
		작업대기 리스트
		</div>
		<div class="j_container">
			<form id="workDanIpgoForm" name="workDanIpgoForm" autocomplete="off" style="width:100%;">
				<div class="j_row1">
					<label class="daylabel">입고일 :</label>
					<input type="text" id="dan_ipgo_sdate" class="iRowInput datetimepicker_date">
					~
					<input type="text" id="dan_ipgo_edate" class="iRowInput datetimepicker_date">

					<label for="" class="iRowLabel margin_left">거래처</label>
					<input type="text" id="dan_ipgo_cname" class="iRowInput dan_ipgo_input"/>
					<label for="" class="iRowLabel margin_left">품명</label>
					<input type="text" id="dan_ipgo_pname" class="iRowInput dan_ipgo_input"/>
					<label for="" class="iRowLabel margin_left">품번</label>
					<input type="text" id="dan_ipgo_pno" class="iRowInput dan_ipgo_input"/>
					<button class="iRowBtn margin_left" type="button" onclick="getWorkDanIpgoDataList();">조회</button>
				</div>
				<div class="j_row1" style="justify-content: end;">
					<span style="color:red;" class="margin_left">*단취기준수량 0인 제품은 작업표준에서 등록해주십시오! (더블클릭 시 아래 등록정보에 적용됩니다)</span>
				</div>
			</form>
		</div>

		<div class="j_container">
			<div class="setRow">
				<div id="workDanIpgoTabu"></div>
			</div>
		</div>
	</div>

    <div class="btnSaveClose">
		<button class="close" type="button" onclick="workDanIpgoModalClose();">닫기</button>
    </div>
</div>

<!-- 선입 리스트 -->
<div class="workDanSunipModal">
	<div class="detail">
		<div class="header">
		작업대기 리스트
		</div>
	</div>
		<div class="j_container">
			<form id="workDanSunipForm" name="workDanSunipForm" autocomplete="off" style="width:100%;">
				<div class="j_row1">
					<label class="daylabel">입고일 :</label>
					<input type="text" id="dan_ipgo_sdate" class="iRowInput_180 datetimepicker_date" 
					style="width:100px;">
					~
					<input type="text" id="dan_ipgo_edate" class="iRowInput_180 datetimepicker_date" 
					style="width:100px;">				
	
					<label for="" class="iRowLabel margin_left">거래처</label>
					<input type="text" id="dan_ipgo_cname" class="iRowInput_180 dan_ipgo_input"
					style="width:140px;"/>
					<label for="" class="iRowLabel margin_left">품명</label>
					<input type="text" id="dan_ipgo_pname" class="iRowInput_180 dan_ipgo_input"
					style="width:140px;"/>
					<label for="" class="iRowLabel margin_left">품번</label>
					<input type="text" id="dan_ipgo_pno" class="iRowInput_180 dan_ipgo_input"
					style="width:140px;"/>
					<button class="iRowBtn margin_left" type="button" onclick="getworkDanSunipDataList();">조회</button>
				</div>
				<div class="j_row1" style="justify-content: end;">
					<span style="color:red;" class="margin_left">*단취기준수량 0인 제품은 작업표준에서 등록해주십시오!</span>
				</div>				
			</form>
		</div>
	
		<div class="j_container">
			<div class="setRow">
				<div id="workDanSunipTabu"></div>
			</div>
		</div>
		<hr />

    <div class="btnSaveClose">
		<button class="close" type="button" onclick="workDanSunipModalClose();">닫기</button>
    </div>
</div>


<form id="reportPrint" name="reportPrint">
	<input type="text" id="reportDate" name="reportDate" style="display:none;"/>
	<input type="text" id="reportBarcode" name="reportBarcode" style="display:none;"/>
	<input type="text" id="reportPlnpLot" name="reportPlnpLot" style="display:none;"/>
</form>

<a style="display:none;" id="downLoadLink" href="#" download="#"></a>

<!-- 열처리 체크시트 출력중 모달 -->
<div class="processOrderStatusModal">
	<div class="detail">
		<div class="header">
			<span style="display:inline-block; width:180px;">단취 공정이동표</span>
		</div>
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<span style="display:inline-block; width:350px;">단취 공정이동표 파일 생성중입니다....</span>
					<br />
					<span style="display:inline-block; width:350px;">생성완료시 팝업창이 닫힙니다.</span>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="processOrderStatusClose iRowBtn margin_left" type="button" onclick="processOrderStatusCloseBtn();">닫기</button>
		</div>
    </div>	
</div>

	
<!-- 단취 공정이동표 표현 모달 -->
<div class="processOrderReportModal">
	<div class="j_container">
		<iframe src="" frameborder="0" width="800" height="700" id="processOrderReport">
		</iframe>	
	</div>
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="processOrderReportClose iRowBtn margin_left" type="button" onclick="processOrderReportCloseBtn();">닫기</button>
		</div>
    </div>
</div>



<script>
	//전역변수
    var cutumTable;	
    let now_page_code = "i01";
	
    var danchSdateTime, danchEdateTime;
    
	//로드
	$(function(){
		//전체 거래처목록 조회
		var tdate = todayDate();

		$("#s_all_sdate").val(tdate);
		$("#s_all_edate").val(tdate);
		
		
		getWorkData();
		getWorkDataList();
	});

	//이벤트	
	$("#processPrintBtn").on("click",function(){
		var selectedData = workDataTable.getSelectedData();
		
		if(selectedData.length <= 0){
			alert("공정이동표를 출력할 단취항목을 선택해주십시오!");
			return false;
		}
		
		processOrderStatusModal.style.display = "block";

		var sendObj = {
				"processOrderData": selectedData
			}

		//선택한 객체 전송
		$.ajax({
			url:"/tkheat/workilbo/processOrderPrint",
			type:"post",
			dataType:"json",
			contentType: false,
			processData: false,			
			data:JSON.stringify(sendObj),
			success:function(result){
   				var fileUrl = "/tkPrint/workilboProcessOrder/"+result.fileName;
                $("#processOrderReport").attr("src",fileUrl);
                processOrderReportModal.style.display = "flex"; // flex-direction:column 레이아웃 적용을 위해 flex로 표시

                processOrderStatusCloseBtn();
//				getChulgoData();
			}
		});

	});
	
	$(".dan_ipgo_input").on("keydown", function(e){
		if(e.keyCode == 13){
			getWorkDanIpgoDataList();
		}
	});
	
	$(".select-button").on("click", function(){
		getWorkDataList();
	});
	
	//작업삭제
	$("#workDeleteBtn").on("click", function(){
		
		var selectedData = workDataTable.getSelectedData()[0];
		
		if(confirm("작업/단취코드 : "+selectedData.ilbo_code+"\n수주번호 : "+selectedData.ord_code+"\n작업구분 : "+selectedData.ilbo_gubn+"\n작업LOT : "+selectedData.ilbo_lot+"\n를 삭제하시겠습니까?")){
			
			var ilbo_code = selectedData.ilbo_code;
			var ord_code = selectedData.ord_code;
			var ilbo_gubn = selectedData.ilbo_gubn;
			var ilbo_lot = selectedData.ilbo_lot;
			var user_name = "${loginUser.user_name}";
						
			
			$.ajax({
				url:"/tkheat/workilbo/dataDelete",
				type:"post",
				dataType:"json",
				data:{
					"ilbo_code":ilbo_code,
					"ord_code":ord_code,
					"ilbo_gubn":ilbo_gubn,
					"ilbo_lot":ilbo_lot,
					"user_code":user_name
				},
				success:function(result){
					getWorkDataList();
					alert("삭제되었습니다.");
				}
			});
		}
	});
	
	
	//함수
	
	function sdateTimeSetBtn(gb){
		var now = new Date();
		var ye = now.getFullYear();
		var mo = paddingZero(now.getMonth()+1);
		var da = paddingZero(now.getDate());
		
		var ho = paddingZero(now.getHours());
		var mi = paddingZero(now.getMinutes());		
		
		var setDateTime = ye+"-"+mo+"-"+da+" "+ho+":"+mi;
		
		switch(gb){
			case "danchStart": 
				$("#workDanForm input[name='ilbo_strt']").val(setDateTime);
			break;
			case "danchEnd": 
				$("#workDanForm input[name='ilbo_end']").val(setDateTime);
			break;
			case "bcfStart": 
				$("#workBcfForm input[name='ilbo_strt']").val(setDateTime);
			break;
			case "bcfEnd": 
				$("#workBcfForm input[name='ilbo_end']").val(setDateTime);
			break;
			case "tfStart": 
				$("#workTfForm input[name='ilbo_strt']").val(setDateTime);
			break;
			case "tfEnd": 
				$("#workTfForm input[name='ilbo_end']").val(setDateTime);
			break;
		} 
	}
	
	//더블클릭으로 기존 데이터를 불러올 때, 작업자 목록이 아직 로딩되기 전(최초 진입 시)이면
	//select에 값 설정이 조용히 실패하므로, 목록 로딩(getWorkDanDataUserCode)이 끝난 뒤에도
	//적용할 수 있도록 값을 임시 보관해둔다.
	var danchPendingUserCode = null;
	var tkheatLoginUserCode = "${loginUser.user_code}"; //신규 등록시 작업자 기본값용(현재 로그인 사용자)

	//단취작업 모달
	function workDanModalOpen(){
		$("#workDanForm")[0].reset();
		danchPendingUserCode = null;
		//select에 남아있는 이전(수정모드 등) 선택값을 지워야, 신규등록시 로그인 사용자 기본선택 로직이 정상 동작함
		$("#workDanForm select[name='user_code']").val('');
/*
		var now = new Date();
		var ye = now.getFullYear();
		var mo = paddingZero(now.getMonth()+1);
		var da = paddingZero(now.getDate());
		
		var ho = paddingZero(now.getHours());
		var mi = paddingZero(now.getMinutes());		
		
		var setDateTime = ye+"-"+mo+"-"+da+" "+ho+":"+mi;
		
		$("#workDanForm input[name='ilbo_strt']").val(setDateTime);
		$("#workDanForm input[name='ilbo_end']").val(setDateTime);
*/

		getWorkDanData();
		getWorkDanDataUserCode();
		$("#workDanForm input[name='ilbo_strt']").val("1900-01-01 00:00");
		$("#workDanForm input[name='ilbo_end']").val("1900-01-01 00:00");
		workDanModal.style.display = 'flex'; // 모달 보임 (flex-direction:column 레이아웃 적용을 위해 flex로 표시)
		
	}	
	function workDanModalClose(){		
		workDanModal.style.display = 'none'; // 모달 숨김
	}
	
	//단취작업 입고이력 모달
	function workDanIpgoModalOpen(){
		$("#workDanIpgoForm")[0].reset();
		
		//1주일전 ~ 오늘
		var ydate = beforeWeekDate();
		var tdate = todayDate();
		
		$("#dan_ipgo_sdate").val(ydate);
		$("#dan_ipgo_edate").val(tdate);
		
		getWorkDanIpgoData();
		getWorkDanIpgoDataList();
		
		workDanIpgoModal.style.display = 'flex'; // 모달 보임 (flex-direction:column 레이아웃 적용을 위해 flex로 표시)
	}
	function workDanIpgoModalClose(){
		workDanIpgoModal.style.display = 'none'; // 모달 숨김
	}
	
	var rowDeleteBtn = function(cell, formatterParams){ //plain text value
		
		var rowData = cell.getRow().getData();
	
		console.log(rowData.ilbo_code);
		
		
		var btn = "";
		if(rowData.ilbo_code == 0){
			btn = "<button type='button' style='display: flex;align-items: center; cursor:pointer;width:90px;height:20px; font-size:12pt;padding-left:20px; margin-right:0;'>행삭제</button>";
		}
		
		return btn;
	};
	
	//작업지시관리NEW 전체이력 조회
	function getWorkDataList(){
		var s_sdate = $("#s_all_sdate").val();
		var s_edate = $("#s_all_edate").val();
		var s_corp_name = $("#s_all_corp_name").val();
		var s_prod_name = $("#s_prod_name").val();
		var s_prod_no = $("#s_prod_no").val();
		
		$.ajax({
			url:"/tkheat/workilbo/danch/allList",
			type:"post",
			dataType:"json",
			data:{
				"s_sdate":s_sdate,
				"s_edate":s_edate,
				"s_corp_name":s_corp_name,
				"s_prod_name":s_prod_name,
				"s_prod_no":s_prod_no
			},
			success:function(result){
				workDataTable.setData(result.data);
			}
		});
	}
	
	
	
	var workDataTable;
	function getWorkData(){
		
		workDataTable = new Tabulator("#workTabu", {
		    height:"100%",
		    layout:"fitColumns",
		    selectable:1,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:false,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
		    paginationSize:20,
		    paginationSizeSelector:[20,50,100,500,1000],
		    paginationCounter:"rows",
		    headerSort:false,
		    rowSelectionChanged:function(data, rows){
		        // 현재 화면에 보이는 모든 행 다시 그림
		        this.getRows().forEach(function(r){
		            r.reformat();
		        });
		    },
		    rowClick: function(e, row){
		        // 이미 선택된 행이면 아무것도 안 함
		        if(!row.isSelected()){
		            row.select();   // 다른 행 누르면 기존 자동 해제
		        }
		        
		        
		        if(e.detail === 2){
					var rowData = row.getData();

					//일보구분에 따라 각각 표기
					
					var ilbo_code = rowData.ilbo_code;
					var ilbo_gubn = rowData.ilbo_gubn;
					var ilbo_lot = rowData.ilbo_lot;
					var ilbo_pc = rowData.ilbo_pc;
					
					$.ajax({
						url:"/tkheat/workilbo/danch/dataUpdateList",
						type:"post",
						dataType:"json",
						data:{
							"ilbo_code":ilbo_code,
							"ilbo_gubn":ilbo_gubn,
							"ilbo_lot":ilbo_lot,
							"ilbo_pc":ilbo_pc
						},
						success:function(result){
							//ilbo_gubn의 값에 따라서 모달변경
							if(ilbo_gubn == "J"){
								//단취작업 수정							
								workDanModalOpen();
							
								workDanDataTable.setData(result.data);
								
//								console.log(result.data);
								
								var stdDatas = result.data;
								
								var danch_std_cnt = 0;
								var danch_total_cnt = 0;
								
								for(let keys in stdDatas){
									var stdData = stdDatas[keys];
									
									for(let key in stdData){
										if(key != "danch_sunip_chk_pw" && key != "danch_sunip_chk"){
											if(key == "user_code"){
												danchPendingUserCode = stdData[key];
											}
											$("#workDanForm input[name='"+key+"']").val(stdData[key]);
											$("#workDanForm select[name='"+key+"']").val(stdData[key]);
										}

										if(key == "wstd_t43"){
											danch_std_cnt = stdData[key]; 
										}
										if(key == "ilbo_su"){
											danch_total_cnt += stdData[key]; 
										}
									}
								}
								$("#workDanForm input[name='danch_std_cnt']").val(danch_std_cnt);
								$("#workDanForm input[name='danch_total_cnt']").val(danch_total_cnt);

							}else if(ilbo_gubn == "A"){
								//열처리작업 수정
								workBcfModalOpen();
								
								workBcfDataTable.setData(result.data);
							}else if(ilbo_gubn == "R"){
								//열처리작업 수정
								workTfModalOpen();
								
								workTfDataTable.setData(result.data);
							}
						}
					});

		        }
		    },
		    columns:[
		        {title:"NO", formatter:"rownum", width:40, hozAlign:"center", headerSort:false},
		        {
		            title: "",
		            field: "indicator",
		            width: 20,
		            hozAlign: "center",
		            headerSort: false,
		            formatter: function(cell){
		                return cell.getRow().isSelected()
//		                    ? "<span style='font-size:16px;'>✔</span>"
		                    ? "<span style='font-size:11pt;'>▶</span>"
		                    : "";
		            }
		        },
		        {title:"단취코드", field:"danch_barcode", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"수주NO", field:"ord_code", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"작업일", field:"ilbo_strt_date", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"작업구분", field:"ilbo_gubn", sorter:"string", width:80,
		        	hozAlign:"center", visible:false},		        
		        {title:"작업코드", field:"ilbo_code", sorter:"string", width:80,
		        	hozAlign:"center", visible:false},
		        {title:"작업LOT", field:"ilbo_lot", sorter:"string", width:100,
		        	hozAlign:"center", visible:false},
		        {title:"작업시작", field:"ilbo_strt_time", sorter:"string", width:80,
		        	hozAlign:"center"},
		        {title:"작업종료", field:"ilbo_end_time", sorter:"string", width:80,
		        	hozAlign:"center"},
		        {title:"업체명", field:"corp_name", sorter:"string", width:140,
			        hozAlign:"left", cssClass:"ellipsis-cell", tooltip:true},	
		        {title:"품명", field:"prod_name", sorter:"string", width:240,
			        hozAlign:"left", cssClass:"ellipsis-cell", tooltip:true},	
		        {title:"품번", field:"prod_no", sorter:"string", width:140,
			        hozAlign:"left", cssClass:"ellipsis-cell", tooltip:true},
		        {title:"규격", field:"prod_gyu", sorter:"string", width:160,
			        hozAlign:"left", cssClass:"ellipsis-cell", tooltip:true}, 
		        {title:"작업수량", field:"ilbo_su", sorter:"string", width:80,
		        	hozAlign:"right"},
		        {title:"작업중량", field:"ilbo_jung", sorter:"string", width:80,
		        	hozAlign:"right", visible:false},
		        {title:"비고", field:"ilbo_bigo", sorter:"string", width:130,
		        	hozAlign:"center"},
		        {title:"소입경도", field:"prod_si", sorter:"string", width:120,
			        hozAlign:"center", visible:false},
			    {title:"경화깊이", field:"prod_gd", sorter:"string", width:120, visible:false},
			    {title:"제품코드", field:"prod_code", visible:false},
			    {title:"일보코드_pc", field:"ilbo_pc", visible:false},
			    {title:"작업완료시간", field:"ilbo_end", visible:false},
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    var ilbo_end = data.ilbo_end;

			    if(ilbo_end == "1900-01-01 00:00"){
			    	row.getElement().style.backgroundColor = "#FAED7D";
			    }else{
			    	row.getElement().style.backgroundColor = "#FFFFFF";	
			    }
				
			}
		});		

	}
	
	//작업지시(단취) - 선택한 입고이력
	var workDanDataTable;	
	function getWorkDanData(){
		
		workDanDataTable = new Tabulator("#workDanTabu", {
			index:"id",
		    height:"100%",
		    layout:"fitColumns",
		    selectable:1,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:false,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
		    paginationSize:20,
		    paginationSizeSelector:[20,50,100,500,1000],
		    paginationCounter:"rows",
		    headerSort:false,
		    rowSelectionChanged:function(data, rows){
		        rows.forEach(row => {
		            row.getCell("indicator").render();
		        });
		    },
		    ajaxResponse:function(url, params, response){
				$("#workDanTabu .tabulator-col.tabulator-sortable").css("height","30px");
		        return response; //return the response data to tabulator
		    },
		    rowClick: function(e, row){
		        // 이미 선택된 행이면 아무것도 안 함
		        if(!row.isSelected()){
		            row.select();   // 다른 행 누르면 기존 자동 해제
		        }
		    },  
		    columns:[
		        {
		            title: "",
		            field: "indicator",
		            width: 20,
		            hozAlign: "center",
		            headerSort: false,
		            formatter: function(cell){
		                return "";
		            }
		        },
		    	//행 삭제
				{title:"제거", headerSort:false,
		    		formatter:rowDeleteBtn, width:100,
		    		cellClick:function(e, cell){
		    			var rowData = cell.getRow().getData();
		    			
		    			if(rowData.ilbo_code == 0){
			    			var setCount = 0;
			    			var totalCount = $("#workDanForm input[name='danch_total_cnt']").val();
			    			setCount = totalCount - (cell.getRow().getData().ilbo_su);
			    			$("#workDanForm input[name='danch_total_cnt']").val(setCount);
	
			    			cell.getRow().delete();
							alert("삭제되었습니다.");
		    			}
	    			}
				},		    	
		        {title:"바코드", field:"ord_code", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"입고일", field:"ord_input_view", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"수량", field:"ilbo_su", sorter:"string", width:80,
		        	hozAlign:"center", editor:"number",
		        	cellEdited:function(cell){
		        		var rowData = cell.getRow().getData();
		        		var ilbo_su = cell.getValue();
		        		var prod_danj = rowData.prod_danj;
		        		
		        		var ilbo_jung = 0;
		        		if(ilbo_su != 0){
		        			ilbo_jung = ilbo_su * prod_danj;
		        		}
		        		cell.getRow().getCell("ilbo_jung").setValue(ilbo_jung.toFixed(2));
		        	}
			    },		        
		        {title:"중량", field:"ilbo_jung", sorter:"string", width:120,
		        	hozAlign:"center"},
		        {title:"거래처", field:"corp_name", sorter:"string", width:140,
		        	hozAlign:"left"},
		        {title:"품명", field:"prod_name", sorter:"string", width:240,
			        hozAlign:"left"},	
		        {title:"품번", field:"prod_no", sorter:"string", width:160,
			        hozAlign:"left"},
		        {title:"소입경도", field:"prod_si", sorter:"string", width:120,
			        hozAlign:"center"},
			    {title:"경화깊이", field:"prod_gd", width:120},
			    {title:"제품코드", field:"prod_code", visible:false},
			    {title:"작업코드", field:"ilbo_code", visible:false},
			    {title:"입고단중", field:"ord_danj", visible:false},
			    {title:"제품단중", field:"prod_danj", visible:false},
		    ],
		    rowFormatter:function(row){
		        var el = row.getElement();

		        // fontWeight:700은 전역 .tabulator{font-weight:700} 규칙으로 이미 적용되어 중복 제거함

		        if(row.isSelected()){
		            el.style.backgroundColor = "#e0f3ff";
		        }else{
		            el.style.backgroundColor = "#FFFFFF";
		        }
			}
		});		
		
	}
	
	//단취작업 등록 팝업창 작업자이력
	function getWorkDanDataUserCode(){
//		user_code
		$.ajax({
			url:"/tkheat/workilbo/userList",
			type:"post",
			dataType:"json",
			data:{},
			success:function(result){
				
				var data = result.data;
				var _option = "";
				for(var i=0; i<data.length; i++){
					_option += "<option value='"+data[i].user_code+"'>"+data[i].user_name+"</option>";
				}
				
				var curVal = $("#workDanForm select[name='user_code']").val();
				$("#workDanForm select[name='user_code']").empty();
				$("#workDanForm select[name='user_code']").append(_option);
				if(danchPendingUserCode !== null){
					$("#workDanForm select[name='user_code']").val(danchPendingUserCode);
					danchPendingUserCode = null;
				}else if(curVal){
					$("#workDanForm select[name='user_code']").val(curVal);
				}
				//신규 등록시에는 현재 로그인한 사용자를 기본값으로 선택. 목록에 없으면(예: 권한범위 밖) 첫 번째 항목으로 대체
				if(!$("#workDanForm select[name='user_code']").val() && data.length > 0){
					if(tkheatLoginUserCode && $("#workDanForm select[name='user_code'] option[value='"+tkheatLoginUserCode+"']").length > 0){
						$("#workDanForm select[name='user_code']").val(tkheatLoginUserCode);
					}else{
						$("#workDanForm select[name='user_code']").val(data[0].user_code);
					}
				}
			}
		})
	}
	
	//바코드 스캔 후 수주NO로 조회시
	function getWorkDanIpgoDataBarcodeScan(){
		var barcode = $("#workDanForm input[name='danch_ord_code']").val();
		var searchObj = {
				"ord_code":barcode
		};
		
				
		$.ajax({
			url:"/tkheat/workilbo/danch/ipgoBarcodeScan",
			type:"post",
			dataType:"json",
			data:{
				"ord_code":barcode
			},
			success:function(result){
	
				workDanIpgoSelectData = result.data[0];
				workDanIpgoSelectDataReg();
			}
		});
	}
	
	//작업지시(단취) - 입고이력
	var workDanIpgoDataTable;
	function getWorkDanIpgoData(){
		
		workDanIpgoDataTable = new Tabulator("#workDanIpgoTabu", {
			index:"id",
		    height:"100%",
		    layout:"fitColumns",
		    selectable:1,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:false,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
		    paginationSize:20,
		    paginationSizeSelector:[20,50,100,500,1000],
		    paginationCounter:"rows",
		    headerSort:false,
		    rowSelectionChanged:function(data, rows){
		        // 현재 화면에 보이는 모든 행 다시 그림
		        this.getRows().forEach(function(r){
		            r.reformat();
		        });
		    },
		    rowClick: function(e, row){
		        // 이미 선택된 행이면 아무것도 안 함
		        if(!row.isSelected()){
		            row.select();   // 다른 행 누르면 기존 자동 해제
		        }
		        
		        if(e.detail === 2){

					var rData = row.getData();
					workDanIpgoSelectData = rData;
					workDanIpgoSelectDataReg();
		        	
		        }
		    },   
		    columns:[
		        {
		            title: "",
		            field: "indicator",
		            width: 20,
		            hozAlign: "center",
		            headerSort: false,
		            formatter: function(cell){
		                return cell.getRow().isSelected()
//		                    ? "<span style='font-size:16px;'>✔</span>"
		                    ? "<span style='font-size:11pt;'>▶</span>"
		                    : "";
		            }
		        },
		        {title:"수주번호", field:"ord_code", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"입고일", field:"ord_input_view", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"거래처", field:"corp_name", sorter:"string", width:140,
		        	hozAlign:"left"},		        
		        {title:"품명", field:"prod_name", sorter:"string", width:240,
		        	hozAlign:"left"},
		        {title:"품번", field:"prod_no", sorter:"string", width:140,
		        	hozAlign:"left"},
		        {title:"입고수량", field:"ord_su", sorter:"string", width:80,
			        hozAlign:"center"},	
		        {title:"단취기준수량", field:"wstd_t43", sorter:"string", width:100,
			        hozAlign:"center",
			        formatter:function(cell, formatterParams){
			        	var value = cell.getValue();
			        	if(value == 0){
			        		return "<span style='color:#ff0000; font-weight:bold;'>" + value + "</span>";
			        	}else{
			        		return value;
			        	}
			        }},	
		        {title:"단취완료수량", field:"danch_su", sorter:"string", width:100,
			        hozAlign:"center"},
		        {title:"잔량", field:"danch_remain_su", sorter:"string", width:80,
			        hozAlign:"center"},
			    {title:"제품코드", field:"prod_code", visible:false},
			    {title:"단취기준수량", field:"wstd_t43", width:80, visible:false},
			    {title:"소입경도", field:"prod_si", width:80, visible:false},
			    {title:"경화깊이", field:"prod_gd", width:80, visible:false},
			    {title:"단중", field:"prod_danj", width:80, visible:false},
			    {title:"1줄/1판", field:"wstd_t32", width:80, visible:false},
			    {title:"줄/단", field:"wstd_t33", width:80, visible:false},
			    {title:"단/Tray", field:"wstd_t41", width:80, visible:false},
			    {title:"추가수량", field:"wstd_t87", width:80, visible:false},
			    {title:"적재수량", field:"wstd_t43", width:80, visible:false},
			    {title:"Jig중량(kg)", field:"wstd_t44", width:80, visible:false},
			    {title:"제품중량(kg)", field:"wstd_t51", width:80, visible:false},
			    {title:"총중량(kg)", field:"wstd_t52", width:80, visible:false},
			    {title:"적재주의사항-1", field:"wstd_t53", width:80, visible:false},
			    {title:"적재주의사항-2", field:"wstd_t54", width:80, visible:false},
			    {title:"적재주의사항-3", field:"prod_danj", width:80, visible:false},
			    {title:"치구불량", field:"wstd_t30", width:80, visible:false},
			    
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();

			    // fontWeight:700은 전역 .tabulator{font-weight:700} 규칙으로 이미 적용되어 중복 제거함
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowDblClick:function(e, row){
/*				
				console.log(row);
				var rData = row.getData();
				workDanIpgoSelectData = rData;
				workDanIpgoSelectDataReg();
*/
//테스트
//				workDanDataTable.addData(workDanIpgoSelectData);
						
			}
		});		
	}
	
	//단취작업 저장
	function workDanModalSave(){
		if(!$("#workDanForm select[name='user_code']").val()){
			alert("작업자를 선택해주세요.");
			return;
		}

		//단취모달 리스트 데이터 조회
		var danchSettingDataList = JSON.stringify(workDanDataTable.getData());

		var formObj = {
				"user_code":$("#workDanForm select[name='user_code']").val(),
				"ilbo_strt":$("#workDanForm input[name='ilbo_strt']").val().replace("T"," ")+":00",
				"ilbo_end":$("#workDanForm input[name='ilbo_end']").val().replace("T"," ")+":00",
				"wstd_t32":$("#workDanForm input[name='wstd_t32']").val(),
				"wstd_t33":$("#workDanForm input[name='wstd_t33']").val(),
				"wstd_t41":$("#workDanForm input[name='wstd_t41']").val(),
				"wstd_t87":$("#workDanForm input[name='wstd_t87']").val(),
				"wstd_t43":$("#workDanForm input[name='wstd_t43']").val(),
				"wstd_t44":$("#workDanForm input[name='wstd_t44']").val(),
				"wstd_t51":$("#workDanForm input[name='wstd_t51']").val(),
				"wstd_t52":$("#workDanForm input[name='wstd_t52']").val(),
				"wstd_t53":$("#workDanForm input[name='wstd_t53']").val(),
				"wstd_t54":$("#workDanForm input[name='wstd_t54']").val(),
				"wstd_t30":$("#workDanForm input[name='wstd_t30']").val()
		}
		
		var formObjParam = JSON.stringify(formObj);
		
		$.ajax({
			url:"/tkheat/workilbo/danch/dataSave",
			type:"post",
			dataType:"json",
			traditional: true,
			data:{
				"danchSettingDataList":danchSettingDataList,
				"formObjParam":formObjParam
			},
			success:function(result){
				if(result.error){
					alert("저장 중 오류가 발생했습니다: "+result.error);
					return;
				}
				//모달 닫기
				workDanModalClose();
				//전체이력 조회
				getWorkDataList();
				alert("등록되었습니다.");
			}
		});
	}

	let workDanIpgoSelectData;
	let workDanIpgoSelectDataParam;
	
	//적용버튼을 눌렀을 때 -> 더블클릭으로 변경
	function workDanIpgoSelectDataReg(){
		
		
		//단취작업 모달의 form객체 조회
//		var danchForm = new FormData($("#workDanForm")[0]);		
		var danchForm = $("#workDanForm").serialize();		
		//ajax로 선입과 전송한 데이터 확인 후 데이터 이동		
		workDanIpgoSelectDataParam = JSON.stringify(workDanIpgoSelectData);
//		workDanIpgoSelectDataParam = workDanIpgoSelectData;
		
		//단취정보 저장할 리스트
		var danchSettingDataList = JSON.stringify(workDanDataTable.getData());
//		var danchSettingDataList = JSON.stringify(workDanIpgoDataTable.getData()); //테스트
		
		var danch_sunip_chk_val = 0;
		if($("#workDanForm input[name='danch_sunip_chk']").is(":checked")){
			danch_sunip_chk_val = 1;
		}

		var stdObj = {
			"danch_total_cnt":$("#workDanForm input[name='danch_total_cnt']").val(),
			"danch_std_cnt":$("#workDanForm input[name='danch_std_cnt']").val(),
			"danch_sunip_chk":danch_sunip_chk_val,
			"danch_sunip_chk_pw":$("#workDanForm input[name='danch_sunip_chk_pw']").val(),
		};
		
		
		var stdObjParam = JSON.stringify(stdObj);
		
		$.ajax({
			url:"/tkheat/workilbo/danch/ipgoList/dataSetting",
			type:"post",
			dataType:"json",
			traditional: true,
//	        contentType: false,
//	        processData: false,			
			data:{
				"workDanIpgoSelectDataParam":workDanIpgoSelectDataParam,
				"stdObjParam":stdObjParam,
				"danchSettingDataList":danchSettingDataList
			},
			success:function(result){
				
				if(result.alert == "정상"){
					workDanDataTable.addData(result.selectMap);
					
					var stdMap = result.stdMap;
					
					for(let key in stdMap){
						if(key != "danch_sunip_chk_pw" && key != "danch_sunip_chk"
								&& key != "ilbo_strt" && key != "ilbo_end"){
							$("#workDanForm input[name='"+key+"']").val(stdMap[key]);
						}
						
						//제품사진
						if(key == "product_file_name"){
							$("#workDanForm img[name='"+key+"']").attr("src","/tkPrint/productImg/"+stdMap[key]);
						}
						
						//단취사진
						if(key == "wstd_chim_file_name1"){
							$("#workDanForm img[name='"+key+"']").attr("src","/tkPrint/workStdImg/"+stdMap[key]);
						}
						
					}

					var selectOrdCode = result.selectOrdCode;
					
					workDanIpgoDataTable.getRows().forEach(row => {
						  if (row.getData().ord_code === selectOrdCode) {
						    row.delete();
						  }
					});
					
					sdateTimeSetBtn("danchStart");
					alert("목록에 추가되었습니다.");
					
					
				}else{
					alert(result.alert);
					console.log(result.sunipList);
					return false;
				}
			}
		});	
		
	}
	
	function getWorkDanIpgoDataList(){
		//단취정보 저장할 리스트
		var danchSettingDataList = JSON.stringify(workDanDataTable.getData());
		
		var searchObj = {
				"dan_ipgo_cname":$("#dan_ipgo_cname").val(),
				"dan_ipgo_pname":$("#dan_ipgo_pname").val(),
				"dan_ipgo_pno":$("#dan_ipgo_pno").val(),
				"dan_ipgo_sdate":$("#dan_ipgo_sdate").val(),
				"dan_ipgo_edate":$("#dan_ipgo_edate").val()
		};
		
		var searchObjParam = JSON.stringify(searchObj);
		
		$.ajax({
			url:"/tkheat/workilbo/danch/ipgoList",
			type:"post",
			dataType:"json",
			traditional: true,
			data:{
				"danchSettingDataList":danchSettingDataList,
				"searchObjParam":searchObjParam
			},
			success:function(result){
				workDanIpgoDataTable.setData(result.data);
			}
		});
	}

	function processOrderStatusCloseBtn(){
		processOrderStatusModal.style.display = 'none'; // 모달 숨김
	}

	function processOrderReportCloseBtn(){
		processOrderReportModal.style.display = 'none'; // 모달 숨김
	}

	//모달기능
	const workDanModal = document.querySelector('.workDanModal');
	const workDanIpgoModal = document.querySelector('.workDanIpgoModal');
	const workDanSunipModal = document.querySelector('.workDanSunipModal');
	const processOrderStatusModal = document.querySelector('.processOrderStatusModal');
	const processOrderReportModal = document.querySelector('.processOrderReportModal');	
	// 헤더를 드래그할 요소로 사용 -> 모달이 여러 개이므로 각 헤더마다 자신이 속한 모달을 찾아 개별적으로 드래그 처리
	document.querySelectorAll('.header').forEach(function(header){
		header.addEventListener('mousedown', function(e) {
			const modal = header.closest('.workDanModal, .workDanIpgoModal, .workDanSunipModal, .processOrderStatusModal, .processOrderReportModal');
			if(!modal){ return; }

			// transform 제거를 위한 초기 위치 설정
			const rect = modal.getBoundingClientRect();
			modal.style.left = rect.left + 'px';
			modal.style.top = rect.top + 'px';
			modal.style.transform = 'none'; // 중앙 정렬 해제

			let offsetX = e.clientX - rect.left;
			let offsetY = e.clientY - rect.top;

			function moveModal(e) {
				modal.style.left = (e.clientX - offsetX) + 'px';
				modal.style.top = (e.clientY - offsetY) + 'px';
			}

			function stopMove() {
				window.removeEventListener('mousemove', moveModal);
				window.removeEventListener('mouseup', stopMove);
			}

			window.addEventListener('mousemove', moveModal);
			window.addEventListener('mouseup', stopMove);
		});
	});

	
    </script>

	</body>
</html>
