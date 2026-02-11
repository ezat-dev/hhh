<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>거래처등록</title> 
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>

<style>
	/* ========== 기본 스타일 ========== */
.main {
    width: 98%;
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
    margin-left: -1190px;
    gap: 10px;
}

/* ========== 모달 오버레이 ========== */
.modal-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999;
}

.modal-overlay.active {
    display: block;
}

/* ========== 거래처 모달 컨테이너 ========== */
.cutum-modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 900px;
    max-width: 95vw;
    max-height: 90vh;
    background: white;
    border-radius: 10px;
    box-shadow: 0 10px 50px rgba(0, 0, 0, 0.3);
    z-index: 1000;
    overflow: hidden;
}

.cutum-modal.active {
    display: flex;
    flex-direction: column;
}

/* ========== 모달 헤더 ========== */
.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 25px;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white;
    cursor: move;
    flex-shrink: 0;
}

.modal-header h2 {
    margin: 0;
    font-size: 20px;
    font-weight: 700;
}

.modal-close-btn {
    background: none;
    border: none;
    color: white;
    font-size: 28px;
    cursor: pointer;
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 4px;
    transition: all 0.3s;
}

.modal-close-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: rotate(90deg);
}

/* ========== 모달 본문 ========== */
.modal-body {
    flex: 1;
    overflow-y: auto;
    overflow-x: hidden;
    background: #f5f7fa;
    padding: 20px;
}

.modal-body::-webkit-scrollbar {
    width: 8px;
}

.modal-body::-webkit-scrollbar-track {
    background: #e0e0e0;
}

.modal-body::-webkit-scrollbar-thumb {
    background: #999;
    border-radius: 4px;
}

.modal-body::-webkit-scrollbar-thumb:hover {
    background: #666;
}

/* ========== 폼 그리드 ========== */
.form-grid {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

/* ========== 섹션 ========== */
.field-section {
    background: white;
    border-radius: 8px;
    padding: 15px 20px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.section-title {
    margin: 0 0 12px 0;
    font-size: 15px;
    font-weight: 700;
    color: #2c3e50;
    padding-bottom: 8px;
    border-bottom: 2px solid #e9ecef;
}

/* ========== 필드 행/열 ========== */
.field-row {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
    margin-bottom: 10px;
}

.field-row:last-child {
    margin-bottom: 0;
}

.field-col {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.field-col-full {
    grid-column: 1 / -1;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.field-col label,
.field-col-full label {
    font-size: 13px;
    font-weight: 600;
    color: #495057;
}

.req {
    color: #dc3545;
    margin-left: 2px;
}

/* ========== 입력 필드 ========== */
.field-col input[type="text"],
.field-col input[type="number"],
.field-col input[type="date"],
.field-col select,
.field-col-full input[type="text"],
.field-col-full textarea {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ced4da;
    border-radius: 5px;
    font-size: 13px;
    box-sizing: border-box;
    transition: all 0.3s;
}

.field-col input:focus,
.field-col select:focus,
.field-col-full input:focus,
.field-col-full textarea:focus {
    outline: none;
    border-color: #4dabf7;
    box-shadow: 0 0 0 3px rgba(77, 171, 247, 0.1);
}

.field-col input[readonly],
.field-col-full input[readonly] {
    background: #f1f3f5;
    cursor: not-allowed;
}

.field-col select {
    cursor: pointer;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 10px center;
    padding-right: 32px;
}

textarea {
    resize: vertical;
    min-height: 60px;
    font-family: inherit;
}

/* ========== 날짜 + 체크박스 ========== */
.date-with-checkbox {
    display: flex;
    align-items: center;
    gap: 10px;
}

.date-with-checkbox input[type="date"] {
    flex: 1;
}

.checkbox-label {
    display: flex;
    align-items: center;
    gap: 5px;
    font-size: 12px;
    font-weight: 500;
    color: #495057;
    white-space: nowrap;
    cursor: pointer;
}

.checkbox-label input[type="checkbox"] {
    width: 16px;
    height: 16px;
    cursor: pointer;
}

/* ========== 모달 푸터 ========== */
.modal-footer {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    padding: 15px 20px;
    background: white;
    border-top: 1px solid #dee2e6;
    flex-shrink: 0;
}

.modal-footer button {
    min-width: 100px;
    height: 38px;
    border: none;
    border-radius: 5px;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s;
}

.btn-save {
    background: linear-gradient(135deg, #51cf66, #37b24d);
    color: white;
}

.btn-save:hover {
    background: linear-gradient(135deg, #40c057, #2f9e44);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(64, 192, 87, 0.3);
}

.btn-delete {
    background: linear-gradient(135deg, #ff6b6b, #fa5252);
    color: white;
}

.btn-delete:hover {
    background: linear-gradient(135deg, #f03e3e, #e03131);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(240, 62, 62, 0.3);
}

.btn-cancel {
    background: linear-gradient(135deg, #868e96, #495057);
    color: white;
}

.btn-cancel:hover {
    background: linear-gradient(135deg, #6c757d, #343a40);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
}

/* ========== 반응형 ========== */
@media (max-width: 1000px) {
    .cutum-modal {
        width: 95vw;
    }
}

@media (max-width: 768px) {
    .field-row {
        grid-template-columns: 1fr;
    }
}






    
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>
        
        
		<!-- <label class="daylabel">거래처명 :</label>
		<input type="text" class="corp_name" id="corp_name" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">지역 :</label>
		<input type="text" class="corp_plc" id="corp_plc" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">구분 :</label>
		<input type="text" class="corp_gubn" id="corp_gubn" style="font-size: 16px;" autocomplete="off">
			
		<label class="daylabel">영업담당자 :</label>
		<input type="text" class="corp_mast" id="corp_mast" style="font-size: 16px; autocomplete="off"> -->
			
	</div>
    
    <div class="button-container">
        <button class="select-button" onclick="getCutumList();">
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
	    
	    
	    
	<form method="post" class="corrForm" id="cutumInsertForm" name="cutumInsertForm">
    <div class="modal-overlay"></div>
    
    <div class="cutum-modal">
        <!-- 헤더 -->
        <div class="modal-header">
            <h2>거래처등록</h2>
            <button type="button" class="modal-close-btn">&times;</button>
        </div>
        
        <!-- 본문 -->
        <div class="modal-body">
            <div class="form-grid">
                <!-- 기본정보 -->
                <div class="field-section">
                    <h3 class="section-title">기본정보</h3>
                    <div class="field-row">
                        <div class="field-col">
                            <label>거래처명 <span class="req">*</span></label>
                            <input type="text" id="corp_name" name="corp_name">
                        </div>
                        <div class="field-col">
                            <label>사업자번호</label>
                            <input type="text" id="corp_no" name="corp_no">
                        </div>
                    </div>
                    <div class="field-row">
                        <div class="field-col">
                            <label>전화번호</label>
                            <input type="text" id="corp_tel" name="corp_tel">
                        </div>
                        <div class="field-col">
                            <label>팩스번호</label>
                            <input type="text" id="corp_fax" name="corp_fax">
                        </div>
                    </div>
                </div>

                <!-- 담당자정보 -->
                <div class="field-section">
                    <h3 class="section-title">담당자정보</h3>
                    <div class="field-row">
                        <div class="field-col">
                            <label>대표자</label>
                            <input type="text" id="corp_boss" name="corp_boss">
                        </div>
                        <div class="field-col">
                            <label>담당자</label>
                            <input type="text" id="corp_mast" name="corp_mast">
                        </div>
                    </div>
                    <div class="field-row">
                        <div class="field-col">
                            <label>담당자 휴대폰</label>
                            <input type="text" id="corp_hp" name="corp_hp">
                        </div>
                        <div class="field-col">
                            <label>메일주소</label>
                            <input type="text" id="corp_mail" name="corp_mail">
                        </div>
                    </div>
                </div>

                <!-- 사업정보 -->
                <div class="field-section">
                    <h3 class="section-title">사업정보</h3>
                    <div class="field-row">
                        <div class="field-col">
                            <label>업태</label>
                            <input type="text" id="corp_upte" name="corp_upte">
                        </div>
                        <div class="field-col">
                            <label>종목</label>
                            <input type="text" id="corp_upjo" name="corp_upjo">
                        </div>
                    </div>
                    <div class="field-row">
                        <div class="field-col">
                            <label>주소</label>
                            <input type="text" id="corp_add" name="corp_add">
                        </div>
                        <div class="field-col">
                            <label>지역</label>
                            <input type="text" id="corp_plc" name="corp_plc">
                        </div>
                    </div>
                </div>

                <!-- 거래정보 -->
                <div class="field-section">
                    <h3 class="section-title">거래정보</h3>
                    <div class="field-row">
                        <div class="field-col">
                            <label>거래게시일</label>
                            <div class="date-with-checkbox">
                                <input type="date" id="corp_strt" name="corp_strt">
                                <label class="checkbox-label">
                                    <input type="checkbox" id="corp_gyul1" name="corp_gyul1" checked>
                                    매월 말일
                                </label>
                            </div>
                        </div>
                        <div class="field-col">
                            <label>기초잔액</label>
                            <input type="text" id="corp_jan" name="corp_jan" value="0">
                        </div>
                    </div>
                    <div class="field-row">
                        <div class="field-col">
                            <label>마감일</label>
                            <input type="number" id="corp_gyul2" name="corp_gyul2" min="1" max="31" placeholder="1~31일">
                        </div>
                        <div class="field-col">
                            <label>구분</label>
                            <select id="corp_gubn" name="corp_gubn">
                                <option>매출처</option>
                                <option>매입처</option>
                            </select>
                        </div>
                    </div>
                    <div class="field-row">
                        <div class="field-col">
                            <label>입금통장</label>
                            <input type="text" id="corp_cno" name="corp_cno">
                        </div>
                        <div class="field-col">
                            <label>비밀번호</label>
                            <input type="text" id="corp_pwd" name="corp_pwd">
                        </div>
                    </div>
                </div>

                <!-- 추가정보 -->
                <div class="field-section">
                    <h3 class="section-title">추가정보</h3>
                    <div class="field-row">
                        <div class="field-col">
                            <label>영업담당자</label>
                            <select id="corp_business" name="corp_business" class="js-username-select">
                                <option value="">선택</option>
                            </select>
                        </div>
                        <div class="field-col">
                            <label>거래처명2</label>
                            <input type="text" id="corp_name2" name="corp_name2">
                        </div>
                    </div>
                    <div class="field-row">
                        <div class="field-col-full">
                            <label>비고</label>
                            <textarea id="corp_bigo" name="corp_bigo" rows="3"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 푸터 (버튼) -->
        <div class="modal-footer">
            <button type="button" class="btn-delete" onclick="deleteCutum();" style="display:none;">삭제</button>
            <button type="button" class="btn-save" onclick="save();">저장</button>
            <button type="button" class="btn-cancel">닫기</button>
        </div>
    </div>
</form>
	    
	    
	    
<script>
//========== 전역변수 ==========
let now_page_code = "h02";
var cutumTable;
var isEditMode = false;
var selectedRowData = null;

// ========== 페이지 로드 ==========
$(function(){
	if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    getCutumList();
});

// ========== 모달 열기 (입력) ==========
$('.insert-button').on('click', function() {
    isEditMode = false;
    selectedRowData = null;
    $('#cutumInsertForm')[0].reset();
    
    // 기본값 설정
    $('#corp_jan').val('0');
    $('#corp_gyul1').prop('checked', true);
    
    // 버튼 상태
    $('.btn-delete').hide();
    
    // 모달 중앙 정렬
    $('.cutum-modal').css({
        'left': '50%',
        'top': '50%',
        'transform': 'translate(-50%, -50%)'
    });
    
    $('.modal-overlay, .cutum-modal').addClass('active');
});

// ========== 모달 닫기 ==========
$('.modal-close-btn, .btn-cancel').on('click', function() {
    $('.modal-overlay, .cutum-modal').removeClass('active');
});

// ========== 모달 드래그 ==========
let isDragging = false;
let startX, startY, modalLeft, modalTop;

$('.cutum-modal .modal-header').on('mousedown', function(e) {
    if ($(e.target).hasClass('modal-close-btn') || $(e.target).closest('.modal-close-btn').length) {
        return;
    }
    
    isDragging = true;
    const modal = $('.cutum-modal');
    const offset = modal.offset();
    
    startX = e.pageX;
    startY = e.pageY;
    modalLeft = offset.left;
    modalTop = offset.top;
    
    modal.css('transform', 'none');
    e.preventDefault();
});

$(document).on('mousemove', function(e) {
    if (isDragging) {
        const dx = e.pageX - startX;
        const dy = e.pageY - startY;
        
        $('.cutum-modal').css({
            left: (modalLeft + dx) + 'px',
            top: (modalTop + dy) + 'px'
        });
    }
});

$(document).on('mouseup', function() {
    isDragging = false;
});

// ========== 거래처 리스트 조회 ==========
// ========== 거래처 리스트 조회 함수만 수정 ==========
function getCutumList(){
    console.log("🔄 getCutumList 시작");
    
    // 기존 테이블 완전히 제거
    if (cutumTable) {
        cutumTable.destroy();
        cutumTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    cutumTable = new Tabulator("#tab1", {
        height:"750px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/management/cutumInsert/cutumInsertList",
        ajaxParams:{
            "corp_name": "",
            "corp_plc": "",
            "corp_gubn": "",
            "corp_mast": "",
        },
        placeholder:"조회된 데이터가 없습니다.",
        
        pagination:"local",
        paginationSize:20,
        paginationSizeSelector:[20,50,100,500,1000],
        paginationCounter:"rows",
        
        headerFilterPlaceholder: "",
        
        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
            console.log("📊 서버 응답:", response);
            
            const data = response.data ? response.data : response;
            console.log("📊 데이터 개수:", data.length);
            
            return data;
        },
        
        columns:[
            {title:"NO", field:"corp_code", sorter:"int", width:80, hozAlign:"center"},
            {title:"구분ID", field:"corp_gubn", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"거래처명", field:"corp_name", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"영업담당자", field:"corp_name2", sorter:"string", width:100, hozAlign:"center", headerFilter:"input"},
            {title:"사업자번호", field:"corp_no", sorter:"string", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"전화", field:"corp_tel", sorter:"int", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"FAX", field:"corp_fax", sorter:"int", width:200, hozAlign:"center", headerFilter:"input"},
            {title:"대표", field:"corp_boss", sorter:"int", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"담당자", field:"corp_mast", sorter:"int", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"지역", field:"corp_plc", sorter:"int", width:100, hozAlign:"center", headerFilter:"input"},
            {title:"거래처코드", field:"corp_code", width:120, hozAlign:"center", visible:false},
        ],
        
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },
        
        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
        },
        
        rowDblClick:function(e, row){
            
            if (window.disableRowDblClick) {
                alert("수정 권한이 없습니다.");
                return false;
            }
            
            var data = row.getData();
            selectedRowData = data;
            isEditMode = true;
            cutumInsertDetail(data.corp_code);
            
            
            const permission = userPermissions?.[now_page_code];
            if (permission === 'D') {
                $('.btn-delete').show();
            } else {
                $('.btn-delete').hide();
            }
        },
    });
    
    console.log("✅ Tabulator 생성 완료");
}

// ========== 거래처 상세 조회 ==========
function cutumInsertDetail(corp_code){
    $.ajax({
        url:"/tkheat/management/cutumInsert/cutumInsertDetail",
        type:"post",
        dataType:"json",
        data:{
            "corp_code":corp_code
        },
        success:function(result){
            console.log("📄 상세 데이터:", result);
            const d = result.data;
            
            // 폼 초기화
            $('#cutumInsertForm')[0].reset();
            
            // 기본 데이터 바인딩
            for(let key in d){
                $("[name='"+key+"']").val(d[key]);
            }

            // 모달 열기
            $('.modal-overlay, .cutum-modal').addClass('active');
        },
        error: function(xhr, status, error) {
            console.error("❌ 상세 조회 오류:", error);
        }
    });
}

//========== 저장 ==========
function save() {
    
    const permission = userPermissions?.[now_page_code];
    
    // 저장함수
    if (!isEditMode) {
        if (!['I', 'U', 'D'].includes(permission)) {
            alert("등록 권한이 없습니다.");
            console.log("등록 권한 없음 - 현재 권한:", permission);
            return false;
        }
        console.log("등록 권한 확인 완료");
    } 
    // 수정함수
    else {
        if (!['U', 'D'].includes(permission)) {
            alert("수정 권한이 없습니다.");
            console.log("수정 권한 없음 - 현재 권한:", permission);
            return false;
        }
        console.log("수정 권한 확인 완료");
    }
    
    var formData = new FormData($("#cutumInsertForm")[0]);
    let confirmMsg = "";
    
    if (isEditMode && selectedRowData && selectedRowData.corp_code) {
        formData.append("mode", "update");
        formData.append("corp_code", selectedRowData.corp_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
        formData.delete("corp_code");
    }
    
    if (!confirm(confirmMsg)) {
        return;
    }
    
    $.ajax({
        url: "/tkheat/management/cutumInsert/cutumInsertSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 저장 완료:", result);
            alert("저장 되었습니다.");
            
            // 모달 닫기
            $('.modal-overlay, .cutum-modal').removeClass('active');
            
            // 모달 위치 초기화
            $('.cutum-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 테이블 리로드
            setTimeout(function() {
                console.log("🔄 테이블 리로드 시작");
                getCutumList();
            }, 300);
        },
        error: function(xhr, status, error) {
            console.error("❌ 저장 오류:", error);
            console.error("응답:", xhr.responseText);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 삭제 ==========
function deleteCutum() {
    
    const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("삭제 권한 없음 - 현재 권한:", permission);
        return false;
    }
    console.log("삭제 권한 확인 완료");
    
    if (!selectedRowData || !selectedRowData.corp_code) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }
    
    if (!confirm("삭제하시겠습니까?")) {
        return;
    }
    
    $.ajax({
        url: "/tkheat/management/cutumInsert/cutumDelete",
        type: "POST",
        data: {
            corp_code: selectedRowData.corp_code
        },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay, .cutum-modal').removeClass('active');
                
                // 모달 위치 초기화
                $('.cutum-modal').css({
                    'left': '50%',
                    'top': '50%',
                    'transform': 'translate(-50%, -50%)'
                });
                
                setTimeout(function() {
                    getCutumList();
                }, 300);
            } else {
                alert("삭제 중 오류가 발생했습니다: " + result.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("❌ 삭제 오류:", error);
            alert("삭제 요청 중 오류가 발생했습니다.");
        }
    });
}



// ========== 엑셀 다운로드 ==========
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "거래처등록_" + today + ".xlsx";
    cutumTable.download("xlsx", filename, { sheetName: "거래처등록" });
});
    </script>

	</body>
</html>
