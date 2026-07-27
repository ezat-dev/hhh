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
.row_select {
	    background-color: #ffeeba !important;
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
 

/* ========== 상단 도구바 ========== */
.tab {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 10px 14px;
    margin-bottom: 10px;
}
.button-container .select-button,
.button-container .insert-button,
.button-container .excel-button,
.button-container .printer-button {
    height: 34px;
    border: 1px solid #E2E8F0;
    border-radius: 8px;
    background: #F0F4F8;
    transition: background-color .13s, border-color .13s;
}
.button-container .select-button:hover,
.button-container .insert-button:hover,
.button-container .excel-button:hover,
.button-container .printer-button:hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
}

/* ========== 리스트/차트 카드 공통 (여러 패널을 한 화면에 보여주는 페이지라 자연스러운 세로 스크롤은 유지) ========== */
.view {
    display: flex;
    gap: 12px;
    margin-bottom: 12px;
    align-items: flex-start;
}
.view > div {
    flex: 1;
    min-width: 0;
}
#standardTable,
#dataTable,
#cpkCalcTable {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    overflow: hidden;
}
#xBar,
#rBar {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 10px;
    margin-bottom: 12px;
}

/* ========== Tabulator 리스트 재도장 (기준정보/측정값/계산값 테이블, 품번선택 모달은 제외) ========== */
#standardTable .tabulator-header,
#dataTable .tabulator-header,
#cpkCalcTable .tabulator-header {
    background: linear-gradient(135deg, #2B6CB0, #3182CE);
    border-bottom: none;
}
#standardTable .tabulator-col,
#dataTable .tabulator-col,
#cpkCalcTable .tabulator-col {
    background: transparent;
    border-right: 1px solid rgba(255,255,255,.15);
}
#standardTable .tabulator-col-title,
#dataTable .tabulator-col-title,
#cpkCalcTable .tabulator-col-title {
    color: #ffffff;
    font-weight: 700;
}
#standardTable .tabulator-row,
#dataTable .tabulator-row,
#cpkCalcTable .tabulator-row {
    border-bottom: 1px solid #EDF2F7;
    transition: background-color .12s;
}
#standardTable .tabulator-row.tabulator-row-even,
#dataTable .tabulator-row.tabulator-row-even,
#cpkCalcTable .tabulator-row.tabulator-row-even {
    background-color: #F7FAFC;
}
#standardTable .tabulator-row:hover,
#dataTable .tabulator-row:hover,
#cpkCalcTable .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#standardTable .tabulator-row.row_select,
#dataTable .tabulator-row.row_select,
#cpkCalcTable .tabulator-row.row_select {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#standardTable .tabulator-cell,
#dataTable .tabulator-cell,
#cpkCalcTable .tabulator-cell {
    border: 1px solid #E2E8F0;
    color: #2D3748;
}

/*품번모달*/
        .pumbunModal {
            display: none;
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            transition: opacity 0.3s ease-in-out;
        }
	    .pumbun-modal-content {
	        background: white;
	        width: 60%;
	        max-width: 1200px;
	        height: 80vh; 
	        overflow-y: auto; 
	        margin: 6% auto 0;
	        padding: 20px;
	        border-radius: 10px;
	        position: relative;
	        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	        transform: scale(0.8);
	        transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
	        opacity: 0;
	    }
        .pumbunModal.show {
            display: block;
            opacity: 1;
        }
        .pumbunModal.show .pumbun-modal-content {
            transform: scale(1);
            opacity: 1;
        }


        .pumbun-modal-content button {
            background-color: #d3d3d3;
            color: black;
            padding: 10px;
            border: none;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .pumbun-modal-content button:hover {
            background-color: #a9a9a9;
        }
        .pumbun-modal-content form {
            display: flex;
            flex-direction: column;
        }
        .pumbun-modal-content label {
            font-weight: bold;
            margin: 10px 0 5px;
        }
        .pumbun-modal-content input, .pumbun-modal-content textarea {
            width: 97%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .dayselect {
            width: 20%;
            text-align: center;
            font-size: 15px;
        }
        .daySet {
        	width: 20%;
      		text-align: center;
            height: 16px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
        .daylabel {
            margin-right: 10px;
            margin-bottom: 13px;
            font-size: 18px;
            margin-left: 20px;
        }

   
    </style>
    
    
    <body>
    <main class="main">
        <div class="tab">
        

            <div class="button-container">
            
               <div class="box1">
	
	            <label class="daylabel">조회일자 :</label>
	            <input type="text" id="s_sdate" class="dayselect daySet"/>
	            <label for="">~</label>
	            <input type="text" id="s_edate" class="dayselect daySet"/>
			    <label>품번</label>
			      
				<input type="text" name="w_pnum" class="dayselect" readonly="readonly" 
				style="cursor:pointer; border-color:red; padding:8px; margin-bottom:10px;" onclick="pumbunSelect();">
			</div>
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

        <div class="view">
        	<div id="standardTable"></div>
        </div>
        	<!-- 하이차트 - 1 -->
        	<div id="xBar"></div>
        	<!-- 하이차트 - 2 -->
        	<div id="rBar"></div>
        <div class="view">
            <div id="dataTable"></div>
             <div id="cpkCalcTable"></div>

	
		</div>
    </main>
	    
<div id="pumbunModal" class="pumbunModal">
  <div class="pumbun-modal-content">
    <span class="closePumbun">&times;</span>
    <!-- 추가, 수정 -->
    <h2>품번선택</h2>
    	<hr />
    	<div style="display:inline-block;">
			<label style="display:inline-block; width:40px;">거래처</label>
			<input type="text" id="s_client" class="pumModalEnter" style="text-align:left; display:inline-block; width:100px;">    	
			<label style="display:inline-block; width:40px;">품명</label>
			<input type="text" id="s_pname" class="pumModalEnter" style="text-align:left; display:inline-block; width:50px;">    	
			<label style="display:inline-block; width:40px;">규격</label>
			<input type="text" id="s_spec" class="pumModalEnter" style="text-align:left; display:inline-block; width:50px;">
			<button type="button" onclick="getPumbunData();">조회</button>			    	
    	</div>
    	<hr />
    
    <div id="pumbunTabu"></div>
    <hr />
	<button type="button" class="closePumbunModal">닫기</button>
  </div>
</div>
		
		
		  
<script>
let now_page_code = "f03";
var cpkListTable;
var selectedRowData = null;

$(function() {
	$("#s_sdate").val(yesterDate());
	$("#s_edate").val(todayDate());

	getStandardTable();	
	getCpkDataList();
	getCpkCalcList();
	getXbar();
	getRbar();
});

//이벤트
  $('.select-button').click(function() {	  
	  dataSearch();
  });
  

  $(".closePumbunModal, .closePumbun").click(function(){
	  $('#pumbunModal').removeClass('show').hide();
  });

//엑셀 다운로드
 $('.excel-download-button').click(function() {
	    dataTable.download("xlsx", "스페어부품 관리.xlsx", {sheetName:"스페어부품 관리",
	    	 visibleColumnsOnly: false //숨겨진 데이터도 출력
	    	 });
	});

 $(".excel-upload-button").on("click", function () {
     $("#fileInput").click(); 
 });

//함수

function dataSearch(){
	$.ajax({
		url:"/tkheat/quality/xBar/list",
		type:"post",
		dataType:"json",
		data:{
			"h_pnum" : $("input[name='w_pnum']").val(),
			"h_sdate" : $("#s_sdate").val(),
			"h_edate" : $("#s_edate").val()
		},success:function(result){
			console.log(result);
			standardTable.setData(result.standardData);
			cpkListTable.setData(result.cpkValueData);
			
			cpkCalc = result.cpkValueCalcData;
//			console.log(cpkCalc);
			var objArray = new Array();
			var obj1 = {"value1":"관리도계수표 - n", "value2":cpkCalc.n};
			var obj2 = {"value1":"관리도계수표 - d2", "value2":cpkCalc.d2};
			var obj3 = {"value1":"관리도계수표 - a2", "value2":cpkCalc.a2};
			var obj4 = {"value1":"관리도계수표 - d4", "value2":cpkCalc.d4};
			var obj5 = {"value1":"X관리도 - 관리상한(UCL)", "value2":cpkCalc.ucl_x};
			var obj6 = {"value1":"X관리도 - 평균값(CL=X)", "value2":cpkCalc.cl_x};
			var obj7 = {"value1":"X관리도 - 관리하한(LCL)", "value2":cpkCalc.lcl_x};
			var obj8 = {"value1":"R관리도 - 관리상한(UCL)", "value2":cpkCalc.ucl_r};
			var obj9 = {"value1":"R관리도 - 평균값(CL=R)", "value2":cpkCalc.cl_r};
			var obj10 = {"value1":"R관리도 - 관리하한(LCL)", "value2":"-"};
			var obj11 = {"value1":"공정능력분석 - R/d2", "value2":cpkCalc.r_d2};
			var obj12 = {"value1":"공정능력분석 - CP", "value2":cpkCalc.cp};
			var obj13 = {"value1":"공정능력분석 - k", "value2":cpkCalc.k};
			var obj14 = {"value1":"공정능력분석 - CPk", "value2":cpkCalc.cpk};
			
			
			objArray.push(obj1);
			objArray.push(obj2);
			objArray.push(obj3);
			objArray.push(obj4);
			objArray.push(obj5);
			objArray.push(obj6);
			objArray.push(obj7);
			objArray.push(obj8);
			objArray.push(obj9);
			objArray.push(obj10);
			objArray.push(obj11);
			objArray.push(obj12);
			objArray.push(obj13);
			objArray.push(obj14);
			
			cpkCalcTable.setData(objArray);
			
			var trendData = result.trendData;
			
			var x_avgObj = new Object();
			var x_uclObj = new Object();
			var x_clObj = new Object();
			var x_lclObj = new Object();
			var x_maxObj = new Object();
			var x_minObj = new Object();
			var r_uclObj = new Object();
			var r_clObj = new Object();
			var r_rmObj = new Object();

			var x_avg_save = new Array();
			var x_ucl_save = new Array();
			var x_cl_save = new Array();
			var x_lcl_save = new Array();
			var x_max_save = new Array();
			var x_min_save = new Array();
			var r_ucl_save = new Array();
			var r_cl_save = new Array();
			var r_rm_save = new Array();

			
			trendData.forEach(function(data, i){
				console.log(data);
				var x_avg = new Array();
				var x_ucl = new Array();
				var x_cl = new Array();
				var x_lcl = new Array();
				var x_max = new Array();
				var x_min = new Array();
				var r_ucl = new Array();
				var r_cl = new Array();
				var r_rm = new Array();
				
				
				x_avg.push(i);
				x_avg.push(data.g_avg)
				
				x_ucl.push(i);
				x_ucl.push(data.g_ucl_x);
				
				x_cl.push(i);
				x_cl.push(data.g_cl_x);
				
				x_lcl.push(i);
				x_lcl.push(data.g_lcl_x);
				
				x_max.push(i);
				x_max.push(data.g_max);
				
				x_min.push(i);
				x_min.push(data.g_min);
				
				r_ucl.push(i);
				r_ucl.push(data.g_ucl_r);
				
				r_cl.push(i);
				r_cl.push(data.g_cl_r);
				
				r_rm.push(i);
				r_rm.push(data.g_range);
				
				x_avg_save.push(x_avg);
				x_ucl_save.push(x_ucl);
				x_cl_save.push(x_cl);
				x_lcl_save.push(x_lcl);
				x_max_save.push(x_max);
				x_min_save.push(x_min);
				r_ucl_save.push(r_ucl);
				r_cl_save.push(r_cl);
				r_rm_save.push(r_rm);
			});

			x_avgObj = {"name":"X_AVG", "data":x_avg_save, "color":"black"};
			x_uclObj = {"name":"X_UCL", "data":x_ucl_save, "color":"blue"};
			x_clObj = {"name":"X_CL", "data":x_cl_save, "color":"green"};
			x_lclObj = {"name":"X_LCL", "data":x_lcl_save, "color":"blue"};
			x_maxObj = {"name":"X_MAX", "data":x_max_save, "color":"red"};
			x_minObj = {"name":"X_MIN", "data":x_min_save, "color":"red"};
			r_uclObj = {"name":"R_UCL", "data":r_ucl_save, "color":"red"};
			r_clObj = {"name":"R_CL", "data":r_cl_save, "color":"blue"};
			r_rmObj = {"name":"R_RANGE", "data":r_rm_save, "color":"black"};
			
			
			seriesArray[0] = x_avgObj;
			seriesArray[1] = x_uclObj;
			seriesArray[2] = x_clObj;
			seriesArray[3] = x_lclObj;
			seriesArray[4] = x_maxObj;
			seriesArray[5] = x_minObj;
			seriesArrayR[0] = r_uclObj;
			seriesArrayR[1] = r_clObj;
			seriesArrayR[2] = r_rmObj;
			
			getXbar();
			getRbar();
		}
	})
}


var standardTable;
function getStandardTable(){
	standardTable = new Tabulator('#standardTable', {
		    height: '80px',
		    layout: 'fitDataFill',
		    headerSort: false,
		    reactiveData: true,
		    columnHeaderVertAlign: "middle",
		    rowVertAlign: "middle",
		    headerHozAlign: 'center',
		    ajaxConfig: { method: 'POST' },
		    ajaxProgressiveLoad:"scroll",    
		    ajaxResponse:function(url, params, response){
				$("#standardTable .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    placeholder: "조회된 데이터가 없습니다.",
		    columns: [
		        //{ title: "no", field: "no", visible: false }, 
		      { title: "품번",field: "h_pnum",width: 300, hozAlign: "center" },		      
		      { title: "품명",field: "h_pname",width: 300, hozAlign: "center" },
		      { title: "규격",field: "h_gang",width: 200, hozAlign: "center" },
		      { title: "재질",field: "h_t_gb",width: 200, hozAlign: "center" },
		      { title: "상한",field: "h_hard_up",width: 200, hozAlign: "center" },
		      { title: "하한",field: "h_hard_dw",width: 200, hozAlign: "center" },
		    ],

		    rowClick: function(e, row) {
		      $('#standardTable .tabulator-row').removeClass('row_select');
		      row.getElement().classList.add('row_select');
		      selectedRowData = row.getData();
		    },
		  });
}

function getCpkDataList(){
	
	
	cpkListTable = new Tabulator('#dataTable', {
		    height: '400px',
		    layout: 'fitDataFill',	    
		    headerSort: false,
		    reactiveData: true,
		    columnHeaderVertAlign: "middle",
		    rowVertAlign: "middle",
		    headerHozAlign: 'center',    
		    ajaxResponse:function(url, params, response){
				$("#dataTable .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    placeholder: "조회된 데이터가 없습니다.",
		    columns: [
		        //{ title: "no", field: "no", visible: false }, 
		      { title: "일자", field: "h_day",width: 100, hozAlign: "center" },
		      { title: "시간", field: "h_time",width: 100, hozAlign: "center" },
		      { title: "측정값-1",field: "h_x1",width: 100, hozAlign: "center" },		      
		      { title: "측정값-2",field: "h_x2",width: 100, hozAlign: "center" },
		      { title: "측정값-3",field: "h_x3",width: 100, hozAlign: "center" },
		      { title: "X 평균",field: "h_avg",width: 100, hozAlign: "center" },
		      { title: "Range",field: "h_range",width: 100, hozAlign: "center" },
		    ],

		    rowClick: function(e, row) {
		      $('#dataTable .tabulator-row').removeClass('row_select');
		      row.getElement().classList.add('row_select');
		    },
		  });
}


var cpkCalcTable;
function getCpkCalcList(){
	cpkCalcTable = new Tabulator('#cpkCalcTable', {
		    height: '400px',
		    layout: 'fitDataFill',
		    headerSort: false,
		    reactiveData: true,
		    columnHeaderVertAlign: "middle",
		    rowVertAlign: "middle",
		    headerHozAlign: 'center',
		    ajaxConfig: { method: 'POST' },
		    ajaxProgressiveLoad:"scroll", 
		    ajaxResponse:function(url, params, response){
				$("#cpkCalcTable .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    placeholder: "조회된 데이터가 없습니다.",
		    columns: [
		      { title: "기준", field: "value1", width: 300, hozAlign: "center" },  	
		   	  { title: "값", field: "value2", width: 200, hozAlign: "center" }, 
		    ],

		    rowClick: function(e, row) {
		      $('#cpkCalcTable .tabulator-row').removeClass('row_select');
		      row.getElement().classList.add('row_select');
		    },
		  });
}




function pumbunSelect(){

	$("#pumbunModal").show().addClass('show');
	getPumbunList();
	getPumbunData();
}
var pumbunTabu;

function getPumbunData(){
	$.ajax({
		url: "/tkheat/quality/xBar/pumbun/list",
		type:"post",
		dataType:"json",
		data:{
	    	"w_client": $("#s_client").val(),
	    	"w_pname": $("#s_pname").val(),		    	
	    	"w_spec": $("#s_spec").val()			
		},success:function(result){
		console.log(result);
			pumbunTabu.setData(result.data);
		}
	})
	
}
function getPumbunList(){
	pumbunTabu = new Tabulator('#pumbunTabu', {
		    height: '300px',
		    layout: 'fitDataFill',
		    headerSort: false,
		    reactiveData: true,
		    columnHeaderVertAlign: "middle",
		    rowVertAlign: "middle",
		    headerHozAlign: 'center',
/*		    ajaxConfig: { method: 'POST' },
		    ajaxURL: "/tkheat/quality/xBar/pumbun/list",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams: { 
		    	"w_client": $("#s_client").val(),
		    	"w_pnum": $("#s_pnum").val(),		    	
		    	"w_spec": $("#s_spec").val()	    	
		    },	*/	    
		    ajaxResponse:function(url, params, response){
				$("#pumbunTabu .tabulator-col.tabulator-sortable").css("height","55px");
		        return response; //return the response data to tabulator
		    },
		    placeholder: "조회된 데이터가 없습니다.",
		    columns: [
		        //{ title: "no", field: "no", visible: false }, 
		      { title: "업체명", field: "corp_name",width: 120, hozAlign: "center" },
		      { title: "품명", field: "prod_name",width: 150, hozAlign: "center" },
		      { title: "품번", field: "prod_no",width: 150, hozAlign: "center" },
		      { title: "규격",field: "prod_gyu",width: 80, hozAlign: "center" },
		      { title: "재질",field: "prod_jai",width: 80, hozAlign: "center" },
/*		      { title: "소입온도(℃)",field: "w_qf",width: 110, hozAlign: "center" },
		      { title: "소려온도(℃)",field: "w_tf",width: 110, hozAlign: "center" },
		      { title: "CP(%)",field: "w_cp",width: 110, hozAlign: "center" },
		      { title: "장입기준량(kg)",field: "w_std_weight",width: 110, hozAlign: "center" },
		      { title: "요구경도",field: "w_hardness",width: 110, hozAlign: "center" },*/
		    ],

		    rowClick: function(e, row) {
		      $('#pumbunTabu .tabulator-row').removeClass('row_select');
		      row.getElement().classList.add('row_select');
		      selectedRowData = row.getData();
		    },

		    //더블클릭 했을때 
		    rowDblClick: function(e, row) {
		  	  var d = row.getData();
		  	  $("input[name='w_pnum']").val(d.prod_no);
		  		$('#pumbunModal').removeClass('show').hide();
		  			  
		  	}

		  });
}

//하이차트 설정
var seriesArray = new Array();
function getXbar(){	
    const chart = Highcharts.chart('xBar', {    	
    	chart: {
    		type:"line",        		
    		panning:true,
            panKey:"shift",
            zoomType:"x",
			styleMode: true,
			height:200
    	},
    	title: {
    		text:null
    	},
    	time:{
    		timezone: "Asia/Seoul",
    		useUTC: false
    	},
        yAxis: [{
        	crosshair:{
        		width:3,
        		color:'#5D5D5D',
        		zIndex:5
        	},
            title: {
                text: '값'
            },
            labels:{
            	style:{
            		fontSize:"10pt"
            	}
            }
        }],
        xAxis: {
        	crosshair:{
        		width:3,
        		color:'#5D5D5D',
        		zIndex:5
        	},
//			tickAmount:11,
        	labels:{
        		style:{
        			fontSize:"11pt"
        		}
        	},
        	allowDecimals:false
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },
        plotOptions: {
            series: {
            	selected:true,
            	marker:{
                	radius:1
            	}
            }
        },
        series: seriesArray,
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 1200
                },
                chartOptions: {
                    legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    }
                }
            }]
        },
        exporting:{
            menuItemDefinitions: {
                // Custom definition
                label: {
                    onclick: function () {
                        this.renderer.label(
                            'You just clicked a custom menu item',
                            100,
                            100
                        )
                            .attr({
                                fill: '#a4edba',
                                r: 5,
                                padding: 10,
                                zIndex: 10
                            })
                            .css({
                                fontSize: '1.5em'
                            })
                            .add();
                    },
                    text: 'Show label'
                }
            },
            buttons: {
                contextButton: {
                    menuItems: ['downloadPNG', 'downloadPDF', 'downloadXLS', 'separator']
                }
            }
        },
        legend:{
            itemStyle:{
                fontSize: "11pt"
            }
		}
    });
    
}

var seriesArrayR = new Array();
function getRbar(){	
    const chart = Highcharts.chart('rBar', {    	
    	chart: {
    		type:"line",        		
    		panning:true,
            panKey:"shift",
            zoomType:"x",
			styleMode: true,
			height:200
    	},
    	title: {
    		text:null
    	},
    	time:{
    		timezone: "Asia/Seoul",
    		useUTC: false
    	},
        yAxis: [{
        	crosshair:{
        		width:3,
        		color:'#5D5D5D',
        		zIndex:5
        	},
            title: {
                text: '값'
            },
            labels:{
            	style:{
            		fontSize:"10pt"
            	}
            }
        }],
        xAxis: {
        	crosshair:{
        		width:3,
        		color:'#5D5D5D',
        		zIndex:5
        	},
//			tickAmount:11,
        	labels:{
        		style:{
        			fontSize:"11pt"
        		}
        	},
        	allowDecimals:false
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },
        plotOptions: {
            series: {
            	selected:true,
            	marker:{
                	radius:1
            	}
            }
        },
        series: seriesArrayR,
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 1200
                },
                chartOptions: {
                    legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    }
                }
            }]
        },
        exporting:{
            menuItemDefinitions: {
                // Custom definition
                label: {
                    onclick: function () {
                        this.renderer.label(
                            'You just clicked a custom menu item',
                            100,
                            100
                        )
                            .attr({
                                fill: '#a4edba',
                                r: 5,
                                padding: 10,
                                zIndex: 10
                            })
                            .css({
                                fontSize: '1.5em'
                            })
                            .add();
                    },
                    text: 'Show label'
                }
            },
            buttons: {
                contextButton: {
                    menuItems: ['downloadPNG', 'downloadPDF', 'downloadXLS', 'separator']
                }
            }
        },
        legend:{
            itemStyle:{
                fontSize: "11pt"
            }
		}
    });
    
}
		
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
