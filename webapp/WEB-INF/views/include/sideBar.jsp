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
.row_select{
	background-color:#9ABCEA !important;
}
</style>

<body>
  <div class="tk-layout">
    <nav class="l-navbar" id="navbar">
        <div class="nav">
            <div>
                <div class="nav__brand" onclick="iframeSrc('/tkheat/monitoring/overView','모니터링-설비모니터링')">
                     <a href="#" class="nav__logo" onclick="return false;"><img class="tkLogo" src="/tkheat/css/sideBar/tkLogo.png"></a>
                </div>
                <div class="nav__list">
                    <div class="submenu-empty" id="submenuEmpty">상단 메뉴를 선택하세요</div>

                    <ul class="sub-menu-list" id="aMenu"></ul>
                    <ul class="sub-menu-list" id="bMenu"></ul>
                    <ul class="sub-menu-list" id="cMenu"></ul>
                    <ul class="sub-menu-list" id="dMenu">
                        <li><a href="/tkheat/monitoring/monitoring" class="collapse__sublink">생산모니터링</a></li>
                    </ul>
                    <ul class="sub-menu-list" id="eMenu"></ul>
                    <ul class="sub-menu-list" id="fMenu"></ul>
                    <ul class="sub-menu-list" id="gMenu"></ul>
                    <ul class="sub-menu-list" id="hMenu"></ul>
                    <ul class="sub-menu-list" id="iMenu"></ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="tk-main-area">
        <header class="tk-header">
            <p class="headerP"></p>

            <div class="tk-category-bar" id="categoryBar">
                <button class="cat-btn" data-menu="aMenu" onclick="selectCategory('aMenu',this)">
                    <ion-icon name="folder-outline"></ion-icon><span>제품관리</span>
                </button>
                <button class="cat-btn" data-menu="bMenu" onclick="selectCategory('bMenu',this)">
                    <ion-icon name="folder-outline"></ion-icon><span>생산관리</span>
                </button>
                <button class="cat-btn" data-menu="cMenu" onclick="selectCategory('cMenu',this)">
                    <ion-icon name="folder-outline"></ion-icon><span>생산공정관리</span>
                </button>
                <button class="cat-btn" data-menu="dMenu" onclick="selectCategory('dMenu',this)">
                    <ion-icon name="desktop-outline"></ion-icon><span>모니터링</span>
                </button>
                <button class="cat-btn" data-menu="eMenu" onclick="selectCategory('eMenu',this)">
                    <ion-icon name="folder-outline"></ion-icon><span>설비보존관리</span>
                </button>
                <button class="cat-btn" data-menu="fMenu" onclick="selectCategory('fMenu',this)">
                    <ion-icon name="folder-outline"></ion-icon><span>품질관리</span>
                </button>
                <button class="cat-btn" data-menu="gMenu" onclick="selectCategory('gMenu',this)">
                    <ion-icon name="folder-outline"></ion-icon><span>경영정보</span>
                </button>
                <button class="cat-btn" data-menu="hMenu" onclick="selectCategory('hMenu',this)">
                    <ion-icon name="people-outline"></ion-icon><span>기준정보</span>
                </button>
                <button class="cat-btn" data-menu="iMenu" onclick="selectCategory('iMenu',this)">
                    <ion-icon name="people-outline"></ion-icon><span>작업지시</span>
                </button>
            </div>

            <div class="tk-user-area">
                <p class="loginName"></p>
                <button class="logout-button">
                    <img src="/tkheat/css/sideBar/exit-outline.svg" alt="select" class="button-image">로그아웃
                </button>
            </div>
        </header>

        <div class="frameDiv">
            <iframe id="pageFrame" src="" frameborder="0"></iframe>
        </div>
    </div>
  </div>
   <script>

// ✅ 대메뉴 클릭 시 좌측 사이드바에 소메뉴 표시 (애니메이션 없이 즉시 전환)
// autoNavigate: 대메뉴 버튼을 직접 클릭했을 때만 true로 호출 -> 첫번째 소메뉴 페이지로 자동 이동
// (setActiveMenu에서 UI 동기화 목적으로 호출할 때는 false로 넘겨서 재이동이 일어나지 않도록 함)
function selectCategory(groupId, btnEl, autoNavigate){
    document.querySelectorAll('.sub-menu-list').forEach(function(el){
        el.classList.remove('active-group');
    });
    var target = document.getElementById(groupId);
    if(target){
        target.classList.add('active-group');
    }

    document.querySelectorAll('.cat-btn').forEach(function(b){
        b.classList.remove('active');
    });
    if(!btnEl){
        btnEl = document.querySelector('.cat-btn[data-menu="'+groupId+'"]');
    }
    if(btnEl){
        btnEl.classList.add('active');
    }

    var empty = document.getElementById('submenuEmpty');
    if(empty){
        empty.style.display = 'none';
    }

    if(autoNavigate !== false && target){
        var firstLink = target.querySelector('a.collapse__sublink[onclick]');
        if(firstLink){
            firstLink.click();
        }
    }
}

// ✅ 메뉴 클릭 시 활성 상태 유지 함수
function setActiveMenu(menuUrl) {
    $('.collapse__sublink').removeClass('active');

    $('.collapse__sublink').each(function() {
        const clickAttr = $(this).attr('onclick');
        //단순 includes()는 예: '/tkheat/product/chulgo'가 '/tkheat/product/chulgoWaiting'의 접두어라
        //출고관리 클릭시 출고대기현황까지 같이 active 처리되는 오탐이 있어, 따옴표로 감싼 정확한 URL만 매칭
        if(clickAttr && clickAttr.includes("'" + menuUrl + "'")) {
            $(this).addClass('active');

            const groupId = $(this).closest('.sub-menu-list').attr('id');
            if(groupId){
                selectCategory(groupId, null, false);
            }
        }
    });
}

// 로드
$(function(){
    var loginInfo = "${loginUser.user_name}";
    $(".loginName").text(loginInfo+"님 로그인");

    loginUserMenuSetting();
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
                // b01(작업지시), b06(작업지시NEW)는 생산관리 메뉴에서 숨김 처리
                // i07(최종검사)는 미구현 페이지라 작업지시 메뉴에서 숨김 처리
                if(key != "perm_code" && key != "user_code" && key != "b01" && key != "b06" && key != "i07"){
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
                                }else if(key.indexOf("i") != -1){
                                    _group = "작업지시";
                                    _groupID = "iMenu";
                                }

                                _group_t = _group.replace(/\s/gi,"&nbsp;");
                                _name_t = _name.replace(/\s/gi,"&nbsp;");

                                var _menu = "<li>";
                                _menu += "<a class='collapse__sublink' onClick=updateHeaderAndNavigate(event,'"+_link+"','"+_group+"-"+_name+"');>"+_name+"</a>"
                                _menu += "</li>";

                                $("#"+_groupID).append(_menu);
                                if(idx == 0){
                                    const savedUrl = localStorage.getItem("currentPageUrl");
                                    const savedName = localStorage.getItem("currentPageName");

                                    if(savedUrl){
                                        iframeSrc(savedUrl, savedName);
                                    }else{
                                        iframeSrc("/tkheat/monitoring/overView", "모니터링-설비모니터링");
                                    }
                                }

                                idx++;
                            }
                        }
                    }
                }
            }

            checkParentMenuVisibility();

            if($('.sub-menu-list.active-group').length === 0){
                var $firstBtn = $('.cat-btn:visible').first();
                if($firstBtn.length){
                    // 초기 로딩 시 페이지 이동은 위에서 이미 처리됐으므로(복원된 페이지 또는 기본 페이지),
                    // 여기서는 사이드바 활성 표시만 맞추고 재이동은 시키지 않음
                    selectCategory($firstBtn.data('menu'), $firstBtn.get(0), false);
                }
            }
        }
    });
}


function checkParentMenuVisibility() {
    const menuIds = ["aMenu","bMenu","cMenu","dMenu","eMenu","fMenu","gMenu","hMenu","iMenu"];

    menuIds.forEach(function(menuId) {
        const $menu = $("#" + menuId);
        const childCount = $menu.find("li").length;
        const $btn = $('.cat-btn[data-menu="'+menuId+'"]');

        if(childCount === 0) {
            $btn.hide();
        } else {
            $btn.show();
        }
    });
}

function iframeSrc(url, menuGroupName){
    $("#pageFrame").attr("src",url);
    $(".headerP").text(menuGroupName);

    localStorage.setItem("currentPageUrl", url);
    localStorage.setItem("currentPageName", menuGroupName);

    setActiveMenu(url);
}

function updateHeader(menuGroupName) {
}

function updateHeaderAndNavigate(event, url, menuGroupName) {
    event.preventDefault();
    event.stopPropagation();

    iframeSrc(url,menuGroupName);
}

$(".logout-button").on("click",function(){
	localStorage.removeItem("currentPageUrl");
    localStorage.removeItem("currentPageName");
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
