<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>제품등록</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %> 
    <style>
.main {
	width: 98%;
}

.container {
	display: flex;
	justify-content: space-between;
}
.productModal {
    position: fixed;
    top: 50%;
    left: 50%;
    display: none;
    transform: translate(-50%, -50%);
    z-index: 1000;
}

.detail {
    background: #ffffff;
    border: 1px solid #000000;
    width: 1200px;
    height: 720px; /* 원래 높이 유지 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
    margin: 0 auto;
    border-radius: 5px;
    position: relative; /* 헤더 absolute 기준 */
    overflow: hidden; /* 전체 스크롤 방지 */
}

.header {
    position: absolute; /* 모달 상단 고정 */
    top: 0;
    left: 0;
    right: 0;
    height: 50px;
    background-color: #33363d;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-size: 20px;
    z-index: 10;
}

.header-close {
    position: absolute;
    right: 15px;
    top: 10px;
    cursor: pointer;
    font-size: 20px;
    color: white;
}

.modal-body {
    position: absolute;
    top: 50px; /* 헤더 높이만큼 아래 시작 */
    left: 0;
    right: 0;
    bottom: 0; /* 모달 하단까지 */
    overflow-y: auto; /* 내용만 스크롤 */
    padding: 20px;
}


.insideTable {
	width: 100%; /* 내부 테이블 너비 100% */
	border-collapse: collapse;
}

.insideTable th, .insideTable td {
	padding: 5px; /* 셀 패딩을 줄여 세로 길이 감소 */
	border: 1px solid #ccc; /* 셀 경계선 */
	text-align: left; /* 텍스트 왼쪽 정렬 */
}

.insideTable th {
	background: #f0f0f0; /* 헤더 배경색 */
	font-weight: bold; /* 굵은 글씨 */
}

.basic {
	background: #ffffff;
	border: 1px solid #949494; /* 경계선 색상 */
	width: calc(50% - 10px); /* 입력 박스 너비 조정 */
	padding: 5px; /* 내부 여백 */
	box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1); /* 내부 그림자 */
	border-radius: 3px; /* 둥근 모서리 */
	display: inline-block; /* 인라인 블록으로 설정하여 가로 정렬 */
	margin-right: 5px; /* 입력 박스 간격 조정 */
}

.basic:last-child {
	margin-right: 0; /* 마지막 입력 박스의 여백 제거 */
}



.btnSearchCorp:hover, .btn1T:hover {
	background: #0056b3; /* 호버 시 색상 변경 */
}

.resultArea2 {
	background: #f9f9f9; /* 결과 영역 배경색 */
	padding: 10px; /* 내부 여백 */
	border: 1px solid #ddd; /* 경계선 */
	border-radius: 5px; /* 모서리 둥글게 */
}

.imgArea {
	width: 200px; /* 이미지 영역 너비 */
	height: 150px; /* 이미지 영역 높이 */
	border: 1px solid #ddd; /* 경계선 */
	margin-bottom: 10px; /* 하단 여백 */
}

.imgClass {
	width: 100%; /* 이미지 너비 */
	height: 100%; /* 이미지 높이 */
	object-fit: cover; /* 이미지 비율 유지 */
}

.tdRight {
	text-align: right; /* 오른쪽 정렬 */
}

.thSub2 {
	width: 100px; /* 서브 헤더 너비 */
}
.thSub {
	width: 100px; /* 서브 헤더 너비 */
}
.valClean {
	margin-left: 5px; /* 여백 */
}

textarea {
	border: 1px solid #949494; /* 경계선 색상 */
	padding: 5px; /* 내부 여백 */
	width: calc(100% - 10px); /* 너비 100%에서 여백 제외 */
	height: 100px; /* 높이 */
	border-radius: 3px; /* 둥근 모서리 */
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

.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -250px;
}

.box1 input{
	width : 5%;
}
.box1 select{
	width: 5%
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
/* 페이지네이션 중앙정렬 */
.tabulator-footer {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 10px 0;
}

/* 커스텀 페이지 버튼 */
.custom-pagination button {
    margin: 0 5px;
    padding: 5px 10px;
    border: 1px solid #ccc;
    background: #f8f8f8;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
}
.custom-pagination button:hover {
    background: #007bff;
    color: white;
    border-color: #007bff;
}

</style>
    
    
    <body>
    
    <div class="tab">
    
    <div class="box1">
           <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
        	<label class="daylabel">업체명 :</label>
			<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off">
			<!-- <label class="daylabel">업체명 :</label>
			<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off">
			
			<label class="daylabel">품명 :</label>
			<input type="text" class="prod_name" id="prod_name" style="font-size: 16px;" autocomplete="off">
			
			<label class="daylabel">품번 :</label>
			<input type="text" class="prod_no" id="prod_no" style="font-size: 16px;" autocomplete="off">
			
			<label class="daylabel">규격 :</label>
			<input type="text" class="prod_gyu" id="prod_gyu" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">재질 :</label>
			<input type="text" class="prod_jai" id="prod_jai" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">표면경도 :</label>
			<input type="text" class="prod_pg" id="prod_pg" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">경화깊이 :</label>
			<input type="text" class="prod_gd3" id="prod_gd3" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">심부경도 :</label>
			<input type="text" class="prod_sg" id="prod_sg" style="font-size: 16px; autocomplete="off">
			
			<label class="daylabel">공정 :</label>
			<select id="tech_te" name="tech_te" class="basic valPost valClean">
                  
                    <option value="">전체</option>
                    
                    <option value="A08">가스산질화</option>
                  
                    <option value="A11">가스연질화</option>
                  
                    <option value="A12">가스질화</option>
                  
                    <option value="A13">기타</option>
                  
                    <option value="A14">염욕질화</option>
                  
                    <option value="A15">외주품</option>
                  
                    <option value="A16">이온질화</option>
                  
                    <option value="A17">진공열처리</option>
                  
                    <option value="A18">침류질화</option>
                  
                    <option value="A20">침탄</option>
                  
                    <option value="A21">침탄질화</option>
                  
                    <option value="A27">침탄PQ</option>
                  
                    <option value="A30">템퍼링</option>
                  
                    <option value="A31">템퍼링기타</option>
                  
                    <option value="A32">Annearling</option>
                  
                    <option value="A33">Case-Vc</option>
                  
                    <option value="A34">Normalizing</option>
                  
                    <option value="A35">PLASOX</option>
                  
                    <option value="B16">PQ</option>
                  
                    <option value="B17">QT</option>
                  
                    <option value="B38">VT침탄</option>
                  
                </select>
			 -->
			
			
			</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getProductList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
            
        </button>
        <button class="printer-button">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
            
        </button>
    </div>
    
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>


<form method="post" class="corrForm" id="productInsertForm" name="productInsertForm">	    
<div class="productModal">    
 <div class="detail">
 <div class="header">
 	제품등록
 	<span class="header-close">&times;</span>
 </div>
 	<div class="modal-body">
    <table cellspacing="0" cellpadding="0" width="100%">
      <tbody><tr>
        <td>
          <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
            <colgroup span="4">
              <col width="*">
              <col width="40%">
              <col width="*">
              <col width="40%">
            </colgroup>
            <tbody><tr>
              <th class="left">등록일</th>
              <td><input id="prod_date" name="prod_date" type="date" style="width:100px;" maxlength="20" size="20"></td>
              <th>구분</th>
              <td>
                <select id="prod_gubn" name="prod_gubn" class="basic valPost valClean" style="width:150px;">										
                  <option>양산</option>
                  <option>개발</option>
                </select>
              </td>
            </tr>
            <tr>
              <th class="left">거래처</th>
              <td>
                  <input id="corp_name" name="corp_name"class="basic valClean" type="text" style="width:60%;"  readonly="readonly">
                  <input id="corp_code" name="corp_code" class="basic valPost valClean" type="hidden" style="width:50%;"  readonly="readonly">
                <input class="btnSearchCorp" name="" type="button" title="거래처선택" value="검색" onclick="openCutumModal();">

              </td>
              <th>관리번호</th>
              <td><input id="prod_cno" name="prod_cno" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>
            <tr>
              <th class="left">품명</th>
              <td>
                <input id="prod_name" name="prod_name" class="basic valPost valClean" type="text" style="width:90%;" value="">
<!--                 <input id="PROD_CODE" name="prod_code" class="basic valPost valClean" type="hidden" value=""> -->
              </td>
              <th><span class="left">품번</span></th>
              <td><input id="prod_no" name="prod_no" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>
            <tr>
              <th class="left">모델명</th>
              <td><input id="prod_model" name="prod_model" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
              <th><span class="left">재질</span></th>
              <td><input id="prod_jai" name="prod_jai" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>									
            <tr>
              <th class="left">규격</th>
              <td>
                <input id="prod_gyu" name="prod_gyu" class="basic valPost valClean" type="text" style="width:200px;" value="">
                <input type="button" value="Φ" class="btn1T" onclick="$('#prod_gyu').val($('#prod_gyu').val()+'Φ');">
                <input type="button" value="X" class="btn1T" onclick="$('#prod_gyu').val($('#prod_gyu').val()+'X');">
                <input type="button" value="L" class="btn1T" onclick="$('#prod_gyu').val($('#prod_gyu').val()+'L');">
              </td>
              <th><span class="left">단중(kg)</span></th>
              <td><input id="prod_danj" name="prod_danj" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>
            <tr>
              <th class="left">단가</th>
              <td><input id="prod_dang" name="prod_dang" class="basic valPost valClean" type="text" style="width:90%;" value="0"></td>
              <th class="left">단위</th>
              <td>
                <select id="prod_danw" name="prod_danw" class="basic valPost valClean" style="width:150px;">
                  <option>EA</option>
                  <option>CH</option>
                  <option>KG</option>
                </select>
              </td>
            </tr><tr>
            </tr><tr>
              <th>수입검사</th>
              <td style="vertical-align: top;">
                <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                  <tbody><tr>
                  <th>치수1</th>
                  <td><input id="prod_chisu1n" name="prod_chisu1n"  type="text" value="">-<input id="prod_chisu1s" name="prod_chisu1s"  type="text" value=""></td>
                    </tr>
                    <tr>
                  <th>치수2</th>
                  <td><input id="prod_chisu2n" name="prod_chisu2n"  type="text" value="">-<input id="prod_chisu2s" name="prod_chisu2s" type="text" value=""></td>
                    </tr>
                    <tr>
                  <th>치수3</th>
                  <td><input id="prod_chisu3n" name="prod_chisu3n" type="text" value="">-<input id="prod_chisu3s" name="prod_chisu3s" type="text" value=""></td>
                    </tr>
                    <tr>
                  <th>치수4</th>
                  <td><input id="prod_chisu4n" name="prod_chisu4n"  type="text" value="">-<input id="prod_chisu4s" name="prod_chisu4s" type="text" value=""></td>
                    </tr>
                    <tr>
                  <th>치수5</th>
                  <td><input id="prod_chisu5n" name="prod_chisu5n"  type="text" value="">-<input id="prod_chisu5s" name="prod_chisu5s" type="text" value=""></td>
                    </tr>
                </tbody></table>
              </td>
            </tr>
            <tr>
              <th class="left">연마여유(mm)</th>
              <td style="vertical-align: top;">
                <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                  <tbody><tr><td><input id="prod_polish" name="prod_polish" class="basic valPost valClean" type="text" style="width:90%;" value="0"></td>
                </tr></tbody></table>
              </td>
              <th><span class="left">박스당수량</span></th>
              <td><input id="prod_boxsu" name="prod_boxsu" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>
            <tr>
              <th><span class="left">공정</span></th>
              <td>
                <select id="tech_no" name="tech_no" class="basic valPost valClean">
                  
                    <option value="A08">PIT로-가스산질화(A08)</option>
                  
                    <option value="A11">PIT로-가스질화(A11)</option>
                  
                    <option value="A12">PIT로-가스연질화(A12)</option>
                  
                    <option value="A13">PIT로-Annearling(A13)</option>
                  
                    <option value="A14">PIT로-Normalizing(A14)</option>
                  
                    <option value="A15">PIT로-기타(A15)</option>
                  
                    <option value="A16">Box Type-QT(A16)</option>
                  
                    <option value="A17">Box Type-침탄(A17)</option>
                  
                    <option value="A18">Box Type-침탄질화(A18)</option>
                  
                    <option value="A20">Box Type-가스연질화(A20)</option>
                  
                    <option value="A21">Box Type-Normalizing(A21)</option>
                  
                    <option value="A27">이온질화-이온질화(A27)</option>
                  
                    <option value="A30">Salt로-염욕질화(A30)</option>
                  
                    <option value="A31">Box Type-Case-Vc(A31)</option>
                  
                    <option value="A32">PIT로-Normalizing(A32)</option>
                  
                    <option value="A33">Box Type-VC침탄(A33)</option>
                  
                    <option value="A34">Box Type-가스질화(A34)</option>
                  
                    <option value="A35">PIT로-침류질화(A35)</option>
                  
                    <option value="B16">템퍼링로-템퍼링(B16)</option>
                  
                    <option value="B17">템퍼링로-템퍼링기타(B17)</option>
                  
                    <option value="B38">진공로-진공열처리(B38)</option>
                  
                    <option value="B39">이온질화-PLASOX(B39)</option>
                  
                    <option value="B40">진공로-Annearling(B40)</option>
                  
                    <option value="B41">진공로-Normalizing(B41)</option>
                  
                    <option value="B42">진공로-기타(B42)</option>
                  
                    <option value="C01">PQ-PQ(C01)</option>
                  
                    <option value="C02">PQ-외주품(C02)</option>
                  
                    <option value="C03">PQ-침탄PQ(C03)</option>
                  
                </select>
              </td>
              <th>공정순서</th>
              <td><input id="tech_seq" name="tech_seq" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>
            <tr>
              <th class="left changeDanga" style="display: none;">입고변경단가</th>
              <td colspan="4" class="changeDanga" style="display: none;">
                <input type="text" id="changeIpgoFromDate" name="changeIpgoFromDate" value="" class="date" style="width:85px;" readonly="">
                ~<input type="text" id="changeIpgoToDate" name="changeIpgoToDate" value="" class="date" style="width:85px;" readonly="">
                <input id="changeIpgoValue" name="changeIpgoValue" class="basic" type="text" style="width:10%;" value="" placeholder="변경단가 입력">
                <input class="" type="button" title="단가를 적용시키실려면 클릭하세요" value="저장" style="width:50px;" onclick="changeIpgoDanga();">
              </td>
            </tr>
            <tr>
              <th class="left changeDanga" style="display: none;">출고변경단가</th>
              <td colspan="4" class=" changeDanga" style="display: none;"><input type="text" id="changeFromDate" name="changeFromDate" value="" class="date" style="width:85px;" readonly="">
              ~<input type="text" id="changeToDate" name="changeToDate" value="" class="date" style="width:85px;" readonly="">
              <input id="changeValue" name="changeValue" class="basic" type="text" style="width:10%;" value="" placeholder="변경단가 입력">
              <input class="" type="button" title="단가를 적용시키실려면 클릭하세요" value="저장" style="width:50px;" onclick="changeDanga();">
              </td>										
            </tr>	
            <tr>
              <th>공정패턴</th>
              <td><input id="tech_pattern" name="tech_pattern" class="basic valPost valClean" type="number" value=""></td>
              <th>포장방법</th>
              <td><input id="prod_danch" name="prod_danch" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>	
            </tr>
            <tr>
              <th class="left">BOX TYPE</th>
              <td>
                <select id="prod_box" name="prod_box" class="basic valPost valClean" style="width:150px;">
                  <option>A</option>
                  <option>B</option>
                </select>
              </td>
              <th class="left">열처리곡선</th>
              <td>
                <select id="prod_snp" name="prod_snp" class="basic valPost valClean" type="text" style="width:150px;" value="">
                  <option>불요</option>
                  <option>필요</option>
                </select>
              </td>
            </tr>
            <tr>
              <th class="left">방청유</th>
              <td>
                <select id="prod_bangch" name="prod_bangch" class="basic valPost valClean" style="width:150px;">
                  <option>필요없음</option>
                  <option>수용성</option>
                  <option>유용성</option>
                  <option>기타</option>
                </select>
              </td>
              <th class="left">후처리</th>
              <td>
                <select id="prod_vnyl" name="prod_vnyl" class="basic valPost valClean" style="width:150px;">
                  <option>불요</option>
                  <option>쇼트SHOT-H</option>
                  <option>쇼트SHOT-T</option>
                  <option>쇼트SHOT-A</option>
                  <option>쇼트SHOT-H</option>
                  <option>센딩SAND-A</option>
                  <option>센딩SAND-index</option>
                  <option>센딩SAND-T</option>
                  <option>센딩SAND-conveyer</option>
                </select>
              </td>
            </tr>
            <tr>
              <th class="left">시편제목</th>
              <td>
                <select id="prod_pad" name="prod_pad" class="basic valPost valClean" style="width:150px;">
                  <option>본품</option>
                  <option>대체시편</option>
                  <option>시편절단(본품절단)</option>
                  <option>시편필요없음</option>
                </select>
              </td>
              <th class="left">제품실재고 현황</th>
              <td>
                <input id="prod_realjai" name="prod_realjai" class="basic valPost valClean" type="text" style="width:90%;" value="">
              </td>
            </tr>	
            <tr>
            <th class="left">업종</th>
              <td>
                <select id="prod_upjong" name="prod_upjong" class="basic valPost valClean" style="width:150px;">
                  <option>자동차</option>
                  <option>선박</option>
                  <option>유압</option>
                  <option>방산</option>
                  <option>기타</option>
                </select>
              </td>
            <th class="left">성적서</th>
              <td>
                <select id="prod_plt" name="prod_plt" class="basic valPost valClean" style="width:150px;">
                  <option>필요</option>
                  <option>불필요</option>
                </select>
              </td>
            </tr>									
            <tr>
  <th class="left">SPEC</th>
  <td colspan="3">
    <table class="insideTable w-100">
      <tbody>
        <!-- 경도 정보 영역 -->
        <tr>
          <th class="thSub2">표면경도</th>
          <td>
            <select id="prod_pg" name="prod_pg">
              <option>HRC</option><option>HV</option><option>HS</option><option>HRA</option><option>HRB</option><option>HB</option><option>HR15N</option><option>HR30N</option><option>HR45N</option>
            </select>
            <input id="prod_pg1" name="prod_pg1" type="text" style="width:60px;"> ~ 
            <input id="prod_pg2" name="prod_pg2" type="text" style="width:60px;">
          </td>

          <th class="thSub2">소입경도</th>
          <td>
            <select id="prod_si" name="prod_si">
              <option>HRC</option><option>HV</option><option>HS</option><option>HRA</option><option>HRB</option><option>HB</option><option>HR15N</option><option>HR30N</option><option>HR45N</option>
            </select>
            <input id="prod_si1" name="prod_si1" type="text" style="width:60px;"> ~ 
            <input id="prod_si2" name="prod_si2" type="text" style="width:60px;">
          </td>
        </tr>

        <tr>
          <th class="thSub2">소려경도</th>
          <td>
            <select id="prod_sr" name="prod_sr">
              <option>HRC</option><option>HV</option><option>HS</option><option>HRA</option><option>HRB</option><option>HB</option><option>HR15N</option><option>HR30N</option><option>HR45N</option>
            </select>
            <input id="prod_sr1" name="prod_sr1" type="text" style="width:60px;"> ~ 
            <input id="prod_sr2" name="prod_sr2" type="text" style="width:60px;">
          </td>

          <th class="thSub2">심부경도</th>
          <td>
            <select id="prod_sg" name="prod_sg">
              <option>HRC</option><option>HV</option><option>HRA</option><option>HRB</option><option>HB</option>
            </select>
            <input id="prod_sg1" name="prod_sg1" type="text" style="width:60px;"> ~ 
            <input id="prod_sg2" name="prod_sg2" type="text" style="width:60px;">
          </td>
        </tr>

        <!-- 경화 깊이 -->
        <tr>
          <th class="thSub2">경화깊이</th>
          <td colspan="3">
            <select id="prod_gd1" name="prod_gd1">
              <option>유효경화</option><option>전경화</option>
            </select>
            <select id="prod_gd3" name="prod_gd3">
              <option>HV</option><option>HRC</option>
            </select>
            <input id="prod_gd2" name="prod_gd2" type="text" style="width:60px;"> 기준,
            <input id="prod_gd4" name="prod_gd4" type="text" style="width:60px;"> ~ 
            <input id="prod_gd5" name="prod_gd5" type="text" style="width:60px;">
          </td>
        </tr>

        <!-- 화합물층, 금속조직, 변형량, 비고 -->
        <tr>
          <th class="thSub2">화합물층 깊이</th>
          <td>
            <select id="prod_whadeep" name="prod_whadeep">
              <option>㎛</option><option>㎜</option>
            </select>
            <input id="prod_e1" name="prod_e1" type="text" style="width:60px;"> ~ 
            <input id="prod_e2" name="prod_e2" type="text" style="width:60px;">
          </td>

          <th class="thSub2">금속조직</th>
          <td><input id="prod_gj" name="prod_gj" type="text" style="width:95%;"></td>
        </tr>

        <tr>
          <th class="thSub2">변형량</th>
          <td><input id="prod_bh" name="prod_bh" type="text" style="width:95%;"></td>
          <th class="thSub2">비고</th>
          <td><textarea id="prod_note" name="prod_note" style="width:95%; height: 50px;"></textarea></td>
        </tr>
      </tbody>
    </table>
  </td>
</tr>
              
              <th rowspan="3">사진</th>
              <td rowspan="3">
                <table class="insideTable" cellspacing="0" cellpadding="0" width="100%">
                  <tbody>
                    <tr>
                      <th class="thSub2">제품</th>
                      <td class="tdRight">
                        <div>
                              <input id="imgInput0" class="imgInputClass valClean" type="file" name="product_file_url" title="이미지 찾기" onchange="rpReadImageURL(this); $(this).parent().find('img').removeClass('rp-file-del');">
                              <!-- <input type="button" value="X" name="product_file_url" onclick="$('#img0').attr('src', '/resources/images/noimage_01.gif'); $('#imgInput0').val('');"> -->
                          <!-- <input type="text" name="product_file_name">  -->
                          <a href="" class="form-control aphoto" download="">다운로드</a>
                        </div>
                        <div class="imgArea" style="width:200px; height:150px; border:1px solid #ddd;">
                          <img id="img0" class="imgClass rp-img-popup" style="width:100%; height:100%;" src="/tkheat/css/image/no_image.png">
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th class="thSub2">외형사진<br>및<br>분석위치</th>
                      <td class="tdRight">
                        <div>
                              <input id="imgInput1" class="imgInputClass valClean" type="file" name="apperance_file_url" title="이미지 찾기">
                              <input type="button" value="X" onclick="$('#img1').attr('src', '/tkheat/css/image/no_image.png'); $('#imgInput1').val('');">
                          <a href="" class="form-control bphoto" download="">다운로드</a>
                          </div>
                        <div class="imgArea" style="width:200px; height:150px; border:1px solid #ddd;">
                          <img id="img1" class="imgClass rp-img-popup" style="width:100%; height:100%;" src="/tkheat/css/image/no_image.png">
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th class="thSub2">열처리공정</th>
                      <td class="tdRight">
                        <div>
                              <input id="imgInput2" class="imgInputClass valClean" type="file" name="heat_file_url" title="이미지 찾기">
                              <input type="button" value="X" onclick="$('#img2').attr('src', '/tkheat/css/image/no_image.png'); $('#imgInput2').val('');">
                          <a href="" class="form-control cphoto" download="">다운로드</a>
                          </div>
                        <div class="imgArea" style="width:200px; height:150px; border:1px solid #ddd;">
                          <img id="img2" class="imgClass rp-img-popup" style="width:100%; height:100%;" src="/tkheat/css/image/no_image.png">
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
                    <script type="text/javascript">
                      $(function(){	
                        // 파일 선택시 이미지 띄우기
                      $('.imgInputClass').change(function(event){
                        var selectedFile = event.target.files[0];
                      var reader = new FileReader();
                      
                      var img = $(this).parent().parent().find('img')[0];
                      img.title = selectedFile.name;
                      
                      reader.onload = function(event) {
                        img.src = event.target.result;
                      };
                      
                      reader.readAsDataURL(selectedFile);
                      });
                    });
                  $("#PROD_DANG").change(function(){
                    $(this).val($(this).val() == '' ? 0 : $(this).val());
                    $(this).val(parseFloat($(this).val()).toFixed(2));
                  });
                    </script>
              </td>
            </tr>
            
            <tr>
              <th>도면파일</th>
              <td>
                <div>
                      <input id="file" class="valClean" type="file" title="파일 찾기">
                  <input type="button" value="X" onclick="$('#fileLink').text('');">
                  </div>
                <div>
                  <a href="" id="fileLink" class="valClean" target="_blank"></a> 
                </div>
              </td>
            </tr>
                                    
                                    <tr>
              <th>공정</th>
              <td>
                <div class="resultArea2">
                  <div class="contentList" style="">							
                    <table>						
                      <thead>
                        <tr>
                          <th scope="col" class="left seq" width="50%">공정명</th>
                          <th scope="col" width="50%">공정순서</th>
                        </tr>
                      </thead>
                      <tbody id="contentListTBody">									
                        <tr>
                          <td class="left seq" width="50%">전세정</td>
                          <td width="50%"><input type="checkbox" id="prod_fac1" name="prod_fac1" class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">방탄</td>
                          <td width="50%"><input type="checkbox" id="prod_fac2" name="prod_fac2" class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">침탄</td>
                          <td width="50%"><input type="checkbox" id="prod_fac3" name="prod_fac3"class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">고주파</td>
                          <td width="50%"><input type="checkbox" id="prod_fac4" name="prod_fac4"class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">후세정</td>
                          <td width="50%"><input type="checkbox" id="prod_fac5" name="prod_fac5"class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">템퍼링</td>
                          <td width="50%"><input type="checkbox" id="prod_fac6" name="prod_fac6"class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">쇼트</td>
                          <td width="50%"><input type="checkbox" id="prod_fac7" name="prod_fac7"class="basic valPost valClean" value=""></td>
                        </tr>	
                        <tr>
                          <td class="left seq" width="50%">후처리</td>
                          <td width="50%"><input type="checkbox" id="prod_fac8" name="prod_fac8"class="basic valPost valClean" value=""></td>
                        </tr>										
                      </tbody>
                    </table>
                  </div>
                </div>
              </td>
            </tr>
                                    
          </tbody></table>
        </td>
      </tr>
    </tbody></table>
	    <div class="btnSaveClose">
	    		<button class="delete" type="button" onclick="deleteProduct();"  style="display: none;">삭제</button>
	            <button class="save" type="button" onclick="save();">저장</button>
	            <button id="btnSaveAs" class="saveAs" type="button" onclick="saveAsNew();" style="display:none;">다른이름저장</button>
	            <button class="close" type="button" onclick="window.close();">닫기</button>
	    </div>
	    </div>
	  </div>
	</div>
</form>
	    
	    
	    
	    <!-- 거래처(검색버튼) 팝업창 -->
	<div id="cutumListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">거래처 리스트</span> <span class="modal-close" onclick="closeCutumListModal()">&times;</span>
			</div>
			<div id="cutumListTabulator" style="height: 500px;"></div>
		</div>
	</div>
    
	    

	    
<script>


$('.imgInputClass').change(function(event){
    var selectedFile = event.target.files[0];
    var reader = new FileReader();
    var img = $(this).parent().parent().find('img')[0];
    img.title = selectedFile.name;

    reader.onload = function(event) {
        img.src = event.target.result; // base64 URI로 넣기 때문에 file:// 아님
    };
    reader.readAsDataURL(selectedFile);
});

	//전역변수
    var productTable;	
    var isEditMode = false; //수정,최초저장 구분값
    
	//로드
	$(function(){
		//전체 거래처목록 조회
		getProductList();
	});

	//이벤트
	//함수
	function getProductList(){
	userTable = new Tabulator("#tab1", {
	    height:"750px",
	    layout:"fitColumns",
	    selectable:true,
	    tooltips:true,
	    selectableRangeMode:"click",
	    reactiveData:true,
	    headerHozAlign:"center",
	    ajaxConfig:"POST",
	    ajaxLoader:false,
	    ajaxURL:"/tkheat/management/productInsert/productList",
	    // ❌ ajaxProgressiveLoad 제거 (스크롤 페이징이 아니라 클라이언트 페이징 사용)
	    // ajaxProgressiveLoad:"scroll",
	    ajaxParams:{"corp_name": $("#corp_name").val(),},
	    placeholder:"조회된 데이터가 없습니다.",

	    // ✅ [추가] Tabulator 기본 페이징 설정
	    pagination:"local",               // 클라이언트 사이드 페이징
	    paginationSize:20,                // 기본 페이지당 표시 개수
	    paginationSizeSelector:[20,50,100,500,1000],  // 사용자가 개수 선택 가능
	    paginationCounter:"rows",         // "rows" = 현재 페이지 범위/전체 행수 표시

	    ajaxResponse:function(url, params, response){
	        $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
	        /* return response; // 데이터 그대로 반환 */
	        return response.data ? response.data : response;
	    },

	    columns:[
	    	{title:"제품", field:"product_file_name", width:70,
				hozAlign:"center", formatter:"image",
			    cssClass:"rp-img-popup",
		      	formatterParams:{
			      	height:"30px", width:"30px",
			      	urlPrefix:"/tkPrint/사진/제품등록/"
			      	}, 
			    cellMouseEnter:function(e, cell){ productImage(cell.getValue());} 
			    },
	        {title:"NO", field:"idx", sorter:"int", width:50, hozAlign:"center"},
	        {title:"코드", field:"prod_code", sorter:"string", width:120, hozAlign:"center", headerFilter:"input", visible:false},	
		    {title:"등록일", field:"prod_date", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},     
			{title:"거래처명", field:"corp_name", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"}, 
			{title:"품명", field:"prod_name", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"}, 
	        {title:"품번", field:"prod_no", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},		        
	        {title:"규격", field:"prod_gyu", sorter:"string", width:100, hozAlign:"center", headerFilter:"input"},
	        {title:"재질", field:"prod_jai", sorter:"string", width:100, hozAlign:"center", headerFilter:"input"},
	        {title:"공정", field:"tech_te", sorter:"string", width:100, hozAlign:"center", headerFilter:"input"},	
	        {title:"단중", field:"prod_danj", sorter:"int", width:70, hozAlign:"center", headerFilter:"input"},  	
	        {title:"단위", field:"prod_danw", sorter:"int", width:70, hozAlign:"center", headerFilter:"input"},	
		    {title:"단가(EA)", field:"prod_dang", sorter:"int", width:100, hozAlign:"center", headerFilter:"input"},	
			{title:"단가(kG)", field:"prod_dang", sorter:"int", width:100, hozAlign:"center", headerFilter:"input"},
			{title:"표면경도", field:"prod_pg", sorter:"int", width:100, hozAlign:"center", headerFilter:"input"},
		    {title:"경화깊이", field:"prod_gd3", sorter:"int", width:100, hozAlign:"center", headerFilter:"input"},
 		    {title:"심부경도", field:"prod_sg", sorter:"int", width:100, hozAlign:"center", headerFilter:"input"},
	    ],

	    rowFormatter:function(row){
		    row.getElement().style.fontWeight = "700";
			row.getElement().style.backgroundColor = "#FFFFFF";
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
		},

		rowDblClick:function(e, row){
			var data = row.getData();
			selectedRowData = data;
			isEditMode = true;
			$('#productInsertForm')[0].reset();
			productInsertDetail(data.prod_code);
			$("#btnSaveAs").show();
			$('.delete').show();
		},
	});		
}

	

	// 상세 조회
	function productInsertDetail(prod_code) {
    $.ajax({
        url: "/tkheat/management/productInsert/productInsertDetail",
        type: "post",
        dataType: "json",
        data: { "prod_code": prod_code },
        success: function (result) {
            console.log("result", result);
            const d = result.data;

            // 폼 초기화
            $('#productInsertForm')[0].reset();

            // 기본 데이터 바인딩
           for (let key in d) {
			    if (key === "prod_date") {
			        $("[name='" + key + "']").val(d[key].substring(0, 10));
			    } else if (key.startsWith("prod_fac")) {
			        const checkbox = $("#" + key);
			        if (checkbox.length) {
			            const val = d[key] || "";
			            checkbox.prop("checked", val.includes("1"));
			        }
			    } else {
			        $("[name='" + key + "']").val(d[key]);
			        
			    }
			}
            // 이미지 초기화
            $("#img0, #img1, #img2").attr("src", "/tkheat/css/image/no_image.png");
            $(".aphoto, .bphoto, .cphoto").attr("href", "").text("");

            // 제품 사진
            if (d.product_file_name) {
                const path = "/tkPrint/사진/제품등록/" + d.product_file_name;
                $("#img0").attr("src", path);
                $(".aphoto").attr("href", path).text(d.product_file_name);
            }

            // 외형 사진
            if (d.apperance_file_name) {
                const path = "/tkPrint/사진/제품등록/" + d.apperance_file_name;
                $("#img1").attr("src", path);
                $(".bphoto").attr("href", path).text(d.apperance_file_name);
            }

            // 열처리 사진
            if (d.heat_file_name) {
                const path = "/tkPrint/사진/제품등록/" + d.heat_file_name;
                $("#img2").attr("src", path);
                $(".cphoto").attr("href", path).text(d.heat_file_name);
            }

            // 모달 열기
            $('.productModal').show().addClass('show');
        },
        error: function (xhr, status, error) {
            console.error("제품 상세 조회 오류:", error);
        }
    });
}

</script>
    
    
    <script>
		
 // 드래그 기능 추가
	const modal = document.querySelector('.productModal');
	const header = document.querySelector('.header'); // 헤더를 드래그할 요소로 사용

	header.addEventListener('mousedown', function(e) {
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

		

	// 모달 열기
	const insertButton = document.querySelector('.insert-button');
	const productModal = document.querySelector('.productModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');

	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#productInsertForm')[0].reset(); // 폼 초기화

		// 이미지 초기화
		$("#img0, #img1, #img2").attr("src", "/tkheat/css/image/no_image.png");
		$(".aphoto, .bphoto, .cphoto").attr("href", "").text("");
		
	    productModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
		$("#btnSaveAs").hide();
	});

	closeButton.addEventListener('click', function() {
		productModal.style.display = 'none'; // 모달 숨김
	});

	headerCloseButton.addEventListener('click', function() {
		productModal.style.display = 'none';
	});


	//설비검색버튼 리스트 모달
    function openCutumModal() {
        document.getElementById('cutumListModal').style.display = 'flex';

        
        let cutumListTable = new Tabulator("#cutumListTabulator", {
            height:"450px",
            layout:"fitColumns",
            selectable:true,
            ajaxURL:"/tkheat/management/cutumInsert/cutumInsertList",
            ajaxConfig:"POST",
            ajaxParams:{
            	"corp_name": "",
                "corp_plc": "",
                "corp_gubn": "",
                "corp_mast": "",
                "corp_code": "",   
            },
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				console.log(response);
		        return response.data; //return the response data to tabulator
		    },    
            columns:[
            	{title:"구분ID", field:"corp_gubn", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"거래처명", field:"corp_name", sorter:"string", width:150,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"사업자번호", field:"corp_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"거래처코드", field:"corp_code", width:120, hozAlign:"center",visible:false},	
            ],
            rowDblClick:function(e, row){
                let data = row.getData();
                
               
                document.getElementById('corp_name').value = data.corp_name;
                document.getElementById('corp_code').value = data.corp_code;
                
                document.getElementById('cutumListModal').style.display = 'none';
            }
        });
    }

    function closeCutumListModal() {
        document.getElementById('cutumListModal').style.display = 'none';
    }


  //제품등록 저장
   function save() {
    // 체크박스 처리: 체크 안된 것도 'N'으로 강제로 값 지정
    const checkboxFields = ["prod_fac1", "prod_fac2", "prod_fac3", "prod_fac4", "prod_fac5", "prod_fac6", "prod_fac7", "prod_fac8"];
    checkboxFields.forEach(field => {
        const checked = $("#" + field).is(":checked");
        // 존재하는 hidden input이 있으면 set, 없으면 추가
        if ($("#hidden_" + field).length === 0) {
            $("<input>").attr({
                type: "hidden",
                id: "hidden_" + field,
                name: field,
                value: checked ? "1" : "0"
            }).appendTo("#productInsertForm");
        } else {
            $("#hidden_" + field).val(checked ? "1" : "0");
        }
    });

    var formData = new FormData($("#productInsertForm")[0]);

    let confirmMsg = "";
    if (isEditMode && selectedRowData && selectedRowData.prod_code) {
        formData.append("mode", "update");
        formData.append("prod_code", selectedRowData.prod_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
    }

    if (!confirm(confirmMsg)) {
        return;
    }

    $.ajax({
        url: "/tkheat/management/productInsert/productInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function (result) {
            console.log(result);
            alert("저장 되었습니다.");
            $(".productModal").hide();
            getProductList();
        },
        error: function (xhr, status, error) {
            console.error("저장 오류:", error);
        }
    });
}

   function saveAsNew() {
	    const checkboxFields = ["prod_fac1", "prod_fac2", "prod_fac3", "prod_fac4", "prod_fac5", "prod_fac6", "prod_fac7", "prod_fac8"];
	    checkboxFields.forEach(field => {
	        const checked = $("#" + field).is(":checked");
	        if ($("#hidden_" + field).length === 0) {
	            $("<input>").attr({
	                type: "hidden",
	                id: "hidden_" + field,
	                name: field,
	                value: checked ? "1" : "0"
	            }).appendTo("#productInsertForm");
	        } else {
	            $("#hidden_" + field).val(checked ? "1" : "0");
	        }
	    });

	    var formData = new FormData($("#productInsertForm")[0]);

	    formData.append("mode", "insert");
	    formData.delete("prod_code");

	    if (!confirm("현재 데이터를 바탕으로 새 제품을 등록하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/productInsert/productInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function (result) {
	            console.log(result);
	            alert("새로운 제품으로 저장되었습니다.");
	            $(".productModal").hide();
	            getProductList();
	        },
	        error: function (xhr, status, error) {
	            console.error("다른이름으로 저장 오류:", error);
	            alert("저장 중 오류가 발생했습니다.");
	        }
	    });
	}
	
    function deleteProduct() {
	    if (!selectedRowData || !selectedRowData.prod_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/productInsert/productDelete",
	        type: "POST",
	        data: {
	        	prod_code: selectedRowData.prod_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".productModal").hide();
	                getProductList();
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
    //엑셀 다운로드
	$(".excel-button").click(function () {
	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "제품등록_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "제품등록" });
	});



	
	

    </script>

	</body>
</html>
