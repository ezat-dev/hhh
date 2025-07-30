<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비등록</title>
    <link rel="stylesheet" href="/tkheat/css/management/facInsert.css">
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

.detail {
	background: #ffffff;
	border: 1px solid #000000;
	width: 1000px; /* 가로 길이 고정 */
	height: 630px; /* 세로 길이 고정 */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
	margin: 20px auto; /* 중앙 정렬 */
	padding: 20px;
	border-radius: 5px; /* 모서리 둥글게 */
	overflow-y: auto; /* 세로 스크롤 추가 */
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

.btnSearchCorp, .btn1T {
	background: #007bff; /* 버튼 배경색 */
	color: white; /* 버튼 글자색 */
	border: none; /* 경계선 없음 */
	padding: 5px 10px; /* 내부 여백 */
	cursor: pointer; /* 커서 변경 */
	border-radius: 3px; /* 모서리 둥글게 */
	margin-top: 5px; /* 위쪽 여백 */
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

.facModal {
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
	margin-bottom: -20px; /* 상단 여백 */
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
th{
	font-size : 14px;
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
        
        
		<!-- <label class="daylabel">설비NO :</label>
		<input type="text" class="fac_no" id="fac_no" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">설비명 :</label>
		<input type="text" class="fac_name" id="fac_name" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">설비현황표 :</label>
		<input type="text" class="" id="" style="font-size: 16px;" autocomplete="off"> -->
			
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getFacList();">
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
	    
	    
	<form method="post" class="corrForm" id="facInsertForm" name="facInsertForm">
			<div class="facModal">
				<div class="header">설비등록
					<span class="header-close">&times;</span>
				</div>
				<div class="detail">
					<table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
						<colgroup span="4">
							<col width="*" />
							<col width="40%" />
							<col width="*" />
							<col width="40%" />
						</colgroup>
						<tr>
							<th class="">설비번호</th>
							<td class="">
								<input id="fac_no" name="fac_no" class="basic" type="text" style="width:90%;" value="" />
							</td>
							<th class="">설비명</th>
							<td class="">
								<input id="fac_name" name="fac_name" class="basic" type="text" style="width:90%;" value="" />
							</td>
						</tr>
						<tr>
							<th class="">규격</th>
							<td class="">
<!-- 								<input id="facGyu" name="facGyu" class="basic" type="text" style="width:100%;" value="" /> -->
								<select id="fac_gyu" name="fac_gyu" class="basic" style="width:90%;">
									<option>가스질화</option>
									<option>이온질화</option>
									<option>침탄</option>
									<option>VC</option>
									<option>PQ</option>
									<option>TEMPERING</option>
									<option>진공</option>
									<option>세척기</option>
									<option>후처리</option>
									<option>기타</option>
								</select>
							</td>
							<th class="">형식</th>
							<td class="">
								<input id="fac_hyun" name="fac_hyun" class="basic" type="text" style="width:90%;" value="" />
							</td>
						</tr>
						<tr>
							<th class="">용도</th>
							<td class="">
								<input id="fac_yong" name="fac_yong" class="basic" type="text" style="width:90%;" value="" />
							</td>
							<th class="">설비종류</th>
							<td class="">
								<select id="tech_no" name="tech_no" class="basic">									
									
										<option value="A08">PIT로(A08)</option>
									
										<option value="A11">PIT로(A11)</option>
									
										<option value="A12">PIT로(A12)</option>
									
										<option value="A13">PIT로(A13)</option>
									
										<option value="A14">PIT로(A14)</option>
									
										<option value="A15">PIT로(A15)</option>
									
										<option value="A16">Box Type(A16)</option>
									
										<option value="A17">Box Type(A17)</option>
									
										<option value="A18">Box Type(A18)</option>
									
										<option value="A20">Box Type(A20)</option>
									
										<option value="A21">Box Type(A21)</option>
									
										<option value="A27">이온질화(A27)</option>
									
										<option value="A30">Salt로(A30)</option>
									
										<option value="A31">Box Type(A31)</option>
									
										<option value="A32">PIT로(A32)</option>
									
										<option value="A33">Box Type(A33)</option>
									
										<option value="A34">Box Type(A34)</option>
									
										<option value="A35">PIT로(A35)</option>
									
										<option value="B16">템퍼링로(B16)</option>
									
										<option value="B17">템퍼링로(B17)</option>
									
										<option value="B38">진공로(B38)</option>
									
										<option value="B39">이온질화(B39)</option>
									
										<option value="B40">진공로(B40)</option>
									
										<option value="B41">진공로(B41)</option>
									
										<option value="B42">진공로(B42)</option>
									
										<option value="C01">PQ(C01)</option>
									
										<option value="C02">PQ(C02)</option>
									
										<option value="C03">PQ(C03)</option>
									
								</select>
							</td>
						</tr>
						<tr>
							<th class="">관리자(정)</th>
							<td class="">
								<input id="fac_man1" name="fac_man1" class="basic" type="text" style="width:90%;" value="" />
							</td>
							<th class="">관리자(부)</th>
							<td class="">
								<input id="fac_man2" name="fac_man2" class="basic" type="text" style="width:90%;" value="" />
							</td>
						</tr>
						<tr>
							<th class="">사용부서</th>
							<td class="">
								<input id="fac_lot" name="fac_lot" class="basic" type="text" style="width:90%;" value="" />
							</td>
							<th class="">제조번호</th>
							<td class="">
								<input id="fac_e1" name="fac_e1" class="basic" type="text" style="width:90%;" value="" />
							</td>
						</tr>
						<tr>
							<th class="">설치장소</th>
							<td colspan="3" class="">
								<input id="fac_plc" name="fac_plc" class="basic" type="text" style="width:90%;" value="" />
							</td>
						</tr>
					</table>
													
					<p style="margin-top:4px; padding:4px 0; border-top:1px solid #bbb;">
								
					<table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
						<tr>
							<td class="leftSide">
								<table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
									<tr>
										<th class="">제조사국적</th>
										<td class="">
											<input id="fac_e2" name="fac_e2" class="basic" type="text" style="width:90%;" value=""/>
										</td>
										<th class="">제조회사</th>
										<td class="">
											<input id="fac_make" name="fac_make" class="basic" type="text" style="width:90%;" value=""/>
										</td>
									</tr>
									<tr>
										<th class="">구입처</th>
										<td class="">
											<input id="fac_cBuy" name="fac_cBuy" class="basic" type="text" style="width:90%;" value=""/>
										</td>
										<th class="">유지보수업체</th>
										<td class="">
											<input id="fac_e3" name="fac_e3" class="basic" type="text" style="width:90%;" value=""/>
										</td>
									</tr>
									<tr>
										<th class="">도입시기</th>
										<td class="">
											<input id="fac_buy" class="date js-datepicker" type="text" style="width:100px;"  maxlength="20" size="20" name="fac_buy" />
										</td>
										<th class="">제조일자</th>
										<td class="">
											<input id="fac_mday" class="date js-datepicker" type="text" style="width:100px;"  maxlength="20" size="20" name="fac_mday" />
										</td>
									</tr>
									<tr>
										<th class="">구입가격</th>
										<td class="">
											<input id="fac_mon" name="fac_mon" class="basic" type="text" style="width:90;" value="0"/> 만원</td>
										<th class="">실적및현황 출력</th>
										<td class="">
										 <input type="checkbox" id="fac_dan" name="fac_dan" checked="checked" class="">
										</td>
									</tr>
									<tr>
										<td class=""></td>
										<td class=""></td>
										<td class=""></td>
										<td class=""></td>
									</tr>
								</table>
								
								<p style="margin-top:4px; padding:4px 0; border-top:1px solid #bbb;">
								<table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
									<tr>
										<th class="">처리용량</th>
										<td colspan="3" class="">
											<input id="fac_able" name="fac_able" class="basic" type="text" style="width:90%;" value=""/>
										</td>
										</tr>
									<tr>
										<th class="">가동기준시간</th>
										<td class="">
											<input id="fac_time" name="fac_time" class="basic" type="text" style="width:90%;" value=""/>
										</td>
										<th class="">점검주기</th>
										<td class="">
											<input id="fac_test" name="fac_test" class="basic" type="text" style="width:90%;" value=""/>
										</td>
									</tr>
									<tr>
										<td class=""></td>
										<td class=""></td>
										<td class=""></td>
										<td class=""></td>
									</tr>
								</table>
								
								<p style="margin-top:4px; padding:4px 0; border-top:1px solid #bbb;">
								
								<table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
									<tr>
										<th class="">주변설비 및<br />관련사항</th>
										<td class="">
											<textarea id="fac_e4" name="fac_e4" class="basic" style="width:90%;"></textarea></td>
									</tr>
									<tr>
										<th class="">비고</th>
										<td class="">
											<textarea id="fac_bigo" name="fac_bigo" class="basic" style="width:90%;"></textarea></td>
									</tr>
									<tr>
										<th class="left">설비점검주의사항</td>
										<td class=""><textarea id="fac_cau" name="fac_cau" class="basic" style="width:90%;  height: 70px;"></textarea></td>
									</tr>
								</table>
							</td>
							<td class="rightSide">
								<table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
									<tr>
										<th class="">이미지</th>
										<td class="findImage">
											<input type="hidden" name="type" value="facility" />
											<input id="imgInput0" class="imgInputClass" type="file" name="fac_file_url" title="이미지 찾기" onchange="previewImage(this,'previewId')">
											<div class="imgArea" id='previewId' style="height:200px;border:1px solid #ddd;">
												<img id="img0" src="/resources/images/noimage_01.gif" width="100%" height="100%" />
											</div>
										</td>
									</tr>
								</table>
									<table cellspacing="0" cellpadding="0" width="100%" class="popFieldTable2">
										<colgroup span="3">
											<col width="" />
											<col width="" />
										</colgroup>
										<tr>
											<th class="left" style="height: 70px;">특이사항</th>
											<td class=""><textarea id="fac_unus" name="fac_unus" class="basic" style="width:90%;  height: 70px;"></textarea></td>
										</tr>
									</table>
							</td>
						</tr>
					</table>
					<div class="btnSaveClose">
					<button class="delete" type="button" onclick="deleteFac();"  style="display: none;">삭제</button>
		            <button class="save" type="button" onclick="save();">저장</button>
		            <button class="close" type="button" onclick="window.close();">닫기</button>
	    			</div>
				</div>
				
				</div>
			</form>
	    
	    
	    
	    
	    
<script>
	//전역변수
    var cutumTable;	
    var isEditMode = false; //수정,최초저장 구분값

	//로드
	$(function(){
		//전체 거래처목록 조회
		getFacList();
	});

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

	//이벤트
	//함수
	function getFacList(){
		
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
		    ajaxURL:"/tkheat/management/facInsert/getFacList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"fac_no": $("#fac_no").val(),
                "fac_name": $("#fac_name").val(),
                "fac_code":"",
			    },
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"fac_code", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"설비NO", field:"fac_no", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"설비명", field:"fac_name", sorter:"string", width:150,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"규격", field:"fac_gyu", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"형식", field:"fac_hyun", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"용도", field:"fac_yong", sorter:"int", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"설치장소", field:"fac_plc", sorter:"int", width:200,
			        hozAlign:"center", headerFilter:"input"},
			    {title:"능력", field:"fac_able", sorter:"int", width:120,
				    hozAlign:"center", headerFilter:"input"},
				{title:"제작사", field:"fac_make", sorter:"int", width:150,
					hozAlign:"center", headerFilter:"input"},
				{title:"구매처", field:"fac_cbuy", sorter:"int", width:100,
					hozAlign:"center", headerFilter:"input"},   
					{title:"이미지", field:"fac_file_name", width:100,
						hozAlign:"center", formatter:"image",
					    cssClass:"rp-img-popup",
				      	formatterParams:{
					      	height:"30px", width:"30px",
					      	urlPrefix:"/excelTest/태경출력파일/사진/설비등록/"
					      	},   
						    cellMouseEnter:function(e, cell){ productImage(cell.getValue());} 
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
				$('#facInsertForm')[0].reset();
				

				/* Object.keys(data).forEach(function (key) {
			        const field = $('[name="' + key + '"]');

			        if (field.length) {
			            field.val(data[key]);
			        }
				}); */
				facInsertDetail(data.fac_code);	

				 $('.delete').show();
			},
			
		});		
	}

	function facInsertDetail(fac_code){
		$.ajax({
			url:"/tkheat/management/facInsert/facInsertDetail",
			type:"post",
			dataType:"json",
			data:{
				"fac_code":fac_code
			},
			success:function(result){
//				console.log(result);
				var allData = result.data;
				
				for(let key in allData){
//					console.log(allData, key);	
					$("#facInsertForm [name='"+key+"']").val(allData[key]);
				}

				// 이미지 초기화
				$("#img0").attr("src", "/resources/images/noimage_01.gif");

				// 이미지
				if (allData.fac_file_name) {
					console.log("원본 파일명:", allData.fac_file_name);
					console.log("인코딩된 경로:", encodeURIComponent(allData.fac_file_name));
					const path = "/excelTest/태경출력파일/사진/설비등록/" + allData.fac_file_name;
					console.log("path: ", path);
					$("#img0").attr("src", path);
					//$(".aphoto").attr("href", path).text(d.product_file_name);
				}

				$('.facModal').show().addClass('show');
			}
		});
	}


	


	// 드래그 기능 추가
	const modal = document.querySelector('.facModal');
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
	const facModal = document.querySelector('.facModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');

	
	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#facInsertForm')[0].reset(); // 폼 초기화
		facModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
	});

	closeButton.addEventListener('click', function() {
	    facModal.style.display = 'none'; // 모달 숨김
	});

	headerCloseButton.addEventListener('click', function() {
		facModal.style.display = 'none';
	});

	
	
	// 저장 and 수정
	function save() {
	    var formData = new FormData($("#facInsertForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.fac_code) {
	        formData.append("mode", "update");
	        formData.append("fac_code", selectedRowData.fac_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/facInsert/facInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	            alert("저장 되었습니다.");
	            $(".facModal").hide();
	            getFacList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}


	function deleteFac() {
	    if (!selectedRowData || !selectedRowData.fac_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/facInsert/facDelete",
	        type: "POST",
	        data: {
	        	fac_code: selectedRowData.fac_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".facModal").hide();
	                getFacList();
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
	    const filename = "설비등록_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "설비등록" });
	});


	
    </script>

	</body>
</html>
