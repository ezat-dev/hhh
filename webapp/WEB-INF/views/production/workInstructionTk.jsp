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
        
.tabulator .tabulator-cell {
	white-space: normal !important;
	word-break: break-word; 
	text-align: center;
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

/*작업지시선택 모달*/
.workSelectModal {
	position: fixed; /* 화면에 고정 */
	width:500px;
	height:200px;	
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20010; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.workSelectModal .j_container{
	display:flex;	
}

.workSelectModal .j_row1{
	display:flex;
	margin-top:1px;
}

.workSelectModal .margin_left{
	margin-left:5px;
}

.workSelectModal .iRowBtn{
	display:block;
	cursor:pointer;
	width:70px;
	height:30px;
	font-size:12pt;
}

.workSelectModal .workSelectBtn{
	width:140px;
	height:70px;
	border-radius: 3px; /* 모서리 둥글게 */
	border: 1px solid black;
	margin-right: 5%;
	text-align : center;
	font-size:14pt;
	background:white;
	cursor:pointer;
}

.workSelectModal .workSelectBtn:hover{
	background:aliceblue;
}

/*단취작업 등록 모달*/
.workDanModal{
	position: fixed; /* 화면에 고정 */
	width:1400px;
	height:680px;	
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20010; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.workDanModal .j_container{
	display:flex;	
}

.workDanModal .j_row1{
	display:flex;
	margin-top:1px;
}

.workDanModal .margin_left{
	margin-left:5px;
}

.workDanModal .iRowBtn{
	display:block;
	cursor:pointer;
	width:70px;
	height:30px;
	font-size:12pt;
}

.workDanModal .iRowBtn2{
	display:block;
	cursor:pointer;
	width:120px;
	height:30px;
	font-size:12pt;
}

.workDanModal .iRowLabel{
	display:block;
	width:120px;
	height:20px;
	text-align:center;
	margin-bottom:2px;
	font-size:12pt;
}

.workDanModal .iRowLabel2{
	display:block;
	width:120px;
	height:24px;
	text-align:left;
	margin-bottom:7px;
	font-size:12pt;
	margin-left:10px;
}

.workDanModal .iRowInput{
	/*display:flex;*/
	width:120px !important;
	height:20px;
	font-size:12pt;
	text-align:center;
}

.workDanModal .iRowInput2{
	display:block;
	width:120px !important;
	height:20px;
	font-size:12pt;
	text-align:center;
	margin-bottom:5px;
}

/*단취-입고이력 저장모달*/
.workDanIpgoModal{
	position: fixed; /* 화면에 고정 */
	width:1200px;
	height:750px;
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20011; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
}

.workDanIpgoModal .iRowBtn{
	display:block;
	cursor:pointer;
	width:70px;
	height:30px;
	font-size:12pt;
}

.workDanIpgoModal .j_container{
	display:flex;	
}

.workDanIpgoModal .j_row1{
	display:flex;
	margin-top:1px;
}

.workDanIpgoModal .margin_left{
	margin-left:5px;
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

.tabulator-header > .tabulator-headers > .tabulator-col > .tabulator-col-content > .tabulator-col-title-holder > .tabulator-col-title{
	font-size: 10pt !important;
}

.tabulator-col-title > input[type='checkbox']{
	width:20px;
	height:20px;
}

.tabulator-cell > input[type='checkbox']{
	width:20px;
	height:20px;
}


    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
		<form action="" autocomplete="off">
				<label class="daylabel">작업일 :</label>
				<input type="date" id="s_all_sdate" style="font-size: 14pt; width:140px;">
				~
				<input type="date" id="s_all_edate" style="font-size: 14pt; width:140px;">
				<label class="daylabel">거래처 :</label>
				<input type="text" id="s_all_corp_name" style="font-size: 14pt; width:140px;">
				<label class="daylabel">품명 :</label>
				<input type="text" id="s_all_prod_name" style="font-size: 14pt; width:140px;">
				<label class="daylabel">품번 :</label>
				<input type="text" id="s_all_prod_no" style="font-size: 14pt; width:140px;">
				
		</form>	
	</div>
    <div class="button-container">
        <button class="select-button">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
<!--         
        <button class="insert-button" id="jAddBtn">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          	단취등록
        </button>
 -->
        <button class="insert-button" id="workSelectBtn">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
        </button>
        <button class="delete" id="workDeleteBtn">
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
		<div id="workTabu"></div>
	</div>
</main>
	    
<!-- 다이얼로그 -->
<!-- 작업지시 선택 모달 -->
<div class="workSelectModal">
	<div class="detail">
		<div class="header">
		작업지시 선택
		</div>
	</div>
	
	<form id="workSelectForm" name="workSelectForm" autocomplete="off">
		<div class="j_container">
			<button class="workSelectBtn margin_left" type="button" onclick="workDanModalOpen();">단취</button>
			<button class="workSelectBtn margin_left" type="button" onclick="workBcfModalOpen();">열처리</button>
			<button class="workSelectBtn margin_left" type="button" onclick="workTfModalOpen();">템퍼링</button>
		</div>
	</form>
	
	<hr />
	
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="iRowBtn margin_left" type="button" onclick="workSelectModalClose();">닫기</button>
		</div>
    </div>
</div>

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
				<input type="text" id="danch_ord_code" name="danch_ord_code" class="iRowInput_180"/>
				<button class="iRowBtn2 margin_left" type="button" onclick="workHIpgoDataBarcodeScan();">수주NO조회</button>				
				<button class="workHDataBtn iRowBtn2 margin_left" type="button" onclick="workDanIpgoModalOpen();">입고이력조회</button>
				<label for="" class="margin_left iRowLabel">총 작업수량</label>
				<input type="text" name="danch_total_cnt" class="iRowInput" value="0" disabled="disabled"/>			
				<label for="" class="margin_left iRowLabel">단취 기준수량</label>
				<input type="text" name="danch_std_cnt" class="iRowInput" value="0" disabled="disabled"/>			
				<label for="" class="margin_left iRowLabel">선입선출제외</label>
				<input type="checkbox" id="danch_sunip_chk" name="danch_sunip_chk" class="iRowInput"
					style="width:40px !important;"/>
				<input type="password" id="danch_sunip_chk_pw" name="danch_sunip_chk_pw" class="iRowInput margin_left"/>
									
			</div>	
	
		
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
					<select name="user_code" class="iRowInput" style="height:27px;"></select>						
				</div>
				
				<div class="j_div">
					<label for="wstd_t32" class="iRowLabel margin_left" style="width:240px;">작업시작</label>
					<input type="datetime-local" name="ilbo_strt" class="iRowInput margin_left" style="width:240px !important; height:25px;"/>
					<button class="iRowBtn margin_left" type="button" onclick="sdateTimeSetBtn('danchStart');"
					style="display:inline-block;">시작</button>
				</div>
				
				<div class="j_div">
					<label for="wstd_t32" class="iRowLabel margin_left" style="width:240px;">작업종료</label>
					<input type="datetime-local" name="ilbo_end" class="iRowInput margin_left" style="width:240px !important; height:25px;"/>
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
				</div>
			</div>

			
			
		</div>
		
	</form>
	
	<hr />
	
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="iRowBtn margin_left" type="button" onclick="workDanModalSave();">저장</button>
			<button class="iRowBtn margin_left" type="button" onclick="workDanModalClose();">닫기</button>
		</div>
    </div>
</div>


<!-- 입고이력 -->
<div class="workDanIpgoModal">
	<div class="detail">
		<div class="header">
		작업대기 리스트
		</div>
	</div>
		<div class="j_container">
			<form id="workDanIpgoForm" name="workDanIpgoForm" autocomplete="off">
				<label for="" class="iRowLabel margin_left">거래처</label>
				<input type="text" id="dan_ipgo_cname" class="iRowInput_180 dan_ipgo_input"/>
				<label for="" class="iRowLabel margin_left">품명</label>
				<input type="text" id="dan_ipgo_pname" class="iRowInput_180 dan_ipgo_input"/>
				<label for="" class="iRowLabel margin_left">품번</label>
				<input type="text" id="dan_ipgo_pno" class="iRowInput_180 dan_ipgo_input"/>
			</form>
			<button class="iRowBtn margin_left" type="button" onclick="getWorkDanIpgoDataList();">조회</button>
			<span style="color:red;" class="margin_left">*단취기준수량 0인 제품은 작업표준에서 등록해주십시오!</span>				
		</div>	
	
		<div class="j_container">
			<div class="setRow">
				<div id="workDanIpgoTabu"></div>
			</div>
		</div>
		<hr />	
		
    <div class="j_container" style="justify-content:end;">
    	<div class="j_row1">
			<button class="iRowBtn margin_left" type="button" onclick="workDanIpgoModalClose();">닫기</button>
		</div>
    </div>
</div>


<form id="reportPrint" name="reportPrint">
	<input type="text" id="reportDate" name="reportDate" style="display:none;"/>
	<input type="text" id="reportBarcode" name="reportBarcode" style="display:none;"/>
	<input type="text" id="reportPlnpLot" name="reportPlnpLot" style="display:none;"/>
</form>

<a style="display:none;" id="downLoadLink" href="#" download="#"></a>
	
<script>
	//전역변수
    var cutumTable;	
    let now_page_code = "b06";
	
    var danchSdateTime, danchEdateTime;
    
	//로드
	$(function(){
		//전체 거래처목록 조회
		var ydate = yesterDate();
		var tdate = todayDate();
		
		$("#s_all_sdate").val(ydate);
		$("#s_all_edate").val(tdate);
		
		getWorkData();
		getWorkDataList();
	});

	//이벤트
	$("#workSelectBtn").on("click",function(){
		//단취, 열처리, 템퍼링선택모달 오픈
		workSelectModalOpen();
	});
	
	$(".dan_ipgo_input").on("keydown", function(e){
		if(e.keyCode == 13){
			getWorkDanIpgoDataList();
		}
	});
	
	$(".select-button").on("click", function(){
		getWorkDataList();
	});
	
	//함수
	function workHIpgoDataBarcodeScan(){
		alert("기능구현 예정");
		return false;
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
		} 
	}
	
	//작업선택 모달
	function workSelectModalOpen(){		
		workSelectModal.style.display = 'block'; // 모달 숨김
	}
	function workSelectModalClose(){		
		workSelectModal.style.display = 'none'; // 모달 숨김
	}
	
	//단취작업 모달
	function workDanModalOpen(){
		$("#workDanForm")[0].reset();
		
		var now = new Date();
		var ye = now.getFullYear();
		var mo = paddingZero(now.getMonth()+1);
		var da = paddingZero(now.getDate());
		
		var ho = paddingZero(now.getHours());
		var mi = paddingZero(now.getMinutes());		
		
		var setDateTime = ye+"-"+mo+"-"+da+" "+ho+":"+mi;
		
		$("#workDanForm input[name='ilbo_strt']").val(setDateTime);
		$("#workDanForm input[name='ilbo_end']").val(setDateTime);
		
		workSelectModalClose();
		getWorkDanData();
		getWorkDanDataUserCode();
		workDanModal.style.display = 'block'; // 모달 숨김
	}	
	function workDanModalClose(){		
		workDanModal.style.display = 'none'; // 모달 숨김
	}
	
	//단취작업 입고이력 모달
	function workDanIpgoModalOpen(){
		$("#workDanIpgoForm")[0].reset();
		getWorkDanIpgoData();
		getWorkDanIpgoDataList();
		workDanIpgoModal.style.display = 'block'; // 모달 숨김
	}
	function workDanIpgoModalClose(){
		workDanIpgoModal.style.display = 'none'; // 모달 숨김
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
		
		$.ajax({
			url:"/tkheat/production/workInstructionTk/allList",
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
		    height:"700px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    headerSort:false,
		    ajaxResponse:function(url, params, response){
				$("#workTabu .tabulator-col.tabulator-sortable").css("height","30px");
		        return response; //return the response data to tabulator
		    },
		    columns:[	    	
		        {title:"수주번호", field:"ord_code", sorter:"string", width:80,
			        hozAlign:"center"},	
		        {title:"입고일", field:"ord_input_view", sorter:"string", width:80,
			        hozAlign:"center"},	
		        {title:"작업구분", field:"ilbo_gubn", sorter:"string", width:80,
		        	hozAlign:"center"},		        
		        {title:"작업코드", field:"ilbo_code", sorter:"string", width:80,
		        	hozAlign:"center"},
		        {title:"작업LOT", field:"ilbo_lot", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"작업시작", field:"ilbo_strt", sorter:"string", width:120,
		        	hozAlign:"center"},
		        {title:"작업종료", field:"ilbo_end", sorter:"string", width:120,
		        	hozAlign:"center"},
		        {title:"작업수량", field:"ilbo_su", sorter:"string", width:80,
		        	hozAlign:"center"},
		        {title:"작업중량", field:"ilbo_jung", sorter:"string", width:80,
		        	hozAlign:"center"},
		        {title:"업체명", field:"corp_name", sorter:"string", width:140,
			        hozAlign:"center"},	
		        {title:"품명", field:"prod_name", sorter:"string", width:220,
			        hozAlign:"center"},	
		        {title:"품번", field:"prod_no", sorter:"string", width:140,
			        hozAlign:"center"},
		        {title:"소입경도", field:"prod_pg", sorter:"string", width:120,
			        hozAlign:"center"},
			    {title:"경화깊이", field:"prod_gd", sorter:"string", width:120},
			    {title:"제품코드", field:"prod_code", visible:false},
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowClick:function(e, row){

				$("#workTabu .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#workTabu div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});
			}
		});		

	}
	
	//작업지시(단취) - 선택한 입고이력
	var workDanDataTable;	
	function getWorkDanData(){
		
		workDanDataTable = new Tabulator("#workDanTabu", {
			index:"id",
		    height:"140px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    headerSort:false,
		    ajaxResponse:function(url, params, response){
				$("#workDanTabu .tabulator-col.tabulator-sortable").css("height","30px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		    	//행 삭제
				{	headerSort:false,
		    		formatter:rowDeleteBtn, width:100, title:"",
		    		cellClick:function(e, cell){
		    			
		    			var setCount = 0;
		    			var totalCount = $("input[name='danch_total_cnt']").val();
		    			setCount = totalCount - (cell.getRow().getData().ilbo_su);
		    			$("input[name='danch_total_cnt']").val(setCount);

		    			cell.getRow().delete();
	    			}
				},		    	
		        {title:"바코드", field:"ord_code", sorter:"string", width:120,
			        hozAlign:"center"},	
		        {title:"입고일", field:"ord_input_view", sorter:"string", width:120,
			        hozAlign:"center"},	
		        {title:"수량", field:"ilbo_su", sorter:"string", width:80,
		        	hozAlign:"center"},		        
		        {title:"중량", field:"ilbo_jung", sorter:"string", width:80,
		        	hozAlign:"center"},
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"center"},
		        {title:"품명", field:"prod_name", sorter:"string", width:280,
			        hozAlign:"center"},	
		        {title:"품번", field:"prod_no", sorter:"string", width:160,
			        hozAlign:"center"},
		        {title:"소입경도", field:"prod_pg", sorter:"string", width:120,
			        hozAlign:"center"},
			    {title:"경화깊이", field:"prod_gd", width:120},
			    {title:"제품코드", field:"prod_code", visible:false},
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowClick:function(e, row){

				$("#workDanTabu .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#workDanTabu div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});
			}
		});		
		
	}
	
	//단취작업 등록 팝업창 작업자이력
	function getWorkDanDataUserCode(){
//		user_code
		$.ajax({
			url:"/tkheat/production/workInstructionTk/dan/ipgoList/userList",
			type:"post",
			dataType:"json",
			data:{},
			success:function(result){
				console.log(result);
				
				var data = result.data;
				var _option = "";
				for(var i=0; i<data.length; i++){
					_option += "<option value='"+data[i].user_code+"'>"+data[i].user_name+"</option>";
				}
				
				$("select[name='user_code']").append(_option);
			}
		})
	}
	
	//작업지시(단취) - 입고이력
	var workDanIpgoDataTable;
	function getWorkDanIpgoData(){
		
		workDanIpgoDataTable = new Tabulator("#workDanIpgoTabu", {
			index:"id",
		    height:"600px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    headerSort:false,
		    ajaxResponse:function(url, params, response){
				$("#workDanIpgoTabu .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"수주번호", field:"ord_code", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"입고일", field:"ord_input_view", sorter:"string", width:120,
			        hozAlign:"center"},	
		        {title:"거래처", field:"corp_name", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"품명", field:"prod_name", sorter:"string", width:220,
		        	hozAlign:"center"},
		        {title:"품번", field:"prod_no", sorter:"string", width:160,
		        	hozAlign:"center"},
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
			    {title:"소입경도", field:"prod_pg", width:80, visible:false},
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
				row.getElement().style.backgroundColor = "#FFFFFF";
			},
			rowClick:function(e, row){

				$("#workDanIpgoTabu .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#workDanIpgoTabu div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});
			},
			rowDblClick:function(e, row){
				
				var rData = row.getData();
				workDanIpgoSelectData = rData;
				workDanIpgoSelectDataReg();

//테스트
//				workDanDataTable.addData(workDanIpgoSelectData);
						
			}
		});		
	}
	
	//단취작업 저장
	function workDanModalSave(){
		//단취모달 리스트 데이터 조회
		var danchSettingDataList = JSON.stringify(workDanDataTable.getData());
		
		var formObj = {
				"user_code":$("select[name='user_code']").val(),
				"ilbo_strt":$("input[name='ilbo_strt']").val().replace("T"," ")+":00",
				"ilbo_end":$("input[name='ilbo_end']").val().replace("T"," ")+":00"
		}
		
		var formObjParam = JSON.stringify(formObj);
		
//		console.log($("input[name='ilbo_strt']").val().replace("T"," ")+":00");
//		console.log($("input[name='ilbo_end']").val().replace("T"," ")+":00");
		
		$.ajax({
			url:"/tkheat/production/workInstructionTk/dan/dataSave",
			type:"post",
			dataType:"json",
			traditional: true,
			data:{
				"danchSettingDataList":danchSettingDataList,
				"formObjParam":formObjParam
			},
			success:function(result){
				console.log(result);
				
				//모달 닫기
				workDanModalClose();				
				//전체이력 조회
				getWorkDataList();
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
		if($("input[name='danch_sunip_chk']").is(":checked")){
			danch_sunip_chk_val = 1;
		}

		var stdObj = {
			"danch_total_cnt":$("input[name='danch_total_cnt']").val(),
			"danch_std_cnt":$("input[name='danch_std_cnt']").val(),
			"danch_sunip_chk":danch_sunip_chk_val,
			"danch_sunip_chk_pw":$("input[name='danch_sunip_chk_pw']").val(),
		};
		
		
		var stdObjParam = JSON.stringify(stdObj);
		
		$.ajax({
			url:"/tkheat/production/workInstructionTk/dan/ipgoList/dataSetting",
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
					}
					
					var selectOrdCode = result.selectOrdCode;
					
					workDanIpgoDataTable.getRows().forEach(row => {
						  if (row.getData().ord_code === selectOrdCode) {
						    row.delete();
						  }
					});
					
					
				}else{
					alert(result.alert);
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
				"dan_ipgo_pno":$("#dan_ipgo_pno").val()	
		};
		
		var searchObjParam = JSON.stringify(searchObj);
		
		$.ajax({
			url:"/tkheat/production/workInstructionTk/dan/ipgoList",
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
	
	//모달기능
	const workSelectModal = document.querySelector('.workSelectModal');
	const workDanModal = document.querySelector('.workDanModal');
	const workDanIpgoModal = document.querySelector('.workDanIpgoModal');
	
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
