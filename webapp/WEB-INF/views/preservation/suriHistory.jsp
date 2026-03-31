<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비수리이력관리</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
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

.tabulator {
    width: 100%;
    max-width: 100%;
    overflow-x: hidden !important;
}

.tabulator .tabulator-cell {
    white-space: normal !important;
    word-break: break-word;
    text-align: center;
}

.row_select {
    background-color: #9ABCEA !important;
}

.box1 {
    display: flex;
    justify-content: right;
    align-items: center;
    width: 1500px;
    margin-left: -1030px;
    gap: 10px;
}

.box1 select {
    width: 5%;
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
    margin-right: 10px;
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

/* ========== 수리이력 모달 컨테이너 ========== */
.suri-modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
}

.suri-modal.active {
    display: block;
}

.suri-insert-box {
    width: 900px;
    max-width: 95vw;
    max-height: 90vh;
    background: white;
    border-radius: 10px;
    box-shadow: 0 10px 50px rgba(0, 0, 0, 0.3);
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

/* ========== 모달 헤더 ========== */
.suri-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 25px;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white;
    font-size: 20px;
    font-weight: 700;
    cursor: move;
}

.header-close-btn {
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

.header-close-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: rotate(90deg);
}

/* ========== 모달 본문 ========== */
.suri-modal-body {
    flex: 1;
    overflow-y: auto;
    overflow-x: hidden;
    background: #f5f7fa;
    padding: 20px;
    max-height: 700px;
}

.suri-modal-body::-webkit-scrollbar {
    width: 8px;
}

.suri-modal-body::-webkit-scrollbar-track {
    background: #e0e0e0;
}

.suri-modal-body::-webkit-scrollbar-thumb {
    background: #999;
    border-radius: 4px;
}

/* ========== 섹션 ========== */
.suri-section {
    background: white;
    border-radius: 8px;
    padding: 15px 20px;
    margin-bottom: 15px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.suri-section:last-child {
    margin-bottom: 0;
}

.suri-section-title {
    font-size: 15px;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 12px;
    padding-bottom: 8px;
    border-bottom: 2px solid #e9ecef;
}

/* ========== 기본 행/열 레이아웃 ========== */
.suri-row {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
    margin-bottom: 10px;
}

.suri-row:last-child {
    margin-bottom: 0;
}

.suri-col {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.suri-col-full {
    grid-column: 1 / -1;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.suri-col label,
.suri-col-full label {
    font-size: 13px;
    font-weight: 600;
    color: #495057;
}

/* ========== 입력 필드 ========== */
.suri-col input[type="text"],
.suri-col input[type="date"],
.suri-col select,
.suri-col-full textarea {
    padding: 8px 12px;
    border: 1px solid #ced4da;
    border-radius: 5px;
    font-size: 13px;
    box-sizing: border-box;
    transition: all 0.3s;
}

.suri-col input[type="text"],
.suri-col input[type="date"],
.suri-col select,
.suri-col-full textarea {
    width: 100%;
}

.suri-col input:focus,
.suri-col select:focus,
.suri-col-full textarea:focus {
    outline: none;
    border-color: #4dabf7;
    box-shadow: 0 0 0 3px rgba(77, 171, 247, 0.1);
}

.suri-col select {
    cursor: pointer;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 10px center;
    padding-right: 32px;
}

textarea {
    resize: vertical;
    min-height: 80px;
    font-family: inherit;
}

/* ========== 이미지 업로드 영역 ========== */
.image-upload-area {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
    margin-top: 0;
}

.image-upload-col {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.image-upload-col label {
    font-size: 13px;
    font-weight: 600;
    color: #495057;
}

.image-upload-col input[type="file"] {
    padding: 6px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 12px;
    cursor: pointer;
}

.img-preview {
    width: 100%;
    height: 200px;
    border: 2px dashed #ced4da;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f8f9fa;
    overflow: hidden;
}

.img-preview img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

/* ========== 모달 푸터 ========== */
.suri-modal-footer {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    padding: 15px 20px;
    background: white;
    border-top: 1px solid #dee2e6;
}

.suri-modal-footer button {
    min-width: 100px;
    height: 38px;
    border: none;
    border-radius: 5px;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s;
}

.save {
    background: linear-gradient(135deg, #51cf66, #37b24d);
    color: white;
}

.save:hover {
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

.close {
    background: linear-gradient(135deg, #868e96, #495057);
    color: white;
}

.close:hover {
    background: linear-gradient(135deg, #6c757d, #343a40);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
}

/* ========== 반응형 ========== */
@media (max-width: 1000px) {
    .suri-insert-box {
        width: 95vw;
    }
    
    .suri-row {
        grid-template-columns: 1fr;
    }
    
    .image-upload-area {
        grid-template-columns: 1fr;
    }
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
        <button class="select-button" onclick="getSuriHistoryList();">
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
	    
	    
	    
<form method="post" id="suriHistoryForm" name="suriHistoryForm" enctype="multipart/form-data">
    <div class="modal-overlay"></div>
    
    <div class="suri-modal">
        <div class="suri-insert-box">
            <!-- 헤더 -->
            <div class="suri-header">
                설비수리이력
                <button type="button" class="header-close-btn">&times;</button>
            </div>
            
            <!-- 본문 -->
            <div class="suri-modal-body">
                <!-- 기본정보 섹션 -->
                <div class="suri-section">
                    <div class="suri-section-title">기본정보</div>
                    
                    <div class="suri-row">
                        <div class="suri-col">
                            <label>설비</label>
                            <select id="fac_code" name="fac_code">
                                <option value="1">침탄로 1호기</option>
                                <option value="2">침탄로 2호기</option>
                                <option value="3">침탄로 3호기</option>
                                <option value="4">침탄로 4호기</option>
                                <option value="18">침탄로 5호기</option>
                                <option value="5">고주파 1호기(폐기)</option>
                                <option value="6">고주파 2호기(폐기)</option>
                                <option value="9">고주파 5호기</option>
                                <option value="10">변성로 1호기</option>
                                <option value="11">변성로 2호기</option>
                                <option value="12">쇼트 1호기</option>
                                <option value="13">쇼트 2호기</option>
                                <option value="14">쇼트 3호기</option>
                                <option value="19">쇼트 4호기</option>
                                <option value="15">진공세정기 2호기</option>
                                <option value="16">템퍼링기 1호기</option>
                                <option value="17">템퍼링기 2호기</option>
                                <option value="20">전기시설</option>
                                <option value="21">급수시설</option>
                                <option value="22">콤프레샤</option>
                            </select>
                        </div>
                        <div class="suri-col">
                            <label>일자</label>
                            <input type="date" id="ffx_date" name="ffx_date">
                        </div>
                    </div>
                    
                    <div class="suri-row">
                        <div class="suri-col">
                            <label>수리처</label>
                            <input type="text" id="ffx_wrk" name="ffx_wrk">
                        </div>
                        <div class="suri-col">
                            <label>수리비용</label>
                            <input type="text" id="ffx_cost" name="ffx_cost">
                        </div>
                    </div>
                    
                    <div class="suri-row">
                        <div class="suri-col">
                            <label>담당자</label>
                            <select id="ffx_man" name="ffx_man">
                                <option value="admin">admin</option>
                                <option value="정중환">정중환</option>
                                <option value="김성우">김성우</option>
                                <option value="조병수">조병수</option>
                                <option value="이용희">이용희</option>
                                <option value="이은영">이은영</option>
                                <option value="산지와">산지와</option>
                                <option value="이주영">이주영</option>
                                <option value="가얀">가얀</option>
                                <option value="두사르">두사르</option>
                                <option value="피얀타">피얀타</option>
                                <option value="김영수">김영수</option>
                                <option value="패툼">패툼</option>
                                <option value="응웬티하">응웬티하</option>
                                <option value="양수석">양수석</option>
                                <option value="최균홍">최균홍</option>
                                <option value="정희주">정희주</option>
                                <option value="장무강">장무강</option>
                            </select>
                        </div>
                        <div class="suri-col">
                            <label>차기점검일</label>
                            <input type="date" id="ffx_next" name="ffx_next">
                        </div>
                    </div>
                    
                    <div class="suri-row">
                        <div class="suri-col-full">
                            <label>내용</label>
                            <textarea id="ffx_note" name="ffx_note" rows="4"></textarea>
                        </div>
                    </div>
                    
                    <!-- Hidden Fields -->
                    <input type="hidden" id="ffx_evt" name="ffx_evt">
                    <input type="hidden" id="ffx_time" name="ffx_time">
                    <input type="hidden" id="ffx_end" name="ffx_end">
                </div>

                <!-- 수리사진 섹션 -->
                <div class="suri-section">
                    <div class="suri-section-title">수리사진</div>
                    
                    <div class="image-upload-area">
                        <div class="image-upload-col">
                            <label>수리 전 사진</label>
                            <input type="file" name="file_url1" onchange="previewImage(this, 'previewId')">
                            <div class="img-preview" id="previewId">
                                <img id="img0" src="/resources/images/noimage_01.gif" alt="수리 전">
                            </div>
                        </div>
                        <div class="image-upload-col">
                            <label>수리 후 사진</label>
                            <input type="file" name="file_url2" onchange="previewImage(this, 'previewId2')">
                            <div class="img-preview" id="previewId2">
                                <img id="img1" src="/resources/images/noimage_01.gif" alt="수리 후">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 푸터 버튼 -->
            <div class="suri-modal-footer">
                <button type="button" class="btn-delete" onclick="deleteSuri();" style="display:none;">삭제</button>
                <button type="button" class="save">저장</button>
                <button type="button" class="close">닫기</button>
            </div>
        </div>
    </div>
</form>




	    
<script>
//========== 전역변수 ==========
let now_page_code = "e04";	
var suriTable;
var isEditMode = false;
var selectedRowData = null;

// ========== 페이지 로드 ==========
$(function() {
	if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    var tdate = todayDate();
    var ydate = yesterDate();
    
    $("#sdate").val(ydate);
    $("#edate").val(tdate);
    getSuriHistoryList();
    
    // 파일 선택시 이미지 띄우기
    $('.imgInputClass').change(function(event){
        var selectedFile = event.target.files[0];
        var reader = new FileReader();
        
        var img = $(this).parent().parent().find('img')[0];
        img.title = selectedFile.name;
        
        reader.onload = function(event) {
            img.src = event.target.result;
        };
        
        reader.readAsDataURL(selectedFile);
    });
});

// ========== 설비수리이력 리스트 조회 ==========
function getSuriHistoryList(){
    // 기존 테이블 완전히 제거
    if (suriTable) {
        suriTable.destroy();
        suriTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    suriTable = new Tabulator("#tab1", {
        height:"730px",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        headerSort:false,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/preservation/suriHistory/getSuriHistoryList",
        ajaxParams:{
            "sdate": $("#sdate").val(),
            "edate": $("#edate").val(),
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
            return response.data ? response.data : [];
        },
        
        columns:[
            {title:"NO", field:"idx", sorter:"int", width:80, hozAlign:"center"},
            {title:"설비NO", field:"fac_no", sorter:"int", width:80, hozAlign:"center"},
            {title:"설비명", field:"fac_name", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"점검일", field:"ffx_date", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"담당자", field:"ffx_man", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"수리처", field:"ffx_wrk", sorter:"string", width:100, hozAlign:"center", headerFilter:"input"},
            {title:"금액", field:"ffx_cost", sorter:"int", width:100, hozAlign:"center", headerFilter:"input"},
            {title:"내용", field:"ffx_note", sorter:"string", width:600, hozAlign:"center", headerFilter:"input"},
            {
                title:"수리 전 사진", 
                field:"file_name1", 
                width:100,
                hozAlign:"center", 
                formatter:"image",
                cssClass:"rp-img-popup",
                formatterParams:{
                    height:"30px", 
                    width:"30px",
                    urlPrefix:"/tkPrint/사진/설비수리이력관리/"
                }, 
                cellMouseEnter:function(e, cell){ 
                    if(cell.getValue()) {
                        productImage(cell.getValue());
                    }
                }
            },
            {
                title:"수리 후 사진", 
                field:"file_name2", 
                width:100,
                hozAlign:"center", 
                formatter:"image",
                cssClass:"rp-img-popup",
                formatterParams:{
                    height:"30px", 
                    width:"30px",
                    urlPrefix:"/tkPrint/사진/설비수리이력관리/"
                }, 
                cellMouseEnter:function(e, cell){ 
                    if(cell.getValue()) {
                        productImage(cell.getValue());
                    }
                }
            },
            {title:"ffx_no", field:"ffx_no", sorter:"int", width:80, hozAlign:"center", visible:false},
            {title:"fac_code", field:"fac_code", sorter:"int", width:80, hozAlign:"center", visible:false},
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
            console.log("더블클릭 데이터:", selectedRowData.ffx_no);
            $('#suriHistoryForm')[0].reset();
            
            suriHistoryDetail(data.ffx_no);
            $('.btn-delete').show();

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

// ========== 설비수리이력 상세 조회 ==========
function suriHistoryDetail(ffx_no){
    $.ajax({
        url:"/tkheat/preservation/suriHistory/suriHistoryDetail",
        type:"post",
        dataType:"json",
        data:{
            "ffx_no":ffx_no
        },
        success:function(result){
            console.log("📄 상세 데이터:", result);
            var allData = result.data;
            
            // ✅ 폼 초기화
            $('#suriHistoryForm')[0].reset();
            
            // ✅ 데이터 바인딩
            for(let key in allData){
                const value = allData[key];
                const $element = $("[name='"+key+"']");
                
                if ($element.length) {
                    const safeValue = (value === null || value === undefined) ? '' : value;
                    
                    if ($element.attr('type') === 'date') {
                        if (safeValue && safeValue !== '') {
                            const formattedDate = safeValue.replace(/[./]/g, '-').substring(0, 10);
                            $element.val(formattedDate);
                        }
                    } else {
                        $element.val(safeValue);
                    }
                }
            }
            
            // ✅ 이미지 초기화
            $("#img0").attr("src", "/resources/images/noimage_01.gif");
            $("#img1").attr("src", "/resources/images/noimage_01.gif");
            $("#img0").attr("title", "");
            $("#img1").attr("title", "");
            
            // ✅ 이미지 로드
            if (allData.file_name1) {
                console.log("수리 전 파일명:", allData.file_name1);
                const path1 = "/excelTest/태경출력파일/사진/설비수리이력관리/" + allData.file_name1;
                $("#img0").attr("src", path1);
                $("#img0").attr("title", allData.file_name1);
            }
            
            if (allData.file_name2) {
                console.log("수리 후 파일명:", allData.file_name2);
                const path2 = "/excelTest/태경출력파일/사진/설비수리이력관리/" + allData.file_name2;
                $("#img1").attr("src", path2);
                $("#img1").attr("title", allData.file_name2);
            }
            
            // 모달 열기
            $('.modal-overlay').addClass('active');
            $('.suri-modal').addClass('active');
        },
        error: function(xhr, status, error) {
            console.error("❌ 상세 조회 오류:", error);
            alert("데이터를 불러오는 중 오류가 발생했습니다.");
        }
    });
}

// ========== 저장 ==========
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
    var formData = new FormData($("#suriHistoryForm")[0]);
    let confirmMsg = "";
    
    if (isEditMode && selectedRowData && selectedRowData.ffx_no) {
        formData.append("mode", "update");
        formData.append("ffx_no", selectedRowData.ffx_no);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
    }
    
    // ✅ 필수 입력 검증
    if (!$("#fac_code").val() || $("#fac_code").val() === '') {
        alert("설비를 선택해주세요.");
        $("#fac_code").focus();
        return;
    }
    
    if (!$("#ffx_date").val() || $("#ffx_date").val() === '') {
        alert("일자를 입력해주세요.");
        $("#ffx_date").focus();
        return;
    }
    
    // ✅ 숫자 필드 빈값 처리
    if (!$("#ffx_cost").val() || $("#ffx_cost").val() === '') {
        formData.set("ffx_cost", "0");
    }
    
    // ✅ Hidden 필드 처리
    ['ffx_evt', 'ffx_time', 'ffx_end'].forEach(field => {
        const value = $("#" + field).val();
        if (!value || value === '' || value === 'null') {
            formData.delete(field);
        }
    });
    
    // ✅ 파일 필드 빈값 제거
    if (!$('input[name="file_url1"]')[0].files.length) {
        formData.delete('file_url1');
    }
    if (!$('input[name="file_url2"]')[0].files.length) {
        formData.delete('file_url2');
    }
    
    console.log("=== 전송 데이터 확인 ===");
    for (let pair of formData.entries()) {
        console.log(pair[0] + ': ' + pair[1]);
    }
    
    if (!confirm(confirmMsg)) return;
    
    $.ajax({
        url: "/tkheat/preservation/suriHistory/suriHistorySave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 저장 완료:", result);
            alert("저장 되었습니다.");
            
            $('.modal-overlay').removeClass('active');
            $('.suri-modal').removeClass('active');
            
            // 모달 위치 초기화
            $('.suri-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 폼 초기화
            $('#suriHistoryForm')[0].reset();
            isEditMode = false;
            selectedRowData = null;
            
            setTimeout(function() {
                getSuriHistoryList();
            }, 300);
        },
        error: function(xhr, status, error) {
            console.error("❌ 저장 오류:", xhr.status, error);
            console.error("응답 텍스트:", xhr.responseText);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 삭제 ==========
function deleteSuri() {
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
	    
    if (!selectedRowData || !selectedRowData.ffx_no) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }
    
    if (!confirm("삭제하시겠습니까?")) {
        return;
    }
    
    $.ajax({
        url: "/tkheat/preservation/suriHistory/suriHistoryDelete",
        type: "POST",
        data: {
            ffx_no: selectedRowData.ffx_no
        },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay').removeClass('active');
                $('.suri-modal').removeClass('active');
                
                setTimeout(function() {
                    getSuriHistoryList();
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

// ========== 이미지 미리보기 ==========
function previewImage(input, previewId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#' + previewId + ' img').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

// ========== 드래그 기능 ==========
const modal = document.querySelector('.suri-modal');
const header = document.querySelector('.suri-header');

header.addEventListener('mousedown', function(e) {
    if (e.target.classList.contains('header-close-btn') || e.target.closest('.header-close-btn')) {
        return;
    }
    
    const rect = modal.getBoundingClientRect();
    modal.style.left = rect.left + 'px';
    modal.style.top = rect.top + 'px';
    modal.style.transform = 'none';
    
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

// ========== 모달 열기/닫기 ==========
const insertButton = document.querySelector('.insert-button');
const suriModal = document.querySelector('.suri-modal');
const modalOverlay = document.querySelector('.modal-overlay');
const closeButton = document.querySelector('.close');
const headerCloseBtn = document.querySelector('.header-close-btn');

insertButton.addEventListener('click', function() {
    isEditMode = false;
    selectedRowData = null;
    
    // ✅ 폼 완전 초기화
    $('#suriHistoryForm')[0].reset();
    
    // ✅ 이미지 초기화
    $("#img0").attr("src", "/resources/images/noimage_01.gif");
    $("#img1").attr("src", "/resources/images/noimage_01.gif");
    $("#img0").attr("title", "");
    $("#img1").attr("title", "");
    
    // 중앙 정렬
    suriModal.style.left = '50%';
    suriModal.style.top = '50%';
    suriModal.style.transform = 'translate(-50%, -50%)';
    
    modalOverlay.classList.add('active');
    suriModal.classList.add('active');
    
    $('.btn-delete').hide();
});

closeButton.addEventListener('click', function() {
    modalOverlay.classList.remove('active');
    suriModal.classList.remove('active');
});

headerCloseBtn.addEventListener('click', function() {
    modalOverlay.classList.remove('active');
    suriModal.classList.remove('active');
});

// ========== 저장 버튼 ==========
$('.save').click(function() {
    save();
});

// ========== 엑셀 다운로드 ==========
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "설비수리이력관리_" + today + ".xlsx";
    suriTable.download("xlsx", filename, { sheetName: "설비수리이력관리" });
});

    </script>

	</body>
</html>
