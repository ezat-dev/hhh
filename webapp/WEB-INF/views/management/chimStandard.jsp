<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>침탄로작업표준</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>     
    
    <style>
    
	.container {
		display: flex;
		justify-content: space-between;
/*		margin-left:1008px;
		margin-top:200px;*/
	}

.chimStandardModal {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 수직 중앙 */
    left: 55%; /* 수평 중앙 */
    display : none;
    transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
    z-index: 1000; /* 다른 요소 위에 표시 */
}
#editPop {
    background: #ffffff;
    border: 1px solid #000000;
    width: 1300px; /* 가로 길이 고정 */
    height: 720px; /* 세로 길이 고정 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
    margin: 20px auto; /* 중앙 정렬 */
    padding: 20px;
    border-radius: 5px; /* 모서리 둥글게 */
    overflow-y: auto; /* 세로 스크롤 추가 */
}

.popField {
    margin-bottom: 20px; /* 각 필드셋 간의 여백 */
    border: 1px solid #ccc; /* 테두리 */
    border-radius: 5px; /* 둥근 모서리 */
    padding: 10px; /* 내부 여백 */
}

.popField legend {
    font-weight: bold; /* 굵은 글씨 */
    padding: 0 10px; /* 레전드 패딩 */
}

.popFieldTable, .popFieldTable2, .popFieldTable3 {
    width: 100%; /* 테이블 너비 100% */
    border-collapse: collapse; /* 테두리 겹침 제거 */
}

.popFieldTable th,
.popFieldTable td,
.popFieldTable2 th,
.popFieldTable2 td,
.popFieldTable3 th,
.popFieldTable3 td {
    padding: 5px; /* 셀 패딩 */
    border: 1px solid #ccc; /* 셀 경계선 */
}

.basic {
    background: #ffffff;
    border: 1px solid #949494; /* 경계선 색상 */
    width: calc(100% - 10px); /* 기본 너비 100%에서 여백 제외 */
    padding: 5px; /* 내부 여백 */
    box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1); /* 내부 그림자 */
    border-radius: 3px; /* 둥근 모서리 */
}

.basic[readonly] {
    background-color: #f9f9f9; /* 읽기 전용 필드 색상 */
}

.imgArea {
    width: 100%; /* 이미지 영역 너비 */
    height: 90px; /* 이미지 영역 높이 */
    border: 1px solid #ddd; /* 경계선 */
    
    margin-bottom: 10px; /* 하단 여백 */
}

.imgArea img {
    width: 100%; /* 이미지 너비 */
    height: 100%; /* 이미지 높이 */
    object-fit: cover; /* 이미지 비율 유지 */
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
    
body{
	font-size : 15px;
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
	    
   <div class="chimStandardModal">    
	<form name="searchForm" method="post" enctype="multipart/form-data">
      <div id="editPop">
       <div class="header">
       			침탄로표준등록
       </div>
        <fieldset class="popField">
          <legend>제품정보</legend>
          <fieldset class="popField">
              <legend>제품사진</legend>
              <div class="findImage">
                <input type="hidden" name="type" value="standard">
                
                
                <div class="imgArea" id="previewId7" style="height:90px;border:1px solid #ddd;">
                  <img class="rp-img-popup" id="prev_previewId7" src="/images/prod/P.jpg" width="30%" height="100%">
                </div>
              </div>
            </fieldset><table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
          <colgroup span="8">
            <col width="7%">
            <col width="18%">
            <col width="7%">
            <col width="18%">
            <col width="7%">
            <col width="18%">
            <col width="7%">
            <col width="18%">
          </colgroup>
            
          <tbody><tr>
            <th class="left">고객명<input id="prodCode" name="prod_code" type="hidden" value=""></th>
            <td class=""><input id="corpName" name="corp_name" class="basic" type="text" style="width:70%;" value="" readonly="">
            <input class="" type="button" title="제품선택" onclick="MM_openBrWindow('etcSub_popup_06_1','Srch','width=1024,height=720,scrollbars=yes')"></td>
            <th class="">단중(g)</th>
            <td class=""><input id="prodDanj" name="prod_danj" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">도번/품번</th>
            <td class=""><input id="prodNo" name="prod_no" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">품명</th>
            <td class=""><input id="prodName" name="prod_name" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
          </tr>
          <tr>
            <th class="left">재질</th>
            <td class=""><input id="prodJai" name="prod_jai" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">단가</th>
            <td class=""><input id="prodDang" name="prod_dang" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">주문번호</th>
            <td class=""><input id="prodCno" name="prodC_cno" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="">PWS No.</th>
            <td class=""><input id="prodPwsno" name="prod_pwsno" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
          </tr>
          <tr>
            <th class="">공정</th>
            <td class=""><input id="techTe" name="tech_te" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="left">도면/공정도</th>
            <td class=""><input id="prodDo" name="prod_do" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="left">Ref No.</th>
            <td class=""><input id="prodRefno" name="prod_refno" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <th class="left">검사규격</th>
            <td class=""><input id="prodGyu" name="prod_gyu" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
          </tr>
          <tr>
            <!-- <th class="">ECD</th>
            <td class=""><input id="prodE5" name="prodE5" class="basic" type="text" style="width:100%;" value="" readonly /></td>
            <th class="left">Ra%</th>
            <td class=""><input id="prodRa" name="prodRa" class="basic" type="text" style="width:100%;" value="" readonly/></td> -->
            <th class="left">기종</th>
            <td class=""><input id="prodKijong" name="prod_kijong" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
            <td class=""><input id="prodAppear" name="prod_appear" class="basic" type="hidden" style="width:90%;" value="" readonly=""></td>
            <td class=""><input id="prodTransform" name="prod_transform" class="basic" type="hidden" style="width:90%;" value="" readonly=""></td>
            <th class="left" hidden="">기종</th>
            <td class="" hidden="">&gt;<input id="prodCd" name="prod_cd" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
          </tr>
        </tbody></table>
        </fieldset>

        <table cellspacing="0" cellpadding="0" width="100%" class="">
        <colgroup span="2">
          <col width="70%">
          <col width="30%">
        </colgroup>
        <tbody><tr>
          <td class="" valign="top">
            <div class="">
              <fieldset class="popField">
              <legend>요구규격</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="5">
                    <col width="3%">
                    <col width="5%">
                    <col width="3%">
                    <col width="5%">
                    <col width="3%">
                    <col width="5%">
                    <col width="2%">
                    <col width="5%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">표면경도</th>
                    <td class=""><input id="prodPg" name="prod_pg" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <th class="">심부경도</th>
                    <td class=""><input id="prodSg" name="prod_sg" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <th class="">금속조직</th>
                    <td class=""><input id="prodE1" name="prod_e1" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <th class="">변형량</th>
                    <td class=""><input id="prodE3" name="prod_e3" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                  </tr>
                  <tr>
                    <th class="" hidden="">표면경도 비고</th>
                    <td class="" hidden=""><input id="prodPg3" name="prod_pg3" class="basic" type="text" style="width:90%; display:none;" value="" readonly=""></td>
                    <th class="" hidden="">심부경도 비고</th>
                    <td class="" hidden=""><input id="prodSg3" name="prod_sg3" class="basic" type="text" style="width:90%; display:none;" value="" readonly=""></td>
                    <!-- <th class="">표면경도 (실측치)</th>
                    <td class=""><input id="prodPgs" name="prodPgs" class="basic" type="text" style="width:100%;" value="" readonly/></td> -->
                    <th class="">경화거리(ECD)</th>
                    <td class=""><input id="ProdKhEcd" name="Prod_khecd" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <th class="">경화거리(TCD)</th>
                    <td class=""><input id="ProdKhTcd" name="Prod_khtcd" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                  </tr>
                    <tr>
                    <th class="">경화깊이</th>
                    <td class=""><input id="prodGD1" name="prod_gd1" class="basic" type="text" style="width:90%;" value="" readonly=""></td><td class="" align="center">기준</td><td class=""><input id="prodGD2" name="prod_gd2" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    <td class="" align="center">~</td><td class=""><input id="prodGD5" name="prod_gd5" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                    </tr>
                    <tr>
                    <input id="ProdCd" name="Prod_cd" class="basic" type="hidden" value="" readonly="">
                    <input id="prodE5" name="prod_e5" class="basic" type="hidden" value="" readonly="">
                    <input id="prodRa" name="prod_ra" class="basic" type="hidden" value="" readonly="">
                    <input id="prodPgs" name="prod_pgs" class="basic" type="hidden" value="" readonly="">
                    </tr>
                </tbody></table>
              </fieldset>
            </div>

            <div class="" hidden="">
              <fieldset class="popField">
                <legend>침탄경화깊이</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="5">
                    <col width="1%">
                    <col width="8%">
                    <col width="1%">
                    <col width="8%">
                    <col width="1%">
                    <col width="8%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">0.28mm</th>
                    <td class=""><input id="prodGd1" name="prod_gd1" class="basic" type="text" style="width:100%;" value="" readonly=""></td>
                    <th class="">0.68mm</th>
                    <td class=""><input id="prodGd2" name="prod_gd2" class="basic" type="text" style="width:100%;" value="" readonly=""></td>
                    <th class="">1.18mm</th>
                    <td class=""><input id="prodGd3" name="prod_gd3" class="basic" type="text" style="width:100%;" value="" readonly=""></td>
                  </tr>
                </tbody></table>
              </fieldset>
            </div>


            <div class="">
              <fieldset class="popField">
                <legend>전세척</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <tbody><tr>
                  <td class=""><select id="facCode1" name="fac_code1" class="basic" style="width: 100%">
                        
                          <option value="15">진공세정기 2호기</option>
                        
                          </select>
                  <!-- <td class=""  hidden=""><select id="wstdStep07" name="wstdStep07"class="basic" style="width:145px;">
                          <option></option>
                          <option>STEP1</option>
                          <option>STEP2</option>
                          <option>STEP3</option>
                         </select> -->
                    </td><th class="" style="width:5%;">온도</th>
                    <td class=""><input id="wstdN01" name="wstd_n01" class="basic" type="text" style="width:80%;" value=""></td>
                    <th class="" style="width:5%;">시간</th>
                    <td class=""><input id="wstdN02" name="wstd_n02" class="basic" type="text" style="width:80%;" value=""></td>
                    <th class="" style="width:5%;">농도</th>
                    <td class=""><input id="wstdT66" name="wstd_t66" class="basic" type="text" style="width:80%;" value=""></td>
                      
                </tr>
                </tbody></table>
              </fieldset>
            </div>

            <div class="">
              <fieldset class="popField">
                <legend>공정</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="9">
                    <col width="12%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                    <col width="11%">
                  </colgroup>
                  <tbody><tr>
                    <th>구분</th>
                    <th>예열</th>
                    <th>침탄</th>
                    <th>확산</th>
                    <th>강온</th>
                    <th>균열</th>
                    <th>Oil</th>
                    <th>교반기</th>
                    <th>냉각시간</th>
                  </tr>
                  <tr>
                    <th>온도[℃]</th>
                    <td><input id="wstdGJ11" name="wstd_gj11" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ12" name="wstd_gj12" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ13" name="wstd_gj13" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ14" name="wstd_gj14" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ15" name="wstd_gj15" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ16" name="wstd_gj16" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ17" name="wstd_gj17" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ18" name="wstd_gj18" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th>시간[분]</th>
                    <td><input id="wstdGJ21" name="wstd_gj21" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ22" name="wstd_gj22" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ23" name="wstd_gj23" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ24" name="wstd_gj24" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ25" name="wstd_gj25" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ26" name="wstd_gj26" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ27" name="wstd_gj27" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ28" name="wstd_gj28" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th>cp%</th>
                    <td><input id="wstdGJ31" name="wstd_gj31" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ32" name="wstd_gj32" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ33" name="wstd_gj33" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ34" name="wstd_gj34" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ35" name="wstd_gj35" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ36" name="wstd_gj36" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ37" name="wstd_gj37" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ38" name="wstd_gj38" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th>RX[㎥/Hr]</th>
                    <td><input id="wstdGJ39" name="wstd_gj39" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ42" name="wstd_gj42" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ43" name="wstd_gj43" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ44" name="wstd_gj44" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ45" name="wstd_gj45" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>LPG</th>
                    <td><input id="wstdGJ49" name="wstd_gj49" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ52" name="wstd_gj52" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ53" name="wstd_gj53" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ54" name="wstd_gj54" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ55" name="wstd_gj55" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>CH3OH[cc/Hr]</th>
                    <td><input id="wstdGJ59" name="wstd_gj59" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ62" name="wstd_gj62" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ63" name="wstd_gj63" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ64" name="wstd_gj64" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ65" name="wstd_gj65" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>N2[㎥/Hr]</th>
                    <td><input id="wstdGJ69" name="wstd_gj69" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ72" name="wstd_gj72" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ73" name="wstd_gj73" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ74" name="wstd_gj74" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ75" name="wstd_gj75" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>NH3[Nl/min]</th>
                    <td><input id="wstdGJ79" name="wstd_gj79" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ82" name="wstd_gj82" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ83" name="wstd_gj83" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ84" name="wstd_gj84" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="wstdGJ85" name="wstd_gj85" class="basic" type="text" style="width:90%;" value=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                    <td><input id="" name="" class="basic" type="text" style="width:90%;" value="" disabled=""></td>
                  </tr>
                  <tr>
                    <th>수량</th>
                    <td><input id="wstdGJSu" name="wstd_gjsu" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th>rpm</th>
                    <td><input id="wstdGJRpm" name="wstd_gjrpm" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                </tbody></table>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="2">
                    <col width="10%">
                    <col width="90%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">비고</th>
                    <td class=""><input id="wstdWorkNote" name="wstd_worknote" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>

                </tbody></table>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="2">
                    <col width="10%">
                    <col width="90%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">설비</th>
                    <td class="">
                      <select id="facCode" name="fac_code" class="basic" style="width: 100%">
                        
                          <option value="5">고주파 1호기(폐기)</option>
                        
                          <option value="6">고주파 2호기 (폐기)</option>
                        
                          <option value="9">고주파 5호기</option>
                        
                          <option value="21">급수시설</option>
                        
                          <option value="10">변성로 1호기</option>
                        
                          <option value="11">변성로 2호기</option>
                        
                          <option value="12">쇼트 1호기</option>
                        
                          <option value="13">쇼트 2호기</option>
                        
                          <option value="14">쇼트 3호기</option>
                        
                          <option value="19">쇼트 4호기</option>
                        
                          <option value="20">전기시설</option>
                        
                          <option value="15">진공세정기 2호기</option>
                        
                          <option value="1">침탄로 1호기</option>
                        
                          <option value="2">침탄로 2호기</option>
                        
                          <option value="3">침탄로 3호기</option>
                        
                          <option value="4">침탄로 4호기</option>
                        
                          <option value="18">침탄로 5호기</option>
                        
                          <option value="22">콤프레샤</option>
                        
                          <option value="16">템퍼링기 1호기</option>
                        
                          <option value="17">템퍼링기 2호기</option>
                        
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th class="">보고서 유형</th>
                    <td class="">
                      <select id="reportType" name="report_type" class="basic" style="width: 100%">
                        <option value="QT1">QT-Tempering</option>
                        <option value="QT2">QT-1차,2차 Tempering</option>
                        <option value="QT3">QT-심냉처리</option>
                        <option value="QT4">QT-응력제거</option>
                        <option value="CH1">침탄-Tempering</option>
                        <option value="CH2">침탄-1차,2차 Tempering</option>
                        <option value="CH3">침탄-중간검사교정</option>
                        <option value="CH4">침탄-Marking</option>
                      </select>
                    </td>
                  </tr>
                </tbody></table>
              </fieldset>
            </div>
            <div class="">
              <fieldset class="popField">
                <legend>후세척</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                      <tbody><tr>
                      <td class=""><select id="facCode2" name="fac_code2" class="basic" style="width: 100%">
                           
                           <option value="15">진공세정기 2호기</option>
                           
                           </select>
                      <!-- <td class="" hidden=""><select id="wstdStep08" name="wstdStep08"class="basic" style="width:145px;">
                          <option></option>
                          <option>STEP1</option>
                          <option>STEP2</option>
                          <option>STEP3</option>
                         </select> -->
                    </td><th class="" style="width:5%;">온도</th>
                    <td class=""><input id="wstdN03" name="wstd_n03" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:5%;">시간</th>
                    <td class=""><input id="wstdN04" name="wstd_n04" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:5%;">농도</th>
                    <td class=""><input id="wstdT67" name="wstd_t67" class="basic" type="text" style="width:90%;" value=""></td>
                      </tr>
                </tbody></table>
              </fieldset>
              <fieldset class="popField">
                <legend>1차탬퍼링</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="5">
                    <col width="1%">
                    <col width="5%">
                    <col width="1%">
                    <col width="5%">
                    <col width="1%">
                    <col width="5%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">온도</th>
                    <td class=""><input id="wstdReady" name="wstd_ready" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="">시간</th>
                    <td class=""><input id="wstdWorkTime" name="wstd_worktime" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="">비고</th>
                    <td class=""><input id="wstdT62" name="wstd_t62" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                </tbody></table>
              </fieldset>
              <fieldset class="popField">
                <legend>2차탬퍼링</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <colgroup span="5">
                    <col width="1%">
                    <col width="5%">
                    <col width="1%">
                    <col width="5%">
                    <col width="1%">
                    <col width="5%">
                  </colgroup>
                  <tbody><tr>
                    <th class="">온도</th>
                    <td class=""><input id="wstdT63" name="wstd_t63" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="">시간</th>
                    <td class=""><input id="wstdT64" name="wstd_t64" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="">비고</th>
                    <td class=""><input id="wstdT65" name="wstd_t65" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                </tbody></table>
              </fieldset>
              <fieldset class="popField">
                <legend>후처리</legend>
                <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                  <tbody><tr>
                    <th class="" style="width:10%;">후처리 수량</th>
                    <td class=""><input id="wstdGJ97" name="wstd_gj97" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:10%;">설비</th>
                    <td class=""><select id="facCode3" name="fac_code3" class="basic" style="width: 90%">
                      
                        <option value="12">쇼트 1호기</option>
                      
                        <option value="13">쇼트 2호기</option>
                      
                        <option value="14">쇼트 3호기</option>
                      
                        <option value="19">쇼트 4호기</option>
                      
                    </select>
                  </td></tr>
                  <tr>
                    <th class="" style="width:5%;">1차처리</th>
                    <td class=""><input id="wstdGJ98" name="wstd_gj98" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:5%;">압력</th>
                    <td class=""><input id="wstdGJ99" name="wstd_gj99" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th class="" style="width:5%;">2차처리</th>
                    <td class=""><input id="wstdGJ100" name="wstd_gj100" class="basic" type="text" style="width:90%;" value=""></td>
                    <th class="" style="width:5%;">압력</th>
                    <td class=""><input id="wstdGJ101" name="wstd_gj101" class="basic" type="text" style="width:90%;" value=""></td>
                  </tr>
                </tbody></table>
              </fieldset>
            </div>
          </td>


          <td class="" valign="top" style="padding-left:10px;">
            <fieldset class="popField">
              <legend>단취사진</legend>
              <div class="findImage">
                <input type="hidden" name="type" value="standard">
                  <input type="file" name="imageFile1" title="이미지 찾기" onchange="previewImage(this,'previewId1')">
                  <!--<input type="button" value="X" title="삭제" class="btnFT" /> -->
                <div class="imgArea" id="previewId1" style="height:90px;border:1px solid #ddd;"><img id="prev_previewId1" src="/resources/images/noimage_01.gif" width="100%" height="100%"></div>
              </div>
            </fieldset>
            <fieldset class="popField">
              <legend>작업표준서</legend>
              <input type="hidden" name="type" value="pdffile">
              <input type="file" name="wstdfile" title="" onchange="" style=" width: 140px;" accept=".pdf">
            </fieldset>
            <fieldset class="popField">
              <legend>사진-3</legend>
              <div class="findImage">
              <input type="hidden" name="type" value="standard">
                  <input type="file" name="imageFile3" title="이미지 찾기" onchange="previewImage(this,'previewId3')"><!-- <input type="button" value="X" title="삭제" class="btnFT" /> -->
                <div class="imgArea" id="previewId3" style="height:91px;border:1px solid #ddd;"><img id="prev_previewId3" src="/resources/images/noimage_01.gif" width="100%" height="100%"></div>
              </div>
            </fieldset>

            <!-- 단취방법 -->
            <div class="">
            <fieldset class="popField">
              <legend>단취방법</legend>
              <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable3">
                <colgroup span="4">
                  <col width="34%">
                  <col width="33%">
                  <col width="25%">
                  <col width="25%">
                </colgroup>
                <tbody><tr>
                  <td class="top">EA/줄(판)</td>
                  <td class="top2" colspan="2"><input type="text" id="wstdT32" name="wstd_t32" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()"></td>
                  <td class="top2">이하</td>
                </tr>
                <tr>
                  <td class="left">줄(판)/단</td>
                  <td colspan="3"><input type="text" id="wstdT33" name="wstd_t33" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()"></td>
                  <td colspan="2" hidden=""><input type="text" id="wstdT34" name="wstd_t34" value="" class="basic" style="width:90%; display:none;"></td>
                </tr>
                <tr>
                  <td class="left">단/Tray</td>
                  <td><input type="text" id="wstdT41" name="wstd_t41" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()"></td>
                  <td>Tray차지</td>
                  <td><input type="text" id="wstdT42" name="wstd_t42" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()"></td>
                </tr>
                <tr>
                  <td class="left">추가수량</td>
                  <td colspan="3"><input type="text" id="wstdT87" name="wstd_t87" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()"></td>
                </tr>
                <tr>
                  <td class="left">단취수량</td>
                  <td colspan="2"><input type="text" id="wstdT43" name="wstd_t43" value="" class="basic" style="width:90%; text-align: right;" readonly=""></td>
                  <td>EA/CH</td>
                </tr>
                <tr>
                  <td class="left">Jig무게</td>
                  <td colspan="2"><input type="text" id="wstdT44" name="wstd_t44" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()"></td>
                  <td>kg</td>
                </tr>
                <tr>
                  <td class="left">제품무게/ch</td>
                  <td colspan="2"><input type="text" id="wstdT51" name="wstd_t51" value="" class="basic" style="width:90%; text-align: right;" readonly=""></td>
                  <td>kg</td>
                </tr>
                <tr>
                  <td class="left">총단중/ch</td>
                  <td colspan="2"><input type="text" id="wstdT52" name="wstd_t52" value="" class="basic" style="width:90%; text-align: right;" readonly=""></td>
                  <td>kg</td>
                </tr>

                <tr height="5px"></tr>

                <tr>
                  <th class="left" colspan="4">단취시 유의사항</th>
                </tr>
                <tr>
                  <td class="left" colspan="4">
                    ● <input type="text" id="wstdT53" name="wstd_t53" value="" class="basic" style="width:91%;">
                  </td>
                </tr>
                <tr>
                  <td class="left" colspan="4">
                    ● <input type="text" id="wstdT54" name="wstd_t54" value="" class="basic" style="width:91%;">
                  </td>
                </tr>
                <tr>
                  <td class="left" colspan="4">
                    ● <input type="text" id="wstdT30" name="wstd_t30" value="" class="basic" style="width:91%;">
                  </td>
                </tr>
                <tr>
                  <td class="left">단중</td>
                  <td colspan="2"><input type="text" id="wstdT40" name="wstd_t40" value="" class="basic" style="width:90%; text-align: right;" onchange="fn_Calc()"></td>
                  <td>kg</td>
                </tr>
                <tr>
                  <!-- <td class="left">HIGH NO</td> -->
                  <td colspan="2" hidden=""><input type="text" id="wstdT50" name="wstd_t50" value="" class="basic" style="width:97%; text-align: right; display:none;" readonly=""></td>
                  <!-- <td>EA</td> -->
                </tr>
                <tr>
                  <!-- <td class="left">LOW NO</td> -->
                  <td colspan="2" hidden=""><input type="text" id="wstdT55" name="wstd_t55" value="" class="basic" style="width:97%; text-align: right; display:none;" readonly=""></td>
                  <!-- <td>EA</td> -->
                </tr>
              </tbody></table>
            </fieldset>
            </div>
           </td>
          </tr>
        </tbody></table>
        
        <div style="margin-top:10px; border-top:1px solid #bbb; height:1px;"></div>
          <div class="clear"></div>
          
        <fieldset class="popField">
          <legend>심냉처리</legend>
            <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
            <colgroup span="5">
              <col width="60">
              <col width="100">
              <col width="60">
              <col width="100">
              <col width="60">
              <col width="100">
              <col width="60">
              <col width="100">
              <col width="70">
              <col width="100">
              <col width="40">
              <col width="100">
            </colgroup>
            <tbody><tr>
              <th class="left">예냉온도</th>
              <td class=""><input id="wstdT68" name="wstd_t68" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">예냉시간</th>
              <td class=""><input id="wstdT69" name="wstd_t69" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">심냉온도</th>
              <td class=""><input id="wstdT70" name="wstd_t70" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">심냉시간</th>
              <td class=""><input id="wstdT71" name="wstd_t71" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">방냉후실온</th>
              <td class=""><input id="wstdT72" name="wstd_t72" class="basic" type="text" style="width:90%;" value=""></td>
              <th class="">비고</th>
              <td class=""><input id="wstdT73" name="wstd_t73" class="basic" type="text" style="width:90%;" value=""></td>
            </tr>
            </tbody></table>
        </fieldset>
        
        <div class="">
          <fieldset class="popField">
            <legend>개정이력</legend>
            <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable2">
              <colgroup span="5">
                <col width="">
                <col width="">
                <col width="">
                <col width="">
              </colgroup>
              <tbody><tr>
                <th class="left">NO</th>
                <th class="">개정일자</th>
                <th class="">사유</th>
                <th class="">확인</th>
              </tr>
              <tr>
                <td class="left">1</td>
                <td class=""><input id="wstdG11" name="wstd_g11" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""><input id="wstdG12" name="wstd_g12" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""></td>
              </tr>
              <tr>
                <td class="left">2</td>
                <td class=""><input id="wstdG21" name="wstd_g21" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""><input id="wstdG22" name="wstd_g22" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""></td>
              </tr>
              <tr>
                <td class="left">3</td>
                <td class=""><input id="wstdG31" name="wstd_g31" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""><input id="wstdG32" name="wstd_g32" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""></td>
              </tr>
              <tr>
                <td class="left">4</td>
                <td class=""><input id="wstdG41" name="wstd_g41" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""><input id="wstdG42" name="wstd_g42" class="basic" type="text" style="width:98%;" value=""></td>
                <td class=""></td>
              </tr>
            </tbody></table>
          </fieldset>
        </div>
        <div class="btnSaveClose">
            <button class="save" type="button" onclick="save();">저장</button>
            <button class="close" type="button" onclick="window.close();">닫기</button>
    	</div>
     </div>
    </form>    
  </div>    
    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
<script>
	//전역변수
    var cutumTable;	

	//로드
	$(function(){
		//전체 거래처목록 조회
		getChimStandardList();
	});

	//이벤트
	//함수
	function getChimStandardList(){
		userTable = new Tabulator("#tab1", {
		    height:"750px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    selectableRows:true,
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/management/chimStandardInsert/getChimStandardList",
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
		        {title:"고객명", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"center"},
		        {title:"품명", field:"prod_name", sorter:"string", width:150,
		        	hozAlign:"center"},
		        {title:"도번/품번", field:"prod_no", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"기종", field:"prod_kijong", sorter:"string", width:200,
		        	hozAlign:"center"},
		        {title:"재질", field:"prod_jai", sorter:"int", width:200,
		        	hozAlign:"center"},
		        {title:"단가", field:"prod_dang", sorter:"int", width:200,
			        hozAlign:"center"},
			    {title:"설비", field:"fac_code", sorter:"int", width:120,
				    hozAlign:"center"},
				{title:"공정", field:"tech_te", sorter:"int", width:150,
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
	

    </script>
    
    
   <script>
		
 // 드래그 기능 추가
	const modal = document.querySelector('.chimStandardModal');
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
	const chimStandardModal = document.querySelector('.chimStandardModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		chimStandardModal.style.display = 'block'; // 모달 표시
	});

	closeButton.addEventListener('click', function() {
		chimStandardModal.style.display = 'none'; // 모달 숨김
	});
		


    </script>

	</body>
</html>
