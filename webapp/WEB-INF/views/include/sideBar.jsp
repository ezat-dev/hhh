<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="description" content="태경열처리 관리 시스템">
  <meta name="author" content="태경열처리">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/tkheat/css/login/style.css">

	<script src="https://cdn.jsdelivr.net/npm/ionicons@latest/dist/ionicons/ionicons.js"></script>
	
  <link rel="stylesheet" href="/tkheat/css/sideBar/styles.css">
<%@include file="../include/pluginpage.jsp" %>  
  <title>태경열처리</title>
</head>
<style>
*{
	font-weight:700;
}

.row_select{
	background-color:#9ABCEA !important;
}


   .menuDiv {
       display: flex;
       align-items: center;
       width: 92.7%;
       height: 50px;
       
       margin-left: 131px;
       padding: 8px 14px;
       border-radius: 14px;
       box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.12);
       overflow-x: auto;
       white-space: nowrap;
       gap: 8px;  /* 탭 간격 좁히기 */
       scrollbar-width: none;
       -ms-overflow-style: none;
   }
   
   .menuDiv::-webkit-scrollbar {
       display: none;
   }
   
   
   .menuDivTab {
       text-align: center;
       cursor: pointer;
       background: white;
       border-radius: 10px;
       padding: 12px 18px;
       font-size: 14px;
       font-weight: 700;
       color: #333;
       border: 1px solid #ddd;
       transition: all 0.3s ease-in-out;
       box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
       user-select: none;
       display: flex;
       align-items: center;
       justify-content: center;
       gap: 6px;
       min-width: 100px;  
       height: 43px;
       cursor:pointer;
   }
   
   
   .menuDivTab:hover {
       background: #f0f2f5;
       transform: translateY(-2px);
       box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
   }
   
   .menuDivTab.active {
       background: #007aff;
       color: white;
       border: 1px solid #0062cc;
       box-shadow: 0 3px 8px rgba(0, 122, 255, 0.3);
       transform: translateY(-2px);
   }
   
   
   .menuDivTab i {
       font-size: 16px;
       color: inherit;
   }
   
   
   .menuDivTab .close-btn {
       font-size: 19px; 
       background: none;
       border: none;
       color: #888; 
       cursor: pointer;
       padding: 0;
       margin-left: 10px;
       display: flex;
       align-items: center; 
       justify-content: center;
       transition: color 0.2s ease-in-out;
   }

   
   .menuDivTab .close-btn:hover {
       color: #ff3b30; 
   }
   
   
   .frameDiv {
       display: flex;
       width: 92.7%;
       height: 90%;
       background: white;
       margin-left: 131px;
       border-radius: 14px;
       box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
       overflow: hidden;
   }
   
   .frameDiv #pageFrame {
       width: 100%;
       height: 100%;
       border: none;
   }


.header{
    margin-left: 131px;
    /* margin-right: 8px; */
    margin-top: 5px;
    height: 30px;
    background-color: #33363d;
    border-radius: 6px 6px 0px 0px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.logout-button {
    height: 30px; /* tab보다 조금 작게 설정 */
    padding: 0 11px; /* 좌우 패딩 */
    border: 1px solid rgb(53, 53, 53);
    border-radius: 4px; /* 모서리 둥글게 */
    background-color: #ffffff; /* 배경색 */
    cursor: pointer; /* 포인터 커서 */
    display: flex; /* 내부 요소를 플렉스 박스로 설정 */
    align-items: center; /* 버튼 안에서 세로 가운데 정렬 */
    margin-right: 30px;
    
    /*opacity: 0.5;  버튼을 흐릿하게 */
 	/*pointer-events: none;  마우스 이벤트 차단 */
}


.logout-button:hover {
    background-color: #f0f0f0; /* hover 시 색상 변화 */
}
.button-image {
    width: 20px; /* 원하는 너비 설정 */
    height: 20px; /* 원하는 높이 설정 */
    margin-right: 0px; /* 이미지와 텍스트 사이의 여백 */
    vertical-align: middle; /* 세로 가운데 정렬 */
}

.loginName{
	display: flex;
}
   .menuDivTab .close-btn {
       font-size: 19px; 
       background: none;
       border: none;
       color: #888; 
       cursor: pointer;
       padding: 0;
       margin-left: 10px;
       display: flex;
       align-items: center; 
       justify-content: center;
       transition: color 0.2s ease-in-out;
   }

   
   .menuDivTab .close-btn:hover {
       color: #ff3b30; 
   }

	.menuName{
		cursor:pointer;
	}   

</style>

<body>
    <header class="header">
	    <p class="headerP" style="font-size:20px; margin-left:40px; color : white; font-weight:800;"></p>
	    <!-- 로그인정보 표현, 로그아웃 버튼 -->
	    <p class="loginName" style="font-size:20px; margin-left:960px; color : white; font-weight:800;"></p>
        <button class="logout-button">
            <img src="/tkheat/css/sideBar/exit-outline.svg" alt="select" class="button-image">로그아웃	 	           
        </button>
    </header>
    <div class="hhhh"></div>
    <div class="l-navbar" id="navbar" style="overflow-y: auto;">
        <nav class="nav">
            <div>
                <div class="nav__brand">
                     <a href="#" class="nav__logo"><img class="tkLogo" src="/tkheat/css/sideBar/tkLogo.png"></a>
                </div>
                <div class="nav__list">
                	
                	
                	 <div class="nav__link collapse">
                        <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">제품관리</span>
                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
                        <ul class="collapse__menu" id="aMenu">
<!--                         
                             <li><a href="#" class="collapse__sublink" onclick="updateHeader('입고관리')">입고관리</a></li>
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('출고관리')">출고관리</a></li>
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('재고현황(상세정보)')">재고현황(상세정보)</a></li>
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('제품별재고현황')">제품별재고현황</a></li>
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('출고대기현황')">출고대기현황</a></li>
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('공정작업현황')">공정작업현황</a></li>
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('입출고삭제현황')">입출고삭제현황</a></li>
 -->
                        </ul>
                    </div>
                	
                	
                    
                     <div class="nav__link collapse">
                        <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">생산관리</span>
                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
                        <ul class="collapse__menu" id="bMenu">

                            
 
                        </ul>
                    </div>
                    
                    
                    <div class="nav__link collapse">
                        <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">생산공정관리</span>
                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
                        <ul class="collapse__menu" id="cMenu">
<!-- 
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('준비 작업실적')">준비 작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('전세정 작업실적')">전세정 작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('침탄 작업실적')">침탄 작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('고주파 작업실적')">고주파 작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('템퍼링 작업실적')">템퍼링 작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('후세정 작업실적')">후세정 작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('쇼트/샌딩 작업실적')">쇼트/샌딩 작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('설비별 작업실적')">설비별 작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('제품별 불량현황')">제품별 불량현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('소입경도현황')">소입경도현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('템퍼링경도현황')">템퍼링경도현황</a></li>
 -->					        
                        </ul>
                    </div>
                    
                    
                    <div class="nav__link collapse">
                        <ion-icon name="desktop-outline"></ion-icon>
                        <span class="nav_name">모니터링</span>
                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
                        <ul class="collapse__menu" id="dMenu">
                          
                            <li><a href="/tkheat/monitoring/monitoring" class="collapse__sublink"">생산모니터링</a></li>

                        </ul>
                    </div>
                    
                    
                  

                     <div class="nav__link collapse">
                        <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">설비보존관리</span>
                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
                        <ul class="collapse__menu" id="eMenu">
<!-- 
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('SparePart관리')">SparePart관리</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('비가동정보')">비가동정보</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('설비가동율분석')">설비가동율분석</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('설비수리이력관리')">설비수리이력관리</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('설비점검기준등록')">설비점검기준등록</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('설비별점검현황(일별)')">설비별점검현황(일별)</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('설비별점검현황(월별)')">설비별점검현황(월별)</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('측정기기고장이력')">측정기기고장이력</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('측정기기점검관리')">측정기기점검관리</a></li>
 -->
                        </ul>
                    </div>

                    
					
                     <div class="nav__link collapse">
                        <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">품질관리</span>
                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
                        <ul class="collapse__menu" id="fMenu">
<!-- 
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('수입검사')">수입검사</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('부적합등록')">부적합등록</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('소입경도현황')">소입경도현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('템퍼링경도현황')">템퍼링경도현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('자주검사불량현황')">자주검사불량현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('자주검사불량조치관리')">자주검사불량조치관리</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('Xbar-R관리도')">Xbar-R관리도</a></li>
 -->
                        </ul>
                    </div>
                    
                      
                    
                     <div class="nav__link collapse">
                        <ion-icon name="folder-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">경영정보</span>
                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
                        <ul class="collapse__menu" id="gMenu">
<!--  
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('제품별입고현황')">제품별입고현황</a></li>
                            <li><a href="#" class="collapse__sublink" onclick="updateHeader('제품별출고현황')">제품별출고현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('거래처별입고현황')">거래처별입고현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('거래처별출고현황')">거래처별출고현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('년간매출현황')">년간매출현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('월별불량현황')">월별불량현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('월별거래처별불량현황')">월별거래처별불량현황</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('제품별작업실적')">제품별작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('설비별작업실적')">설비별작업실적</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('공지사항')">공지사항</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('월매출현황(마감)')">월매출현황(마감)</a></li>
-->					        
                        </ul>
                    </div>
                    
                   
					<div class="nav__link collapse">
                        <ion-icon name="people-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">기준정보</span>
                        <ion-icon name="chevron-down-outline" class="collapse__link"></ion-icon>
                        <ul class="collapse__menu" id="hMenu">
<!--                         
                            <li><a href="#" class="collapse__sublink" onclick="updateHeaderAndNavigate(event, '/tkheat/management/cutumInsert','')">거래처등록</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeaderAndNavigate(event, '/tkheat/management/productInsert', '')">제품등록</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeaderAndNavigate(event, '/tkheat/management/facInsert', '')">설비등록</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeaderAndNavigate(event, '/tkheat/management/chimStandard', '')">침탄로작업표준</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeaderAndNavigate(event, '/tkheat/management/goStandard', '')">고주파로작업표준</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeaderAndNavigate(event, '/tkheat/management/coilInsert', '')">코일등록</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeaderAndNavigate(event, '/tkheat/management/plugInsert', '등록')">PLUG등록</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('PLUG점검기준등록')">PLUG점검기준등록</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeaderAndNavigate(event, '/tkheat/management/userinsert', '')">작업자등록</a></li>
       						<li><a href="#" class="collapse__sublink" onclick="updateHeaderAndNavigate(event, '/tkheat/management/authority', '')">사원별권한등록</a></li>
					        <li><a href="#" class="collapse__sublink" onclick="updateHeader('측정기기관리')">측정기기관리</a></li>
 -->					        
                        </ul>
                    </div>
                   

                  
	
					
                   
                    
                   
                </div>
            </div>
        </nav>
    </div>
    
    <div class="menuDiv"></div>
    <div class="frameDiv">
		<iframe id="pageFrame" src="" frameborder="0"></iframe>
    </div>
   <script>

   $(document).on('click', '.menuDivTab', function () {
       // 기존 active 클래스 제거
       $('.menuDivTab').removeClass('active');

       // 현재 클릭된 탭에 active 클래스 추가
       $(this).addClass('active');
   });

   //로드
   $(function(){
		var loginInfo = "${loginUser.user_name}";


		$(".loginName").text(loginInfo+"님 로그인");
	   
		loginUserMenuSetting();
		menuList();
   });

	function loginUserMenuSetting(){
		$.ajax({
			url:"/tkheat/user/login/menuSetting",
			type:"post",
			dataType:"json",
			success:function(result){
				console.log(result.data);
				var data = result.data;
				var idx = 0;
				for(let key in data){
//					console.log(key);
//					console.log(data[key]);
					
					
					if(key != "perm_code" && key != "user_code"){
						if(data[key] != null && data[key] != "N"){
							
							if(typeof pageObject(key) != "undefined"){
								var _link = pageObject(key)[0];
								var _name = pageObject(key)[1];
								
								if(typeof _link != "undefined" && typeof _name != "undefined"){
									
									var _group = "";
									var _groupID = "";

									if(key.indexOf("a") != -1){
										_group = "제품관리";
										_groupID = "aMenu";
									}else if(key.indexOf("b") != -1){
										_group = "생산관리";
										_groupID = "bMenu";
									}else if(key.indexOf("c") != -1){
										_group = "생산공정관리";
										_groupID = "cMenu";
									}else if(key.indexOf("d") != -1){
										_group = "모니터링";
										_groupID = "dMenu";
									}else if(key.indexOf("e") != -1){
										_group = "설비보존관리";
										_groupID = "eMenu";
									}else if(key.indexOf("f") != -1){
			                              _group = "품질관리";
			                              _groupID = "fMenu";
			                           }else if(key.indexOf("g") != -1){
			                              _group = "경영정보";
			                              _groupID = "gMenu";
			                           }else if(key.indexOf("h") != -1){
			                              _group = "기준정보";
			                              _groupID = "hMenu";
			                           }

									_group_t = _group.replace(/\s/gi,"&nbsp;");
									_name_t = _name.replace(/\s/gi,"&nbsp;");
									
									var _menu = "<li>";
									_menu += "<a class='collapse__sublink' onClick=updateHeaderAndNavigate(event,'"+_link+"','"+_group+"-"+_name+"');>"+_name+"</a>"
									_menu += "</li>";
									
									$("#"+_groupID).append(_menu);
									if(idx == 0){
										iframeSrc(_link,(_group+"-"+_name));
									}
									idx++;
								}
							}
						}
					}					
				}				
			}
		});
    }
    
	
	
    
   	function iframeSrc(url, menuGroupName){
   		$("#pageFrame").attr("src",url);
   		$(".headerP").text(menuGroupName);
   	}
    
        // 메뉴 클릭 시 헤더 업데이트
	function updateHeader(menuGroupName) {
//		document.getElementById('header-title').innerText = menuName;
	}

	function updateHeaderAndNavigate(event, url, menuGroupName) {
		event.preventDefault(); // 기본 링크 동작 방지
            
		iframeSrc(url,menuGroupName);
		//각 사용자별 메뉴 저장
		var loginCode = "${loginUser.user_code}";
		var menuUrl = url;
		var menuName = menuGroupName;
        
		menuSave(loginCode, menuUrl, menuName);
	}
        
	function menuSave(loginCode, menuUrl, menuName){
		$.ajax({
			url:"/tkheat/user/login/menuSave",
			type:"post",
			dataType:"json",
			data:{
				"user_code":loginCode,
				"menu_url":menuUrl,
				"menu_name":menuName
			},
			success:function(result){     			
				menuList();
			}
		});
	}

	function menuList(){
		var loginCode = "${loginUser.user_code}";
        	
		$.ajax({
			url:"/tkheat/user/login/menuList",
			type:"post",
			dataType:"json",
			data:{
				"user_code":loginCode
			},
			success:function(result){
				var data = result.data;
				var _div = "";
				var idx = 0;
				$(".menuDiv").empty();
        		
				for(let key in data){
					 var menuName = data[key].menu_name;
		                var menuNameIndex = (data[key].menu_name).indexOf("-")+1;
		                
		                menuName = menuName.substring(menuNameIndex,menuName.length);                
		                menuName = menuName.replace("/\s/g","&nbsp;");

		                _div = "<div class='menuDivTab' onClick=iframeSrc('"+data[key].menu_url+"','"+menuName+"')>";
						_div += "<label class='menuName' onClick=iframeSrc('"+data[key].menu_url+"','"+menuName+"')>" + menuName + "</label>";
		                _div += "<button class='close-btn' onClick=removeMenu('"+data[key].menu_url+"')>×</button>";
		                _div += "</div>";

		                $(".menuDiv").append(_div);
				}
         			
			}
		});
	}


	document.addEventListener('DOMContentLoaded', function () {
		  const collapseItems = document.querySelectorAll('.nav__link.collapse');

		  collapseItems.forEach(item => {
		    item.addEventListener('click', function (e) {
		      e.stopPropagation(); // 이벤트 전파 방지

		      const collapseMenu = this.querySelector('.collapse__menu');
		      const icon = this.querySelector('.collapse__link');

		      // toggle 상태만 제어 (닫거나 열기)
		      collapseMenu.classList.toggle('showCollapse');
		      icon.classList.toggle('rotate');
		    });
		  });

		  // 하위 메뉴 클릭 시 상위 메뉴 닫히지 않게
		  document.querySelectorAll('.collapse__menu a').forEach(link => {
		    link.addEventListener('click', function (e) {
		      e.stopPropagation(); // 반드시 필요
		      // 페이지 이동 또는 iframeSrc 등 호출 가능
		    });
		  });
		});





		
	   function removeMenu(url) {
			var loginCode = "${loginUser.user_code}";		   
		   
		   $.ajax({
			  url:"/tkheat/user/login/menuRemove",
			  type:"post",
			  dataType:"json",
			  data:{
				  "user_code":loginCode,
				  "menu_url":url},
			  success:function(result){
				  menuList();
			  }
		   });
/*		   
		   console.log(button);
		   
	       var menuName = $(button).siblings('.menuName').text(); 
	       console.log(menuName + " 메뉴 엑스 .");
	    
	       $(button).parent().remove();
*/	       
	   }	

        // DOMContentLoaded 이벤트로 DOM이 준비된 후 스크립트 실행
        document.addEventListener('DOMContentLoaded', function() {
            const linkColor = document.querySelectorAll('.nav__link');

            // 메뉴 클릭 시 활성화
            function colorLink() {
                linkColor.forEach(l => l.classList.remove('active'));
                this.classList.add('active');
            }
            linkColor.forEach(l => l.addEventListener('click', colorLink));

            const linkCollapse = document.getElementsByClassName('collapse__link');
            let i;
            for(i = 0; i < linkCollapse.length; i++) {
                linkCollapse[i].addEventListener('click', function() {
                    const collapseMenu = this.nextElementSibling;
                    collapseMenu.classList.toggle('showCollapse');
                    const rotate = collapseMenu.previousElementSibling;
                    rotate.classList.toggle('rotate');
                });
            }
        });




        $(".logout-button").on("click",function(){
       		$.ajax({
       			url:"/tkheat/user/logout",
       			type:"get",
       			dataTypa:"json",
       			success:function(result){
       				location.href = "/tkheat";
       			}
       		});
       	});  




		











        
</script>

    
</body>
</html>