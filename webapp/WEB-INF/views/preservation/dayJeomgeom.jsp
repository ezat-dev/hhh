<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비점검현황(일별)</title>
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
	margin-left: -400px;
}

.box1 select{
	width: 5%
}  
.box1 input[type="text"] {
	width: 100px;
	padding: 5px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	color: #333;
	outline: none;
	transition: border 0.3s ease;
}

.box1 input[type="text"]:focus {
	border: 1px solid #007bff;
	background-color: #fff;
}  
.box1 label,
.box1 input {
	margin-right: 10px; /* 요소 사이 간격 */
} 

.dayJeomgeomModal {
	position: fixed; /* 화면에 고정 */
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 1000; /* 다른 요소 위에 표시 */
}
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.modal-content {
  background: white;
  padding: 20px 30px;
  border-radius: 10px;
  width: 90%;
  position: relative;
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
  font-size: 20px;
  margin-bottom: 20px;
}

.modal-close {
  cursor: pointer;
  font-size: 28px;
}

.modal-form {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 15px 30px;
  margin-bottom: 20px;
}

.form-row {
  display: flex;
  flex-direction: column;
}

.form-row label {
  font-weight: bold;
  margin-bottom: 6px;
  font-size: 14px;
}

.modal-form-inline {
  display: flex;
  flex-wrap: wrap; /* 혹시 너비 넘치면 줄바꿈 */
  align-items: center;
  gap: 10px;
  margin-bottom: 15px;
  flex-wrap: nowrap; /* 가능한 한 줄 유지 */
  overflow-x: auto;
}

.modal-form-inline label {
  font-size: 14px;
  font-weight: bold;
}

.input-field {
  font-size: 14px;
  padding: 5px 8px;
  width: 150px;
  min-width: 130px;
  max-width: 180px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
    
    .subSearch {
  padding: 6px 14px;
  font-size: 14px;
  background-color: #3498db;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  white-space: nowrap;
  transition: background-color 0.2s ease;
}

.subSearch:hover {
  background-color: #2980b9;
}
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -1220px;
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

    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>        
		<label class="daylabel">날짜검색 : </label>
		<input type="date" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off">
				
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getDayJeomgeomList();">
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
	
	
	
	
	<div id="dayJeomgeomModal" class="modal-overlay" style="display: none;">
  <div class="modal-content">
    <div class="modal-header">
  <span class="modal-title">설비 리스트</span>
  <span class="modal-close" onclick="closeDayJeomgeomModal()">&times;</span>
</div>




<div class="modal-form-inline">
  <label for="sdate">일자</label>
  <input type="date" id="sdate" class="input-field">

  <label for="fac_code">설비</label>
  <select id="fac_code" class="input-field">
    <option value="">설비 선택</option>
    <option value="5">고주파 1호기(폐기)</option>
    <option value="6">고주파 2호기 (폐기)</option>
    <option value="9">고주파 5호기</option>
    <option value="10">변성로 1호기</option>
    <option value="11">변성로 2호기</option>
    <option value="12">쇼트 1호기</option>
    <option value="13">쇼트 2호기</option>
    <option value="14">쇼트 3호기</option>
    <option value="19">쇼트 4호기</option>
    <option value="15">진공세정기 2호기</option>
    <option value="1">침탄로 1호기</option>
    <option value="2">침탄로 2호기</option>
    <option value="3">침탄로 3호기</option>
    <option value="4">침탄로 4호기</option>
    <option value="18">침탄로 5호기</option>
    <option value="16">템퍼링기 1호기</option>
    <option value="17">템퍼링기 2호기</option>
  </select>

  <label for="chs_gubn">점검주기</label>
  <select id="chs_gubn" class="input-field">
    <option value="">점검주기 선택</option>
    <option value="일상">일상</option>
    <option value="주간">주간</option>
    <option value="월간">월간</option>
    <option value="분기">분기</option>
    <option value="반기">반기</option>
    <option value="공정순회">공정순회</option>
  </select>

  <label for="chs_gubn_detail">주야간</label>
  <select id="chs_gubn_detail" class="input-field">
    <option value="">주야간 선택</option>
    <option value="주간">주간</option>
    <option value="야간">야간</option>
  </select>

  <label for="chs_sort">기준순서</label>
  <select id="chs_sort" name="chs_sort" class="input-field">
    <option value="">점검기준순서 선택</option>
  </select>

  <label for="che_pan">판정</label>
  <select id="che_pan" class="input-field">
    <option value="">판정 선택</option>
    <option value="양호">양호</option>
    <option value="수리">수리</option>
  </select>
  <button class="subSearch" id="subSearch" onclick="OpenDayJeomgeomModal();">검색</button>
</div>



<div id="dayJeomgeomTabulator" style="height: 500px; margin-top: 20px;"></div>
				</div>
				</div>				
				
			

	    
	    
<script>
	//전역변수
	let now_page_code = "e06";
    var cutumTable;	

	//로드
	$(function(){
		//전체 거래처목록 조회
		getDayJeomgeomList();
	});

	//이벤트
	//함수
	function getDayJeomgeomList(){
	userTable = new Tabulator("#tab1", {
	    height:"750px",
	    layout:"fitColumns",
	    selectable:true,
	    tooltips:true,
	    selectableRangeMode:"click",
	    reactiveData:true,
	    headerHozAlign:"center",
	    ajaxConfig:"POST",
	    ajaxLoader:false,
	    ajaxURL:"/tkheat/preservation/dayJeomgeom/getDayJeomgeomList",
	    ajaxProgressiveLoad:"scroll",
	    ajaxParams:{"sdate": $("#sdate").val(),},
	    placeholder:"조회된 데이터가 없습니다.",
	    paginationSize:20,
	    ajaxResponse:function(url, params, response){
			$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
	        return response;
	    },
	    columns:[
			{title:"점검일시", field:"che_date", sorter:"string", width:120, hozAlign:"center"},	
			{title:"설비", field:"fac_name", sorter:"string", width:80, hozAlign:"center"},     
			{title:"점검주기", field:"chs_gubn", sorter:"string", width:60, hozAlign:"center"}, 
			{title:"순번", field:"chs_sort", sorter:"string", width:60, hozAlign:"center"}, 
			{title:"점검항목", field:"chs_hang", sorter:"string", width:100, hozAlign:"center"},		        
			{title:"기준방법", field:"chs_kijun", sorter:"string", width:100, hozAlign:"center"},
			{title:"단위", field:"chs_danw", sorter:"string", width:80, hozAlign:"center"},
			{title:"하한", field:"chs_min", sorter:"string", width:60, hozAlign:"center"},	
			{title:"상한", field:"chs_max", sorter:"int", width:60, hozAlign:"center"},  	
			{title:"X1", field:"che_x1", sorter:"int", width:60, hozAlign:"center"},	
			{
				title: "점검",
				field: "che_pan",
				sorter: "string",
				width: 100,
				hozAlign: "center",
				formatter: function(cell){
					const value = cell.getValue();
					let bgColor = "";
					let color = "#fff";
					if (value === "수리" || value === "주의") {
						bgColor = "#e74c3c";
					} else if (value === "양호") {
						bgColor = "#3498db";
					} else {
						bgColor = "";
						color = "#000";
					}
					const el = cell.getElement();
					el.style.backgroundColor = bgColor;
					el.style.color = color;
					el.style.fontWeight = "bold";
					return value;
				}
			},
			{
				title: "관리자확인", hozAlign: "center", columns: [ 
					{
						title: "확인유무", field: "che_check", hozAlign: "center",
						editor: "tickCross",
						editorParams: {
							tristate: false,
							allowEmpty: true,
							indeterminateValue: "0",
							trueValue: "1",
							falseValue: "0"
						}
					},
					{
						title: "재측정값", field: "che_rx1", hozAlign: "center",
						editor: function(cell){
							const pan = cell.getRow().getData().che_pan;
							if(pan === "수리" || pan === "주의"){
								return "input";
							}
							return false;
						}
					},
					{
						title: "재점검", field: "che_re_pan", hozAlign: "center",
						editor: function(cell){
							const pan = cell.getRow().getData().che_pan;
							if(pan === "수리" || pan === "주의"){
								return "input";
							}
							return false;
						}
					}
				]
			},
			{
				title: "조치내용", field: "che_jochi_contents", hozAlign: "center",
				editor: function(cell){
					const pan = cell.getRow().getData().che_pan;
					if(pan === "수리" || pan === "주의"){
						return "input";
					}
					return false;
				}
			},
			{ title: "요청내역", field: "che_req", hozAlign: "center", editor: "input" },
			{ title: "완료내역", field: "che_fin", hozAlign: "center", editor: "input" },
			{ title: "비고", field: "che_bigo", hozAlign: "center", editor: "input" },

			{ title: "chs_code", field: "chs_code", visible: false },
			{ title: "che_code", field: "che_code", visible: false }
	    ],
	    rowFormatter: function(row){
	        const data = row.getData();
	        row.getElement().style.fontWeight = "700";
	        row.getElement().style.backgroundColor = "#FFFFFF";

	        const cells = row.getCells();

	        // 점검 '양호'일 때 → 비활성 처리
	        if(data.che_pan === "양호"){
	            cells.forEach(cell => {
	                const field = cell.getColumn().getField();
	                if(field === "che_rx1" || field === "che_re_pan" || field === "che_jochi_contents"){
	                    cell.getElement().style.backgroundColor = "#808080";
	                    cell.getElement().style.color = "#fff";
	                    cell.getElement().style.fontWeight = "bold";
	                }
	            });
	        }

	        // 점검값 조건에 따라 하한, 상한, X1 폰트색 설정
	        const isRed = (data.che_pan === "수리" || data.che_pan === "주의");
	        const isGreen = (data.che_pan === "양호");

	        cells.forEach(function(cell){
	            const field = cell.getColumn().getField();

	            if(field === "chs_min" || field === "chs_max" || field === "che_x1"){
	                if(isRed){
	                    cell.getElement().style.color = "#e74c3c";
	                } else if(isGreen){
	                    cell.getElement().style.color = "#27ae60";
	                }
	            }
	        });
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
			// 여기에 필요 시 선택 후 추가 로직
		}
	});		
}





	function OpenDayJeomgeomModal() {
        document.getElementById('dayJeomgeomModal').style.display = 'flex';

        let facListTable = new Tabulator("#dayJeomgeomTabulator", {
            height:"450px",
            layout:"fitColumns",
            selectable:true,
            ajaxURL:"/tkheat/preservation/dayJeomgeom/dayJeomgeomSubList",
            ajaxConfig:"POST",
            ajaxParams:{
            	fac_code: $('#fac_code').val(),
				chs_gubn: $('#chs_gubn').val(),
				chs_gubn_detail: $('#chs_gubn_detail').val(),
				che_date : $('#sdate').val(),
				chs_sort : $('#chs_sort').val(),
				che_pan : $('#che_pan').val()
                   
            },
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				console.log(response);
		        return response; //return the response data to tabulator
		    },    
            columns:[
                {title:"점검기준코드", field:"chs_std_code", width:120, hozAlign:"center"},
                {title:"점검기준순서", field:"chs_sort", width:120, hozAlign:"center"},
                {title:"설비명", field:"fac_name", width:150, hozAlign:"center"},
                {title:"점검주기", field:"chs_gubn", width:100, hozAlign:"center"},
                {title:"주야간구분", field:"chs_gubn_detail", width:100, hozAlign:"center"},
                {title:"점검항목", field:"chs_hang", width:200, hozAlign:"center"},
                {title:"기준방법", field:"chs_kijun", width:200, hozAlign:"center"},
                {title:"하한", field:"chs_min", width:200, hozAlign:"center"},
                {title:"상한", field:"chs_max", width:200, hozAlign:"center"},
                {title:"단위", field:"chs_danw", width:200, hozAlign:"center"},
                {title:"측정값", field:"che_x1", width:200, hozAlign:"center"},
                {title:"점검방법", field:"chs_chkmethod", width:200, hozAlign:"center"},
                {title:"조치방법", field:"chs_stepmethod", width:200, hozAlign:"center"},
                {title:"fac_code", field:"fac_code", width:200, hozAlign:"center",visible:false},
                
            ],
            rowDblClick:function(e, row){
                let data = row.getData();
                
                
                document.getElementById('dayJeomgeomModal').style.display = 'none';
            }
        });
    }

    function closeDayJeomgeomModal() {
        document.getElementById('dayJeomgeomModal').style.display = 'none';
    }


    


	

    </script>

	</body>
</html>
