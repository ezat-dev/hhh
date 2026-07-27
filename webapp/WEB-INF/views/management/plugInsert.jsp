<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코일등록</title>
    <link rel="stylesheet" href="/tkheat/css/management/plugInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>     
    
    <style>
    
	.container {
		display: flex;
		justify-content: space-between;
/*		margin-left:1008px;
		margin-top:200px;*/
	}

        #tab1, #tab2, #tab3, #tab4 {
            visibility: hidden;
        }

        #tab1 {
            visibility: visible;
        }

        .tabulator {
            width: 90%;
            max-width: 100%;
            max-height: 900px;
            overflow-x: hidden !important;  
        }
        
        .tabulator .tabulator-cell {
            white-space: normal !important;
            word-break: break-word;
            text-align: center;
            border: 1px solid #E2E8F0;
        }
        
.row_select{
	background-color:#9ABCEA !important;
}
    
    
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="button-container">
        <button class="select-button">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
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
	    
	    
	    
	    
	 <div class="coilModal">
      <div class="coil-main"></div>
      <div class="coil-header">금형등록</div>
      <div class="_1">금형입고일</div>
      <div class="_2">구분</div>
      <div class="_3">금형명</div>
      <div class="_4">관리NO</div>
      <div class="_5">수리타수</div>
      <div class="_6">수리일자</div>
      <div class="_7">점검자</div>
      <div class="_8">폐기일자</div>
      <div class="_9">폐기내역</div>
      <div class="_10">주의사항</div>
      <div class="_11">현재타발수</div>
      <div class="_12">등급</div>
      <div class="_13">수명타발수</div>
      <div class="_14">수리이력</div>
      <div class="_15">수리일자</div>
      <div class="_16">수리사유</div>
      <input type="date" class="coil-ipgo">
      <select class="coil-gubn">
	    <option value="수리">수리</option>
	    <option value="폐기">폐기</option>
	    <option value="양호">양호</option>
	  </select>
      <input type="text" class="coil-name">
      <input type="text" class="coil-no">
      <input type="text" class="coil-suritasu">
      <input type="date" class="coil-suridate">
      <input type="text" class="coil-chkman">
      <input type="date" class="coil-dis-date">
      <input type="text" class="coil-dislist">
      <input type="text" class="coil-warn">
      <input type="text" class="coil-gicho">
      <select class="coil-level">
	    <option value="A">A</option>
	    <option value="B">B</option>
	    <option value="C">C</option>
	  </select>
      <input type="text" class="coil-sumyung">
      <input type="date" class="coil-recdate-1">>
      <input type="text" class="coil-record-1">
      <input type="date" class="coil-recdate-2">
      <input type="text" class="coil-record-2">
      <input type="date" class="coil-recdate-3">
      <input type="text" class="coil-record-3">
      <input type="date" class="coil-recdate-4">
      <input type="text" class="coil-record-4">
      <input type="date" class="coil-recdate-5">
      <input type="text" class="coil-record-5">
      <div class="save">저장</div>
      <div class="close">닫기</div>
    </div>
    
    
    
    
	    
<script>
	//전역변수
    var cutumTable;	

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
/*		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/management/authority/corpList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{},*/
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:80,
		        	hozAlign:"center"},
		        {title:"구분ID", field:"corp_gubn", sorter:"string", width:120,
		        	hozAlign:"center"},
		        {title:"거래처명", field:"corp_name", sorter:"string", width:150,
		        	hozAlign:"center"},
		        {title:"영업담당자", field:"corp_name2", sorter:"string", width:100,
		        	hozAlign:"center"},
		        {title:"사업자번호", field:"corp_no", sorter:"string", width:200,
		        	hozAlign:"center"},
		        {title:"전화", field:"corp_tel", sorter:"int", width:200,
		        	hozAlign:"center"},
		        {title:"FAX", field:"corp_fax", sorter:"int", width:200,
			        hozAlign:"center"},
			    {title:"대표", field:"corp_boss", sorter:"int", width:120,
				    hozAlign:"center"},
				{title:"담당자", field:"corp_mast", sorter:"int", width:150,
					hozAlign:"center"},
				{title:"지역", field:"corp_plc", sorter:"int", width:100,
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
		});		
	}




	// 드래그 기능 추가
	const modal = document.querySelector('.coilModal');
	const header = document.querySelector('.coil-header'); // 헤더를 드래그할 요소로 사용

	header.addEventListener('mousedown', function(e) {
	    let offsetX = e.clientX - modal.getBoundingClientRect().left; // 마우스와 모달의 x 위치 차이
	    let offsetY = e.clientY - modal.getBoundingClientRect().top; // 마우스와 모달의 y 위치 차이

	    function moveModal(e) {
	        modal.style.left = (e.clientX - offsetX) + 'px';
	        modal.style.top = (e.clientY - offsetY) + 'px';
	    }

	    function stopMove() {
	        window.removeEventListener('mousemove', moveModal); // 이동 중지
	        window.removeEventListener('mouseup', stopMove); // 마우스 업 이벤트 제거
	    }

	    window.addEventListener('mousemove', moveModal); // 마우스 이동 이벤트
	    window.addEventListener('mouseup', stopMove); // 마우스 업 이벤트
	});
		

	// 모달 열기
	const insertButton = document.querySelector('.insert-button');
	const coilModal = document.querySelector('.coilModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
		coilModal.style.display = 'block'; // 모달 표시
	});

	closeButton.addEventListener('click', function() {
	    coilModal.style.display = 'none'; // 모달 숨김
	});

    </script>

	</body>
</html>
