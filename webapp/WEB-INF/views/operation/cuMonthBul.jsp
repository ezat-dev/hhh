<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>월별거래처별불량현황</title>
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
.container2 {
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
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -1035px;
}
 
.box1 momth{
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

.box1 momth:focus {
	border: 1px solid #007bff;
	background-color: #fff;
}  
.box1 select{
	width: 5%
}  
.box1 select{
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

.box1 select:focus {
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
	        
	        
			<label class="daylabel">월선택 : </label>
			<input type="month" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off">
			
			<label class="daylabel">불량구분 : </label>
		<select id="werr_in_out_gubn" class="werr_in_out_gubn" style="font-size: 16px;">
		  <option value="사내">사내</option>
		  <option value="사외">사외</option>
		</select>
			
				
		</div>
	    <div class="button-container">
	        <button class="select-button" onclick="getCuMonthBulList(); getCuBulSubList();">
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
			<!-- <div id="cuMonthBulChart" style="width: 100%; height: 400px; margin-top: 20px;"></div> -->
			<h4>항목</h4>
			<div class="container2">
				<div id="sub" class="tabulator"></div>
			</div>
		</main>
	    
	    
<script>
	//전역변수
    var cutumTable;	
    var sdate = $("#sdate").val();
	//로드
	$(function(){
		//전체 거래처목록 조회
		getCuMonthBulList();
		getCuBulSubList();
	});

	//이벤트
	//함수
	function getCuMonthBulList(){
    userTable = new Tabulator("#tab1", {
        height:"370px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/operation/cuMonthBul/getCuMonthBulList",
        ajaxProgressiveLoad:"scroll",
        ajaxParams:{
            "sdate": $("#sdate").val(),
            "werr_in_out_gubn": $("#werr_in_out_gubn").val(),
        },
        placeholder:"조회된 데이터가 없습니다.",
        paginationSize:20,
        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
            return response;
        },
        columns:[
            {title:"NO", field:"idx", sorter:"int", width:80, hozAlign:"center"},
            {title:"업체명", field:"corp_name", sorter:"string", width:100, hozAlign:"center", headerFilter:"input"},

            {title:"총납품수량", field:"och_su", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"불량수량", field:"werr_su", sorter:"number", width:60, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },

            {
                title: "불량요인",
                columns: [
                    { title: "찍힘", field: "werr_gubn1", width: 70, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                    { title: "외관(이물)", field: "werr_gubn2", width: 80, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                    { title: "외관(조도)", field: "werr_gubn3", width: 80, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                    { title: "외관(발청)", field: "werr_gubn4", width: 80, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                    { title: "경도", field: "werr_gubn5", width: 70, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                    { title: "경화깊이", field: "werr_gubn6", width: 80, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                    { title: "조직", field: "werr_gubn7", width: 70, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                    { title: "크랙", field: "werr_gubn8", width: 70, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                    { title: "사양오정용", field: "werr_gubn9", width: 80, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                    { title: "변형", field: "werr_gubn10", width: 70, hozAlign: "right",
                        formatter:"money",
                        formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                        bottomCalc:"sum",
                        bottomCalcFormatter:"money",
                        bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
                    },
                ],
            },

            {title:"불량율(PPM)", field:"ppm", sorter:"number", width:120, hozAlign:"center"},

            {title:"총 납품금액", field:"och_mon", sorter:"number", width:120, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"불량금액", field:"werr_mon", sorter:"number", width:120, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"불량금액률(%)", field:"ppm_mon", sorter:"number", width:120, hozAlign:"center"},
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },
        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
                if($(this).hasClass("row_select")){
                    $(this).removeClass('row_select');
                    row.getElement().className += " row_select";
                } else {
                    $("#tab1 div.row_select").removeClass("row_select");
                    row.getElement().className += " row_select";
                }
            });
        },
    });
}



function getCuBulSubList(){
    subTable = new Tabulator("#sub", {
        height:"165px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/operation/cuMonthBul/getCuBulSubList",
        ajaxProgressiveLoad:"scroll",
        ajaxParams:{
            "sdate": $("#sdate").val(),
            "werr_in_out_gubn": $("#werr_in_out_gubn").val(),
        },
        placeholder:"조회된 데이터가 없습니다.",
        paginationSize:20,
        ajaxResponse:function(url, params, response){
            $("#sub .tabulator-col.tabulator-sortable").css("height","55px");
            return response;
        },
        columns:[
            {title:"항목", field:"quantityItem", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"1월", field:"m1", sorter:"number", width:120, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"2월", field:"m2", sorter:"number", width:120, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"3월", field:"m3", sorter:"number", width:150, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"4월", field:"m4", sorter:"number", width:120, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"5월", field:"m5", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"6월", field:"m6", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"7월", field:"m7", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"8월", field:"m8", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"9월", field:"m9", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"10월", field:"m10", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"11월", field:"m11", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"12월", field:"m12", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
            {title:"평균", field:"average_SUM", sorter:"number", width:100, hozAlign:"right",
                formatter:"money",
                formatterParams: { decimal: ".", thousand: ",", precision: 0 },
                bottomCalc:"sum",
                bottomCalcFormatter:"money",
                bottomCalcFormatterParams: { decimal: ".", thousand: ",", precision: 0 }
            },
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },
        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
                if($(this).hasClass("row_select")){
                    $(this).removeClass('row_select');
                    row.getElement().className += " row_select";
                } else {
                    $("#tab1 div.row_select").removeClass("row_select");
                    row.getElement().className += " row_select";
                }
            });
        },
    });
}


    </script>

	</body>
</html>
