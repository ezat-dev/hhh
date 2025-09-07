<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>거래처등록</title> 
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>

<style>
	.container {
		display: flex;
		justify-content: space-between;
	}

.main {
	width: 98%;
}

.container {
	display: flex;
	justify-content: space-between;
}

.cutumModal {
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
	margin-bottom: -25px; /* 상단 여백 */
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
	width: 850px; /* 가로 길이 고정 */
	height: 630px; /* 세로 길이 고정 */
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
	margin-left: -1190px;
}

.box1 input[type="text"] {
	width: 5%;
}

.box1 input[type="date"] {
	width: 7%;
}

.box1 select {
	width: 5%
}
th{
	font-size:14px;
}
    
    
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
        
		<!-- <label class="daylabel">거래처명 :</label>
		<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">지역 :</label>
		<input type="text" class="corp_plc" id="corp_plc" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">구분 :</label>
		<input type="text" class="corp_gubn" id="corp_gubn" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">영업담당자 :</label>
		<input type="text" class="corp_mast" id="corp_mast" style="font-size: 16px; autocomplete="off"> -->
			
	</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getCutumList();">
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
	    
	    
	    
	<form method="post" class="corrForm" id="cutumInsertForm" name="cutumInsertForm">
			<div class="cutumModal">
				<div class="header">거래처등록 
					<span class="header-close">&times;</span>
				</div>	
				<div class="detail">
					<table cellspacing="0" cellpadding="0" width="100%">
						<tr>
							<td class="">
								<table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
									<colgroup span="4">
										<col width="*" />
										<col width="40%" />
										<col width="*" />
										<col width="40%" />
									</colgroup>
									<tr>
										<th class="">거래처</th>
										<td class=""><input id="corp_name" name="corp_name" class="basic" type="text" style="width:90%;" value="" />										
										</td>
										<th class="">사업자번호</th>
										<td class=""><input id="corp_no" name="corp_no" class="basic" type="text" style="width:90%;" value="" /></td>
									</tr>
									<tr>
										<th class="">전화번호</th>
										<td class=""><input id="corp_tel" name="corp_tel" class="basic" type="text" style="width:90%;" value="" /></td>
										<th class="">팩스번호</th>
										<td class=""><input id="corp_fax" name="corp_fax" class="basic" type="text" style="width:90%;" value="" /></td>
									</tr>
									<tr>
										<th class="">대표자</th>
										<td class=""><input id="corp_boss" name="corp_boss" class="basic" type="text" style="width:90%;" value="" /></td>
										<th class="">담당자</th>
										<td class=""><input id="corp_mast" name="corp_mast" class="basic" type="text" style="width:90%;" value="" /></td>
									</tr>
									<tr>
										<th class="">담당자 휴대폰</th>
										<td class=""><input id="corp_hp" name="corp_hp" class="basic" type="text" style="width:90%;" value="" /></td>
										<th class="">메일주소</th>
										<td class=""><input id="corp_mail" name="corp_mail" class="basic" type="text" style="width:90%;" value="" /></td>
									</tr>
									<tr>
										<th class="">업태</th>
										<td class=""><input id="corp_upte" name="corp_upte" class="basic" type="text" style="width:90%;" value="" /></td>
										<th class="">종목</th>
										<td class=""><input id="corp_upjo" name="corp_upjo" class="basic" type="text" style="width:90%;" value="" /></td>
									</tr>
									<tr>
										<th class="">주소</th>
										<td class=""><input id="corp_add" name="corp_add" class="basic" type="text" style="width:90%;" value="" /></td>
										<th class="">지역</th>
										<td class=""><input id="corp_plc" name="corp_plc" class="basic" type="text" style="width:90%;" value="" /></td>
									</tr>
									<tr>
										<th class="">거래게시일</th>
										<td class="">
											<input id="corp_strt" name="corp_strt" type="date" style="width:100px;" value="" maxlength="20" size="20"  /> 
											<input type="checkbox" id="corp_gyul1" name="corp_gyul1" checked="checked" class="" />매월 말일
										</td>
										<th class="">기초잔액</th>
										<td class=""><input id="corp_jan" name="corp_jan" class="basic" type="text" style="width:90%;" value="0" /></td>
										</tr>
									<tr>
										<th class="">마감일</th>
										<td class="">
											<input id="corp_gyul2" name="corp_gyul2" class="basic" type="number" style="width:100px;IME-MODE:disabled;" value="" min="1" max="31" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/>
										</td>
										<th class="">구분</th>
										<td class=""><select id="corp_gubn" name="corp_gubn"class="basic" style="width:85px;">
														<option>매출처</option>
														<option>매입처</option>
													</select></td>
									</tr>
									<tr>
										<th class="">입금통장</th>
										<td class=""><input id="corp_cno" name="corp_cno" class="basic" type="text" style="width:90%;" value="" /></td>
										<th class="">비밀번호</th>
										<td class=""><input id="corp_pwd" name="corp_pwd" class="basic" type="text" style="width:90%;" value="" /></td>
									</tr>
									<tr>
										<th class=""></th>
										<td class=""></td>
										<th class="">거래처명2</th>
										<td class=""><input id="corp_name2" name="corp_name2" class="basic" type="text" style="width:90%;" value="" /></td>
									</tr>
									<tr>
										<th class="">비고</th>
										<td colspan="3" class=""><textarea id="corp_bigo" name="corp_bigo" class="basic" style="width:90%;"></textarea></td>
										
									</tr>
									<tr>
										<th class="">영업담당자</th>
										<td class="">
											<select id='corp_business' name="corp_business" class='basic js-username-select'></select>
										</td>
										
									</tr>
								</table>
							</td>
							</tr>
					</table>
					<div class="btnSaveClose">
				<button class="delete" type="button" onclick="deleteCutum();"  style="display: none;">삭제</button>
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
		    selectableRows:true,
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/management/cutumInsert/cutumInsertList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"corp_name": $("#corp_name").val(),
                "corp_plc": $("#corp_plc").val(),
                "corp_gubn": $("#corp_gubn").val(),
                "corp_mast": $("#corp_mast").val(),
                /* "corp_code":"", */
			    },
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"corp_code", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"구분ID", field:"corp_gubn", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"거래처명", field:"corp_name", sorter:"string", width:150,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"영업담당자", field:"corp_name2", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"사업자번호", field:"corp_no", sorter:"string", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"전화", field:"corp_tel", sorter:"int", width:200,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"FAX", field:"corp_fax", sorter:"int", width:200,
			        hozAlign:"center", headerFilter:"input"},
			    {title:"대표", field:"corp_boss", sorter:"int", width:120,
				    hozAlign:"center", headerFilter:"input"},
				{title:"담당자", field:"corp_mast", sorter:"int", width:150,
					hozAlign:"center", headerFilter:"input"},
				{title:"지역", field:"corp_plc", sorter:"int", width:100,
					hozAlign:"center", headerFilter:"input"},    
				{title:"거래처코드", field:"corp_code", width:120, 
					hozAlign:"center",visible:false},  		
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
				$('#cutumInsertForm')[0].reset();
				

				/* Object.keys(data).forEach(function (key) {
			        const field = $('#cutumInsertForm [name="' + key + '"]');

			        if (field.length) {
			            field.val(data[key]);
			        }
				}); */
				cutumInsertDetail(data.corp_code);	
				 $('.delete').show();
			},
		});		
	}

	function cutumInsertDetail(corp_code){
		$.ajax({
			url:"/tkheat/management/cutumInsert/cutumInsertDetail",
			type:"post",
			dataType:"json",
			data:{
				"corp_code":corp_code
			},
			success:function(result){
//				console.log(result);
				var allData = result.data;
				
				for(let key in allData){
//					console.log(allData, key);	
					$("[name='"+key+"']").val(allData[key]);
				}

				$('.cutumModal').show().addClass('show');
			}
		});
	}


	// 드래그 기능 추가
	const modal = document.querySelector('.cutumModal');
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
	const cutumModal = document.querySelector('.cutumModal');
	const closeButton = document.querySelector('.close');
	const headerCloseButton = document.querySelector('.header-close');
	
	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#cutumInsertForm')[0].reset(); // 폼 초기화
		cutumModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
	});

	closeButton.addEventListener('click', function() {
	    cutumModal.style.display = 'none'; // 모달 숨김
	});

	headerCloseButton.addEventListener('click', function() {
		cutumModal.style.display = 'none';
	});
	

	
	function save() {
	    var formData = new FormData($("#cutumInsertForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.corp_code) {
	        formData.append("mode", "update");
	        formData.append("corp_code", selectedRowData.corp_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/cutumInsert/cutumInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	            alert("저장 되었습니다.");
	            $(".cutumModal").hide();
	            getCutumList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}


	function deleteCutum() {
	    if (!selectedRowData || !selectedRowData.corp_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/cutumInsert/cutumDelete",
	        type: "POST",
	        data: {
	            corp_code: selectedRowData.corp_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".cutumModal").hide();
	                getCutumList();
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
