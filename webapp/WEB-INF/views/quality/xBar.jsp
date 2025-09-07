<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>거래처등록</title>
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
.xbarModal {
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
    
    
    </style>
    
    
    <body>
    
    <div class="tab">
    
    <div class="button-container">
        <button class="select-button">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
        <button class="insert-button">
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
	    
	 <div class="xbarModal">   
	  <form name="searchForm" target="_self" method="post" action="">
			<div id="searchPop">
				<div class="detail">
					<div class="header">
						Xbar-R관리도
					</div>
					<table cellspacing="0" cellpadding="0" width="100%">
						<tr>
							<td class="">
								<div class="subTitle">
									<div style=" position:absolute; width:40px; left:110px;">
										<input type="button" id="" name="" title="검색" class="btnSearchSmall" onclick="MM_openBrWindow('etcSub_popup_06_1','Srch','width=1024,height=720,scrollbars=yes')" style="margin-top:2px;" />
									</div>
									<div class="h3">제품정보</div>
								</div>
								<table cellspacing="0" cellpadding="0" width="100%" class="">
									<tr>
										<th class="">작성일</th>
										<td class="">
											<input type="text" id="ordDate" name="ordDate" value="2025-04-09" class="date js-datepicker" style="width:85px;" readonly="readonly" />
											<input type="button" id="" name="" value="공정능력 계산" class="btnFT2" onclick="xbarCalc();" />
										</td>
									</tr>
									<tr>
										<th class="">거래처</th>
										<td class=""><input id="corpName" class="basic" type="text" style="width:100%;" value="" name="corpName" readonly="readonly"/></td>
										<th class="">품명</th>
										<td class=""><input id="prodName" class="basic" type="text" style="width:100%;" value="" name="prodName" readonly="readonly"/></td>
										<th class="">품번</th>
										<td class=""><input id="prodNo" class="basic" type="text" style="width:100%;" value="" name="prodNo" readonly="readonly"/></td>
									</tr>
									<tr>
										<th class="">규격</th>
										<td class="">
											<input id="prodGyu" class="basic" type="text" style="width:100%;" value="" name="prodGyu" readonly="readonly"/>
											<input id="prodE1" class="basic hidden" type="text" style="width:100%;" value="" name="prodE1" readonly="readonly"/>
											<input id="prodDanj" name="prodDanj" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
											<input id="prodDang" name="prodDang" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
											<input id="prodCno" name="prodCno" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
											<input id="prodGd1" name="prodGd1" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
											<input id="prodGd2" name="prodGd2" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
											<input id="prodGd3" name="prodGd3" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
											<input id="prodE3" name="prodE3" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
											<input id="prodGD1" name="prodGD1" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
											<input id="prodGD2" name="prodGD2" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
											<input id="prodGD5" name="prodGD5" class="basic hidden" type="text" style="width:100%;" value="" readonly="readonly"/>
										</td>
										<th class="">재질</th>
										<td class=""><input id="prodJai" class="basic" type="text" style="width:100%;" value="" name="prodJai" readonly="readonly"/></td>
										<th class="">공정</th>
										<td class="">
											<input id="techTe" class="basic" type="text" style="width:100%;" value="" name="techTe" readonly="readonly"/>
											<input id="prodPg" class="basic" type="hidden" style="width:100%;" value="" name="prodPg" />
											<input id="prodSg" class="basic" type="hidden" style="width:100%;" value="" name="prodSg" />
											<input id="ProdCd" class="basic" type="hidden" style="width:100%;" value="" name="ProdCd" />
											<input id="prodCode" class="basic" type="hidden" style="width:100%;" value="" name="prodCode" />
										</td>
									</tr>
									<tr>
										<th class="">설비</th>
										<td class="">
											<select id="facCode" name="facCode" class="basic" style="width:190px;">
												<option value="">전체</option>
												
													<option value="고주파 1호기(폐기)">고주파 1호기(폐기)</option>
												
													<option value="고주파 2호기 (폐기)">고주파 2호기 (폐기)</option>
												
													<option value="고주파 5호기">고주파 5호기</option>
												
													<option value="급수시설">급수시설</option>
												
													<option value="변성로 1호기">변성로 1호기</option>
												
													<option value="변성로 2호기">변성로 2호기</option>
												
													<option value="쇼트 1호기">쇼트 1호기</option>
												
													<option value="쇼트 2호기">쇼트 2호기</option>
												
													<option value="쇼트 3호기">쇼트 3호기</option>
												
													<option value="쇼트 4호기">쇼트 4호기</option>
												
													<option value="전기시설">전기시설</option>
												
													<option value="진공세정기 2호기">진공세정기 2호기</option>
												
													<option value="침탄로 1호기">침탄로 1호기</option>
												
													<option value="침탄로 2호기">침탄로 2호기</option>
												
													<option value="침탄로 3호기">침탄로 3호기</option>
												
													<option value="침탄로 4호기">침탄로 4호기</option>
												
													<option value="침탄로 5호기">침탄로 5호기</option>
												
													<option value="콤프레샤">콤프레샤</option>
												
													<option value="템퍼링기 1호기">템퍼링기 1호기</option>
												
													<option value="템퍼링기 2호기">템퍼링기 2호기</option>
												

											</select>
										</td>
										<th class="">기간</th>
										<td class=""><input type="text" id="fromDate" name="fromDate" value="2025-04-09" class="date js-datepicker" style="width:85px;" readonly="readonly" /> ~
											<input type="text" id="toDate" name="toDate" value="2025-04-09" class="date js-datepicker" style="width:85px;" readonly="readonly" /></td>
										<th class="">관리항목</th>
										<td class="">
											<select id="prodGubn" name="prodGubn" class="basic" style="width:150px;" >
												<option>제품 검색 후 선택</option>
												<option>소려경도</option>
												<option>소입경도</option>
												<option>초중종검사</option>
											</select>
										</td>
									</tr>
									<tr>
										<th class="">SL</th>
										<td class=""><input id="SL" class="basic" type="text" style="width:100%;" value="" name="SL" /></td>
										<th class="">SU</th>
										<td class=""><input id="SU" class="basic" type="text" style="width:100%;" value="" name="SU" /></td>
									</tr>
									<tr>
										<th class="">검사일수</th>
										<td class=""><input id="daySu" class="basic" type="text" style="width:100%;" value="25" name="daySu" /></td>
										<th class="">샘플수</th>
										<td class=""><input id="sampleSu" class="basic" type="text" style="width:100%;" value="5" name="sampleSu" /></td>
										<td class=""><input type="button" id="" name="" value="데이터 로딩" class="btnFT" onclick="dataLoading();"/></td>
										<td class=""></td>
									</tr>
								</table>

								<p style="margin-top:4px; padding:4px 0;"></p></td>
						</tr>
					</table>
				</div>

				<div id="tabs">
					<ul>
						<li><a href="#tabs-1">데이터 입력/결과</a></li>
						<li><a href="#tabs-2" onclick="xbarandRCalc();">Xbar-R관리도</a></li>
						<li><a href="#tabs-3" onclick="xbarandRCalc();">추이도</a></li>
					</ul>

					<div id="tabs-1">
						<div class="searchResult">
							<div class="resultAreaXY150" style="height:313px;"></div>
						</div>

						<p style="padding:10px 0"></p>

						<!-- Detail List -->
						<div class="detail">
							<table cellspacing="0" cellpadding="0" width="100%">
								<tr>
									<td class="">
										<table cellspacing="0" cellpadding="0" class="insideTable2" style="width:100%">
											<colgroup span="5">
												<col width="15%" />
												<col width="20%" />
												<col width="20%" />
												<col width="25%" />
												<col width="10%" />
											</colgroup>
											<thead>
											<tr>
												<td scope="col" class="left thSub">상수</td>
												<td scope="col" class="thSub">X 관리도</td>
												<td scope="col" class="thSub">R 관리도</td>
												<td scope="col" class="thSub">공정능력지수</td>
												<td scope="col" class="thSub">평가 / 조치</td>
											</tr>
											</thead>
											<tbody>
											<tr>
												<td valign="top" class="left">
													<table cellspacing="0" cellpadding="0" class="noLineTable">
														<tr>
															<td style="height:10px"><p style="height:2px">_</p><p style="height:-8px">_</p>X = </td>
															<td valign="bottom"><input id="varVarX" class="basic" type="text"  style="width:90px;" value="" name="varVarX" /></td>
														</tr>
														<tr>
															<td><p style="height:15px">_</p>R = </td>
															<td valign="bottom"><input id="varR" class="basic" type="text" style="width:90px;" value="" name="varR" /></td>
														</tr>
													</table>
												</td>
												<td  valign="top">
													<table cellspacing="0" cellpadding="0" class="noLineTable">
														<tr>
															<td><p style="height:2px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_</p>
																<p style="height:-8px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_</p>CL = X = </td>
															<td valign="bottom"><input id="CLX" class="basic" type="text" style="width:90px;;" value="" name="CLX" /></td>
														</tr>
														<tr>
															<td><p style="height:2px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_</p>
																<p style="height:-8px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp_</p>UCL = X + A2R = </td>
															<td valign="bottom"><input id="UCLX" class="basic" type="text" style="width:90px;;" value="" name="UCLX" /></td>
														</tr>
														<tr>
															<td><p style="height:2px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_</p>
																<p style="height:-8px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_</p>LCL = X - A2R = </td>
															<td valign="bottom"><input id="LCLX" class="basic" type="text" style="width:90px;" value="" name="LCLX" /></td>
														</tr>
														<tr>
															<td><p style="height:15px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_</p>
																σ = R / d2 = </td>
															<td valign="bottom"><input id="sigma" class="basic" type="text" style="width:90px;;" value="" name="sigma" /></td>
														</tr>
													</table>
												</td>
												<td valign="top" >
													<table cellspacing="0" cellpadding="0" class="noLineTable">
														<tr>
															<td><p style="height:15px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_</p>
																CL = R = </td>
															<td valign="bottom"><input id="CLR" class="basic" type="text" style="width:90px;;" value="" name="CLR" /></td>
														</tr>
														<tr>
															<td><p style="height:15px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																&nbsp;&nbsp;&nbsp;_</p>
																UCL = X + D4R = </td>
															<td valign="bottom"><input id="UCLR" class="basic" type="text" style="width:90px;;" value="" name="UCLR" /></td>
														</tr>
														<tr>
															<td><p style="height:15px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																&nbsp;&nbsp;_</p>
																LCL = X + D3R = </td>
															<td valign="bottom"><input id="LCLR" class="basic" type="text" style="width:90px;;" value="" name="LCLR" /></td>
														</tr>
													</table>
												</td>
												<td valign="top" >
													<table cellspacing="0" cellpadding="0" class="noLineTable">
														<tr>
															<td>Cp(Pp) = (SU-SL)/6σ = </td>
															<td valign="bottom"><input id="Cp" class="basic" type="text" style="width:90px;;" value="" name="Cp" /></td>
														</tr>
														<tr>
															<td>Cpk(Ppk) = (1-K)XCp = </td>
															<td valign="bottom"><input id="Cpk" class="basic" type="text" style="width:90px;;" value="" name="Cpk" /></td>
														</tr>
														<tr>
															<td>치우침계수 K = 2IM-XI/T = </td>
															<td valign="bottom"><input id="KRate" class="basic" type="text" style="width:90px;;" value="" name="KRate" /></td>
														</tr>
													</table>
												</td>
												<td valign="top"><textarea name="estimate" id="estimate" class="basic" style="width:96%; height:84px;"></textarea></td>
											</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div id="tabs-2">
						<!-- <a>그래프는 준비중입니다.</a> -->
						<canvas id="myChart1" width="950" height="250"></canvas>
						<canvas id="myChart2" width="950" height="250"></canvas>
					</div>
					<div id="tabs-3">
						<canvas id="myChart3" width="950" height="450"></canvas>
					</div>
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
		getCutumList();
	});

	//이벤트
	//함수
	function getCutumList(){
		
		userTable = new Tabulator("#tab1", {
		    height:"750px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    /*		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/management/authority/productList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{},
*/		    placeholder:"조회된 데이터가 없습니다.",
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
		        {title:"공정", field:"tech_te", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"단중", field:"prod_danj", sorter:"int", width:100,
		        	hozAlign:"center"},  	
		        {title:"단위", field:"prod_danw", sorter:"int", width:100,
			        hozAlign:"center"},	
			    {title:"단가(EA)", field:"prod_danw", sorter:"int", width:100,
				    hozAlign:"center"},	
				{title:"단가(kG)", field:"prod_danw", sorter:"int", width:100,
				    hozAlign:"center"},
				{title:"표면경도", field:"prod_danw", sorter:"int", width:100,
					hozAlign:"center"},
			    {title:"경화깊이", field:"prod_danw", sorter:"int", width:100,
					hozAlign:"center"},
 			    {title:"심부경도", field:"prod_danw", sorter:"int", width:100,
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
	const modal = document.querySelector('.xbarModal');
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
	const xbarModal = document.querySelector('.xbarModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		xbarModal.style.display = 'block'; // 모달 표시
	});

	closeButton.addEventListener('click', function() {
		xbarModal.style.display = 'none'; // 모달 숨김
	});
		


    </script>
    
    

	</body>
</html>
