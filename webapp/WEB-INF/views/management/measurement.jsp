<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>측정기기등록</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %>     
    <style>
    
	.container {
		display: flex;
		justify-content: space-between;
/*		margin-left:1008px;
		margin-top:200px;*/
	}


.measurementModal {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 수직 중앙 */
    left: 50%; /* 수평 중앙 */
    display : none;
    transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
    z-index: 1000; /* 다른 요소 위에 표시 */
}
       
    .detail {
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

.insideTable {
    width: 100%; /* 테이블 너비 100% */
    border-collapse: collapse; /* 테두리 겹침 제거 */
}

.insideTable th,
.insideTable td {
    padding: 8px; /* 셀 패딩 */
    border: 1px solid #ccc; /* 셀 경계선 */
    vertical-align: middle; /* 수직 정렬 */
}

.insideTable th {
    background: #f0f0f0; /* 헤더 배경색 */
}

.basic, .form-control, .rp-input {
    width: calc(100% - 12px); /* 너비 조정 */
    padding: 5px; /* 내부 여백 */
    border: 1px solid #949494; /* 경계선 색상 */
    border-radius: 3px; /* 둥근 모서리 */
    box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1); /* 내부 그림자 */
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
	
	
<form method="post" class="corrForm" id="measurementForm" name="measurementForm">
<div class="measurementModal">	
	<div class="detail">
		<div class="header">
			측정기기등록
		</div>
          <table cellspacing="0" cellpadding="0" width="100%">
            <tbody><tr>
              <td class="">
                <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                  <input type="hidden" class="basic rp-input" id="ter_code" name="ter_code" value="-1">
                  <tbody><tr>
                    <th class="left">측정기기명</th>
                    <td class="">
  
                      <input type="text" class="form-control rp-input" id="ter_name" name="ter_name" style="width:90%;" value="">
  
                    </td>
  
                    <th class="left">측정기기번호</th>
                    <td class="">
                      <input type="text" class="basic rp-input" id="ter_no" name="ter_no" style="width:90%;" value="">
                    </td>
  
                    <th class="left">제조회사</th>
                    <td class="">
                      <input type="text" class="basic rp-input" id="ter_maker" name="ter_maker" style="width:90%;" value="">
                    </td>
  
                  </tr>
                  <tr>
                    <td class="" colspan="2">
                    <input id="imgInput0" class="imgInputClass" type="file" name="file_url" style="width:92%;" onchange="rpReadImageURL(this); $(this).parent().find('img').removeClass('rp-file-del');">
                      <button onclick="imageDelete(this)">X</button>
                    </td>
                    <th class="">모델명</th>
                    <td class=""><input id="ter_model" name="ter_model" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                    <th class="">제조일자</th>
                    <td class=""><input id="ter_mdate" name="ter_mdate" class="basic rp-input date js-datepicker js-date-now hasDatepicker" type="text" style="width:90%;" value="" maxlength="20" size="20" readonly="readonly"></td>
  
                  </tr>
                  <tr>
                    <td class="" colspan="2" rowspan="10">
                      <img id="img0" class="img-rounded rp-img-popup" src="resources/images/imgs/noimage_click.jpg" alt="사진" style="width: 220px;">
                    </td>
                    <th class="">S/N</th>
                    <td class=""><input id="ter_sn" name="ter_sn" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                    <th class="">구입회사</th>
                    <td class=""><input id="ter_buy" name="ter_buy" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th class="">용도</th>
                    <td class=""><input id="ter_yong" name="ter_yong" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                    <th class="">구입일자</th>
                    <td class=""><input id="ter_bdate" name="ter_bdate" class="basic rp-input date js-datepicker js-date-now hasDatepicker" type="text" style="width:90%;" value="" maxlength="20" size="20" readonly="readonly"></td>
                  </tr>
                  <tr>
                    <th class="">측정기기종류</th>
                    <td class=""><input id="ter_kind" name="ter_kind" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                    <th class="">구입금액</th>
                    <td class=""><input id="ter_bmon" name="ter_bmon" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th class="">관리자(정)</th>
                    <td class=""><input id="ter_ma1" name="ter_ma1" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                    <th class="">검교정주기</th>
                    <td class="">
  
                        <select id="ter_gum" name="ter_gum"  class="basic rp-input" style="width: 100%">
                          
                            <option value="분기(120)">분기(120)</option>
                          
                            <option value="반년(182)">반년(182)</option>
                          
                            <option value="년간(362)">년간(362)</option>
                          
                            <option value="2년간(730)">2년간(730)</option>
                          
                        </select>
                  </td></tr>
                  <tr>
                    <th class="">관리자(부)</th>
                    <td class=""><input id="ter_man2" name="ter_man2" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                    <th class="">사용전압</th>
                    <td class=""><input id="ter_v" name="ter_v" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th class="">설치장소</th>
                    <td class=""><input id="ter_place" name="ter_place" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                    <th class="">사용전류</th>
                    <td class=""><input id="ter_a" name="ter_a" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th class="">상태</th>
                    <td class="">
                      <select id="ter_use" name="ter_use" class="basic rp-input" style="width:90%;">
                        <option>사용</option>
                        <option>폐기</option>
                        <option>매각</option>
                      </select>
                    </td>
                    <th class="">사용전력</th>
                    <td class=""><input id="ter_kw" name="ter_kw" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th class="">상태비고</th>
                    <td class=""><input id="ter_ubigo" name="ter_ubigo" class="basic rp-input" type="text" style="width:90%;" value=""></td>
                    <th class="">차기검교정일</th>
                    <td class=""><input id="ter_next_gum" name="ter_next_gum" c type="date" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th class="">첨부파일</th>
                    <td class="findImage"><input type="hidden" name="type" id="type" class="imgInputClass" value="tester" onchange="rpReadImageURL(this); $(this).parent().find('img').removeClass('rp-file-del');">
                      <input type="file" name="file1" id="file1" class="rp-input" title="파일 찾기" onchange="" accept=".xls,.xlsx,.hwp,.hwpx,.pdf,.jpeg,.jpg,.png">
                    </td><th class="">최종검교정일</th>
                    <td class=""><input id="ter_end_gum" name="ter_end_gum"  type="date" onfocusout="set_ter_next_gum();" style="width:90%;" value=""></td>
                  </tr>
                  <tr>
                    <th class="">비고</th>
                    <td class="" colspan="3">
                      <textarea id="ter_bigo" name="ter_bigo" class="basic rp-input" type="text" style="width:90%;"></textarea>
                    </td>
                  </tr>
                </tbody></table>
                
  
              </td>
            </tr>
          </tbody></table>
          <div class="btnSaveClose">
          	 <button class="delete" type="button" onclick="deleteMea();"  style="display: none;">삭제</button>
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
		getMeasureList();
	});

	$(function(){	
		  // 파일 선택 시 이미지 미리보기 적용
		  $('.imgInputClass').change(function(event){
		    var selectedFile = event.target.files[0];
		    if (!selectedFile) return;

		    var reader = new FileReader();

		    // 이미지 출력 위치 지정
		    reader.onload = function(event) {
		      $('#img0').attr('src', event.target.result); 
		    };

		    reader.readAsDataURL(selectedFile);
		  });
		});


	//이벤트
	//함수
	function getMeasureList(){
		
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
		    ajaxURL:"/tkheat/management/measurement/measureList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:60,
		        	hozAlign:"center"},
		        {title:"상태", field:"ter_use", sorter:"string", width:90,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"측정기기명", field:"ter_name", sorter:"string", width:150,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"측정기기번호", field:"ter_code", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"최근검교정날짜", field:"ter_end_gum", sorter:"string", width:150,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"차기검교정날짜", field:"ter_next_gum", sorter:"int", width:150,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"검교정주기", field:"ter_gum", sorter:"int", width:100,
			        hozAlign:"center", headerFilter:"input"},
			    {title:"모델명", field:"ter_model", sorter:"int", width:120,
				    hozAlign:"center", headerFilter:"input"},
				{title:"구입회사", field:"ter_buy", sorter:"int", width:150,
					hozAlign:"center", headerFilter:"input"},
				{title:"구입일", field:"ter_bdate", sorter:"int", width:100,
					hozAlign:"center", headerFilter:"input"},
				{title:"구입금액", field:"ter_bmon", sorter:"int", width:100,
				    hozAlign:"center", headerFilter:"input"}, 
					/* {title:"사진", field:"file_name", width:100,
						hozAlign:"center", formatter:"image",
					    cssClass:"rp-img-popup",
				      	formatterParams:{
					      	height:"30px", width:"30px",
					      	urlPrefix:"/excelTest/태경출력파일/사진/측정기기관리/"
					      	}, 
					    cellMouseEnter:function(e, cell){ productImage(cell.getValue());} 
					    },   */   		
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
				$('#measurementForm')[0].reset();

/*
				Object.keys(data).forEach(function (key) {
			        const field = $('#chimStandardForm [name="' + key + '"]');

			        if (field.length) {
			            field.val(data[key]);
			        }
				});
*/

				console.log("data.ter_code",data.ter_code);
				measureDetail(data.ter_code);

				 $('.delete').show();
			},
		});		
	}

	//더블클릭 했을 때 데이터 가져오기
		function measureDetail(ter_code){
		$.ajax({
			url:"/tkheat/management/getMeasurmentDetail",
			type:"post",
			dataType:"json",
			data:{
				"ter_code":ter_code
			},
			success:function(result){
				console.log(result);
				var allData = result.data;
				
				for(let key in allData){
//					console.log(allData, key);	
					$("#measurementForm [name='"+key+"']").val(allData[key]);
				}

				// 이미지 초기화
				$("#img0").attr("src", "/resources/images/noimage_01.gif");

				// 이미지
 				if (allData.file_name) {
					console.log("원본 파일명:", allData.file_name);
					console.log("인코딩된 경로:", encodeURIComponent(allData.file_name));
					const path = "/excelTest/태경출력파일/사진/측정기기관리/" + allData.file_name;
					console.log("path: ", path);
					$("#img0").attr("src", path);
					//$(".aphoto").attr("href", path).text(d.product_file_name);
				} 

				$('.measurementModal').show().addClass('show');
			}
		});
	}
	

    </script>
    
    
	<script>
		
 // 드래그 기능 추가
	const modal = document.querySelector('.measurementModal');
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
	const measurementModal = document.querySelector('.measurementModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#measurementForm')[0].reset(); // 폼 초기화
	    measurementModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
	});

	closeButton.addEventListener('click', function() {
		measurementModal.style.display = 'none'; // 모달 숨김
	});



	//측정기기 저장
    function save() {
	    var formData = new FormData($("#measurementForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.ter_code) {
	        formData.append("mode", "update");
	        formData.append("wstd_code", selectedRowData.ter_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/measurement/measureInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	        	alert("저장 되었습니다.");
                $(".measurementModal").hide();
                getMeasureList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}


	function deleteMea() {
	    if (!selectedRowData || !selectedRowData.ter_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/management/measurement/measureDelete",
	        type: "POST",
	        data: {
	        	ter_code: selectedRowData.ter_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".measurementModal").hide();
	                getMeasureList();
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
	    const filename = "측정기기관리_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "측정기기관리" });
	});
		


    </script>
	</body>
</html>
