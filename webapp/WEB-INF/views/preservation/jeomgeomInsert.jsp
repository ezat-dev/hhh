<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비점검기준등록</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %> 
    <style>
    
.main{
	width:98%;
}
.container {
	display: flex;
	justify-content: space-between;
}
.jgInsertModal {
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
    margin-bottom: 10px; /* 상단 여백 */
    background-color: #33363d; /* 배경색 */
    height: 50px; /* 높이 */
    color: white; /* 글자색 */
    font-size: 20px; /* 글자 크기 */
    text-align: center; /* 텍스트 정렬 */
}
#editPop {
    background: #ffffff;
    border: 1px solid #000000;
    width: 500px; /* 가로 길이 고정 */
    height: 690px; /* 세로 길이 고정 */
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
  width: 40%;
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
    
    <div class="button-container">
        <!-- <button class="select-button">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button> -->
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
	
	
<form method="post" class="corrForm" id="jeomgeomInsertForm" name="jeomgeomInsertForm">	
	<div class="jgInsertModal">
	   <div id="editPop">
	   	<div class="header">설비점검기준등록</div>
            <div class="detail">
                <table cellspacing="0" cellpadding="0" width="100%">
                    <tbody><tr>
                        <td>
                            <table cellspacing="0" cellpadding="0" width="100%" class="insideTable">
                                <colgroup span="2">
                                    <col width="20%">
                                    <col width="80%">
                                </colgroup>
                                <tbody><tr>
                                    <th>설비그룹</th>
                                     <td>
                                        <input id="chs_no" name="chs_no" class="basic" type="text" style="width:96%;" value="" readonly="">
                                    </td>
                                </tr>
                                <tr>
                                    <th>설비</th>
                                    <td>
                                        
                                            
                                                <input id="fac_code" name="fac_code" class="basic" type="hidden" style="width:83%;" value="">
                                                <input id="fac_name" name="fac_name" class="basic" type="text" style="width:83%;" value="" disabled="">
                                            
                                            
                                        
    
                                        <input type="button" title="검색" class="btnSearchSmall" onclick="openFacListModal();">
                                    </td>
                                </tr>
    
                                <tr>
                                    <th>설비번호</th>
                                    <td>
                                        <input id="fac_no" name="fac_no" class="basic" type="text" style="width:96%;" value="" disabled="">
                                    </td>
                                </tr>
                                <tr>
                                    <th>순번</th>
                                    <td><input id="chs_sort" name="chs_sort" class="basic" type="text" style="width:96%;" value=""></td>
                                </tr>
                                <tr>
                                    <th>점검주기</th>
                                    <td>
                                        <select id="chs_gubn" name="chs_gubn" style="width:98%;">
                                            <option>일상</option>
                                            <option>주간</option>
                                            <option>월간</option>
                                            <option>분기</option>
                                            <option>반기</option>
                                            <option>수시</option>
                                            <option>공정순회</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>구분</th>
                                    <td>
                                        <select id="chs_gubn_detail" style="width:98%;">
                                            <option>주간</option>
                                            <option>야간</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>점검항목</th>
                                    <td><input id="chs_hang" name="chs_hang" class="basic" type="text" style="width:96%;" value=""></td>
                                </tr>
                                <tr>
                                    <th>기준방법</th>
                                    <td><input id="chs_kijun" name="chs_kijun" class="basic" type="text" style="width:96%;"></td>
                                </tr>
                                <tr>
                                    <th>하한</th>
                                    <td><input id="chs_min" name="chs_min" class="basic" type="text" style="width:96%;" value=""></td>
                                </tr>
                                <tr>
                                    <th>상한</th>
                                    <td><input id="chs_max" name="chs_max" class="basic" type="text" style="width:96%;" value=""></td>
                                </tr>
                                <tr>
                                    <th>단위</th>
                                    <td><input id="chs_dawn" name="chs_dawn" class="basic" type="text" style="width:96%;" value=""></td>
                                </tr>
                                <tr>
                                    <th>점검방법</th>
                                    <td><input id="chs_chkmethod" name="chs_chkmethod" class="basic" type="text" style="width:96%;" value=""></td>
                                </tr>
                                <tr>
                                    <th>조치방법</th>
                                    <td><input id="chs_stepmethod" name="chs_stepmethod" class="basic" type="text" style="width:96%;" value=""></td>
                                </tr>
                                <tr>
                                    <th>이미지</th>
                                    <!-- <td>
                                        <input id="chs_img" name="chs_img" type="file" style="width:96%;" value="" accept="image/*">
    
                                    </td> -->
                                </tr>
    
                            </tbody></table>
                        </td>
                    </tr>
                </tbody></table>
            </div>
            <div class="btnSaveClose">
            	<button class="delete" type="button" onclick="deleteJeomgeom();"  style="display: none;">삭제</button>
				<button class="save" type="button" onclick="save();">저장</button>
				<button class="close" type="button" onclick="window.close();">닫기</button>
    		</div>
        </div> 
        </div>
       </form> 
        
        
        <!-- 설비목록(검색버튼) 팝업창 -->
	<div id="facListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">설비 리스트</span> <span class="modal-close" onclick="closeFacListModal()">&times;</span>
			</div>
			<div id="facListTabulator" style="height: 500px;"></div>
		</div>
	</div>
	    
<script>
	//전역변수
    var cutumTable;	
    var isEditMode = false; //수정,최초저장 구분값

	//로드
	$(function(){
		//전체 거래처목록 조회
		getJeomgeomInsertList();
	});

	//이벤트
	//함수
	function getJeomgeomInsertList(){
		
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
		    ajaxURL:"/tkheat/preservation/jeomgeomInsert/getJeomgeomInsertList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
			    
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
		         {title:"설비그룹", field:"chs_no", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},	
				    {
				        title: "설비공정종류",
				        field: "tech_ht",
				        editor: "list",
				        editorParams: {
				            values: {
				                "이온질화": "이온질화",
				                "진공로": "진공로",
				                "템퍼링로": "템퍼링로",
				                "Box Type": "Box Type",
				                "PIT로": "PIT로",
				                "PQ": "PQ",
				                "Salt로": "Salt로"
				            },
				            clearable: true
				        },
				        headerFilter: true,
				        headerFilterParams: {
				            values: {
				                "이온질화": "이온질화",
				                "진공로": "진공로",
				                "템퍼링로": "템퍼링로",
				                "Box Type": "Box Type",
				                "PIT로": "PIT로",
				                "PQ": "PQ",
				                "Salt로": "Salt로",
				                "": ""
				            },
				            clearable: true
				        }
				    },	
				   
			    {title:"설비", field:"fac_name", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},     
				{title:"점검주기", field:"chs_gubn", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"}, 
				{title:"순번", field:"chs_sort", sorter:"string", width:150,
				    hozAlign:"center", headerFilter:"input"}, 
		        {title:"점검항목", field:"chs_hang", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},		        
		        {title:"기준방법", field:"chs_kijun", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"점검방법", field:"chs_chkmethod", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"조치방법", field:"chs_stepmethod", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input"},	
		        {title:"하한", field:"chs_min", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},  	
		        {title:"상한", field:"chs_max", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"단위", field:"chs_danw", sorter:"string", width:100,
				    hozAlign:"center", headerFilter:"input"},	
				{title:"사진", field:"chs_img", sorter:"string", width:100,
				    hozAlign:"center", headerFilter:"input"},
				    {title:"사진", field:"chs_code", sorter:"int", width:100,
					    hozAlign:"center", headerFilter:"input",visible:false}    
				    
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
				$('#jeomgeomInsertForm')[0].reset();
				

				/* Object.keys(data).forEach(function (key) {
			        const field = $('#jeomgeomInsertForm [name="' + key + '"]');

			        if (field.length) {
			            field.val(data[key]);
			        }
			        console.log('data',data);
				}); */

				jeomgeomInsertDetail(data.chs_code);
				console.log('data',data);
				 $('.delete').show();
			},
		});		
	}

		function jeomgeomInsertDetail(chs_code){
			$.ajax({
				url:"/tkheat/preservation/jeomgeomInsert/jeomgeomInsertDetail",
				type:"post",
				dataType:"json",
				data:{
					"chs_code":chs_code
				},
				success:function(result){
	//				console.log(result);
					var allData = result.data;
					
					for(let key in allData){
	//					console.log(allData, key);	
						$("input[name='"+key+"']").val(allData[key]);
					}
	
					$('.jgInsertModal').show().addClass('show');
				}
			});
		}

	

    </script>
    
    <script>
		
	//설비검색버튼 리스트 모달
    function openFacListModal() {
        document.getElementById('facListModal').style.display = 'flex';

        
        let facListTable = new Tabulator("#facListTabulator", {
            height:"450px",
            layout:"fitColumns",
            selectable:true,
            ajaxURL:"/tkheat/management/facInsert/getFacList",
            ajaxConfig:"POST",
            ajaxParams:{
                "fac_code": "",
                "fac_name": "",
                "fac_no":"",
                   
            },
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				console.log(response);
		        return response.data; //return the response data to tabulator
		    },    
            columns:[
                {title:"설비NO", field:"fac_code", width:120, hozAlign:"center",visible:false},
                {title:"설비명", field:"fac_name", width:150, hozAlign:"center"},
                {title:"설비번호", field:"fac_no", width:120, hozAlign:"center"},
                {title:"용도", field:"fac_yong", width:200, hozAlign:"center"},
            ],
            rowDblClick:function(e, row){
                let data = row.getData();
                
                console.log("선택된 설비:", data);
                document.getElementById('fac_code').value = data.fac_code;
                document.getElementById('fac_name').value = data.fac_name;
                document.getElementById('fac_no').value = data.fac_no;
                
                document.getElementById('facListModal').style.display = 'none';
            }
        });
    }

    function closeFacListModal() {
        document.getElementById('facListModal').style.display = 'none';
    }





	
  //설비점검기준등록 저장
    function save() {
	    var formData = new FormData($("#jeomgeomInsertForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.chs_code) {
	        formData.append("mode", "update");
	        formData.append("chs_code", selectedRowData.chs_code);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

	    $.ajax({
	    	url: "/tkheat/preservation/jeomgeomInsert/jeomgeomInsertSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	            alert("저장 되었습니다.");
	            $(".jgInsertModal").hide();
	            getJeomgeomInsertList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}



    function deleteJeomgeom() {
	    if (!selectedRowData || !selectedRowData.chs_code) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/preservation/jeomgeomInsert/jeomgeomDelete",
	        type: "POST",
	        data: {
	        	chs_code: selectedRowData.chs_code
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".jgInsertModal").hide();
	                getJeomgeomInsertList();
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




 // 드래그 기능 추가
	const modal = document.querySelector('.jgInsertModal');
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
	const jgInsertModal = document.querySelector('.jgInsertModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#jeomgeomInsertForm')[0].reset(); // 폼 초기화
	    jgInsertModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
	});

	closeButton.addEventListener('click', function() {
		jgInsertModal.style.display = 'none'; // 모달 숨김
	});

    //엑셀 다운로드
	$(".excel-button").click(function () {
	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "설비점검기준등록_" + today + ".xlsx";
	    userTable.download("xlsx", filename, { sheetName: "설비점검기준등록" });
	});
    

    </script>

	</body>
</html>
