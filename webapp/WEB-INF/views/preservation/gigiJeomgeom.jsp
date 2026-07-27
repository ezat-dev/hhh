<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>측정기기점검관리</title>
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
.gigiJeomgeomModal {
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
	margin-bottom: 10px; /* 상단 여백 */
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
	height: 530px; /* 세로 길이 고정 */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
	margin: 20px auto; /* 중앙 정렬 */
	padding: 20px;
	border-radius: 5px; /* 모서리 둥글게 */
	overflow-y: auto; /* 세로 스크롤 추가 */
}

.insideTable {
	width: 100%; /* 테이블 너비 100% */
	border-collapse: collapse; /* 테두리 겹침 제거 */
}

.insideTable th, .insideTable td {
	padding: 8px; /* 셀 패딩 */
	border: 1px solid #ccc; /* 셀 경계선 */
	vertical-align: middle; /* 수직 정렬 */
}

.insideTable th {
	background: #f0f0f0; /* 헤더 배경색 */
}

.basic, .rp-input, .form-control {
	width: calc(100% - 12px); /* 너비 조정 */
	padding: 5px; /* 내부 여백 */
	border: 1px solid #949494; /* 경계선 색상 */
	border-radius: 3px; /* 둥근 모서리 */
}

.basic[readonly] {
	background-color: #f9f9f9; /* 읽기 전용 필드 색상 */
}

textarea {
	width: 100%; /* 너비 100% */
	padding: 5px; /* 내부 여백 */
	border: 1px solid #949494; /* 경계선 색상 */
	border-radius: 3px; /* 둥근 모서리 */
}

.findImage {
	display: flex; /* 플렉스 박스 사용 */
	align-items: center; /* 수직 정렬 */
}

.findImage input[type="file"] {
	margin-right: 10px; /* 오른쪽 여백 */
}

.imgArea {
	width: 200px; /* 이미지 영역 너비 */
	height: 150px; /* 이미지 영역 높이 */
	border: 1px solid #ddd; /* 경계선 */
	margin-bottom: 10px; /* 하단 여백 */
}

.imgArea img {
	width: 100%; /* 이미지 너비 */
	height: 100%; /* 이미지 높이 */
	object-fit: cover; /* 이미지 비율 유지 */
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
	font-size:14px;
}


/* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main {
    flex: 1;
    min-height: 0;
    display: flex;
    padding: 8px;
    overflow: hidden;
}

/* ========== 상단 도구바 ========== */
.tab {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 0 14px;
}
.button-container .select-button,
.button-container .insert-button,
.button-container .excel-button,
.button-container .printer-button,
.button-container .delete {
    height: 34px;
    border: 1px solid #E2E8F0;
    border-radius: 8px;
    background: #F0F4F8;
    transition: background-color .13s, border-color .13s;
}
.button-container .select-button:hover,
.button-container .insert-button:hover,
.button-container .excel-button:hover,
.button-container .printer-button:hover,
.button-container .delete:hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
}

/* ========== 리스트 카드 영역 ========== */
.container {
    display: flex;
    flex: 1;
    min-height: 0;
    flex-direction: column;
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 8px;
    overflow: hidden;
}

/* ========== Tabulator 리스트 ========== */
#tab1.tabulator {
    flex: 1;
    min-height: 0;
    border: none;
    font-size: 12px;
}
#tab1 .tabulator-header {
    background: linear-gradient(135deg, #2B6CB0, #3182CE);
    border-bottom: none;
}
#tab1 .tabulator-col {
    background: transparent;
    border-right: 1px solid rgba(255,255,255,.15);
}
#tab1 .tabulator-col.tabulator-sortable:hover {
    background: rgba(255,255,255,.08);
}
#tab1 .tabulator-col-title {
    color: #ffffff;
    font-weight: 700;
}
#tab1 .tabulator-col .tabulator-header-filter input {
    border: none;
    border-radius: 5px;
    padding: 4px 6px;
    font-size: 11px;
    background: rgba(255,255,255,.92);
    box-sizing: border-box;
}
#tab1 .tabulator-col .tabulator-header-filter input:focus {
    outline: none;
    background: #ffffff;
    box-shadow: 0 0 0 2px rgba(255,255,255,.6);
}
#tab1 .tabulator-row {
    border-bottom: 1px solid #EDF2F7;
    transition: background-color .12s;
}
#tab1 .tabulator-row.tabulator-row-even {
    background-color: #F7FAFC;
}
#tab1 .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#tab1 .tabulator-row.row_select,
#tab1 .tabulator-row.tabulator-selected {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#tab1 .tabulator-cell {
    border: 1px solid #E2E8F0;
    color: #2D3748;
}

/* ========== 페이지네이션 (직관적으로 개선) ========== */
#tab1 .tabulator-footer {
    background: #F7FAFC;
    border-top: 1px solid #E2E8F0;
    padding: 8px 12px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
}
#tab1 .tabulator-paginator {
    display: flex;
    align-items: center;
    gap: 6px;
}
#tab1 .tabulator-page-size {
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    padding: 4px 8px;
    font-size: 12px;
    background: #ffffff;
    color: #2D3748;
    cursor: pointer;
    margin: 0;
}
#tab1 .tabulator-page-size:focus {
    outline: none;
    border-color: #3182CE;
}
#tab1 .tabulator-pages {
    display: flex;
    gap: 4px;
    margin: 0;
}
#tab1 .tabulator-page {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    background: #ffffff;
    color: #2D3748;
    min-width: 30px;
    height: 28px;
    padding: 0 8px;
    font-size: 12px;
    font-weight: 600;
    margin: 0;
    transition: background-color .13s, border-color .13s, color .13s;
}
#tab1 .tabulator-page.active {
    background: #3182CE;
    border-color: #2B6CB0;
    color: #ffffff;
}
#tab1 .tabulator-page:not(:disabled):hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
    color: #2B6CB0;
    cursor: pointer;
}
#tab1 .tabulator-page:disabled {
    opacity: .4;
    cursor: not-allowed;
}

/* ========== 모달 오버레이 ========== */
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
        <button class="select-button" onclick="getGigiJeomgeomList();">
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
        <!-- <button class="printer-button">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
            
        </button> -->
    </div>
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>



<form method="post" class="corrForm" id="gigiJeomgeomForm" name="gigiJeomgeomForm">
   <div class="gigiJeomgeomModal">
	<div class="detail">
		<div class="header">
				측정기기점검관리 상세정보
				<span class="header-close">&times;</span>
			</div>
		<table cellspacing="0" cellpadding="0" width="100%">
			<tr>
				<td>
					<table cellspacing="0" cellpadding="0" width="100%"
						class="insideTable">
						<colgroup span="4">
							<col width="10%" />
							<col width="40%" />
							<col width="10%" />
							<col width="40%" />
						</colgroup>
						<tr>
							<th class="left">장비명*</th>
							<td><input type="text" class="basic rp-input" id="ter_name" name="ter_name" placeholder="검색해주세요 -->" style="width: 76%;" disabled /> 
								<input type="text" class="basic rp-input" id="ter_code" name="ter_code" hidden="true" />
								<button type="reset" class="btn btn-outline-primary float-right width-100" title="검색" onclick="openMeaListModal();">검색</button>
							</td>
							<th class="left">점검일자*</th>
							<td><input type="text"class="basic rp-input date js-datepicker js-date-now" id="mcd_inspection_date" name="mcd_inspection_date" onfocusout="set_ter_next_gum();" value="2025-05-20" style="width: 76%;" placeholder="점검일자" /></td>
						</tr>
						<tr>
							<th class="left">장비번호*</th>
							<td><input type="text" class="basic rp-input" id="mcd_no" placeholder="장비 검색해주세요" style="width: 76%;" value="" disabled /></td>
							<th class="left">수리기관</th>
							<td><input type="text" class="basic rp-input"
								id="s_tmcd_repair_comp" style="width: 76%;" placeholder="수리기관" />
							</td>
						</tr>

						<tr>
							<th class="left">관리번호</th>
							<td><input type="text" class="basic rp-input"
								id="s_tmcd_man_no" placeholder="관리번호" style="width: 76%;" /></td>
							<th class="left">담당자*</th>
							<td><select id="mcd_reg_cd" name="mcd_reg_cd" class="basic rp-input"
								style="width: 100%">

									<option value="2">정중환</option>

									<option value="5">조병수</option>

									<option value="12">이은영</option>

									<option value="7">이용희</option>

									<option value="13">.</option>

									<option value="26">산지와</option>

									<option value="31">이주영</option>

									<option value="32">가얀</option>

									<option value="36">두사르</option>

									<option value="41">패툼</option>

									<option value="42">응웬티하</option>

									<option value="43">양수석</option>

									<option value="44">최균홍</option>

									<option value="45">정희주</option>

									<option value="49">123</option>

									<option value="50">22</option>

									<option value="54">테스트</option>

									<option value="37">피얀타</option>

									<option value="4">김성우</option>

									<option value="9">외국인전용ID</option>

									<option value="10">.</option>

									<option value="46">장무강</option>

									<option value="14">두사르(이전등록)</option>

									<option value="40">김영수</option>

									<option value="51"></option>

									<option value="52">123123</option>

									<option value="53">ㅁㅁㅁ</option>

							</select></td>
						</tr>
						<tr>
							<th class="left">교정주기*</th>
							<td><input id="mcd_correction_cycle" name="mcd_correction_cycle" class="basic rp-input"
								type="text" style="width: 76%;" value="" disabled /></td>
							<th class="left">유효기간</th>
							<td><input type="text" class="basic rp-input" id="s_tmcd_available_term" placeholder="유효기간"
								style="width: 76%;" /></td>
						</tr>
						<tr>
							<th class="left">차기교정일</th>
							<td><input type="text" class="basic rp-input" id="mcd_available_term" name="mcd_available_term" style="width: 76%;" value="" readonly />
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<div>
									<input id="file" class="valClean" type="file" title="파일 찾기">
									<input type="button" value="X" onclick="$('#file').val('');">
								</div>
								<div>
									<a href="" id="fileLink" class="valClean" target="_blank"></a>
								</div>
							</td>
							<th class="left">수리내역</th>
							<td><textarea rows="5" class="basic" id="repair_history" name="repair_history" placeholder="수리내역" style="width: 76%;" /> </textarea></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="btnSaveClose">
            <button class="delete" type="button" onclick="deleteGigi();"  style="display: none;">삭제</button>
			<button class="save" type="button" onclick="save();">저장</button>
			 <button class="close" type="button" onclick="window.close();">닫기</button>
    	 </div>
	</div>
	</div>
</form>



	   <!-- 측정기기(검색버튼) 팝업창 -->
	<div id="meaListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">설비 리스트</span> <span class="modal-close" onclick="closeMeaListModal()">&times;</span>
			</div>
			<div id="meaListTabulator" style="height: 500px;"></div>
		</div>
	</div>


	<script>
		//전역변수
		var cutumTable;
		var isEditMode = false; //수정,최초저장 구분값
		
		//로드
		$(function() {
			var tdate = todayDate();
			var ydate = yesterDate();
			
			$("#sdate").val(ydate);
			$("#edate").val(tdate);
			getGigiJeomgeomList();
		});

		//이벤트
		//함수
		function getGigiJeomgeomList() {

			userTable = new Tabulator(
					"#tab1",
					{
						height : "100%",
						layout : "fitColumns",
						selectable : true, //로우 선택설정
						tooltips : true,
						selectableRangeMode : "click",
						reactiveData : true,
						headerHozAlign : "center",
						ajaxConfig : "POST",
						ajaxLoader : false,
						ajaxURL : "/tkheat/preservation/gigiJeomgeom/getGigiJeomgeomList",
						ajaxParams : {
							"sdate" : $("#sdate").val(),
							"edate" : $("#edate").val(),
						},
						placeholder : "조회된 데이터가 없습니다.",
						pagination : "local",
						paginationSize : 20,
						paginationSizeSelector : [ 20, 50, 100, 500, 1000 ],
						paginationCounter : "rows",
						ajaxResponse : function(url, params, response) {
							$("#tab1 .tabulator-col.tabulator-sortable").css(
									"height", "29px");
							return response.data ? response.data : response; //return the response data to tabulator
						},
						columns : [ {
							title : "NO",
							field : "idx",
							sorter : "int",
							width : 80,
							hozAlign : "center"
						}, {
							title : "점검일",
							field : "mcd_inspection_date",
							sorter : "string",
							width : 120,
							hozAlign : "center"
						}, {
							title : "장비명",
							field : "ter_name",
							sorter : "string",
							width : 120,
							hozAlign : "center"
						}, {
							title : "장비번호",
							field : "mcd_no",
							sorter : "string",
							width : 120,
							hozAlign : "center"
						}, {
							title : "교정주기명",
							field : "mcd_correction_cycle",
							sorter : "string",
							width : 150,
							hozAlign : "center"
						}, {
							title : "차기교정일",
							field : "mcd_next_date",
							sorter : "string",
							width : 120,
							hozAlign : "center"
						}, {
							title : "담당자",
							field : "mcd_manager_user_cd",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "최초등록일시",
							field : "mcd_reg_dt",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "최초등록자명",
							field : "mcd_reg_cd",
							sorter : "string",
							width : 100,
							hozAlign : "center"
						}, {
							title : "최종수정일시",
							field : "mcd_mod_dt",
							sorter : "int",
							width : 100,
							hozAlign : "center"
						}, {
							title : "최종수정자명",
							field : "mcd_mod_cd",
							sorter : "int",
							width : 100,
							hozAlign : "center"
						},

						],
						rowFormatter : function(row) {
							var data = row.getData();

							row.getElement().style.fontWeight = "600";
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
						rowDblClick:function(e, row){

							var data = row.getData();
							selectedRowData = data;
							isEditMode = true;
							$('#gigiJeomgeomForm')[0].reset();
							$('.gigiJeomgeomModal').show().addClass('show');

							Object.keys(data).forEach(function (key) {
						        const field = $('#gigiJeomgeomForm [name="' + key + '"]');

						        if (field.length) {
						            field.val(data[key]);
						        }
							});

							 $('.delete').show();
						},
					});
		}


		// 드래그 기능 추가
		const modal = document.querySelector('.gigiJeomgeomModal');
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
		const gigiJeomgeomModal = document.querySelector('.gigiJeomgeomModal');
		const closeButton = document.querySelector('.close');
		const headerCloseButton = document.querySelector('.header-close');

		insertButton.addEventListener('click', function() {
			isEditMode = false;  // 추가 모드
		    $('#gigiJeomgeomForm')[0].reset(); // 폼 초기화
		    gigiJeomgeomModal.style.display = 'block'; // 모달 표시

			$('.delete').hide();
		});

		closeButton.addEventListener('click', function() {
			gigiJeomgeomModal.style.display = 'none'; // 모달 숨김
		});

		headerCloseButton.addEventListener('click', function() {
			gigiJeomgeomModal.style.display = 'none';
		});
			



		//측정기기버튼검색 리스트 모달
	    function openMeaListModal() {
	        document.getElementById('meaListModal').style.display = 'flex';

	        
	        let facListTable = new Tabulator("#meaListTabulator", {
	            height:"450px",
	            layout:"fitColumns",
	            selectable:true,
	            ajaxURL:"/tkheat/management/measurement/measureList",
	            ajaxConfig:"POST",
	            ajaxParams:{
	                "ter_code": "",
	                "ter_name": "",
	                   
	            },
			    ajaxResponse:function(url, params, response){
//					$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
					console.log(response);
			        return response.data; //return the response data to tabulator
			    },    
	            columns:[
	                {title:"기기NO", field:"ter_code", width:120, hozAlign:"center"},
	                {title:"기기명", field:"ter_name", width:150, hozAlign:"center"},
	            ],
	            rowDblClick:function(e, row){
	                let data = row.getData();
	                
	                console.log("선택된 설비:", data);
	                document.getElementById('ter_code').value = data.ter_code;
	                document.getElementById('ter_name').value = data.ter_name;
	                
	                document.getElementById('meaListModal').style.display = 'none';
	            }
	        });
	    }

	    function closeMeaListModal() {
	        document.getElementById('meaListModal').style.display = 'none';
	    }
			


	    </script>
	    
	    
	    <script>



		//측정기기점검관리 저장
	    function save() {
		    var formData = new FormData($("#gigiJeomgeomForm")[0]);

		    let confirmMsg = "";

		    if (isEditMode && selectedRowData && selectedRowData.ter_code) {
		        formData.append("mode", "update");
		        formData.append("ter_code", selectedRowData.ter_code);
		        confirmMsg = "수정하시겠습니까?";
		    } else {
		        formData.append("mode", "insert");
		        confirmMsg = "저장하시겠습니까?";
		    }

		    if (!confirm(confirmMsg)) {
		        return;
		    }

		    $.ajax({
		        url: "/tkheat/preservation/gigiJeomgeom/gigiJeomgeomSave",
		        type: "POST",
		        data: formData,
		        contentType: false,
		        processData: false,
		        dataType: "json",
		        success: function(result) {
		            alert("저장 되었습니다.");
		            $(".gigiJeomgeomModal").hide();
		            getGigiJeomgeomList();
		        },
		        error: function(xhr, status, error) {
		            console.error("저장 오류:", error);
		        }
		    });
		}


		function deleteGigi() {
		    if (!selectedRowData || !selectedRowData.ter_code) {
		        alert("삭제할 대상을 선택하세요.");
		        return;
		    }

		    if (!confirm("삭제하시겠습니까?")) {
		        return;
		    }

		    $.ajax({
		        url: "/tkheat/preservation/gigiJeomgeom/gigiJeomgeomDelete",
		        type: "POST",
		        data: {
		        	ter_code: selectedRowData.ter_code
		        },
		        dataType: "json",
		        success: function(result) {
		            if (result.status === "success") {
		                alert("삭제되었습니다.");
		                $(".gigiJeomgeomModal").hide();
		                getGigiJeomgeomList();
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



		
	</script>

	</body>
</html>
