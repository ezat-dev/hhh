<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>측정기기고장이력</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>
<style>
.main { width: 98%; }
.container { display: flex; justify-content: space-between; }
.tabulator { width: 100%; max-width: 100%; overflow-x: hidden !important; }
.tabulator .tabulator-cell { white-space: normal !important; word-break: break-word; text-align: center; }
.row_select { background-color: #9ABCEA !important; }

.box1 {
    display: flex; justify-content: right; align-items: center;
    width: 1500px; margin-left: -1050px; gap: 10px;
}
.box1 select { width: 5%; }
.box1 input[type="date"] {
    width: 150px; padding: 5px 10px; font-size: 16px;
    border: 1px solid #ccc; border-radius: 6px;
    background-color: #f9f9f9; color: #333;
    outline: none; transition: border 0.3s ease;
}
.box1 input[type="date"]:focus { border: 1px solid #007bff; background-color: #fff; }
.box1 label, .box1 input { margin-right: 10px; }

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

/* ========== 고장이력 모달 컨테이너 ========== */
.gojangModal {
    display: none; position: fixed;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
}
.gojangModal.show { display: block; }

.gojang-insert-box {
    width: 860px; max-width: 95vw;
    max-height: 95vh;
    background: white; border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0,0,0,0.3);
    overflow: hidden; display: flex; flex-direction: column;
}

/* ========== 모달 헤더 ========== */
.header {
    display: flex; justify-content: space-between; align-items: center;
    padding: 8px 16px;
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white; font-size: 15px; font-weight: 700; cursor: move;
    flex-shrink: 0;
}
.header-close {
    cursor: pointer; font-size: 22px; color: white;
    width: 26px; height: 26px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 4px; transition: all 0.3s;
}
.header-close:hover { background: rgba(255,255,255,0.2); transform: rotate(90deg); }

/* ========== 모달 본문 ========== */
.gojang-modal-body {
    flex: 1; overflow-y: auto; overflow-x: hidden;
    background: #f5f7fa;
    padding: 8px 10px;
    max-height: calc(95vh - 90px);
}
.gojang-modal-body::-webkit-scrollbar { width: 5px; }
.gojang-modal-body::-webkit-scrollbar-track { background: #e0e0e0; }
.gojang-modal-body::-webkit-scrollbar-thumb { background: #999; border-radius: 4px; }

/* ========== 섹션 ========== */
.gojang-section {
    background: white; border-radius: 6px;
    padding: 6px 10px; margin-bottom: 5px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.05);
}
.gojang-section:last-child { margin-bottom: 0; }
.gojang-section-title {
    font-size: 11px; font-weight: 700; color: #2c3e50;
    margin-bottom: 5px; padding-bottom: 4px;
    border-bottom: 1px solid #e9ecef;
}

/* ========== 행/열 레이아웃 ========== */
.gojang-row {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 6px; margin-bottom: 5px;
}
.gojang-row:last-child { margin-bottom: 0; }
.gojang-row-4 {
    display: grid; grid-template-columns: repeat(4,1fr);
    gap: 6px; margin-bottom: 5px;
}
.gojang-col { display: flex; flex-direction: column; gap: 2px; }
.gojang-col-full { grid-column: 1/-1; display: flex; flex-direction: column; gap: 2px; }
.gojang-col label, .gojang-col-full label {
    font-size: 10px; font-weight: 600; color: #495057;
}

/* ========== 입력 필드 ========== */
.gojang-col input[type="text"],
.gojang-col input[type="date"],
.gojang-col select,
.gojang-col-full input[type="text"],
.gojang-col-full textarea {
    width: 100%; padding: 3px 7px;
    border: 1px solid #ced4da; border-radius: 4px;
    font-size: 11px; box-sizing: border-box; transition: all 0.2s;
    height: 26px;
}
.gojang-col input:focus, .gojang-col select:focus,
.gojang-col-full input:focus, .gojang-col-full textarea:focus {
    outline: none; border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77,171,247,0.1);
}
.gojang-col input[disabled] { background: #f1f3f5; cursor: not-allowed; }
.gojang-col select {
    cursor: pointer; appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat; background-position: right 8px center; padding-right: 26px;
}
.gojang-col-full textarea {
    height: 44px; min-height: unset; resize: vertical; font-family: inherit;
}

/* ========== 시간 입력 inline ========== */
.time-inline { display: flex; align-items: center; gap: 3px; }
.time-inline input[type="date"] { width: 120px !important; flex-shrink: 0; }
.time-inline input[type="text"] { width: 38px !important; text-align: center; }
.time-inline span { font-size: 11px; color: #495057; }

/* ========== 이미지 업로드 ========== */
.img-upload-row {
    display: grid; grid-template-columns: repeat(2,1fr);
    gap: 8px;
}
.img-upload-col { display: flex; flex-direction: column; gap: 4px; }
.img-upload-col label { font-size: 10px; font-weight: 600; color: #495057; }
.img-upload-col input[type="file"] {
    padding: 3px; border: 1px solid #ced4da; border-radius: 3px;
    font-size: 10px; cursor: pointer;
}
.img-preview {
    width: 100%; height: 120px;
    border: 2px dashed #ced4da; border-radius: 5px;
    display: flex; align-items: center; justify-content: center;
    background: #f8f9fa; overflow: hidden;
}
.img-preview img { max-width: 100%; max-height: 100%; object-fit: contain; }

/* ========== 모달 푸터 ========== */
.gojang-modal-footer {
    display: flex; justify-content: center; align-items: center;
    gap: 8px; padding: 7px 16px;
    background: white; border-top: 1px solid #dee2e6;
    flex-shrink: 0;
}
.gojang-modal-footer button {
    min-width: 80px; height: 30px;
    border: none; border-radius: 4px;
    font-size: 12px; font-weight: 700; cursor: pointer; transition: all 0.3s;
}
.save    { background: linear-gradient(135deg,#51cf66,#37b24d); color: white; }
.save:hover { background: linear-gradient(135deg,#40c057,#2f9e44); transform: translateY(-1px); }
.btn-delete { background: linear-gradient(135deg,#ff6b6b,#fa5252); color: white; }
.btn-delete:hover { background: linear-gradient(135deg,#f03e3e,#e03131); transform: translateY(-1px); }
.close   { background: linear-gradient(135deg,#868e96,#495057); color: white; }
.close:hover { background: linear-gradient(135deg,#6c757d,#343a40); transform: translateY(-1px); }

/* ========== PDF 미리보기 모달 ========== */
.modal-overlay {
    position: fixed; top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(0,0,0,0.6);
    display: flex; align-items: center; justify-content: center; z-index: 9999;
}
.modal-content {
    background: white; border-radius: 8px;
    width: 80%; max-width: 1200px; height: 90%;
    box-shadow: 0 4px 20px rgba(0,0,0,0.5);
    position: relative; overflow: hidden;
    display: flex; flex-direction: column;
}
</style>
</head>
<body>

<div class="tab">
    <div class="box1">
        <p class="tabP" style="font-size:20px; margin-left:40px; color:white; font-weight:800;"></p>
        <label class="daylabel">기간 : </label>
        <input type="date" id="sdate" style="font-size:16px;" autocomplete="off"> ~
        <input type="date" id="edate" style="font-size:16px;" autocomplete="off">
    </div>
    <div class="button-container">
        <button class="select-button" onclick="getGigiGojangList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">조회
        </button>
        <button class="insert-button">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">입력
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">엑셀
        </button>
    </div>
</div>

<main class="main">
    <div class="container">
        <div id="tab1" class="tabulator"></div>
    </div>
</main>

<!-- 이미지 확대 오버레이 -->
<div id="imgZoomOverlay" style="display:none;">
    <img id="imgZoomTarget" src="">
</div>

<form autocomplete="off" method="post" id="gigiGojangForm" name="gigiGojangForm" enctype="multipart/form-data">
    <div class="gojangModal">
        <div class="gojang-insert-box">
            <!-- 헤더 -->
            <div class="header">
                <span>측정기기고장이력</span>
                <span class="header-close">&times;</span>
            </div>

            <!-- 본문 -->
            <div class="gojang-modal-body">

                <!-- 기본정보 -->
                <div class="gojang-section">
                    <h3 class="gojang-section-title">기본정보</h3>
                    <div class="gojang-row">
                        <div class="gojang-col">
                            <label>측정기기</label>
                            <select id="ter_code" name="ter_code">
                                <option value="1">로크웰경도기</option>
                                <option value="2">비커스경도기</option>
                            </select>
                            <input type="hidden" id="terr_code" name="terr_code">
                        </div>
                        <div class="gojang-col">
                            <label>확인자</label>
                            <select id="terr_chkman" name="terr_chkman">
                                <option value="0">admin</option>
                                <option value="2">정중환</option>
                                <option value="5">조병수</option>
                                <option value="12">이은영</option>
                                <option value="7">이용희</option>
                                <option value="26">산지와</option>
                                <option value="31">이주영</option>
                                <option value="32">가얀</option>
                                <option value="36">두사르</option>
                                <option value="41">패툼</option>
                                <option value="42">응웬티하</option>
                                <option value="44">최균홍</option>
                                <option value="45">정희주</option>
                                <option value="37">피얀타</option>
                                <option value="4">김성우</option>
                                <option value="9">외국인전용ID</option>
                                <option value="46">장무강</option>
                                <option value="40">김영수</option>
                            </select>
                        </div>
                    </div>
                    <div class="gojang-row">
                        <div class="gojang-col">
                            <label>고장일시</label>
                            <input type="date" id="terr_date" name="terr_date">
                        </div>
                        <div class="gojang-col">
                            <label>상태</label>
                            <select id="terr_condi" name="terr_condi">
                                <option>가동</option>
                                <option>비가동</option>
                            </select>
                        </div>
                    </div>
                    <div class="gojang-row">
                        <div class="gojang-col">
                            <label>소요비용</label>
                            <input type="text" id="terr_cost" name="terr_cost"
                                onchange="getNumber(this);" onkeyup="getNumber(this);" style="text-align:right;">
                        </div>
                        <div class="gojang-col">
                            <label>수리</label>
                            <select id="terr_suri" name="terr_suri">
                                <option>수리</option>
                                <option>완료</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- 수리시간 -->
                <div class="gojang-section">
                    <h3 class="gojang-section-title">수리시간</h3>
                    <div class="gojang-row">
                        <div class="gojang-col">
                            <label>수리시작시간</label>
                            <div class="time-inline">
                                <input type="date" id="terr_strt" name="terr_strt">
                                <input type="text" id="terr_strt_h"  name="terr_strt_h"  value="0" placeholder="00">
                                <span>시</span>
                                <input type="text" id="terr_strt_mm" name="terr_strt_mm" value="0" placeholder="00">
                                <span>분</span>
                                <input type="text" id="terr_strt_ss" name="terr_strt_ss" value="0" placeholder="00">
                                <span>초</span>
                            </div>
                        </div>
                        <div class="gojang-col">
                            <label>수리종료시간</label>
                            <div class="time-inline">
                                <input type="date" id="TERR_END" name="terr_end">
                                <input type="text" id="terr_end_h"  name="terr_end_h"  value="0" placeholder="00">
                                <span>시</span>
                                <input type="text" id="terr_end_mm" name="terr_end_mm" value="0" placeholder="00">
                                <span>분</span>
                                <input type="text" id="terr_end_ss" name="terr_end_ss" value="0" placeholder="00">
                                <span>초</span>
                            </div>
                        </div>
                    </div>
                    <div class="gojang-row">
                        <div class="gojang-col">
                            <label>수리시간</label>
                            <input type="text" id="terr_time" name="terr_time" disabled>
                        </div>
                        <div class="gojang-col">
                            <label>수리자</label>
                            <input type="text" id="terr_man" name="terr_man">
                        </div>
                    </div>
                </div>

                <!-- 내용 -->
                <div class="gojang-section">
                    <h3 class="gojang-section-title">내용</h3>
                    <div class="gojang-row">
                        <div class="gojang-col">
                            <label>고장현상</label>
                            <textarea id="terr_reward" name="terr_reward"></textarea>
                        </div>
                        <div class="gojang-col">
                            <label>수리내용</label>
                            <textarea id="terr_content" name="terr_content"></textarea>
                        </div>
                    </div>
                    <div class="gojang-row">
                        <div class="gojang-col-full">
                            <label>비고</label>
                            <textarea id="terr_bigo" name="terr_bigo" style="height:50px;"></textarea>
                        </div>
                    </div>
                </div>

                <!-- 사진 -->
                <div class="gojang-section">
                    <h3 class="gojang-section-title">사진</h3>
                    <div class="img-upload-row">
                        <div class="img-upload-col">
                            <label>수리전사진</label>
                            <input type="file" id="terr_bphoto" name="terr_bphoto_url" accept="image/*"
                                onchange="previewGojangImage(this, 'terr_bphoto_before');">
                            <div class="img-preview">
                                <img id="terr_bphoto_before" src="/tkheat/css/image/no_image.png" alt="수리전사진">
                            </div>
                        </div>
                        <div class="img-upload-col">
                            <label>수리후사진</label>
                            <input type="file" id="terr_aphoto" name="terr_aphoto_url" accept="image/*"
                                onchange="previewGojangImage(this, 'terr_aphoto_after');">
                            <div class="img-preview">
                                <img id="terr_aphoto_after" src="/tkheat/css/image/no_image.png" alt="수리후사진">
                            </div>
                        </div>
                    </div>
                </div>

            </div><!-- /gojang-modal-body -->

            <!-- 푸터 -->
            <div class="gojang-modal-footer">
                <button type="button" class="btn-delete" style="display:none;" onclick="deleteGigiGojang();">삭제</button>
                <button type="button" class="save" onclick="save();">저장</button>
                <button type="button" class="close">닫기</button>
            </div>
        </div>
    </div>
</form>

<script>
let now_page_code = "e08";
var userTable;
var isEditMode = false;
var selectedRowData = null;

$(function(){
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    var tdate = todayDate();
    var ydate = yesterDate();
    $("#sdate").val(ydate);
    $("#edate").val(tdate);
    getGigiGojangList();
});
//========== 숫자 포맷 ==========
function getNumber(el) {
    var val = el.value.replace(/[^0-9]/g, '');
    el.value = val.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
// ========== 리스트 조회 ==========
function getGigiGojangList(){
    if (userTable) { userTable.destroy(); userTable = null; }
    $('#tab1').empty();

    userTable = new Tabulator("#tab1", {
        height:"100%", layout:"fitColumns", selectable:true,
        tooltips:true, headerSort:false,
        selectableRangeMode:"click", reactiveData:true,
        headerHozAlign:"center", ajaxConfig:"POST", ajaxLoader:false,
        ajaxURL:"/tkheat/preservation/gigiGojang/getGigiGojangList",
        ajaxParams:{ "sdate": $("#sdate").val(), "edate": $("#edate").val() },
        placeholder:"조회된 데이터가 없습니다.",
        pagination:"local", paginationSize:20, paginationSizeSelector:[20,50,100,500,1000], paginationCounter:"rows",
        headerFilterPlaceholder:"",
        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
            return response.data ? response.data : response;  // ★ 수정
        },
        columns:[
            {title:"측정기기",    field:"terr_name",    width:120, hozAlign:"center", headerFilter:"input"},
            {title:"고장일시",    field:"terr_date",    width:120, hozAlign:"center", headerFilter:"input"},
            {title:"고장현상",    field:"terr_reward",  width:150, hozAlign:"center", headerFilter:"input"},
            {title:"수리시작시간", field:"terr_strt",    width:150, hozAlign:"center", headerFilter:"input"},
            {title:"수리종료시간", field:"terr_end",     width:150, hozAlign:"center", headerFilter:"input"},
            {title:"수리시간",    field:"terr_time",    width:100, hozAlign:"center", headerFilter:"input"},
            {title:"수리내용",    field:"terr_content", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"수리자",     field:"terr_man",     width:100, hozAlign:"center", headerFilter:"input"},
            {title:"소요비용",    field:"terr_cost",    width:100, hozAlign:"center", headerFilter:"input"},
            {title:"수리전사진",  field:"terr_bphoto",  width:80,  hozAlign:"center", formatter:"image",
                formatterParams:{ height:"30px", width:"30px", urlPrefix:"/tkPrint/사진/측정기기고장이력/" },
                cellMouseEnter:function(e, cell){ productImage(cell.getValue()); }
            },
            {title:"수리후사진",  field:"terr_aphoto",  width:80,  hozAlign:"center", formatter:"image",
                formatterParams:{ height:"30px", width:"30px", urlPrefix:"/tkPrint/사진/측정기기고장이력/" },
                cellMouseEnter:function(e, cell){ productImage(cell.getValue()); }
            },
            {title:"", field:"terr_code", visible:false},
            {title:"", field:"ter_code",  visible:false},
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "600";
        },
        rowClick:function(e, row){
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");
        },
        rowDblClick:function(e, row){
            if (window.disableRowDblClick) { alert("수정 권한이 없습니다."); return false; }
            var data = row.getData();
            selectedRowData = data;
            isEditMode = true;
            gigiGojangtDetail(data.terr_code);

            const permission = userPermissions?.[now_page_code];
            if (permission === 'D') {
                $('.btn-delete').show();
            } else {
                $('.btn-delete').hide();
            }
        },
    });
}

// ========== 상세 조회 ==========
function gigiGojangtDetail(terr_code){
    $.ajax({
        url:"/tkheat/preservation/gigiGojang/gigiGojangtDetail",
        type:"post", dataType:"json",
        data:{ "terr_code": terr_code },
        success:function(result){
            var d = result.data;
            $('#gigiGojangForm')[0].reset();

            // input, select, textarea 전체 바인딩
            for(let key in d){
                const val = (d[key] === null || d[key] === undefined) ? '' : d[key];
                $("[name='"+key+"']").val(val);
            }

            // 사진 처리
            $('#terr_bphoto_before').attr('src', '/tkheat/css/image/no_image.png');
            $('#terr_aphoto_after').attr('src', '/tkheat/css/image/no_image.png');

            if (d.terr_bphoto && d.terr_bphoto !== '') {
                $('#terr_bphoto_before').attr('src', '/tkPrint/사진/측정기기고장이력/' + d.terr_bphoto);
            }
            if (d.terr_aphoto && d.terr_aphoto !== '') {
                $('#terr_aphoto_after').attr('src', '/tkPrint/사진/측정기기고장이력/' + d.terr_aphoto);
            }

            $('.gojangModal').show();
        },
        error: function(xhr, status, error){
            console.error("상세 조회 오류:", error);
            alert("데이터를 불러오는 중 오류가 발생했습니다.");
        }
    });
}

// ========== 저장 ==========
function save(){
    const permission = userPermissions?.[now_page_code];

    if (!isEditMode) {
        if (!['I', 'U', 'D'].includes(permission)) {
            alert("등록 권한이 없습니다."); return false;
        }
    } else {
        if (!['U', 'D'].includes(permission)) {
            alert("수정 권한이 없습니다."); return false;
        }
    }

    var formData = new FormData($("#gigiGojangForm")[0]);
    let confirmMsg = "";

    if (isEditMode && selectedRowData && selectedRowData.terr_code) {
        formData.append("mode", "update");
        formData.append("terr_code", selectedRowData.terr_code);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
    }

    if (!confirm(confirmMsg)) return;

    $.ajax({
        url: "/tkheat/preservation/gigiGojang/gigiGojangSave",
        type: "POST", data: formData,
        contentType: false, processData: false, dataType: "json",
        success: function(result){
            alert("저장 되었습니다.");
            $('.gojangModal').hide();
            isEditMode = false; selectedRowData = null;
            getGigiGojangList();
        },
        error: function(xhr, status, error){
            console.error("저장 오류:", error);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 삭제 ==========
function deleteGigiGojang(){
    const permission = userPermissions?.[now_page_code];
    if (permission !== 'D') { alert("삭제 권한이 없습니다."); return false; }
    if (!selectedRowData || !selectedRowData.terr_code) { alert("삭제할 대상을 선택하세요."); return; }
    if (!confirm("삭제하시겠습니까?")) return;

    $.ajax({
        url: "/tkheat/preservation/gigiGojang/deleteGigiGojang",
        type: "POST", data: { terr_code: selectedRowData.terr_code }, dataType: "json",
        success: function(result){
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.gojangModal').hide();
                isEditMode = false; selectedRowData = null;
                getGigiGojangList();
            } else {
                alert("삭제 중 오류가 발생했습니다: " + result.message);
            }
        },
        error: function(xhr, status, error){
            console.error("삭제 오류:", error);
            alert("삭제 요청 중 오류가 발생했습니다.");
        }
    });
}

// ========== 이미지 미리보기 ==========
function previewGojangImage(input, targetId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) { $('#' + targetId).attr('src', e.target.result); };
        reader.readAsDataURL(input.files[0]);
    }
}

// ========== 모달 드래그 ==========
const gojangModalEl = document.querySelector('.gojangModal');
const gojangHeader  = document.querySelector('.gojangModal .header');

gojangHeader.addEventListener('mousedown', function(e) {
    if (e.target.classList.contains('header-close')) return;
    const rect = gojangModalEl.getBoundingClientRect();
    gojangModalEl.style.left = rect.left + 'px';
    gojangModalEl.style.top  = rect.top  + 'px';
    gojangModalEl.style.transform = 'none';

    let offsetX = e.clientX - rect.left;
    let offsetY = e.clientY - rect.top;

    function moveModal(e) {
        gojangModalEl.style.left = (e.clientX - offsetX) + 'px';
        gojangModalEl.style.top  = (e.clientY - offsetY) + 'px';
    }
    function stopMove() {
        window.removeEventListener('mousemove', moveModal);
        window.removeEventListener('mouseup', stopMove);
    }
    window.addEventListener('mousemove', moveModal);
    window.addEventListener('mouseup', stopMove);
});

// ========== 모달 열기/닫기 ==========
document.querySelector('.insert-button').addEventListener('click', function() {
    isEditMode = false;
    selectedRowData = null;
    $('#gigiGojangForm')[0].reset();
    $('#terr_bphoto_before, #terr_aphoto_after').attr('src', '/tkheat/css/image/no_image.png');
    $('.btn-delete').hide();
    gojangModalEl.style.left = '50%';
    gojangModalEl.style.top  = '50%';
    gojangModalEl.style.transform = 'translate(-50%, -50%)';
    $('.gojangModal').show();
});

document.querySelector('.gojangModal .close').addEventListener('click', function() {
    $('.gojangModal').hide();
});
document.querySelector('.header-close').addEventListener('click', function() {
    $('.gojangModal').hide();
});

// ========== PDF 미리보기 ==========
function openDrawingModal(event, fileName) {
    event.preventDefault();
    if (!fileName) { alert("저장된 파일이 없습니다."); return; }
    const filePath = "/tkPrint/사진/측정기기고장이력/" + fileName;
    $("#drawingFileName").text(fileName);
    $("#pdfViewer").attr("src", filePath);
    $('#drawingFileModal').css('display', 'flex');
}
function closeDrawingModal() {
    $('#drawingFileModal').css('display', 'none');
    $("#pdfViewer").attr("src", "");
}
</script>

</body>
</html>