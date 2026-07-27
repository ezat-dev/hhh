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
	margin-left: 0%;
}

/* ========== 상단 도구바 (다른 페이지 날짜검색/검색창과 통일) ========== */
.tab {
	background: #ffffff;
	border: 1px solid #E2E8F0;
	border-radius: 10px;
	box-shadow: 0 1px 4px rgba(0,0,0,.06);
	padding: 10px 14px;
}
.daylabel {
	font-size: 12px;
	font-weight: 600;
	color: #495057;
	white-space: nowrap;
}
.box1 input[type="date"],
.box1 input[type="text"],
.box1 select {
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
.box1 input:focus,
.box1 select:focus {
	border-color: #3182CE;
	background-color: #fff;
}


/* ========== 모달 (management 쪽 모달과 동일한 톤) ========== */
.workHModal,
.workHIpgoModal,
.workJHModal,
.workJisiReportModal,
.workPrintStatusModal {
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

.workHModal {
	width:1600px;
	height:830px;
	flex-direction: column;
}
.workHModal form {
	flex: 1;
	min-height: 0;
	overflow-y: auto;
	padding: 10px 14px;
	background: #f5f7fa;
}

.workHIpgoModal {
	width:1200px;
	height:750px;
	z-index: 20011; /* workHModal 위에 표시되는 하위 모달 */
	flex-direction: column;
}

.workJHModal {
	width:1600px;
	height:700px;
	flex-direction: column;
}
.workJHModal form {
	flex: 1;
	min-height: 0;
	overflow-y: auto;
	padding: 10px 14px;
	background: #f5f7fa;
}

.workJisiReportModal {
	width:850px;
	height:800px;
	flex-direction: column;
	padding: 14px;
	gap: 10px;
	box-sizing: border-box;
}

.workPrintStatusModal {
	width:350px;
	height:150px;
	left: 40%; /* 원래 위치값 유지 */
}
.workPrintStatusModal .detail {
	background: #f5f7fa;
	padding: 10px 14px;
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

.btnSaveClose button {
	background: #007bff; /* 버튼 배경색 */
	color: white; /* 버튼 글자색 */
	border: none; /* 경계선 없음 */
	padding: 8px 15px; /* 내부 여백 */
	cursor: pointer; /* 커서 변경 */
	border-radius: 3px; /* 모서리 둥글게 */
	margin: 0 10px; /* 버튼 간격 */
	margin-top: 10px;
	align-items: center; /* 수직 중앙 정렬 */
}

.btnSaveClose button:hover {
	background: #0056b3; /* 호버 시 색상 변경 */
}

.tabulator-header > .tabulator-headers > .tabulator-col{
	height:55px !important;
}

.setRow{
	display:flex;
}

.setRow *{
	margin-right:5px;
	height:25px;
}

.setRow input,select{
	border: 1px solid black;
	width: 10%;
	height:25px;
}

.setRow button{
	width: 10%;
	height: 25px;
}

.setRowWait{
	display:flex;
}

.setRowWait *{
	margin-right:5px;
	height:25px;
}

.setRowWait input,select{
	border: 1px solid black;
	width: 12%;
	height:25px;
}

.setRowWait button{
	width: 10%;
	height: 25px;
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
.workSelectBtn{
    width: 100px;
    height:50px;
    padding: 5px 10px;
    line-height: 50px;
    font-size: 14pt;
    text-align:center;
    align-items:center;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #f9f9f9;
    cursor:pointer;
}




.iRowLabel2{
	display:inline-block;
	width:100px;
	height:25px;
}


.iRowInput2{
	width:100px !important;
	height:25px;
}

.iCol{
	width:35%;
	display:inline-block;
}


.iRow2{
	display:inline-block;
}

.iRowLabel{
	display:block;
	width:120px;
	height:20px;
	text-align:center;
	margin-bottom:4px;
	font-size:12px;
	font-weight:600;
	color:#495057;
}

.iRowInput{
	width:120px !important;
	text-align:center;
}

.iRowLabel_180{
	display:block;
	width:180px;
	height:20px;
	text-align:center;
	margin-bottom:4px;
	font-size:12px;
	font-weight:600;
	color:#495057;
}

.iRowInput_180{
	width:180px !important;
	text-align:center;
}

.iRowLabel_300{
	display:block;
	width:300px;
	height:20px;
	text-align:center;
	margin-bottom:4px;
	font-size:12px;
	font-weight:600;
	color:#495057;
}

.iRowInput_300{
	width:300px !important;
	text-align:center;
}

/* ========== 모달 내 입력요소 공통 스킨 (체크박스 제외) ========== */
.iRowInput:not([type="checkbox"]),
.iRowInput_180:not([type="checkbox"]),
.iRowInput_300:not([type="checkbox"]),
.iRowHInput:not([type="checkbox"]),
.workHIpgoModal input[type="date"] {
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
.iRowInput:not([type="checkbox"]):focus,
.iRowInput_180:not([type="checkbox"]):focus,
.iRowInput_300:not([type="checkbox"]):focus,
.iRowHInput:not([type="checkbox"]):focus,
.workHIpgoModal input[type="date"]:focus {
	border-color: #3182CE;
	background-color: #fff;
}

.iRowBtn{
	display:inline-flex;
	align-items:center;
	justify-content:center;
	cursor:pointer;
	width:128px !important;
	height:30px;
	font-size:12px;
	font-weight:600;
	border:1px solid #E2E8F0;
	border-radius:6px;
	background:#F0F4F8;
	color:#2D3748;
	transition: background-color .13s, border-color .13s;
}
.iRowBtn:hover{
	background:#EBF8FF;
	border-color:#BEE3F8;
}

/* 저장/닫기 버튼 (iRowBtn 위에 덧씌움) */
.save{
	background: linear-gradient(135deg, #51cf66, #37b24d);
	color: white;
	border: none;
}
.save:hover{
	background: linear-gradient(135deg, #40c057, #2f9e44);
}
.workHClose,
.workHIpgoClose,
.workJHClose,
.workJisiReportClose,
.workPrintStatusClose{
	background: linear-gradient(135deg, #868e96, #495057);
	color: white;
	border: none;
}
.workHClose:hover,
.workHIpgoClose:hover,
.workJHClose:hover,
.workJisiReportClose:hover,
.workPrintStatusClose:hover{
	background: linear-gradient(135deg, #6c757d, #343a40);
}

/* ========== 모달 내 리스트(#workHTabu, #workHIpgoTabu) ========== */
#workHTabu.tabulator,
#workHIpgoTabu.tabulator {
	border: 1px solid #E2E8F0;
	border-radius: 8px;
	font-size: 12px;
}
#workHTabu .tabulator-header,
#workHIpgoTabu .tabulator-header {
	background: linear-gradient(135deg, #2B6CB0, #3182CE);
	border-bottom: none;
}
#workHTabu .tabulator-col,
#workHIpgoTabu .tabulator-col {
	background: transparent;
	border-right: 1px solid rgba(255,255,255,.15);
}
#workHTabu .tabulator-col-title,
#workHIpgoTabu .tabulator-col-title {
	color: #ffffff;
	font-weight: 700;
}
#workHTabu .tabulator-row,
#workHIpgoTabu .tabulator-row {
	border-bottom: 1px solid #EDF2F7;
	transition: background-color .12s;
}
#workHTabu .tabulator-row.tabulator-row-even,
#workHIpgoTabu .tabulator-row.tabulator-row-even {
	background-color: #F7FAFC;
}
#workHTabu .tabulator-row:hover,
#workHIpgoTabu .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#workHTabu .tabulator-row.row_select,
#workHIpgoTabu .tabulator-row.row_select {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#workHTabu .tabulator-cell,
#workHIpgoTabu .tabulator-cell {
	border: 1px solid #E2E8F0;
	color: #2D3748;
}
#workHTabu .tabulator-footer,
#workHIpgoTabu .tabulator-footer {
	background: #F7FAFC;
	border-top: 1px solid #E2E8F0;
	padding: 6px 10px;
}
#workHTabu .tabulator-page,
#workHIpgoTabu .tabulator-page {
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
#workHTabu .tabulator-page.active,
#workHIpgoTabu .tabulator-page.active {
	background: #3182CE;
	border-color: #2B6CB0;
	color: #ffffff;
}
#workHTabu .tabulator-page:not(:disabled):hover,
#workHIpgoTabu .tabulator-page:not(:disabled):hover {
	background: #EBF8FF;
	border-color: #BEE3F8;
	color: #2B6CB0;
	cursor: pointer;
}

/*준비작업모달 */
.j_container{
	display:flex;
	flex-wrap:wrap;
	align-items:center;
	gap:8px;
}

.j_row1{
	display:flex;
	flex-wrap:wrap;
	align-items:center;
	gap:8px;
}

.margin_left{
	margin-left:0 !important;
}

.tabulator-col-title > input[type='checkbox']{
	width:20px;
	height:20px;
}

.tabulator-cell > input[type='checkbox']{
	width:20px;
	height:20px;
}

.iRowHLabel{
	display:block;
	width:120px;
	height:22px;
	text-align:center;
	margin-bottom:4px;
	font-size:12px;
	font-weight:600;
	color:#495057;
}

.iRowHInput{
	display:block;
	width:120px !important;
	text-align:center;
}

.j_h_div{
	width:130px;
}

    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
		<form action="" autocomplete="off">
			<div class="j_container">
				<label class="daylabel">작업지시일 :</label>
				<input type="date" class="jisi_sdate" id="jisi_sdate">
				~
				<input type="date" class="jisi_edate" id="jisi_edate">
			</div>
		</form>
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getWorkJisiAllListData();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
<!--         
        <button class="insert-button" id="jAddBtn">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          	단취등록
        </button>
 -->
        <button class="insert-button" id="hAddBtn">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
        </button>
        <button class="delete">
            <img src="/tkheat/css/image/delete-icon.png" alt="delete" class="button-image">
        </button>
        
        <button class="printer-button" id="jPrintBtn">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
			 공정이동표            
        </button>
        
        <button class="printer-button" id="hPrintBtn">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
            체크시트
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

<!-- 열처리작업 저장 모달 -->
<div class="workHModal">
	<div class="detail">
		<div class="header">
		열처리작업
		</div>
	</div>
	
		<form id="workHForm" name="workHForm" autocomplete="off">
			<div class="j_container">
				<label for="" class="iRowLabel">수주NO</label>
				<input type="text" id="s_ord_code" name="s_ord_code" class="iRowInput_180"/>
				<button class="iRowBtn margin_left" type="button" onclick="workHIpgoDataBarcodeScan();">입력</button>				
				<button class="workHDataBtn iRowBtn margin_left" type="button" onclick="workHDataList();">검색</button>				
				<label for="" class="iRowLabel">선입선출제외</label>
				<input type="checkbox" id="s_ord_sunip_check" name="s_ord_sunip_check" class="iRowInput"
					style="width:40px !important;"/>
				<input type="password" id="s_ord_sunip_pw" name="s_ord_sunip_pw" class="iRowInput margin_left"/>					
			</div>	
	
		
			<div class="setRow">
				<div id="workHTabu"></div>
			</div>
			<hr />
			
		<div class="j_container">
			<div class="j_row1">
				<input type="text" style="display:none;" name="jisi_h_ord_code" />
				<div class="j_div">
					<label for="jisi_h_fac_code" class="iRowLabel">열처리설비</label>
					<select name="jisi_h_fac_code" class="iRowInput">
						<option value="1">침탄 1호기</option>
						<option value="2">침탄 2호기</option>
						<option value="3">침탄 3호기</option>
						<option value="4">침탄 4호기</option>
						<option value="18">침탄 5호기</option>
					</select>
				</div>				
				<div class="j_div">
					<label for="jisi_t_fac_code" class="iRowLabel margin_left">템퍼링설비</label>
					<select name="jisi_t_fac_code" class="iRowInput margin_left">
						<option value="16">템퍼링 1호기</option>
						<option value="17">템퍼링 2호기</option>
					</select>
				</div>
				
				<div class="j_div">
					<label for="jisi_j_su" class="iRowLabel margin_left">총 작업수량</label>
					<input type="text" name="jisi_j_su" class="iRowInput margin_left"/>
				</div>
				
				<div class="j_div">
					<label for="jisi_h_calc_su" class="iRowLabel margin_left">작업지시수량</label>
					<input type="text" name="jisi_h_calc_su" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_calc_jung" class="iRowLabel margin_left">작업지시중량</label>
					<input type="text" name="jisi_h_calc_jung" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_work_q_hard_std" class="iRowLabel_180 margin_left">소입경도</label>
					<input type="text" name="jisi_h_work_q_hard_std" class="iRowInput_180 margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_work_q_hard_std2" class="iRowLabel_300 margin_left">경화깊이</label>
					<input type="text" name="jisi_h_work_q_hard_std2" class="iRowInput_300 margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_rx" class="iRowLabel margin_left">RX</label>
					<input type="text" name="jisi_h_rx" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_lpg" class="iRowLabel margin_left">LPG</label>
					<input type="text" name="jisi_h_lpg" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_agi" class="iRowLabel margin_left">교반속도</label>
					<input type="text" name="jisi_h_agi" class="iRowInput margin_left"/>
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
					<label for="wstd_t32" class="iRowLabel">1줄/1판</label>
					<input type="text" name="wstd_t32" class="iRowInput"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t33" class="iRowLabel margin_left">줄/단</label>
					<input type="text" name="wstd_t33" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t41" class="iRowLabel margin_left">단/Tray</label>
					<input type="text" name="wstd_t41" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t87" class="iRowLabel margin_left">추가수량</label>
					<input type="text" name="wstd_t87" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t43" class="iRowLabel margin_left">적재수량</label>
					<input type="text" name="wstd_t43" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t44" class="iRowLabel margin_left">Jig중량(kg)</label>
					<input type="text" name="wstd_t44" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t51" class="iRowLabel margin_left">제품중량(kg)</label>
					<input type="text" name="wstd_t51" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t52" class="iRowLabel margin_left">총중량(kg)</label>
					<input type="text" name="wstd_t52" class="iRowInput margin_left"/>						
				</div>
			</div>			
		</div>

		<div class="j_container">				
			<div class="j_row1">
				<div class="j_div">
					<label for="wstd_t53" class="iRowLabel">적재주의사항-1</label>
					<input type="text" name="wstd_t53" class="iRowInput"/>
				</div>
				<div class="j_div">
					<label for="wstd_t54" class="iRowLabel margin_left">적재주의사항-2</label>
					<input type="text" name="wstd_t54" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="wstd_t30" class="iRowLabel margin_left">적재주의사항-3</label>
					<input type="text" name="wstd_t30" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="" class="iRowLabel margin_left">치구불량</label>
					<input type="text" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="" class="iRowLabel margin_left">비고</label>
					<input type="text" class="iRowInput margin_left"/>
				</div>
			</div>
		</div>
		
		<hr />

		<div class="j_container" style="justify-content:center; font-size:14pt;">
			<div class="j_row1">*열처리 패턴정보*</div>			
		</div>
		
		<hr />
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel"></label>
				</div>
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">예열</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">침탄</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">확산</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">강온</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">균열</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">냉각</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">템퍼링</label>
				</div>			
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">온도</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="jisi_h_pre_temp" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_crack_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_cold_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_t_temp" class="iRowHInput margin_left"/>
				</div>
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">시간</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="jisi_h_pre_time" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_crack_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_cold_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_t_time" class="iRowHInput margin_left"/>
				</div>			
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">CP</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_cp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_cp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_cp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="" class="iRowHInput margin_left"/>
				</div>			
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">H2[m3/Hr]</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="jisi_h_pre_h2" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_h2" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_h2" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_h2" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_crack_h2" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_cold_h2" class="iRowHInput margin_left"/>
				</div>			
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">NH3[m3/Hr]</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="jisi_h_pre_nh3" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_nh3" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_nh3" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_nh3" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_crack_nh3" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_cold_nh3" class="iRowHInput margin_left"/>
				</div>			
			</div>
		</div>
				
	</form>
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="save iRowBtn" type="button" onclick="workHSave();">저장</button>
			<button class="workHClose iRowBtn margin_left" type="button" onclick="workHCloseBtn();">닫기</button>
		</div>
    </div>
</div>

<!-- 열처리등록시 입고이력, 잔량표현 -->
<div class="workHIpgoModal">
	<div class="detail">
		<div class="header">
		작업대기 리스트
		</div>
	</div>
		<div class="j_container">
			<form action="">
					<label class="daylabel margin_left">입고일 :</label>
					<input type="date" class="ord_sdate" id="ord_sdate">
					~
					<input type="date" class="ord_edate" id="ord_edate">
			</form>			
			<button class="iRowBtn margin_left" type="button" onclick="workHIpgoDataList();">조회</button>				
		</div>	
	
		<div class="j_container">
			<div class="setRow">
				<div id="workHIpgoTabu"></div>
			</div>
		</div>
		<hr />	
		
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
<!--  			<button class="iRowBtn" type="button" onclick="workHIpgoDataReg();">적용</button>-->
			<button class="workHIpgoClose iRowBtn margin_left" type="button" onclick="workHIpgoCloseBtn();">닫기</button>
		</div>
    </div>
</div>

<!-- 단취, 열처리 수정 모달 -->
<div class="workJHModal">
	<div class="detail">
		<div class="header">
		단취,열처리 수정
		</div>
	</div>
		<form id="workJHForm" name="workJHForm">
		<div class="j_container" style="justify-content:center; font-size:14pt;">
			<div class="j_row1">*단취정보*</div>			
		</div>
		<hr />
		
		<div class="j_container">
			<div class="j_row1">
				<input type="text" style="display:none;" name="jisi_j_ord_code" />
				<div class="j_div">
					<label for="j_ord_su" class="iRowLabel">단취수량</label>
					<input type="text" name="j_ord_su" class="iRowInput"/>
				</div>
				<div class="j_div">
					<label for="j_ord_danj" class="iRowLabel margin_left">단취중량</label>
					<input type="text" name="j_ord_danj" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="j_ord_su" class="iRowLabel margin_left"></label>
					<button type="button" id="jisi_j_btn" class="iRowBtn margin_left">계산 => </button>
				</div>
				<div class="j_div">
					<label for="jisi_j_su" class="iRowLabel margin_left">총수량</label>
					<input type="text" name="jisi_j_su" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_j_jung" class="iRowLabel margin_left">총중량</label>
					<input type="text" name="jisi_j_jung" class="iRowInput margin_left"/>
				</div>
			</div>
		</div>
		
		<div class="j_container">				
			<div class="j_row1">
				<div class="j_div">
					<label for="wstd_t32" class="iRowLabel">1줄/1판</label>
					<input type="text" name="wstd_t32" class="iRowInput"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t33" class="iRowLabel margin_left">줄/단</label>
					<input type="text" name="wstd_t33" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t41" class="iRowLabel margin_left">단/Tray</label>
					<input type="text" name="wstd_t41" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t87" class="iRowLabel margin_left">추가수량</label>
					<input type="text" name="wstd_t87" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t43" class="iRowLabel margin_left">적재수량</label>
					<input type="text" name="wstd_t43" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t44" class="iRowLabel margin_left">Jig중량(kg)</label>
					<input type="text" name="wstd_t44" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t51" class="iRowLabel margin_left">제품중량(kg)</label>
					<input type="text" name="wstd_t51" class="iRowInput margin_left"/>						
				</div>
				<div class="j_div">
					<label for="wstd_t52" class="iRowLabel margin_left">총중량(kg)</label>
					<input type="text" name="wstd_t52" class="iRowInput margin_left"/>						
				</div>
			</div>			
		</div>

		<div class="j_container">				
			<div class="j_row1">
				<div class="j_div">
					<label for="wstd_t53" class="iRowLabel">적재주의사항-1</label>
					<input type="text" name="wstd_t53" class="iRowInput"/>
				</div>
				<div class="j_div">
					<label for="wstd_t54" class="iRowLabel margin_left">적재주의사항-2</label>
					<input type="text" name="wstd_t54" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="wstd_t30" class="iRowLabel margin_left">적재주의사항-3</label>
					<input type="text" name="wstd_t30" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="" class="iRowLabel margin_left">치구불량</label>
					<input type="text" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="" class="iRowLabel margin_left">비고</label>
					<input type="text" class="iRowInput margin_left"/>
				</div>
			</div>
		</div>


		<hr />
		<div class="j_container" style="justify-content:center; font-size:14pt;">
			<div class="j_container">
				<div class="j_row1">*열처리정보*</div>
			</div>
			<div class="j_container">	
		    	<div class="j_row1">
		    		<button class="save iRowBtn" type="button" onclick="workJHSave();">저장</button>			
					<button class="workJHClose iRowBtn margin_left" type="button" onclick="workJHCloseBtn();">닫기</button>
				
				</div>
			</div>
		</div>
		<hr />

		<div class="j_container">
			<div class="j_row1">
				<input type="text" style="display:none;" name="jisi_h_ord_code" />
				<div class="j_div">
					<label for="jisi_h_fac_code" class="iRowLabel">열처리설비</label>
					<select name="jisi_h_fac_code" class="iRowInput">
						<option value="1">침탄로 1호기</option>
						<option value="2">침탄로 2호기</option>
						<option value="3">침탄로 3호기</option>
						<option value="4">침탄로 4호기</option>
						<option value="18">침탄로 5호기</option>
					</select>
				</div>				
				<div class="j_div">
					<label for="jisi_t_fac_code" class="iRowLabel margin_left">템퍼링설비</label>
					<select name="jisi_t_fac_code" class="iRowInput margin_left">
						<option value="16">템퍼링로 1호기</option>
						<option value="17">템퍼링로 2호기</option>
					</select>
				</div>
				
				<div class="j_div">
					<label for="jisi_h_calc_su" class="iRowLabel margin_left">작업수량</label>
					<input type="text" name="jisi_h_calc_su" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_calc_jung" class="iRowLabel margin_left">작업중량</label>
					<input type="text" name="jisi_h_calc_jung" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_work_q_hard_std" class="iRowLabel_180 margin_left">소입경도</label>
					<input type="text" name="jisi_h_work_q_hard_std" class="iRowInput_180 margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_work_q_hard_std2" class="iRowLabel_300 margin_left">경화깊이</label>
					<input type="text" name="jisi_h_work_q_hard_std2" class="iRowInput_300 margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_rx" class="iRowLabel margin_left">RX</label>
					<input type="text" name="jisi_h_rx" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_lpg" class="iRowLabel margin_left">LPG</label>
					<input type="text" name="jisi_h_lpg" class="iRowInput margin_left"/>
				</div>
				<div class="j_div">
					<label for="jisi_h_agi" class="iRowLabel margin_left">교반속도</label>
					<input type="text" name="jisi_h_agi" class="iRowInput margin_left"/>
				</div>
			</div>
		</div>
		
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel"></label>
				</div>
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">예열</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">침탄</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">확산</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">강온</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">균열</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">냉각</label>
				</div>			
				<div class="j_h_div">
					<label for="" class="iRowHLabel margin_left">템퍼링</label>
				</div>			
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">온도</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="jisi_h_pre_temp" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_crack_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_cold_temp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_t_temp" class="iRowHInput margin_left"/>
				</div>
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">시간</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="jisi_h_pre_time" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_crack_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_cold_time" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_t_time" class="iRowHInput margin_left"/>
				</div>			
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">CP</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_cp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_cp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_cp" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="" class="iRowHInput margin_left"/>
				</div>			
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">H2[m3/Hr]</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="jisi_h_pre_h2" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_h2" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_h2" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_h2" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_crack_h2" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_cold_h2" class="iRowHInput margin_left"/>
				</div>			
			</div>
		</div>
		
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<label for="" class="iRowHLabel">NH3[m3/Hr]</label>
				</div>
				<div class="j_h_div">
					<input type="text" name="jisi_h_pre_nh3" class="iRowHInput"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_chim_nh3" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_diff_nh3" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_gang_nh3" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_crack_nh3" class="iRowHInput margin_left"/>
				</div>			
				<div class="j_h_div">
					<input type="text" name="jisi_h_cold_nh3" class="iRowHInput margin_left"/>
				</div>			
			</div>
		</div>
	<hr />
	</form>
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">			
			<button class="workJHClose iRowBtn margin_left" type="button" onclick="workJHCloseBtn();">닫기</button>
		</div>
    </div>
</div>

<input type="text" id="plnpSeq" style="display:none;" value="0" />
<input type="text" id="plnpLot" style="display:none;" value="0" />

<form id="reportPrint" name="reportPrint">
	<input type="text" id="reportDate" name="reportDate" style="display:none;"/>
	<input type="text" id="reportBarcode" name="reportBarcode" style="display:none;"/>
	<input type="text" id="reportPlnpLot" name="reportPlnpLot" style="display:none;"/>
</form>

<a style="display:none;" id="downLoadLink" href="#" download="#"></a>
<!-- 열처리작업 저장 모달 -->
<div class="workJisiReportModal">
	<div class="j_container">
		<iframe src="" frameborder="0" width="800" height="700" id="workJisi">
		</iframe>	
	</div>
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="workJisiReportClose iRowBtn margin_left" type="button" onclick="workJisiReportCloseBtn();">닫기</button>
		</div>
    </div>
</div>

<!-- 공정이동표, 작업지시서 출력중 모달 -->
<div class="workPrintStatusModal">
	<div class="detail">
		<div class="header">
			공정이동표, 작업지시서 파일 생성
		</div>
		<div class="j_container">
			<div class="j_row1">
				<div class="j_h_div">
					<span style="display:inline-block; width:350px;">공정이동표, 작업지시서 파일 생성중입니다....</span>
					<br />
					<span style="display:inline-block; width:350px;">생성완료시 팝업창이 닫힙니다.</span>
				</div>
			</div>
		</div>
	</div>
	
	
	    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="workPrintStatusClose iRowBtn margin_left" type="button" onclick="workPrintStatusCloseBtn();">닫기</button>
		</div>
    </div>	
</div>
	
	
	
	
<script>
	//전역변수
    var cutumTable;	
    let now_page_code = "b01";
	
	//로드
	$(function(){
		//전체 거래처목록 조회
		var ydate = yesterDate();
		var tdate = todayDate();
		
		
		$("#plnp_date").val(tdate);		
		$("#s_plnp_date").val(tdate);
		
		$("#wait_ord_sdate").val(ydate);
		$("#wait_ord_edate").val(tdate);
		$("#jisi_sdate").val(yesterDate());
		$("#jisi_edate").val(todayDate());
//		$("#jisi_sdate").val("2024-07-14");
//		$("#jisi_edate").val("2024-07-20");
		$("#ord_sdate").val(beforeMonthDate());
		$("#ord_edate").val(todayDate());
		
		getWorkJisiAllListData();
		getWorkInstructionList();

	});

	//이벤트
	
	//공정이동식별표 파일저장
	$("#jPrintBtn").on("click",function(){
		
		workPrintStatusModal.style.display = "block";
		
		//체크한 데이터만 조회
		if(workAllDataTable.getSelectedData().length > 0){
			
			var selectArray = workAllDataTable.getSelectedData();
			var jisiLotArray = new Array();
			
			for(var i=0; i<selectArray.length; i++){
				
				if(selectArray[i].jisi_lot != null){
					//작업번호가 다를경우 alert창
					jisiLotArray.push(selectArray[i].jisi_lot);	
				}else{
					alert("작업지시 등록진행 후 파일을 저장해주십시오!");
					return false;
				}

			}
			
			$.ajax({
				url:"/tkheat/production/workjisi/heat/workHeatListProcPrint",
				type:"post",
				dataType:"json",
				traditional: true,
				data:{
					"jisi_lot_array":jisiLotArray
				},
				success:function(result){
					
					workPrintStatusCloseBtn();
					getWorkJisiAllListData();
    				var fileUrl = "/tkPrint/workProc/"+result.heatData;
                    $("#workJisi").attr("src",fileUrl);
                    workJisiReportModal.style.display = "flex";
					
				}
			});
		}		
		
	});
	
	//작업지시서 파일저장
	$("#hPrintBtn").on("click",function(){
		
		workPrintStatusModal.style.display = "block";
		
		//체크한 데이터만 조회
		if(workAllDataTable.getSelectedData().length > 0){
			
			var selectArray = workAllDataTable.getSelectedData();
			var jisiLotArray = new Array();
			
			for(var i=0; i<selectArray.length; i++){
				
				if(selectArray[i].jisi_lot != null){
					//작업번호가 다를경우 alert창
					jisiLotArray.push(selectArray[i].jisi_lot);	
				}else{
					alert("작업지시 등록진행 후 파일을 저장해주십시오!");
					return false;
				}

			}
			
			$.ajax({
				url:"/tkheat/production/workjisi/heat/workHeatListWorkPrint",
				type:"post",
				dataType:"json",
				traditional: true,
				data:{
					"jisi_lot_array":jisiLotArray
				},
				success:function(result){
					
					workPrintStatusCloseBtn();
					getWorkJisiAllListData();
    				var fileUrl = "/tkPrint/workJisi/"+result.heatData;
                    $("#workJisi").attr("src",fileUrl);
                    workJisiReportModal.style.display = "flex";
					
				}
			});
		}		
	});
	
	
	//삭제버튼
	$(".delete").on("click",function(){
		
		var selectArray = workAllDataTable.getSelectedData();
		
		//체크한 데이터만 조회
		if(workAllDataTable.getSelectedData().length > 0){
			
			if(confirm("선택한 행을 삭제하시겠습니까?")){

				var selectArray = workAllDataTable.getSelectedData();
				var jisiLotViewArray = new Array();
				
				for(var i=0; i<selectArray.length; i++){
					
					if(selectArray[i].jisi_lot_view != null){
						//작업번호가 다를경우 alert창
						jisiLotViewArray.push(selectArray[i].jisi_lot_view);	
					}
	
				}
	
				$.ajax({
					url:"/tkheat/production/workjisi/workJisiListDelete",
					type:"post",
					dataType:"json",
					traditional: true,
					data:{
						"jisi_lot_view_array":jisiLotViewArray
					},
					success:function(result){
						getWorkInstructionList();
					}
				});
			}
		}else{
			alert("삭제할 행을 선택해주십시오!!");
			return false;
		}
		
	});
	
	
	//함수
	function getWorkJisiAllListData(){
		$.ajax({
			url:"/tkheat/production/workjisi/allList",
			type:"post",
			dataType:"json",
			data:{
				"jisi_sdate":$("#jisi_sdate").val(),
				"jisi_edate":$("#jisi_edate").val()
			},success:function(result){
				workAllDataTable.setData(result.data);
				
			}
		});
	}
/*	
    <button class="insert-button" id="jAddBtn">
    <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
  	단취등록
</button>
*/
	var printIconProc = function(cell, formatterParams){ //plain text value
	var icon = "";
	if(cell.getRow().getData().jisi_j_file_yn != 0){
		icon = "<img src='/tkheat/css/image/folder-icon.png' alt='forder' class='button-image'></img>";
	}
	return icon;
	};
	
	var printIconJisi = function(cell, formatterParams){ //plain text value
		var icon = "";
		if(cell.getRow().getData().jisi_h_file_yn != 0){
			icon = "<img src='/tkheat/css/image/folder-icon.png' alt='forder' class='button-image'></img>";
		}
		return icon;
	};
	
	
	//작업지시 전체이력
	var workAllDataTable;
	function getWorkInstructionList(){
		workAllDataTable = new Tabulator("#tab1", {
		    height:"100%",
		    layout:"fitColumns",
//		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
	        paginationSize:20,
	        paginationSizeSelector:[20,50,100,500,1000],
	        paginationCounter:"rows",
	        headerFilterPlaceholder: "",
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
/*
				{	headerSort:false,
		    		formatter:printIconProc, width:60, title:"작업</br>지시",cellClick:function(e, cell){
		    			if(cell.getRow().getData().jisi_j_file_yn != 0){
		    				var jisi_lot_view = cell.getRow().getData().jisi_lot_view;
		    				var fileUrl = "/tkPrint/공정이동표/"+jisi_lot_view+".pdf";
		                    $("#workJisi").attr("src",fileUrl);
		                    workJisiReportModal.style.display = "block";
		    			}
		    		}
				},
				{	headerSort:false,
		    		formatter:printIconJisi, width:60, title:"열처리</br>체크시트",cellClick:function(e, cell){
		    			if(cell.getRow().getData().jisi_h_file_yn != 0){
		    				var jisi_lot_view = cell.getRow().getData().jisi_lot_view;
		    				var fileUrl = "/tkPrint/작업지시서/"+jisi_lot_view+".pdf";
		                    $("#workJisi").attr("src",fileUrl);
		                    workJisiReportModal.style.display = "block";
		    			}
		    		}
				},
*/
		        {title:"NO", field:"jisi_j_code", sorter:"int", width:80,
		        	hozAlign:"center", visible:false},
		        {title:"NO", field:"jisi_h_code", sorter:"int", width:80,
		        	hozAlign:"center", visible:false},
		        {title:"NO", field:"jisi_lot", sorter:"int", width:80,
		        	hozAlign:"center", visible:false},
		        {title:"NO", field:"jisi_h_file_yn", sorter:"int", width:80,
		        	hozAlign:"center", visible:false},
		        {title:"입고일", field:"ord_input", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"작업지시일", field:"jisi_h_regtime", sorter:"string", width:160,
			        hozAlign:"center"},	
		        {title:"입고코드", field:"ord_code", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input"},     
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},		        
		        {title:"작업번호", field:"jisi_lot_view", sorter:"string", width:120,
			        hozAlign:"center", headerFilter:"input"},
				{title:"설비", field:"fac_name", sorter:"string", width:100,
				    hozAlign:"center", headerFilter:"input", headerSort:false},
		        {title:"품명", field:"prod_name", sorter:"string", width:220,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},
		        {title:"품번", field:"prod_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input", headerSort:false}, 	
		        {title:"입고수량", field:"ord_su", sorter:"int", width:80,
			        hozAlign:"center", headerFilter:"input", headerSort:false},
		        {title:"작업수량", field:"jisi_h_su", sorter:"int", width:80,
			        hozAlign:"center", headerFilter:"input", headerSort:false},
		    ],
		    rowFormatter:function(row){
			    row.getElement().style.fontWeight = "600";
			},
			rowClick:function(e, row){

				$("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(
					function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#tab1 div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});
				
				
			},
			rowDblClick:function(e, row){
				var rData = row.getData();
				
				
				//준비작업 코드
				var jisi_j_code = rData.jisi_j_code;
				//작업지시 코드 전송
				var jisi_h_code = rData.jisi_h_code;
				
				getWorkInstructionListDetail(jisi_j_code,jisi_h_code);
			}
		});		
	}
	
	function getWorkInstructionListDetail(jisi_j_code,jisi_h_code){
/*
		$.ajax({
			url:"/tkheat/production/workjisi/allList/detail",
			type:"post",
			dataType:"json",
			data:{
				"jisi_j_code":jisi_j_code,
				"jisi_h_code":jisi_h_code
			},success:function(result){
				workJHModal.style.display = 'block'; // 모달 표시
			}			
		});
*/
		workJHModal.style.display = 'flex'; // 모달 표시
	}

	function nullValueRtn(value){
		var rtnValue = "";
		if(value != null){
			rtnValue = value;
		}
		return rtnValue;
	}
	
	
	//작업등록 선택
	function workSelectFunc(wGubun){
		//wGubun : J(준비), A(열처리), R(템퍼링)
		workHSelectOrdCodeArray = new Array();
		if(wGubun == 'J'){
		}else if(wGubun = 'H'){
			$("#workHForm")[0].reset();
			//모달 오픈
			
			getWorkHList();
			workHModal.style.display = 'flex'; // 모달 표시
		}else if(wGubun = 'R'){
			//모달 오픈
			
		}
	
		//작업등록 선택 모달 닫기
		workSelectCloseBtn();
	}
	
	
/*	
	function getWorkHData(selectedData){

//		$("#workHForm")[0].reset();
		$.ajax({
			url:"/tkheat/production/workjisi/heat/jisiList",
			type:"post",
			dataType:"json",
			data:{
				"jisi_code_array":selectedData
			},
			success:function(result){
				
				workHDataTable.setData(result.data);
			}
		});
	}
*/	

	//입고기간 내 작업가능한 리스트 모달창 표현
	function workHDataList(){
		getWorkHIpgoDataList();
		workHIpgoDataList();
		workHIpgoModal.style.display = 'flex';
	}
	
	function workHIpgoDataList(){
		$.ajax({
			url:"/tkheat/production/workInstruction/heat/ipgoList",
			type:"post",
			dataType:"json",
			data:{
				"ord_sdate":$("#ord_sdate").val(),
				"ord_edate":$("#ord_edate").val(),
				"ord_sunip_chk":$("#s_ord_sunip_check").val()
			},success:function(result){
//				console.log(result.data);
				
				workHIpgoDataTable.setData(result.data);
			}
		});
	}
	
	let workHIpgoSelectData;
	let workJisiParam;
	var workHIpgoSelectSunipRtn = true;
	var workHIpgoSelectOrdCodeArray = new Array();
	
	
	//적용버튼을 눌렀을 때 -> 더블클릭으로 변경
	function workHIpgoDataReg(){
		workJisiParam = JSON.stringify(workHIpgoSelectData);
		//
		workHIpgoDataRegSetting();
	}

	//바코드를 스캔해서 수주번호가 변경되었을 때
	function workHIpgoDataBarcodeScan(){
		var s_ord_code = $("#s_ord_code").val();
		if(s_ord_code.length > 0){
			
			//workJisiParam = JSON.stringify(workHIpgoSelectData);
			$.ajax({
				url:"/tkheat/production/workInstruction/heat/ipgoBarcodeScan",
				type:"post",
				dataType:"json",
				data:{
					"ord_code":s_ord_code
				},success:function(result){
					if(result.data != null){
						workJisiParam = JSON.stringify(result.data);
						workHIpgoDataRegSetting();
						$("#s_ord_code").val("");
					}else{
						alert("바코드를 확인해주십시오!!!");
						return false;
					}
				}
			});
		}
	}
	
	var workHSelectOrdCodeArray = new Array();
	
	function workHIpgoDataRegSetting(){
		var sunip_chk = 0;
		
		if($("#s_ord_sunip_check").is(":checked")){
			sunip_chk = 1;
		}		
		
		var jisi_h_calc_su = $("input[name='jisi_h_calc_su']").val();
		var jisi_h_calc_jung = $("input[name='jisi_h_calc_jung']").val();
		
		if(jisi_h_calc_su.length == 0){
			jisi_h_calc_su = 0;
			jisi_h_calc_jung = 0;
		}
		
		if(workHIpgoSelectOrdCodeArray.length == 0){
			workHIpgoSelectOrdCodeArray.push(0);
		}
		
		workHSelectOrdCodeArray.push(workHIpgoSelectData.ord_code)
		
		$.ajax({
			url:"/tkheat/production/workInstruction/heat/ipgoListReg",
			type:"post",
			dataType:"json",
			traditional: true,
			data:{
				"workJisi":workJisiParam,
				"ord_sdate":$("#ord_sdate").val(),
				"ord_edate":$("#ord_edate").val(),
				"s_ord_sunip_check":sunip_chk,
				"s_ord_sunip_pw":$("#s_ord_sunip_pw").val(),
				"jisi_h_calc_su_param":jisi_h_calc_su,
				"ipgo_ord_code_array":workHIpgoSelectOrdCodeArray,
				"selectOrdCodeArray":workHSelectOrdCodeArray
			},
			success:function(result){
				if(typeof result.alert != "undefined"){
					workHIpgoSelectSunipRtn = false;
//					console.log(result.alertData);
					alert(result.alert);
					return false;
				}else{
					//열처리작업 모달에서 작업지시수량,중량 계산
					var jisiData = result.data;
					
					
//					var jisi_h_calc_su = 0;
					
					
					for(var jd in jisiData){
//						console.log(jisiData[jd]);
						var j2Array = jisiData[jd];
						
						for(var j2 in j2Array){
							$("#workHForm input[name='"+j2+"']").val(j2Array[j2]);
						}
						
						var jisiListData = workHDataTable.getData();
//						console.log("행 갯수 : ",jisiListData.length);
	
						var rowValueCheck = true;
						var tempArray = new Array();
						//모달에서 선택, 바코드선택시 열처리 작업리스트에 없는 수주번호만 추가되도록 
						if(jisiListData.length > 0){
							for(var whl in jisiListData){
								if(jisiData[jd].ord_code == jisiListData[whl].ord_code){
									rowValueCheck = false;
								}
							}
						}
						
						
						
						//열처리작업리스트에 동일한 데이터가 없을경우
						if(rowValueCheck){
							tempArray.push(jisiData[jd]);
							workHDataTable.addData(tempArray);
							
							workHIpgoSelectOrdCodeArray.push(jisiData[jd].ord_code);
							jisi_h_calc_su = eval(jisi_h_calc_su) + eval(jisiData[jd].jisi_h_su);
							jisi_h_calc_jung = (eval(jisi_h_calc_jung) + (eval(jisiData[jd].jisi_h_su) * eval(jisiData[jd].ord_danj))).toFixed(2);
							$("input[name='jisi_h_calc_su']").val(jisi_h_calc_su);
							$("input[name='jisi_h_calc_jung']").val(jisi_h_calc_jung);

							workHIpgoDataTable.getRows().forEach(row => {
							  if (row.getData().ord_code === jisiData[jd].ord_code) {
							    row.delete();
							  }
							});
							
						}


					}
//					workHIpgoCloseBtn();

				}
			}
		});	
		
	}
	
	//작업지시 적용리스트
	var workHIpgoDataTable;
	function getWorkHIpgoDataList(){
		
		workHIpgoDataTable = new Tabulator("#workHIpgoTabu", {
			index:"id",
		    height:"600px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
		    paginationSize:20,
		    paginationSizeSelector:[20,50,100,500,1000],
		    paginationCounter:"rows",
		    headerSort:false,
		    ajaxResponse:function(url, params, response){
				$("#workHIpgoTabu .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"수주번호", field:"ord_code", sorter:"string", width:120,
			        hozAlign:"center"},	
		        {title:"입고일", field:"ord_input", sorter:"string", width:120,
			        hozAlign:"center"},	
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},		        
		        {title:"품명", field:"prod_name", sorter:"string", width:220,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"품번", field:"prod_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"입고수량", field:"ord_su", sorter:"string", width:80,
			        hozAlign:"center"},	
		        {title:"작업완료수량", field:"jisi_h_su", sorter:"string", width:100,
			        hozAlign:"center"},
		        {title:"잔량", field:"jisi_diff_su", sorter:"string", width:80,
			        hozAlign:"center"},
			    {title:"단취수량", field:"jisi_j_su", width:80, visible:false},
			    {title:"제품코드", field:"prod_code", visible:false}
		    ],
		    rowFormatter:function(row){
			    row.getElement().style.fontWeight = "600";
			},
			rowClick:function(e, row){

				$("#workHIpgoTabu .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#workHTabu div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});
			},
			rowDblClick:function(e, row){
				
				var rData = row.getData();
				workHIpgoSelectData = rData;
				workHIpgoDataReg();

						
			}
		});		
	}
	

	 //행삭제 버튼
	var rowDeleteBtn = function(cell, formatterParams){ //plain text value
		var btn = "";
		btn = "<button type='button' style='display: flex;align-items: center; cursor:pointer;width:90px;height:20px; font-size:12pt;padding-left:20px; margin-right:0;'>행삭제</button>";
		
		return btn;
	};
	
	function getWorkHListRowDeleteDataCalc(){
		
    	//form태그의 수량, 중량 연산
    	let tData = workHDataTable.getData();
    	var row_su = 0;
    	var row_jung = 0;
    	for(var i in tData){
    		row_su += eval(tData[i].jisi_h_su);
    		row_jung += eval(tData[i].jisi_h_su * tData[i].ord_danj);
    	}
    	$("input[name='jisi_h_calc_su']").val(row_su);
    	$("input[name='jisi_h_calc_jung']").val(row_jung.toFixed(2));				
	}
	
	//열처리작업 리스트
	var workHDataTable;
	function getWorkHList(){
		workHDataTable = new Tabulator("#workHTabu", {
		    height:"180px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
		    paginationSize:20,
		    paginationSizeSelector:[20,50,100,500,1000],
		    paginationCounter:"rows",
		    headerSort:false,
		    ajaxResponse:function(url, params, response){
				$("#workHTabu .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
				{	headerSort:false,
		    		formatter:rowDeleteBtn, width:100, title:"",
		    		cellClick:function(e, cell){
		    			cell.getRow().delete();
		    			getWorkHListRowDeleteDataCalc();
	    			}
				},
		        {title:"수주번호", field:"ord_code", sorter:"string", width:120,
			        hozAlign:"center"},	
		        {title:"수주번호", field:"ord_code", sorter:"string", width:120,
			        hozAlign:"center"},	
		        {title:"입고일", field:"ord_input", sorter:"string", width:120,
			        hozAlign:"center"},	
		        {title:"입고수량", field:"ord_su", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"입고중량", field:"ord_amnt", sorter:"string", width:100,
			        hozAlign:"center"},
		        {title:"작업지시수량", field:"jisi_h_su", sorter:"string", width:100,
			        hozAlign:"center"},
		        {title:"작업완료수량", field:"jisi_suc_su", sorter:"string", width:100,
			        hozAlign:"center"},
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},		        
		        {title:"품명", field:"prod_name", sorter:"string", width:220,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"품번", field:"prod_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"입고중량", field:"ord_danj", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input", visible:false},	
		        {title:"소입경도", field:"prod_pg", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input", visible:false},	
		        {title:"경화깊이", field:"prod_gd", sorter:"int", width:220,
		        	hozAlign:"center", headerFilter:"input", visible:false},
		        //출고정보 추가예정
		        {title:"jisi_h_pre_temp", field:"jisi_h_pre_temp", visible:false},
		        {title:"jisi_h_chim_temp", field:"jisi_h_chim_temp", visible:false},
		        {title:"jisi_h_diff_temp", field:"jisi_h_diff_temp", visible:false},
		        {title:"jisi_h_gang_temp", field:"jisi_h_gang_temp", visible:false},
		        {title:"jisi_h_crack_temp", field:"jisi_h_crack_temp", visible:false},
		        {title:"jisi_h_cold_temp", field:"jisi_h_cold_temp", visible:false},
		        {title:"jisi_h_pre_time", field:"jisi_h_pre_time", visible:false},
		        {title:"jisi_h_chim_time", field:"jisi_h_chim_time", visible:false},
		        {title:"jisi_h_diff_time", field:"jisi_h_diff_time", visible:false},
		        {title:"jisi_h_gang_time", field:"jisi_h_gang_time", visible:false},
		        {title:"jisi_h_crack_time", field:"jisi_h_crack_time", visible:false},
		        {title:"jisi_h_cold_time", field:"jisi_h_cold_time", visible:false},
		        {title:"jisi_h_pre_cp", field:"jisi_h_pre_cp", visible:false},
		        {title:"jisi_h_chim_cp", field:"jisi_h_chim_cp", visible:false},
		        {title:"jisi_h_diff_cp", field:"jisi_h_diff_cp", visible:false},
		        {title:"jisi_h_gang_cp", field:"jisi_h_gang_cp", visible:false},
		        {title:"jisi_h_crack_cp", field:"jisi_h_crack_cp", visible:false},
		        {title:"jisi_h_rx", field:"jisi_h_rx", visible:false},
		        {title:"jisi_h_lpg", field:"jisi_h_lpg", visible:false},
		        {title:"jisi_h_agi", field:"jisi_h_agi", visible:false},
		        {title:"jisi_t_temp", field:"jisi_t_temp", visible:false},
		        {title:"jisi_t_time", field:"jisi_t_time", visible:false},
		    	{field:"jisi_j_code", visible:false},
		    	{field:"jisi_h_code", visible:false},
		    ],
		    rowFormatter:function(row){
			    row.getElement().style.fontWeight = "600";
			},
			rowClick:function(e, row){

				$("#workHTabu .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#workHTabu div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});
			}
		});		
	}
	
	
	function workHSave(){
		//form태그값 조회		
		var formData = $("#workHForm").serialize();
		var formJson = {};
		
//		console.log(formData);
		
		formData.split("&").forEach(data => {
			const [key,value] = data.split("=");
/*			var v_value = " ";
			if(value.length > 0){v_value = decodeURIComponent(value)}*/
			formJson[key] = decodeURIComponent(value);
		});
		
		var formJsonString = JSON.stringify(formJson);
		
		var hDataList = workHDataTable.getData();
		
		var objParams = {
			"hDataList":hDataList,
			"hDataForm":formJson
		};

		var jsonData = JSON.stringify(objParams);
		jQuery.ajaxSettings.traditional = true;		
		
	    $.ajax({
	        url: "/tkheat/production/workInstruction/workJisiHSave",
            type: "post",
            dataType: "json",
            data:{"jsonData" : jsonData
            },
	        success: function(result) {
//	        	console.log(result.data1);
//	        	console.log(result.data2);
				$("#workHForm")[0].reset();
				workHCloseBtn();
				workHIpgoSelectOrdCodeArray = new Array();
				getWorkJisiAllListData();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
		
		
	}
	
	function workHCloseBtn(){
		$("#workHForm")[0].reset();
		workHIpgoSelectOrdCodeArray = new Array();
		workHModal.style.display = 'none'; // 모달 숨김
	}
	function workJisiReportCloseBtn(){
		workJisiReportModal.style.display = 'none'; // 모달 숨김
	}
	function workJHCloseBtn(){
		workJHModal.style.display = 'none'; // 모달 숨김
	}
	function workPrintStatusCloseBtn(){
		workPrintStatusModal.style.display = 'none'; // 모달 숨김
	}
	function workHIpgoCloseBtn(){		
		workHIpgoModal.style.display = 'none'; // 모달 숨김
	}
	
	
	//모달기능
	const workHIpgoModal = document.querySelector('.workHIpgoModal');
	const workHModal = document.querySelector('.workHModal');
	const workJHModal = document.querySelector('.workJHModal');
	const workJisiReportModal = document.querySelector('.workJisiReportModal');
	const workPrintStatusModal = document.querySelector('.workPrintStatusModal');
	
	const header = document.querySelector('.header'); // 헤더를 드래그할 요소로 사용
	
	header.addEventListener('mousedown', function(e) {
		// transform 제거를 위한 초기 위치 설정
		const rect = workSetModal.getBoundingClientRect();
		workSetModal.style.left = rect.left + 'px';
		workSetModal.style.top = rect.top + 'px';
		workSetModal.style.transform = 'none'; // 중앙 정렬 해제

		let offsetX = e.clientX - rect.left;
		let offsetY = e.clientY - rect.top;

		function moveModal(e) {
			workSetModal.style.left = (e.clientX - offsetX) + 'px';
			workSetModal.style.top = (e.clientY - offsetY) + 'px';
		}

		function stopMove() {
			window.removeEventListener('mousemove', moveModal);
			window.removeEventListener('mouseup', stopMove);
		}

		window.addEventListener('mousemove', moveModal);
		window.addEventListener('mouseup', stopMove);
	});

		

	// 모달 열기
	//단취등록
	$("#jAddBtn").on("click",function(){
		$("#workJForm")[0].reset();
		getWorkJData();
		$("#jisi_j_sdate").val(yesterDate());
		$("#jisi_j_edate").val(todayDate());
		
		getWorkJList();
		
		workJModal.style.display = 'block'; // 모달 표시
	});

	
	//열처리등록
	$("#hAddBtn").on("click",function(){

		getWorkHList();
		workHModal.style.display = 'flex'; // 모달 표시

	});
	
    </script>

	</body>
</html>
