<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수입검사</title>
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
.suipModal {
	position: fixed; /* 화면에 고정 */
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 1000; /* 다른 요소 위에 표시 */
}

.header {
	display: flex; /* 플렉스 박스 사용 */
	justify-content: center; /* 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
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
.detail {
	background: #ffffff;
	border: 1px solid #000000;
	width: 800px; /* 가로 길이 고정 */
	height: 550px; /* 세로 길이 고정 */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
	padding: 20px;
	border-radius: 5px; /* 모서리 둥글게 */
	overflow-y: auto; /* 세로 스크롤 추가 */
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
        <button class="select-button" onclick="getSuipList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
        <button class="insert-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
         입력 
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
        엑셀    
        </button>
        <button class="printer-button">
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
	    
	    
	    <form method="post" name="suipForm" id="suipForm">	
	    	<div class="suipModal">
			<div id="detail">
				<div class="header">
				수입검사
			</div>
				
				
				
				<!-- Article List -->
				<div class="detail">								
					<table cellspacing="0" cellpadding="0" width="100%">
						<colgroup>
							<col width="60%" />
							<col width="40%" />
						</colgroup>
						<tr>
							<td class="" style="width: 100%;">
								
								<div class="subTitle">
									<div class="h3">입고정보</div>
								</div>
								
								<div class="searchOption">
								<table cellspacing="0" cellpadding="0" id="">
								<tr>
									<th class="">검사일</th>
									<td class=""><input id="itst_date" class="date" type="date" style="width:100px;"  maxlength="20" size="20" name="itst_date" /></td>
									<input type="hidden" name="corp_code" id="corp_code"/>
									<input type="hidden" name="corp_name" id="corp_name"/>
									<th class="">최종판정</th>
									<td class="">
										<select id="itst_wp" name="itst_wp" class="basic">
									<option selected>합격</option>
									<option >불합격</option>
									<option >부적합</option>
									<option >보류</option>
									<option >검사대기</option>
								</select>
							</td>
						</tr>
					</table>
				</div>
								
								<table cellspacing="0" cellpadding="0" width="100%" class="">									
									<tr>
										<th class="">거래처</th>
										<td class=""><input id="corp_code" name="corp_code" class="basic" type="text" style="width:100%;" value="(주)동양" /></td>
										<th class="">품번</th>
										<td class=""><input id="prod_no" name="prod_no" class="basic" type="text" style="width:100%;" value="MHB0143-R0-60" /></td>
										</tr>
									<tr>
										<th class="">품명</th>
										<td class=""><input id="prod_name" name="prod_name" class="basic" type="text" style="width:100%;" value="M5ZR1 허브1&2단" /></td>
										<th class="">재질</th>
										<td class=""><input id="prod_jai" name="prod_jai" class="basic" type="text" style="width:100%;" value="SCR420" /></td>
										</tr>
									<tr>
										<th class="">입고량</th>
										<td class=""><input id="ord_su" name="ord_su" class="basic" type="text" style="width:100%;" value="369" /></td>
										<th class="">입고LOT</th>
										<td class=""><input id="ord_lot" name="ord_lot" class="basic" type="text" style="width:100%;" value="" /></td>
									</tr>
								</table>
								
								<div class="subTitle">
									<div class="h3">검사내용</div>
								</div>
								
								<table cellspacing="0" cellpadding="0" width="100%" class="">									
									<tr>
										<th class="">외관</th>
										<td class="">
											<input id="itst_wn" name="itst_wn" class="basic" type="text" style="width:100px;" value="외관" />
											<input id="itst_ws" name="itst_ws" class="basic" type="text" style="width:100px;" value="녹없을것" />
											<select id="itst_w1" name="itst_w1" class="basic" style="width:58px;"><option selected>OK</option><option >NG</option></select>
											<select id="itst_w2" name="itst_w2" class="basic" style="width:58px;"><option selected>OK</option><option >NG</option></select>
											<select id="itst_w3" name="itst_w3" class="basic" style="width:58px;"><option selected>OK</option><option >NG</option></select>
											<select id="itst_w4" name="itst_w4" class="basic" style="width:58px;"><option selected>OK</option><option >NG</option></select>
											<select id="itst_w5" name="itst_w5" class="basic" style="width:58px;"><option selected>OK</option><option >NG</option></select>
										</td>
										
									</tr>
                                    <tr>
										<th class="">외관</th>
										<td class="">
											<input id="itst_05n" name="itst_05n" class="basic" type="text" style="width:100px;" value="가공칩" />
											<input id="itst_05s" name="itst_05s" class="basic" type="text" style="width:100px;" value="가공칩없을것" />
											<input id="itst_051" name="itst_051" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_052" name="itst_052" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_053" name="itst_053" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_054" name="itst_054" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_055" name="itst_055" class="basic" type="text" style="width:50px;" value="OK" />
										</td>
									</tr>
                                    <tr>
										<th class="">외관</th>
										<td class="">
											<input id="itst_03n" name="itst_03n" class="basic" type="text" style="width:100px;" value="이물질" />
											<input id="itst_03s" name="itst_03s" class="basic" type="text" style="width:100px;" value="이물질없을것" />
											<input id="itst_031" name="itst_031" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_032" name="itst_032" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_033" name="itst_033" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_034" name="itst_034" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_035" name="itst_035" class="basic" type="text" style="width:50px;" value="OK" />
										</td>
									</tr>
									<tr>
										<th class="">외관</th>
										<td class="">
											<input id="itst_01n" name="itst_01n" class="basic" type="text" style="width:100px;" value="찍힘" />
											<input id="itst_01s" name="itst_01s" class="basic" type="text" style="width:100px;" value="찍힘없을것" />
											<input id="itst_011" name="itst_011" class="basic startOK" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_012" name="itst_012" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_013" name="itst_013" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_014" name="itst_014" class="basic" type="text" style="width:50px;" value="OK" /> 
											<input id="itst_015" name="itst_015" class="basic" type="text" style="width:50px;" value="OK" />
										</td>
									</tr>								
									<tr>
										<th class="">치수1</th>
										<td class="">
											<input id="itst_06n" name="itst_06n" class="basic min" type="text" style="width:100px;" value="" />
											<input id="itst_06s" name="itst_06s" class="basic max" type="text" style="width:100px;" value="" />
											<input id="itst_061" name="itst_061" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_062" name="itst_062" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_063" name="itst_063" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_064" name="itst_064" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_065" name="itst_065" class="basic chisuInput" type="text" style="width:50px;" value="" />
										</td>
									</tr>
									<tr>
										<th class="">치수2</th>
										<td class="">
											<input id="itst_07n" name="itst_07n" class="basic min" type="text" style="width:100px;" value="" />
											<input id="itst_07s" name="itst_07s" class="basic max" type="text" style="width:100px;" value="" />
											<input id="itst_07s" name="itst_071" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_072" name="itst_072" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_073" name="itst_073" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_074" name="itst_074" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_075" name="itst_075" class="basic chisuInput" type="text" style="width:50px;" value="" />
										</td>
									</tr>
									<tr>
										<th class="">치수3</th>
										<td class="">
											<input id="itst_08n" name="itst_08n" class="basic min" type="text" style="width:100px;" value="" />
											<input id="itst_08s" name="itst_08s" class="basic max" type="text" style="width:100px;" value="" />
											<input id="itst_081" name="itst_081" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_082" name="itst_082" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_083" name="itst_083" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_084" name="itst_084" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_085" name="itst_085" class="basic chisuInput" type="text" style="width:50px;" value="" />
										</td>
									</tr>
                                    <tr>
										<th class="">치수4</th>
										<td class="">
											<input id="itst_04n" name="itst_04n" class="basic min" type="text" style="width:100px;" value="" />
											<input id="itst_04s" name="itst_04s" class="basic max" type="text" style="width:100px;" value="" />
											<input id="itst_041" name="itst_041" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_042" name="itst_042" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_043" name="itst_043" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_044" name="itst_044" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_045" name="itst_045" class="basic chisuInput" type="text" style="width:50px;" value="" />
										</td>
									</tr>
                                    <tr>
										<th class="">치수5</th>
										<td class="">
											<input id="itst_02n" name="itst_02n" class="basic min" type="text" style="width:100px;" value="" />
											<input id="itst_02s" name="itst_02s" class="basic max" type="text" style="width:100px;" value="" />
											<input id="itst_021" name="itst_021" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_022" name="itst_022" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_023" name="itst_023" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_024" name="itst_024" class="basic chisuInput" type="text" style="width:50px;" value="" />
											<input id="itst_025" name="itst_025" class="basic chisuInput" type="text" style="width:50px;" value="" />
										</td>
									</tr>
								</table>
								
								<div class="subTitle">
									<div class="h3">검사정보</div>
								</div>
								<table cellspacing="0" cellpadding="0" width="100%" class="">									
									<tr>
										<th class="">검사자</th>
										<td class="">
											
											<input id="itst_p" name="itst_p" class="basic" type="text" style="width:100%;" value="최균홍" />
										</td>
										<th class="">비고</th>
										<td class=""><input id="itst_bigo" name="itst_bigo" class="basic" type="text" style="width:100%;" value="" /></td>
									</tr>
									<tr>
										<th class="">샘플수</th>
										<td class=""><input id="itst_su" name="itst_su" class="basic" type="text" style="width:100%;" value="5EA"/></td>
										<th class="">검사내역</th>
										<td class=""><input id="itst_test" name="itst_test" class="basic" type="text" style="width:100%;" value="" /></td>
									</tr>
									<tr>
										<th class="">불량수</th>
										<td class=""><input id="itst_poor" name="itst_poor" class="basic" type="text" style="width:100%;" value=""/></td>
										<td class=""></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<div class="btnSaveClose">
                	 <button class="delete" type="button" onclick="();"  style="display: none;">삭제</button>
					 <button class="save" type="button" onclick="save();">저장</button>
					 <button class="close" type="button" onclick="window.close();">닫기</button>
    	  		</div>
				</div>
				
			</div>
			</div>
			</form>
	    
<script>
	//전역변수
    var cutumTable;	

	//로드
	$(function(){
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		getSuipList();
	});

	//이벤트
	//함수
	function getSuipList(){
		
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
		    ajaxURL:"/tkheat/quality/suip/getSuipList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
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
		        {title:"검사일", field:"itst_date", sorter:"string", width:120,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"입고일", field:"ord_date", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},     
				{title:"거래처", field:"corp_name", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"}, 
				    {title:"거래처", field:"corp_code", sorter:"string", width:120,
					    hozAlign:"center", headerFilter:"input",visible:false},     
				{title:"품명", field:"prod_name", sorter:"string", width:150,
				    hozAlign:"center", headerFilter:"input"}, 
		        {title:"품번", field:"prod_no", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},		        
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"재질", field:"prod_jai", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"불량수", field:"itst_poor", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input"},	
			        { 
			        	  title:"판정", 
			        	  field:"itst_wp", 
			        	  sorter:"string", 
			        	  width:100, 
			        	  hozAlign:"center", 
			        	  headerFilter:"input",
			        	  formatter:function(cell, formatterParams, onRendered){
			        	    const value = cell.getValue();
			        	    const el = cell.getElement();

			        	    if(value === "합격"){
			        	      el.style.backgroundColor = "#a3d8f4";  // 연한 파란색
			        	    } else if(value === "불합격"){
			        	      el.style.backgroundColor = "#f4a3a3";  // 연한 빨간색
			        	    } else {
			        	      el.style.backgroundColor = ""; // 기본
			        	    }
			        	    return value;
			        	  }
			        	},
				    
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
			rowDblClick:function(e, row){

				var data = row.getData();
				selectedRowData = data;
				isEditMode = true;
				console.log(selectedRowData.itst_code)
				$('#suipForm')[0].reset();

				/* Object.keys(data).forEach(function (key) {
			        const field = $('#begaInsertForm [name="' + key + '"]');

			        if (field.length) {
			            field.val(data[key]);
			        }
				}); */
				suipDetail(data.itst_code);
				 $('.delete').show();
			},
		});		
	}


	function suipDetail(itst_code){
		$.ajax({
			url:"/tkheat/quality/suip/suipDetail",
			type:"post",
			dataType:"json",
			data:{
				"itst_code":itst_code
			},
			success:function(result){
				var allData = result.data;
				
				for(let key in allData){
					const lowerKey = key.toLowerCase();

					
					if(lowerKey === 'itst_date'){
						const formattedDate = allData[key]?.replace(/[./]/g, '-').substring(0,10);
						$("#suipForm [name='itst_date']").val(formattedDate);
						continue;
					}

					$("#suipForm [name='"+lowerKey+"']").val(allData[key]);
				}

				$('.suipModal').show().addClass('show');
			}
		});
	}


	 function save() {
		    var formData = new FormData($("#suipForm")[0]);

		    let confirmMsg = "";

		    if (isEditMode && selectedRowData && selectedRowData.itst_code) {
		        formData.append("mode", "update");
		        formData.append("itst_code", selectedRowData.itst_code);
		        confirmMsg = "수정하시겠습니까?";
		    } else {
		        formData.append("mode", "insert");
		        confirmMsg = "저장하시겠습니까?";
		    }

		    if (!confirm(confirmMsg)) {
		        return;
		    }

		    $.ajax({
		        url: "/tkheat/quality/suip/suipSave",
		        type: "POST",
		        data: formData,
		        contentType: false,
		        processData: false,
		        dataType: "json",
		        success: function(result) {
		            alert("저장 되었습니다.");
		            $(".suipModal").hide();
		            getSuipList();
		        },
		        error: function(xhr, status, error) {
		            console.error("저장 오류:", error);
		        }
		    });
		}
	
	
	


	// 드래그 기능 추가
	const modal = document.querySelector('.suipModal');
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
	const suipModal = document.querySelector('.suipModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');
	
	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#suipForm')[0].reset(); // 폼 초기화
	    suipModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
	});

	closeButton.addEventListener('click', function() {
		suipModal.style.display = 'none'; // 모달 숨김
	});

	headerCloseButton.addEventListener('click', function() {
		suipModal.style.display = 'none';
	});

    </script>

	</body>
</html>
