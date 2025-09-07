<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>권한 설정</title>
    <%-- <%@ include file="../include/sideBar.jsp" %> --%>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <%@include file="../include/pluginpage.jsp" %>
    <link rel="stylesheet" href="/tkheat/css/management/userinsert2.css">
    <style>

    
	.container {
            display: flex;
            justify-content: space-between;
            margin-left:5px;
        }

        #tab1, #tab2, #tab3, #tab4 {
            visibility: hidden;
        }

        #tab1 {
            visibility: visible;
        }

        .tabulator {
            width: 100%;
            max-width: 100%;
            max-height: 1200px;
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
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -780px;
}

.box1 input{
	width : 5%;
}
.box1 select{
	width: 5%
}    
    
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
           <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
        
		<label class="daylabel">부서 :</label>
		<input type="text" class="user_buso" id="user_buso" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">직책 :</label>
		<input type="text" class="user_jick" id="user_jick" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">이름 :</label>
		<input type="text" class="user_name" id="user_name" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">재직구분 :</label>
		<input type="text" class="user_ret" id="user_ret" style="font-size: 16px; autocomplete="off">
			
		<label class="daylabel">보고서타입 :</label>
		<input type="text" class="" id="" style="font-size: 16px; autocomplete="off">
			
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getAllUserList();">
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
	
	
	<div class="userModal">
	<div class="user-insert-box"></div>
    <div class="user-inser-header">작업자등록</div>
    <div class="user-no-box">사원번호</div>
    <div class="user-buso-box">부서</div>
    <div class="user-name-box">이름</div>
    <div class="user-jick-box">직책</div>
    <div class="user-jdate-box">입사일</div>
    <div class="user-odate-box">퇴사일</div>
    <div class="user-id-box">아이디</div>
    <div class="user-pwd-box">패스워드</div>
    <div class="user-phone-box">휴대전화</div>
    <div class="user-add-box">주소</div>
    <div class="user-bigo-box">비고</div>
    <div class="user-sms-box">SMS 발송</div>
    <input type="text" class="user-no">
    <input type="text" class="user-name">
    <input type="text" class="user-buso">
    <input type="text" class="user-jick">
    <input type="date" class="user-jdate">
    <input type="date" class="user-odate">
    <input type="text" class="user-id">
    <input type="text" class="user-pwd">
    <input type="text" class="user-phone">
    <input type="text" class="user-add">
    <input type="text" class="user-bigo">
    <div class="save">저장</div>
    <div class="close">닫기</div>
	</div>
	
	
	
	
</main>
    

<script>

	//전역변수
    var userTable;	
	

	//로드
	$(function(){
		//전체 사용자목록 조회
		getAllUserList();
	});
	
	
	
	
	
	//함수
	function getAllUserList(){
		
		
		userTable = new Tabulator("#tab1", {
		    height:"760px",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    selectableRows:true,
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/management/authority/userList",
		    ajaxProgressiveLoad:"scroll",
		    ajaxParams:{
		    	"user_buso": $("#user_buso").val(),
                "user_jick": $("#user_jick").val(),
                "user_name": $("#user_name").val(),
                "user_ret": $("#user_ret").val(),
			   },
		    ajaxResponse:function(url, params, response){
		    	console.log(response);
		    	console.log(params);
		    	console.log(url);
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","29px");
		        return response; //return the response data to tabulator
		    },
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:180,
		        	hozAlign:"center"},
		        {title:"아이디", field:"user_no", sorter:"string", width:250,
		        	hozAlign:"center"},
		        {title:"부서", field:"user_buso", sorter:"string", width:250,
		        	hozAlign:"center"},
		        {title:"직책", field:"user_jick", sorter:"string", width:250,
		        	hozAlign:"center"},
		        {title:"성명", field:"user_name", sorter:"string", width:250,
		        	hozAlign:"center"},
		        {title:"입사일", field:"user_jdate", sorter:"string", width:200,
			        hozAlign:"center"},	
		        {title:"퇴사", field:"user_ret", sorter:"string", width:100,
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
				$(".userName").text(rowData.user_name);
				
				
			},
			rowDblClick:function(e, row){


				var rowData = row.getData();
				$(".userName").text(rowData.user_name);
				
				
			},			
		});		
	}
	
	


	// 드래그 기능 추가
	const modal = document.querySelector('.userModal');
	const header = document.querySelector('.user-inser-header'); // 헤더를 드래그할 요소로 사용

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
	const userModal = document.querySelector('.userModal');
	const closeButton = document.querySelector('.close');

	insertButton.addEventListener('click', function() {
	    userModal.style.display = 'block'; // 모달 표시
	});

	closeButton.addEventListener('click', function() {
	    userModal.style.display = 'none'; // 모달 숨김
	});




	// 사용자 등록 모달 ajax
	
	$('.save').click(function() {
    const userData = {
        user_no: $('.user-no').val(),
        user_name: $('.user-name').val(),
        user_buso: $('.user-buso').val(),
        user_jick: $('.user-jick').val(),
        user_jdate: $('.user-jdate input').val(), 
        user_odate: $('.user-odate input').val(), 
        user_id: $('.user-id').val(),
        user_pwd: $('.user-pwd').val(),
        user_phone: $('.user-phone').val(),
        user_add: $('.user-add').val(),
        user_bigo: $('.user-bigo').val()
    };

    $.ajax({
        type: "POST",
        url: "/tkheat/management/userinsert/save",
        contentType: "application/json",
        data: JSON.stringify(userData),
        success: function(response) {
        	alert(response.message);        
            $('.userModal').hide();          
            location.reload(); 
        },
        error: function(xhr) {
            alert("등록 실패: " + xhr.responseText);
        }
    });
});
	














	

    </script>

	</body>
</html>
