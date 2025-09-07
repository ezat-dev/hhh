<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자주검사불량조치관리</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
    <style>
.main {
	width: 98%;
}

.container {
	display: flex;
	justify-content: space-between;
}

.jajujochiModal {
	position: fixed; /* 화면에 고정 */
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 1000; /* 다른 요소 위에 표시 */
}

.detail {
	background: #ffffff;
	border: 1px solid #000000;
	width: 1300px; /* 가로 길이 고정 */
	height: 800px; /* 세로 길이 고정 */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
	margin: 20px auto; /* 중앙 정렬 */
	padding: 20px;
	border-radius: 5px; /* 모서리 둥글게 */
	overflow-y: auto; /* 세로 스크롤 추가 */
	position: relative; /* 자식 요소의 절대 위치 설정을 위한 기준 */
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
	font-size : 14px;
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
        <button class="select-button" onclick="getJajuJochiList();">
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
        <button class="printer-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
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
	    
	    
<form method="post" id="jajuJochiForm" name="jajuJochiForm">    
	<div class="jajujochiModal">    
	 <div class="detail">
       <div class="header">
            자주검사불합격등록
        </div>

        <table cellspacing="0" cellpadding="0" width="100%">
            <tbody>
                <tr>
                    <td>
                        <input class="btnSearchWork" type="button" title="" value="불합격현황 검색" onclick="openJajuListModal();">
                        <table cellspacing="0" cellpadding="0" width="80%" class="insideTable">
                            <colgroup span="6">
                                <col width="*">
                                <col width="20%">
                                <col width="*">
                                <col width="20%">
                                <col width="*">
                                <col width="20%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="left">거래처</th>
                                    <td>
                                        <input id="corp_name" name="corp_name" class="basic valPost valClean" type="text" style="width:90%;" value="" readonly="">
                                        <input id="corp_code" name="corp_code" class="basic valPost valClean" type="text" style="width:90%;" value="" readonly="">
                                    </td>
                                    <th><span class="left">품명</span></th>
                                    <td><input id="prod_name" name="prod_name" class="basic valPost valClean" type="text" style="width:90%;" value="" readonly=""></td>
                                    <th><span class="left">품번</span></th>
                                    <td><input id="prod_no" name="prod_no" class="basic valPost valClean" type="text" style="width:90%;" value="" readonly=""></td>
                                </tr>
                                <tr>
                                    <th class="left">관리번호</th>
                                    <td><input id="" class="basic valClean" type="text" style="width:90%;" value=""></td>
                                    <th class="left">작성일</th>
                                    <td><input type="text" id="jerr_rdate" name="jerr_rdate" size="10" maxlength="10" value="2025-03-26" class="date valPost valClean hasDatepicker" style="width:85px;"></td>
                                    <th><span class="left">관리번호</span></th>
                                    <td><input id="" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
                                </tr>
                                <tr>
                                    <th class="left">발생일자</th>
                                    <td><input type="text" id="jerr_sdate" name="jerr_sdate" size="10" maxlength="10" value="2025-03-26" class="date valPost valClean hasDatepicker" style="width:85px;"></td>
                                    <th><span class="left">발생부서</span></th>
                                    <td><input id="jerr_sbuso" name="jerr_sbuso" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
                                    <th><span class="left">발생자</span></th>
                                    <td><input id="jerr_sman" name="jerr_sman" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
                                </tr>
                                <tr>
                                    <th class="left">보고자</th>
                                    <td><input id="jerr_rman" name="jerr_rman" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
                                    <th><span class="left">수,중량</span></th>
                                    <td><input id="jerr_su" name="jerr_su" class="basic valPost valClean" type="text" style="width:90%;" value=""></td>
                                    <th><span class="left">설비</span></th>
                                    <td><input id="fac_name" name="fac_name" class="basic valPost valClean" type="text" style="width:90%;" value="" readonly=""></td>
                                    <td><input class="btnSearchFac" type="button" onclick="openFacListModal();" value="설비검색"></td>
                                    <td><input id="fac_code" name="fac_code" class="basic valPost valClean hidden" type="text" style="width:90%;" value="" readonly=""></td>
                                </tr>
                            </tbody>
                        </table>
                        <table cellspacing="0" cellpadding="0" width="80%" class="insideTable">
                            <colgroup span="4">
                                <col width="20%">
                                <col width="30%">
                                <col width="20%">
                                <col width="30%">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="">부적합구분</th>
                                    <td>
                                        <select id="jerr_gubn" name="jerr_gubn" class="basic valPost valClean" type="text" style="width:100px;">
                                            <option>경도</option>
                                            <option>경화깊이</option>
                                            <option>조직</option>
                                            <option>크랙</option>
                                            <option>사양오적용(혼입)</option>
                                            <option>변형</option>
                                        </select>
                                    </td>
                                    <th rowspan="8">개선전</th>
                                    <td rowspan="8">
                                        <div>
                                            <input id="imgInput0" class="imgInputClass valClean" type="file" title="이미지 찾기">
                                            <input type="button" value="X" onclick="$('#img0').attr('src', '/resources/images/noimage_01.gif'); $('#imgInput0').val('');">
                                        </div>
                                        <div class="imgArea" style="width:200px; height:150px; border:1px solid #ddd;">
                                            <img id="img0" class="imgClass" style="width:100%; height:100%;" src="/resources/images/noimage_01.gif">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="left">부적합내용</th>
                                    <td class=""><textarea  name="jerr_acontents" id="jerr_acontents" class="basic valPost valClean" style="width:90%; height:60px;"></textarea></td>
                                </tr>
                                <tr>
                                    <th class="left">발생원인 및 원인분석</th>
                                    <td class=""><textarea  name="jerr_bcontents" id="jerr_bcontents" class="basic valPost valClean" style="width:90%; height:60px;"></textarea></td>
                                </tr>
                                <tr>
                                    <th class="left">조치구분</th>
                                    <td>
                                        <select id="jerr_jgubn" name="jerr_jgubn" class="basic valPost valClean" type="text" style="width:150px;">
                                            <option>재작업</option>
                                            <option>대기</option>
                                            <option>합격</option>
                                            <option>불합격</option>
                                        </select>
                                    </td>
                                    <th rowspan="8">개선후</th>
                                    <td rowspan="8">
                                        <div>
                                            <input id="imgInput1" class="imgInputClass valClean" type="file" title="이미지 찾기">
                                            <input type="button" value="X" onclick="$('#img1').attr('src', '/resources/images/noimage_01.gif'); $('#imgInput1').val('');">
                                        </div>
                                        <div class="imgArea" style="width:200px; height:150px; border:1px solid #ddd;">
                                            <img id="img1" class="imgClass" style="width:100%; height:100%;" src="/resources/images/noimage_01.gif">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="left">대책수립 및 대책실시</th>
                                    <td class=""><textarea id="jerr_dcontents" name="jerr_dcontents" class="basic valPost valClean" style="width:90%; height:60px;"></textarea></td>
                                </tr>
                                <tr>
                                    <th class="left">결과분석 및 사후관리</th>
                                    <td class=""><textarea id="jerr_econtents" name="jerr_econtents" class="basic valPost valClean" style="width:90%; height:60px;"></textarea></td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="btnSaveClose">
        	<button class="delete" type="button" onclick="deleteJochi();"  style="display: none;">삭제</button>
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
	
	<!-- 불량현황 팝업창 -->
	<div id="jajuListModal" class="modal-overlay" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<span class="modal-title">설비 리스트</span> <span class="modal-close" onclick="closeJajuListModal()">&times;</span>
			</div>
			<div id="jajuListTabulator" style="height: 500px;"></div>
		</div>
	</div>
	
	
	    
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
		getJajuJochiList();
	});

	//이벤트
	//함수
	function getJajuJochiList(){
		
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
		    ajaxURL:"/tkheat/quality/jajwjochi/getJajuJochiList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
			    },
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		    	{title:"수주NO", field:"ord_code", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"거래처명", field:"corp_name", sorter:"string", width:120,
				    hozAlign:"center"}, 
				{title:"품명", field:"prod_name", sorter:"string", width:150,
				    hozAlign:"center"}, 
		        {title:"품번", field:"prod_no", sorter:"string", width:120,
		        	hozAlign:"center"},		        
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"작성일", field:"jerr_rdate", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"불량구분", field:"jerr_gubn", sorter:"string", width:100,
			        hozAlign:"center"},	
		        {title:"조치구분", field:"jerr_jgubn", sorter:"string", width:100,
		        	hozAlign:"center"},
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
				$('#jajuJochiForm')[0].reset();
				$('.jajujochiModal').show().addClass('show');

				Object.keys(data).forEach(function (key) {
			        const field = $('#jajuJochiForm [name="' + key + '"]');

			        if (field.length) {
			            field.val(data[key]);
			        }
				});

				 $('.delete').show();
			},
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
                {title:"NO", field:"idx", width:80, hozAlign:"center"},
                {title:"설비NO", field:"fac_no", width:120, hozAlign:"center"},
                {title:"설비NO", field:"fac_code", width:120, hozAlign:"center",visible:false},
                {title:"설비명", field:"fac_name", width:150, hozAlign:"center"},
                {title:"규격", field:"fac_gyu", width:100, hozAlign:"center"},
                {title:"형식", field:"fac_hyun", width:200, hozAlign:"center"},
                {title:"용도", field:"fac_yong", width:200, hozAlign:"center"},
            ],
            rowDblClick:function(e, row){
                let data = row.getData();
                
                console.log("선택된 설비:", data);
                document.getElementById('fac_code').value = data.fac_code;
                document.getElementById('fac_name').value = data.fac_name;
                
                document.getElementById('facListModal').style.display = 'none';
            }
        });
    }

    function closeFacListModal() {
        document.getElementById('facListModal').style.display = 'none';
    }



  //자주현황 검색 리스트 모달
    function openJajuListModal() {
        document.getElementById('jajuListModal').style.display = 'flex';

        
        let jajuListTable = new Tabulator("#jajuListTabulator", {
            height:"450px",
            layout:"fitColumns",
            selectable:true,
            ajaxURL:"/tkheat/quality/jajuStatus/getJajuStatusList",
            ajaxConfig:"POST",
            ajaxParams:{
                "prod_name": "",
                "prod_no": "",
                "corp_name": "",
                "corp_code": "",
                   
            },
		    ajaxResponse:function(url, params, response){
//				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
				console.log(response);
		        return response.data; //return the response data to tabulator
		    },    
            columns:[
            	{title:"구분", field:"ilbo_gubn", sorter:"string", width:120,
			        hozAlign:"center", headerFilter:"input"},
		    	{title:"준비코드", field:"juckjaecode", sorter:"string", width:120,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"작업일", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"},     
				{title:"시작", field:"ilbo_strt", sorter:"string", width:120,
				    hozAlign:"center", headerFilter:"input"}, 
				{title:"종료", field:"ilbo_end", sorter:"string", width:150,
				    hozAlign:"center", headerFilter:"input"}, 
		        {title:"LOTNO", field:"ilbo_lot", sorter:"string", width:120,
		        	hozAlign:"center", headerFilter:"input"},		        
		        {title:"작업자", field:"user_name", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"품명", field:"prod_name", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},
		        {title:"품번", field:"prod_no", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input"},	
		        {title:"규격", field:"prod_gyu", sorter:"string", width:100,
		        	hozAlign:"center", headerFilter:"input"},  	
		        {title:"재질", field:"prod_jai", sorter:"string", width:100,
			        hozAlign:"center", headerFilter:"input"},	
			    {title:"표면경도", field:"prod_pg", sorter:"string", width:100,
				    hozAlign:"center", headerFilter:"input"},	
				{title:"판정", field:"ilbo_okng", sorter:"string", width:100,
				    hozAlign:"center", headerFilter:"input"},
				{title:"x1", field:"ilbo_pg1", sorter:"String", width:100,
					hozAlign:"center", headerFilter:"input"},
			    {title:"x2", field:"ilbo_pg2", sorter:"String", width:100,
					hozAlign:"center", headerFilter:"input"},
 			    {title:"x3", field:"ilbo_pg3", sorter:"String", width:100,
					hozAlign:"center", headerFilter:"input"},
				{title:"x4", field:"ilbo_pg4", sorter:"String", width:100,
					hozAlign:"center", headerFilter:"input"},
	 			{title:"x5", field:"ilbo_pg5", sorter:"String", width:100,
				    hozAlign:"center", headerFilter:"input"},
				    {title:"거래처명", field:"corp_name", sorter:"String", width:100,
					    hozAlign:"center", headerFilter:"input",visible:false},
					    {title:"거래처코드", field:"corp_code", sorter:"int", width:100,
						    hozAlign:"center", headerFilter:"input",visible:false},    
            ],
            rowDblClick:function(e, row){
                let data = row.getData();
                
                
                document.getElementById('prod_name').value = data.prod_name;
                document.getElementById('corp_name').value = data.corp_name;
                document.getElementById('prod_no').value = data.prod_no;
                document.getElementById('corp_code').value = data.corp_code;
                
                document.getElementById('jajuListModal').style.display = 'none';
            }
        });
    }

    function closeJajuListModal() {
        document.getElementById('jajuListModal').style.display = 'none';
    }



	
		
    // 드래그 기능 추가
	const modal = document.querySelector('.jajujochiModal');
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
	const jajujochiModal = document.querySelector('.jajujochiModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		isEditMode = false;  // 추가 모드
	    $('#jajuJochiForm')[0].reset(); // 폼 초기화
	    jajujochiModal.style.display = 'block'; // 모달 표시

		$('.delete').hide();
	});

	closeButton.addEventListener('click', function() {
		jajujochiModal.style.display = 'none'; // 모달 숨김
	});

    </script>

	</body>
</html>
