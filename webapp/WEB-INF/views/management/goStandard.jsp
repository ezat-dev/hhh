<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고주파로작업표준</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>     
    <style>
    
.container {
		display: flex;
		justify-content: space-between;
/*		margin-left:1008px;
		margin-top:200px;*/
	}
.goStandardModal {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 수직 중앙 */
    left: 50%; /* 수평 중앙 */
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
    
    .box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -1080px;
}

.box1 input{
	width : 5%;
}
.box1 select{
	width: 5%
}
#tab1 .tabulator-cell {
	border: 1px solid #E2E8F0;
}
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
        
		<label class="daylabel">거래처명 :</label>
		<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">품명 :</label>
		<input type="text" class="prod_name" id="prod_name" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">품번 :</label>
		<input type="text" class="prod_no" id="prod_no" style="font-size: 16px;" autocomplete="off">
			
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getGoStandardList();">
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
	
	<div class="goStandardModal">
	<form name="searchForm" method="post" enctype="multipart/form-data">
                    <div id="editPop">
                    	<div class="header">
       						고주파로표준등록
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
                                <td class=""><input id="prodCno" name="prod_cno" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
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
                                <th class="">ECD</th>
                                <td class=""><input id="prodE5" name="prod_e5" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                                <th class="left">Ra%</th>
                                <td class=""><input id="prodRa" name="prod_ra" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                                <th class="left">기종</th>
                                <td class=""><input id="prodKijong" name="prod_kijong" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                                <td class=""><input id="prodSg" name="prod_sg" class="basic" type="hidden" style="width:100%;" value="" readonly=""></td>
                                <td class=""><input id="prodE1" name="prod_e1" class="basic" type="hidden" style="width:100%;" value="" readonly=""></td>
                                <td class=""><input id="prodE3" name="prod_e3" class="basic" type="hidden" style="width:100%;" value="" readonly=""></td>
                                <td class=""><input id="prodPg3" name="prod_pg3" class="basic" type="hidden" style="width:100%;" value="" readonly=""></td>
                                <td class=""><input id="prodSg3" name="prod_sg3" class="basic" type="hidden" style="width:100%;" value="" readonly=""></td>
                                <td class=""><input id="prodPgs" name="prod_pgs" class="basic" type="hidden" style="width:100%;" value="" readonly=""></td>
                                <td class=""><input id="prodGd1" name="prod_gd1" class="basic" type="hidden" style="width:100%;" value="" readonly=""></td>
                                <td class=""><input id="prodGd2" name="prod_gd2" class="basic" type="hidden" style="width:100%;" value="" readonly=""></td>
                                <td class=""><input id="prodGd3" name="prod_gd3" class="basic" type="hidden" style="width:100%;" value="" readonly=""></td>
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
                                            </colgroup>
                                            <tbody><tr>
                                                 <th class="">외관 및 크랙/(n=3)</th>
                                                <td class=""><input id="prodAppear" name="prod_appear" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                                                <th class="">표면경도(n=3)</th>
                                                <td class=""><input id="prodPg" name="prod_pg" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
    <!-- 											<th class="">ECD/(n=1)</th> -->
    <!-- 											<td class=""><input id="prodE5" name="prodE5" class="basic" type="text" style="width:100%;" value="" readonly/></td> -->
                                                <th class="">경화거리/n=1</th>
                                                <td class=""><input id="ProdCd" name="Prod_cd" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                                            </tr>
                                            <tr>
                                                
                                                <th class="">변형</th>
                                                <td class=""><input id="prodTransform" name="prod_transform" class="basic" type="text" style="width:90%;" value="" readonly=""></td>
                                            </tr>
                                            <tr>
                                            <th class="" hidden="">경화깊이</th>
                                            <td class="" hidden=""><input id="prodGD1" name="prod_gd1" class="basic" type="text" style="width:100%; display:none;" value="" readonly=""></td><td class="" align="center">기준</td><td class="" hidden=""><input id="prodGD2" name="prod_gd2" class="basic" type="text" style="width:100%; display:none;" value="" readonly=""></td>
                                            <td class="" align="center" hidden="">~</td><td class="" hidden=""><input id="prodGD5" name="prod_gd5" class="basic" type="text" style="width:100%; display:none;" value="" readonly=""></td>
                                            </tr>
                                        </tbody></table>
                                    </fieldset>
                                </div>
                                
                                <div>
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
                                                <td class=""><input id="wstdN01" name="wstd_n01" class="basic" type="text" style="width:90%;" value=""></td>
                                                <th class="" style="width:5%;">시간</th>
                                                <td class=""><input id="wstdN02" name="wstd_n02" class="basic" type="text" style="width:90%;" value=""></td>
                                                <th class="" style="width:5%;">농도</th>
                                                <td class=""><input id="wstdT66" name="wstd_t66" class="basic" type="text" style="width:90%;" value=""></td>
                                            
                                        </tr>
                                        </tbody></table>
                                    </fieldset>
                                </div>
                                
                                <div class="">
                                    <fieldset class="popField">
                                        <legend>공정</legend>
                                        <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable">
                                          <tbody><tr>
                                                <td width="11%" style="text-align: right">PLUG준비</td>
                                                <td width="11%"><input id="wstdH01" name="wstd_h01" class="basic" type="text" style="width:90%;"></td>
                                                <td width="11%" style="text-align: right">COIL준비</td>
                                                <td width="11%"><input id="wstdH02" name="wstd_h02" class="basic" type="text" style="width:90%;"></td>
                                                <td width="17%" style="text-align: right">COIL받침볼트높이</td>
                                                <td width="13%"><input id="wstdH03" name="wstd_h03" class="basic" type="text" style="width:90%;"></td>
                                                <td width="12%" style="text-align: right">유도자간격</td>
                                                <td width="14%"><input id="wstdH04" name="wstd_h04" class="basic" type="text" style="width:90%;"></td>
                                            </tr>
                                            <tr>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                              <td></td>
                                          </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td style="text-align: center">내주1차가열</td>
                                                <td style="text-align: center">외주1차가열</td>
                                                <td style="text-align: center">내주2차가열</td>
                                                <td style="text-align: center">외주2차가열</td>
                                                <td style="text-align: center">내주냉각</td>
                                                <td style="text-align: center">외주냉각</td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: right">지연시간</td>
                                                <td><input id="wstdH05" name="wstd_h05" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH06" name="wstd_h06" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH07" name="wstd_h07" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH08" name="wstd_h08" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH09" name="wstd_h09" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH10" name="wstd_h10" class="basic" type="text" style="width:90%;"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: right">시간</td>
                                                <td><input id="wstdH11" name="wstd_h11" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH12" name="wstd_h12" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH13" name="wstd_h13" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH14" name="wstd_h14" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH15" name="wstd_h15" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH16" name="wstd_h16" class="basic" type="text" style="width:90%;"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: right">전압(유량)</td>
                                                <td><input id="wstdH17" name="wstd_h17" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH18" name="wstd_h18" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH19" name="wstd_h19" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH20" name="wstd_h20" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH21" name="wstd_h21" class="basic" type="text" style="width:90%;"></td>
                                                <td><input id="wstdH22" name="wstd_h22" class="basic" type="text" style="width:90%;"></td>
                                            </tr>
                                            <tr>
                                              <td colspan="2"></td>
                                              <td colspan="2"></td>
                                              <td colspan="2"></td>
                                              <td colspan="2"></td>
                                          </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: right">소입수AIR BLOW 시간</td>
                                                <td colspan="2"><input id="wstdH23" name="wstd_h23" class="basic" type="text" style="width:90%;"></td>
                                                <td colspan="2" style="text-align: right">AIR BLOW 시간</td>
                                                <td colspan="2"><input id="wstdH24" name="wstd_h24" class="basic" type="text" style="width:90%;"></td>
                                            </tr>
                                            <tr>
                                              <td colspan="2" style="text-align: right">소입수온도</td>
                                              <td colspan="2"><input id="wstdH25" name="wstd_h25" class="basic" type="text" style="width:90%;"></td>
                                              <td colspan="2" style="text-align: right">소입수농도</td>
                                              <td colspan="2"><input id="wstdH26" name="wstd_h26" class="basic" type="text" style="width:90%;"></td>
                                          </tr>
                                            <tr>
                                              <td colspan="2" style="text-align: right">설비종류</td>
                                              <td colspan="2"><select id="facCode" name="fac_code" class="basic" style="width: 100%">
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
                                              </select></td>
                                              <td colspan="2" style="text-align: right">중간검사</td>
                                              <td colspan="2"><input id="wstdGumNote" name="wstd_gumnote" class="basic" type="text" style="width:90%;" value=""></td>
                                            </tr>
                                        </tbody></table>
                                    </fieldset>
                                </div>
                                <div>
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
                                        <legend>탬퍼링</legend>
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
                                    <legend>제품사진</legend>
                                    <div class="findImage">
                                        <input type="hidden" name="type" value="standard">
                                            <input type="file" name="imageFile1" title="이미지 찾기" onchange="previewImage(this,'previewId1')">
                                            <!--<input type="button" value="X" title="삭제" class="btnFT" /> -->
                                        <div class="imgArea" id="previewId1" style="height:100px;border:1px solid #ddd;"><img id="prev_previewId1" src="/tkheat/css/image/no_image.png" width="100%" height="100%"></div>
                                    </div>
                                </fieldset>
                                <fieldset class="popField">
                                    <legend>작업표준서</legend>
                                    <div class="findImage">
                                    <input type="hidden" name="type" value="standard">
                                            <input type="file" name="imageFile2" title="이미지 찾기" onchange="previewImage(this,'previewId2')"><!-- <input type="button" value="X" title="삭제" class="btnFT" /> -->
                                        <div class="imgArea" id="previewId2" style="height:90px;border:1px solid #ddd;"><img id="prev_previewId2" src="/tkheat/css/image/no_image.png" width="100%" height="100%"></div>
                                    </div>
                                </fieldset>
                                <!-- 단취방법 -->
                                <div class="">
                                <fieldset class="popField">
                                    <legend>단취방법</legend>
                                    <table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable3">
                                        <colgroup span="4">
                                            <col width="34%">
                                            <col width="30%">
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
                                            <td colspan="3"><input type="text" id="wstdT33" name="wstd_t33" value="" class="basic" style="width:100%; text-align: right;" onchange="fn_Calc()"></td>
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
                                    </tbody></table>
                                </fieldset>
                                </div>
                             </td>
                            
                        </tr>
                        </tbody></table>
                        
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
                        
                        <div style="margin-top:10px; border-top:1px solid #bbb; height:1px;"></div>
                        <div class="clear"></div>
                        <!-- Article List.end -->
                        
                        <div class="popBottomSec">
                            <div class="btnPopBottom" style="width:390px;">
                                <ul>
                                    
                                    <li><input class="btnPopSave" type="button" title="저장" onclick="save();"></li>
                                    <li><input class="btnPopClose" type="button" title="종료" onclick="window.close();"></li>
                                </ul>
                            </div>
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
		getGoStandardList();
	});

	//이벤트
	//함수
	function getGoStandardList(){
		
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
		    ajaxURL:"/tkheat/management/goStandardInsert/getGoStandardList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"corp_name": $("#corp_name").val(),
                "prod_name": $("#prod_name").val(),
                "prod_no": $("#prod_no").val(),
			    },
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"거래처명", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"품명", field:"prod_name", sorter:"string", width:150,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"품번", field:"prod_no", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"규격", field:"prod_gyu", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"재질", field:"prod_jai", sorter:"int", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"설비", field:"fac_code", sorter:"int", width:200,
			        hozAlign:"center", headerFilter:"input"},
			    {title:"공정", field:"tech_te", sorter:"int", width:120,
				    hozAlign:"center", headerFilter:"input"},
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
	const modal = document.querySelector('.goStandardModal');
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
	const goStandardModal = document.querySelector('.goStandardModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		goStandardModal.style.display = 'block'; // 모달 표시
	});

	closeButton.addEventListener('click', function() {
		goStandardModal.style.display = 'none'; // 모달 숨김
	});
		


    </script>
    
    
    
    
    
    
    
    
    
    
    
    
    
    

	</body>
</html>
