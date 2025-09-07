<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>출고관리</title>
<link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
<link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp"%>
<style>
.main {
	width: 98%;
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

.row_select {
	background-color: #9ABCEA !important;
}


.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -760px;
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

.chulgoModal {
	position: fixed; /* 화면에 고정 */
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 20010; /* 다른 요소 위에 표시 */
	border:2px solid black;
	background-color:white;
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
        
        
		<label class="daylabel">일자 : </label>
		<input type="date" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off"> ~ 
		<input type="date" class="edate" id="edate" style="font-size: 16px;" autocomplete="off">
		
		<label class="daylabel">제품구분 : </label>
		<input type="text" class="prod_gubn" id="prod_gubn" style="font-size: 16px; autocomplete="off">
			
	</div>

		<div class="button-container">
			<button class="select-button" onclick="getChulgoList();">
				<img src="/tkheat/css/image/search-icon.png" alt="select"
					class="button-image">
				조회
			</button>
			<button class="insert-button">
				<img src="/tkheat/css/image/insert-icon.png" alt="insert"
					class="button-image">
					입력
			</button>
			<button class="excel-button">
				<img src="/tkheat/css/image/excel-icon.png" alt="excel"
					class="button-image">
					엑셀
			</button>
			<button class="printer-button">
				<img src="/tkheat/css/image/printer-icon.png" alt="printer"
					class="button-image">
					보고서출력
			</button>
		</div>
	</div>
	<main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>


	<div class="chulgoModal">
		<div class="detail">
			<div class="header">출고등록</div>
			<div id="tabuData"></div>
		</div>

		<div class="btnSaveClose">
			<button class="save" type="button" onclick="save();">저장</button>
			<button class="close" type="button" onclick="window.close();">닫기</button>
		</div>
	</div>


	<script>
		//전역변수
		var cutumTable;

		//로드
		$(function() {
			var tdate = todayDate();
			var ydate = yesterDate();
			
			$("#sdate").val(ydate);
			$("#edate").val(tdate);
			getChulgoList();
		});

		//이벤트
		//함수
		function getChulgoList() {

			userTable = new Tabulator(
					"#tab1",
					{
						height : "750px",
						layout : "fitColumns",
						selectable : true, //로우 선택설정
						tooltips : true,
						selectableRangeMode : "click",
						reactiveData : true,
						headerHozAlign : "center",
						ajaxConfig : "POST",
						ajaxLoader : false,
						ajaxURL : "/tkheat/product/chulgo/getChulgoList",
						ajaxProgressiveLoad : "scroll",
						ajaxParams : {
							"sdate" : $("#sdate").val(),
							"edate" : $("#edate").val(),
							"prod_gubn" : $("#prod_gubn").val(),
						},
						placeholder : "조회된 데이터가 없습니다.",
						paginationSize : 20,
						ajaxResponse : function(url, params, response) {
							$("#tab1 .tabulator-col.tabulator-sortable").css(
									"height", "55px");
							return response; //return the response data to tabulator
						},
						columns : [ {
							title : "NO",
							field : "idx",
							sorter : "int",
							width : 80,
							hozAlign : "center"
						}, {
							title : "출력",
							field : "och_prn",
							sorter : "string",
							width : 120,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "입고일",
							field : "ord_date",
							sorter : "string",
							width : 120,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "출고일",
							field : "och_date",
							sorter : "string",
							width : 120,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "수주No",
							field : "och_code",
							sorter : "string",
							width : 150,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "거래처",
							field : "corp_name",
							sorter : "string",
							width : 120,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "품명",
							field : "prod_name",
							sorter : "string",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "품번",
							field : "prod_no",
							sorter : "string",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "재질",
							field : "prod_jai",
							sorter : "string",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "규격",
							field : "prod_gyu",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "공정",
							field : "tech_te",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "입고/타각LOT",
							field : "och_lot",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "단위",
							field : "prod_danw",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "출고수량",
							field : "och_su",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "출고중량",
							field : "och_amnt",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "금액",
							field : "och_mon",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "단가",
							field : "och_dang",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "단중",
							field : "prod_danj",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "마감월",
							field : "och_ma",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						}, {
							title : "비고",
							field : "och_bigo",
							sorter : "int",
							width : 100,
							hozAlign : "center",
							headerFilter : "input"
						},

						],
						rowFormatter : function(row) {
							var data = row.getData();

							row.getElement().style.fontWeight = "700";
							row.getElement().style.backgroundColor = "#FFFFFF";
						},
						rowClick : function(e, row) {

							$(
									"#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row")
									.each(
											function(index, item) {

												if ($(this).hasClass(
														"row_select")) {
													$(this).removeClass(
															'row_select');
													row.getElement().className += " row_select";
												} else {
													$("#tab1 div.row_select")
															.removeClass(
																	"row_select");
													row.getElement().className += " row_select";
												}
											});

							var rowData = row.getData();

						},
					});
		}



		
		//출고등록(입고리스트) 모달
		function getChulgoAddList() {

			chulgoAddTable = new Tabulator(
					"#tabuData",
					{
						height : "550px",
						layout : "fitColumns",
						selectable : true, //로우 선택설정
						tooltips : true,
						selectableRangeMode : "click",
						reactiveData : true,
						headerHozAlign : "center",
						ajaxConfig : "POST",
						ajaxLoader : false,
						ajaxURL : "/tkheat/product/chulgo/getChulgoAddList",
						ajaxProgressiveLoad : "scroll",
						ajaxParams : {
							"sdate" : $("#sdate").val(),
							"edate" : $("#edate").val(),
						},
						placeholder : "조회된 데이터가 없습니다.",
						paginationSize : 20,
						ajaxResponse : function(url, params, response) {
							$("#tabuData .tabulator-col.tabulator-sortable")
									.css("height", "55px");
							return response; //return the response data to tabulator
						},
						columns:[
					        {title:"제품단중", field:"prod_danj", sorter:"string", width:100,
						        hozAlign:"center", headerFilter:"input"},	
						    {title:"제품코드", field:"prod_code", sorter:"string", width:100,
							    hozAlign:"center", headerFilter:"input", visible:false},     
							{title:"수주NO", field:"ord_code", sorter:"string", width:120,
							    hozAlign:"center", headerFilter:"input", visible:false}, 
							{title:"거래처", field:"corp_name", sorter:"string", width:150,
							    hozAlign:"center", headerFilter:"input"}, 
					        {title:"품명", field:"prod_name", sorter:"string", width:100,
					        	hozAlign:"center", headerFilter:"input"},
					        {title:"품번", field:"prod_no", sorter:"string", width:100,
					        	hozAlign:"center", headerFilter:"input"},
					        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
						        hozAlign:"center", headerFilter:"input"},	
					        {title:"재질", field:"prod_jai", sorter:"string", width:100,
					        	hozAlign:"center", headerFilter:"input"},  	
					        {title:"공정", field:"tech_te", sorter:"string", width:80,
						        hozAlign:"center", headerFilter:"input"},	
						    {title:"표면경도", field:"prod_pg", sorter:"string", width:100,
							    hozAlign:"center", headerFilter:"input"},	
							{title:"심부경도", field:"prod_sg", sorter:"string", width:100,
							    hozAlign:"center", headerFilter:"input"},
							{title:"경화깊이", field:"prod_cd", sorter:"string", width:100,
								hozAlign:"center", headerFilter:"input"},
							{title:"단위", field:"prod_danw", sorter:"string", width:80,
								hozAlign:"center", headerFilter:"input"},	
							{title:"박스수량", field:"prod_boxsu", sorter:"string", width:100,
								hozAlign:"center", headerFilter:"input"},	
							{title:"수량", field:"ord_su", sorter:"string", width:100,
								hozAlign:"center", headerFilter:"input"},
							{title:"ROWS*", field:"ord_row", sorter:"int", width:100,
								hozAlign:"center", headerFilter:"input"},
							{title:"단가", field:"prod_dang", sorter:"int", width:100,
								hozAlign:"center", headerFilter:"input"},],
						rowFormatter : function(row) {
							var data = row.getData();

							row.getElement().style.fontWeight = "700";
							row.getElement().style.backgroundColor = "#FFFFFF";
						},
						rowClick : function(e, row) {

							$(
									"#tabuData .tabulator-tableHolder > .tabulator-table > .tabulator-row")
									.each(
											function(index, item) {

												if ($(this).hasClass(
														"row_select")) {
													$(this).removeClass(
															'row_select');
													row.getElement().className += " row_select";
												} else {
													$(
															"#tabuData div.row_select")
															.removeClass(
																	"row_select");
													row.getElement().className += " row_select";
												}
											});

							var rowData = row.getData();

						},
					});
		}

		//모달기능	
		const header = document.querySelector('.header'); // 헤더를 드래그할 요소로 사용
		const insertButton = document.querySelector('.insert-button');
		const chulgoModal = document.querySelector('.chulgoModal');
		const closeButton = document.querySelector('.close');

		header.addEventListener('mousedown', function(e) {
			// transform 제거를 위한 초기 위치 설정
			const rect = chulgoModal.getBoundingClientRect();
			chulgoModal.style.left = rect.left + 'px';
			chulgoModal.style.top = rect.top + 'px';
			chulgoModal.style.transform = 'none'; // 중앙 정렬 해제

			let offsetX = e.clientX - rect.left;
			let offsetY = e.clientY - rect.top;

			function moveModal(e) {
				chulgoModal.style.left = (e.clientX - offsetX) + 'px';
				chulgoModal.style.top = (e.clientY - offsetY) + 'px';
			}

			function stopMove() {
				window.removeEventListener('mousemove', moveModal);
				window.removeEventListener('mouseup', stopMove);
			}

			window.addEventListener('mousemove', moveModal);
			window.addEventListener('mouseup', stopMove);
		});

		insertButton.addEventListener('click', function() {
			getChulgoAddList();
			chulgoModal.style.display = 'block'; // 모달 표시
		});

		closeButton.addEventListener('click', function() {
			chulgoModal.style.display = 'none'; // 모달 숨김
		});
	</script>

</body>
</html>
