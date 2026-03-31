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
    
.main{
	width:98%;
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
        
.row_select{
	background-color:#9ABCEA !important;
}
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
/*	width: 1500px;*/
/*	margin-left: -620px;*/
	margin-left: 0%;
}

.box1 input{
	width : 7%;
}
.box1 select{
	width: 5%
}  

/*침탄로작업 등록 모달*/
.workBcfModal{
	position: fixed; /* 화면에 고정 */
	width:1400px;
	height:720px;	
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20010; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.workBcfModal .j_container{
	display:flex;	
}

.workBcfModal .j_row1{
	display:flex;
	margin-top:1px;
}

.workBcfModal .margin_left{
	margin-left:5px;
}

.workBcfModal .iRowBtn{
	display:block;
	cursor:pointer;
	width:70px;
	height:30px;
	font-size:14pt;
}

.workBcfModal .iRowBtn2{
	display:block;
	cursor:pointer;
	width:140px;
	height:30px;
	font-size:14pt;
}

.workBcfModal .iRowLabel{
	display:block;
	width:120px;
	height:20px;
	text-align:center;
	margin-bottom:2px;
	font-size:14pt;
}

.workBcfModal .iRowLabel2{
	display:block;
	width:120px;
	height:24px;
	text-align:left;
	margin-bottom:7px;
	font-size:14pt;
	margin-left:10px;
}

.workBcfModal .iRowInput{
	/*display:flex;*/
	width:120px !important;
	height:20px;
	font-size:14pt;
	text-align:center;
}

.workBcfModal .iRowInput2{
	display:block;
	width:120px !important;
	height:20px;
	font-size:14pt;
	text-align:center;
	margin-bottom:5px;
}

.workBcfModal .iRowInput_180{
	/*display:flex;*/
	width:180px !important;
	height:24px;
	font-size:14pt;
	text-align:center;
}


/*열처리 대기이력*/
.workBcfDanchModal{
	position: fixed; /* 화면에 고정 */
	width:1300px;
	height:750px;
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20011; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.workBcfDanchModal .iRowBtn{
	display:block;
	cursor:pointer;
	width:70px;
	height:30px;
	font-size:14pt;
}

.workBcfDanchModal .j_container{
	display:flex;	
}

.workBcfDanchModal .j_row1{
	display:flex;
	margin-top:1px;
}

.workBcfDanchModal .margin_left{
	margin-left:5px;
}

.workBcfDanchModal .iRowInput{
	/*display:flex;*/
	width:120px !important;
	height:20px;
	font-size:14pt;
	text-align:center;
}

.workBcfDanchModal .iRowInput2{
	display:block;
	width:120px !important;
	height:20px;
	font-size:14pt;
	text-align:center;
	margin-bottom:5px;
}

.workBcfDanchModal .iRowInput_180{
	/*display:flex;*/
	width:180px !important;
	height:24px;
	font-size:14pt;
	text-align:center;
}

/**/

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

.main{
	height: calc(100vh - 162px);
}

/*말줄임표*/
.ellipsis-cell .tabulator-cell-value {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.select-hogi-button{
	font-size:14pt;
}


.checkSheetStatusModal {
	position: fixed; /* 화면에 고정 */
	width:350px;
	height:150px;	
	top: 50%; /* 수직 중앙 */
	left: 40%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20010; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.checkSheetStatusModal .j_container{
	display:flex;
}

.checkSheetStatusModal .j_row1{
	display:flex;
	margin-top:1px;
}


.checkSheetReportModal {
	position: fixed; /* 화면에 고정 */
	width:850px;
	height:800px;
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20010; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.checkSheetReportModal .j_container{
	display:flex;
}

.checkSheetReportModal .j_row1{
	display:flex;
	margin-top:1px;
}


    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
		<form action="" autocomplete="off">
				<label class="daylabel">작업일 :</label>
				<input type="text" id="s_all_sdate" class="datetimepicker_date" style="font-size: 14pt; width:140px;">
				~
				<input type="text" id="s_all_edate" class="datetimepicker_date" style="font-size: 14pt; width:140px;">
				<label class="daylabel">거래처 :</label>
				<input type="text" id="s_all_corp_name" style="font-size: 14pt; width:140px;">
				<label class="daylabel">품명 :</label>
				<input type="text" id="s_all_prod_name" style="font-size: 14pt; width:140px;">
				<label class="daylabel">품번 :</label>
				<input type="text" id="s_all_prod_no" style="font-size: 14pt; width:140px;">
				
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
						<input type="number" name="ilbo_pg1" class="iRowInput bcf_hard_input"/>					
					</div>
					<div class="j_div">
						<input type="number" name="ilbo_pg2" class="iRowInput margin_left bcf_hard_input"/>					
					</div>
					<div class="j_div">
						<input type="number" name="ilbo_pg3" class="iRowInput margin_left bcf_hard_input"/>					
					</div>
					<div class="j_div">
						<input type="number" name="ilbo_pg4" class="iRowInput margin_left bcf_hard_input"/>					
					</div>
					<div class="j_div">
						<input type="number" name="ilbo_pg5" class="iRowInput margin_left bcf_hard_input"/>					
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
	
	<hr />
	
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="iRowBtn margin_left" type="button" onclick="workBcfModalSave();">저장</button>
			<button class="iRowBtn margin_left" type="button" onclick="workBcfModalClose();">닫기</button>
		</div>
    </div>
</div>

<div class="workBcfDanchModal">
	<div class="detail">
		<div class="header">
		작업대기 리스트
		</div>
	</div>
		<div class="j_container">
			<form id="workBcfDanchForm" name="workBcfDanchForm" autocomplete="off" style="width:100%;">
				<div class="j_row1">
					<label class="daylabel">입고일 :</label>
					<input type="text" id="bcf_danch_sdate" class="iRowInput datetimepicker_date" 
					style="width:100px;">
					~
					<input type="text" id="bcf_danch_edate" class="iRowInput datetimepicker_date" 
					style="width:100px;">				
	
					<label for="" class="iRowLabel margin_left">거래처</label>
					<input type="text" id="bcf_danch_cname" class="iRowInput_180 bcf_danch_input"
					style="width:140px;"/>
					<label for="" class="iRowLabel margin_left">품명</label>
					<input type="text" id="bcf_danch_pname" class="iRowInput_180 bcf_danch_input"
					style="width:140px;"/>
					<label for="" class="iRowLabel margin_left">품번</label>
					<input type="text" id="bcf_danch_pno" class="iRowInput_180 bcf_danch_input"
					style="width:140px;"/>
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
		<hr />	
		
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="iRowBtn margin_left" type="button" onclick="workBcfDanchModalClose();">닫기</button>
		</div>
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
		var ydate = yesterDate();
		var tdate = todayDate();
		
		$("#s_all_sdate").val(ydate);
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
                checkSheetReportModal.style.display = "block";
				
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
				$("#selectHogi"+hogi).css("background-color","#FAED7D");		
			}else{
				$("#selectHogi"+hogiArray[i]).css("background-color","#FFFFFF");
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
	function workBcfModalOpen(){
		bcfModalSet(0);
		
		$("#workBcfForm")[0].reset();
		
		getWorkBcfData();
		getWorkBcfDataFacCode();
		getWorkBcfDataUserCode();
		ilboLotRtn(1);
		
		workBcfModal.style.display = 'block'; // 모달 보임
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
		
		workBcfDanchModal.style.display = 'block'; // 모달 숨김
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
		    height:"650px",
		    layout:"fitColumns",
		    selectable:1,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:false,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
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
			    
			    row.getElement().style.fontWeight = "700";
			    
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
		    height:"140px",
		    layout:"fitColumns",
		    selectable:1,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:false,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
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
		    height:"580px",
		    layout:"fitColumns",
		    selectable:1,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:false,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
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
				$("#workBcfForm select[name='user_code']").empty();
				$("#workBcfForm select[name='user_code']").append(_option);
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
				
				$("#workBcfForm select[name='fac_code']").empty();
				$("#workBcfForm select[name='fac_code']").append(_option);
			}
		})
	}

	//열처리작업 저장
	function workBcfModalSave(){

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
				//모달 닫기
				workBcfModalClose();				
				//전체이력 조회
				getWorkDataList();
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

	
    </script>

	</body>
</html>
