<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
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
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -310px;
}
.box1 input[type="text"] {
	width: 5%;
}

.box1 input[type="date"] {
	width: 7%;
}

.box1 select {
	width: 5%
}

/* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main {
    flex: 1;
    min-height: 0;
    display: flex;
    padding: 8px;
    overflow: hidden;
}

/* ========== 상단 도구바 ========== */
.tab {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 0 14px;
}
.button-container .select-button,
.button-container .insert-button,
.button-container .excel-button,
.button-container .printer-button,
.button-container .delete {
    height: 34px;
    border: 1px solid #E2E8F0;
    border-radius: 8px;
    background: #F0F4F8;
    transition: background-color .13s, border-color .13s;
}
.button-container .select-button:hover,
.button-container .insert-button:hover,
.button-container .excel-button:hover,
.button-container .printer-button:hover,
.button-container .delete:hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
}

/* ========== 리스트 카드 영역 ========== */
.container {
    display: flex;
    flex: 1;
    min-height: 0;
    flex-direction: column;
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 8px;
    overflow: hidden;
}

/* ========== Tabulator 리스트 ========== */
#tab1.tabulator {
    flex: 1;
    min-height: 0;
    border: none;
    font-size: 12px;
}
#tab1 .tabulator-header {
    background: linear-gradient(135deg, #2B6CB0, #3182CE);
    border-bottom: none;
}
#tab1 .tabulator-col {
    background: transparent;
    border-right: 1px solid rgba(255,255,255,.15);
}
#tab1 .tabulator-col.tabulator-sortable:hover {
    background: rgba(255,255,255,.08);
}
#tab1 .tabulator-col-title {
    color: #ffffff;
    font-weight: 700;
}
#tab1 .tabulator-col .tabulator-header-filter input {
    border: none;
    border-radius: 5px;
    padding: 4px 6px;
    font-size: 11px;
    background: rgba(255,255,255,.92);
    box-sizing: border-box;
}
#tab1 .tabulator-col .tabulator-header-filter input:focus {
    outline: none;
    background: #ffffff;
    box-shadow: 0 0 0 2px rgba(255,255,255,.6);
}
#tab1 .tabulator-row {
    border-bottom: 1px solid #EDF2F7;
    transition: background-color .12s;
}
#tab1 .tabulator-row.tabulator-row-even {
    background-color: #F7FAFC;
}
#tab1 .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#tab1 .tabulator-row.row_select,
#tab1 .tabulator-row.tabulator-selected {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#tab1 .tabulator-cell {
    border: 1px solid #E2E8F0;
    color: #2D3748;
}

/* ========== 페이지네이션 (직관적으로 개선) ========== */
#tab1 .tabulator-footer {
    background: #F7FAFC;
    border-top: 1px solid #E2E8F0;
    padding: 8px 12px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
}
#tab1 .tabulator-paginator {
    display: flex;
    align-items: center;
    gap: 6px;
}
#tab1 .tabulator-page-size {
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    padding: 4px 8px;
    font-size: 12px;
    background: #ffffff;
    color: #2D3748;
    cursor: pointer;
    margin: 0;
}
#tab1 .tabulator-page-size:focus {
    outline: none;
    border-color: #3182CE;
}
#tab1 .tabulator-pages {
    display: flex;
    gap: 4px;
    margin: 0;
}
#tab1 .tabulator-page {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    background: #ffffff;
    color: #2D3748;
    min-width: 30px;
    height: 28px;
    padding: 0 8px;
    font-size: 12px;
    font-weight: 600;
    margin: 0;
    transition: background-color .13s, border-color .13s, color .13s;
}
#tab1 .tabulator-page.active {
    background: #3182CE;
    border-color: #2B6CB0;
    color: #ffffff;
}
#tab1 .tabulator-page:not(:disabled):hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
    color: #2B6CB0;
    cursor: pointer;
}
#tab1 .tabulator-page:disabled {
    opacity: .4;
    cursor: not-allowed;
}

/* ========== 모달 오버레이 ========== */
.modal-overlay {
    display: none; position: fixed;
    top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0,0,0,0.5); z-index: 999;
}
.modal-overlay.active { display: block; }

/* ========== 공지사항 모달 ========== */
.notice-modal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
}
.notice-modal.active { display: block; }

.notice-insert-box {
    width: 700px; max-width: 95vw;
    max-height: 90vh;
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    overflow: hidden; display: flex; flex-direction: column;
}

.notice-header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 10px 16px;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white; font-size: 15px; font-weight: 700; cursor: move;
    flex-shrink: 0;
}
.header-close-btn {
    background: none; border: none; color: white;
    font-size: 22px; cursor: pointer;
    width: 26px; height: 26px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 4px; transition: all 0.3s;
}
.header-close-btn:hover { background: rgba(255,255,255,0.2); transform: rotate(90deg); }

.notice-modal-body {
    flex: 1; overflow-y: auto; overflow-x: hidden;
    background: #f5f7fa;
    padding: 12px 16px;
}

.notice-section {
    background: white; border-radius: 6px;
    padding: 10px 14px;
}

.notice-row {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 10px; margin-bottom: 10px;
}
.notice-row:last-child { margin-bottom: 0; }
.notice-col { display: flex; flex-direction: column; gap: 4px; }
.notice-col-full { grid-column: 1/-1; display: flex; flex-direction: column; gap: 4px; }
.notice-col label, .notice-col-full label {
    font-size: 12px; font-weight: 600; color: #495057;
}

.notice-col input[type="text"],
.notice-col input[type="date"],
.notice-col-full input[type="text"],
.notice-col-full textarea {
    width: 100%;
    padding: 6px 10px;
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box; transition: all 0.2s;
    height: 32px;
}
.notice-col-full textarea {
    height: auto;
    resize: vertical;
    font-family: inherit;
}
.notice-col input:focus,
.notice-col-full input:focus,
.notice-col-full textarea:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.notice-col input[readonly] { background: #f1f3f5; cursor: not-allowed; }

.notice-modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 8px; padding: 10px 16px;
    background: white; border-top: 1px solid #dee2e6;
    flex-shrink: 0;
}
.notice-modal-footer button {
    min-width: 80px; height: 32px;
    border: none; border-radius: 4px;
    font-size: 12px; font-weight: 700; cursor: pointer; transition: all 0.3s;
}
.save    { background: linear-gradient(135deg,#51cf66,#37b24d); color: white; }
.save:hover { background: linear-gradient(135deg,#40c057,#2f9e44); transform: translateY(-1px); }
.btn-delete { background: linear-gradient(135deg,#ff6b6b,#fa5252); color: white; }
.btn-delete:hover { background: linear-gradient(135deg,#f03e3e,#e03131); transform: translateY(-1px); }
.close   { background: linear-gradient(135deg,#868e96,#495057); color: white; }
.close:hover { background: linear-gradient(135deg,#6c757d,#343a40); transform: translateY(-1px); }

    </style>


    <body>

    <div class="tab">

    <div class="button-container">
        <!-- <button class="select-button">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">

        </button> -->
        <button class="insert-button">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          입력
        </button>
       <!--  <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">

        </button>
        <button class="printer-button">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">

        </button> -->
    </div>
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>

<form autocomplete="off" method="post" id="noticeForm" name="noticeForm">
    <div class="modal-overlay"></div>

    <div class="notice-modal">
        <div class="notice-insert-box">
            <div class="notice-header">
                공지사항 등록/수정
                <button type="button" class="header-close-btn">&times;</button>
            </div>

            <div class="notice-modal-body">
                <div class="notice-section">
                    <input type="hidden" id="notice_code" name="notice_code">

                    <div class="notice-row">
                        <div class="notice-col-full">
                            <label>제목</label>
                            <input type="text" id="notice_name" name="notice_name" maxlength="50">
                        </div>
                    </div>

                    <div class="notice-row">
                        <div class="notice-col">
                            <label>작성자</label>
                            <input type="text" id="notice_user" name="notice_user" readonly>
                        </div>
                        <div class="notice-col">
                            <label>등록일</label>
                            <input type="text" id="notice_date_view" readonly>
                        </div>
                    </div>

                    <div class="notice-row">
                        <div class="notice-col">
                            <label>게시 시작일</label>
                            <input type="date" id="notice_dates" name="notice_dates">
                        </div>
                        <div class="notice-col">
                            <label>게시 종료일</label>
                            <input type="date" id="notice_datee" name="notice_datee">
                        </div>
                    </div>

                    <div class="notice-row">
                        <div class="notice-col-full">
                            <label>내용</label>
                            <textarea id="notice_memo" name="notice_memo" rows="10" maxlength="4000"></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <div class="notice-modal-footer">
                <button type="button" class="btn-delete" onclick="deleteNotice();" style="display:none;">삭제</button>
                <button type="button" class="save">저장</button>
                <button type="button" class="close">닫기</button>
            </div>
        </div>
    </div>
</form>

<script>
	//전역변수
	let now_page_code = "g09";
    var cutumTable;
    var noticeTable;
    var isEditMode = false;
    var selectedRowData = null;
    var loginUserName = "${loginUser.user_name}";

	//로드
	$(function(){
		if (typeof userInfoList === 'function') {
	        userInfoList(now_page_code);
	    }
		//전체 공지사항 목록 조회
		getNoticeList();
	});

	//날짜/시간 -> YYYY-MM-DD HH:mm 형식으로 표시
	function formatNoticeDateTime(value){
		if(!value){ return ""; }
		var s = String(value).trim();
		var parts = s.split(" ");
		if(parts.length < 2){ return parts[0]; }
		return parts[0] + " " + parts[1].substring(0,5);
	}

	//날짜/시간 -> YYYY-MM-DD 형식으로 표시(date input 바인딩용)
	function formatNoticeDateOnly(value){
		if(!value){ return ""; }
		return String(value).trim().substring(0,10);
	}

	//이벤트
	//함수
	function getNoticeList(){

		noticeTable = new Tabulator("#tab1", {
		    height:"100%",
		    layout:"fitColumns",
		    selectable:true,	//로우 선택설정
		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    ajaxConfig:"POST",
		    ajaxLoader:false,
		    ajaxURL:"/tkheat/operation/notice/getNoticeList",
		    ajaxParams:{},
		    placeholder:"조회된 데이터가 없습니다.",
		    pagination:"local",
		    paginationSize:20,
		    paginationSizeSelector:[20,50,100,500,1000],
		    paginationCounter:"rows",
		    ajaxResponse:function(url, params, response){
				$("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
		        return response.data ? response.data : response; //return the response data to tabulator
		    },
		    columns:[
		        {title:"NO", field:"idx", sorter:"int", width:70,
		        	hozAlign:"center"},
		        {title:"공지코드", field:"notice_code", visible:false},
		        {title:"제목", field:"notice_name", sorter:"string", width:420,
			        hozAlign:"center"},
			    {title:"내용", field:"notice_memo", sorter:"string", width:620,
				    hozAlign:"center"},
				{title:"작성자", field:"notice_user", sorter:"string", width:100,
				    hozAlign:"center"},
				{title:"등록일", field:"notice_date", sorter:"string", width:130,
				    hozAlign:"center", formatter:function(cell){
						return formatNoticeDateTime(cell.getValue());
					}},
				{title:"게시기간", field:"notice_dates", sorter:"string", width:180,
				    hozAlign:"center", formatter:function(cell){
						var data = cell.getRow().getData();
						var s = formatNoticeDateOnly(data.notice_dates);
						var e = formatNoticeDateOnly(data.notice_datee);
						if(!s && !e){ return ""; }
						return s + " ~ " + e;
					}},
				{title:"조회수", field:"notice_views", sorter:"int", width:80,
				    hozAlign:"center"},
			    ],
		    rowFormatter:function(row){
			    var data = row.getData();

			    row.getElement().style.fontWeight = "600";
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

				if (window.disableRowDblClick) {
					alert("수정 권한이 없습니다.");
					return false;
				}

				var data = row.getData();
				selectedRowData = data;
				isEditMode = true;

				noticeDetail(data.notice_code);

				const permission = userPermissions?.[now_page_code];
				if (permission === 'D') {
					$('.btn-delete').show();
				} else {
					$('.btn-delete').hide();
				}
			},
		});
	}

	//더블클릭 상세조회
	function noticeDetail(notice_code){
		$.ajax({
			url:"/tkheat/operation/notice/noticeDetail",
			type:"post",
			dataType:"json",
			data:{
				"notice_code": notice_code
			},
			success:function(result){
				var data = result.data;
				if(!data){ return; }

				$('#noticeForm')[0].reset();

				$("#notice_code").val(data.notice_code);
				$("#notice_name").val(data.notice_name);
				$("#notice_memo").val(data.notice_memo);
				$("#notice_user").val(data.notice_user);
				$("#notice_date_view").val(formatNoticeDateTime(data.notice_date));
				$("#notice_dates").val(formatNoticeDateOnly(data.notice_dates));
				$("#notice_datee").val(formatNoticeDateOnly(data.notice_datee));

				$('.modal-overlay').addClass('active');
				$('.notice-modal').addClass('active');
				registerModalOpen('notice-main', noticeModalClose);
			},
			error: function(xhr, status, error) {
				console.error("상세 조회 오류:", error);
				alert("데이터를 불러오는 중 오류가 발생했습니다.");
			}
		});
	}

	//저장(등록/수정)
	function save() {

		const permission = userPermissions?.[now_page_code];

		if (!isEditMode) {
			if (!['I', 'U', 'D'].includes(permission)) {
				alert("등록 권한이 없습니다.");
				return false;
			}
		} else {
			if (!['U', 'D'].includes(permission)) {
				alert("수정 권한이 없습니다.");
				return false;
			}
		}

		if(!$("#notice_name").val()){
			alert("제목을 입력해주세요.");
			$("#notice_name").focus();
			return;
		}

		var formData = new FormData($("#noticeForm")[0]);

		let confirmMsg = "";
		if (isEditMode && selectedRowData && selectedRowData.notice_code) {
			formData.append("mode", "update");
			formData.set("notice_code", selectedRowData.notice_code);
			confirmMsg = "수정하시겠습니까?";
		} else {
			formData.append("mode", "insert");
			confirmMsg = "저장하시겠습니까?";
		}

		if (!confirm(confirmMsg)) return;

		$.ajax({
			url: "/tkheat/operation/notice/noticeSave",
			type: "POST",
			data: formData,
			contentType: false,
			processData: false,
			dataType: "json",
			success: function(result) {
				alert("저장 되었습니다.");

				noticeModalClose();

				$('.notice-modal').css({
					'left': '50%',
					'top': '50%',
					'transform': 'translate(-50%, -50%)'
				});

				$('#noticeForm')[0].reset();
				isEditMode = false;
				selectedRowData = null;

				setTimeout(function() {
					getNoticeList();
				}, 300);
			},
			error: function(xhr, status, error) {
				console.error("저장 오류:", error);
				alert("저장 중 오류가 발생했습니다.");
			}
		});
	}

	//삭제
	function deleteNotice() {

		const permission = userPermissions?.[now_page_code];

		if (permission !== 'D') {
			alert("삭제 권한이 없습니다.");
			return false;
		}

		if (!selectedRowData || !selectedRowData.notice_code) {
			alert("삭제할 대상을 선택하세요.");
			return;
		}

		if (!confirm("삭제하시겠습니까?")) {
			return;
		}

		$.ajax({
			url: "/tkheat/operation/notice/noticeDelete",
			type: "POST",
			data: {
				notice_code: selectedRowData.notice_code
			},
			dataType: "json",
			success: function(result) {
				if (result.status === "success") {
					alert("삭제되었습니다.");
					noticeModalClose();

					setTimeout(function() {
						getNoticeList();
					}, 300);
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

	// ========== 드래그 기능 ==========
	const noticeModal = document.querySelector('.notice-modal');
	const noticeHeader = document.querySelector('.notice-header');

	noticeHeader.addEventListener('mousedown', function(e) {
	    if (e.target.classList.contains('header-close-btn') || e.target.closest('.header-close-btn')) {
	        return;
	    }

	    const rect = noticeModal.getBoundingClientRect();
	    noticeModal.style.left = rect.left + 'px';
	    noticeModal.style.top = rect.top + 'px';
	    noticeModal.style.transform = 'none';

	    let offsetX = e.clientX - rect.left;
	    let offsetY = e.clientY - rect.top;

	    function moveModal(e) {
	        noticeModal.style.left = (e.clientX - offsetX) + 'px';
	        noticeModal.style.top = (e.clientY - offsetY) + 'px';
	    }

	    function stopMove() {
	        window.removeEventListener('mousemove', moveModal);
	        window.removeEventListener('mouseup', stopMove);
	    }

	    window.addEventListener('mousemove', moveModal);
	    window.addEventListener('mouseup', stopMove);
	});

	// ========== 모달 열기/닫기 ==========
	const insertButton = document.querySelector('.insert-button');
	const modalOverlay = document.querySelector('.modal-overlay');
	const closeButton = document.querySelector('.close');
	const headerCloseBtn = document.querySelector('.header-close-btn');

	function noticeModalClose() {
	    registerModalClose('notice-main');
	    modalOverlay.classList.remove('active');
	    noticeModal.classList.remove('active');
	}

	insertButton.addEventListener('click', function() {
	    isEditMode = false;
	    selectedRowData = null;

	    $('#noticeForm')[0].reset();
	    $("#notice_user").val(loginUserName);
	    $("#notice_date_view").val("");

	    noticeModal.style.left = '50%';
	    noticeModal.style.top = '50%';
	    noticeModal.style.transform = 'translate(-50%, -50%)';

	    modalOverlay.classList.add('active');
	    noticeModal.classList.add('active');
	    registerModalOpen('notice-main', noticeModalClose);

	    $('.btn-delete').hide();
	});

	closeButton.addEventListener('click', function() {
	    noticeModalClose();
	});

	headerCloseBtn.addEventListener('click', function() {
	    noticeModalClose();
	});

	// ========== 저장 버튼 ==========
	$('.save').click(function() {
	    save();
	});

    </script>

	</body>
</html>
