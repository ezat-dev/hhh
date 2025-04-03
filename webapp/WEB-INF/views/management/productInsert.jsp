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
<%@include file="../include/pluginpage.jsp" %> 
    <style>
    
.main{
	width:98%;
}
.container {
	display: flex;
	justify-content: space-between;
}
.detail {
    background: #ffffff;
    border: 1px solid #000000;
    width: 1200px; /* 가로 길이 고정 */
    height: 720px; /* 세로 길이 고정 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
    margin: 20px auto; /* 중앙 정렬 */
    padding: 20px;
    border-radius: 5px; /* 모서리 둥글게 */
    overflow-y: auto; /* 세로 스크롤 추가 */
    position: relative; /* 자식 요소의 절대 위치 설정을 위한 기준 */
}

.insideTable {
    width: 100%; /* 내부 테이블 너비 100% */
    border-collapse: collapse;
}

.insideTable th,
.insideTable td {
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

.btnSearchCorp,
.btn1T {
    background: #007bff; /* 버튼 배경색 */
    color: white; /* 버튼 글자색 */
    border: none; /* 경계선 없음 */
    padding: 5px 10px; /* 내부 여백 */
    cursor: pointer; /* 커서 변경 */
    border-radius: 3px; /* 모서리 둥글게 */
    margin-top: 5px; /* 위쪽 여백 */
}

.btnSearchCorp:hover,
.btn1T:hover {
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
    width: 150px; /* 서브 헤더 너비 */
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

.productModal {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 수직 중앙 */
    left: 50%; /* 수평 중앙 */
    display : none;
    transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
    z-index: 1000; /* 다른 요소 위에 표시 */
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
    </style>
    
    
    <body>
    
    <div class="tab">
    
    <div class="button-container">
        <button class="select-button">
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


<form method="post" id="productForm" name="productForm">	    
<div class="productModal">    
 <div class="detail">
 <div class="header">
 	제품등록
 </div>
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
              <td><input id="PROD_DATE" name="prod_date" class="date valPost valClean hasDatepicker" type="date" style="width:100px;" maxlength="20" size="20"></td>
              <th>구분</th>
              <td>
                <select id="PROD_GUBN" name="prod_gubn" class="basic valPost valClean" style="width:150px;">										
                  <option>양산</option>
                  <option>개발</option>
                </select>
              </td>
            </tr>
            <tr>
              <th class="left">거래처</th>
              <td>
                  <input id="CORP_NAME" name="corp_name"class="basic valClean" type="text" style="width:60%;" value="다산테크" readonly="">
                  <input id="CORP_CODE" name="corp_code" class="basic valPost valClean" type="hidden" style="width:50%;" value="" readonly="">
                <input class="btnSearchCorp" name="" type="button" title="거래처선택" value="검색">
              </td>
              <th>관리번호</th>
              <td><input id="PROD_CNO" name="prod_cno" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>
            <tr>
              <th class="left">품명</th>
              <td>
                <input id="PROD_NAME" name="prod_name" class="basic valPost valClean" type="text" style="width:90%;" value="">
                <input id="PROD_CODE" name="prod_code" class="basic valPost valClean" type="hidden" value="">
              </td>
              <th><span class="left">품번</span></th>
              <td><input id="PROD_NO" name="prod_no" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>
            <tr>
              <th class="left">모델명</th>
              <td><input id="PROD_MODEL" name="prod_model" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
              <th><span class="left">재질</span></th>
              <td><input id="PROD_JAI" name="prod_jai" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>									
            <tr>
              <th class="left">규격</th>
              <td>
                <input id="PROD_GYU" name="prod_gyu" class="basic valPost valClean" type="text" style="width:200px;" value="">
                <input type="button" value="Φ" class="btn1T" onclick="$('#PROD_GYU').val($('#PROD_GYU').val()+'Φ');">
                <input type="button" value="X" class="btn1T" onclick="$('#PROD_GYU').val($('#PROD_GYU').val()+'X');">
                <input type="button" value="L" class="btn1T" onclick="$('#PROD_GYU').val($('#PROD_GYU').val()+'L');">
              </td>
              <th><span class="left">단중(kg)</span></th>
              <td><input id="PROD_DANJ" name="prod_danj" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>
            <tr>
              <th class="left">단가</th>
              <td><input id="PROD_DANG" name="prod_dang" class="basic valPost valClean" type="text" style="width:90%;" value="0"></td>
              <th class="left">단위</th>
              <td>
                <select id="PROD_DANW" name="prod_dawn" class="basic valPost valClean" style="width:150px;">
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
                  <td><input id="PROD_CHISU1N" name="prod_chisu1n" class="basic valPost valClean" type="text" value="">-<input id="PROD_CHISU1S" class="basic valPost valClean" type="text" value=""></td>
                    </tr>
                    <tr>
                  <th>치수2</th>
                  <td><input id="PROD_CHISU2N" name="prod_chisu2n" class="basic valPost valClean" type="text" value="">-<input id="PROD_CHISU2S" class="basic valPost valClean" type="text" value=""></td>
                    </tr>
                    <tr>
                  <th>치수3</th>
                  <td><input id="PROD_CHISU3N" name="prod_chisu3n" class="basic valPost valClean" type="text" value="">-<input id="PROD_CHISU3S" class="basic valPost valClean" type="text" value=""></td>
                    </tr>
                    <tr>
                  <th>치수4</th>
                  <td><input id="PROD_CHISU4N" name="prod_chisu4n" class="basic valPost valClean" type="text" value="">-<input id="PROD_CHISU4S" class="basic valPost valClean" type="text" value=""></td>
                    </tr>
                    <tr>
                  <th>치수5</th>
                  <td><input id="PROD_CHISU5N" name="prod_chisu5n" class="basic valPost valClean" type="text" value="">-<input id="PROD_CHISU5S" class="basic valPost valClean" type="text" value=""></td>
                    </tr>
                </tbody></table>
              </td>
            </tr>
            <tr>
              <th class="left">연마여유(mm)</th>
              <td style="vertical-align: top;">
                <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                  <tbody><tr><td><input id="PROD_POLISH" name="prod_polish" class="basic valPost valClean" type="text" style="width:90%;" value="0"></td>
                </tr></tbody></table>
              </td>
              <th><span class="left">박스당수량</span></th>
              <td><input id="PROD_BOXSU" name="prod_boxsu" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
            </tr>
            <tr>
              <th><span class="left">공정</span></th>
              <td>
                <select id="TECH_NO" name="tech_no" class="basic valPost valClean">
                  
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
              <td><input id="TECH_SEQ" name="tech_seq" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
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
              <td><input id="TECH_PATTERN" name="tect_pattern" class="basic valPost valClean" type="number" value=""></td>
              <th>포장방법</th>
              <td><input id="PROD_DANCH" name="prod_danch" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>	
            </tr>
            <tr>
              <th class="left">BOX TYPE</th>
              <td>
                <select id="PROD_BOX" name="prod_box" class="basic valPost valClean" style="width:150px;">
                  <option>A</option>
                  <option>B</option>
                </select>
              </td>
              <th class="left">열처리곡선</th>
              <td>
                <select id="PROD_SNP" name="prod_snp" class="basic valPost valClean" type="text" style="width:150px;" value="">
                  <option>불요</option>
                  <option>필요</option>
                </select>
              </td>
            </tr>
            <tr>
              <th class="left">방청유</th>
              <td>
                <select id="PROD_BANGCH" name="prod_bangch" class="basic valPost valClean" style="width:150px;">
                  <option>필요없음</option>
                  <option>수용성</option>
                  <option>유용성</option>
                  <option>기타</option>
                </select>
              </td>
              <th class="left">후처리</th>
              <td>
                <select id="PROD_VNYL" name="prod_vnyl" class="basic valPost valClean" style="width:150px;">
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
                <select id="PROD_PAD" name="prod_pad" class="basic valPost valClean" style="width:150px;">
                  <option>본품</option>
                  <option>대체시편</option>
                  <option>시편절단(본품절단)</option>
                  <option>시편필요없음</option>
                </select>
              </td>
              <th class="left">제품실재고 현황</th>
              <td>
                <input id="PROD_REALJAI" name="prod_realjai" class="basic valPost valClean" type="text" style="width:90%;" value="">
              </td>
            </tr>	
            <tr>
            <th class="left">업종</th>
              <td>
                <select id="PROD_UPJONG" name="prod_upjong" class="basic valPost valClean" style="width:150px;">
                  <option>자동차</option>
                  <option>선박</option>
                  <option>유압</option>
                  <option>방산</option>
                  <option>기타</option>
                </select>
              </td>
            <th class="left">성적서</th>
              <td>
                <select id="PROD_PLT" name="prod_prod_plt" class="basic valPost valClean" style="width:150px;">
                  <option>필요</option>
                  <option>불필요</option>
                </select>
              </td>
            </tr>									
            <tr>
              <th class="left">SPEC</th>
              <td style="vertical-align: top;">
                <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                  <tbody><tr>
                    <th class="thSub2">표면경도</th>
                    <th class="thSub">
                      <select id="PROD_PG" name="prod_pg" class="basic valPost valClean">
                        <option>HRC</option>
                        <option>HV</option>
                        <option>HS</option>
                        <option>HRA</option>
                        <option>HRB</option>
                        <option>HB</option>
                        <option>HR15N</option>
                        <option>HR30N</option>
                        <option>HR45N</option>
                      </select>
                    </th>
                    <td class="tdRight">
                      <input id="PROD_PG1" name="prod_pg1" class="basic valPost valClean" type="text" style="width:70px;" value=""> 
                      ~ <input id="PROD_PG2" name="prod_pg2" class="basic valPost valClean" type="text" style="width:70px;" value="">
                    </td>
                  </tr>												
                  <tr>
                    <th class="thSub2">소입경도</th>
                    <th class="thSub">
                      <select id="PROD_SI" name="prod_si" class="basic valPost valClean">
                        <option>HRC</option>
                        <option>HV</option>
                        <option>HS</option>
                        <option>HRA</option>
                        <option>HRB</option>
                        <option>HB</option>
                        <option>HR15N</option>
                        <option>HR30N</option>
                        <option>HR45N</option>
                      </select>
                    </th>
                    <td class="tdRight">
                      <input id="PROD_SI1" name="prod_si1" class="basic valPost valClean" type="text" style="width:70px;" value="">
                      ~ <input id="PROD_SI2" name="prod_si2" class="basic valPost valClean" type="text" style="width:70px;" value="">
                    </td>
                  </tr>
                  <tr>
                    <th class="thSub2">소려경도</th>
                    <th class="thSub">
                      <select id="PROD_SR" name="prod_sr" class="basic valPost valClean">
                        <option>HRC</option>
                        <option>HV</option>
                        <option>HS</option>
                        <option>HRA</option>
                        <option>HRB</option>
                        <option>HB</option>
                        <option>HR15N</option>
                        <option>HR30N</option>
                        <option>HR45N</option>
                      </select>
                    </th>
                    <td class="tdRight">
                      <input id="PROD_SR1" name="prod_sr1" class="basic valPost valClean" type="text" style="width:70px;" value="">
                      ~ <input id="PROD_SR2" name="prod_sr2" class="basic valPost valClean" type="text" style="width:70px;" value="">
                    </td>
                  </tr>
                  <tr>
                    <th class="thSub2">심부경도</th>
                    <th class="thSub">
                      <select id="PROD_SG" name="prod_sg" class="basic valPost valClean">
                        <option>HRC</option>
                        <option>HV</option>
                        <option>HRA</option>
                        <option>HRB</option>
                        <option>HB</option>
                      </select>
                    </th>
                    <td class="tdRight">
                      <input id="PROD_SG1" name="prod_sg1" class="basic valPost valClean" type="text" style="width:70px;" value=""> 
                      ~ <input id="PROD_SG2" name="prod_sg2" class="basic valPost valClean" type="text" style="width:70px;" value="">
                    </td>
                  </tr>
                  <tr>
                    <th rowspan="2" class="thSub2">경화깊이</th>
                    <th class="thSub">
                      <select id="PROD_GD1" name="prod_gd1" class="basic valPost valClean">
                        <option>유효경화</option>
                        <option>전경화</option>
                      </select>
                    </th>
                    <td class="tdRight">
                       <select id="PROD_GD3" name="prod_gd3"  class="basic valPost valClean">
                        <option>HV</option>
                        <option>HRC</option>
                      </select>
                      <input id="PROD_GD2" name="prod_gd2" class="basic valPost valClean" type="text" style="width:70px;" value=""> 
                      기준
                    </td>
                  </tr>
                  <tr>
                    <th class="thSub">
                    </th>
                    <td class="tdRight">
                      <input id="PROD_GD4" name="prod_gd4" class="basic valPost valClean" type="text" style="width:70px;" value=""> 
                      ~ <input id="PROD_GD5" name="prod_gd5" class="basic valPost valClean" type="text" style="width:70px;" value="">
                    </td>
                  </tr>
                  <tr>
                    <th class="thSub2">화합물층 깊이</th>
                    <th class="thSub">
                      <select id="PROD_WHADEEP" name="prod_whadeep" class="basic valPost valClean">
                        <option>㎛</option>
                        <option>㎜</option>
                      </select>
                    </th>
                    <td class="tdRight">
                      <input id="PROD_E1" name="prod_e1" class="basic valPost valClean" type="text" style="width:70px;" value=""> 
                      ~ <input id="PROD_E2" name="prod_e2" class="basic valPost valClean" type="text" style="width:70px;" value="">
                    </td>
                  </tr>
                  <tr>
                  </tr><tr>
                  <th>금속조직</th>
                  <td><input id="PROD_GJ" name="prod_gj" class="basic valPost valClean" type="text" value=""></td>
                    </tr>
                    <tr>
                  <th>변형량</th>
                  <td><input id="PROD_BH" name="prod_bh" class="basic valPost valClean" type="text" value=""></td>
                    </tr>
                  <tr>
                    <th>비고</th>
                    <td colspan="3">
                      <textarea id="PROD_NOTE" name="prod_note" class="basic valPost valClean" style="width:90%;"></textarea>
                    </td>
                  </tr>																								
                </tbody></table>
              </td>
              
              <th rowspan="3">사진</th>
              <td rowspan="3">
                <table class="insideTable" cellspacing="0" cellpadding="0" width="100%">
                  <tbody>
                    <tr>
                      <th class="thSub2">제품</th>
                      <td class="tdRight">
                        <div>
                              <input id="imgInput0" class="imgInputClass valClean" type="file" title="이미지 찾기">
                              <input type="button" value="X" onclick="$('#img0').attr('src', '/resources/images/noimage_01.gif'); $('#imgInput0').val('');">
                          <a href="" class="form-control aphoto" download="">다운로드</a>
                        </div>
                        <div class="imgArea" style="width:200px; height:150px; border:1px solid #ddd;">
                          <img id="img0" class="imgClass rp-img-popup" style="width:100%; height:100%;" src="/resources/images/noimage_01.gif">
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th class="thSub2">외형사진<br>및<br>분석위치</th>
                      <td class="tdRight">
                        <div>
                              <input id="imgInput1" class="imgInputClass valClean" type="file" title="이미지 찾기">
                              <input type="button" value="X" onclick="$('#img1').attr('src', '/resources/images/noimage_01.gif'); $('#imgInput1').val('');">
                          <a href="" class="form-control bphoto" download="">다운로드</a>
                          </div>
                        <div class="imgArea" style="width:200px; height:150px; border:1px solid #ddd;">
                          <img id="img1" class="imgClass rp-img-popup" style="width:100%; height:100%;" src="/resources/images/noimage_01.gif">
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th class="thSub2">열처리공정</th>
                      <td class="tdRight">
                        <div>
                              <input id="imgInput2" class="imgInputClass valClean" type="file" title="이미지 찾기">
                              <input type="button" value="X" onclick="$('#img2').attr('src', '/resources/images/noimage_01.gif'); $('#imgInput2').val('');">
                          <a href="" class="form-control cphoto" download="">다운로드</a>
                          </div>
                        <div class="imgArea" style="width:200px; height:150px; border:1px solid #ddd;">
                          <img id="img2" class="imgClass rp-img-popup" style="width:100%; height:100%;" src="/resources/images/noimage_01.gif">
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
              <th>첨부파일</th>
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
                          <td width="50%"><input type="checkbox" id="PROD_FAC1" name="prod_fac1" class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">방탄</td>
                          <td width="50%"><input type="checkbox" id="PROD_FAC2" name="prod_fac2" class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">침탄</td>
                          <td width="50%"><input type="checkbox" id="PROD_FAC3" name="prod_fac3"class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">고주파</td>
                          <td width="50%"><input type="checkbox" id="PROD_FAC4" name="prod_fac4"class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">후세정</td>
                          <td width="50%"><input type="checkbox" id="PROD_FAC5" name="prod_fac5"class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">템퍼링</td>
                          <td width="50%"><input type="checkbox" id="PROD_FAC6" name="prod_fac6"class="basic valPost valClean" value=""></td>
                        </tr>
                        <tr>
                          <td class="left seq" width="50%">쇼트</td>
                          <td width="50%"><input type="checkbox" id="PROD_FAC7" name="prod_fac7"class="basic valPost valClean" value=""></td>
                        </tr>	
                        <tr>
                          <td class="left seq" width="50%">후처리</td>
                          <td width="50%"><input type="checkbox" id="PROD_FAC8" name="prod_fac8"class="basic valPost valClean" value=""></td>
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
	            <button class="save" type="button" onclick="save();">저장</button>
	            <button class="close" type="button" onclick="window.close();">닫기</button>
	    </div>
	  </div>
	</div>
</form>
	    
    
	    

	    
<script>
	//전역변수
    var productTable;	

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
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/management/productInsert/productList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{},
     	    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"코드", field:"prod_code", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"등록일", field:"prod_date", sorter:"string", width:120,
				    hozAlign:"center"},     
				{title:"거래처명", field:"corp_name", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"품명", field:"prod_name", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"품번", field:"prod_no", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"재질", field:"prod_jai", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"공정", field:"tech_no", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"단중", field:"prod_danj", sorter:"int", width:100,
		        	hozAlign:"center"},  	
		        {title:"단위", field:"prod_danw", sorter:"int", width:100,
			        hozAlign:"center"},	
			    {title:"단가(EA)", field:"prod_dang", sorter:"int", width:100,
				    hozAlign:"center"},	
				{title:"단가(kG)", field:"prod_dang", sorter:"int", width:100,
				    hozAlign:"center"},
				{title:"표면경도", field:"prod_pg", sorter:"int", width:100,
					hozAlign:"center"},
			    {title:"경화깊이", field:"prod_gd3", sorter:"int", width:100,
					hozAlign:"center"},
 			    {title:"심부경도", field:"prod_sg", sorter:"int", width:100,
					hozAlign:"center"},
				    
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
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

				var rowData = row.getData();
				
			},
		});		
	}



	function save(){
	
		var productData = new FormData($("#productForm")[0]);

	console.log($("#productForm")[0]);
		
		$.ajax({
			url:"/tkheat/management/productInsert/productInsertSave",
			type:"post",
			contentType: false,
			processData: false,
			dataType: "json",
			data:productData,
			success:function(result){
				alert("제품이 등록되었습니다.");
				 getProductList();
			}
		});	

/*
		$.ajax({
			url:"/tkheat/management/productInsert/productInsertSave",
			type:"post",
			dataType:"json",
			data:{
				"test":"test"
			},
			success:function(result){
				console.log(result);
			}
		})
*/
	}














	
	
    </script>
    
    
    <script>
		
 // 드래그 기능 추가
	const modal = document.querySelector('.productModal');
	const header = document.querySelector('.header'); // 헤더를 드래그할 요소로 사용

	header.addEventListener('mousedown', function(e) {
	    let offsetX = e.clientX - modal.getBoundingClientRect().left; // 마우스와 모달의 x 위치 차이
	    let offsetY = e.clientY - modal.getBoundingClientRect().top; // 마우스와 모달의 y 위치 차이

	    function moveModal(e) {
	        modal.style.left = (e.clientX - offsetX) + 'px';
	        modal.style.top = (e.clientY - offsetY) + 'px';
	    }

	    function stopMove() {
	        window.removeEventListener('mousemove', moveModal); // 이동 중지
	        window.removeEventListener('mouseup', stopMove); // 마우스 업 이벤트 제거
	    }

	    window.addEventListener('mousemove', moveModal); // 마우스 이동 이벤트
	    window.addEventListener('mouseup', stopMove); // 마우스 업 이벤트
	});
		

	// 모달 열기
	const insertButton = document.querySelector('.insert-button');
	const productModal = document.querySelector('.productModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		productModal.style.display = 'block'; // 모달 표시
	});

	closeButton.addEventListener('click', function() {
		productModal.style.display = 'none'; // 모달 숨김
	});



    </script>

	</body>
</html>
