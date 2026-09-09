<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/tkheat/css/login/style.css">
<%@include file="include/pluginpage.jsp" %>
  
  <style>
   a,
   button,
   input,
   select,
   h1,
   h2,
   h3,
   h4,
   h5,
   * {
       box-sizing: border-box;
       margin: 0;
       padding: 0;
       border: none;
       text-decoration: none;
       background: none;
   
       -webkit-font-smoothing: antialiased;
   } 
   
   menu, ol, ul {
       list-style-type: none;
       margin: 0;
       padding: 0;
   }
   </style>
  <title>Document</title>
</head>
<body>
  <div class="group-1">
    <div class="main"></div>
    <img class="background-1" src="/tkheat/css/login/background-10.png" />
    <div class="login-box"></div>
    
    <div class="id-input"></div>
    <div class="pw-input"></div>
    <div class="text-1">이 사이트는 태경열처리 임직원 전용입니다.</div>
    <div class="text-2">주소 경남 함안군 군북면 함안산단 3 길 34</div>
    <form id="userForm">
	    <input type="text" id="n_id" name="user_id" placeholder="아이디를 입력하세요." />
	    <input type="password" id="n_pw" name="user_pwd" placeholder="비밀번호를 입력하세요." />
	    <input type="hidden" id="n_ip" name="user_ip" placeholder="비밀번호를 입력하세요." />
    </form>
    <button class="login_btn" onclick="login();">로그인</button>
    <div class="text-5">아이디</div>
    <div class="text-6">패스워드</div>
    <img class="logo" src="/tkheat/css/login/logo0.svg" />
    <div class="text-4">태경열처리 로그인</div>
    <div class="text-3">
      Copyright 2025. EZAutomation Co. All rights reserved.
      
    </div>
  </div>
  
  
  <script>

//로그인 화면은 전역 조회중 오버레이(pluginpage.jsp)를 끔
window.disableGlobalLoadingOverlay = true;

	$(function(){
		$.ajax({
			url:"https://api.ip.pe.kr/json"
		}).done(function(val){
			console.log(val);
			console.log(val.ip);
			console.log(val.contry_code);
			$("#n_ip").val(val.ip);
		});

		//아이디/비밀번호 입력 후 엔터키로 로그인
		$("#n_id, #n_pw").on("keydown", function(e){
			if(e.key === "Enter" || e.keyCode === 13){
				e.preventDefault();
				login();
			}
		});
	});
  
  function login(){
		var userData = new FormData($("#userForm")[0]);
		$.ajax({
			url:"/tkheat/user/login",
			type:"post",
			contentType: false,
			processData: false,
			dataType: "json",
			data:userData,
			success:function(result){				
				console.log(result);
				if(result.status == "NG"){
					alert(result.data);	
				}else{				
					location.href = "/tkheat/tkHeat";
				}
			}
		});
	}


//모달
function modal_alert() {
    alert("아이디와 비밀번호를 확인해 주십시오!");
}

  </script>
</body>
</html>