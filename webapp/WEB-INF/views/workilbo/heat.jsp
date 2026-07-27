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
/* nbsp로 간격 맞추던 옛 방식 대체 (gap이 대신 처리) */
.margin_left {
	margin-left: 0 !important;
}
.datetimepicker_date,
.search_input,
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
.box1 select:focus,
.box1 input:focus {
	border-color: #3182CE;
	background-color: #fff;
}
.datetimepicker_date {
	width: 140px !important;
	text-align: center;
}
.search_input {
	width: 140px !important;
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

/* 호기(설비) 선택 버튼 - 활성/비활성 배경은 selectHogiBtn() JS에서 동적으로 지정 */
.select-hogi-button.select-button {
	height: 34px;
	padding: 0 16px;
	border: 1px solid #E2E8F0;
	border-radius: 8px;
	background: #F0F4F8;
	font-size: 12px;
	font-weight: 600;
	color: #2D3748;
	transition: background-color .13s, border-color .13s;
}
.select-hogi-button.select-button:hover {
	background: #EBF8FF;
	border-color: #BEE3F8;
}

/* ========== 모달 공통 (management 쪽 모달과 동일한 톤) ========== */
.workBcfModal,
.workBcfDanchModal,
.checkSheetStatusModal,
.checkSheetReportModal {
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
/* 작업대기 리스트 모달은 열처리작업 모달 위에 얹히므로 z-index를 한 단계 더 높게 */
.workBcfDanchModal {
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
	flex-shrink: 0;
}
.workBcfModal .detail,
.workBcfDanchModal .detail,
.checkSheetStatusModal .detail {
	flex: 1;
	min-height: 0;
	overflow-y: auto;
	display: flex;
	flex-direction: column;
	gap: 8px;
	background: #f5f7fa;
	padding: 10px 14px;
	box-sizing: border-box;
}
/* 목록(#workBcfDanchTabu)이 남는 세로공간을 모두 흡수하도록 하여, 검색줄 등 정적
   콘텐츠 때문에 생기던 모달 레벨의 불필요한 스크롤을 없앰. 행이 많아 넘칠 때는
   타뷸레이터가 자체적으로 스크롤을 보여줌(모달 레벨 스크롤과는 별개) */
.workBcfDanchModal .detail > .j_container:last-of-type,
.workBcfDanchModal .setRow{
	flex: 1;
	min-height: 0;
	display: flex;
	flex-direction: column;
}
.workBcfDanchModal #workBcfDanchTabu{
	flex: 1;
	min-height: 0;
}
.btnSaveClose {
	display: flex;
	justify-content: center;
	gap: 12px;
	padding: 14px 0;
	background: #ffffff;
	border-top: 1px solid #E2E8F0;
	margin: 0;
	flex-shrink: 0;
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

/* ========== 모달 내 공용 유틸 클래스 ========== */
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
.iRowBtn2 {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	cursor: pointer;
	width: 140px;
	height: 32px;
	font-size: 12px;
	font-weight: 600;
	border: 1px solid #E2E8F0;
	border-radius: 6px;
	background: #F0F4F8;
	color: #2D3748;
	transition: background-color .13s, border-color .13s;
}
.iRowBtn2:hover {
	background: #EBF8FF;
	border-color: #BEE3F8;
}
.iRowLabel{
	display:block;
	width:120px;
	height:20px;
	text-align:center;
	margin-bottom:2px;
	font-size:12pt;
}
.iRowLabel2{
	display:block;
	width:120px;
	height:24px;
	text-align:left;
	margin-bottom:7px;
	font-size:12pt;
	margin-left:10px;
}
.iRowInput{
	width:120px !important;
	height:30px;
	font-size:12pt;
	text-align:center;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	box-sizing: border-box;
}
.iRowInput2{
	display:block;
	width:120px !important;
	height:28px;
	font-size:12pt;
	text-align:center;
	margin-bottom:5px;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	box-sizing: border-box;
}
.iRowInput_180{
	width:180px !important;
	height:32px;
	font-size:12pt;
	text-align:center;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	box-sizing: border-box;
}
.j_h_div{
	width:130px;
}

/*침탄로작업 등록 모달*/
.workBcfModal{
	width:1400px;
	height:760px;
	flex-direction: column;
}
.workBcfModal .j_container{
	display:flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}
.workBcfModal .j_row1{
	display:flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}
/* 폼 내부 섹션(행) 간 세로 리듬 통일: <hr> 기본 여백 대신 gap 8px로 일괄 처리
   (기존에는 <hr> 앞뒤로는 브라우저 기본 마진이 생기고, 일반 div끼리는 여백이 0이라
   구간마다 위/아래 여백이 들쭉날쭉해 "단차"처럼 보였음) */
.workBcfModal #workBcfForm,
.workBcfModal .bcfInfo0,
.workBcfModal .bcfInfo1,
.workBcfModal .bcfInfo2 {
	display: flex;
	flex-direction: column;
	gap: 8px;
}
.workBcfModal #workBcfForm{
	flex: 1;
	min-height: 0;
}
.workBcfModal #workBcfForm hr {
	width: 100%;
	margin: 0;
	border: none;
	border-top: 1px solid #E2E8F0;
}
/* 목록(#workBcfTabu)이 남는 세로공간을 모두 흡수하도록 하여, 조건 입력 영역 등 정적
   콘텐츠 때문에 생기던 모달 레벨의 불필요한 스크롤을 없앰. 행이 많아 넘칠 때는
   타뷸레이터가 자체적으로 스크롤을 보여줌(모달 레벨 스크롤과는 별개) */
.workBcfModal .setRow{
	flex: 1;
	min-height: 0;
	display: flex;
	flex-direction: column;
}
.workBcfModal #workBcfTabu{
	flex: 1;
	min-height: 0;
}

/*열처리 대기이력(작업대기 리스트)*/
.workBcfDanchModal{
	width:1300px;
	height:750px;
	flex-direction: column;
}
/* 검색줄 라벨(거래처/품명/품번)이 120px 고정폭이라 인풋+버튼까지 합치면 모달 폭을 살짝
   넘겨서 조회버튼만 다음 줄로 밀려나던 문제 -> 라벨을 텍스트 크기에 맞게 축소 */
.workBcfDanchModal .iRowLabel{
	width:auto;
	min-width:0;
	padding:0 2px;
}
.workBcfDanchModal .j_container{
	display:flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}
.workBcfDanchModal .j_row1{
	display:flex;
	flex-wrap: wrap;
	align-items: center;
	gap: 8px;
}

/* ========== 모달 내 리스트(#workBcfTabu / #workBcfDanchTabu) ========== */
#workBcfTabu.tabulator,
#workBcfDanchTabu.tabulator {
	border: 1px solid #E2E8F0;
	border-radius: 8px;
	font-size: 12px;
}
#workBcfTabu .tabulator-header,
#workBcfDanchTabu .tabulator-header {
	background: linear-gradient(135deg, #2B6CB0, #3182CE);
	border-bottom: none;
}
#workBcfTabu .tabulator-col,
#workBcfDanchTabu .tabulator-col {
	background: transparent;
	border-right: 1px solid rgba(255,255,255,.15);
}
#workBcfTabu .tabulator-col-title,
#workBcfDanchTabu .tabulator-col-title {
	color: #ffffff;
	font-weight: 700;
}
#workBcfTabu .tabulator-row,
#workBcfDanchTabu .tabulator-row {
	border-bottom: 1px solid #EDF2F7;
	transition: background-color .12s;
}
#workBcfTabu .tabulator-row.tabulator-row-even,
#workBcfDanchTabu .tabulator-row.tabulator-row-even {
	background-color: #F7FAFC;
}
#workBcfTabu .tabulator-row:hover,
#workBcfDanchTabu .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#workBcfTabu .tabulator-cell,
#workBcfDanchTabu .tabulator-cell {
	border: 1px solid #E2E8F0;
	color: #2D3748;
}
#workBcfTabu .tabulator-footer,
#workBcfDanchTabu .tabulator-footer {
	background: #F7FAFC;
	border-top: 1px solid #E2E8F0;
	padding: 6px 10px;
}
#workBcfTabu .tabulator-page,
#workBcfDanchTabu .tabulator-page {
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
#workBcfTabu .tabulator-page.active,
#workBcfDanchTabu .tabulator-page.active {
	background: #3182CE;
	border-color: #2B6CB0;
	color: #ffffff;
}
#workBcfTabu .tabulator-page:not(:disabled):hover,
#workBcfDanchTabu .tabulator-page:not(:disabled):hover {
	background: #EBF8FF;
	border-color: #BEE3F8;
	color: #2B6CB0;
	cursor: pointer;
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

.checkSheetStatusModal {
	width:350px;
	height:200px;
}

.checkSheetReportModal {
	width:850px;
	height:800px;
	flex-direction: column;
	padding: 14px;
	gap: 10px;
	box-sizing: border-box;
}

.checkSheetStatusModal .j_container[style*="justify-content:end"],
.checkSheetReportModal .j_container[style*="justify-content:end"] {
	padding: 0 14px 14px;
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
				<input type="text" id="s_all_corp_name" class="search_input">
				<label class="daylabel">품명 :</label>
				<input type="text" id="s_all_prod_name" class="search_input">
				<label class="daylabel">품번 :</label>
				<input type="text" id="s_all_prod_no" class="search_input">
			</div>
		</form>
	</div>
    <div class="button-container">
        <button class="select-button" onClick="getWorkDataList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           검색
        </button>
        <button class="insert-button" onclick="workBcfModalOpen();">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
            신규
        </button>
        <button class="delete" id="workDeleteBtn">
            <img src="/tkheat/css/image/delete-icon.png" alt="delete" class="button-image">
            삭제
        </button>
        
        <button class="printer-button" id="printBtn">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
			 체크시트            
        </button>
    </div>
</div>
<div class="tab">
    <div class="button-container" style="margin-left:20px;">
        <button class="select-hogi-button select-button" type="button" onclick="selectHogiBtn(0);" id="selectHogi0">
            전체호기
        </button>
        <button class="select-hogi-button select-button" type="button" onclick="selectHogiBtn(1);" id="selectHogi1">
            침탄로 1호기
        </button>
        <button class="select-hogi-button select-button" type="button" onclick="selectHogiBtn(2);" id="selectHogi2">
            침탄로 2호기
        </button>
        <button class="select-hogi-button select-button" type="button" onclick="selectHogiBtn(3);" id="selectHogi3">
            침탄로 3호기
        </button>
        <button class="select-hogi-button select-button" type="button" onclick="selectHogiBtn(4);" id="selectHogi4">
            침탄로 4호기
        </button>
        <button class="select-hogi-button select-button" type="button" onclick="selectHogiBtn(18);" id="selectHogi18">
            침탄로 5호기
        </button>
	</div>
</div>
<main class="main">
	<div class="container">
		<div id="workTabu"></div>
	</div>
</main>
	    
<!-- 다이얼로그 -->

<!-- 열처리작업 모달 -->
<div class="workBcfModal">
	<div class="detail">
		<div class="header">
		열처리작업 등록
		</div>

		<form id="workBcfForm" name="workBcfForm" autocomplete="off">
			<div class="j_container">
				<!-- 수주no 바코드스캔 후 적용과 입고이력을 조회한다음 추가하는 방법 2가지 -->				
				<label for="" class="iRowLabel">바코드</label>
				<input type="text" id="bcf_barcode" name="bcf_barcode" class="iRowInput_180"/>
				<button class="iRowBtn margin_left" type="button" onclick="workBcfDanchModalOpen();">검색</button>
				<label for="" class="iRowLabel">생산NO</label>
				<input type="text" id="bcf_ilbo_lot" name="bcf_ilbo_lot" class="iRowInput_180"/>
				<button class="iRowBtn margin_left" type="button" onclick="getWorkBcfIlboLotReset();">제거</button>				
							
									
			</div>	
			<div class="setRow">
				<div id="workBcfTabu"></div>
			</div>
			<hr />
		<div class="j_container">				
			<div class="j_row1">
				<div class="j_div">
					<label for="fac_code" class="iRowLabel" style="height:30px;">설비</label>
					<select name="fac_code" class="iRowInput" style="height:30px; width:130px !important;"></select>						
				</div>
				
				<div class="j_div">
					<label for="user_code" class="iRowLabel margin_left" style="height:30px;">작업자</label>
					<select name="user_code" class="iRowInput margin_left" style="height:30px;"></select>						
				</div>
				
				<div class="j_div">
					<label for="wstd_t32" class="iRowLabel margin_left" style="width:240px; height:30px;">작업시작</label>
					<input type="text" name="ilbo_strt" class="iRowInput margin_left datetimepicker_datetime" style="width:240px !important; height:25px;"/>
				</div>
				
				<div class="j_div" style="width:80px;">
					<label for="" class="iRowLabel margin_left" style="height:30px;"></label>
					<button class="iRowBtn margin_left" type="button" 
					onclick="sdateTimeSetBtn('bcfStart');"
					style="display:inline-block;">시작</button>
				</div>
				
				<div class="j_div">
					<label for="wstd_t32" class="iRowLabel margin_left" style="width:240px; height:30px;">작업종료</label>
					<input type="text" name="ilbo_end" class="iRowInput margin_left datetimepicker_datetime" style="width:240px !important; height:25px;"/>
				</div>
				
				<div class="j_div" style="width:80px;">
					<label for="" class="iRowLabel margin_left" style="height:30px;"></label>
					<button class="iRowBtn margin_left" type="button" 
					onclick="sdateTimeSetBtn('bcfEnd');"
					style="display:inline-block;">종료</button>
				</div>

				<div class="j_div">
					<label for="" class="margin_left iRowLabel" style="height:30px;">총 수량</label>
					<input type="text" name="bcf_total_cnt" class="margin_left iRowInput" value="0" disabled="disabled" style="height:25px;"/>				
				</div>
				
				<div class="j_div">
					<label for="" class="margin_left iRowLabel" style="height:30px;">총 중량</label>
					<input type="text" name="bcf_total_weight" class="margin_left iRowInput" value="0" disabled="disabled" style="height:25px;"/>				
				</div>
			</div>
		</div>		
		<hr />		
			
		<div class="j_container" style="justify-content:left; font-size:14pt;">
			<div class="j_row1">
				<button class="iRowBtn2 margin_left bcfInfoBtn0" type="button" onClick="bcfModalSet(0);">열처리조건</button>
				<button class="iRowBtn2 margin_left bcfInfoBtn1" type="button" onClick="bcfModalSet(1);">자주검사</button>			
				<button class="iRowBtn2 margin_left bcfInfoBtn2" type="button" onClick="bcfModalSet(2);">과거불량이력</button>			
			</div>			
		</div>
		<hr />
		
		<div class="bcfInfo0">
			
			<div class="j_container" style="justify-content:center; font-size:14pt;">
				<div class="j_row1">*열처리조건*</div>			
			</div>
			<hr />
		
		
			<div class="j_container">
				<div class="j_row1">
					<div class="j_div">
						<label class="iRowLabel2"></label>
						<label class="iRowLabel2">온도</label>
						<label class="iRowLabel2">시간</label>
						<label class="iRowLabel2">CP</label>
						<label class="iRowLabel2">H2[㎥/Hr]</label>
						<label class="iRowLabel2">NH3[㎥/Hr]</label>
						<label class="iRowLabel2">RX</label>
					</div>
					<div class="j_div">
						<label class="iRowLabel2" 
							style="text-align:center; margin-left:0; background:beige;
							border:1px solid black; width: 125px;"
						>예열</label>
						<input type="text" name="wstd_gj11" class="iRowInput2"/>					
						<input type="text" name="wstd_gj21" class="iRowInput2"/>
						<input type="text" name="wstd_gj31" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>	
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="wstd_gj42" class="iRowInput2"/>					
					</div>
					
					<div class="j_div margin_left">
						<label class="iRowLabel2" 
							style="text-align:center; margin-left:0; background:beige;
							border:1px solid black; width: 125px;"
						>침탄</label>
						<input type="text" name="wstd_gj12" class="iRowInput2"/>					
						<input type="text" name="wstd_gj22" class="iRowInput2"/>
						<input type="text" name="wstd_gj32" class="iRowInput2"/>
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>	
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>	
						<label class="iRowLabel2">LPG</label>				
					</div>
					
					<div class="j_div margin_left">
						<label class="iRowLabel2" 
							style="text-align:center; margin-left:0; background:MEDIUMSEAGREEN;
							border:1px solid black; width: 125px;"
						>확산</label>
						<input type="text" name="wstd_gj13" class="iRowInput2"/>					
						<input type="text" name="wstd_gj23" class="iRowInput2"/>
						<input type="text" name="wstd_gj33" class="iRowInput2"/>
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>	
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>		
					</div>
					
					<div class="j_div margin_left">
						<label class="iRowLabel2" 
							style="text-align:center; margin-left:0; background:lightskyblue;
							border:1px solid black; width: 125px;"
						>강온</label>
						<input type="text" name="wstd_gj14" class="iRowInput2"/>					
						<input type="text" name="wstd_gj24" class="iRowInput2"/>
						<input type="text" name="wstd_gj34" class="iRowInput2"/>
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>	
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>
						<label class="iRowLabel2">교반속도</label>				
					</div>
					
					<div class="j_div margin_left">
						<label class="iRowLabel2" 
							style="text-align:center; margin-left:0; background:lightpink;
							border:1px solid black; width: 125px;"
						>균열</label>
						<input type="text" name="wstd_gj15" class="iRowInput2" disabled="disabled"/>					
						<input type="text" name="wstd_gj25" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="wstd_gj35" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>	
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="wstd_gj17" class="iRowInput2"/>				
					</div>
					
					<div class="j_div margin_left">
						<label class="iRowLabel2" 
							style="text-align:center; margin-left:0; background:lightpink;
							border:1px solid black; width: 125px;"
						>냉각</label>
						<input type="text" name="wstd_gj16" class="iRowInput2"/>
						<input type="text" name="wstd_gj26" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="wstd_gj36" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>
						<input type="text" name="" class="iRowInput2" disabled="disabled"/>
					</div>
					
				</div>
			</div>
		</div>
		<div class="bcfInfo1">
			<div class="j_container" style="justify-content:center; font-size:14pt;">
				<div class="j_row1">*자주검사*</div>			
			</div>
			<hr />
			<div class="j_container">
				<div class="j_row1">
					<div class="j_div">
						<label class="iRowLabel2">spec</label>
					</div>
					<div class="j_div">
						<input type="text" name="prod_si" class="iRowInput2" style="width:500px !important;" readonly="readonly"/>					
					</div>
 					
					<div class="j_div">
						<input type="text" name="prod_si1" class="iRowInput2 margin_left" style="width:50px !important; display:none;" readonly="readonly"/>				
					</div>
					<div class="j_div">
						<input type="text" name="prod_si1_msg" class="iRowInput2 margin_left" style="width:140px !important; display:none;" readonly="readonly"/>				
					</div>
					<div class="j_div">
						<input type="text" name="prod_si2" class="iRowInput2 margin_left" style="width:50px !important; display:none;" readonly="readonly"/>				
					</div>
					<div class="j_div">
						<input type="text" name="prod_si2_msg" class="iRowInput2 margin_left" style="width:140px !important; display:none;" readonly="readonly"/>				
					</div>

				</div>
			</div>
			
			
			<div class="j_container">
				<div class="j_row1">
					<div class="j_div">
						<label class="iRowLabel2"> </label>
					</div>
					<div class="j_div">
						<label class="iRowLabel" style="width:130px !important;">X1</label>
					</div>
					<div class="j_div">
						<label class="iRowLabel" style="width:130px !important;">X2</label>
					</div>
					<div class="j_div">
						<label class="iRowLabel" style="width:130px !important;">X3</label>
					</div>
					<div class="j_div">
						<label class="iRowLabel" style="width:130px !important;">X4</label>
					</div>
					<div class="j_div">
						<label class="iRowLabel" style="width:130px !important;">X5</label>
					</div>
					<div class="j_div">
						<label class="iRowLabel" style="width:130px !important;">판정</label>
					</div>
				</div>
			</div>
			<div class="j_container">
				<div class="j_row1">
					<div class="j_div">
						<label class="iRowLabel2">소입검사</label>
					</div>
					<div class="j_div">
						<input type="text" name="ilbo_pg1" class="iRowInput bcf_hard_input"/>
					</div>
					<div class="j_div">
						<input type="text" name="ilbo_pg2" class="iRowInput margin_left bcf_hard_input"/>
					</div>
					<div class="j_div">
						<input type="text" name="ilbo_pg3" class="iRowInput margin_left bcf_hard_input"/>
					</div>
					<div class="j_div">
						<input type="text" name="ilbo_pg4" class="iRowInput margin_left bcf_hard_input"/>
					</div>
					<div class="j_div">
						<input type="text" name="ilbo_pg5" class="iRowInput margin_left bcf_hard_input"/>
					</div>
					<div class="j_div">
						<select name="ilbo_okng" class="iRowInput2 margin_left" style="height:27px;">
							<option value="대기">대기</option>
							<option value="합격">합격</option>
							<option value="불합격">불합격</option>
						</select>					
					</div>
				</div>
			</div>
			<div class="j_container">
				<div class="j_row1">
					<div class="j_div">
						<label class="iRowLabel2">전달사항</label>
					</div>
					<div class="j_div">					
						<input type="text" name="ilbo_bigo" class="iRowInput2" style="width:650px !important;"/>
					</div>
				</div>
			</div>
			<hr />
			<div class="j_container">
				<div class="j_row1">
					<div class="j_div">
						<label class="iRowLabel2" style="width:210px !important;">바스켓(파손,변형없을것)</label>						

					</div>
					<div class="j_div">
						<select name="ilbo_ck01" class="iRowInput2 margin_left" style="height:27px;">
							<option value="양호">양호</option>
							<option value="불량">불량</option>
						</select>					
					</div>
					<div class="j_div">
						<label class="iRowLabel2" style="width:140px !important;">체인(변형,파손)</label>
					</div>
					<div class="j_div">
						<select name="ilbo_ck02" class="iRowInput2 margin_left" style="height:27px;">
							<option value="X">X</option>
							<option value="O">O</option>
						</select>					
					</div>

				</div>
			</div>	
			<div class="j_container">
				<div class="j_row1">
					<div class="j_div">
						<label class="iRowLabel2" style="width:210px !important;">부품혼입</label>						

					</div>
					<div class="j_div">
						<select name="ilbo_ck03" class="iRowInput2 margin_left" style="height:27px;">
							<option value="X">X</option>
							<option value="O">O</option>
						</select>					
					</div>
					<div class="j_div">
						<label class="iRowLabel2" style="width:140px !important;">L/S(변형,파손)</label>
					</div>
					<div class="j_div">
						<select name="ilbo_ck04" class="iRowInput2 margin_left" style="height:27px;">
							<option value="X">X</option>
							<option value="O">O</option>
						</select>					
					</div>
					<div class="j_div">
						<label class="iRowLabel2" style="width:140px !important;">레일(변형,파손)</label>
					</div>
					<div class="j_div">
						<select name="ilbo_ck05" class="iRowInput2 margin_left" style="height:27px;">
							<option value="X">X</option>
							<option value="O">O</option>
						</select>					
					</div>

				</div>
			</div>	
		</div>
		
		<div class="bcfInfo2">
			<div class="j_container" style="justify-content:center; font-size:14pt;">
				<div class="j_row1">*과거불량이력*</div>
			</div>
			<hr />
		</div>
	</form>
	</div>

    <div class="btnSaveClose">
		<button class="save" type="button" onclick="workBcfModalSave();">저장</button>
		<button class="close" type="button" onclick="workBcfModalClose();">닫기</button>
    </div>
</div>

<div class="workBcfDanchModal">
	<div class="detail">
		<div class="header">
		작업대기 리스트
		</div>

		<div class="j_container">
			<form id="workBcfDanchForm" name="workBcfDanchForm" autocomplete="off" style="width:100%;">
				<div class="j_row1">
					<label class="daylabel">입고일 :</label>
					<input type="text" id="bcf_danch_sdate" class="datetimepicker_date">
					~
					<input type="text" id="bcf_danch_edate" class="datetimepicker_date">

					<label for="" class="iRowLabel margin_left">거래처</label>
					<input type="text" id="bcf_danch_cname" class="search_input bcf_danch_input"/>
					<label for="" class="iRowLabel margin_left">품명</label>
					<input type="text" id="bcf_danch_pname" class="search_input bcf_danch_input"/>
					<label for="" class="iRowLabel margin_left">품번</label>
					<input type="text" id="bcf_danch_pno" class="search_input bcf_danch_input"/>
					<button class="iRowBtn margin_left" type="button" onclick="getWorkBcfDanchDataList();">조회</button>
				</div>
				<div class="j_row1" style="justify-content: end;">
					<span style="color:red;" class="margin_left">*적색 행은 단취완료가 안된 작업입니다!!</span>
				</div>
			</form>
		</div>

		<div class="j_container">
			<div class="setRow">
				<div id="workBcfDanchTabu"></div>
			</div>
		</div>
	</div>

    <div class="btnSaveClose">
		<button class="close" type="button" onclick="workBcfDanchModalClose();">닫기</button>
    </div>
</div>

<!-- 열처리 체크시트 출력중 모달 -->
<div class="checkSheetStatusModal">
	<div class="detail">
		<div class="header">
			<span style="display:inline-block; width:180px;">열처리 체크시트</span>
		</div>
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<span style="display:inline-block; width:350px;">열처리 체크시트 파일 생성중입니다....</span>
					<br />
					<span style="display:inline-block; width:350px;">생성완료시 팝업창이 닫힙니다.</span>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="checkSheetStatusClose iRowBtn margin_left" type="button" onclick="checkSheetStatusCloseBtn();">닫기</button>
		</div>
    </div>	
</div>

	
<!-- 열처리체크시트 표현 모달 -->
<div class="checkSheetReportModal">
	<div class="j_container">
		<iframe src="" frameborder="0" width="800" height="700" id="checkSheetReport">
		</iframe>	
	</div>
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="checkSheetReportClose iRowBtn margin_left" type="button" onclick="checkSheetReportCloseBtn();">닫기</button>
		</div>
    </div>
</div>


<form id="reportPrint" name="reportPrint">
	<input type="text" id="reportDate" name="reportDate" style="display:none;"/>
	<input type="text" id="reportBarcode" name="reportBarcode" style="display:none;"/>
	<input type="text" id="reportPlnpLot" name="reportPlnpLot" style="display:none;"/>
</form>

<input type="number" id="s_fac_code" value="0" style="display:none;" />

<a style="display:none;" id="downLoadLink" href="#" download="#"></a>
	
<script>
	//전역변수
    var cutumTable;	
    let now_page_code = "i03";
	
    var danchSdateTime, danchEdateTime;
    var setIlboCode = 0;
    
	//로드
	$(function(){
		//전체 거래처목록 조회
		var tdate = todayDate();

		$("#s_all_sdate").val(tdate);
		$("#s_all_edate").val(tdate);
		
		getWorkData();
		
		selectHogiBtn(0);
//		getWorkDataList();


	});

	//이벤트
	
	//열처리 체크시트 출력
	$("#printBtn").on("click",function(e){
		var selectedData = workDataTable.getSelectedData();
		
		if(selectedData.length <= 0){
			alert("체크시트를 출력할 작업LOT를 선택해주십시오!");
			return false;
		}
		
		checkSheetStatusModal.style.display = "block";

		var sendObj = {
				"checkSheetData": selectedData
			}

		//선택한 객체 전송
		$.ajax({
			url:"/tkheat/workilbo/checkSheetPrint",
			type:"post",
			dataType:"json",
			contentType: false,
			processData: false,			
			data:JSON.stringify(sendObj),
			success:function(result){
   				var fileUrl = "/tkPrint/workilboCheckSheet/"+result.fileName;
                $("#checkSheetReport").attr("src",fileUrl);
                checkSheetReportModal.style.display = "flex";
				
                checkSheetStatusCloseBtn();
//				getChulgoData();
			}
		});
		
	});
	
	$(".bcf_danch_input").on("keydown", function(e){
		if(e.keyCode == 13){
			getWorkBcfDanchDataList();
		}
	});

	//바코드 스캔
	var barcodeTimer;
	$("#bcf_barcode").on("input", function(){
		clearTimeout(barcodeTimer);
		var $this = $(this);
		
		barcodeTimer = setTimeout(function(){
			if($this.val().length > 9){
				
				var danch_barcode = $("#bcf_barcode").val();

				var selectedData = {
						"danch_barcode":danch_barcode					
				};
				
				var selectedDataParam = JSON.stringify(selectedData);
				
				$.ajax({
					url:"/tkheat/workilbo/heat/bcfDataSearch",
					type:"post",
					dataType:"json",
					traditional: true,
					data:{"selectedDataParam":selectedDataParam},
					success:function(result){

	
						//작업가능한 바코드인지 확인

						var bcf_total_cnt = 0;		//총 수량
						var bcf_total_weight = 0;	//총 중량
						
						workBcfDataTable.setData(result.data);

						var facCode = $("#workBcfForm select[name='fac_code']").val();
						
						setIlboCode = result.data[0].ilbo_code;
						
						ilboLotRtn(facCode);
						
						var rowDatas = result.data;
						
						for(var keys in rowDatas){
							var rowData = rowDatas[keys];
							for(var key in rowData){
								if(key != "ilbo_strt" && key != "ilbo_end"){
									if(key == "ilbo_su"){
										bcf_total_cnt += rowData[key];
									}
									if(key == "ilbo_jung"){
										bcf_total_weight += rowData[key];
									}
									$("#workBcfForm input[name='"+key+"']").val(rowData[key]);
								}
							}
						}
						
						$("#workBcfForm input[name='bcf_total_cnt']").val(bcf_total_cnt);
						$("#workBcfForm input[name='bcf_total_weight']").val(bcf_total_weight.toFixed(2));

					}
				});
	
			}
		}, 200);
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
	
	$("#workBcfForm select[name='fac_code']").change(function(){
		ilboLotRtn(facNumberRtn(this.value));
	});
	
	
	$(".bcf_hard_input").on("input", function(e){
		var name = $(this).attr("name");
		var value = $(this).val();
		var std1 = $("#workBcfForm input[name='prod_si1_msg']").val();
		var std2 = $("#workBcfForm input[name='prod_si2_msg']").val();
		var stdVal1 = $("#workBcfForm input[name='prod_si1']").val();
		var stdVal2 = $("#workBcfForm input[name='prod_si2']").val();
		
		if(std1 == "정상(순수숫자)"){
			//stdVal1로만 계산
			bcfHardInputCalc(name, value, stdVal1, stdVal2);
		}
	});
	
	let bcfHardInputOKNGObj = {
			"ilbo_pg1":"0",
			"ilbo_pg2":"0",
			"ilbo_pg3":"0",
			"ilbo_pg4":"0",
			"ilbo_pg5":"0"
	}
	
	function bcfHardInputCalc(name, value, stdVal1, stdVal2){
		
		var inputColor = 0;
		if(value != "" && value != null){
			if(stdVal1 != ""){
				if(stdVal2 == ""){
					//경도규격이 하한만 있을 경우
					if(value >= stdVal1){
						inputColor = 1;
					}else{
						inputColor = 2;
					}
				}else{
					if(value >= stdVal1 && value <= stdVal2){
						inputColor = 1;
					}else{
						inputColor = 2;
					}
				}
			}
		}else{
			inputColor = 0;
		}

		bcfHardInputOKNGObj[name] = inputColor;

		bcfHardInputOKNG();
		switch (inputColor){
			case 0 : $("#workBcfForm input[name='"+name+"']").css("background-color","#FFFFFF"); 
					break;
			case 1 : $("#workBcfForm input[name='"+name+"']").css("background-color","#D9E5FF"); 
					break;
			case 2 : $("#workBcfForm input[name='"+name+"']").css("background-color","#FFD8D8"); 
					break;
		}
	}
	
	function bcfHardInputOKNG(){
		var valSum = 0;
		
		for(var obj in bcfHardInputOKNGObj){
			valSum += bcfHardInputOKNGObj[obj];
			if(bcfHardInputOKNGObj[obj] == 2){
				//불합격
				$("#workBcfForm select[name='ilbo_okng']").val("불합격");
				break;
			}else if(bcfHardInputOKNGObj[obj] == 1){
				$("#workBcfForm select[name='ilbo_okng']").val("합격");
			}
		}
		
		if(valSum == 0){
			$("#workBcfForm select[name='ilbo_okng']").val("대기");
		}
		
	}

	function bcfHardInputReset(){
		for(var i=1; i<=5; i++){
			bcfHardInputCalc("ilbo_pg"+i, "", "", "");
		}
	}
	
	//함수
	function selectHogiBtn(hogi){

		var hogiArray = [0,1,2,3,4,18];

		for(var i=0; i<hogiArray.length; i++){
			if(hogiArray[i] == hogi){
				$("#selectHogi"+hogi).css({"background-color":"#BEE3F8","border-color":"#3182CE","color":"#1A365D"});
			}else{
				$("#selectHogi"+hogiArray[i]).css({"background-color":"#F0F4F8","border-color":"#E2E8F0","color":"#2D3748"});
			}
		}

		$("#s_fac_code").val(hogi);
		getWorkDataList();
	}
	
	
	function facNumberRtn(facCode){
		var rtn = 0;
		
		switch (facCode){
			case "1": rtn = 1; break;		//침탄로 1호기
			case "2": rtn = 2; break;		//침탄로 2호기
			case "3": rtn = 3; break;		//침탄로 3호기
			case "4": rtn = 4; break;		//침탄로 4호기
			case "18": rtn = 5; break;	//침탄로 5호기
		}
		
		return rtn;
	}
	
	function getWorkBcfIlboLotReset(){
		var now = new Date();
		var ye = now.getFullYear();
		var mo = paddingZero(now.getMonth()+1);
		var da = paddingZero(now.getDate());
		
		var ho = paddingZero(now.getHours());
		var mi = paddingZero(now.getMinutes());		
		
		var setDateTime = ye+"-"+mo+"-"+da+" "+ho+":"+mi;
		
		var bcf_ilbo_lot = "TK"+((ye+"").slice(-2))+mo+da+"-";
		
		$("#workBcfForm input[name='bcf_ilbo_lot']").val(bcf_ilbo_lot);	
	}
	
	function ilboLotRtn(facCodeParam){
		
		var now = new Date();
		var ye = now.getFullYear();
		var mo = paddingZero(now.getMonth()+1);
		var da = paddingZero(now.getDate());
		
		var ho = paddingZero(now.getHours());
		var mi = paddingZero(now.getMinutes());		
		
		var setDateTime = ye+"-"+mo+"-"+da+" "+ho+":"+mi;
		
		var bcf_ilbo_lot = "TK"+((ye+"").slice(-2))+mo+da+"-"+facCodeParam;
		
		
		
		$.ajax({
			url:"/tkheat/workilbo/heat/ilboLotRtn",
			type:"post",
			dataType:"json",
			data:{
				"ilbo_lot_date":(ye+"-"+mo+"-"+da),
				"fac_code":facCodeParam,
				"ilbo_code":setIlboCode
			},
			success:function(result){
				$("#workBcfForm input[name='bcf_ilbo_lot']").val(result.data);	
			}
		});
	}
	
	
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
	
	function bcfModalSet(val){
		
		var valArray = [0,1,2];
		
		for(var i=0; i<valArray.length; i++){
			if(valArray[i] == val){
				$("#workBcfForm .bcfInfo"+val).show();
				$("#workBcfForm .bcfInfoBtn"+val).css("background-color","#FFFFFF");
				$("#workBcfForm .bcfInfoBtn"+val).css("border","1px solid gray");
				$("#workBcfForm .bcfInfoBtn"+val).css("border-radius","3px");
			}else{
				$("#workBcfForm .bcfInfo"+valArray[i]).hide();
				$("#workBcfForm .bcfInfoBtn"+valArray[i]).css("background-color","#F0F0F0");
				$("#workBcfForm .bcfInfoBtn"+valArray[i]).css("border","1px solid gray");
				$("#workBcfForm .bcfInfoBtn"+valArray[i]).css("border-radius","3px");
				
			}
		}
	}
	
	
	//침탄로작업
	//더블클릭으로 기존 데이터를 불러올 때, 설비/작업자 목록이 아직 로딩되기 전(최초 진입 시)이면
	//select에 값 설정이 조용히 실패하므로, 목록 로딩(getWorkBcfDataFacCode/UserCode)이 끝난 뒤에도
	//적용할 수 있도록 값을 임시 보관해둔다.
	var bcfPendingFacCode = null;
	var bcfPendingUserCode = null;
	var tkheatLoginUserCode = "${loginUser.user_code}"; //신규 등록시 작업자 기본값용(현재 로그인 사용자)

	function workBcfModalOpen(){
		bcfModalSet(0);

		$("#workBcfForm")[0].reset();
		bcfPendingFacCode = null;
		bcfPendingUserCode = null;
		//select에 남아있는 이전(수정모드 등) 선택값을 지워야, 신규등록시 로그인 사용자 기본선택 로직이 정상 동작함
		$("#workBcfForm select[name='user_code']").val('');

		getWorkBcfData();
		getWorkBcfDataFacCode();
		getWorkBcfDataUserCode();
		ilboLotRtn(1);
		
		workBcfModal.style.display = 'flex'; // 모달 보임
		$("#workBcfForm input[name='ilbo_strt']").val("1900-01-01 00:00");
		$("#workBcfForm input[name='ilbo_end']").val("1900-01-01 00:00");
	}
	
	function workBcfModalClose(){		
		bcfHardInputReset();
		workBcfModal.style.display = 'none'; // 모달 숨김
	}
	
	//열처리작업 단취완료 이력
	function workBcfDanchModalOpen(){
		$("#workBcfDanchForm")[0].reset();
		
		if(workBcfDataTable.getData().length > 0){
			alert("이미 선택된 작업이력이 있습니다!");
			return false;
		}
		
		//1주일전 ~ 오늘
		var ydate = beforeWeekDate();
		var tdate = todayDate();
		
		$("#bcf_danch_sdate").val(ydate);
		$("#bcf_danch_edate").val(tdate);
		
		getWorkBcfDanchData();
		getWorkBcfDanchDataList();
		
		workBcfDanchModal.style.display = 'flex'; // 모달 보임
	}
	function workBcfDanchModalClose(){
		workBcfDanchModal.style.display = 'none'; // 모달 숨김
	}

	
	var rowDeleteBtn = function(cell, formatterParams){ //plain text value
		var btn = "";
		btn = "<button type='button' style='display: flex;align-items: center; cursor:pointer;width:90px;height:20px; font-size:12pt;padding-left:20px; margin-right:0;'>행삭제</button>";
		
		return btn;
	};
	
	//작업지시관리NEW 전체이력 조회
	function getWorkDataList(){
		var s_sdate = $("#s_all_sdate").val();
		var s_edate = $("#s_all_edate").val();
		var s_corp_name = $("#s_all_corp_name").val();
		var s_prod_name = $("#s_prod_name").val();
		var s_prod_no = $("#s_prod_no").val();
		var s_fac_code = $("#s_fac_code").val();
		
		$.ajax({
			url:"/tkheat/workilbo/heat/allList",
			type:"post",
			dataType:"json",
			data:{
				"s_sdate":s_sdate,
				"s_edate":s_edate,
				"s_corp_name":s_corp_name,
				"s_prod_name":s_prod_name,
				"s_prod_no":s_prod_no,
				"s_fac_code":s_fac_code
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
						url:"/tkheat/workilbo/heat/dataUpdateList",
						type:"post",
						dataType:"json",
						data:{
							"ilbo_code":ilbo_code,
							"ilbo_gubn":ilbo_gubn,
							"ilbo_lot":ilbo_lot,
							"ilbo_pc":ilbo_pc
						},
						success:function(result){
							//열처리작업 수정
							workBcfModalOpen();
							
							workBcfDataTable.setData(result.data);
							var stdDatas = result.data;
							
							var ilbo_su = 0;
							var ilbo_jung = 0;
							var ilbo_lot = "";
							
							var stdVal1 = 0;
							var stdVal2 = 0;
							
							for(let keys in stdDatas){
								var stdData = stdDatas[keys];
								
								stdVal1 = stdDatas[keys].prod_si1;
								stdVal2 = stdDatas[keys].prod_si2;
								
								for(let key in stdData){
									
									if(key == "ilbo_su"){
										ilbo_su += stdData[key];
									}
									
									if(key == "ilbo_jung"){
										ilbo_jung += stdData[key];
									}
									
									if(key == "ilbo_lot"){
										ilbo_lot = stdData[key];
									}
									
									if(key == "ilbo_pg1" || key == "ilbo_pg2" || key == "ilbo_pg3" ||
											key == "ilbo_pg4" || key == "ilbo_pg5"){
										bcfHardInputCalc(key,stdData[key],stdVal1,stdVal2);
									}

									if(key == "fac_code"){
										bcfPendingFacCode = stdData[key];
									}
									if(key == "user_code"){
										bcfPendingUserCode = stdData[key];
									}

									$("#workBcfForm input[name='"+key+"']").val(stdData[key]);
									$("#workBcfForm select[name='"+key+"']").val(stdData[key]);
								}
							}
							
							$("#workBcfForm input[name='bcf_total_cnt']").val(ilbo_su);
							$("#workBcfForm input[name='bcf_total_weight']").val(ilbo_jung.toFixed(2));
							$("#workBcfForm input[name='bcf_ilbo_lot']").val(ilbo_lot);
							bcfHardInputOKNG();
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
		        {title:"작업일", field:"ilbo_strt_date", sorter:"string", width:60,
			        hozAlign:"center",
			        formatter:function(cell){
			        	var value = cell.getValue();
			        	if(!value) return "";
			        	return value.substring(5,10);
			        }
		       	},	
		        {title:"수주NO", field:"ord_code", sorter:"string", width:100,
			        hozAlign:"center"},	        
		        {title:"적재코드", field:"danch_barcode", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"생산LOT", field:"ilbo_lot", sorter:"string", width:120,
		        	hozAlign:"center"},
		        {title:"설비", field:"fac_name", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"시작", field:"ilbo_strt_time", sorter:"string", width:60,
		        	hozAlign:"center"},
		        {title:"종료", field:"ilbo_end_time", sorter:"string", width:60,
		        	hozAlign:"center"},
		        {title:"입고LOT", field:"ord_lot", sorter:"string", width:80,
			        hozAlign:"center"},	
		        {title:"거래처", field:"corp_name", sorter:"string", width:140,
			        hozAlign:"left"},	
		        {title:"품명", field:"prod_name", sorter:"string", width:240,
			        hozAlign:"left"},	
		        {title:"품번", field:"prod_no", sorter:"string", width:140,
			        hozAlign:"left"},
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
			        hozAlign:"left"},
		        {title:"재질", field:"prod_jai", sorter:"string", width:100,
			        hozAlign:"left"},
		        {title:"수량", field:"ilbo_su", sorter:"string", width:60,
		        	hozAlign:"right"},
		        {title:"중량", field:"ilbo_jung", sorter:"string", width:60,
		        	hozAlign:"right", visible:false},
		        {title:"공정", field:"tech_te", sorter:"string", width:50,
		        	hozAlign:"center"},
		        {title:"비고", field:"tech_in", sorter:"string", width:80,
		        	hozAlign:"center"},
		        {title:"소입경도", field:"prod_si", sorter:"string", width:120,
			        hozAlign:"center", visible:false},
			    {title:"경화깊이", field:"prod_gd", sorter:"string", width:120, visible:false},
			    {title:"제품코드", field:"prod_code", visible:false},
			    {title:"일보코드", field:"ilbo_code", visible:false},
			    {title:"일보코드_pc", field:"ilbo_pc", visible:false},
			    {title:"일보구분", field:"ilbo_gubn", visible:false},
			    {title:"일보종료시간", field:"ilbo_end", visible:false},
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

	/*열처리 작업*/
	//작업지시(열처리) - 등록된 단취작업 리스트
	var workBcfDataTable;	
	function getWorkBcfData(){
		
		workBcfDataTable = new Tabulator("#workBcfTabu", {
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
		        {title:"입고일", field:"ord_input_view", sorter:"string", width:60,
			        hozAlign:"center",
			        formatter:function(cell){
			        	var value = cell.getValue();
			        	if(!value) return "";
			        	return value.substring(5,10);
			        }},	
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"left"},
		        {title:"품명", field:"prod_name", sorter:"string", width:240,
			        hozAlign:"left"},	
		        {title:"품번", field:"prod_no", sorter:"string", width:140,
			        hozAlign:"left"},
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
			        hozAlign:"left"},
		        {title:"재질", field:"prod_jai", sorter:"string", width:100,
			        hozAlign:"left"},
		        {title:"수량", field:"ilbo_su", sorter:"string", width:80,
		        	hozAlign:"right"},		        
		        {title:"중량", field:"ilbo_jung", sorter:"string", width:80,
		        	hozAlign:"right"},
		        {title:"소입경도", field:"prod_si", sorter:"string", width:120,
			        hozAlign:"center"},
			    {title:"경화깊이", field:"prod_gd", width:120},
			    {title:"제품코드", field:"prod_code", visible:false},
			    {title:"작업코드", field:"ilbo_code", visible:false},
			    {title:"작업코드", field:"ilbo_pc", visible:false},
			    {title:"입고단중", field:"ord_danj", visible:false}
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
			}
		});		
		
	}
	
	var workBcfDanchDataTable;
	function getWorkBcfDanchData(){
		
		workBcfDanchDataTable = new Tabulator("#workBcfDanchTabu", {
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
					workBcfDanchSelectData = rData;
					workBcfDanchSelectDataReg();
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
		        {title:"작업번호", field:"ilbo_code", sorter:"string", width:80,
			        hozAlign:"center", visible:false},	
		        {title:"적재코드", field:"danch_barcode", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"수주번호", field:"ord_code", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"수주일", field:"ord_input_view", sorter:"string", width:60,
			        hozAlign:"center",
			        formatter:function(cell){
			        	var value = cell.getValue();
			        	if(!value) return "";
			        	return value.substring(5,10);
			        }
			    },			        
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"left"},		        
		        {title:"품명", field:"prod_name", sorter:"string", width:240,
		        	hozAlign:"left"},
		        {title:"품번", field:"prod_no", sorter:"string", width:140,
		        	hozAlign:"left"},
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
		        	hozAlign:"left"},
		        {title:"재질", field:"prod_jai", sorter:"string", width:100,
		        	hozAlign:"left"},
		        {title:"공정", field:"tech_te", sorter:"string", width:70,
		        	hozAlign:"center"},
		        {title:"수량", field:"ilbo_su", sorter:"string", width:60,
			        hozAlign:"center"},	
		        {title:"중량", field:"ilbo_jung", sorter:"string", width:70,
			        hozAlign:"center"},	
		        {title:"비고", field:"ilbo_bigo", sorter:"string", width:60,
			        hozAlign:"center"},	
			    {title:"일보PC", field:"ilbo_pc", visible:false},
			    {title:"일보코드", field:"ilbo_code", visible:false},
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
			    
			    row.getElement().style.fontWeight = "700";
			    
			    var ilbo_end = data.ilbo_end;
			    
			    if(ilbo_end == "1900-01-01 00:00"){
			    	row.getElement().style.backgroundColor = "#FFD8D8";
			    }else{
			    	row.getElement().style.backgroundColor = "#FFFFFF";	
			    }
			}
		});		
	}
	
	let workBcfDanchSelectData;
	let workBcfDanchSelectDataParam;
	
	//적용버튼을 눌렀을 때 -> 더블클릭으로 변경
	function workBcfDanchSelectDataReg(){
				//ajax로 선입과 전송한 데이터 확인 후 데이터 이동		
		workBcfDanchSelectDataParam = JSON.stringify(workBcfDanchSelectData);		
		
		//선택한 제품의 완료시간이 적용되어 있는지
		var ilbo_end = workBcfDanchSelectData.ilbo_end;
		
		if(ilbo_end == "1900-01-01 00:00"){
			alert("단취완료 후 선택해주십시오!");
			return false;
		}
		
		$.ajax({
			url:"/tkheat/workilbo/bcf/danchList/dataSetting",
			type:"post",
			dataType:"json",
			traditional: true,		
			data:{
				"workBcfDanchSelectDataParam":workBcfDanchSelectDataParam
			},
			success:function(result){
				
				workBcfDataTable.addData(result.data);
				
				var facCode = $("#workBcfForm select[name='fac_code']").val();
				
				setIlboCode = result.data[0].ilbo_code;
				
				ilboLotRtn(facCode);
				
				var stdDatas = result.data;
				
				var ilbo_su = 0;
				var ilbo_jung = 0;
				var ilbo_lot = "";
				
				for(let keys in stdDatas){
					var stdData = stdDatas[keys];
					
					for(let key in stdData){
						
						if(key != "ilbo_strt" && key != "ilbo_end" && key != "fac_code"){
							if(key == "ilbo_su"){
								ilbo_su += stdData[key];
							}
							
							if(key == "ilbo_jung"){
								ilbo_jung += stdData[key];
							}
							
							if(key == "ilbo_lot"){
								ilbo_lot = stdData[key];
							}
							
							$("#workBcfForm input[name='"+key+"']").val(stdData[key]);
						}
					}
				}
				
				$("#workBcfForm input[name='bcf_total_cnt']").val(ilbo_su);
				$("#workBcfForm input[name='bcf_total_weight']").val(ilbo_jung.toFixed(2));
				$("#workBcfForm input[name='bcf_ilbo_lot']").val(ilbo_lot);
				
				sdateTimeSetBtn("bcfStart");

				workBcfDanchModalClose();

				alert("목록에 추가되었습니다.");

			}
		});

	}


	function getWorkBcfDanchDataList(){
		//단취정보 저장할 리스트
		var bcfSettingDataList = JSON.stringify(workBcfDataTable.getData());
		
		var searchObj = {
				"bcf_danch_cname":$("#bcf_danch_cname").val(),
				"bcf_danch_pname":$("#bcf_danch_pname").val(),
				"bcf_danch_pno":$("#bcf_danch_pno").val(),
				"bcf_danch_sdate":$("#bcf_danch_sdate").val(),
				"bcf_danch_edate":$("#bcf_danch_edate").val()
		};
		
		var searchObjParam = JSON.stringify(searchObj);
		
		$.ajax({
			url:"/tkheat/workilbo/bcf/danchList",
			type:"post",
			dataType:"json",
			traditional: true,
			data:{
				"bcfSettingDataList":bcfSettingDataList,
				"searchObjParam":searchObjParam
			},
			success:function(result){
				workBcfDanchDataTable.setData(result.data);
			}
		});
	}

	
	function getWorkBcfDataUserCode(){
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
				var curVal = $("#workBcfForm select[name='user_code']").val();
				$("#workBcfForm select[name='user_code']").empty();
				$("#workBcfForm select[name='user_code']").append(_option);
				if(bcfPendingUserCode !== null){
					$("#workBcfForm select[name='user_code']").val(bcfPendingUserCode);
					bcfPendingUserCode = null;
				}else if(curVal){
					$("#workBcfForm select[name='user_code']").val(curVal);
				}
				//신규 등록시에는 현재 로그인한 사용자를 기본값으로 선택. 목록에 없으면(예: 권한범위 밖) 첫 번째 항목으로 대체
				if(!$("#workBcfForm select[name='user_code']").val() && data.length > 0){
					if(tkheatLoginUserCode && $("#workBcfForm select[name='user_code'] option[value='"+tkheatLoginUserCode+"']").length > 0){
						$("#workBcfForm select[name='user_code']").val(tkheatLoginUserCode);
					}else{
						$("#workBcfForm select[name='user_code']").val(data[0].user_code);
					}
				}
			}
		})
	}

	function getWorkBcfDataFacCode(){
//		user_code
		$.ajax({
			url:"/tkheat/workilbo/bcfList",
			type:"post",
			dataType:"json",
			data:{"tech_no":"A16"},
			success:function(result){
				var data = result.data;
				var _option = "";
				for(var i=0; i<data.length; i++){
					_option += "<option value='"+data[i].fac_code+"'>"+data[i].fac_name+"</option>";
				}

				var curVal = $("#workBcfForm select[name='fac_code']").val();
				$("#workBcfForm select[name='fac_code']").empty();
				$("#workBcfForm select[name='fac_code']").append(_option);
				if(bcfPendingFacCode !== null){
					$("#workBcfForm select[name='fac_code']").val(bcfPendingFacCode);
					bcfPendingFacCode = null;
				}else if(curVal){
					$("#workBcfForm select[name='fac_code']").val(curVal);
				}
				//신규 등록 등 선택된 값이 없을 때는 첫 번째 항목을 기본값으로 선택(빈 값으로 저장 시도되는 것 방지)
				if(!$("#workBcfForm select[name='fac_code']").val() && data.length > 0){
					$("#workBcfForm select[name='fac_code']").val(data[0].fac_code);
				}
			}
		})
	}

	//열처리작업 저장
	function workBcfModalSave(){

		if(!$("#workBcfForm select[name='fac_code']").val()){
			alert("설비를 선택해주세요.");
			return;
		}
		if(!$("#workBcfForm select[name='user_code']").val()){
			alert("작업자를 선택해주세요.");
			return;
		}

		//단취모달 리스트 데이터 조회
		var bcfSettingDataList = JSON.stringify(workBcfDataTable.getData());

		var formObj = {
				"fac_code":$("#workBcfForm select[name='fac_code']").val(),
				"user_code":$("#workBcfForm select[name='user_code']").val(),
				"ilbo_strt":$("#workBcfForm input[name='ilbo_strt']").val().replace("T"," ")+":00",
				"ilbo_end":$("#workBcfForm input[name='ilbo_end']").val().replace("T"," ")+":00",
				"ilbo_lot":$("#workBcfForm input[name='bcf_ilbo_lot']").val(),
				"wstd_gj11":$("#workBcfForm input[name='wstd_gj11']").val(),
				"wstd_gj21":$("#workBcfForm input[name='wstd_gj21']").val(),
				"wstd_gj42":$("#workBcfForm input[name='wstd_gj42']").val(),
				"wstd_gj12":$("#workBcfForm input[name='wstd_gj12']").val(),
				"wstd_gj22":$("#workBcfForm input[name='wstd_gj22']").val(),
				"wstd_gj32":$("#workBcfForm input[name='wstd_gj32']").val(),
				"wstd_gj13":$("#workBcfForm input[name='wstd_gj13']").val(),
				"wstd_gj23":$("#workBcfForm input[name='wstd_gj23']").val(),
				"wstd_gj33":$("#workBcfForm input[name='wstd_gj33']").val(),
				"wstd_gj14":$("#workBcfForm input[name='wstd_gj14']").val(),
				"wstd_gj24":$("#workBcfForm input[name='wstd_gj24']").val(),
				"wstd_gj34":$("#workBcfForm input[name='wstd_gj34']").val(),
				"wstd_gj17":$("#workBcfForm input[name='wstd_gj17']").val(),
				"wstd_gj16":$("#workBcfForm input[name='wstd_gj16']").val(),
				"ilbo_bigo":$("#workBcfForm input[name='ilbo_bigo']").val(),
				"ilbo_pg1":$("#workBcfForm input[name='ilbo_pg1']").val(),
				"ilbo_pg2":$("#workBcfForm input[name='ilbo_pg2']").val(),
				"ilbo_pg3":$("#workBcfForm input[name='ilbo_pg3']").val(),
				"ilbo_pg4":$("#workBcfForm input[name='ilbo_pg4']").val(),
				"ilbo_pg5":$("#workBcfForm input[name='ilbo_pg5']").val(),
				"ilbo_ck01":$("#workBcfForm select[name='ilbo_ck01']").val(),
				"ilbo_ck02":$("#workBcfForm select[name='ilbo_ck02']").val(),
				"ilbo_ck03":$("#workBcfForm select[name='ilbo_ck03']").val(),
				"ilbo_ck04":$("#workBcfForm select[name='ilbo_ck04']").val(),
				"ilbo_ck05":$("#workBcfForm select[name='ilbo_ck05']").val(),
				"ilbo_okng":$("#workBcfForm select[name='ilbo_okng']").val()
		}
		
		var formObjParam = JSON.stringify(formObj);
		
		$.ajax({
			url:"/tkheat/workilbo/heat/dataSave",
			type:"post",
			dataType:"json",
			traditional: true,
			data:{
				"bcfSettingDataList":bcfSettingDataList,
				"formObjParam":formObjParam
			},
			success:function(result){
				if(result.error){
					alert("저장 중 오류가 발생했습니다: "+result.error);
					return;
				}
				//모달 닫기
				workBcfModalClose();
				//전체이력 조회
				getWorkDataList();
				alert("등록되었습니다.");
			}
		});
	}

	function checkSheetStatusCloseBtn(){
		checkSheetStatusModal.style.display = 'none'; // 모달 숨김
	}

	function checkSheetReportCloseBtn(){
		checkSheetReportModal.style.display = 'none'; // 모달 숨김
	}

	
	//모달기능
	const workBcfModal = document.querySelector('.workBcfModal');
	const workBcfDanchModal = document.querySelector('.workBcfDanchModal');
	const checkSheetStatusModal = document.querySelector('.checkSheetStatusModal');
	const checkSheetReportModal = document.querySelector('.checkSheetReportModal');

	// 헤더를 드래그할 요소로 사용 -> 모달이 여러 개이므로 각 헤더마다 자신이 속한 모달을 찾아 개별적으로 드래그 처리
	document.querySelectorAll('.header').forEach(function(header){
		header.addEventListener('mousedown', function(e) {
			const modal = header.closest('.workBcfModal, .workBcfDanchModal, .checkSheetStatusModal, .checkSheetReportModal');
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
