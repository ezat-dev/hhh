<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KPI관리현황</title>
<%@include file="../include/pluginpage.jsp" %>
<style>
html, body { height:100%; margin:0; }
body { display:flex; flex-direction:column; overflow:hidden; }
.main { flex:1; min-height:0; display:flex; flex-direction:column; padding:8px; overflow:hidden; }

.kpi-toolbar {
    display:flex; align-items:center; gap:10px; flex-shrink:0; margin-bottom:8px;
    background:#fff; border:1px solid #E2E8F0; border-radius:10px; padding:8px 14px;
    box-shadow:0 1px 4px rgba(0,0,0,.06);
}
.kpi-toolbar label { font-size:13px; font-weight:700; color:#2D3748; }
.kpi-toolbar select, .kpi-toolbar input[type="number"] {
    height:32px; border:1px solid #CBD5E0; border-radius:6px; padding:0 8px; font-size:13px;
}
.kpi-toolbar button {
    height:32px; padding:0 14px; border-radius:6px; border:1px solid #CBD5E0; background:#F0F4F8;
    font-size:13px; font-weight:700; cursor:pointer;
}
.kpi-toolbar button:hover { background:#EBF8FF; border-color:#BEE3F8; }
.kpi-toolbar .btn-primary { background:#3182CE; color:#fff; border-color:#2B6CB0; }
.kpi-toolbar .btn-primary:hover { background:#2B6CB0; }
.kpi-hint { margin-left:auto; font-size:11px; color:#718096; }

.kpi-table-wrap { flex:1; min-height:0; overflow:auto; background:#fff; border:1px solid #E2E8F0; border-radius:10px; box-shadow:0 1px 4px rgba(0,0,0,.06); }
table.kpi-table { border-collapse:collapse; width:100%; font-size:12px; table-layout:fixed; }
table.kpi-table th, table.kpi-table td {
    border:1px solid #CBD5E0; padding:4px 5px; text-align:center; white-space:pre-line; overflow:hidden; text-overflow:ellipsis;
    box-sizing:border-box;
}
table.kpi-table thead th {
    position:sticky; top:0; z-index:5; background:#2B6CB0; color:#fff; font-weight:700;
}
/* 1번째 헤더행(순/프로세스명/...)과 2번째 헤더행(1月~12月)이 sticky로 겹쳐쌓일 때, 2번째 행의
   top값은 1번째 행의 "실제 렌더링 높이"와 정확히 같아야 두 행이 바로 붙어보임(어긋나면 그 차이만큼
   틈이 생김) - "합계/<br>평균"처럼 2줄짜리 셀이 섞여있어도 높이가 흔들리지 않게 1번째 행 높이를
   고정값으로 못박고, 2번째 행 top도 그 값과 정확히 맞춤 */
table.kpi-table thead tr:nth-child(1) th { height:36px; line-height:14px; }
table.kpi-table thead tr:nth-child(2) th { top:36px; }

col.col-no    { width:32px; }
col.col-proc  { width:70px; }
col.col-name  { width:100px; }
col.col-unit  { width:70px; }
col.col-gubn  { width:40px; }
col.col-month { width:52px; }
col.col-sum   { width:68px; }
col.col-mgr   { width:62px; }
col.col-note  { width:120px; }

.proc-cell { font-weight:800; background:#EDF2F7; }
.row-plan   td { background:#EBF8FF; }
.row-actual td { background:#ffffff; }
.row-pct    td { background:#F7FAFC; color:#4A5568; font-weight:700; }
.pct-good { color:#2F855A !important; }
.pct-bad  { color:#C53030 !important; }

.editable-cell { cursor:pointer; }
.editable-cell:hover { outline:2px solid #90CDF4; outline-offset:-2px; }
.editable-cell.editing { padding:0; }
.editable-cell input {
    width:100%; height:100%; border:none; outline:2px solid #3182CE; text-align:center; font-size:12px;
    box-sizing:border-box; padding:4px 2px;
}
.note-cell, .mgr-cell { text-align:left; }
.gubn-lbl { font-weight:700; color:#4A5568; }

.kpi-loading { text-align:center; padding:40px; color:#718096; }

.kpi-item-cell { cursor:pointer; }
.kpi-item-cell:hover { text-decoration:underline; }

.kpi-modal-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,.45); z-index:999; }
.kpi-modal-overlay.active { display:flex; align-items:center; justify-content:center; }
.kpi-modal-box {
    background:#fff; border-radius:10px; width:420px; max-width:92vw; box-shadow:0 10px 50px rgba(0,0,0,.3);
    overflow:hidden;
}
.kpi-modal-header {
    padding:12px 18px; background:linear-gradient(135deg,#2B6CB0,#3182CE); color:#fff; font-size:15px; font-weight:700;
}
.kpi-modal-body { padding:16px 18px; display:flex; flex-direction:column; gap:12px; }
.kpi-modal-body label { font-size:12px; font-weight:700; color:#4A5568; display:block; margin-bottom:4px; }
.kpi-modal-body input, .kpi-modal-body select {
    width:100%; height:34px; border:1px solid #CBD5E0; border-radius:6px; padding:0 10px; font-size:13px; box-sizing:border-box;
}
.kpi-modal-footer { display:flex; justify-content:flex-end; gap:8px; padding:12px 18px; border-top:1px solid #E2E8F0; }
.kpi-modal-footer button {
    height:34px; padding:0 16px; border-radius:6px; border:1px solid #CBD5E0; background:#F0F4F8; font-size:13px; font-weight:700; cursor:pointer;
}
.kpi-modal-footer .btn-save { background:#3182CE; color:#fff; border-color:#2B6CB0; }
.kpi-modal-footer .btn-del  { background:#FFF5F5; color:#C53030; border-color:#FEB2B2; margin-right:auto; }
</style>
</head>
<body>
<main class="main">
    <div class="kpi-toolbar">
        <label>연도</label>
        <select id="yearSelect" autocomplete="off"></select>
        <input type="number" id="newYearInput" placeholder="새 연도(예:2026)" style="width:120px">
        <button id="btnAddYear">새 연도 추가/조회</button>
        <button class="btn-primary" id="btnReload">조회</button>
        <button id="btnAddKpiItem">＋ 항목 추가</button>
        <span class="kpi-hint"></span>
    </div>
    <div class="kpi-table-wrap">
        <table class="kpi-table" id="kpiTable">
            <colgroup>
                <col class="col-proc"><col class="col-no"><col class="col-name"><col class="col-unit"><col class="col-gubn">
                <col class="col-month"><col class="col-month"><col class="col-month"><col class="col-month">
                <col class="col-month"><col class="col-month"><col class="col-month"><col class="col-month">
                <col class="col-month"><col class="col-month"><col class="col-month"><col class="col-month">
                <col class="col-sum"><col class="col-mgr"><col class="col-note">
            </colgroup>
            <thead>
                <tr>
                    <th rowspan="2">프로세스명</th>
                    <th rowspan="2">순</th>
                    <th rowspan="2">성과지표</th>
                    <th rowspan="2">단위</th>
                    <th rowspan="2">구분</th>
                    <th colspan="12">월별 실적분석</th>
                    <th rowspan="2">합계/<br>평균</th>
                    <th rowspan="2">담당자</th>
                    <th rowspan="2">비고</th>
                </tr>
                <tr>
                    <th>1月</th><th>2月</th><th>3月</th><th>4月</th><th>5月</th><th>6月</th>
                    <th>7月</th><th>8月</th><th>9月</th><th>10月</th><th>11月</th><th>12月</th>
                </tr>
            </thead>
            <tbody id="kpiBody">
                <tr><td colspan="19" class="kpi-loading">조회 버튼을 눌러 데이터를 불러오세요.</td></tr>
            </tbody>
        </table>
    </div>
</main>

<!-- 항목 추가/수정 모달 -->
<div class="kpi-modal-overlay" id="itemModalOverlay">
    <div class="kpi-modal-box">
        <div class="kpi-modal-header" id="itemModalTitle">항목 추가</div>
        <div class="kpi-modal-body">
            <div id="itemProcessField">
                <label>프로세스명(대분류) *</label>
                <input type="text" id="itemProcessName" list="processNameList" placeholder="기존 선택 또는 새로 입력">
                <datalist id="processNameList"></datalist>
            </div>
            <div>
                <label>성과지표명 *</label>
                <input type="text" id="itemKpiName" placeholder="예) 설비가동율">
            </div>
            <div>
                <label>단위</label>
                <input type="text" id="itemUnit" placeholder="예) %, 건수, 천원">
            </div>
            <div>
                <label>합계/평균 계산 방식 *</label>
                <select id="itemAggType">
                    <option value="SUM">합계 (SUM) - 건수/금액형</option>
                    <option value="AVG">평균 (AVG) - %/비율형</option>
                </select>
            </div>
        </div>
        <div class="kpi-modal-footer">
            <button class="btn-del" id="itemDelBtn" style="display:none">삭제</button>
            <button id="itemCancelBtn">취소</button>
            <button class="btn-save" id="itemSaveBtn">저장</button>
        </div>
    </div>
</div>

<script>
let now_page_code = "f07";
var base = '/tkheat';
var curYear = null;
var kpiData = [];

$(function(){
    if (typeof userInfoList === 'function') {
        userInfoList(now_page_code);
    }
    loadYearList();
});

function loadYearList(){
    $.ajax({
        url: base + '/quality/kpiStatus/getYearList',
        type:'post', dataType:'json',
        success:function(result){
            var years = result.data || [];
            var thisYear = new Date().getFullYear();
            if (years.indexOf(thisYear) === -1) years.unshift(thisYear);
            years.sort(function(a,b){ return b-a; });
            $('#yearSelect').html(years.map(function(y){ return '<option value="'+y+'">'+y+'년</option>'; }).join(''));
            //진입/새로고침 때마다 매번 "실제 현재 연도"를 기본으로 보여줌(DB에 가장 최근 연도가
            //아니라, 달력상 지금 연도를 기준으로). 혹시 브라우저가 새로고침 시 전에 선택했던
            //값을 셀렉트박스에 그대로 복원해버리는 경우까지 대비해 명시적으로 다시 지정함
            curYear = thisYear;
            $('#yearSelect').val(curYear);
            loadKpiList();
        }
    });
}

$('#yearSelect').on('change', function(){
    curYear = parseInt($(this).val());
    loadKpiList();
});
$('#btnReload').on('click', function(){
    curYear = parseInt($('#yearSelect').val());
    loadKpiList();
});
$('#btnAddYear').on('click', function(){
    var y = parseInt($('#newYearInput').val());
    if (!y || y < 2000 || y > 2100) { alert('연도를 올바르게 입력하세요.'); return; }
    if ($('#yearSelect option[value="'+y+'"]').length === 0) {
        $('#yearSelect').append('<option value="'+y+'">'+y+'년</option>');
    }
    $('#yearSelect').val(y);
    curYear = y;
    loadKpiList();
});

function loadKpiList(){
    $('#kpiBody').html('<tr><td colspan="19" class="kpi-loading">조회 중...</td></tr>');
    $.ajax({
        url: base + '/quality/kpiStatus/getKpiList',
        type:'post', dataType:'json',
        data:{ year: curYear },
        success:function(result){
            kpiData = result.data || [];
            renderTable();
        },
        error:function(){
            $('#kpiBody').html('<tr><td colspan="19" class="kpi-loading" style="color:#C53030">조회 실패</td></tr>');
        }
    });
}

//셀 하나 저장한 직후에는 연도 변경/조회버튼 때와 달리 "조회 중" 문구로 표 전체를 비웠다가
//다시 그리면 클릭할 때마다 화면이 깜빡이는 느낌이 들어서, 표를 비우지 않고 조용히 최신 데이터만
//다시 받아와서 다시 그리기만 함
function refreshKpiListSilently(){
    $.ajax({
        url: base + '/quality/kpiStatus/getKpiList',
        type:'post', dataType:'json',
        data:{ year: curYear },
        success:function(result){
            kpiData = result.data || [];
            renderTable();
        },
        error:function(){
            $('#kpiBody').html('<tr><td colspan="19" class="kpi-loading" style="color:#C53030">조회 실패</td></tr>');
        }
    });
}

var MONTH_KEYS = [1,2,3,4,5,6,7,8,9,10,11,12];

function monthVals(item, prefix){
    return MONTH_KEYS.map(function(m){ return item[prefix+'_m'+m]; });
}

function aggregate(vals, aggType){
    var nums = vals.filter(function(v){ return v !== null && v !== undefined; });
    if (!nums.length) return null;
    var sum = nums.reduce(function(a,b){ return a+b; }, 0);
    return aggType === 'AVG' ? (sum/nums.length) : sum;
}

function fmtNum(v){
    if (v === null || v === undefined || isNaN(v)) return '';
    var r = Math.round(v*100)/100;
    return String(r);
}

function renderTable(){
    var html = '';
    var i = 0;
    while (i < kpiData.length) {
        var proc = kpiData[i].process_name;
        var groupItems = [];
        while (i < kpiData.length && kpiData[i].process_name === proc) {
            groupItems.push(kpiData[i]); i++;
        }
        var groupRowSpan = groupItems.length * 3;
        groupItems.forEach(function(item, gi){
            html += renderItemRows(item, gi === 0 ? proc : null, gi === 0 ? groupRowSpan : 0);
        });
    }
    $('#kpiBody').html(html || '<tr><td colspan="19" class="kpi-loading">데이터가 없습니다.</td></tr>');
}

function renderItemRows(item, procLabel, procRowSpan){
    var planVals = monthVals(item, 'plan');
    var actualVals = monthVals(item, 'actual');
    var planAgg = aggregate(planVals, item.agg_type);
    var actualAgg = aggregate(actualVals, item.agg_type);
    var pctAgg = (planAgg && actualAgg !== null) ? (actualAgg/planAgg) : null;

    var s = '';

    // 계획 행
    s += '<tr class="row-plan" data-seq="'+item.kpi_seq+'">';
    if (procLabel !== null) s += '<td class="proc-cell" rowspan="'+procRowSpan+'">'+esc(procLabel)+'</td>';
    s += '<td rowspan="3">'+item.item_no+'</td>';
    s += '<td rowspan="3" style="text-align:left" class="kpi-item-cell" data-seq="'+item.kpi_seq+'">'+esc(item.kpi_name)+'</td>';
    s += '<td rowspan="3">'+esc(item.unit)+'</td>';
    s += '<td class="gubn-lbl">계획</td>';
    planVals.forEach(function(v, idx){
        s += editableMonthCell(item.kpi_seq, 'PLAN', idx+1, v);
    });
    s += '<td>'+fmtNum(planAgg)+'</td>';
    s += '<td class="mgr-cell editable-cell" data-field="manager_name" data-seq="'+item.kpi_seq+'" rowspan="3">'+esc(item.manager_name||'')+'</td>';
    s += '<td class="note-cell editable-cell" data-field="note" data-seq="'+item.kpi_seq+'" rowspan="3">'+esc(item.note||'')+'</td>';
    s += '</tr>';

    // 실적 행
    s += '<tr class="row-actual" data-seq="'+item.kpi_seq+'">';
    s += '<td class="gubn-lbl">실적</td>';
    actualVals.forEach(function(v, idx){
        s += editableMonthCell(item.kpi_seq, 'ACTUAL', idx+1, v);
    });
    s += '<td>'+fmtNum(actualAgg)+'</td>';
    s += '</tr>';

    // % 행 (자동계산, 읽기전용)
    s += '<tr class="row-pct" data-seq="'+item.kpi_seq+'">';
    s += '<td class="gubn-lbl">%</td>';
    for (var m = 0; m < 12; m++) {
        var p = planVals[m], a = actualVals[m];
        var pct = (p !== null && p !== undefined && p !== 0 && a !== null && a !== undefined) ? (a/p) : null;
        s += '<td class="'+pctClass(pct)+'">'+fmtPct(pct)+'</td>';
    }
    s += '<td class="'+pctClass(pctAgg)+'">'+fmtPct(pctAgg)+'</td>';
    s += '</tr>';

    return s;
}

function editableMonthCell(seq, rowType, month, val){
    return '<td class="editable-cell" data-seq="'+seq+'" data-rowtype="'+rowType+'" data-month="'+month+'">'+fmtNum(val)+'</td>';
}

function pctClass(pct){
    if (pct === null || pct === undefined) return '';
    return pct >= 1 ? 'pct-good' : 'pct-bad';
}
function fmtPct(pct){
    if (pct === null || pct === undefined) return '';
    return (Math.round(pct*1000)/10) + '%';
}

function esc(s){ return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }

/* ── 셀 클릭 → 인라인 수정 ── */
$('#kpiBody').on('click', '.editable-cell', function(){
    var $cell = $(this);
    if ($cell.hasClass('editing')) return;

    var permission = (typeof userPermissions !== 'undefined') ? userPermissions[now_page_code] : null;
    if (!['I','U'].includes(permission)) { alert('수정 권한이 없습니다.'); return; }

    var isMonth = $cell.data('rowtype') !== undefined;
    var curVal = $cell.text();
    $cell.addClass('editing');
    var inputType = isMonth ? 'number' : 'text';
    $cell.html('<input type="'+inputType+'" value="'+esc(curVal)+'">');
    var $input = $cell.find('input');
    $input.focus().select();

    function commit(){
        var newVal = $input.val();
        if (isMonth) {
            saveDataCell($cell, newVal);
        } else {
            saveMetaField($cell, newVal);
        }
    }
    $input.on('blur', commit);
    $input.on('keydown', function(e){
        if (e.key === 'Enter') { $input.blur(); }
        else if (e.key === 'Escape') { $cell.removeClass('editing'); renderTable(); }
    });
});

function saveDataCell($cell, newVal){
    var seq = $cell.data('seq');
    var rowType = $cell.data('rowtype');
    var month = $cell.data('month');
    var value = (newVal === '' || newVal === null) ? null : parseFloat(newVal);

    $.ajax({
        url: base + '/quality/kpiStatus/saveDataCell',
        type:'post', dataType:'json',
        data:{ kpi_seq: seq, year: curYear, row_type: rowType, month: month, value: value },
        success:function(result){
            if (result.status !== 'success') { alert(result.message || '저장 실패'); }
            refreshKpiListSilently();
        },
        error:function(){ alert('저장 실패'); refreshKpiListSilently(); }
    });
}

function saveMetaField($cell, newVal){
    var seq = $cell.data('seq');
    var item = kpiData.find(function(d){ return d.kpi_seq === seq; });
    var field = $cell.data('field');
    var manager = field === 'manager_name' ? newVal : (item ? item.manager_name : '');
    var note = field === 'note' ? newVal : (item ? item.note : '');

    $.ajax({
        url: base + '/quality/kpiStatus/saveMeta',
        type:'post', dataType:'json',
        data:{ kpi_seq: seq, year: curYear, manager_name: manager, note: note },
        success:function(result){
            if (result.status !== 'success') { alert(result.message || '저장 실패'); }
            refreshKpiListSilently();
        },
        error:function(){ alert('저장 실패'); refreshKpiListSilently(); }
    });
}

/* ══════════════════════════════════════════
   항목(프로세스명/성과지표) 추가 · 수정 · 삭제
══════════════════════════════════════════ */
var itemModalMode = 'add'; // 'add' or 'edit'
var itemModalSeq = null;

function loadProcessList(){
    $.ajax({
        url: base + '/quality/kpiStatus/getProcessList',
        type:'post', dataType:'json',
        success:function(result){
            var procs = result.data || [];
            $('#processNameList').html(procs.map(function(p){ return '<option value="'+esc(p)+'">'; }).join(''));
        }
    });
}

function openAddItemModal(){
    itemModalMode = 'add';
    itemModalSeq = null;
    $('#itemModalTitle').text('항목 추가');
    $('#itemProcessField').show();
    $('#itemProcessName').val('').prop('disabled', false);
    $('#itemKpiName').val('');
    $('#itemUnit').val('');
    $('#itemAggType').val('SUM');
    $('#itemDelBtn').hide();
    loadProcessList();
    $('#itemModalOverlay').addClass('active');
}

function openEditItemModal(seq){
    var item = kpiData.find(function(d){ return d.kpi_seq === seq; });
    if (!item) return;
    itemModalMode = 'edit';
    itemModalSeq = seq;
    $('#itemModalTitle').text('항목 수정 ('+item.process_name+')');
    $('#itemProcessField').hide(); // 소속 프로세스(대분류) 변경은 이 화면에서는 지원하지 않음
    $('#itemKpiName').val(item.kpi_name);
    $('#itemUnit').val(item.unit);
    $('#itemAggType').val(item.agg_type);
    $('#itemDelBtn').show();
    $('#itemModalOverlay').addClass('active');
}

function closeItemModal(){
    $('#itemModalOverlay').removeClass('active');
}

$('#btnAddKpiItem').on('click', function(){
    var permission = (typeof userPermissions !== 'undefined') ? userPermissions[now_page_code] : null;
    if (!['I','U'].includes(permission)) { alert('등록 권한이 없습니다.'); return; }
    openAddItemModal();
});

$('#kpiBody').on('dblclick', '.kpi-item-cell', function(){
    var permission = (typeof userPermissions !== 'undefined') ? userPermissions[now_page_code] : null;
    if (!['I','U'].includes(permission)) { alert('수정 권한이 없습니다.'); return; }
    openEditItemModal($(this).data('seq'));
});

$('#itemCancelBtn').on('click', closeItemModal);
$('#itemModalOverlay').on('click', function(e){ if (e.target === this) closeItemModal(); });

$('#itemSaveBtn').on('click', function(){
    var kpiName = $('#itemKpiName').val().trim();
    var unit = $('#itemUnit').val().trim();
    var aggType = $('#itemAggType').val();
    if (!kpiName) { alert('성과지표명을 입력하세요.'); return; }

    if (itemModalMode === 'add') {
        var processName = $('#itemProcessName').val().trim();
        if (!processName) { alert('프로세스명을 입력하세요.'); return; }
        $.ajax({
            url: base + '/quality/kpiStatus/addItem',
            type:'post', dataType:'json',
            data:{ process_name: processName, kpi_name: kpiName, unit: unit, agg_type: aggType },
            success:function(result){
                if (result.status !== 'success') { alert(result.message || '추가 실패'); return; }
                closeItemModal();
                loadKpiList();
            },
            error:function(){ alert('추가 실패'); }
        });
    } else {
        $.ajax({
            url: base + '/quality/kpiStatus/updateItem',
            type:'post', dataType:'json',
            data:{ kpi_seq: itemModalSeq, kpi_name: kpiName, unit: unit, agg_type: aggType },
            success:function(result){
                if (result.status !== 'success') { alert(result.message || '수정 실패'); return; }
                closeItemModal();
                loadKpiList();
            },
            error:function(){ alert('수정 실패'); }
        });
    }
});

$('#itemDelBtn').on('click', function(){
    var permission = (typeof userPermissions !== 'undefined') ? userPermissions[now_page_code] : null;
    if (permission !== 'U') { alert('삭제 권한이 없습니다.'); return; }
    if (!itemModalSeq) return;
    if (!confirm('이 항목을 삭제하시겠습니까?\n모든 연도의 계획/실적/담당자 데이터가 함께 삭제됩니다.')) return;

    $.ajax({
        url: base + '/quality/kpiStatus/deleteItem',
        type:'post', dataType:'json',
        data:{ kpi_seq: itemModalSeq },
        success:function(result){
            if (result.status !== 'success') { alert(result.message || '삭제 실패'); return; }
            closeItemModal();
            loadKpiList();
        },
        error:function(){ alert('삭제 실패'); }
    });
});
</script>
</body>
</html>
