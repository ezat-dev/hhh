<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>부품재고관리</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>
   <style>
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.main { flex: 1; min-height: 0; display: flex; flex-direction: column; overflow: hidden; padding: 8px; width: 98%; }

/* ========== 서브탭 ========== */
.sp2-tabs { display:flex; gap:6px; margin-bottom:10px; flex-shrink:0; }
.sp2-tab  {
    padding:7px 20px; border-radius:8px; border:1px solid #E2E8F0;
    background:#F0F4F8; font-size:13px; font-weight:700;
    cursor:pointer; transition:all .13s; color:#4A5568;
}
.sp2-tab.active { background:#3182CE; color:#fff; border-color:#2B6CB0; }

.sp2-view { flex:1; min-height:0; display:none; flex-direction:column; overflow:hidden; }
.sp2-view.active { display:flex; }

/* ========== KPI 카드 ========== */
.kpi-row { display:grid; grid-template-columns:repeat(4,1fr); gap:10px; margin-bottom:10px; flex-shrink:0; }
.kpi-card { background:white; border:1px solid #E2E8F0; border-radius:10px; padding:12px 16px; box-shadow:0 1px 4px rgba(0,0,0,.06); text-align:center; }
.kpi-lbl { font-size:11px; color:#718096; margin-bottom:4px; }
.kpi-val { font-size:22px; font-weight:800; }

/* ========== 재고부족 알림 배너 ========== */
.low-alert {
    background:#FFF5F5; color:#C53030; border:1px solid #FEB2B2; border-radius:10px;
    padding:10px 14px; margin-bottom:10px; font-weight:700; font-size:13px; flex-shrink:0;
}
.low-alert small { display:block; font-weight:400; margin-top:3px; color:#9B2C2C; }

/* ========== 필터 바 ========== */
.sp2-filter-bar { display:flex; gap:8px; flex-wrap:wrap; align-items:center; margin-bottom:10px; flex-shrink:0; }
.sp2-filter-bar select,
.sp2-filter-bar input[type="text"],
.sp2-filter-bar input[type="date"] {
    height: 32px; border:1px solid #ced4da; border-radius:6px; padding:0 8px; font-size:12px;
}
.sp2-filter-bar .fbtn {
    height: 32px; padding: 0 14px; border: 1px solid #E2E8F0; border-radius: 6px;
    background: #F0F4F8; font-size: 12px; font-weight: 700; cursor: pointer; transition: background-color .13s;
}
.sp2-filter-bar .fbtn:hover { background:#EBF8FF; }
.sp2-filter-bar .fbtn.pri { background:#3182CE; color:#fff; border-color:#2B6CB0; }
.sp2-filter-bar .fbtn.pri:hover { background:#2B6CB0; }
.sp2-filter-bar .fbtn:disabled { opacity:.45; cursor:not-allowed; }
.sp2-filter-bar .spacer { flex:1; }

/* ========== Tabulator ========== */
.tbl { flex:1; min-height:0; border:none; font-size:12px; }
.tbl .tabulator-header { background:#EDF2F7 !important; border-bottom:2px solid #CBD5E0; }
.tbl .tabulator-col { background:transparent; border-right:1px solid #CBD5E0; }
.tbl .tabulator-col-title { color:#1A202C !important; font-weight:700; }
.tbl .tabulator-row { border-bottom:1px solid #EDF2F7; }
.tbl .tabulator-row.tabulator-row-even { background-color:#F7FAFC; }
.tbl .tabulator-row:hover { background-color:#EBF8FF !important; }
.tbl .tabulator-cell { border:1px solid #E2E8F0; color:#2D3748; }
tr.low-row { background-color:#FFF5F5 !important; }

/* ========== 뱃지 ========== */
.badge { display:inline-block; padding:2px 9px; border-radius:20px; font-size:11px; font-weight:700; white-space:nowrap; }
.b-ok   { background:#E6FFFA; color:#2C7A7B; border:1px solid #9AE6B4; }
.b-low  { background:#FFFAF0; color:#DD6B20; border:1px solid #FBD38D; }
.b-none { background:#FFF5F5; color:#C53030; border:1px solid #FEB2B2; }
.b-in   { background:#EBF8FF; color:#2B6CB0; border:1px solid #BEE3F8; }
.b-out  { background:#FFF5F5; color:#C53030; border:1px solid #FEB2B2; }
.b-adj  { background:#FFFAF0; color:#DD6B20; border:1px solid #FBD38D; }

/* ========== 행 액션 버튼 ========== */
.row-act { display:flex; gap:3px; flex-wrap:nowrap; justify-content:center; }
.row-act button {
    padding:2px 6px; font-size:11px; border-radius:4px; border:1px solid #E2E8F0;
    background:#F7FAFC; cursor:pointer; white-space:nowrap;
}
.row-act button:hover { background:#EBF8FF; }
.row-act button.pri { background:#3182CE; color:#fff; border-color:#2B6CB0; }
.row-act button.pri:hover { background:#2B6CB0; }
.row-act button:disabled { opacity:.4; cursor:not-allowed; background:#F7FAFC; color:#A0AEC0; }

/* ========== 모달 ========== */
.sp2-modal { display:none; position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); z-index:1000; }
.sp2-modal.active { display:block; }
.sp2-box {
    width:520px; max-width:95vw; max-height:90vh; background:white; border-radius:8px;
    box-shadow:0 10px 50px rgba(0,0,0,.3); overflow:hidden; display:flex; flex-direction:column;
}
.sp2-header {
    display:flex; justify-content:space-between; align-items:center; padding:10px 20px;
    background:linear-gradient(135deg,#2c3e50,#34495e); color:white; font-size:17px; font-weight:700; cursor:move;
}
.sp2-header.in-header  { background:linear-gradient(135deg,#2B6CB0,#3182CE); }
.sp2-header.out-header { background:linear-gradient(135deg,#c05621,#dd6b20); }
.sp2-header.adj-header { background:linear-gradient(135deg,#6b46c1,#805ad5); }
.header-close-btn { background:none; border:none; color:white; font-size:22px; cursor:pointer; width:26px; height:26px; }
.sp2-body { padding:16px 18px; background:#f5f7fa; overflow-y:auto; }
.sp2-row { display:grid; grid-template-columns:repeat(2,1fr); gap:10px; margin-bottom:10px; }
.sp2-row:last-child { margin-bottom:0; }
.sp2-row .full { grid-column:1/-1; }
.sp2-col { display:flex; flex-direction:column; gap:4px; }
.sp2-col label { font-size:12px; font-weight:600; color:#495057; }
.sp2-col input, .sp2-col select {
    padding:6px 10px; border:1px solid #ced4da; border-radius:4px; font-size:12px; width:100%; box-sizing:border-box;
}
.sp2-footer { display:flex; justify-content:center; gap:8px; padding:10px 15px; background:white; border-top:1px solid #dee2e6; }
.sp2-footer button { min-width:90px; height:34px; border:none; border-radius:4px; font-size:13px; font-weight:700; cursor:pointer; }
.sp2-footer button:disabled { opacity:.45; cursor:not-allowed; }
.sp2-save  { background:linear-gradient(135deg,#51cf66,#37b24d); color:white; }
.sp2-save-out { background:linear-gradient(135deg,#dd6b20,#c05621); color:white; }
.sp2-save-adj { background:linear-gradient(135deg,#805ad5,#6b46c1); color:white; }
.sp2-del   { background:linear-gradient(135deg,#ff6b6b,#fa5252); color:white; }
.sp2-close { background:linear-gradient(135deg,#868e96,#495057); color:white; }
.fac-chk { display:flex; flex-wrap:wrap; gap:6px; max-height:110px; overflow:auto; border:1px solid #ced4da; border-radius:4px; padding:8px; background:#fff; }
.fac-chk label { display:flex; align-items:center; gap:4px; border:1px solid #E2E8F0; border-radius:99px; padding:3px 10px; font-size:12px; color:#2D3748; cursor:pointer; }
.fac-chk input { width:auto; padding:0; }
.vendor-note { font-size:11px; color:#718096; margin-top:3px; }
.chart-card { background:#fff; border:1px solid #E2E8F0; border-radius:10px; padding:8px 12px; box-shadow:0 1px 4px rgba(0,0,0,.06); height:180px; margin-bottom:10px; flex-shrink:0; }
.hist-mini { max-height:360px; overflow:auto; font-size:13px; }
.hist-mini div { display:flex; justify-content:space-between; gap:8px; padding:6px 0; border-bottom:1px solid #E2E8F0; }
.hide { display:none !important; }
.po-row { display:grid; grid-template-columns:1fr 70px 90px; gap:8px; align-items:center; padding:5px 0; border-bottom:1px solid #E2E8F0; font-size:12px; }
.po-row input { width:100%; padding:4px 6px; border:1px solid #ced4da; border-radius:4px; font-size:12px; box-sizing:border-box; }
    </style>
</head>
<body>
    <main class="main">
        <!-- 서브탭 -->
        <div class="sp2-tabs">
            <button class="sp2-tab active" data-tab="stock">부품 재고</button>
            <button class="sp2-tab" data-tab="history">입출고 이력·현황</button>
        </div>

        <!-- ══════════ 부품 재고 ══════════ -->
        <div id="view-stock" class="sp2-view active">
            <div class="kpi-row">
                <div class="kpi-card"><div class="kpi-lbl">등록 부품</div><div class="kpi-val" id="kParts" style="color:#3182CE">0</div></div>
                <div class="kpi-card"><div class="kpi-lbl">등록 업체</div><div class="kpi-val" id="kVendors" style="color:#2C7A7B">0</div></div>
                <div class="kpi-card"><div class="kpi-lbl">재고부족</div><div class="kpi-val" id="kLow" style="color:#C53030">0</div></div>
                <div class="kpi-card"><div class="kpi-lbl">총 재고금액</div><div class="kpi-val" id="kAmount" style="color:#2D3748; font-size:18px">0원</div></div>
            </div>
            <div id="lowAlert" class="low-alert" style="display:none;"></div>
            <div class="sp2-filter-bar">
                <input type="text" id="q" placeholder="🔍 품명·품번·업체명·적용설비 검색" style="flex:1;min-width:200px">
                <select id="fe"><option value="">전체 적용설비</option></select>
                <select id="fv"><option value="">전체 업체</option></select>
                <select id="fl"><option value="">전체 상태</option><option value="low">재고부족만</option></select>
                <span class="spacer"></span>
                <button type="button" class="fbtn" id="btnPO">📋 발주서</button>
                <button type="button" class="fbtn" id="btnExcel">엑셀 내보내기</button>
                <button type="button" class="fbtn" id="btnReceipt">🧾 영수증사용</button>
                <button type="button" class="fbtn pri insert-button" id="btnAdd">+ 부품 등록</button>
            </div>
            <div id="tab1" class="tbl tabulator"></div>
        </div>

        <!-- ══════════ 입출고 이력·현황 ══════════ -->
        <div id="view-history" class="sp2-view">
            <div class="chart-card"><div id="hisChart" style="width:100%;height:100%"></div></div>
            <div class="sp2-filter-bar">
                <input type="text" id="hKeyword" placeholder="🔍 품번·품명 검색" style="flex:1;min-width:180px">
                <select id="hType">
                    <option value="">입고+출고+실사</option>
                    <option value="IN">입고(구입)만</option>
                    <option value="OUT">출고(사용)만</option>
                    <option value="ADJ">실사조정만</option>
                </select>
                <input type="date" id="hFrom">
                ~
                <input type="date" id="hTo">
                <span class="spacer"></span>
                <button type="button" class="fbtn" id="btnExcelHist">엑셀 저장</button>
            </div>
            <div id="tab2" class="tbl tabulator"></div>
        </div>
    </main>

    <!-- ========== 부품 등록/수정 모달 ========== -->
    <div class="sp2-modal" id="partsModal">
        <div class="sp2-box">
            <div class="sp2-header">
                <span id="partsModalTitle">부품 등록</span>
                <button type="button" class="header-close-btn" id="partsCloseBtn">&times;</button>
            </div>
            <div class="sp2-body">
                <div class="sp2-row">
                    <div class="sp2-col">
                        <label>부품번호 *</label>
                        <input type="text" id="mSpp2No" placeholder="예) HT-001">
                    </div>
                    <div class="sp2-col">
                        <label>품명 *</label>
                        <input type="text" id="mSpp2Name" placeholder="예) 히터 엘리먼트 3kW">
                    </div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col">
                        <label>카테고리</label>
                        <select id="mSpp2Category">
                            <option>히터</option><option>열전대</option><option>O2센서</option>
                            <option>팬모터</option><option>밸브</option><option>필터</option><option>기타</option>
                        </select>
                    </div>
                    <div class="sp2-col">
                        <label>단위</label>
                        <input type="text" id="mSpp2Unit" value="EA">
                    </div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col">
                        <label>업체명 *</label>
                        <select id="mSpp2Vendor"></select>
                        <div class="vendor-note">목록에 없으면 [기준정보 &gt; 거래처등록]에서 구분=매입처로 먼저 등록하세요</div>
                    </div>
                    <div class="sp2-col">
                        <label>단가(원)</label>
                        <input type="number" id="mSpp2Unitprice" min="0" value="0">
                    </div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col full">
                        <label>적용 설비(선택사항, 복수 선택 가능)</label>
                        <div id="mSpp2Equipment" class="fac-chk"></div>
                    </div>
                </div>
                <div class="sp2-row" id="stockFieldsRow">
                    <div class="sp2-col">
                        <label>안전재고(EA)</label>
                        <input type="number" id="mSpp2MinStock" value="1" min="0">
                    </div>
                    <div class="sp2-col" id="initStockBox">
                        <label>기초 재고(EA)</label>
                        <input type="number" id="mSpp2InitStock" value="0" min="0">
                    </div>
                </div>
            </div>
            <div class="sp2-footer">
                <button type="button" class="sp2-del" id="partsDelBtn" style="display:none;">삭제</button>
                <button type="button" class="sp2-save" id="partsSaveBtn">저장</button>
                <button type="button" class="sp2-close" id="partsCloseBtn2">닫기</button>
            </div>
        </div>
    </div>

    <!-- ========== 입고 모달 ========== -->
    <div class="sp2-modal" id="inModal">
        <div class="sp2-box" style="width:420px;">
            <div class="sp2-header in-header">
                📦 입고(구입) 등록
                <button type="button" class="header-close-btn" id="inCloseBtn">&times;</button>
            </div>
            <div class="sp2-body">
                <div class="sp2-row"><div class="sp2-col full"><label id="inPartLabel">부품</label></div></div>
                <div class="sp2-row">
                    <div class="sp2-col">
                        <label>입고 수량 *</label>
                        <input type="number" id="inQty" min="1" value="1">
                    </div>
                    <div class="sp2-col">
                        <label>구입 단가(원)</label>
                        <input type="number" id="inUnitprice" min="0" value="0">
                    </div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col">
                        <label>담당자</label>
                        <input type="text" id="inUserName" placeholder="성명">
                    </div>
                    <div class="sp2-col">
                        <label>메모</label>
                        <input type="text" id="inWorkDesc" placeholder="예) 정기 발주">
                    </div>
                </div>
            </div>
            <div class="sp2-footer">
                <button type="button" class="sp2-save" id="inSaveBtn">저장</button>
                <button type="button" class="sp2-close" id="inCloseBtn2">닫기</button>
            </div>
        </div>
    </div>

    <!-- ========== 출고(사용) 모달 ========== -->
    <div class="sp2-modal" id="outModal">
        <div class="sp2-box" style="width:420px;">
            <div class="sp2-header out-header">
                🔧 출고(사용) 등록
                <button type="button" class="header-close-btn" id="outCloseBtn">&times;</button>
            </div>
            <div class="sp2-body">
                <div class="sp2-row"><div class="sp2-col full"><label id="outPartLabel">부품</label></div></div>
                <div class="sp2-row">
                    <div class="sp2-col">
                        <label>사용 수량 *</label>
                        <input type="number" id="outQty" min="1" value="1">
                    </div>
                    <div class="sp2-col">
                        <label>담당자</label>
                        <input type="text" id="outUserName" placeholder="성명">
                    </div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col">
                        <label>사용 설비</label>
                        <select id="outFacCode"><option value="">(미지정)</option></select>
                    </div>
                    <div class="sp2-col">
                        <label>메모</label>
                        <input type="text" id="outWorkDesc" placeholder="예) 히터 교체">
                    </div>
                </div>
            </div>
            <div class="sp2-footer">
                <button type="button" class="sp2-save-out" id="outSaveBtn">사용 처리</button>
                <button type="button" class="sp2-close" id="outCloseBtn2">닫기</button>
            </div>
        </div>
    </div>

    <!-- ========== 실사 조정 모달 ========== -->
    <div class="sp2-modal" id="adjModal">
        <div class="sp2-box" style="width:420px;">
            <div class="sp2-header adj-header">
                🔍 재고 실사
                <button type="button" class="header-close-btn" id="adjCloseBtn">&times;</button>
            </div>
            <div class="sp2-body">
                <div class="sp2-row"><div class="sp2-col full"><label id="adjPartLabel">부품</label></div></div>
                <div class="sp2-row">
                    <div class="sp2-col">
                        <label>전산재고</label>
                        <input type="text" id="adjCurStock" readonly style="background:#f0f0f0;">
                    </div>
                    <div class="sp2-col">
                        <label>실제 조사 수량 *</label>
                        <input type="number" id="adjCountedQty" min="0" value="0">
                    </div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col full">
                        <label>담당자</label>
                        <input type="text" id="adjUserName" placeholder="성명">
                    </div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col full">
                        <label>메모</label>
                        <input type="text" id="adjWorkDesc" placeholder="예) 정기 실사">
                    </div>
                </div>
            </div>
            <div class="sp2-footer">
                <button type="button" class="sp2-save-adj" id="adjSaveBtn">조정 저장</button>
                <button type="button" class="sp2-close" id="adjCloseBtn2">닫기</button>
            </div>
        </div>
    </div>

    <!-- ========== 부품별 이력 보기 모달 ========== -->
    <div class="sp2-modal" id="histModal">
        <div class="sp2-box" style="width:560px;">
            <div class="sp2-header">
                <span id="histModalTitle">입출고 이력</span>
                <button type="button" class="header-close-btn" id="histCloseBtn">&times;</button>
            </div>
            <div class="sp2-body">
                <div id="histMiniBody" class="hist-mini"></div>
            </div>
            <div class="sp2-footer">
                <button type="button" class="sp2-close" id="histCloseBtn2">닫기</button>
            </div>
        </div>
    </div>

    <!-- ========== 발주서 작성 모달(재고부족 부품) ========== -->
    <div class="sp2-modal" id="poModal">
        <div class="sp2-box" style="width:640px;">
            <div class="sp2-header">
                발주서 작성 (재고부족 부품)
                <button type="button" class="header-close-btn" id="poCloseBtn">&times;</button>
            </div>
            <div class="sp2-body">
                <div id="poListBody" class="hist-mini" style="max-height:260px; margin-bottom:10px;"></div>
                <div class="vendor-note" style="margin-bottom:10px;">발주수량 기본값 = 안전재고×2 − 현재고 (수정 가능). 업체별로 발주서가 나뉘어 한 PDF에 출력됩니다.</div>
                <div class="sp2-row">
                    <div class="sp2-col"><label>회사명</label><input type="text" id="poCompName"></div>
                    <div class="sp2-col"><label>사업자등록번호</label><input type="text" id="poCompBiz" placeholder="000-00-00000"></div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col"><label>대표자</label><input type="text" id="poCompRep"></div>
                    <div class="sp2-col"><label>전화 / FAX</label><input type="text" id="poCompTel"></div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col full"><label>주소</label><input type="text" id="poCompAddr"></div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col"><label>발주 담당자</label><input type="text" id="poWorker"></div>
                    <div class="sp2-col"><label>납기일</label><input type="date" id="poDueDate"></div>
                </div>
                <div class="sp2-row">
                    <div class="sp2-col"><label>인도장소</label><input type="text" id="poPlace"></div>
                    <div class="sp2-col"><label>결제조건</label><input type="text" id="poPay" placeholder="예: 월말 현금결제"></div>
                </div>
            </div>
            <div class="sp2-footer">
                <button type="button" class="sp2-close" id="poCloseBtn2">닫기</button>
                <button type="button" class="sp2-save" id="poPrintBtn">🖨 발주서 출력</button>
            </div>
        </div>
    </div>

    <!-- ========== 발주서 인쇄 미리보기(= PDF 저장은 브라우저 인쇄의 'PDF로 저장' 사용) ========== -->
    <style id="sheetCss">
.sheet{background:#fff;color:#000;width:210mm;min-height:297mm;margin:0 auto 12px;padding:14mm;font:12px/1.45 "Malgun Gothic","Noto Sans KR",sans-serif;page-break-after:always;box-sizing:border-box}
.sheet table{border-collapse:collapse;width:100%;min-width:0;margin-bottom:8px}
.sheet th,.sheet td{border:1px solid #000;padding:4px 6px;white-space:normal;color:#000;background:#fff;font-size:12px;text-align:left}
.sheet th{background:#f0f0f0;text-align:center;font-weight:700}
.sheet .c{text-align:center}.sheet .r{text-align:right}.sheet .s{width:24px}
.sheet .pt{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:10px}
.sheet .pt>div:first-child{width:170px;flex:none}
.sheet .ptt{flex:1;text-align:center;font-size:28px;font-weight:700;letter-spacing:6px;text-decoration:underline;padding-top:6px}
.sheet .ap{width:170px;flex:none;margin:0}.sheet .ap td{height:46px}
.sheet .no{text-align:right;margin-bottom:6px}.sheet .kr{border:1px solid #000;padding:6px;margin-bottom:8px;font-weight:700}
.sheet .sg{text-align:center;margin-top:18px;font-size:14px;line-height:2}
.sheet:last-child{page-break-after:auto}
@media print{body *{visibility:hidden}#prWrap,#prWrap *{visibility:visible}#prWrap{position:absolute;top:0;left:0;background:none!important;padding:0!important}.prbar{display:none!important}.sheet{margin:0;width:auto;min-height:0;padding:0}@page{size:A4;margin:12mm}}
    </style>
    <div id="prWrap" class="hide" style="position:fixed;inset:0;z-index:2000;background:#6b7280;overflow:auto;padding:12px;">
        <div class="prbar" style="display:flex;gap:8px;flex-wrap:wrap;align-items:center;background:#fff;border:1px solid #E2E8F0;border-radius:10px;padding:8px;margin:0 auto 12px;max-width:210mm;position:sticky;top:0;z-index:2;">
            <button type="button" class="fbtn pri" onclick="window.print()">🖨 인쇄 (PDF로 저장 가능)</button>
            <button type="button" class="fbtn" id="prCloseBtn">닫기</button>
            <span class="vendor-note" style="margin:0;">인쇄 대화상자에서 '대상: PDF로 저장'을 선택하면 PDF 파일로 저장됩니다.</span>
        </div>
        <div id="prBody"></div>
    </div>

<script>
let now_page_code = "e10";
var sp2Table, sp2HisTable;
var sp2PartsCache = [];
var vendorCache = [];
var facilityCache = [];
var sp2IsEditMode = false;
var curTxPart = null;

const won = n => Math.round(n||0).toLocaleString('ko-KR')+'원';
const esc = s => String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
const low = p => p.stock_status === '부족' || p.stock_status === '재고없음';
const today = () => new Date().toISOString().slice(0,10);

/* =====================================================================
   권한 체계
   R(조회): 조회만 / I(저장): 조회+입고+출고만 / U(수정)~D(삭제): 그 외 전부(삭제는 D만)
   ===================================================================== */
function canWrite(level){
    const permission = (typeof userPermissions!=='undefined') ? userPermissions?.[now_page_code] : null;
    if(level === 'view')   return ['R','I','U','D'].includes(permission);
    if(level === 'inout')  return ['I','U','D'].includes(permission);
    if(level === 'full')   return ['U','D'].includes(permission);
    if(level === 'delete') return permission === 'D';
    return false;
}

//========== 페이지 로드 ==========
function waitForPermission(cb, attempts){
    attempts = attempts || 0;
    var ready = (typeof userPermissions !== 'undefined') && userPermissions && (userPermissions[now_page_code] !== undefined);
    if(ready || attempts >= 40){ cb(); return; }
    setTimeout(function(){ waitForPermission(cb, attempts+1); }, 50);
}
$(function(){
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    initTables();
    // 권한 로딩 레이스로 버튼이 비활성 상태로 굳어버리는 걸 막기 위해, 권한 확인 후 최초 목록을 그린다.
    waitForPermission(function(){
        loadOptionLists(function(){
            getPartInvenList();
        });
    });

    $(".sp2-tab").on("click", function(){
        var tab = $(this).data("tab");
        $(".sp2-tab").removeClass("active");
        $(this).addClass("active");
        $(".sp2-view").removeClass("active");
        $("#view-"+tab).addClass("active");
        if(tab === 'history') getPartInvenHisList();
    });

    $("#q, #fe, #fv, #fl").on("keyup change", function(e){
        if(e.type === "change" || e.key === "Enter" || e.type === "keyup") renderPartsTable();
    });
    $("#hKeyword, #hType, #hFrom, #hTo").on("keyup change", function(e){
        if(e.type === "change" || e.key === "Enter") getPartInvenHisList();
    });

    const y = today().slice(0,4);
    $("#hFrom").val(y+"-01-01");
    $("#hTo").val(today());
});

function loadOptionLists(cb){
    $.when(
        $.ajax({ url:"/tkheat/preservation/partInven/getVendorOptionList", type:"post", dataType:"json" }),
        $.ajax({ url:"/tkheat/preservation/partInven/getFacilityOptionList", type:"post", dataType:"json" })
    ).done(function(vRes, fRes){
        vendorCache = (vRes[0] && vRes[0].data) ? vRes[0].data : [];
        facilityCache = (fRes[0] && fRes[0].data) ? fRes[0].data : [];
        refreshDependentDropdowns();
        if(cb) cb();
    });
}

function refreshDependentDropdowns(){
    $("#mSpp2Vendor").html('<option value="">업체 선택</option>' +
        vendorCache.map(v => "<option value='"+v.corp_code+"'>"+esc(v.corp_name)+"</option>").join(""));
    $("#mSpp2Equipment").html(facilityCache.map(f =>
        "<label><input type='checkbox' value='"+f.fac_code+"'> "+esc(f.fac_name)+"</label>").join(""));
    $("#outFacCode").html('<option value="">(미지정)</option>' +
        facilityCache.map(f => "<option value='"+f.fac_code+"'>"+esc(f.fac_name)+"</option>").join(""));
    $("#fe").html('<option value="">전체 적용설비</option>' +
        facilityCache.map(f => "<option value='"+f.fac_code+"'>"+esc(f.fac_name)+"</option>").join(""));
    $("#fv").html('<option value="">전체 업체</option>' +
        vendorCache.map(v => "<option value='"+v.corp_code+"'>"+esc(v.corp_name)+"</option>").join(""));
}

/* =====================================================================
   부품 재고 탭
   ===================================================================== */
function initTables(){
    sp2Table = new Tabulator("#tab1", {
        height:"100%", layout:"fitColumns", selectable:false, tooltips:true, headerSort:true,
        reactiveData:false, headerHozAlign:"center", placeholder:"조회된 데이터가 없습니다.",
        pagination:"local", paginationSize:20, paginationSizeSelector:[20,50,100,500],
        paginationCounter:"rows",
        columns:[
            {title:"상태", field:"stock_status", width:80, hozAlign:"center",
                formatter:function(cell){
                    var v = cell.getValue();
                    var cls = v === "재고없음" ? "b-none" : (v === "부족" ? "b-low" : "b-ok");
                    return "<span class='badge "+cls+"'>"+v+"</span>";
                }},
            {title:"품명", field:"spp2_name", minWidth:140, hozAlign:"left"},
            {title:"품번", field:"spp2_no", width:100, hozAlign:"center"},
            {title:"업체명", field:"vendor_name", width:110, hozAlign:"left"},
            {title:"적용설비", field:"equipment_names", width:130, hozAlign:"left"},
            {title:"현재고", field:"current_stock", width:70, hozAlign:"right",
                formatter:function(cell){ return "<b>"+cell.getValue()+"</b>"; }},
            {title:"안전재고", field:"spp2_min_stock", width:70, hozAlign:"right"},
            {title:"단가", field:"spp2_unitprice", width:90, hozAlign:"right", formatter:c=>won(c.getValue())},
            {title:"평균구입단가", field:"spp2_avg_price", width:100, hozAlign:"right",
                formatter:function(cell){ var v=cell.getValue(); return v?won(v):"-"; }},
            {title:"재고금액", field:"stock_amount", width:100, hozAlign:"right", formatter:c=>won(c.getValue())},
            {title:"관리", field:"_mgmt", width:260, minWidth:260, hozAlign:"center", headerSort:false,
                formatter:function(cell){
                    var canIO = canWrite('inout'), canFull = canWrite('full');
                    return "<div class='row-act'>"
                        + "<button class='act-in'"+(canIO?'':' disabled')+">입고</button>"
                        + "<button class='act-out'"+(canIO?'':' disabled')+">출고</button>"
                        + "<button class='act-adj'"+(canFull?'':' disabled')+">실사</button>"
                        + "<button class='act-hist'>이력</button>"
                        + "<button class='act-edit pri'"+(canFull?'':' disabled')+">수정</button>"
                        + "</div>";
                },
                cellClick:function(e, cell){
                    var row = cell.getRow().getData();
                    var btn = e.target.closest("button");
                    if(!btn || btn.disabled) return;
                    if(btn.classList.contains("act-in")) openTxModal(row, "IN");
                    else if(btn.classList.contains("act-out")) openTxModal(row, "OUT");
                    else if(btn.classList.contains("act-adj")) openTxModal(row, "ADJ");
                    else if(btn.classList.contains("act-hist")) openHistMini(row);
                    else if(btn.classList.contains("act-edit")) openPartsModal(row);
                }}
        ],
        rowFormatter:function(row){
            row.getElement().style.fontWeight = "600";
            if(low(row.getData())) row.getElement().classList.add("low-row");
        }
    });

    sp2HisTable = new Tabulator("#tab2", {
        height:"100%", layout:"fitColumns", headerSort:true, reactiveData:false, headerHozAlign:"center",
        placeholder:"조회된 데이터가 없습니다.", pagination:"local", paginationSize:20,
        paginationSizeSelector:[20,50,100,500], paginationCounter:"rows",
        columns:[
            {title:"일시", field:"sph2_reg_date", width:140, hozAlign:"center"},
            {title:"구분", field:"sph2_type", width:70, hozAlign:"center",
                formatter:function(cell){
                    var v = cell.getValue();
                    if(v === "IN") return "<span class='badge b-in'>입고</span>";
                    if(v === "ADJ") return "<span class='badge b-adj'>실사</span>";
                    return "<span class='badge b-out'>사용</span>";
                }},
            {title:"품명", field:"spp2_name", minWidth:140, hozAlign:"left"},
            {title:"품번", field:"spp2_no", width:100, hozAlign:"center"},
            {title:"수량", field:"sph2_qty", width:70, hozAlign:"center",
                formatter:function(cell){
                    var row = cell.getRow().getData(), v = cell.getValue();
                    if(row.sph2_type === "IN") return "<span style='color:#2B6CB0;font-weight:700'>+"+v+"</span>";
                    if(row.sph2_type === "ADJ") return "<span style='color:#DD6B20;font-weight:700'>"+(v>0?"+":"")+v+"</span>";
                    return "<span style='color:#C53030;font-weight:700'>-"+v+"</span>";
                }},
            {title:"단가", field:"sph2_unitprice", width:90, hozAlign:"right", formatter:c=>{var v=c.getValue(); return v?won(v):"-";}},
            {title:"금액", field:"sph2_amount", width:100, hozAlign:"right", formatter:c=>{var v=c.getValue(); return v?won(v):"-";}},
            {title:"사용설비", field:"fac_name", width:110, hozAlign:"left"},
            {title:"담당자", field:"sph2_username", width:70, hozAlign:"center"},
            {title:"메모", field:"sph2_workdesc", minWidth:140, hozAlign:"left"},
            {title:"관리", field:"sph2_idx", width:60, hozAlign:"center", headerSort:false,
                formatter:function(){
                    var canDel = canWrite('delete');
                    return "<button class='act-del'"+(canDel?'':' disabled')+" style='padding:2px 8px;font-size:11px;border-radius:4px;border:1px solid #E2E8F0;background:none;cursor:pointer;'>삭제</button>";
                },
                cellClick:function(e, cell){
                    if(!canWrite('delete')){ alert("삭제 권한이 없습니다."); return; }
                    var d = cell.getRow().getData();
                    if(!confirm("이 이력을 삭제하시겠습니까?\n재고 수량이 자동으로 재계산됩니다.")) return;
                    $.ajax({
                        url:"/tkheat/preservation/partInven/partInvenHisDelete", type:"post", dataType:"json",
                        data:{ sph2_idx: d.sph2_idx },
                        success:function(result){
                            if(result.status === "success"){ getPartInvenHisList(); getPartInvenList(); }
                            else alert("삭제 중 오류가 발생했습니다: " + result.message);
                        }
                    });
                }}
        ]
    });
}

function getPartInvenList(){
    $.ajax({
        url:"/tkheat/preservation/partInven/getPartInvenList", type:"post", dataType:"json",
        data:{ category:"", keyword:"" },
        success:function(result){
            sp2PartsCache = result.data || [];
            renderPartsTable();
        }
    });
}

function renderPartsTable(){
    var q = $("#q").val().trim().toLowerCase();
    var fe = $("#fe").val(), fv = $("#fv").val(), fl = $("#fl").val();

    var list = sp2PartsCache.filter(function(p){
        var hay = [p.spp2_name, p.spp2_no, p.vendor_name, p.equipment_names].join(" ").toLowerCase();
        var matchQ = !q || hay.indexOf(q) >= 0;
        var matchFe = !fe || (p.equipment_names||"").indexOf((facilityCache.find(f=>String(f.fac_code)===fe)||{}).fac_name||" ") >= 0;
        var matchFv = !fv || String(p.spp2_vendor_code) === fv;
        var matchFl = fl !== "low" || low(p);
        return matchQ && matchFe && matchFv && matchFl;
    });
    sp2Table.setData(list);

    var lowList = sp2PartsCache.filter(low);
    var totalAmount = sp2PartsCache.reduce(function(s,p){ return s + (p.stock_amount||0); }, 0);
    $("#kParts").text(sp2PartsCache.length);
    $("#kVendors").text(vendorCache.length);
    $("#kLow").text(lowList.length);
    $("#kAmount").text(won(totalAmount));

    if(lowList.length){
        $("#lowAlert").show().html("⚠️ 재고부족 "+lowList.length+"건 — 발주가 필요합니다"
            + "<small>" + lowList.map(function(p){
                return esc(p.spp2_name) + (p.vendor_name?" ["+esc(p.vendor_name)+"]":"") + " (" + p.current_stock + "/" + p.spp2_min_stock + ")";
            }).join(" · ") + "</small>");
    }else{
        $("#lowAlert").hide();
    }
}

/* =====================================================================
   부품 등록/수정 모달
   ===================================================================== */
var sp2IsReceiptMode = false;
function openPartsModal(rowData, receiptMode){
    if(!canWrite('full')){ alert("권한이 없습니다. (수정 권한 이상 필요)"); return; }
    sp2IsEditMode = !!rowData;
    sp2IsReceiptMode = !rowData && !!receiptMode;
    $("#partsModalTitle").text(rowData ? "부품 수정" : (sp2IsReceiptMode ? "영수증사용 부품 등록" : "부품 등록"));
    $("#mSpp2Equipment input[type=checkbox]").prop("checked", false);

    if(rowData){
        $("#mSpp2No").val(rowData.spp2_no).prop("readonly", true);
        $("#mSpp2Name").val(rowData.spp2_name);
        $("#mSpp2Category").val(rowData.spp2_category);
        $("#mSpp2Unit").val(rowData.spp2_unit || "EA");
        $("#mSpp2Vendor").val(rowData.spp2_vendor_code || "");
        $("#mSpp2Unitprice").val(rowData.spp2_unitprice || 0);
        $("#mSpp2MinStock").val(rowData.spp2_min_stock);
        $("#stockFieldsRow").show();
        $("#initStockBox").hide();
        $("#partsDelBtn").toggle(canWrite('delete')).data("row", rowData);

        $.ajax({
            url:"/tkheat/preservation/partInven/getPartFacilityCodes", type:"post", dataType:"json",
            data:{ spp2_no: rowData.spp2_no },
            success:function(result){
                (result.data||[]).map(String).forEach(function(c){ $("#mSpp2Equipment input[value='"+c+"']").prop("checked", true); });
            }
        });
    }else{
        $("#mSpp2No").val("").prop("readonly", false);
        $("#mSpp2Name").val("");
        $("#mSpp2Category").val("기타");
        $("#mSpp2Unit").val("EA");
        $("#mSpp2Vendor").val("");
        $("#mSpp2Unitprice").val("0");
        $("#mSpp2MinStock").val("1");
        $("#mSpp2InitStock").val("0");
        $("#partsDelBtn").hide();
        if(sp2IsReceiptMode){
            $("#stockFieldsRow").hide();
        }else{
            $("#stockFieldsRow").show();
            $("#initStockBox").show();
        }
    }

    $("#partsModal").addClass("active");
    registerModalOpen('partInven-parts', closePartsModal);
}
function closePartsModal(){ registerModalClose('partInven-parts'); $("#partsModal").removeClass("active"); }
$("#btnAdd").on("click", function(){
    if(vendorCache.length === 0){ alert("먼저 [기준정보 > 거래처등록]에서 구분=매입처로 업체를 등록하세요."); return; }
    openPartsModal(null, false);
});
$("#btnReceipt").on("click", function(){
    if(!canWrite('full')){ alert("권한이 없습니다. (수정 권한 이상 필요)"); return; }
    if(vendorCache.length === 0){ alert("먼저 [기준정보 > 거래처등록]에서 구분=매입처로 업체를 등록하세요."); return; }
    openPartsModal(null, true);
});
$("#partsCloseBtn, #partsCloseBtn2").on("click", closePartsModal);

$("#partsSaveBtn").on("click", function(){
    if(!canWrite('full')){ alert("권한이 없습니다. (수정 권한 이상 필요)"); return; }

    var spp2_no = $("#mSpp2No").val().trim();
    var spp2_name = $("#mSpp2Name").val().trim();
    var vendorCode = $("#mSpp2Vendor").val();
    if(!spp2_no || !spp2_name){ alert("부품번호와 품명은 필수입니다."); return; }
    if(!vendorCode){ alert("업체를 선택하세요."); return; }
    if(!confirm(sp2IsEditMode ? "수정하시겠습니까?" : "저장하시겠습니까?")) return;

    var facCodes = $("#mSpp2Equipment input[type=checkbox]:checked").map(function(){ return $(this).val(); }).get();
    var minStock = sp2IsReceiptMode ? 0 : ($("#mSpp2MinStock").val() || 0);

    $.ajax({
        url:"/tkheat/preservation/partInven/partInvenSave", type:"post", dataType:"json", traditional:true,
        data:{
            mode: sp2IsEditMode ? "update" : "insert",
            spp2_no: spp2_no, spp2_name: spp2_name,
            spp2_category: $("#mSpp2Category").val(),
            spp2_unit: $("#mSpp2Unit").val().trim() || "EA",
            spp2_vendor_code: vendorCode,
            spp2_unitprice: $("#mSpp2Unitprice").val() || 0,
            spp2_min_stock: minStock,
            fac_codes: facCodes
        },
        success:function(result){
            if(result.status !== "success"){ alert(result.message || "저장 실패"); return; }
            var initQty = sp2IsReceiptMode ? 0 : parseInt($("#mSpp2InitStock").val());
            if(!sp2IsEditMode && initQty > 0){
                $.ajax({
                    url:"/tkheat/preservation/partInven/partInvenHisSave", type:"post", dataType:"json",
                    data:{ spp2_no: spp2_no, sph2_type:"IN", sph2_qty:initQty, sph2_unitprice:$("#mSpp2Unitprice").val()||0, sph2_workdesc:"기초 재고 등록" },
                    complete:function(){ alert("저장 되었습니다."); closePartsModal(); getPartInvenList(); }
                });
            }else{
                alert("저장 되었습니다."); closePartsModal(); getPartInvenList();
            }
        }
    });
});
$("#partsDelBtn").on("click", function(){
    if(!canWrite('delete')){ alert("삭제 권한이 없습니다."); return; }
    var row = $(this).data("row");
    if(!row) return;
    if(!confirm("["+row.spp2_no+"] 부품을 삭제하시겠습니까?\n관련 입출고 이력도 함께 삭제됩니다.")) return;
    $.ajax({
        url:"/tkheat/preservation/partInven/partInvenDelete", type:"post", dataType:"json",
        data:{ spp2_no: row.spp2_no },
        success:function(result){
            if(result.status !== "success"){ alert(result.message || "삭제 실패"); return; }
            alert("삭제되었습니다."); closePartsModal(); getPartInvenList();
        }
    });
});

/* =====================================================================
   입고/출고/실사 모달
   ===================================================================== */
function openTxModal(part, type){
    var need = (type === 'ADJ') ? 'full' : 'inout';
    if(!canWrite(need)){ alert("권한이 없습니다."); return; }
    curTxPart = part;
    if(type === "IN"){
        $("#inPartLabel").text(part.spp2_name + " (" + part.spp2_no + ")");
        $("#inQty").val(1);
        $("#inUnitprice").val(part.spp2_unitprice || 0);
        $("#inUserName").val(""); $("#inWorkDesc").val("정기 발주");
        $("#inModal").addClass("active"); registerModalOpen('partInven-in', closeInModal);
    }else if(type === "OUT"){
        $("#outPartLabel").text(part.spp2_name + " (" + part.spp2_no + ")");
        $("#outQty").val(1); $("#outUserName").val(""); $("#outWorkDesc").val(""); $("#outFacCode").val("");
        $("#outModal").addClass("active"); registerModalOpen('partInven-out', closeOutModal);
    }else{
        $("#adjPartLabel").text(part.spp2_name + " (" + part.spp2_no + ")");
        $("#adjCurStock").val(part.current_stock);
        $("#adjCountedQty").val(part.current_stock);
        $("#adjUserName").val(""); $("#adjWorkDesc").val("정기 실사");
        $("#adjModal").addClass("active"); registerModalOpen('partInven-adj', closeAdjModal);
    }
}
function closeInModal(){ registerModalClose('partInven-in'); $("#inModal").removeClass("active"); }
function closeOutModal(){ registerModalClose('partInven-out'); $("#outModal").removeClass("active"); }
function closeAdjModal(){ registerModalClose('partInven-adj'); $("#adjModal").removeClass("active"); }
$("#inCloseBtn, #inCloseBtn2").on("click", closeInModal);
$("#outCloseBtn, #outCloseBtn2").on("click", closeOutModal);
$("#adjCloseBtn, #adjCloseBtn2").on("click", closeAdjModal);

$("#inSaveBtn").on("click", function(){
    if(!canWrite('inout')){ alert("권한이 없습니다."); return; }
    var qty = parseInt($("#inQty").val());
    if(!qty || qty < 1){ alert("수량을 1 이상 입력하세요."); return; }
    $.ajax({
        url:"/tkheat/preservation/partInven/partInvenHisSave", type:"post", dataType:"json",
        data:{
            spp2_no: curTxPart.spp2_no, sph2_type:"IN", sph2_qty:qty,
            sph2_unitprice: $("#inUnitprice").val() || 0,
            sph2_workdesc: $("#inWorkDesc").val().trim(), sph2_username: $("#inUserName").val().trim()
        },
        success:function(result){
            if(result.status !== "success"){ alert(result.message || "저장 실패"); return; }
            closeInModal(); getPartInvenList();
        }
    });
});
$("#outSaveBtn").on("click", function(){
    if(!canWrite('inout')){ alert("권한이 없습니다."); return; }
    var qty = parseInt($("#outQty").val());
    if(!qty || qty < 1){ alert("수량을 1 이상 입력하세요."); return; }
    if(curTxPart.current_stock < qty){
        if(!confirm("현재 재고("+curTxPart.current_stock+")보다 많은 수량입니다. 계속 진행하시겠습니까?")) return;
    }
    $.ajax({
        url:"/tkheat/preservation/partInven/partInvenHisSave", type:"post", dataType:"json",
        data:{
            spp2_no: curTxPart.spp2_no, sph2_type:"OUT", sph2_qty:qty,
            sph2_fac_code: $("#outFacCode").val(),
            sph2_workdesc: $("#outWorkDesc").val().trim(), sph2_username: $("#outUserName").val().trim()
        },
        success:function(result){
            if(result.status !== "success"){ alert(result.message || "저장 실패"); return; }
            closeOutModal(); getPartInvenList();
        }
    });
});
$("#adjSaveBtn").on("click", function(){
    if(!canWrite('full')){ alert("권한이 없습니다."); return; }
    var cur = curTxPart.current_stock;
    var counted = parseInt($("#adjCountedQty").val());
    if(isNaN(counted) || counted < 0){ alert("실제 조사 수량을 입력하세요."); return; }
    var delta = counted - cur;
    if(delta === 0){ alert("전산재고와 실제 수량이 같아 조정할 내용이 없습니다."); return; }
    if(!confirm("전산재고 "+cur+" → 실제 "+counted+" ("+(delta>0?"+":"")+delta+")로 조정하시겠습니까?")) return;
    $.ajax({
        url:"/tkheat/preservation/partInven/partInvenHisSave", type:"post", dataType:"json",
        data:{
            spp2_no: curTxPart.spp2_no, sph2_type:"ADJ", sph2_qty:delta,
            sph2_workdesc: $("#adjWorkDesc").val().trim() || "실사 조정", sph2_username: $("#adjUserName").val().trim()
        },
        success:function(result){
            if(result.status !== "success"){ alert(result.message || "저장 실패"); return; }
            closeAdjModal(); getPartInvenList();
        }
    });
});

/* =====================================================================
   부품별 이력 간단보기 모달
   ===================================================================== */
function openHistMini(part){
    $("#histModalTitle").text(part.spp2_name + " 입출고 이력");
    $("#histMiniBody").html("<div class='empty'>불러오는 중…</div>");
    $("#histModal").addClass("active");
    registerModalOpen('partInven-histmini', closeHistMini);
    $.ajax({
        url:"/tkheat/preservation/partInven/getPartInvenHisList", type:"post", dataType:"json",
        data:{ type:"", keyword: part.spp2_no, fromDt:"", toDt:"" },
        success:function(result){
            var list = (result.data||[]).filter(function(l){ return l.spp2_no === part.spp2_no; });
            if(!list.length){ $("#histMiniBody").html("<div style='padding:20px;text-align:center;color:#718096;'>이력이 없습니다.</div>"); return; }
            $("#histMiniBody").html(list.map(function(l){
                var label = l.sph2_type === "IN" ? "<b style='color:#2B6CB0'>입고 +"+l.sph2_qty+"</b>"
                    : l.sph2_type === "ADJ" ? "<b style='color:#DD6B20'>실사 "+(l.sph2_qty>0?"+":"")+l.sph2_qty+"</b>"
                    : "<b style='color:#C53030'>출고 -"+l.sph2_qty+"</b>";
                var extra = l.sph2_type === "IN" && l.sph2_unitprice ? " @ "+won(l.sph2_unitprice)+" (합계 "+won(l.sph2_amount)+")" : "";
                return "<div><span>"+esc(l.sph2_reg_date)+" · "+label+extra+"</span>"
                    + "<span style='color:#718096'>"+esc([l.fac_name, l.sph2_username, l.sph2_workdesc].filter(Boolean).join(' · '))+"</span></div>";
            }).join(""));
        }
    });
}
function closeHistMini(){ registerModalClose('partInven-histmini'); $("#histModal").removeClass("active"); }
$("#histCloseBtn, #histCloseBtn2").on("click", closeHistMini);

/* =====================================================================
   입출고 이력·현황 탭
   ===================================================================== */
function getPartInvenHisList(){
    $.ajax({
        url:"/tkheat/preservation/partInven/getPartInvenHisList", type:"post", dataType:"json",
        data:{ type: $("#hType").val(), keyword: $("#hKeyword").val(), fromDt: $("#hFrom").val(), toDt: $("#hTo").val() },
        success:function(result){
            var list = result.data || [];
            sp2HisTable.setData(list);
            renderHisChart(list);
        }
    });
}
function renderHisChart(list){
    var m = {};
    list.filter(function(l){ return l.sph2_type === 'IN'; }).forEach(function(l){
        var ym = (l.sph2_reg_date||'').slice(0,7);
        if(!ym) return;
        m[ym] = (m[ym]||0) + (l.sph2_amount||0);
    });
    var keys = Object.keys(m).sort();
    Highcharts.chart('hisChart', {
        chart:{ type:'column' },
        title:{ text:'월별 구입금액', style:{ fontSize:'13px' } },
        xAxis:{ categories:keys, labels:{ style:{ fontSize:'10px' } } },
        yAxis:{ title:{ text:null }, labels:{ style:{ fontSize:'10px' } } },
        legend:{ enabled:false },
        credits:{ enabled:false },
        plotOptions:{ column:{ color:'#3182CE' } },
        series:[{ name:'구입금액', data:keys.map(function(k){ return m[k]; }) }]
    });
}

/* =====================================================================
   엑셀 내보내기
   ===================================================================== */
$("#btnExcel").on("click", function(){
    var data = sp2Table.getData();
    if(!data.length){ alert("내보낼 데이터가 없습니다."); return; }
    var rows = data.map(function(p){
        return { 품명:p.spp2_name, 품번:p.spp2_no, 업체명:p.vendor_name||'', 적용설비:p.equipment_names||'',
            현재고:p.current_stock, 안전재고:p.spp2_min_stock, 단가:p.spp2_unitprice||0,
            평균구입단가:Math.round(p.spp2_avg_price||0), 재고금액:Math.round(p.stock_amount||0), 상태:p.stock_status };
    });
    var ws = XLSX.utils.json_to_sheet(rows);
    ws['!cols'] = Object.keys(rows[0]).map(function(k){ return { wch: Math.max(10, k.length*2+4) }; });
    var wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "부품재고");
    XLSX.writeFile(wb, "부품재고_"+today()+".xlsx");
});
$("#btnExcelHist").on("click", function(){
    var data = sp2HisTable.getData();
    if(!data.length){ alert("내보낼 이력이 없습니다."); return; }
    var typeName = { IN:'입고', OUT:'출고', ADJ:'실사조정' };
    var rows = data.map(function(l){
        return { 일자:l.sph2_reg_date, 구분:typeName[l.sph2_type]||l.sph2_type, 품명:l.spp2_name, 품번:l.spp2_no,
            수량:l.sph2_qty, 단가:l.sph2_type==='IN'?(l.sph2_unitprice||0):'', 금액:l.sph2_type==='IN'?(l.sph2_amount||0):'',
            사용설비:l.fac_name||'', 담당자:l.sph2_username||'', 메모:l.sph2_workdesc||'' };
    });
    var ws = XLSX.utils.json_to_sheet(rows);
    ws['!cols'] = Object.keys(rows[0]).map(function(k){ return { wch: Math.max(10, k.length*2+4) }; });
    var wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "입출고이력");
    XLSX.writeFile(wb, "입출고이력_"+today()+".xlsx");
});

/* =====================================================================
   모달 드래그(공통)
   ===================================================================== */
function makeModalDraggable(headerSel, modalSel){
    const header = document.querySelector(headerSel);
    const modal = document.querySelector(modalSel);
    if(!header || !modal) return;
    header.addEventListener('mousedown', function(e){
        if (e.target.classList.contains('header-close-btn') || e.target.closest('.header-close-btn')) return;
        const rect = modal.getBoundingClientRect();
        modal.style.left = rect.left + 'px'; modal.style.top = rect.top + 'px'; modal.style.transform = 'none';
        let offsetX = e.clientX - rect.left, offsetY = e.clientY - rect.top;
        function moveModal(e){ modal.style.left = (e.clientX - offsetX) + 'px'; modal.style.top = (e.clientY - offsetY) + 'px'; }
        function stopMove(){ window.removeEventListener('mousemove', moveModal); window.removeEventListener('mouseup', stopMove); }
        window.addEventListener('mousemove', moveModal); window.addEventListener('mouseup', stopMove);
    });
}
/* =====================================================================
   발주서 (재고부족 부품 → 업체별 발주서, 인쇄/“PDF로 저장”)
   ===================================================================== */
var poList = [];
function getPoCompanyDefaults(){
    try{ return JSON.parse(localStorage.getItem('tkheat_po_company')||'{}'); }catch(e){ return {}; }
}
function savePoCompanyDefaults(c){
    try{ localStorage.setItem('tkheat_po_company', JSON.stringify(c)); }catch(e){}
}
function openPOModal(){
    if(!canWrite('full')){ alert("권한이 없습니다. (수정 권한 이상 필요)"); return; }
    poList = sp2PartsCache.filter(low).map(function(p){
        return { p:p, q: Math.max((p.spp2_min_stock||0)*2 - (p.current_stock||0), 1) };
    });
    renderPoListBody();
    var c = getPoCompanyDefaults();
    $("#poCompName").val(c.name||''); $("#poCompBiz").val(c.biz||'');
    $("#poCompRep").val(c.rep||''); $("#poCompTel").val(c.tel||'');
    $("#poCompAddr").val(c.addr||''); $("#poWorker").val(c.worker||'');
    $("#poPlace").val(c.place||''); $("#poPay").val(c.pay||'');
    var d = new Date(); d.setDate(d.getDate()+7);
    $("#poDueDate").val(d.toISOString().slice(0,10));
    $("#poModal").addClass("active");
    registerModalOpen('partInven-po', closePOModal);
}
function closePOModal(){ registerModalClose('partInven-po'); $("#poModal").removeClass("active"); }
function renderPoListBody(){
    if(!poList.length){ $("#poListBody").html("<div style='padding:16px;text-align:center;color:#718096;'>재고부족 부품이 없습니다.</div>"); return; }
    $("#poListBody").html(poList.map(function(x,i){
        return "<div class='po-row'><span>"+esc(x.p.spp2_name)+" <span style='color:#718096'>"+esc(x.p.spp2_no)+" · "+esc(x.p.vendor_name||'업체없음')+"</span></span>"
            + "<span style='text-align:center;color:#718096'>"+x.p.current_stock+"/"+x.p.spp2_min_stock+"</span>"
            + "<input type='number' min='0' value='"+x.q+"' data-i='"+i+"' class='po-qty'></div>";
    }).join(""));
    $(".po-qty").on("input", function(){ poList[$(this).data("i")].q = (+$(this).val())||0; });
}
$("#btnPO").on("click", openPOModal);
$("#poCloseBtn, #poCloseBtn2").on("click", closePOModal);

function krNum(n){
    n=Math.round(n); if(!n) return '영';
    const U=['','만','억','조'],D=['','일','이','삼','사','오','육','칠','팔','구'],S=['','십','백','천'];
    let r='',g=0;
    while(n>0){
        let x=n%10000,t='';
        for(let i=0;i<4;i++){ const v=x%10; if(v) t=(v===1&&i>0?'':D[v])+S[i]+t; x=Math.floor(x/10); }
        if(t) r=t+U[g]+r;
        n=Math.floor(n/10000); g++;
    }
    return r;
}
function poSheet(v, items, no, c, o){
    const f = n => n.toLocaleString('ko-KR');
    let sup = 0;
    const rows = items.map(function(x,i){
        const pr = x.p.spp2_unitprice || Math.round(x.p.spp2_avg_price||0) || 0, amt = pr*x.q;
        sup += amt;
        return "<tr><td class='c'>"+(i+1)+"</td><td>"+esc(x.p.spp2_name)+"</td><td>"+esc(x.p.spp2_no)+"</td><td class='c'>"+esc(x.p.spp2_unit||'EA')+"</td>"
            + "<td class='r'>"+x.q+"</td><td class='r'>"+f(pr)+"</td><td class='r'>"+f(amt)+"</td><td>"+esc(x.p.equipment_names||'')+"</td></tr>";
    });
    while(rows.length<12) rows.push("<tr><td class='c'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
    const vat = Math.round(sup*0.1), tot = sup+vat, dt = today().split('-'), ds = dt[0]+"년 "+(+dt[1])+"월 "+(+dt[2])+"일";
    return "<div class='sheet'><div class='pt'><div></div><div class='ptt'>발 주 서</div>"
        + "<table class='ap'><tr><th rowspan='2' style='width:22px'>결<br>재</th><th>담당</th><th>검토</th><th>승인</th></tr><tr><td></td><td></td><td></td></tr></table></div>"
        + "<div class='no'>발주번호: "+no+" &nbsp;&nbsp; 발주일: "+ds+"</div>"
        + "<table class='info'><tr><th rowspan='5' class='s'>수<br>신</th><th>상 호</th><td>"+esc(v.corp_name||'')+"</td><th rowspan='5' class='s'>발<br>신</th><th>상 호</th><td>"+esc(c.name)+"</td></tr>"
        + "<tr><th>사업자번호</th><td>"+esc(v.corp_no||'')+"</td><th>사업자번호</th><td>"+esc(c.biz)+"</td></tr>"
        + "<tr><th>대 표 자</th><td>"+esc(v.corp_boss||'')+"</td><th>대 표 자</th><td>"+esc(c.rep)+"</td></tr>"
        + "<tr><th>전 화</th><td>"+esc(v.corp_tel||'')+"</td><th>전 화</th><td>"+esc(c.tel)+"</td></tr>"
        + "<tr><th>주 소</th><td>"+esc(v.corp_add||'')+"</td><th>주 소</th><td>"+esc(c.addr)+"</td></tr></table>"
        + "<p style='margin:6px 0'>아래와 같이 발주합니다.</p>"
        + "<table class='it'><thead><tr><th style='width:30px'>No</th><th>품 명</th><th>품번(규격)</th><th style='width:38px'>단위</th><th style='width:44px'>수량</th><th>단가</th><th>공급가액</th><th>적용설비 / 비고</th></tr></thead><tbody>"+rows.join("")+"</tbody>"
        + "<tfoot><tr><th colspan='6'>공 급 가 액</th><td class='r' colspan='2'>"+f(sup)+" 원</td></tr><tr><th colspan='6'>부 가 세 (10%)</th><td class='r' colspan='2'>"+f(vat)+" 원</td></tr><tr><th colspan='6'>합 계 금 액</th><td class='r' colspan='2'><b>"+f(tot)+" 원</b></td></tr></tfoot></table>"
        + "<div class='kr'>합계금액: 일금 "+krNum(tot)+"원정 (₩"+f(tot)+", VAT 포함)</div>"
        + "<table class='info'><tr><th>납 기 일</th><td>"+esc(o.due)+"</td><th>인도장소</th><td>"+esc(o.place)+"</td></tr><tr><th>결제조건</th><td>"+esc(o.pay)+"</td><th>발주담당</th><td>"+esc(o.worker)+"</td></tr></table>"
        + "<div class='sg'>"+ds+"<br>발주처: <b>"+esc(c.name)+"</b> &nbsp;&nbsp; 대표 "+esc(c.rep)+" (인)</div></div>";
}
$("#poPrintBtn").on("click", function(){
    var items = poList.filter(function(x){ return x.q > 0; });
    if(!items.length){ alert("발주할 품목이 없습니다."); return; }
    var c = {
        name: $("#poCompName").val().trim(), biz: $("#poCompBiz").val().trim(), rep: $("#poCompRep").val().trim(),
        tel: $("#poCompTel").val().trim(), addr: $("#poCompAddr").val().trim(),
        worker: $("#poWorker").val().trim(), place: $("#poPlace").val().trim(), pay: $("#poPay").val().trim()
    };
    savePoCompanyDefaults(c);
    var o = { worker:c.worker, due:$("#poDueDate").val(), place:c.place, pay:c.pay };

    var byVendor = {};
    items.forEach(function(x){
        var key = x.p.spp2_vendor_code || 'none';
        (byVendor[key] = byVendor[key] || []).push(x);
    });
    var ids = Object.keys(byVendor);
    var d = today().replace(/-/g,'');
    var html = ids.map(function(id, i){
        var v = vendorCache.find(function(z){ return String(z.corp_code) === String(id); }) || {corp_name:'(업체 미지정)'};
        return poSheet(v, byVendor[id], "PO-"+d+"-"+String(i+1).padStart(2,'0'), c, o);
    }).join("");
    $("#prBody").html(html);
    closePOModal();
    $("#prWrap").removeClass("hide");
});
$("#prCloseBtn").on("click", function(){ $("#prWrap").addClass("hide"); });

['#partsModal','#inModal','#outModal','#adjModal','#histModal','#poModal'].forEach(function(sel){
    makeModalDraggable(sel+' .sp2-header', sel);
});
</script>
</body>
</html>
