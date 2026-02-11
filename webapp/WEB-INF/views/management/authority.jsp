<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사원별 권한 설정</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <%@include file="../include/pluginpage.jsp" %>     
    
<style>
/* ========== 전체 레이아웃 ========== */
body {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 0;
    background: #f5f7fa;
}

.main {
    width: 98%;
    margin: 0 auto;
    padding: 10px 0;  /* ✅ 추가 */
}

/* ========== 상단 영역 ========== */
.top-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 15px;  /* ✅ 20px → 8px */
    background: white;
    border-radius: 6px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    margin-bottom: 8px;  /* ✅ 20px → 8px */
}

.user-info {
    display: flex;
    align-items: center;
    gap: 10px;  /* ✅ 15px → 10px */
}

.user-info-label {
    font-size: 14px;  /* ✅ 16px → 14px */
    font-weight: 700;
    color: #2c3e50;
}

.user-name {
    font-size: 15px;  /* ✅ 18px → 15px */
    font-weight: 700;
    color: #3498db;
    padding: 4px 12px;  /* ✅ 8px 16px → 4px 12px */
    background: #e3f2fd;
    border-radius: 4px;
}

.top-buttons {
    display: flex;
    gap: 6px;  /* ✅ 10px → 6px */
}

.top-buttons button {
    min-width: 85px;  /* ✅ 100px → 85px */
    height: 32px;  /* ✅ 38px → 32px */
    border: none;
    border-radius: 4px;
    font-size: 13px;  /* ✅ 14px → 13px */
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s;
}

.btn-all-none {
    background: linear-gradient(135deg, #868e96, #495057);
    color: white;
}

.btn-all-none:hover {
    background: linear-gradient(135deg, #6c757d, #343a40);
    transform: translateY(-2px);
}

.btn-all-grant {
    background: linear-gradient(135deg, #f39c12, #e67e22);
    color: white;
}

.btn-all-grant:hover {
    background: linear-gradient(135deg, #e67e22, #d35400);
    transform: translateY(-2px);
}

.btn-save {
    background: linear-gradient(135deg, #51cf66, #37b24d);
    color: white;
}

.btn-save:hover {
    background: linear-gradient(135deg, #40c057, #2f9e44);
    transform: translateY(-2px);
}

.btn-reset {
    background: linear-gradient(135deg, #ff6b6b, #fa5252);
    color: white;
}

.btn-reset:hover {
    background: linear-gradient(135deg, #f03e3e, #e03131);
    transform: translateY(-2px);
}

/* ========== 컨텐츠 영역 (좌우 레이아웃) ========== */
.content-wrapper {
    display: grid;
    grid-template-columns: 500px 1fr;
    gap: 10px;  /* ✅ 20px → 10px */
}

/* ========== 왼쪽: 사용자 목록 ========== */
.user-list-section {
    background: white;
    border-radius: 6px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    padding: 12px;  /* ✅ 20px → 12px */
}

.section-title {
    font-size: 15px;  /* ✅ 18px → 15px */
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 8px;  /* ✅ 15px → 8px */
    padding-bottom: 6px;  /* ✅ 10px → 6px */
    border-bottom: 2px solid #e9ecef;
}

.row_select {
    background-color: #9ABCEA !important;
}

/* ========== 오른쪽: 권한 설정 ========== */
.permission-section {
    background: white;
    border-radius: 6px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    padding: 12px;  /* ✅ 20px → 12px */
}

.permission-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 8px;  /* ✅ 16px → 8px */
    max-height: calc(100vh - 200px);  /* ✅ 동적 높이 설정 */
    overflow-y: auto;
}

.permission-container::-webkit-scrollbar {
    width: 6px;  /* ✅ 8px → 6px */
}

.permission-container::-webkit-scrollbar-track {
    background: #e0e0e0;
}

.permission-container::-webkit-scrollbar-thumb {
    background: #999;
    border-radius: 3px;
}

.category-section {
    background: #f9f9f9;
    padding: 10px;  /* ✅ 15px → 10px */
    border-radius: 6px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.08);
}

.category-section h3 {
    margin: 0 0 8px;  /* ✅ 12px → 8px */
    font-size: 14px;  /* ✅ 16px → 14px */
    color: #2c3e50;
    font-weight: 700;
    padding-bottom: 5px;  /* ✅ 8px → 5px */
    border-bottom: 2px solid #3498db;
}

.permission-control {
    display: flex;
    align-items: center;
    margin-bottom: 6px;  /* ✅ 10px → 6px */
}

.permission-control label {
    width: 130px;  /* ✅ 140px → 130px */
    font-size: 12px;  /* ✅ 13px → 12px */
    font-weight: 600;
    color: #555;
}

.permission-control select {
    flex: 1;
    padding: 4px 6px;  /* ✅ 6px 10px → 4px 6px */
    border: 1px solid #ced4da;
    border-radius: 3px;
    font-size: 12px;  /* ✅ 13px → 12px */
    cursor: pointer;
    transition: all 0.3s;
}

.permission-control select:focus {
    outline: none;
    border-color: #4dabf7;
    box-shadow: 0 0 0 2px rgba(77, 171, 247, 0.1);
}

/* ========== 반응형 ========== */
@media (max-width: 1600px) {
    .permission-container {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 1200px) {
    .content-wrapper {
        grid-template-columns: 1fr;
    }
    
    .permission-container {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .permission-container {
        grid-template-columns: 1fr;
    }
}
</style>
</head>

<body>

<!-- <div class="tab">
    <div class="button-container">
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
            엑셀    
        </button>
    </div>
</div> -->

<main class="main">
    <!-- 상단 영역: 사용자 정보 + 버튼들 -->
    <div class="top-section">
        <div class="user-info">
            <span class="user-info-label">선택된 사용자:</span>
            <span class="user-name">사용자를 선택하세요</span>
        </div>
        <div class="top-buttons">
            <button type="button" class="btn-all-none">전체 없음</button>
            <button type="button" class="btn-all-grant">최고 권한</button>
            <button type="button" class="btn-save">저장</button>
            <button type="button" class="btn-reset">초기화</button>
        </div>
    </div>

    <!-- 컨텐츠 영역: 좌우 분할 -->
    <div class="content-wrapper">
        <!-- 왼쪽: 사용자 목록 -->
        <div class="user-list-section">
            <h2 class="section-title">사용자 목록</h2>
            <div id="userTable" class="tabulator"></div>
        </div>

        <!-- 오른쪽: 권한 설정 -->
        <div class="permission-section">
            <h2 class="section-title">권한 설정</h2>
            
            <form id="permissionForm" class="permission-container">
                <input type="hidden" id="user_code" name="user_code" />

                <!-- 제품관리 -->
                <div class="category-section">
                    <h3>제품관리</h3>
                    <div class="permission-control">
                        <label>입고관리</label>
                        <select id="a01" name="a01">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>출고관리</label>
                        <select id="a02" name="a02">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>제품별재고현황</label>
                        <select id="a03" name="a03">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>출고대기현황</label>
                        <select id="a04" name="a04">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>공정작업현황</label>
                        <select id="a05" name="a05">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>재고현황(상세)</label>
                        <select id="a06" name="a06">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>입출고삭제현황</label>
                        <select id="a07" name="a07">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                </div>

                <!-- 생산관리 -->
                <div class="category-section">
                    <h3>생산관리</h3>
                    <div class="permission-control">
                        <label>작업지시</label>
                        <select id="b01" name="b01">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>작업현황</label>
                        <select id="b02" name="b02">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>생산대기현황</label>
                        <select id="b03" name="b03">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>LOT추적(입고)</label>
                        <select id="b04" name="b04">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>LOT추적(열처리)</label>
                        <select id="b05" name="b05">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>작업지시NEW</label>
                        <select id="b06" name="b06">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>LOT보고서</label>
                        <select id="b07" name="b07">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                </div>

                <!-- 생산공정관리 -->
                <div class="category-section">
                    <h3>생산공정관리</h3>
                    <div class="permission-control">
                        <label>전세정작업실적</label>
                        <select id="c01" name="c01">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>침탄작업실적</label>
                        <select id="c02" name="c02">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>템퍼링작업실적</label>
                        <select id="c03" name="c03">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>후세정작업실적</label>
                        <select id="c04" name="c04">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>쇼트/샌딩작업실적</label>
                        <select id="c05" name="c05">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>설비별작업실적</label>
                        <select id="c06" name="c06">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>준비작업실적</label>
                        <select id="c07" name="c07">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                </div>

                <!-- 모니터링 -->
                <div class="category-section">
                    <h3>모니터링</h3>
                    <div class="permission-control">
                        <label>설비모니터링</label>
                        <select id="d01" name="d01">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>알람-1</label>
                        <select id="d02" name="d02">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>알람-2</label>
                        <select id="d03" name="d03">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>트렌드</label>
                        <select id="d04" name="d04">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>알람내역</label>
                        <select id="d05" name="d05">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>알람랭킹</label>
                        <select id="d06" name="d06">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                </div>

                <!-- 설비보존관리 -->
                <div class="category-section">
                    <h3>설비보존관리</h3>
                    <div class="permission-control">
                        <label>SparePart관리</label>
                        <select id="e01" name="e01">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>설비비가동등록</label>
                        <select id="e02" name="e02">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>설비비가동율분석</label>
                        <select id="e03" name="e03">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>설비수리이력관리</label>
                        <select id="e04" name="e04">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>설비점검기준등록</label>
                        <select id="e05" name="e05">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>설비별점검(일별)</label>
                        <select id="e06" name="e06">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>설비별점검(월별)</label>
                        <select id="e07" name="e07">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>측정기기고장이력</label>
                        <select id="e08" name="e08">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                </div>

                <!-- 품질관리 -->
                <div class="category-section">
                    <h3>품질관리</h3>
                    <div class="permission-control">
                        <label>수입검사</label>
                        <select id="f01" name="f01">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>부적합등록</label>
                        <select id="f02" name="f02">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>Xbar-R관리도</label>
                        <select id="f03" name="f03">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>자주검사불량현황</label>
                        <select id="f04" name="f04">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>소입경도현황</label>
                        <select id="f05" name="f05">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>템퍼링경도현황</label>
                        <select id="f06" name="f06">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                </div>

                <!-- 경영정보 -->
                <div class="category-section">
                    <h3>경영정보</h3>
                    <div class="permission-control">
                        <label>제품별입출고현황</label>
                        <select id="g01" name="g01">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>제품별출고현황</label>
                        <select id="g02" name="g02">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>제품별작업실적</label>
                        <select id="g03" name="g03">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>거래처별입출고현황</label>
                        <select id="g04" name="g04">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>거래처별출고현황</label>
                        <select id="g05" name="g05">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>월매출현황(마감)</label>
                        <select id="g06" name="g06">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>월별불량현황</label>
                        <select id="g07" name="g07">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>년간매출현황</label>
                        <select id="g08" name="g08">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>공지사항</label>
                        <select id="g09" name="g09">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>월별거래처별불량현황</label>
                        <select id="g10" name="g10">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                </div>

                <!-- 기준정보 -->
                <div class="category-section">
                    <h3>기준정보</h3>
                    <div class="permission-control">
                        <label>제품등록</label>
                        <select id="h01" name="h01">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>거래처등록</label>
                        <select id="h02" name="h02">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>설비등록</label>
                        <select id="h03" name="h03">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>침탄로작업표준</label>
                        <select id="h04" name="h04">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>작업자등록</label>
                        <select id="h05" name="h05">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>사원별권한등록</label>
                        <select id="h06" name="h06">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>측정기기관리</label>
                        <select id="h07" name="h07">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                </div>

                <!-- 작업지시 -->
                <div class="category-section">
                    <h3>작업지시</h3>
                    <div class="permission-control">
                        <label>적재</label>
                        <select id="i01" name="i01">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>전세척</label>
                        <select id="i02" name="i02">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>열처리</label>
                        <select id="i03" name="i03">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>후세정</label>
                        <select id="i04" name="i04">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>쇼트</label>
                        <select id="i05" name="i05">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>템퍼링</label>
                        <select id="i06" name="i06">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>최종검사</label>
                        <select id="i07" name="i07">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>방청</label>
                        <select id="i08" name="i08">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                    <div class="permission-control">
                        <label>포장</label>
                        <select id="i09" name="i09">
                            <option value="N">없음</option>
                            <option value="R">조회</option>
                            <option value="I">저장</option>
                            <option value="U">수정</option>
                            <option value="D">삭제</option>
                        </select>
                    </div>
                </div>

            </form>
        </div>
    </div>
</main>

<script>
// 전역변수
let now_page_code = "h06";
var userTable;
var selectedUserCode = null;

// 로드
$(function(){
    getAllUserList();
});

// 전체 사용자 목록 조회
function getAllUserList(){
    userTable = new Tabulator("#userTable", {
        height:"650px",
        layout:"fitColumns",
        selectable:true,
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
            "user_buso": "",
            "user_jick": "",
            "user_name": ""
        },
        placeholder:"조회된 데이터가 없습니다.",
        paginationSize:20,
        ajaxResponse:function(url, params, response){
            $("#userTable .tabulator-col.tabulator-sortable").css("height","55px");
            return response;
        },
        columns:[
            {title:"NO", field:"idx", sorter:"int", width:60, hozAlign:"center"},
            {title:"사원번호", field:"user_no", sorter:"string", width:100, hozAlign:"center"},
            {title:"부서", field:"user_buso", sorter:"string", width:100, hozAlign:"center"},
            {title:"직책", field:"user_jick", sorter:"string", width:80, hozAlign:"center"},
            {title:"성명", field:"user_name", sorter:"string", width:100, hozAlign:"center"},
        ],
        rowFormatter:function(row){
            var data = row.getData();
            row.getElement().style.fontWeight = "700";
            row.getElement().style.backgroundColor = "#FFFFFF";
        },
        rowClick:function(e, row){
            $("#userTable .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
            row.getElement().classList.add("row_select");

            var rowData = row.getData();
            selectedUserCode = rowData.user_code;
            $("#user_code").val(rowData.user_code);
            $(".user-name").text(rowData.user_name);

            // 권한 정보 조회
            getPermissionData();
        },
    });
}

// ✅ 안전한 값 정리 함수
function cleanValue(value) {
    // null, undefined, 빈 문자열 체크
    if (value === null || value === undefined || value === '') {
        return 'N';
    }
    
    // 문자열이 아니면 문자열로 변환
    const strValue = String(value);
    
    // 공백 제거 후 빈 문자열이면 'N' 반환
    const trimmed = strValue.trim();
    return (trimmed === '' || trimmed === 'null') ? 'N' : trimmed;
}

// 권한 정보 조회
function getPermissionData(){
    $.ajax({
        url:"/tkheat/management/authority/userSelect",
        type:"post",
        dataType:"json",
        data:{"user_code": selectedUserCode},
        success:function(result){
            console.log("✅ 권한 조회 결과:", result);
            
            var data = result.data;
            
            // 모든 select 박스 초기화
            $('#permissionForm select').val('N');
            
            // 데이터가 있으면 값 설정
            if(data) {
                // ✅ 안전하게 값 설정
                for(let key in data){
                    const lowerKey = key.toLowerCase();
                    const cleanedValue = cleanValue(data[key]);
                    
                    const $select = $("#" + lowerKey);
                    if($select.length > 0) {
                        $select.val(cleanedValue);
                        console.log(`${lowerKey} = ${cleanedValue}`);
                    }
                }
            } else {
                console.warn("⚠️ 권한 데이터가 없습니다.");
            }
        },
        error:function(xhr, status, error){
            console.error("❌ 권한 조회 실패:", error);
            console.error("응답:", xhr.responseText);
            alert("권한 정보 조회에 실패했습니다.");
        }
    });
}

// 전체 없음
$('.btn-all-none').click(function() {
    if(!selectedUserCode) {
        alert("사용자를 선택하세요.");
        return;
    }
    $('#permissionForm select').val('N');
});

// 최고 권한
$('.btn-all-grant').click(function() {
    if(!selectedUserCode) {
        alert("사용자를 선택하세요.");
        return;
    }
    
    $('#permissionForm select').each(function() {
        const $select = $(this);
        const options = $select.find('option').map(function() {
            return $(this).val();
        }).get();
        
        let highestPermission = 'N';
        
        if(options.includes('D')) {
            highestPermission = 'D';
        } else if(options.includes('U')) {
            highestPermission = 'U';
        } else if(options.includes('I')) {
            highestPermission = 'I';
        } else if(options.includes('R')) {
            highestPermission = 'R';
        }
        
        $select.val(highestPermission);
    });
});

// ✅ 저장 (모든 필드 수동 수집)
$('.btn-save').click(function() {
    if(!selectedUserCode) {
        alert("사용자를 선택하세요.");
        return;
    }
    
    if(!confirm("권한을 저장하시겠습니까?")) {
        return;
    }
    
    // ✅ 모든 select 값 수집
    var permissionData = {
        user_code: selectedUserCode
    };
    
    // 모든 select 요소 순회하며 데이터 수집
    $('#permissionForm select').each(function() {
        const fieldName = $(this).attr('name');
        const fieldValue = $(this).val() || 'N';
        permissionData[fieldName] = fieldValue;
    });
    
    console.log("📤 저장할 권한 데이터:", permissionData);
    
    $.ajax({
        url:"/tkheat/management/authority/userSelectSave",
        type:"post",
        data: permissionData,
        dataType: "json",
        success:function(result){
            console.log("✅ 저장 성공:", result);
            if(result.status === "success") {
                alert(result.message || "권한이 저장되었습니다.");
                getPermissionData();
            } else {
                alert("권한 저장에 실패했습니다: " + result.message);
            }
        },
        error:function(xhr, status, error){
            console.error("❌ 저장 오류:", error);
            console.error("응답:", xhr.responseText);
            alert("권한 저장에 실패했습니다.");
        }
    });
});

// 초기화
$('.btn-reset').click(function() {
    if(!selectedUserCode) {
        alert("사용자를 선택하세요.");
        return;
    }
    
    if(!confirm("현재 사용자의 권한을 다시 불러오시겠습니까?")) {
        return;
    }
    
    getPermissionData();
});

// 엑셀 다운로드
$(".excel-button").click(function () {
    const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");
    const filename = "사원별권한_" + today + ".xlsx";
    userTable.download("xlsx", filename, { sheetName: "사원별권한" });
});
</script>

</body>
</html>