<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>측정기기고장이력</title>
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
.gojangModal {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 수직 중앙 */
    left: 50%; /* 수평 중앙 */
    display : none;
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
}
#editPop {
    background: #ffffff;
    border: 1px solid #000000;
    width: 800px; /* 가로 길이 고정 */
    height: 670px; /* 세로 길이 고정 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
    margin: 20px auto; /* 중앙 정렬 */
    padding: 20px;
    border-radius: 5px; /* 모서리 둥글게 */
    overflow-y: auto; /* 세로 스크롤 추가 */
    position: relative;
    margin-top: 0;
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

.img-rounded {
    border-radius: 5px; /* 둥근 모서리 */
}

.imgArea {
    width: 100%; /* 이미지 영역 너비 */
    height: 100px; /* 이미지 영역 높이 */
    border: 1px solid #ddd; /* 경계선 */
    margin-bottom: 10px; /* 하단 여백 */
}

.imgArea img {
    width: 100%; /* 이미지 너비 */
    height: 100%; /* 이미지 높이 */
    object-fit: cover; /* 이미지 비율 유지 */
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
th{
	font-size : 14px;
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
        <button class="select-button" onclick="getGigiGojangList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
            
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
	

<form method="post" id="gigiGojangForm" name="gigiGojangForm">		
	<div class="gojangModal">
	<div class="header">측정기기고장이력</div> 
        <div id="editPop">
    
            <!-- Article List -->
    
            <div class="detail">
                <table cellspacing="0" cellpadding="0" width="100%">
                    <tbody><tr>
                        <td>
                            <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
    						
                                <colgroup span="4">
                                    <col width="10%">
                                    <col width="40%">
                                    <col width="10%">
                                    <col width="40%">
                                </colgroup>
                                <tbody><tr>
                                    <th class="left">측정기기</th>
                                    <td>
                                        <select id="ter_code" name="ter_code" class="form-control rp-input" style="width:90%;">
                                            
                                                <option value="1">로크웰경도기</option>
                                            
                                                <option value="2">비커스경도기</option>
                                            
                                        </select>
                                        <input type="hidden" id="terr_code" name="terr_code" value="">
                                    </td>
                                    <th class="left">수리시작시간</th>
                                    <td>
                                        <input type="date" class="form-control rp-input js-datepicker js-date-now hasDatepicker" id="terr_strt" name="terr_strt" value="" placeholder="0000-00-00" style="width:30%;">
    
                                        
                                            
                                            
                                                <input type="text" class="form-control rp-input" id="terr_strt_h" name="terr_strt_h" placeholder="00" value="0" style="width:10%; text-align: center;">시
                                                <input type="text" class="form-control rp-input" id="terr_strt_mm" name="terr_strt_mm" placeholder="00" value="0" style="width:10%; text-align: center;">분
                                                <input type="text" class="form-control rp-input" id="terr_strt_ss" name="terr_strt_ss" placeholder="00" value="0" style="width:10%; text-align: center;">초
                                            
                                            
                                        </td>
                                </tr>
                                <tr>
                                    <th class="left">확인자</th>
                                    <td>
                                        <select id="terr_chkman" name="terr_chkman" class="basic rp-input" style="width:90%;">
                                            
                                                <option value="0">admin</option>
                                            
                                                <option value="2">정중환</option>
                                            
                                                <option value="5">조병수</option>
                                            
                                                <option value="12">이은영</option>
                                            
                                                <option value="7">이용희</option>
                                            
                                                <option value="26">산지와</option>
                                            
                                                <option value="31">이주영</option>
                                            
                                                <option value="32">가얀</option>
                                            
                                                <option value="36">두사르</option>
                                            
                                                <option value="41">패툼</option>
                                            
                                                <option value="42">응웬티하</option>
                                            
                                                <option value="44">최균홍</option>
                                            
                                                <option value="45">정희주</option>
                                            
                                                <option value="37">피얀타</option>
                                            
                                                <option value="4">김성우</option>
                                            
                                                <option value="9">외국인전용ID</option>
                                            
                                                <option value="46">장무강</option>
                                            
                                                <option value="40">김영수</option>
                                            
                                        </select>
                                    </td>
                                    <th class="left">수리종료시간</th>
                                    <td>
    
                                        <input type="date" class="form-control rp-input js-datepicker js-date-now hasDatepicker" id="TERR_END" name="terr_end" value="" placeholder="0000-00-00" style="width:30%;">
                                        
                                            
                                            
                                                <input type="text" class="form-control rp-input" id="terr_end_h" name="terr_end_h" placeholder="00" value="0" style="width:10%; text-align: center;">시
                                                <input type="text" class="form-control rp-input" id="terr_end_mm" name="terr_end_mm" placeholder="00" value="0" style="width:10%; text-align: center;">분
                                                <input type="text" class="form-control rp-input" id="terr_end_ss" name="terr_end_ss" placeholder="00" value="0" style="width:10%; text-align: center;">초
    
                                    </td>
                                </tr>
    
                                <tr>
                                    <th class="left">고장일시</th>
                                    <td>
                                        <input type="date"  id="terr_date" name="terr_date" value="" placeholder="0000-00-00" style="width:90%;">
                                    </td>
                                    <th class="left">수리시간</th>
                                    <td>
                                        <input type="text" class="form-control rp-input" id="terr_time" name="terr_time" value="" style="width:90%;" disabled="">
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <th class="left">상태</th>
                                    <td>
                                        <select id="terr_condi" name="terr_condi" class="basic rp-input" style="width:90%;">
                                            <option>가동</option>
                                            <option>비가동</option>
                                        </select>
                                    </td>
                                    <th class="left">수리자</th>
                                    <td>
                                        <input type="text" class="form-control rp-input" id="terr_man" name="terr_man" value="" style="width:90%;">
                                    </td>
                                </tr>
                                <tr>
                                    <th class="left">소요비용</th>
                                    <td>
                                        <input type="text" class="basic rp-input" onchange="getNumber(this);" onkeyup="getNumber(this);" id="terr_cost" name="terr_cost" value="" style="text-align:right; width:90%;">
                                    </td>
                                    <th class="left">수리</th>
                                    <td>
                                        <select id="terr_suri" name="terr_suri" class="basic rp-input" style="width:90%;">
                                            <option>수리</option>
                                            <option>완료</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="left">고장현상</th>
                                    <td>
                                        <textarea type="text" class="basic rp-input" rows="2" id="terr_reward" name="terr_reward" style="width:90%;"></textarea>
                                    </td>
                                    <th class="left">수리내용</th>
                                    <td>
                                        <textarea type="text" class="basic rp-input" rows="2" id="terr_content" name="terr_content" style="width:90%;"></textarea>
                                    </td>
                                </tr><tr>
                                    <th class="left">비고</th>
                                    <td colspan="4">
                                        <textarea type="text" class="basic rp-input" rows="5" id="terr_bigo" name="terr_bigo" style="width:90%; height: 100px;"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="left">수리전사진</th>
                                    <td>
                                                <input id="terr_bphoto" name="terr_bphoto" type="file" class="rp-input" onchange="rpReadImageURL(this); $(this).parent().find('img').removeClass('rp-file-del');" style="float:left;width: 220px;">
                                                <button onclick="imageDelete(this)" style="float:left">X</button><br><br>
                                                <img id="terr_bphoto_before" name="terr_bphoto_before" height="220" width="100%" align="center"  style="display: none;">
                                            
                                    </td>
                                    <th class="left">수리후사진</th>
                                    <td>
                                                <input id="terr_aphoto" name="terr_aphoto" type="file" class="rp-input" onchange="rpReadImageURL(this); $(this).parent().find('img').removeClass('rp-file-del');" style="float:left;width: 220px;">
                                                <button onclick="imageDelete(this)" style="float:left">X</button><br><br>
                                                <img id="terr_aphoto_after" name="terr_aphoto_after" height="220" width="100%" align="center"  style="display: none;">
                                            
                                    </td>
                                </tr>
    
                            </tbody></table>
                        </td>
                    </tr>
                </tbody></table>
                <div class="btnSaveClose">
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
    var isEditMode = false; //수정,최초저장 구분값
    
	//로드
	$(function(){
		var tdate = todayDate();
		var ydate = yesterDate();
		
		$("#sdate").val(ydate);
		$("#edate").val(tdate);
		getGigiGojangList();
	});

	//이벤트
	//함수
	function getGigiGojangList(){
		
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
		    ajaxURL:"/tkheat/preservation/gigiGojang/getGigiGojangList",
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
		        {title:"측정기기", field:"terr_name", sorter:"string", width:120,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"고장일시", field:"terr_date", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},     
				{title:"고장현상", field:"terr_reward", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"}, 
				{title:"수리시작시간", field:"terr_strt", sorter:"string", width:150,
				    hozAlign:"center", headerFilter:"input"}, 
		        {title:"수리종료시간", field:"terr_end", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},		        
		        {title:"수리시간", field:"terr_time", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"수리내용", field:"terr_content", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"수리자", field:"terr_man", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input"},	
		        {title:"소요비용", field:"terr_cost", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"기기코드", field:"terr_code", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input", visible:false},
			    {title:"기기코드", field:"ter_code", sorter:"string", width:100,
				    hozAlign:"center", headerFilter:"input", visible:false},
				{title:"소요비용", field:"terr_chkman", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input", visible:false},
			    {title:"소요비용", field:"terr_suri", sorter:"string", width:100,
				    hozAlign:"center", headerFilter:"input", visible:false}, 
			    {title:"소요비용", field:"terr_bigo", sorter:"string", width:100,
				    hozAlign:"center", headerFilter:"input", visible:false},
				{title:"소요비용", field:"terr_condi", sorter:"string", width:100,
					hozAlign:"center", headerFilter:"input", visible:false},		        	    		
				    
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
				console.log(selectedRowData.terr_code)
				$('#gigiGojangForm')[0].reset();

				/* Object.keys(data).forEach(function (key) {
			        const field = $('#begaInsertForm [name="' + key + '"]');

			        if (field.length) {
			            field.val(data[key]);
			        }
				}); */
				gigiGojangtDetail(data.terr_code);
				 $('.delete').show();
			},
		});		
	}

	function gigiGojangtDetail(terr_code){
		$.ajax({
			url:"/tkheat/preservation/gigiGojang/gigiGojangtDetail",
			type:"post",
			dataType:"json",
			data:{
				"terr_code":terr_code
			},
			success:function(result){
//				console.log(result);
				var allData = result.data;
				
				for(let key in allData){
//					console.log(allData, key);	
					$("input[name='"+key+"']").val(allData[key]);
				}

				$('.gojangModal').show().addClass('show');
			}
		});
	}


	//측정기기고장이력 저장
    function save() {
	    var formData = new FormData($("#gigiGojangForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.terr_code) {
	        formData.append("mode", "update");
	        formData.append("terr_code", selectedRowData.terr_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/preservation/gigiGojang/gigiGojangSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	            alert("저장 되었습니다.");
	            $(".gojangModal").hide();
	            getGigiGojangList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}


	function deleteGigiGojang() {
	    if (!selectedRowData || !selectedRowData.terr_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/preservation/gigiGojang/deleteGigiGojang",
	        type: "POST",
	        data: {
	        	terr_code: selectedRowData.terr_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".gojangModal").hide();
	                getGigiGojangList();
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
    
    
     <script>
		
 	// 드래그 기능 추가
	const modal = document.querySelector('.gojangModal');
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
	const gojangModal = document.querySelector('.gojangModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		gojangModal.style.display = 'block'; // 모달 표시
	});

	closeButton.addEventListener('click', function() {
		gojangModal.style.display = 'none'; // 모달 숨김
	});



	
		


    </script>

	</body>
</html>
