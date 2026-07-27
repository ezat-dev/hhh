<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자주검사불량현황</title>
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
.nonModal {
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    position: fixed;
    display: none;
    z-index: 1000;
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
    position: relative;
}
.header-close {
	position: absolute;
	right: 15px;
	top: 10px;
	cursor: pointer;
	font-size: 20px;
	color: white;
}
#editPop {
    background: #ffffff;
    border: 1px solid #000;
    width: 1000px;  /* 줄임 */
    height: 600px;  /* 줄임 */
    padding: 15px;
    border-radius: 5px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
    overflow-y: auto;
}

.insideTable {
    width: 100%; /* 테이블 너비 100% */
    border-collapse: collapse; /* 테두리 겹침 제거 */
}

.insideTable th,
.insideTable td {
    padding: 4px 6px;
    border: 1px solid #ccc;
    vertical-align: top;
    line-height: 1.2;
    font-size: 13px;
}

.insideTable th {
    background: #f4f4f4;
    white-space: nowrap;
    text-align: center;        /* 가로 중앙 정렬 */
    vertical-align: middle;    /* 세로 중앙 정렬 */
}

.basic, .rp-input, .form-control {
    width: calc(100% - 12px); /* 너비 조정 */
    padding: 5px; /* 내부 여백 */
    border: 1px solid #949494; /* 경계선 색상 */
    border-radius: 3px; /* 둥근 모서리 */
}

.basic[readonly] {
    background-color: #f9f9f9; /* 읽기 전용 필드 색상 */
}

textarea {
    width: 100%;
    height: 60px !important; /* 기본 높이 줄이기 */
    padding: 4px;
}

.findImage {
    flex-direction: column;
    align-items: flex-start;
}
.findImage input[type="file"] {
    margin-right: 10px; /* 오른쪽 여백 */
}

.img-rounded {
    border-radius: 5px; /* 둥근 모서리 */
}

.imgArea {
    width: 100%; /* 이미지 영역 너비 */
    height: 100px; /* 이미지 영역 높이 */
    border: 1px solid #ddd; /* 경계선 */
    margin-bottom: 10px; /* 하단 여백 */
}

.imgArea img {
    width: 100%;
    height: 100%;
    object-fit: contain; /* cover → contain으로 여백 줄임 */
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
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -1050px;
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
    display: flex;
    align-items: center;
    justify-content: flex-end;
}
#tab1 .tabulator-paginator {
    display: flex;
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

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.modal-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  width: 90%;
  max-width: 1000px;
  position: relative;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  font-weight: bold;
  font-size: 18px;
  margin-bottom: 10px;
}

.modal-close {
  cursor: pointer;
  font-size: 24px;
}
    
/* 헤더 컬럼 높이 고정 */
.tabulator .tabulator-col {
    height: 55px !important;
}

/* 헤더 필터 input 위치 고정 */
.tabulator .tabulator-col .tabulator-col-content {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
       <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>        
	   <label class="daylabel">기간 : </label>
	   <input type="date" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off"> ~ 
	   <input type="date" class="edate" id="edate" style="font-size: 16px;" autocomplete="off">			
	</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getJajuStatusList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
        <button class="insert-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%);">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
         입력 
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
        엑셀    
        </button>
        <button class="printer-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
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
	    
<form method="post" id="nonInsertForm" name="nonInsertForm" enctype="multipart/form-data">		    
	<div class="nonModal">    
            <div id="editPop">
            	<div class="header">
            			자주검사등록
            			<span class="header-close">&times;</span>
            	</div>
                
                <!-- Article List1 -->
                <div class="section1">
                    <div class="subTitle">
                        <div class="h3">기본정보</div></div>
                    <div class="detail">
                        <table cellspacing="0" cellpadding="0" width="100%">
                            <tbody><tr>
                                <td class="">
                                    <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                                    <colgroup span="4">
                                        <col width="*">
                                        <col width="40%">
                                        <col width="*">
                                        <col width="40%">
                                    </colgroup>
                                        <tbody><tr>
                                            <th class="left">거래처</th>
                                            <td class=""><input id="corp_name" class="basic" type="text" style="width:60%;" value="" name="corp_name" readonly=""> <input type="button" value="검색" onclick="openCorpListModal();" class="btnSearchSmall"></td>
                                            <th class="">품명</th>
                                            <td class=""><input id="prod_name" class="basic" type="text" style="width:90%;" value="" name="prod_name" readonly=""></td>
                                        </tr>
                                        <tr>
                                            <th class="">품번</th>
                                            <td class=""><input id="prod_no" class="basic" type="text" style="width:90%;" value="" name="prod_no" readonly=""></td>
                                            
                                            <th hidden="" class="">LOT No</th>
                                            <td hidden="" class=""><input id="werr_lot" class="basic" type="text" style="width:90%;" value="" name="werr_lot" readonly=""></td>
                                        </tr>
                                        <tr>
                                            <th class="">작성일자</th>
                                            <td class=""><input id="werr_date"  type="date" style="width:100px;"  maxlength="20" size="20" name="werr_date" ></td>
                                            
                                            <th hidden="" class="">관리번호</th>
                                            <td hidden="" class=""><input id="werr_yu" class="basic" type="text" style="width:90%;" value="" name="werr_yu" readonly=""></td>
                                            
                                            <th class="">금액</th>
                                            <td class=""><input id="werr_mon" class="basic" type="text" style="width:90%;" value="" name="werr_mon"></td>
                                        </tr>
                                        <tr>
                                            <th class="">발생일자</th>
                                            <td class=""><input id="werr_wdate" class="date js-datepicker hasDatepicker" type="text" style="width:100px;" value="" maxlength="20" size="20" name="werr_wdate" readonly=""></td>
                                            <th class="">열처리LOT</th>
                                            <td class=""><input id="tech_te" class="basic" type="text" style="width:90%;" value="" name="tech_te" readonly=""></td>
                                        </tr>
                                        <tr>
                                            <th class="">발생자</th>
                                            <td class=""><input id="werr_user" class="basic" type="text" style="width:90%;" value="" name="werr_user"></td>
                                            <th class="">보고자</th>
                                            <td class=""><input id="werr_rep" class="basic" type="text" style="width:90%;" value="admin" name="werr_rep"></td>
                                        </tr>
                                        <tr>
                                            <th class="">생산수량</th>
                                            <td class=""><input id="werr_amnt" class="basic" type="text" style="width:90%;" value="0" name="werr_amnt"></td>
                                            <th class="">설비</th>
                                            <td class="">
                                            <input id="fac_name" class="basic" type="text" style="width:90%;" value="" name="fac_name" readonly="readonly"/></td>
                                            <input id="ilbo_code" class="basic" type="hidden" style="width:90%; display:none;" value="0" name="ilbo_code"/>
                                            <input id="ilbo_no" class="basic" type="hidden" style="width:90%; display:none;" value="" name="ilbo_no"/>
                                            <input id="werr_code" class="basic" type="hidden" style="width:90%; display:none;" value="0" name="werr_code" />
                                            <input id="ilbo_lot" class="basic" type="hidden" style="width:90%; display:none;" value="" name="ilbo_lot" />
                                        </tr>
                                    </tbody></table>
                                </td>
                                </tr>
                        </tbody></table>
                    </div>
                </div>
                <div class="clear"></div>
                <!-- Article List1.end -->
            
                <!-- Article List2 -->
                <div class="subTitle">
                    <div class="h3">불량정보</div></div>
                    
                <div class="detail">				
                    <table cellspacing="0" cellpadding="0" width="100%">
                        <tbody><tr>
                            <td class="">
                                <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                                    <colgroup span="4">
                                        <col width="*">
                                        <col width="40%">
                                        <col width="*">
                                        <col width="40%">
                                    </colgroup>
                                    <tbody><tr>
                                           <th class="">알림</th>
                                           <td class="">
                                               <input type="checkbox" id="werr_alert" name="werr_alert" checked="checked" class="">
                                           </td>
                                           <th class="">부서</th>
                                           <td class="">
                                            <select id="werr_buso" name="werr_buso" class="basic" style="width: 100%" value="">									
                                                
                                                    <option value="" selected="selected"></option>
                                                  
                                                    <option value="123" selected="selected">123</option>
                                                  
                                                    <option value="123123" selected="selected">123123</option>
                                                  
                                                    <option value="22" selected="selected">22</option>
                                                  
                                                    <option value="관리" selected="selected">관리</option>
                                                  
                                                    <option value="ㅁㅁㅁ" selected="selected">ㅁㅁㅁ</option>
                                                  
                                                    <option value="생산" selected="selected">생산</option>
                                                  
                                                    <option value="생산관리" selected="selected">생산관리</option>
                                                  
                                                    <option value="생산팀" selected="selected">생산팀</option>
                                                  
                                                    <option value="영업" selected="selected">영업</option>
                                                  
                                                    <option value="영업팀" selected="selected">영업팀</option>
                                                  
                                                    <option value="퇴사" selected="selected">퇴사</option>
                                                  
                                                    <option value="품질" selected="selected">품질</option>
                                                  
                                                    <option value="품질팀" selected="selected">품질팀</option>
                                                  
                                            </select>	
                                       </td>
                                    </tr>
                                    <tr>
                                        
                                        
                                        <th class="">불량구분</th>
                                        <td class="">
                                            <select class="basic" id="werr_gubn" name="werr_gubn" style="width:100px;">												
                                                <option selected="selected">찍힘</option>
                                                <option>외관(이물)</option>
                                                <option>외관(발청)</option>
                                                <option>외관(조도)</option>
                                                <option>경도</option>
                                                <option>경화깊이</option>
                                                <option>조직</option>
                                                <option>크랙</option>
                                                <option>사양오적용(혼입)</option>
                                                <option>변형</option>
                                            </select>
                                            <select class="basic" id="werr_in_out_gubn" name="werr_in_out_gubn" style="width:100px;">												
                                                <option selected="selected">사내</option>
                                                <option>사외</option>
                                            </select>
                                        </td>
                                        <th rowspan="3" class="">개선전</th>
                                        <td rowspan="3" class="findImage"><input type="hidden" name="type" value="error">
                                            <input type="file" name="imageFile1" title="이미지 찾기" onchange="previewImage(this,'previewId1')">
                                            <!-- <input type="text" name="imageFile1" title="이미지 찾기" onchange="previewImage(this,'previewId1')"> -->
                                            <div class="imgArea" id="previewId1" style="height:168px;"><img id="prev_previewId1" src="/resources/images/noimage_01.gif" width="100%" height="100%"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="">불량내용</th>
                                        <td class=""><textarea name="werr_gnote" id="werr_gnote" class="basic" style="width:90%; height:80px;"></textarea></td>
                                        </tr>
                                    <tr>
                                        <th class="">발생원인 및 <br>원인분석</th>
                                        <td class=""><textarea name="werr_case" id="werr_case" class="basic" style="width:90%;; height:80px;"></textarea></td>
                                        </tr>
                                    <tr>
                                        <th class="">조치구분</th>
                                        <td class="">
                                            <select class="basic" id="werr_jgubn" name="werr_jgubn" style="width:100px;">												
                                                <option>재작업</option>
                                                <option>폐기</option>
                                                <option>업체통보후납품</option>
                                                <option>별도관리(보관)</option>
                                                <option>기타</option>
                                            </select>
                                        </td>
                                        <th rowspan="3" class="">개선후</th>
                                        <td rowspan="3" class="findImage"><input type="hidden" name="type" value="error">
										<input type="file" name="imageFile2" title="이미지 찾기" onchange="previewImage(this,'previewId2')">
                                            <!-- <input type="text" name="imageFile2" title="이미지 찾기" onchange="previewImage(this,'previewId2')"> -->
                                            <div class="imgArea" id="previewId2" style="height:168px;"><img id="prev_previewId2" src="/resources/images/noimage_01.gif" width="100%" height="100%"></div>
                                        </td>
                                        </tr>
                                    <tr>
                                        <th class="">대책수립 및<br>
                                           	 대책실시</th>
                                        <td class=""><textarea name="werr_jnote" id="werr_jnote" class="basic" style="width:90%; height:200px;"></textarea>
										<input type="file" name="werr_fname" id="werr_fname" title="파일 첨부" onchange="">
                                        <!-- <input type="text" name="werr_fname" title="이미지 찾기" onchange="previewImage(this,'werr_fname')"> -->
                                        <!-- <input type="button" value="X" onclick=""> -->
                                        </td>
                                        </tr>
                                    <!-- <tr>
                                        <th class="">결과분석 및<br />
                                            사후관리</th>
                                        <td class=""><textarea name="werrNote" id="werrNote" class="basic" style="width:100%; height:80px;"></textarea></td>
                                        </tr> -->
                                </tbody></table>
                            </td>
                            </tr>
                    </tbody></table>
                    <table cellspacing="0" cellpadding="0" width="100%" class="">
                                    <tbody><tr>
                                          <td></td>
                                          <td class="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;확인일자&nbsp;&nbsp;&nbsp;&nbsp;
                                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          &nbsp;확인자&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;점검내용&nbsp;
                                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;비고</td>
                                      </tr>
                                    <tr>
                                        <th>유효성점검1차</th>
                                        <td class="">
                                            <input id="check_date_a"  type="date" style="width:100px;" maxlength="20" size="20" name="check_date_a" >
                                            <input id="werr_user1" name="werr_user1" class="basic" type="text" style="width:100px;" value="">
                                            <input id="werr_note1" name="werr_note1" class="basic" type="text" style="width:200px;" value="">
                                            <input id="werr_bigo1" name="werr_bigo1" class="basic" type="text" style="width:100px;" value="">
                                        </td>
                                    </tr>								
                                    <tr>
                                        <th class="">유효성점검2차</th>
                                        <td class="">
                                            <input id="check_date_b" type="date" style="width:100px;" maxlength="20" size="20" name="check_date_b">
                                            <input id="werr_user2" name="werr_user2" class="basic" type="text" style="width:100px;" value="">
                                            <input id="werr_note2" name="werr_note2" class="basic" type="text" style="width:200px;" value="">
                                            <input id="werr_bigo2" name="werr_bigo2" class="basic" type="text" style="width:100px;" value="">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="">유효성점검3차</th>
                                        <td class="">
                                            <input id="check_date_c" type="date" style="width:100px;" maxlength="20" size="20" name="check_date_c">
                                            <input id="werr_user3" name="werr_user3" class="basic" type="text" style="width:100px;" value="">
                                            <input id="werr_note3" name="werr_note3" class="basic" type="text" style="width:200px;" value="">
                                            <input id="werr_bigo3" name="werr_bigo3" class="basic" type="text" style="width:100px;" value="">
                                        </td>
                                    </tr>
                    </tbody></table>
                </div>  
                <div class="btnSaveClose">
					 <button class="save" type="button" onclick="save();">저장</button>
					 <button class="close" type="button" onclick="window.close();">닫기</button>
    	  		</div>                              
            </div>    
              
	    </div>
	      </form>
	      
	      <!-- 설비목록(검색버튼) 팝업창 -->
	<div id="corpListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
			<input type="date" class="subsdate" id="subsdate" style="font-size: 16px;" autocomplete="off"> ~ 
		<input type="date" class="subedate" id="subedate" style="font-size: 16px;" autocomplete="off">
				<span class="modal-title">설비 리스트</span> <span class="modal-close" onclick="closeCorpListModal()">&times;</span>
			</div>
			<div id="corpListTabulator" style="height: 500px;"></div>
		</div>
	</div>
	
	
<script>
	//전역변수
	let now_page_code = "f04";
    var cutumTable;	

	//로드
	$(function(){
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		getJajuStatusList();
	});

	//이벤트
	//함수
	function getJajuStatusList(){
		
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
		    ajaxURL:"/tkheat/quality/jajuStatus/getJajuStatusList",
		    ajaxParams:{
		    	"sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
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
		    	{title:"구분", field:"ilbo_gubn", sorter:"string", width:60,
			        hozAlign:"center", headerFilter:"input", headerSort:false},
		    	{title:"준비코드", field:"juckjaecode", sorter:"string", width:80,
			        hozAlign:"center", headerFilter:"input", headerSort:false},	
			    {title:"작업일", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input", headerSort:false},     
				{title:"시작", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input", headerSort:false}, 
				{title:"종료", field:"ilbo_end", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input", headerSort:false}, 
		        {title:"LOTNO", field:"ilbo_lot", sorter:"string", width:110,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},		        
		        {title:"작업자", field:"user_name", sorter:"string", width:70,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},
		        {title:"품명", field:"prod_name", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},
		        {title:"품번", field:"prod_no", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input", headerSort:false},	
		        {title:"규격", field:"prod_gyu", sorter:"string", width:90,
		        	hozAlign:"center", headerFilter:"input", headerSort:false},  	
		        {title:"재질", field:"prod_jai", sorter:"string", width:90,
			        hozAlign:"center", headerFilter:"input", headerSort:false},	
			        { 
			        	  title: "표면경도", field: "prod_pg", sorter: "string", width: 90,
			        	  hozAlign: "center", headerFilter: "input",  headerSort:false,
			        	  formatter: function(cell) {
			        	    const el = cell.getElement();
			        	    el.style.backgroundColor = "#fff599"; // 연노랑
			        	    el.style.fontWeight = "bold";
			        	    return cell.getValue();
			        	  }
			        	},
			        	{ 
			        	  title: "판정", field: "ilbo_okng", sorter: "string", width: 80,
			        	  hozAlign: "center", headerFilter: "input",  headerSort:false,
			        	  formatter: function(cell) {
			        	    const el = cell.getElement();
			        	    el.style.backgroundColor = "#e74c3c"; // 빨간색
			        	    el.style.color = "#fff"; // 흰색 글자
			        	    el.style.fontWeight = "bold";
			        	    return cell.getValue();
			        	  }
			        	},

				{title:"x1", field:"ilbo_pg1", sorter:"String", width:80,
					hozAlign:"center", headerFilter:"input", headerSort:false},
			    {title:"x2", field:"ilbo_pg2", sorter:"String", width:80,
					hozAlign:"center", headerFilter:"input", headerSort:false},
 			    {title:"x3", field:"ilbo_pg3", sorter:"String", width:80,
					hozAlign:"center", headerFilter:"input", headerSort:false},
				{title:"x4", field:"ilbo_pg4", sorter:"String", width:80,
					hozAlign:"center", headerFilter:"input", headerSort:false},
	 			{title:"x5", field:"ilbo_pg5", sorter:"String", width:80,
				    hozAlign:"center", headerFilter:"input", headerSort:false},
				    
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
	
	//부적합등록 저장
    function save() {
	    var formData = new FormData($("#nonInsertForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.werr_code) {
	        formData.append("mode", "update");
	        formData.append("werr_code", selectedRowData.werr_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

		console.log($("#nonInsertForm")[0].werr_code);
	    
	    $.ajax({
	        url: "/tkheat/quality/nonInsert/nonInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	            alert("저장 되었습니다.");
	            $(".nonModal").hide();
	            getNonInsertList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}


	function deleteNon() {
	    if (!selectedRowData || !selectedRowData.werr_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/quality/nonInsert/deleteNon",
	        type: "POST",
	        data: {
	        	werr_code: selectedRowData.werr_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".nonModal").hide();
	                getNonInsertList();
	            } else {
	                alert("삭제 중 오류가 발생했습니다: " + result.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("삭제 오류:", error);
	            alert("삭제 요청 중 오류가 발생했습니다.");
	        }
	    });
	}
	
	function nonInsertDetail(werr_code){
		$.ajax({
			url:"/tkheat/quality/nonInsert/nonInsertDetail",
			type:"post",
			dataType:"json",
			data:{
				"werr_code":werr_code
			},
			success:function(result){
				console.log(result);
				var allData = result.data;
				
				for(let key in allData){
//					console.log(allData, key);	
					$("[name='"+key+"']").val(allData[key]);
				}

				$('.nonModal').show().addClass('show');
			}
		});
	}


	//설비검색버튼 리스트 모달
    function openCorpListModal() {
        document.getElementById('corpListModal').style.display = 'flex';

        
        let facListTable = new Tabulator("#corpListTabulator", {
            height:"450px",
            layout:"fitColumns",
            selectable:true,
            ajaxURL:"/tkheat/quality/nonInsert/getNonCorpList",
            ajaxConfig:"POST",
            ajaxParams:{
            	"fac_code": $("#fac_code").val() || 0,
                "ord_code": $("#ord_code").val() || 0,
                "prod_code": $("#prod_code").val() || 0,
                "ilbo_code": $("#ilbo_code").val() || 0,
                "ilbo_no": $("#ilbo_no").val() || 0,
                "corp_code": $("#corp_code").val() || 0,
                "werr_wdate": $("#werr_wdate").val() || 0,
                "ilbo_lot": $("#ilbo_lot").val() || 0
                   
            },
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				console.log(response);
		        return response.data; //return the response data to tabulator
		    },    
            columns:[
                {title:"NO", field:"idx", width:80, hozAlign:"center"},
                {title:"입고일", field:"ord_date", width:120, hozAlign:"center"},
                {title:"생산일", field:"ilbo_date", width:120, hozAlign:"center"},
                {title:"거래처", field:"corp_name", width:150, hozAlign:"center"},
                {title:"품명", field:"prod_name", width:100, hozAlign:"center"},
                {title:"품번", field:"prod_no", width:200, hozAlign:"center"},
                {title:"공정", field:"tech_te", width:200, hozAlign:"center"},
                {title:"설비", field:"fac_name", width:200, hozAlign:"center"},
                {title:"수량", field:"ilbo_su", width:200, hozAlign:"center"},
                {title:"고객LOT", field:"ord_lot", width:200, hozAlign:"center"},
                {title:"열처리LOT", field:"ilbo_lot", width:200, hozAlign:"center"},
                {title:"열처리LOT", field:"ord_code", width:200, hozAlign:"center", visible:false},
                {title:"열처리LOT", field:"fac_code", width:200, hozAlign:"center", visible:false},
                {title:"열처리LOT", field:"prod_code", width:200, hozAlign:"center", visible:false},
                {title:"열처리LOT", field:"ilbo_code", width:200, hozAlign:"center", visible:false},
                {title:"열처리LOT", field:"ilbo_no", width:200, hozAlign:"center", visible:false},
                {title:"열처리LOT", field:"corp_code", width:200, hozAlign:"center", visible:false},
                
            ],
            rowDblClick:function(e, row){
                let data = row.getData();
                
                console.log("선택된 설비:", data);
                document.getElementById('werr_wdate').value = data.werr_wdate;
                document.getElementById('corp_name').value = data.corp_name;
                document.getElementById('prod_name').value = data.prod_name;
                document.getElementById('prod_no').value = data.prod_no;
                document.getElementById('fac_name').value = data.fac_name;
                document.getElementById('ilbo_lot').value = data.ilbo_lot;
                document.getElementById('corpListModal').style.display = 'none';
            }
        });
    }

    function closeCorpListModal() {
        document.getElementById('corpListModal').style.display = 'none';
    }
	

    </script>
    
 <script>
		
 	
	const modal = document.querySelector('.nonModal');
	const header = document.querySelector('.header');

	header.addEventListener('mousedown', function(e) {
		
		const rect = modal.getBoundingClientRect();
		modal.style.left = rect.left + 'px';
		modal.style.top = rect.top + 'px';
		modal.style.transform = 'none';

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
		

	// 모달 열기
	const insertButton = document.querySelector('.insert-button');
	const nonModal = document.querySelector('.nonModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');

	insertButton.addEventListener('click', function() {
		nonModal.style.display = 'block'; // 모달 표시
	});

	closeButton.addEventListener('click', function() {
		nonModal.style.display = 'none'; // 모달 숨김
	});

	headerCloseButton.addEventListener('click', function() {
		nonModal.style.display = 'none';
	});

    </script>

	</body>
</html>
