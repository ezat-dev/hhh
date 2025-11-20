<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>sparePart관리</title>
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
.container2 {
	display: flex;
	justify-content: space-between;
}
.container3 {
	display: flex;
	justify-content: space-between;
}
.spareModal {
    position: fixed; /* 화면에 고정 */
    top: 50%; /* 수직 중앙 */
    left: 50%; /* 수평 중앙 */
    display : none;
    transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
    z-index: 1000; /* 다른 요소 위에 표시 */
}
.spareHisModal {
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
.header2 {
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
    height: 650px; /* 세로 길이 고정 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
    margin: 20px auto; /* 중앙 정렬 */
    padding: 20px;
    border-radius: 5px; /* 모서리 둥글게 */
    overflow-y: auto; /* 세로 스크롤 추가 */
}
#editPop2 {
    background: #ffffff;
    border: 1px solid #000000;
    width: 500px; /* 가로 길이 고정 */
    height: 650px; /* 세로 길이 고정 */
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
		<h4>sparePart 관리내역
			<button class="sparePartHisInsert">
            	입력
        	</button>
        	<button class="">
            	삭제
        	</button>
		</h4>
		
		<div class="container2">
			<div id="sub" class="tabulator"></div>
		</div>
	</main>
	
	
	
	
<form method="post" id="sparePartForm" name="sparePartForm">	
	<div class="spareModal">    
	  <div id="editPop">
	  	<div class="header">
	  		sparePart 리스트
	  	</div>
		<div class="detail">
			<table cellspacing="0" cellpadding="0" width="100%">
				<tbody><tr>
					<td>
						<table cellspacing="0" cellpadding="0" width="100%" class="insideTable" table-layout:fixed="">
							<tbody><tr>
								<th class="" style="width: 20%;">매입처</th>
								<td>
									<select id="spp_purchase" name="spp_purchase" class="basic valPost valClean" style="width:90%;">
	
										
											<option value="(주)금성풍력 서울지사">(주)금성풍력 서울지사</option>
										
											<option value="(주)대한히타">(주)대한히타</option>
										
											<option value="(주)동광화학">(주)동광화학</option>
										
											<option value="(주)성호기업">(주)성호기업</option>
										
											<option value="(주)세원에너지">(주)세원에너지</option>
										
											<option value="(주)알피네트웍스">(주)알피네트웍스</option>
										
											<option value="(주)제일연마영남영업소">(주)제일연마영남영업소</option>
										
											<option value="(주)한국하우톤온산공상">(주)한국하우톤온산공상</option>
										
											<option value="(주)한국PME">(주)한국PME</option>
										
											<option value="2000ENG">2000ENG</option>
										
											<option value="그랜드종합상">그랜드종합상</option>
										
											<option value="길호철강(주)">길호철강(주)</option>
										
											<option value="대광화학">대광화학</option>
										
											<option value="범우루브켐">범우루브켐</option>
										
											<option value="월드히타엔지니어링">월드히타엔지니어링</option>
										
											<option value="한성엠텍">한성엠텍</option>
										
									</select>
								</td>
							</tr>
							<tr>
								<th class="" style="width: 20%;">품번</th>
								<td>
									<input id="spp_no" name="spp_no" class="basic valPost valClean" type="text" style="width:90%;" value="">
									<!-- 
									<input id="spp_idx" name="spp_idx" class="basic valPost valClean" type="hidden" value="">
									 -->
								</td>
							</tr>
							<tr>
								<th class="left">품명</th>
								<td>
									<input id="spp_name" name="spp_name" class="basic valPost valClean" type="text" style="width:90%;" value="">
								</td>
							</tr>
							<tr>
								<th class="left">규격</th>
								<td>
									<input id="spp_gyu" name="spp_gyu" class="basic valPost valClean" type="text" style="width:90%;" value="">
								</td>
							</tr>
							<tr>
								<th class="left">교체주기</th>
								<td>
									<input id="spp_yong" name="spp_yong" class="basic valPost valClean" type="text" style="width:90%;" value="">
								</td>
							</tr>
							<tr>
								<th class="left">적정재고</th>
								<td>
									<input id="spp_proper" name="spp_proper" class="basic valPost valClean" type="text" style="width:90%;" value="">
								</td>
							</tr>
							<tr>
								<th class="left">비고</th>
								<td>
									<input id="spp_bigo" name="spp_bigo" class="basic valPost valClean" type="text" style="width:90%;" value="">
								</td>
							</tr>
	
	
	
						</tbody></table>
				</td></tr><tr>
					<td rowspan="3">
						<table class="insideTable" cellspacing="0" cellpadding="0" width="100%">
							<tbody>
							<tr>
								
								<th class="thSub2">이미지</th>
								<td class="tdRight">
									<div>
										<input id="imgInput0" class="imgInputClass valClean" type="file" name="file_url" title="이미지 찾기">
										<!-- <input type="button" value="X" onclick="$('#img0').attr('src', '/tkheat/css/image/no_image.png'); $('#imgInput0').val('');"> -->
										<a href="" class="form-control aphoto" download="">다운로드</a>
									</div>
									<div class="imgArea" style="width:200px; height:150px; border:1px solid #ddd;">
										<img id="img0" class="imgClass rp-img-popup" style="width:100%; height:100%;" src="/tkheat/css/image/no_image.png">
									</div>
								</td>
							</tr>
							</tbody>
						</table>
						<script type="text/javascript">
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
						</script>
					</td>
				</tr>
					
				
			</tbody></table>
		</div>
		<div class="btnSaveClose">
			<button class="delete" type="button" onclick="deleteSparePart();"  style="display: none;">삭제</button>
			<button class="save" type="button" onclick="save();">저장</button>
			<button class="close" type="button" onclick="window.close();">닫기</button>
    	 </div>
	</div>
</div>
</form>






			<!-- 서브 모달 -->
			<form method="post" id="sparePartHisForm" name="sparePartHisForm">	
				<div class="spareHisModal">    
				  <div id="editPop2">
				  	<div class="header2">
				  		sparePart 관리내역
				  	</div>
					<div class="detail2">
						<table cellspacing="0" cellpadding="0" width="100%">
							<tbody><tr>
								<td>
									<table cellspacing="0" cellpadding="0" width="100%" class="insideTable" table-layout:fixed="">
										<tbody><tr>
											<th class="" style="width: 20%;">매입처</th>
											<td>
												<input id="spp_purchase_his" name="spp_purchase_his" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
										<tr>
											<th class="" style="width: 20%;">품번</th>
											<td>
												<input id="spp_no_his" name="spp_no_his" class="basic valPost valClean" type="text" style="width:90%;" value="">
												<input id="spp_idx" name="spp_idx"  type="hidden">
											</td>
										</tr>
										<tr>
											<th class="left">품명</th>
											<td>
												<input id="spp_name_his" name="spp_name_his" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
										<tr>
											<th class="left">규격</th>
											<td>
												<input id="spp_gyu_his" name="spp_gyu_his" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
										<tr>
											<th class="left">교체주기</th>
											<td>
												<input id="spp_yong_his" name="spp_yong_his" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
										<tr>
											<th class="left">입고</th>
											<td>
												<input id="sph_input" name="sph_input" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
										<tr>
											<th class="left">수리출고</th>
											<td>
												<input id="sph_suriout" name="sph_suriout" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
										<tr>
											<th class="left">자산출고</th>
											<td>
												<input id="sph_jasanout" name="sph_jasanout" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
										<tr>
											<th class="left">비고</th>
											<td>
												<input id="sph_bigo" name="sph_bigo" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
										<tr>
											<th class="left">입력시간</th>
											<td>
												<input id="sph_time" name="sph_time" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
										<tr>
											<th class="left">담당자</th>
											<td>
												<input id="sph_user" name="sph_user" class="basic valPost valClean" type="text" style="width:90%;" value="">
											</td>
										</tr>
				
				
				
									</tbody></table>
									
							</td></tr>
								
							
						</tbody></table>
					</div>
					<div class="btnSaveClose">
						<button class="save2" type="button" onclick="saveSpareSub()">저장</button>
						<button class="close2" type="button" onclick="window.close();">닫기</button>
			    	 </div>
				</div>
			</div>
			</form>







	    
<script>
	//전역변수
    var cutumTable;	
    var isEditMode = false; //수정,최초저장 구분값
    let isSubEditMode = false;
    let selectedSubRowData = null;
	//로드
	$(function(){
		//전체 거래처목록 조회
		getSparePartList();
	});

	//이벤트
	//함수
	function getSparePartList(){
		
		userTable = new Tabulator("#tab1", {
		    height:"330px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/preservation/sparePart/getSparePartList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		    	{title:"제품", field:"file_name", width:100,
					hozAlign:"center", formatter:"image",
				    cssClass:"rp-img-popup",
			      	formatterParams:{
				      	height:"30px", width:"30px",
				      	urlPrefix:"/tkPrint/사진/SparePart관리/"
				      	}, 
				    cellMouseEnter:function(e, cell){ productImage(cell.getValue());} 
				    },
		    	{title:"NO", field:"idx", width:80, hozAlign:"center"},
		        {title:"NO", field:"spp_idx", sorter:"int", width:80,
		        	hozAlign:"center",visible:false},
		        {title:"NO", field:"spp_idx_his", sorter:"int", width:80,
			        hozAlign:"center",visible:false},	
		        {title:"매입처", field:"spp_purchase", sorter:"string", width:120,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"품번", field:"spp_no", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},     
				{title:"품명", field:"spp_name", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"}, 
				{title:"규격", field:"spp_gyu", sorter:"string", width:150,
				    hozAlign:"center", headerFilter:"input"}, 
		        {title:"교체주기", field:"spp_yong", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},		        
		        {title:"적정재고", field:"spp_proper", sorter:"int", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"비고", field:"spp_bigo", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"입고", field:"sph_input", sorter:"int", width:100,
			        hozAlign:"center", headerFilter:"input"},	
		        {title:"수리출고", field:"sph_suriout", sorter:"int", width:100,
		        	hozAlign:"center", headerFilter:"input"},  	
		        {title:"자산출고", field:"sph_jasanout", sorter:"int", width:100,
			        hozAlign:"center", headerFilter:"input"},	
			        { 
			        	  title: "현재고", field: "spp_jaigo", sorter: "int", width: 100,
			        	  hozAlign: "center", headerFilter: "input",
			        	  formatter: function(cell) {
			        	    const value = cell.getValue(); // 현재고
			        	    const rowData = cell.getRow().getData();
			        	    const proper = rowData.spp_proper; // 적정재고
			        	    const cellElement = cell.getElement();

			        	    if (value < proper) {
			        	      cellElement.style.backgroundColor = "#f99"; // 연한 빨강
			        	      cellElement.style.fontWeight = "bold";
			        	    } else {
			        	      cellElement.style.backgroundColor = ""; // 기본값
			        	      cellElement.style.fontWeight = "normal";
			        	    }
			        	    return value;
			        	  }
			        	}	
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
			    $("#spp_purchase_his").val(rowData.spp_purchase);
			    $("#spp_no_his").val(rowData.spp_no);
			    $("#spp_idx").val(rowData.spp_idx);  // hidden input
			    $("#spp_name_his").val(rowData.spp_name);
			    $("#spp_gyu_his").val(rowData.spp_gyu);
			    $("#spp_yong_his").val(rowData.spp_yong);
			    $("#sph_user").val(rowData.sph_user); // 담당자 필드

			    const now = new Date();
			    const formatted = now.getFullYear() + '-' +
			        String(now.getMonth() + 1).padStart(2, '0') + '-' +
			        String(now.getDate()).padStart(2, '0') + ' ' +
			        String(now.getHours()).padStart(2, '0') + ':' +
			        String(now.getMinutes()).padStart(2, '0') + ':' +
			        String(now.getSeconds()).padStart(2, '0');
			    $("#sph_time").val(formatted);

			    // 서브 모달 열기
			    /* $(".spareHisModal").show().addClass("show"); */

			 
			    if(rowData.spp_idx){
			        getSpareSubList(rowData.spp_idx);
			    }
				
			},
			rowDblClick:function(e, row){

				var data = row.getData();
				selectedRowData = data;
				isEditMode = true;
				console.log(selectedRowData.spp_idx)
				$('#sparePartForm')[0].reset();

				sparePartDetail(data.spp_idx);
				 $('.delete').show();
			},
		});		
	}



	

	function sparePartDetail(spp_idx){
		$.ajax({
			url:"/tkheat/preservation/sparePart/sparePartDetail",
			type:"post",
			dataType:"json",
			data:{
				"spp_idx":spp_idx
			},
			success:function(result){
//				console.log(result);
				var allData = result.data;
				
				for(let key in allData){
					console.log(allData, key);	
					$("input[name='"+key+"']").val(allData[key]);
				}

				// 이미지 초기화
				$("#img0").attr("src", "/tkheat/css/image/no_image.png");

				if (allData.file_name) {
					console.log("원본 파일명:", allData.file_name);
					console.log("인코딩된 경로:", encodeURIComponent(allData.file_name));
					const path = "/tkPrint/사진/SparePart관리/" + allData.file_name;
					console.log("path: ", path);
					$("#img0").attr("src", path);
					//$(".aphoto").attr("href", path).text(d.product_file_name);
				}

				$('.spareModal').show().addClass('show');
			}
		});
	}




	

	//SparePart 저장
    function save() {
	    var formData = new FormData($("#sparePartForm")[0]);

	    let confirmMsg = "";

	    if (isEditMode && selectedRowData && selectedRowData.spp_idx) {
	        formData.append("mode", "update");
	        formData.append("spp_idx", selectedRowData.spp_idx);
	        confirmMsg = "수정하시겠습니까?";
	    } else {
	        formData.append("mode", "insert");
	        confirmMsg = "저장하시겠습니까?";
	    }

	    if (!confirm(confirmMsg)) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/preservation/sparePart/sparePartSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function(result) {
	            alert("저장 되었습니다.");
	            $(".spareModal").hide();
	            getSparePartList();
	        },
	        error: function(xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}

    function deleteSparePart() {
	    if (!selectedRowData || !selectedRowData.spp_idx) {
	        alert("삭제할 대상을 선택하세요.");
	        return;
	    }

	    if (!confirm("삭제하시겠습니까?")) {
	        return;
	    }

	    $.ajax({
	        url: "/tkheat/preservation/sparePart/sparePartDelete",
	        type: "POST",
	        data: {
	        	spp_idx: selectedRowData.spp_idx
	        },
	        dataType: "json",
	        success: function(result) {
	            if (result.status === "success") {
	                alert("삭제되었습니다.");
	                $(".spareModal").hide();
	                getSparePartList();
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



	


	function getSpareSubList(spp_idx){
		
		subTable = new Tabulator("#sub", {
		    height:"330px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/preservation/sparePart/getSpareSubList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{spp_idx: spp_idx},
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#sub .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		    	
		        {title:"NO", field:"idx", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"매입처", field:"spp_purchase_his", sorter:"string", width:120,
			        hozAlign:"center"},	
			    {title:"품번", field:"spp_no_his", sorter:"string", width:120,
				    hozAlign:"center"},     
				{title:"품명", field:"spp_name_his", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"규격", field:"spp_gyu_his", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"교체주기", field:"spp_yong_his", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"입고", field:"sph_input", sorter:"int", width:100,
		        	hozAlign:"center"},
		        {title:"수리출고", field:"sph_suriout", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"자산출고", field:"sph_jasanout", sorter:"int", width:100,
			        hozAlign:"center"},	
		        {title:"비고", field:"sph_bigo", sorter:"int", width:100,
		        	hozAlign:"center"},  	
		        {title:"입력시간", field:"sph_time", sorter:"int", width:100,
			        hozAlign:"center"},	
			    {title:"담당자", field:"sph_user", sorter:"int", width:100,
				    hozAlign:"center"},	
				    {title:"NO", field:"spp_idx", sorter:"int", width:80,
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
			    const rowData = row.getData();

			    // 모드 설정
			    isSubEditMode = true;
			    selectedSubRowData = rowData;

			    $('#sparePartHisForm')[0].reset();
			    // 값 채우기
			    $("#spp_purchase_his").val(rowData.spp_purchase_his);
			    $("#spp_no_his").val(rowData.spp_no_his);
			    $("#spp_name_his").val(rowData.spp_name_his);
			    $("#spp_gyu_his").val(rowData.spp_gyu_his);
			    $("#spp_yong_his").val(rowData.spp_yong_his);
			    $("#sph_input").val(rowData.sph_input);
			    $("#sph_suriout").val(rowData.sph_suriout);
			    $("#sph_jasanout").val(rowData.sph_jasanout);
			    $("#sph_bigo").val(rowData.sph_bigo);
			    $("#sph_time").val(rowData.sph_time);
			    $("#sph_user").val(rowData.sph_user);
			    $("#spp_idx").val(rowData.spp_idx);
			    $(".spareHisModal").show().addClass("show");
			},
		});		
	}







	function saveSpareSub() {
	    var formData = new FormData($("#sparePartHisForm")[0]);

	    console.log(formData);
	    console.log($("#spp_idx").val());
	    if (!formData.get("spp_idx")) {
	        alert("대상이 선택되지 않았습니다.");
	        return;
	    }

	    let confirmMsg = isSubEditMode ? "수정하시겠습니까?" : "저장하시겠습니까?";
	    if (!confirm(confirmMsg)) return;

	    if (isSubEditMode) {
	        formData.append("mode", "update");
	    } else {
	        formData.append("mode", "insert");
	    }

	    $.ajax({
	        url: "/tkheat/preservation/sparePart/spareSubSave",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        dataType: "json",
	        success: function (res) {
	            alert("저장되었습니다.");
	            $(".spareHisModal").hide();
	            getSpareSubList(formData.get("spp_idx")); 
	            isSubEditMode = false;
	        },
	        error: function (xhr, status, error) {
	            console.error("저장 오류:", error);
	        }
	    });
	}

	

    </script>
    
    
    <script>
		
 	// 드래그 기능 추가
	const modal = document.querySelector('.spareModal');
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
	const spareModal = document.querySelector('.spareModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		spareModal.style.display = 'block'; // 모달 표시
		isEditMode = false;
		selectedRowData = null;

		$('#img0').attr('src', '/tkheat/css/image/no_image.png');
		$('#sparePartForm')[0].reset(); // 메인 폼 초기화
	});

	closeButton.addEventListener('click', function() {
		spareModal.style.display = 'none'; // 모달 숨김
	});
		



	//his 서브모달
	// 드래그 기능 추가
	const modal2 = document.querySelector('.spareHisModal');
	const header2 = document.querySelector('.header2'); // 헤더를 드래그할 요소로 사용

	header2.addEventListener('mousedown', function(e) {
		// transform 제거를 위한 초기 위치 설정
		const rect2 = modal2.getBoundingClientRect();
		modal2.style.left = rect2.left + 'px';
		modal2.style.top = rect2.top + 'px';
		modal2.style.transform = 'none'; // 중앙 정렬 해제

		let offsetX2 = e.clientX - rect.left;
		let offsetY2 = e.clientY - rect.top;

		function moveModal2(e) {
			modal2.style.left = (e.clientX - offsetX2) + 'px';
			modal2.style.top = (e.clientY - offsetY2) + 'px';
		}

		function stopMove2() {
			window.removeEventListener('mousemove', moveModal2);
			window.removeEventListener('mouseup', stopMove2);
		}

		window.addEventListener('mousemove', moveModal2);
		window.addEventListener('mouseup', stopMove2);
	});
		

	// 모달 열기
	const insertButton2 = document.querySelector('.sparePartHisInsert');
	const spareHisModal = document.querySelector('.spareHisModal');
	const closeButton2 = document.querySelector('.close2');

	insertButton2.addEventListener('click', function() {
		spareHisModal.style.display = 'block';

		isSubEditMode = false;
		selectedSubRowData = null;

//		$("#spp_idx").val('');
		$("#sph_input").val('');
		$("#sph_suriout").val('');
		$("#sph_jasanout").val('');
		$("#sph_bigo").val('');

		
		const now = new Date();
		const formatted = now.getFullYear() + '-' +
			String(now.getMonth() + 1).padStart(2, '0') + '-' +
			String(now.getDate()).padStart(2, '0') + ' ' +
			String(now.getHours()).padStart(2, '0') + ':' +
			String(now.getMinutes()).padStart(2, '0') + ':' +
			String(now.getSeconds()).padStart(2, '0');
		$("#sph_time").val(formatted);

		
		$("#sph_user").val($("#login_user").val() || "");
	});


	closeButton2.addEventListener('click', function() {
		spareHisModal.style.display = 'none'; 
	});


	$(".excel-button").click(function () {
	    const data1 = userTable.getData();
	    const data2 = subTable.getData();

	    const columns1 = userTable.getColumnDefinitions();
	    const columns2 = subTable.getColumnDefinitions();

	    const ws = XLSX.utils.aoa_to_sheet([]);
	    let rowIndex = 0;

	    //  [userTable] 삽입
	    if (data1.length > 0) {
	        const headers1 = columns1.map(col => col.title);
	        const fields1 = columns1.map(col => col.field);

	        XLSX.utils.sheet_add_aoa(ws, [["[SparePart 관리]"]], { origin: rowIndex++ });
	        XLSX.utils.sheet_add_aoa(ws, [headers1], { origin: rowIndex++ });

	        const rows1 = data1.map(row =>
	            fields1.map(f => row[f])
	        );
	        XLSX.utils.sheet_add_aoa(ws, rows1, { origin: rowIndex });
	        rowIndex += rows1.length;
	    }

	    rowIndex += 2; // 구분용 빈 줄


	    const headers2 = columns2.map(col => col.title);
	    const fields2 = columns2.map(col => col.field);

	    XLSX.utils.sheet_add_aoa(ws, [["[SparePart 관리]"]], { origin: rowIndex++ });
	    XLSX.utils.sheet_add_aoa(ws, [headers2], { origin: rowIndex++ });

	    //  [subTable] 삽입
	    if (data2.length > 0) {
	        const rows2 = data2.map(row =>
	            fields2.map(f => row[f])
	        );
	        XLSX.utils.sheet_add_aoa(ws, rows2, { origin: rowIndex });
	    }

	    // 열 너비 설정 (전체 최대 열 수 기준)
	    const maxCols = Math.max(
	        columns1.length,
	        columns2.length
	    );
	    ws['!cols'] = Array.from({ length: maxCols }, () => ({ wch: 20 }));

	    const wb = XLSX.utils.book_new();
	    XLSX.utils.book_append_sheet(wb, ws, "SparePart 관리");

	    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
	    const filename = "SparePart 관리_" + today + ".xlsx";
	    XLSX.writeFile(wb, filename);
	});

    </script>

	</body>
</html>
