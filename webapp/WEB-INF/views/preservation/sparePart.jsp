<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>sparePart관리</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <script type="text/javascript" src="https://oss.sheetjs.com/sheetjs/xlsx.full.min.js"></script>
<%@include file="../include/pluginpage.jsp" %> 
   <style>
/* ========== 기본 레이아웃 ========== */
.main {
    width: 98%;
    padding: 5px;  /* ✅ 10px → 5px */
}

/* ========== 타뷸레이터 컨테이너 ========== */
.table-section {
    background: white;
    border-radius: 6px;
    padding: 12px;  /* ✅ 20px → 12px */
    margin-bottom: 10px;  /* ✅ 20px → 10px */
    box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;  /* ✅ 15px → 10px */
    padding-bottom: 6px;  /* ✅ 10px → 6px */
    border-bottom: 2px solid #e9ecef;
}

.section-title {
    font-size: 16px;  /* ✅ 18px → 16px */
    font-weight: 700;
    color: #2c3e50;
}

.section-buttons {
    display: flex;
    gap: 6px;  /* ✅ 8px → 6px */
}

.section-buttons button {
    padding: 6px 14px;  /* ✅ 8px 16px → 6px 14px */
    border: none;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
}

.btn-insert {
    background: linear-gradient(135deg, #51cf66, #37b24d);
    color: white;
}

.btn-insert:hover {
    background: linear-gradient(135deg, #40c057, #2f9e44);
    transform: translateY(-2px);
}

.btn-delete-sub {
    background: linear-gradient(135deg, #ff6b6b, #fa5252);
    color: white;
}

.btn-delete-sub:hover {
    background: linear-gradient(135deg, #f03e3e, #e03131);
    transform: translateY(-2px);
}

.tabulator {
    width: 100%;
}

.row_select {
    background-color: #ffd700 !important;
    color: #000;
}

/* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
/* 이 페이지는 리스트가 위/아래 2개(#tab1, #sub) — 기존 비율(2:1)을 유지한 채 세로로 쌓음 */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main {
    flex: 1;
    min-height: 0;
    display: flex;
    flex-direction: column;
    gap: 8px;
    padding: 8px;
    overflow: hidden;
}
.table-section {
    display: flex;
    flex-direction: column;
    min-height: 0;
    margin-bottom: 0;
    overflow: hidden;
}
.table-section:nth-of-type(1) { flex: 2; }
.table-section:nth-of-type(2) { flex: 1; }
.section-header { flex-shrink: 0; }

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

/* ========== Tabulator 리스트 (위: #tab1, 아래: #sub 둘 다 동일하게 적용) ========== */
#tab1.tabulator,
#sub.tabulator {
    flex: 1;
    min-height: 0;
    border: none;
    font-size: 12px;
}
#tab1 .tabulator-header,
#sub .tabulator-header {
    background: linear-gradient(135deg, #2B6CB0, #3182CE);
    border-bottom: none;
}
#tab1 .tabulator-col,
#sub .tabulator-col {
    background: transparent;
    border-right: 1px solid rgba(255,255,255,.15);
}
#tab1 .tabulator-col.tabulator-sortable:hover,
#sub .tabulator-col.tabulator-sortable:hover {
    background: rgba(255,255,255,.08);
}
#tab1 .tabulator-col-title,
#sub .tabulator-col-title {
    color: #ffffff;
    font-weight: 700;
}
#tab1 .tabulator-col .tabulator-header-filter input,
#sub .tabulator-col .tabulator-header-filter input {
    border: none;
    border-radius: 5px;
    padding: 4px 6px;
    font-size: 11px;
    background: rgba(255,255,255,.92);
    box-sizing: border-box;
}
#tab1 .tabulator-col .tabulator-header-filter input:focus,
#sub .tabulator-col .tabulator-header-filter input:focus {
    outline: none;
    background: #ffffff;
    box-shadow: 0 0 0 2px rgba(255,255,255,.6);
}
#tab1 .tabulator-row,
#sub .tabulator-row {
    border-bottom: 1px solid #EDF2F7;
    transition: background-color .12s;
}
#tab1 .tabulator-row.tabulator-row-even,
#sub .tabulator-row.tabulator-row-even {
    background-color: #F7FAFC;
}
#tab1 .tabulator-row:hover,
#sub .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
#tab1 .tabulator-row.row_select,
#tab1 .tabulator-row.tabulator-selected,
#sub .tabulator-row.row_select,
#sub .tabulator-row.tabulator-selected {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
#tab1 .tabulator-cell,
#sub .tabulator-cell {
    border: 1px solid #E2E8F0;
    color: #2D3748;
}

/* ========== 페이지네이션 (직관적으로 개선) ========== */
#tab1 .tabulator-footer,
#sub .tabulator-footer {
    background: #F7FAFC;
    border-top: 1px solid #E2E8F0;
    padding: 8px 12px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
}
#tab1 .tabulator-paginator,
#sub .tabulator-paginator {
    display: flex;
    align-items: center;
    gap: 6px;
}
#tab1 .tabulator-page-size,
#sub .tabulator-page-size {
    border: 1px solid #E2E8F0;
    border-radius: 6px;
    padding: 4px 8px;
    font-size: 12px;
    background: #ffffff;
    color: #2D3748;
    cursor: pointer;
    margin: 0;
}
#tab1 .tabulator-page-size:focus,
#sub .tabulator-page-size:focus {
    outline: none;
    border-color: #3182CE;
}
#tab1 .tabulator-pages,
#sub .tabulator-pages {
    display: flex;
    gap: 4px;
    margin: 0;
}
#tab1 .tabulator-page,
#sub .tabulator-page {
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
#tab1 .tabulator-page.active,
#sub .tabulator-page.active {
    background: #3182CE;
    border-color: #2B6CB0;
    color: #ffffff;
}
#tab1 .tabulator-page:not(:disabled):hover,
#sub .tabulator-page:not(:disabled):hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
    color: #2B6CB0;
    cursor: pointer;
}
#tab1 .tabulator-page:disabled,
#sub .tabulator-page:disabled {
    opacity: .4;
    cursor: not-allowed;
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

/* ========== SparePart 메인 모달 ========== */
.spare-modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1000;
}

.spare-modal.active {
    display: block;
}

.spare-box {
    width: 600px;
    max-width: 95vw;
    max-height: 90vh;
    background: white;
    border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0, 0, 0, 0.3);
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

/* ========== 모달 헤더 ========== */
.spare-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px;  /* ✅ 15px 25px → 10px 20px */
    background: linear-gradient(135deg, #2c3e50, #34495e);
    color: white;
    font-size: 18px;  /* ✅ 20px → 18px */
    font-weight: 700;
    cursor: move;
}

.header-close-btn {
    background: none;
    border: none;
    color: white;
    font-size: 24px;  /* ✅ 28px → 24px */
    cursor: pointer;
    width: 28px;  /* ✅ 30px → 28px */
    height: 28px;
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
.spare-modal-body {
    flex: 1;
    overflow-y: auto;
    overflow-x: hidden;
    background: #f5f7fa;
    padding: 12px;  /* ✅ 20px → 12px */
    max-height: 650px;  /* ✅ 700px → 650px */
}

.spare-modal-body::-webkit-scrollbar {
    width: 6px;  /* ✅ 8px → 6px */
}

.spare-modal-body::-webkit-scrollbar-track {
    background: #e0e0e0;
}

.spare-modal-body::-webkit-scrollbar-thumb {
    background: #999;
    border-radius: 3px;
}

/* ========== 섹션 ========== */
.spare-section {
    background: white;
    border-radius: 6px;
    padding: 10px 15px;  /* ✅ 15px 20px → 10px 15px */
    margin-bottom: 10px;  /* ✅ 15px → 10px */
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.spare-section:last-child {
    margin-bottom: 0;
}

.spare-section-title {
    font-size: 14px;  /* ✅ 15px → 14px */
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 8px;  /* ✅ 12px → 8px */
    padding-bottom: 6px;  /* ✅ 8px → 6px */
    border-bottom: 2px solid #e9ecef;
}

/* ========== 기본 행/열 레이아웃 ========== */
.spare-row {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 10px;  /* ✅ 12px → 10px */
    margin-bottom: 8px;  /* ✅ 10px → 8px */
}

.spare-row:last-child {
    margin-bottom: 0;
}

.spare-col {
    display: flex;
    flex-direction: column;
    gap: 4px;  /* ✅ 5px → 4px */
}

.spare-col-full {
    grid-column: 1 / -1;
    display: flex;
    flex-direction: column;
    gap: 4px;  /* ✅ 5px → 4px */
}

.spare-col label,
.spare-col-full label {
    font-size: 12px;  /* ✅ 13px → 12px */
    font-weight: 600;
    color: #495057;
}

/* ========== 입력 필드 ========== */
.spare-col input[type="text"],
.spare-col input[type="file"],
.spare-col select,
.spare-col-full input[type="text"],
.spare-col-full select {
    padding: 6px 10px;  /* ✅ 8px 12px → 6px 10px */
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 12px;  /* ✅ 13px → 12px */
    box-sizing: border-box;
    transition: all 0.3s;
    width: 100%;
}

.spare-col input:focus,
.spare-col select:focus,
.spare-col-full input:focus,
.spare-col-full select:focus {
    outline: none;
    border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77, 171, 247, 0.1);  /* ✅ 3px → 2px */
}

.spare-col input[readonly],
.spare-col-full input[readonly] {
    background: #f1f3f5;
    cursor: not-allowed;
}

.spare-col select,
.spare-col-full select {
    cursor: pointer;
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23495057' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 8px center;  /* ✅ 10px → 8px */
    padding-right: 28px;  /* ✅ 32px → 28px */
}

/* ========== 이미지 업로드 섹션 ========== */
.image-upload-section {
    display: flex;
    flex-direction: column;
    gap: 8px;  /* ✅ 10px → 8px */
}

.image-preview {
    width: 100%;
    height: 180px;  /* ✅ 200px → 180px */
    border: 2px dashed #ced4da;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    background: #f8f9fa;
}

.image-preview img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

.file-input-wrapper {
    display: flex;
    gap: 6px;  /* ✅ 8px → 6px */
}

.file-input-wrapper input[type="file"] {
    flex: 1;
}

.download-link {
    padding: 6px 10px;  /* ✅ 8px 12px → 6px 10px */
    background: #4dabf7;
    color: white;
    text-decoration: none;
    border-radius: 4px;
    font-size: 12px;  /* ✅ 13px → 12px */
    font-weight: 600;
    text-align: center;
    white-space: nowrap;
    transition: all 0.3s;
}

.download-link:hover {
    background: #339af0;
}

/* ========== 모달 푸터 ========== */
.spare-modal-footer {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;  /* ✅ 10px → 8px */
    padding: 10px 15px;  /* ✅ 15px 20px → 10px 15px */
    background: white;
    border-top: 1px solid #dee2e6;
}

.spare-modal-footer button {
    min-width: 90px;  /* ✅ 100px → 90px */
    height: 34px;  /* ✅ 38px → 34px */
    border: none;
    border-radius: 4px;
    font-size: 13px;  /* ✅ 14px → 13px */
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

/* ========== 관리내역 모달 (동일 스타일) ========== */
.spare-his-modal {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 1001;
}

.spare-his-modal.active {
    display: block;
}

.spare-his-box {
    width: 550px;
    max-width: 95vw;
    max-height: 90vh;
    background: white;
    border-radius: 8px;
    box-shadow: 0 10px 50px rgba(0, 0, 0, 0.3);
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

.spare-his-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px;  /* ✅ 15px 25px → 10px 20px */
    background: linear-gradient(135deg, #5c7cfa, #4c6ef5);
    color: white;
    font-size: 18px;  /* ✅ 20px → 18px */
    font-weight: 700;
    cursor: move;
}

/* ========== 반응형 ========== */
@media (max-width: 700px) {
    .spare-box,
    .spare-his-box {
        width: 95vw;
    }
    
    .spare-row {
        grid-template-columns: 1fr;
    }
}
</style>
</head>
<body>
    <div class="tab">
        <div class="button-container">
            <button class="select-button">
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
        <!-- SparePart 리스트 -->
        <div class="table-section">
            <div class="section-header">
                <div class="section-title">📦 SparePart 목록</div>
            </div>
            <div id="tab1" class="tabulator"></div>
        </div>

        <!-- SparePart 관리내역 -->
        <div class="table-section">
            <div class="section-header">
                <div class="section-title">📋 SparePart 관리내역</div>
                <div class="section-buttons">
                    <button class="btn-insert sparePartHisInsert">입력</button>
                    <button class="btn-delete-sub deleteSub">삭제</button>
                </div>
            </div>
            <div id="sub" class="tabulator"></div>
        </div>
    </main>

    <!-- ========== SparePart 메인 모달 ========== -->
    <div class="modal-overlay"></div>
    
    <form autocomplete="off" method="post" id="sparePartForm" name="sparePartForm" enctype="multipart/form-data">
        <div class="spare-modal">
            <div class="spare-box">
                <!-- 헤더 -->
                <div class="spare-header">
                    SparePart 정보
                    <button type="button" class="header-close-btn">&times;</button>
                </div>
                
                <!-- 본문 -->
                <div class="spare-modal-body">
                    <!-- 기본정보 섹션 -->
                    <div class="spare-section">
                        <div class="spare-section-title">기본정보</div>
                        
                        <div class="spare-row">
                            <div class="spare-col-full">
                                <label>매입처</label>
                                <select id="spp_purchase" name="spp_purchase">
                                    <option value="(주)금성풍력 서울지사">(주)금성풍력 서울지사</option>
                                    <option value="(주)대한히타">(주)대한히타</option>
                                    <option value="(주)동광화학">(주)동광화학</option>
                                    <option value="(주)성호기업">(주)성호기업</option>
                                    <option value="(주)세원에너지">(주)세원에너지</option>
                                    <option value="(주)알피네트웍스">(주)알피네트웍스</option>
                                    <option value="(주)제일연마영남영업소">(주)제일연마영남영업소</option>
                                    <option value="(주)한국하우톤온산공상">(주)한국하우톤온산공상</option>
                                    <option value="(주)한국PME">(주)한국PME</option>
                                    <option value="2000ENG">2000ENG</option>
                                    <option value="그랜드종합상">그랜드종합상</option>
                                    <option value="길호철강(주)">길호철강(주)</option>
                                    <option value="대광화학">대광화학</option>
                                    <option value="범우루브켐">범우루브켐</option>
                                    <option value="월드히타엔지니어링">월드히타엔지니어링</option>
                                    <option value="한성엠텍">한성엠텍</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="spare-row">
                            <div class="spare-col">
                                <label>품번</label>
                                <input type="text" id="spp_no" name="spp_no">
                            </div>
                            <div class="spare-col">
                                <label>품명</label>
                                <input type="text" id="spp_name" name="spp_name">
                            </div>
                        </div>
                        
                        <div class="spare-row">
                            <div class="spare-col">
                                <label>규격</label>
                                <input type="text" id="spp_gyu" name="spp_gyu">
                            </div>
                            <div class="spare-col">
                                <label>교체주기</label>
                                <input type="text" id="spp_yong" name="spp_yong">
                            </div>
                        </div>
                        
                        <div class="spare-row">
                            <div class="spare-col">
                                <label>적정재고</label>
                                <input type="text" id="spp_proper" name="spp_proper">
                            </div>
                            <div class="spare-col">
                                <label>비고</label>
                                <input type="text" id="spp_bigo" name="spp_bigo">
                            </div>
                        </div>
                    </div>

                    <!-- 이미지 섹션 -->
                    <div class="spare-section">
                        <div class="spare-section-title">제품 이미지</div>
                        
                        <div class="image-upload-section">
                            <div class="image-preview">
                                <img id="img0" src="/tkheat/css/image/no_image.png" alt="제품 이미지">
                            </div>
                            <div class="file-input-wrapper">
                                <input type="file" id="imgInput0" name="file_url" accept="image/*">
                                <a href="#" class="download-link aphoto" download="">다운로드</a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 푸터 버튼 -->
                <div class="spare-modal-footer">
                    <button type="button" class="btn-delete" onclick="deleteSparePart();" style="display:none;">삭제</button>
                    <button type="button" class="save">저장</button>
                    <button type="button" class="close">닫기</button>
                </div>
            </div>
        </div>
    </form>

    <!-- ========== 관리내역 모달 ========== -->
    <form autocomplete="off" method="post" id="sparePartHisForm" name="sparePartHisForm">
        <div class="spare-his-modal">
            <div class="spare-his-box">
                <!-- 헤더 -->
                <div class="spare-his-header">
                    SparePart 관리내역
                    <button type="button" class="header-close-btn header-close-btn-his">&times;</button>
                </div>
                
                <!-- 본문 -->
                <div class="spare-modal-body">
                    <div class="spare-section">
                        <div class="spare-section-title">기본정보</div>
                        
                        <div class="spare-row">
                            <div class="spare-col-full">
                                <label>매입처</label>
                                <input type="text" id="spp_purchase_his" name="spp_purchase_his" readonly>
                                <input type="hidden" id="spp_idx" name="spp_idx">
                                <input type="hidden" id="sph_idx" name="sph_idx">
                            </div>
                        </div>
                        
                        <div class="spare-row">
                            <div class="spare-col">
                                <label>품번</label>
                                <input type="text" id="spp_no_his" name="spp_no_his" readonly>
                            </div>
                            <div class="spare-col">
                                <label>품명</label>
                                <input type="text" id="spp_name_his" name="spp_name_his" readonly>
                            </div>
                        </div>
                        
                        <div class="spare-row">
                            <div class="spare-col">
                                <label>규격</label>
                                <input type="text" id="spp_gyu_his" name="spp_gyu_his" readonly>
                            </div>
                            <div class="spare-col">
                                <label>교체주기</label>
                                <input type="text" id="spp_yong_his" name="spp_yong_his" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="spare-section">
                        <div class="spare-section-title">재고 관리</div>
                        
                        <div class="spare-row">
                            <div class="spare-col">
                                <label>입고</label>
                                <input type="text" id="sph_input" name="sph_input">
                            </div>
                            <div class="spare-col">
                                <label>수리출고</label>
                                <input type="text" id="sph_suriout" name="sph_suriout">
                            </div>
                        </div>
                        
                        <div class="spare-row">
                            <div class="spare-col">
                                <label>자산출고</label>
                                <input type="text" id="sph_jasanout" name="sph_jasanout">
                            </div>
                            <div class="spare-col">
                                <label>비고</label>
                                <input type="text" id="sph_bigo" name="sph_bigo">
                            </div>
                        </div>
                        
                        <div class="spare-row">
                            <div class="spare-col">
                                <label>입력시간</label>
                                <input type="text" id="sph_time" name="sph_time" readonly>
                            </div>
                            <div class="spare-col">
                                <label>담당자</label>
                                <input type="text" id="sph_user" name="sph_user" readonly>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 푸터 버튼 -->
                <div class="spare-modal-footer">
                    <button type="button" class="save save2">저장</button>
                    <button type="button" class="close close2">닫기</button>
                </div>
            </div>
        </div>
    </form>
<script>
//========== 전역변수 ==========
let now_page_code = "e01";  // ✅ 페이지 코드 (필수)
var spareTable;
var subTable;
var isEditMode = false;
var isSubEditMode = false;
var selectedRowData = null;
var selectedSubRowData = null;

// ========== 페이지 로드 ==========
$(function(){
    // ✅ 권한 체크 실행
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    getSparePartList();
});

// ========== SparePart 목록 조회 ==========
function getSparePartList(){
    console.log("🔄 getSparePartList 시작");
    
    // 기존 테이블 완전히 제거
    if (spareTable) {
        spareTable.destroy();
        spareTable = null;
    }
    
    // DOM 초기화
    $('#tab1').empty();
    
    spareTable = new Tabulator("#tab1", {
        height:"100%",
        layout:"fitColumns",
        selectable:true,
        tooltips:true,
        headerSort:false,
        selectableRangeMode:"click",
        reactiveData:true,
        headerHozAlign:"center",
        ajaxConfig:"POST",
        ajaxLoader:false,
        ajaxURL:"/tkheat/preservation/sparePart/getSparePartList",
        ajaxParams:{},
        placeholder:"조회된 데이터가 없습니다.",
        pagination:"local",
        paginationSize:20,
        paginationSizeSelector:[20,50,100,500,1000],
        paginationCounter:"rows",
        headerFilterPlaceholder: "",
        
        ajaxResponse:function(url, params, response){
            $("#tab1 .tabulator-col.tabulator-sortable").css("height","55px");
            console.log("📊 SparePart 응답:", response);
            
            const data = response.data ? response.data : response;
            console.log("📊 데이터 개수:", data.length);
            
            return data;
        },
        
        columns:[
            {
                title:"제품", 
                field:"file_name", 
                width:100,
                hozAlign:"center", 
                formatter:"image",
                cssClass:"rp-img-popup",
                formatterParams:{
                    height:"18px", 
                    width:"18px",
                    urlPrefix:"/tkPrint/사진/SparePart관리/"
                }, 
                cellMouseEnter:function(e, cell){ 
                    if(cell.getValue()) {
                        productImage(cell.getValue());
                    }
                }
            },
            {title:"NO", field:"idx", width:60, hozAlign:"center"},
            {title:"spp_idx", field:"spp_idx", sorter:"int", width:80, hozAlign:"center", visible:false},
            {title:"spp_idx_his", field:"spp_idx_his", sorter:"int", width:80, hozAlign:"center", visible:false},
            {title:"매입처", field:"spp_purchase", sorter:"string", width:160, hozAlign:"center", headerFilter:"input"},
            {title:"품번", field:"spp_no", sorter:"string", width:140, hozAlign:"center", headerFilter:"input"},
            {title:"품명", field:"spp_name", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"규격", field:"spp_gyu", sorter:"string", width:150, hozAlign:"center", headerFilter:"input"},
            {title:"교체주기", field:"spp_yong", sorter:"string", width:100, hozAlign:"center", headerFilter:"input"},
            {title:"적정재고", field:"spp_proper", sorter:"int", width:90, hozAlign:"center", headerFilter:"input"},
            {title:"비고", field:"spp_bigo", sorter:"string", width:120, hozAlign:"center", headerFilter:"input"},
            {title:"입고", field:"sph_input", sorter:"int", width:80, hozAlign:"center", headerFilter:"input"},
            {title:"수리출고", field:"sph_suriout", sorter:"int", width:90, hozAlign:"center", headerFilter:"input"},
            {title:"자산출고", field:"sph_jasanout", sorter:"int", width:90, hozAlign:"center", headerFilter:"input"},
            { 
                title: "현재고", 
                field: "spp_jaigo", 
                sorter: "int", 
                width: 80,
                hozAlign: "center", 
                headerFilter: "input",
                formatter: function(cell) {
                    const value = cell.getValue();
                    const rowData = cell.getRow().getData();
                    const proper = rowData.spp_proper;
                    const cellElement = cell.getElement();

                    if (value < proper) {
                        cellElement.style.backgroundColor = "#ff6b6b";
                        cellElement.style.color = "white";
                        cellElement.style.fontWeight = "bold";
                    } else {
                        cellElement.style.backgroundColor = "";
                        cellElement.style.color = "";
                        cellElement.style.fontWeight = "normal";
                    }
                    return value;
                }
            }
        ],
        
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "600";
        },
        
        rowClick:function(e, row){
            // ✅ 노란색 배경 적용
            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");

            var rowData = row.getData();
            selectedRowData = rowData;
            
            // 관리내역 폼에 데이터 자동 입력
            $("#spp_purchase_his").val(rowData.spp_purchase || '');
            $("#spp_no_his").val(rowData.spp_no || '');
            $("#spp_idx").val(rowData.spp_idx || '');
            $("#spp_name_his").val(rowData.spp_name || '');
            $("#spp_gyu_his").val(rowData.spp_gyu || '');
            $("#spp_yong_his").val(rowData.spp_yong || '');

            const now = new Date();
            const formatted = now.getFullYear() + '-' +
                String(now.getMonth() + 1).padStart(2, '0') + '-' +
                String(now.getDate()).padStart(2, '0') + ' ' +
                String(now.getHours()).padStart(2, '0') + ':' +
                String(now.getMinutes()).padStart(2, '0') + ':' +
                String(now.getSeconds()).padStart(2, '0');
            $("#sph_time").val(formatted);
            $("#sph_user").val($("#login_user").val() || "관리자");

            // 서브 테이블 조회
            if(rowData.spp_idx){
                getSpareSubList(rowData.spp_idx);
            }
        },
        
        // ✅ 더블클릭 이벤트에 권한 체크 추가 (메인)
        rowDblClick:function(e, row){
            // 수정 권한 체크
            const permission = userPermissions?.[now_page_code];
            
            if (!['U', 'D'].includes(permission)) {
                alert("수정 권한이 없습니다.");
                console.log("⚠️ 더블클릭 차단 (메인) - 현재 권한:", permission);
                return false;
            }
            
            console.log("✅ 더블클릭(수정) 권한 확인 완료 (메인)");
            
            var data = row.getData();
            selectedRowData = data;
            isEditMode = true;
            console.log("더블클릭 데이터:", selectedRowData.spp_idx);
            
            sparePartDetail(data.spp_idx);
            
            // ✅ 버튼 표시 제어
            if (permission === 'D') {
                $('.btn-delete').show();
                console.log("✅ 삭제 버튼 표시 (메인)");
            } else {
                $('.btn-delete').hide();
                console.log("⚠️ 삭제 버튼 숨김 (메인)");
            }
        },
    });
    
    console.log("✅ SparePart Tabulator 생성 완료");
}

// ========== SparePart 상세 조회 ==========
function sparePartDetail(spp_idx){
    $.ajax({
        url:"/tkheat/preservation/sparePart/sparePartDetail",
        type:"post",
        dataType:"json",
        data:{
            "spp_idx":spp_idx
        },
        success:function(result){
            console.log("📄 상세 데이터:", result);
            var allData = result.data;
            
            // ✅ 폼 초기화
            $('#sparePartForm')[0].reset();
            
            // ✅ 데이터 바인딩
            for(let key in allData){
                const value = allData[key];
                const safeValue = (value === null || value === undefined) ? '' : value;
                
                // input 처리
                const $input = $("#" + key);
                if ($input.length && $input.is('input')) {
                    $input.val(safeValue);
                }
            }
            
            // ✅ select 박스 별도 처리 (매입처)
            if (allData.spp_purchase) {
                $("#spp_purchase").val(allData.spp_purchase);
                console.log("✅ 매입처 설정:", allData.spp_purchase);
            }
            
            // ✅ 이미지 초기화
            $("#img0").attr("src", "/tkheat/css/image/no_image.png");
            
            // ✅ 이미지 로드
            if (allData.file_name) {
                console.log("제품 파일명:", allData.file_name);
                const path = "/tkPrint/사진/SparePart관리/" + allData.file_name;
                $("#img0").attr("src", path);
            }
            
            // 모달 열기
            $('.modal-overlay').addClass('active');
            $('.spare-modal').addClass('active');
        },
        error: function(xhr, status, error) {
            console.error("❌ 상세 조회 오류:", error);
            alert("데이터를 불러오는 중 오류가 발생했습니다.");
        }
    });
}

// ========== 저장 (메인) ==========
function save() {
    console.log("💾 save() 함수 시작 (메인)");
    
    // ✅ 권한 체크
    const permission = userPermissions?.[now_page_code];
    
    // 신규 등록인 경우
    if (!isEditMode) {
        if (!['I', 'U', 'D'].includes(permission)) {
            alert("등록 권한이 없습니다.");
            console.log("⚠️ 등록 권한 없음 (메인) - 현재 권한:", permission);
            return false;
        }
        console.log("✅ 등록 권한 확인 완료 (메인)");
    } 
    // 수정인 경우
    else {
        if (!['U', 'D'].includes(permission)) {
            alert("수정 권한이 없습니다.");
            console.log("⚠️ 수정 권한 없음 (메인) - 현재 권한:", permission);
            return false;
        }
        console.log("✅ 수정 권한 확인 완료 (메인)");
    }
    
    var formData = new FormData($("#sparePartForm")[0]);
    let confirmMsg = "";
    
    if (isEditMode && selectedRowData && selectedRowData.spp_idx) {
        formData.append("mode", "update");
        formData.append("spp_idx", selectedRowData.spp_idx);
        confirmMsg = "수정하시겠습니까?";
    } else {
        formData.append("mode", "insert");
        confirmMsg = "저장하시겠습니까?";
    }
    
    // ✅ 필수 입력 검증
    if (!$("#spp_purchase").val() || $("#spp_purchase").val() === '') {
        alert("매입처를 선택해주세요.");
        $("#spp_purchase").focus();
        return;
    }
    
    if (!$("#spp_name").val() || $("#spp_name").val() === '') {
        alert("품명을 입력해주세요.");
        $("#spp_name").focus();
        return;
    }
    
    // ✅ 숫자 필드 빈값 처리
    if (!$("#spp_proper").val() || $("#spp_proper").val() === '') {
        formData.set("spp_proper", "0");
    }
    
    // ✅ 파일이 없을 때 파일 필드 제거
    if (!$('#imgInput0')[0].files.length) {
        formData.delete('file_url');
    }
    
    console.log("=== 전송 데이터 확인 (메인) ===");
    for (let pair of formData.entries()) {
        console.log(pair[0] + ': ' + pair[1]);
    }
    
    if (!confirm(confirmMsg)) return;
    
    $.ajax({
        url: "/tkheat/preservation/sparePart/sparePartSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(result) {
            console.log("💾 저장 완료 (메인):", result);
            alert("저장 되었습니다.");
            
            $('.modal-overlay').removeClass('active');
            $('.spare-modal').removeClass('active');
            
            // 모달 위치 초기화
            $('.spare-modal').css({
                'left': '50%',
                'top': '50%',
                'transform': 'translate(-50%, -50%)'
            });
            
            // 폼 초기화
            $('#sparePartForm')[0].reset();
            isEditMode = false;
            selectedRowData = null;
            
            setTimeout(function() {
                getSparePartList();
            }, 300);
        },
        error: function(xhr, status, error) {
            console.error("❌ 저장 오류 (메인):", xhr.status, error);
            console.error("응답 텍스트:", xhr.responseText);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 삭제 (메인) ==========
function deleteSparePart() {
    console.log("🗑️ deleteSparePart() 함수 시작 (메인)");
    
    // ✅ 권한 체크 (삭제 권한 필요)
    const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("⚠️ 삭제 권한 없음 (메인) - 현재 권한:", permission);
        return false;
    }
    console.log("✅ 삭제 권한 확인 완료 (메인)");
    
    if (!selectedRowData || !selectedRowData.spp_idx) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }
    
    if (!confirm("삭제하시겠습니까?")) {
        return;
    }
    
    $.ajax({
        url: "/tkheat/preservation/sparePart/sparePartDelete",
        type: "POST",
        data: {
            spp_idx: selectedRowData.spp_idx
        },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                $('.modal-overlay').removeClass('active');
                $('.spare-modal').removeClass('active');
                
                // 모달 위치 초기화
                $('.spare-modal').css({
                    'left': '50%',
                    'top': '50%',
                    'transform': 'translate(-50%, -50%)'
                });
                
                setTimeout(function() {
                    getSparePartList();
                }, 300);
            } else {
                alert("삭제 중 오류가 발생했습니다: " + result.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("❌ 삭제 오류 (메인):", error);
            alert("삭제 요청 중 오류가 발생했습니다.");
        }
    });
}

// ========== 관리내역 목록 조회 ==========
function getSpareSubList(spp_idx) {
    console.log("🔄 getSpareSubList 시작");
    
    // 기존 테이블 완전히 제거
    if (subTable) {
        subTable.destroy();
        subTable = null;
    }
    
    // DOM 초기화
    $('#sub').empty();
    
    subTable = new Tabulator("#sub", {
        height: "100%",
        layout: "fitColumns",
        selectable: true,
        tooltips: true,
        headerSort:false,
        selectableRangeMode: "click",
        reactiveData: true,
        headerHozAlign: "center",
        ajaxConfig: "POST",
        ajaxLoader: false,
        ajaxURL: "/tkheat/preservation/sparePart/getSpareSubList",
        ajaxParams: { spp_idx: spp_idx },
        placeholder: "조회된 데이터가 없습니다.",
        pagination: "local",
        paginationSize: 20,
        paginationSizeSelector: [20, 50, 100, 500, 1000],
        paginationCounter: "rows",
        headerFilterPlaceholder: "",
        
        ajaxResponse: function(url, params, response) {
            $("#sub .tabulator-col.tabulator-sortable").css("height", "55px");
            console.log("📊 관리내역 응답:", response);
            
            const data = response.data ? response.data : response;
            console.log("📊 데이터 개수:", data.length);
            
            return data;
        },
        
        columns: [
            { title: "NO", field: "idx", sorter: "int", width: 60, hozAlign: "center" },
            { title: "매입처", field: "spp_purchase_his", sorter: "string", width: 170, hozAlign: "center" },
            { title: "품번", field: "spp_no_his", sorter: "string", width: 140, hozAlign: "center" },
            { title: "품명", field: "spp_name_his", sorter: "string", width: 140, hozAlign: "center" },
            { title: "규격", field: "spp_gyu_his", sorter: "string", width: 140, hozAlign: "center" },
            { title: "교체주기", field: "spp_yong_his", sorter: "string", width: 100, hozAlign: "center" },
            { title: "입고", field: "sph_input", sorter: "int", width: 80, hozAlign: "center" },
            { title: "수리출고", field: "sph_suriout", sorter: "string", width: 90, hozAlign: "center" },
            { title: "자산출고", field: "sph_jasanout", sorter: "int", width: 90, hozAlign: "center" },
            { title: "비고", field: "sph_bigo", sorter: "string", width: 100, hozAlign: "center" },
            { title: "입력시간", field: "sph_time", sorter: "string", width: 150, hozAlign: "center" },
            { title: "담당자", field: "sph_user", sorter: "string", width: 80, hozAlign: "center" },
            { field: "spp_idx_his", visible: false },
            { field: "spp_idx", visible: false },
            { field: "sph_idx", visible: false }
        ],
        
        rowFormatter: function(row) {
            row.getElement().style.fontWeight = "600";
        },

        rowClick: function(e, row) {
            $("#sub .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass("row_select");
            row.getElement().classList.add("row_select");
            selectedSubRowData = row.getData();
        },
        
        // ✅ 더블클릭 이벤트에 권한 체크 추가 (서브)
        rowDblClick: function(e, row) {
            // 수정 권한 체크
            const permission = userPermissions?.[now_page_code];
            
            if (!['U', 'D'].includes(permission)) {
                alert("수정 권한이 없습니다.");
                console.log("⚠️ 더블클릭 차단 (서브) - 현재 권한:", permission);
                return false;
            }
            
            console.log("✅ 더블클릭(수정) 권한 확인 완료 (서브)");
            
            const rowData = row.getData();
            
            console.log("=== 관리내역 더블클릭 ===");
            console.log("전체 rowData:", rowData);
            console.log("sph_idx 값:", rowData.sph_idx);

            if (!rowData.sph_idx || rowData.sph_idx === '' || rowData.sph_idx === null || rowData.sph_idx === undefined) {
                alert("이 데이터는 수정할 수 없습니다.");
                console.error("❌ sph_idx가 없습니다!");
                return;
            }

            // ✅ 수정 모드 설정
            isSubEditMode = true;
            selectedSubRowData = rowData;
            
            console.log("✅ 수정 모드 진입 (서브)");
            
            // ✅ 폼에 데이터 바인딩
            $("#sph_idx").val(rowData.sph_idx);
            $("#spp_idx").val(rowData.spp_idx);
            $("#spp_purchase_his").val(rowData.spp_purchase_his || '');
            $("#spp_no_his").val(rowData.spp_no_his || '');
            $("#spp_name_his").val(rowData.spp_name_his || '');
            $("#spp_gyu_his").val(rowData.spp_gyu_his || '');
            $("#spp_yong_his").val(rowData.spp_yong_his || '');
            $("#sph_input").val(rowData.sph_input || '0');
            $("#sph_suriout").val(rowData.sph_suriout || '0');
            $("#sph_jasanout").val(rowData.sph_jasanout || '0');
            $("#sph_bigo").val(rowData.sph_bigo || '');
            $("#sph_time").val(rowData.sph_time || '');
            $("#sph_user").val(rowData.sph_user || '');
            
            console.log("✅ 폼 데이터 설정 완료 (서브)");
            
            // ✅ 모달 열기
            $('.spare-his-modal').addClass('active');
        }
    });
    
    console.log("✅ 관리내역 Tabulator 생성 완료");
}

//========== 관리내역 저장 (서브) ==========
function saveSpareSub() {
    console.log("💾 saveSpareSub() 함수 시작 (서브)");
    
    // ✅ 권한 체크
    const permission = userPermissions?.[now_page_code];
    
    const sphIdx = $("#sph_idx").val();
    console.log("isSubEditMode:", isSubEditMode);
    console.log("sph_idx:", sphIdx);
    
    // 신규 등록인 경우
    if (!isSubEditMode) {
        if (!['I', 'U', 'D'].includes(permission)) {
            alert("등록 권한이 없습니다.");
            console.log("⚠️ 등록 권한 없음 (서브) - 현재 권한:", permission);
            return false;
        }
        console.log("✅ 등록 권한 확인 완료 (서브)");
    } 
    // 수정인 경우
    else {
        if (!['U', 'D'].includes(permission)) {
            alert("수정 권한이 없습니다.");
            console.log("⚠️ 수정 권한 없음 (서브) - 현재 권한:", permission);
            return false;
        }
        console.log("✅ 수정 권한 확인 완료 (서브)");
    }
    
    var formData = new FormData($("#sparePartHisForm")[0]);
    
    // ✅ 필수 입력 검증
    const input = parseInt($("#sph_input").val()) || 0;
    const suriout = parseInt($("#sph_suriout").val()) || 0;
    const jasanout = parseInt($("#sph_jasanout").val()) || 0;
    
    if (input === 0 && suriout === 0 && jasanout === 0) {
        alert("입고, 수리출고, 자산출고 중 하나는 입력해주세요.");
        return;
    }

    let confirmMsg = (isSubEditMode && sphIdx) ? "수정하시겠습니까?" : "저장하시겠습니까?";
    if (!confirm(confirmMsg)) return;

    console.log("=== 전송 데이터 확인 (서브) ===");
    for (let pair of formData.entries()) {
        console.log(pair[0] + ': ' + pair[1]);
    }

    $.ajax({
        url: "/tkheat/preservation/sparePart/spareSubSave",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        dataType: "json",
        success: function(res) {
            console.log("💾 관리내역 저장 완료 (서브):", res);
            alert("저장되었습니다.");
            
            // ✅ 모달 닫기
            $('.spare-his-modal').removeClass('active');

            const topIdx = $("#spp_idx").val();

            // ✅ 테이블 리로드
            getSparePartList();
            
            setTimeout(function() {
                if (topIdx && spareTable) {
                    const rows = spareTable.getRows();
                    rows.forEach(function(row) {
                        const rowData = row.getData();
                        if (rowData.spp_idx == topIdx) {
                            $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
                            row.getElement().classList.add("row_select");
                            getSpareSubList(topIdx);
                        }
                    });
                }
            }, 500);

            isSubEditMode = false;
            selectedSubRowData = null;
        },
        error: function(xhr, status, error) {
            console.error("❌ 저장 오류 (서브):", xhr.status, error);
            console.error("응답 텍스트:", xhr.responseText);
            alert("저장 중 오류가 발생했습니다.");
        }
    });
}

// ========== 관리내역 삭제 (서브) ==========
$(".deleteSub").click(function() {
    console.log("🗑️ deleteSub 클릭 (서브)");
    
    // ✅ 권한 체크 (삭제 권한 필요)
    const permission = userPermissions?.[now_page_code];
    
    if (permission !== 'D') {
        alert("삭제 권한이 없습니다.");
        console.log("⚠️ 삭제 권한 없음 (서브) - 현재 권한:", permission);
        return false;
    }
    console.log("✅ 삭제 권한 확인 완료 (서브)");
    
    if (!selectedSubRowData || !selectedSubRowData.sph_idx) {
        alert("삭제할 대상을 선택하세요.");
        return;
    }

    if (!confirm("삭제하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: "/tkheat/preservation/sparePart/spareSubDelete",
        type: "POST",
        data: {
            sph_idx: selectedSubRowData.sph_idx
        },
        dataType: "json",
        success: function(result) {
            if (result.status === "success") {
                alert("삭제되었습니다.");
                
                const topIdx = $("#spp_idx").val();
                setTimeout(function() {
                    if (topIdx) {
                        getSpareSubList(topIdx);
                        getSparePartList();
                    }
                }, 300);
                
                selectedSubRowData = null;
            } else {
                alert("삭제 중 오류가 발생했습니다: " + result.message);
            }
        },
        error: function(xhr, status, error) {
            console.error("❌ 삭제 오류 (서브):", error);
            alert("삭제 요청 중 오류가 발생했습니다.");
        }
    });
});

// ========== 드래그 기능 (메인 모달) ==========
const modal = document.querySelector('.spare-modal');
const header = document.querySelector('.spare-header');

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

// ========== 드래그 기능 (관리내역 모달) ==========
const modal2 = document.querySelector('.spare-his-modal');
const header2 = document.querySelector('.spare-his-header');

header2.addEventListener('mousedown', function(e) {
    if (e.target.classList.contains('header-close-btn-his') || e.target.closest('.header-close-btn-his')) {
        return;
    }
    
    const rect2 = modal2.getBoundingClientRect();
    modal2.style.left = rect2.left + 'px';
    modal2.style.top = rect2.top + 'px';
    modal2.style.transform = 'none';
    
    let offsetX2 = e.clientX - rect2.left;
    let offsetY2 = e.clientY - rect2.top;
    
    function moveModal2(e) {
        modal2.style.left = (e.clientX - offsetX2) + 'px';
        modal2.style.top = (e.clientY - offsetY2) + 'px';
    }
    
    function stopMove2() {
        window.removeEventListener('mousemove', moveModal2);
        window.removeEventListener('mouseup', stopMove2);
    }
    
    window.addEventListener('mousemove', moveModal2);
    window.addEventListener('mouseup', stopMove2);
});

// ========== 모달 열기/닫기 (메인) ==========
const insertButtonMain = document.querySelector('.insert-button');
const spareModal = document.querySelector('.spare-modal');
const modalOverlay = document.querySelector('.modal-overlay');
const closeButton = document.querySelector('.spare-modal .close');
const headerCloseBtn = document.querySelector('.spare-header .header-close-btn');

insertButtonMain.addEventListener('click', function() {
    isEditMode = false;
    selectedRowData = null;
    
    // ✅ 폼 완전 초기화
    $('#sparePartForm')[0].reset();
    
    // ✅ 이미지 초기화
    $('#img0').attr('src', '/tkheat/css/image/no_image.png');
    
    // 중앙 정렬
    spareModal.style.left = '50%';
    spareModal.style.top = '50%';
    spareModal.style.transform = 'translate(-50%, -50%)';
    
    modalOverlay.classList.add('active');
    spareModal.classList.add('active');
    
    $('.btn-delete').hide();
});

closeButton.addEventListener('click', function() {
    modalOverlay.classList.remove('active');
    spareModal.classList.remove('active');
});

headerCloseBtn.addEventListener('click', function() {
    modalOverlay.classList.remove('active');
    spareModal.classList.remove('active');
});

// ========== 모달 열기/닫기 (관리내역) ==========
const insertButton2 = document.querySelector('.sparePartHisInsert');
const spareHisModal = document.querySelector('.spare-his-modal');
const closeButton2 = document.querySelector('.spare-his-modal .close2');
const headerCloseBtn2 = document.querySelector('.spare-his-header .header-close-btn-his');

insertButton2.addEventListener('click', function() {
    const sppIdx = $("#spp_idx").val();
    console.log("입력 버튼 클릭, spp_idx:", sppIdx);
    
    if (!sppIdx) {
        alert("먼저 SparePart 항목을 선택해주세요.");
        return;
    }
    
    isSubEditMode = false;
    selectedSubRowData = null;
    
    $("#sph_input").val('0');
    $("#sph_suriout").val('0');
    $("#sph_jasanout").val('0');
    
    $("#sph_bigo").val('');
    $("#sph_idx").val('');

    const now = new Date();
    const formatted = now.getFullYear() + '-' +
        String(now.getMonth() + 1).padStart(2, '0') + '-' +
        String(now.getDate()).padStart(2, '0') + ' ' +
        String(now.getHours()).padStart(2, '0') + ':' +
        String(now.getMinutes()).padStart(2, '0') + ':' +
        String(now.getSeconds()).padStart(2, '0');
    $("#sph_time").val(formatted);
    $("#sph_user").val($("#login_user").val() || "관리자");
    
    spareHisModal.classList.add('active');
});

closeButton2.addEventListener('click', function() {
    spareHisModal.classList.remove('active');
});

headerCloseBtn2.addEventListener('click', function() {
    spareHisModal.classList.remove('active');
});

// ========== 저장 버튼 ==========
$('.spare-modal .save').click(function() {
    save();
});

$('.spare-his-modal .save2').click(function() {
    saveSpareSub();
});

// ========== 엑셀 다운로드 ==========
$(".excel-button").click(function () {
    const data1 = spareTable ? spareTable.getData() : [];
    const data2 = subTable ? subTable.getData() : [];

    const columns1 = spareTable ? spareTable.getColumnDefinitions() : [];
    const columns2 = subTable ? subTable.getColumnDefinitions() : [];

    const ws = XLSX.utils.aoa_to_sheet([]);
    let rowIndex = 0;

    // SparePart 목록
    if (data1.length > 0) {
        const headers1 = columns1.filter(c => c.visible !== false).map(col => col.title);
        const fields1 = columns1.filter(c => c.visible !== false).map(col => col.field);

        XLSX.utils.sheet_add_aoa(ws, [["[SparePart 목록]"]], { origin: rowIndex++ });
        XLSX.utils.sheet_add_aoa(ws, [headers1], { origin: rowIndex++ });

        const rows1 = data1.map(row =>
            fields1.map(f => row[f] || '')
        );
        XLSX.utils.sheet_add_aoa(ws, rows1, { origin: rowIndex });
        rowIndex += rows1.length;
    }

    rowIndex += 2;

    // 관리내역
    if (data2.length > 0) {
        const headers2 = columns2.filter(c => c.visible !== false).map(col => col.title);
        const fields2 = columns2.filter(c => c.visible !== false).map(col => col.field);

        XLSX.utils.sheet_add_aoa(ws, [["[SparePart 관리내역]"]], { origin: rowIndex++ });
        XLSX.utils.sheet_add_aoa(ws, [headers2], { origin: rowIndex++ });

        const rows2 = data2.map(row =>
            fields2.map(f => row[f] || '')
        );
        XLSX.utils.sheet_add_aoa(ws, rows2, { origin: rowIndex });
    }

    const maxCols = Math.max(
        columns1.length,
        columns2.length
    );
    ws['!cols'] = Array.from({ length: maxCols }, () => ({ wch: 20 }));

    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "SparePart관리");

    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "SparePart관리_" + today + ".xlsx";
    XLSX.writeFile(wb, filename);
});
</script>
	</body>
</html>
