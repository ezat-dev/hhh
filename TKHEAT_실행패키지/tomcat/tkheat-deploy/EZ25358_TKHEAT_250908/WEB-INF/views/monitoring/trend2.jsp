<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>통합 트렌드(V2)</title>
<%@include file="../include/pluginpage.jsp" %>
<style>
:root {
  --primary: #123478; --primary-l: #eef3fb; --primary-m: rgba(18,52,120,.30);
  --green: #38A169; --red: #E53E3E; --orange: #DD6B20;
  --white: #ffffff; --border: #e5e7eb; --text: #1f2937; --muted: #6b7280;
  --shadow: 0 1px 3px rgba(0,0,0,.08), 0 1px 2px rgba(0,0,0,.06);
  --shadow-md: 0 6px 18px rgba(0,0,0,.14);
}
html, body { height: 100%; margin: 0; overflow: hidden; background: #eef1f6; }
* { box-sizing: border-box; }
body { font-family: Pretendard,'Malgun Gothic','Noto Sans KR','Segoe UI',sans-serif; }

.trend-wrap {
  height: 100vh; padding: 14px 16px; display: flex; flex-direction: column; overflow: hidden;
}
.trend-title { font-size: 16px; font-weight: 800; color: var(--text); margin: 0 0 10px 2px; flex-shrink: 0; }

.trend-layout {
  display: grid; grid-template-columns: 220px 1fr; gap: 14px;
  align-items: stretch; flex: 1; min-height: 0; overflow: hidden;
}
.trend-layout > * { min-height: 0; }
@media(max-width:900px){ .trend-layout { grid-template-columns:1fr; } }

/* KPI 카드 */
.kpi-cards { display: grid; grid-template-columns: repeat(auto-fill, minmax(150px,1fr)); gap: 10px; }
.kpi-card {
  background: var(--white); border: 1px solid var(--border); border-radius: 8px; padding: 6px 10px;
  box-shadow: var(--shadow); border-top: 3px solid var(--primary); transition: box-shadow .13s;
}
.kpi-card:hover { box-shadow: var(--shadow-md); }
.kpi-card-lbl { font-size: 11px; color: var(--muted); font-weight: 700; margin-bottom: 2px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.kpi-card-val { font-size: 18px; font-weight: 800; color: var(--text); font-family: 'Segoe UI',monospace; line-height: 1.15; }
.kpi-card-sub { font-size: 10px; color: var(--muted); margin-top: 2px; display: flex; gap: 6px; }
.kpi-sub-mn { color: var(--primary); } .kpi-sub-mx { color: var(--red); }

/* 좌측 태그 패널 */
.tag-panel { display: flex; flex-direction: column; min-height: 0; overflow: hidden; }
.tag-card {
  background: var(--white); border: 1px solid var(--border); border-radius: 10px; box-shadow: var(--shadow);
  padding: 12px 10px; flex: 1; display: flex; flex-direction: column; overflow: hidden; min-height: 0;
}
.tag-group-btns { display: flex; gap: 5px; margin-bottom: 8px; flex-shrink: 0; }
.tag-group-btn {
  flex: 1; padding: 6px 0; border-radius: 6px; border: 1px solid var(--border); background: var(--white);
  font-size: 11px; font-weight: 700; cursor: pointer; color: var(--muted); transition: all .13s;
}
.tag-group-btn:hover { border-color: var(--primary-m); color: var(--primary); }
.tag-group-btn.active { background: var(--primary); color: #fff; border-color: var(--primary); }

.sp-toggle-row {
  display: flex; align-items: center; justify-content: space-between; gap: 6px;
  padding: 7px 9px; margin-bottom: 8px; border-radius: 7px; flex-shrink: 0;
  background: rgba(128,90,213,.06); border: 1px solid rgba(128,90,213,.2);
}
.sp-toggle-lbl { font-size: 11px; font-weight: 700; color: #553C9A; }
.sp-switch { position: relative; width: 34px; height: 18px; flex-shrink: 0; cursor: pointer; }
.sp-switch input { opacity: 0; width: 0; height: 0; }
.sp-switch-track { position: absolute; inset: 0; background: #cbd5e1; border-radius: 20px; transition: .15s; }
.sp-switch-track::before { content:''; position:absolute; width:14px; height:14px; left:2px; top:2px; background:#fff; border-radius:50%; transition:.15s; box-shadow:0 1px 2px rgba(0,0,0,.3); }
.sp-switch input:checked + .sp-switch-track { background: #805AD5; }
.sp-switch input:checked + .sp-switch-track::before { transform: translateX(16px); }

.tag-search {
  width: 100%; padding: 7px 10px; border: 1px solid var(--border); border-radius: 7px;
  font-size: 12px; outline: none; transition: border-color .13s; flex-shrink: 0; font-family: inherit;
}
.tag-search:focus { border-color: var(--primary); }
.tag-sel-btns { display: flex; gap: 6px; margin: 8px 0; flex-shrink: 0; }
.tag-sel-btns button {
  flex: 1; padding: 5px 0; font-size: 11px; font-weight: 700; border-radius: 6px;
  border: 1px solid var(--border); background: var(--white); color: var(--muted); cursor: pointer;
}
.tag-sel-btns button:hover { border-color: var(--primary-m); color: var(--primary); background: var(--primary-l); }

.tag-list { display: flex; flex-direction: column; gap: 4px; flex: 1; overflow-y: auto; }
.tag-list::-webkit-scrollbar { width: 4px; }
.tag-list::-webkit-scrollbar-thumb { background: var(--border); border-radius: 4px; }
.tag-item {
  display: flex; align-items: center; gap: 8px; padding: 7px 9px; border-radius: 8px;
  border: 1px solid var(--border); background: var(--white); cursor: pointer; transition: all .13s;
  font-size: 12px; user-select: none;
}
.tag-item:hover { border-color: var(--primary-m); background: var(--primary-l); }
.tag-item.sel { border-color: var(--primary); background: var(--primary-l); box-shadow: 0 0 0 2px var(--primary-m); }
.tag-dot { width: 9px; height: 9px; border-radius: 50%; flex-shrink: 0; }
.tag-item-name { font-weight: 700; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.tag-item-sub { font-size: 10px; color: var(--muted); }

/* 우측 차트 패널 */
.chart-panel { display: flex; flex-direction: column; gap: 8px; min-height: 0; overflow: hidden; }

.toolbar-box {
  background: var(--white); border: 1px solid var(--border); border-radius: 10px; padding: 7px 12px;
  box-shadow: var(--shadow); display: flex; flex-wrap: wrap; align-items: center; gap: 6px; flex-shrink: 0;
}
.period-btn {
  padding: 5px 12px; border-radius: 20px; border: 1px solid var(--border); background: var(--white);
  font-size: 12px; font-weight: 700; cursor: pointer; transition: all .13s; white-space: nowrap; color: var(--text);
}
.period-btn.active { background: var(--primary); color: #fff; border-color: var(--primary); }
.tb-sep { width: 1px; height: 20px; background: var(--border); margin: 0 2px; }
.dt-input { padding: 5px 8px; border: 1px solid var(--border); border-radius: 6px; font-size: 11px; color: var(--text); outline: none; font-family: inherit; }
.dt-input:focus { border-color: var(--primary); }
.tb-label { font-size: 11px; color: var(--muted); font-weight: 700; }
.tb-btn {
  padding: 6px 13px; border-radius: 7px; border: none; background: var(--primary); color: #fff;
  font-size: 12px; font-weight: 700; cursor: pointer;
}
.tb-btn:hover { background: #1b4fb0; }
.tb-btn-outline {
  padding: 6px 12px; border-radius: 7px; border: 1px solid var(--border); background: var(--white);
  color: var(--text); font-size: 12px; font-weight: 700; cursor: pointer;
}
.tb-btn-outline:hover { background: #f3f4f6; }

.live-badge {
  display: inline-flex; align-items: center; gap: 6px; padding: 4px 10px; border-radius: 20px;
  border: 1px solid rgba(56,161,105,.5); background: rgba(56,161,105,.08); font-size: 11px; font-weight: 800; color: var(--green);
}
.live-dot { width: 7px; height: 7px; border-radius: 50%; background: var(--green); animation: live-pulse 1.4s ease-in-out infinite; }
@keyframes live-pulse { 0%,100%{ opacity:1; box-shadow:0 0 6px var(--green); } 50%{ opacity:.3; box-shadow:none; } }

.chart-box {
  background: #141c2e; border: 1px solid #1e2d4a; border-radius: 12px; padding: 12px 14px;
  box-shadow: 0 4px 20px rgba(0,0,0,.4); position: relative; flex: 1; display: flex; flex-direction: column;
  min-height: 0; overflow: hidden;
}
#mainChart { flex: 1; min-height: 0; }
.chart-topbar { display:flex; align-items:center; justify-content:flex-end; gap:8px; margin-bottom:6px; flex-shrink:0; }
.alt-hint { font-size: 10px; color: #5a6a8a; padding: 2px 8px; border: 1px dashed #2d3d5a; border-radius: 4px; }
.btn-zoom-reset {
  padding: 4px 10px; border-radius: 6px; border: 1px solid #2d3d5a; background: #1e2d45; font-size: 11px;
  color: #8899bb; cursor: pointer; transition: all .13s; display: none;
}
.btn-zoom-reset:hover { border-color: #60A5FA; color: #60A5FA; }
.btn-zoom-reset.visible { display: inline-block; }

.refresh-bar { position: absolute; bottom: 0; left: 0; right: 0; height: 3px; background: #1e2d45; border-radius: 0 0 12px 12px; overflow: hidden; }
.refresh-bar-inner { height: 100%; width: 0%; background: var(--primary); transition: width .1s linear; }

.avg-overlay { position: absolute; background: rgba(49,130,206,.12); border: 1px solid rgba(49,130,206,.4); pointer-events: none; z-index: 10; }
.avg-tooltip {
  position: absolute; background: var(--white); border: 1px solid var(--border); border-radius: 8px;
  padding: 8px 12px; box-shadow: var(--shadow-md); font-size: 11px; z-index: 20; pointer-events: auto;
  min-width: 190px; top: 4px; right: 4px;
}
.avg-tooltip-row { display:flex; align-items:center; gap:6px; padding:2px 0; }

.no-data-msg { text-align:center; padding:80px 0; color:#8899bb; font-size:13px; }
</style>
</head>
<body>
  <div class="trend-wrap">
    <div class="trend-title">통합 트렌드(V2) - 열처리 설비 온도/CP</div>

    <div id="kpiWrap" style="flex-shrink:0;display:none;margin-bottom:10px">
      <div class="kpi-cards" id="kpiCards"></div>
    </div>

    <div class="trend-layout">

      <!-- 좌측 태그 패널 -->
      <div class="tag-panel">
        <div class="tag-card">
          <div class="tag-group-btns">
            <button class="tag-group-btn active" onclick="setGroup('all',this)">전체</button>
            <button class="tag-group-btn" onclick="setGroup('temp',this)">온도</button>
            <button class="tag-group-btn" onclick="setGroup('cp',this)">CP</button>
          </div>
          <label class="sp-toggle-row" for="spSwitch">
            <span class="sp-toggle-lbl">SV(설정값) 겹쳐보기</span>
            <span class="sp-switch">
              <input type="checkbox" id="spSwitch" onchange="toggleSp(this.checked)">
              <span class="sp-switch-track"></span>
            </span>
          </label>
          <input class="tag-search" id="tagSearch" placeholder="태그 검색..." oninput="renderTagList()">
          <div class="tag-sel-btns">
            <button onclick="selectAll(true)">전체 선택</button>
            <button onclick="selectAll(false)">전체 해제</button>
          </div>
          <div class="tag-list" id="tagList"></div>
        </div>
      </div>

      <!-- 우측 차트 패널 -->
      <div class="chart-panel">
        <div class="toolbar-box">
          <button class="period-btn" onclick="setPeriod('1h',this)">1시간</button>
          <button class="period-btn" onclick="setPeriod('6h',this)">6시간</button>
          <button class="period-btn active" onclick="setPeriod('24h',this)">24시간</button>
          <button class="period-btn" onclick="setPeriod('3d',this)">3일</button>
          <button class="period-btn" onclick="setPeriod('7d',this)">7일</button>
          <div class="tb-sep"></div>
          <span class="tb-label">FROM</span>
          <input class="dt-input" type="datetime-local" id="fromTime">
          <span class="tb-label">TO</span>
          <input class="dt-input" type="datetime-local" id="toTime">
          <button class="tb-btn" onclick="applyCustomRange()">적용</button>
          <div class="tb-sep"></div>
          <span class="live-badge" id="liveBadge">
            <span class="live-dot"></span> LIVE
            <svg id="liveGauge" width="22" height="22" style="transform:rotate(-90deg)">
              <circle cx="11" cy="11" r="8" fill="none" stroke="rgba(56,161,105,.2)" stroke-width="2.5"/>
              <circle id="liveArc" cx="11" cy="11" r="8" fill="none" stroke="#38A169" stroke-width="2.5"
                stroke-dasharray="50.3" stroke-dashoffset="0" stroke-linecap="round"
                style="transition:stroke-dashoffset .9s linear"/>
            </svg>
          </span>
          <button class="tb-btn-outline" onclick="reloadChart()">&#8635; 갱신</button>
          <button class="tb-btn-outline" onclick="saveChartPng()" style="border-color:rgba(59,130,246,.5);color:#1D4ED8">&#128247; 캡쳐</button>
          <button class="tb-btn-outline" onclick="saveChartXls()" style="border-color:rgba(34,197,94,.5);color:#166534">&#128202; 엑셀</button>
          <button id="kpiToggleBtn" class="tb-btn-outline" onclick="toggleKpi()" style="margin-left:auto">&#9660; KPI 펼치기</button>
        </div>

        <div class="chart-box" id="mainChartBox">
          <div class="chart-topbar">
            <span class="alt-hint">Alt+드래그 → 구간 평균</span>
            <button class="btn-zoom-reset" id="btnZoomReset" onclick="resetZoom()">줌 초기화</button>
          </div>
          <div id="mainChart" style="flex:1;min-height:200px"></div>
          <div class="refresh-bar"><div class="refresh-bar-inner" id="refreshBar"></div></div>
        </div>
      </div>

    </div>
  </div>

<script>
let now_page_code = "d06";
var base = '/tkheat';

/* ── 태그 메타 (tb_temp 테이블, 기존 통합트렌드와 동일한 컬럼 그대로 사용) ── */
var TAG_DEFS = [
  { key:'bcf1_cf_pv',  label:'1호기 로내온도', group:'temp', color:'#F87171' },
  { key:'bcf1_oil_pv', label:'1호기 유조온도', group:'temp', color:'#FCA5A5' },
  { key:'bcf2_cf_pv',  label:'2호기 로내온도', group:'temp', color:'#FB923C' },
  { key:'bcf2_oil_pv', label:'2호기 유조온도', group:'temp', color:'#FDBA74' },
  { key:'bcf3_cf_pv',  label:'3호기 로내온도', group:'temp', color:'#FBBF24' },
  { key:'bcf3_oil_pv', label:'3호기 유조온도', group:'temp', color:'#FDE68A' },
  { key:'bcf4_cf_pv',  label:'4호기 로내온도', group:'temp', color:'#A3E635' },
  { key:'bcf4_oil_pv', label:'4호기 유조온도', group:'temp', color:'#BEF264' },
  { key:'bcf5_cf_pv',  label:'5호기 로내온도', group:'temp', color:'#22D3EE' },
  { key:'bcf5_oil_pv', label:'5호기 유조온도', group:'temp', color:'#67E8F9' },
  { key:'tf1_zone1',   label:'템퍼링 1존',     group:'temp', color:'#A78BFA' },
  { key:'tf1_zone2',   label:'템퍼링 2존',     group:'temp', color:'#C4B5FD' },
  { key:'tf1_zone3',   label:'템퍼링 3존',     group:'temp', color:'#DDD6FE' },
  { key:'bcf1_cp_pv',  label:'1호기 CP',       group:'cp',   color:'#4ADE80' },
  { key:'bcf2_cp_pv',  label:'2호기 CP',       group:'cp',   color:'#34D399' },
  { key:'bcf3_cp_pv',  label:'3호기 CP',       group:'cp',   color:'#2DD4BF' },
  { key:'bcf4_cp_pv',  label:'4호기 CP',       group:'cp',   color:'#60A5FA' },
  { key:'bcf5_cp_pv',  label:'5호기 CP',       group:'cp',   color:'#818CF8' }
];
var TAG_MAP = {};
TAG_DEFS.forEach(function(t){ TAG_MAP[t.key] = t; });

var selTags   = {};
var curGroup  = 'all';
var showSp    = false;
var curPeriod = '24h';
var isCustom  = false;
var mainChart = null;
var countdown = 15;
var countTimer = null;
var curData   = null;   // 마지막 조회 결과(태그별 재가공된 오브젝트)
var curFrom   = '', curTo = '';

var PERIOD_MS = {'1h':3600000,'6h':21600000,'24h':86400000,'3d':259200000,'7d':604800000};

TAG_DEFS.forEach(function(t){ selTags[t.key] = true; });

Highcharts.setOptions({
  lang: {
    months:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    shortMonths:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    weekdays:['일','월','화','수','목','금','토']
  },
  global: { useUTC: false }
});

function esc(s){ return String(s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }
//TKHEAT 컬럼명은 snake_case(xxx_pv/xxx_sv) 이므로 끝의 _pv만 _sv로 치환
function spKey(pvKey){ return pvKey.replace(/_pv$/, '_sv'); }
function pad(n){ return String(n).padStart(2,'0'); }
function toDateTimeLocalParam(dt) {
  //기존 /monitoring/trend/trendList 가 받는 형식: "yyyy-MM-dd HH:mm"
  return dt.getFullYear()+'-'+pad(dt.getMonth()+1)+'-'+pad(dt.getDate())
       +' '+pad(dt.getHours())+':'+pad(dt.getMinutes());
}
function toLocalInput(dt) {
  return dt.getFullYear()+'-'+pad(dt.getMonth()+1)+'-'+pad(dt.getDate())
       +'T'+pad(dt.getHours())+':'+pad(dt.getMinutes());
}
/* 서버가 내려주는 "yyyy-MM-dd HH:mm:ss" 형태를 로컬시간 타임스탬프로 변환 */
function parseTs(v) {
  if (!v) return null;
  var s = String(v).replace(' ', 'T').replace(/\.\d+$/, '');
  var t = Date.parse(s);
  return isNaN(t) ? null : t;
}

/* ── 초기 범위 세팅 ── */
function initRange() {
  var now  = new Date();
  var from = new Date(now.getTime() - PERIOD_MS[curPeriod]);
  document.getElementById('fromTime').value = toLocalInput(from);
  document.getElementById('toTime').value   = toLocalInput(now);
}

/* ── 실시간 카운트다운(원형 게이지) ── */
var CIRC = 2 * Math.PI * 8;
function setGaugeOffset(pct) {
  var arc = document.getElementById('liveArc');
  if (arc) arc.style.strokeDashoffset = (CIRC * (1 - pct)).toFixed(2);
}
function startCountdown() {
  if (countTimer) clearInterval(countTimer);
  countdown = 15;
  setGaugeOffset(1);
  countTimer = setInterval(function() {
    countdown--;
    setGaugeOffset(countdown / 15);
    if (countdown <= 0) {
      countdown = 15;
      setGaugeOffset(1);
      if (!isCustom) reloadChart();
    }
  }, 1000);
}
document.getElementById('liveBadge').style.display = '';

/* ── refresh bar 애니메이션 ── */
var rafId = null;
function animateRefreshBar(ms) {
  var bar = document.getElementById('refreshBar');
  var start = null;
  if (rafId) cancelAnimationFrame(rafId);
  function step(ts) {
    if (!start) start = ts;
    var pct = Math.min((ts - start) / ms * 100, 100);
    bar.style.width = pct + '%';
    if (pct < 100) rafId = requestAnimationFrame(step);
  }
  bar.style.width = '0%';
  rafId = requestAnimationFrame(step);
}

/* ── 태그 그룹 필터 ── */
function setGroup(g, btn) {
  curGroup = g;
  document.querySelectorAll('.tag-group-btn').forEach(function(b){ b.classList.remove('active'); });
  if (btn) btn.classList.add('active');
  renderTagList();
}

/* ── SV 겹쳐보기 토글 ── */
function toggleSp(v) { showSp = v; buildKpiCards(); buildMainChart(); }

/* ── 태그 목록 렌더 ── */
function renderTagList() {
  var q = (document.getElementById('tagSearch').value || '').toLowerCase();
  var html = '';
  TAG_DEFS.forEach(function(t) {
    if (curGroup !== 'all' && t.group !== curGroup) return;
    if (q && t.label.toLowerCase().indexOf(q) === -1 && t.key.toLowerCase().indexOf(q) === -1) return;
    var isSel = selTags[t.key];
    html += '<div class="tag-item'+(isSel?' sel':'')+'" id="ti_'+t.key+'" onclick="toggleTag(\''+t.key+'\')">'
          + '<div class="tag-dot" style="background:'+t.color+'"></div>'
          + '<div style="flex:1;min-width:0">'
          + '  <div class="tag-item-name">'+esc(t.label)+'</div>'
          + '  <div class="tag-item-sub">'+t.key+(showSp ? ' + SV' : '')+'</div>'
          + '</div></div>';
  });
  document.getElementById('tagList').innerHTML = html ||
    '<div style="text-align:center;padding:14px;color:var(--muted);font-size:12px">태그 없음</div>';
}

function toggleTag(key) {
  selTags[key] = !selTags[key];
  var el = document.getElementById('ti_'+key);
  if (el) el.classList.toggle('sel', selTags[key]);
  buildKpiCards();
  buildMainChart();
}

function selectAll(v) {
  TAG_DEFS.forEach(function(t) {
    if (curGroup === 'all' || t.group === curGroup) selTags[t.key] = v;
  });
  renderTagList();
  buildKpiCards();
  buildMainChart();
}

/* ── 기간 선택 ── */
function setPeriod(p, btn) {
  curPeriod = p; isCustom = false;
  document.querySelectorAll('.period-btn').forEach(function(b){ b.classList.remove('active'); });
  if (btn) btn.classList.add('active');
  var now  = new Date();
  var from = new Date(now.getTime() - PERIOD_MS[p]);
  document.getElementById('fromTime').value = toLocalInput(from);
  document.getElementById('toTime').value   = toLocalInput(now);
  reloadChart();
}

function applyCustomRange() {
  isCustom = true;
  document.querySelectorAll('.period-btn').forEach(function(b){ b.classList.remove('active'); });
  reloadChart();
}

/* ── 데이터 조회 (기존 통합트렌드가 쓰는 tb_temp 조회 API를 그대로 재사용) ── */
function reloadChart() {
  var fv = document.getElementById('fromTime').value;
  var tv = document.getElementById('toTime').value;
  if (!fv || !tv) return;
  var fromStr = toDateTimeLocalParam(new Date(fv));
  var toStr   = toDateTimeLocalParam(new Date(tv));
  curFrom = fromStr; curTo = toStr;

  animateRefreshBar(800);

  $.ajax({
    url: base + '/monitoring/trend/trendList',
    type: 'POST',
    data: { startDate: fromStr, endDate: toStr },
    dataType: 'json',
    success: function(rows) {
      curData = reshapeRows(rows || []);
      buildKpiCards();
      buildMainChart();
      if (!isCustom) startCountdown();
    },
    error: function() {
      document.getElementById('mainChart').innerHTML = '<div class="no-data-msg" style="color:#F87171">데이터 로드 실패</div>';
    }
  });
}

/* 기존 트렌드 API는 "행 배열"(한 시각당 1행, 모든 태그가 컬럼으로 들어있음)로 내려주므로,
   이 화면에서 쓰는 "태그별 [[시각,값],...] 배열" 형태로 재가공 */
function reshapeRows(rows) {
  var data = {};
  var allKeys = TAG_DEFS.map(function(t){ return t.key; })
    .concat(TAG_DEFS.map(function(t){ return spKey(t.key); }));
  allKeys.forEach(function(k){ data[k] = { data: [] }; });

  rows.forEach(function(row) {
    var ts = parseTs(row.tdatetime);
    if (ts === null) return;
    allKeys.forEach(function(k) {
      var v = row[k];
      if (v !== null && v !== undefined) data[k].data.push([ts, v]);
    });
  });
  return data;
}

function selectedKeys() {
  return TAG_DEFS.filter(function(t){ return selTags[t.key]; }).map(function(t){ return t.key; });
}

function seriesPoints(key) {
  var s = curData && curData[key];
  if (!s || !s.data) return [];
  return s.data;
}

/* ── KPI 카드 ── */
function buildKpiCards() {
  var keys = selectedKeys();
  var html = '';
  keys.forEach(function(key) {
    renderKpiCard(key, TAG_MAP[key], false);
    if (showSp) renderKpiCard(spKey(key), TAG_MAP[key], true);
  });
  function renderKpiCard(k, meta, isSp) {
    var pts = seriesPoints(k);
    var vals = pts.map(function(p){ return p[1]; });
    var dec = meta.group === 'cp' ? 3 : 0;
    var label = meta.label + (isSp ? ' SV' : '');
    if (!vals.length) {
      html += '<div class="kpi-card" style="border-top-color:'+meta.color+'">'
            + '<div class="kpi-card-lbl" title="'+esc(label)+'">'+esc(label)+'</div>'
            + '<div class="kpi-card-val" style="color:var(--muted)">N/A</div></div>';
      return;
    }
    var last = vals[vals.length-1];
    var sum  = vals.reduce(function(a,b){return a+b;},0);
    var avg  = sum/vals.length;
    var mn   = Math.min.apply(null, vals);
    var mx   = Math.max.apply(null, vals);
    html += '<div class="kpi-card" style="border-top-color:'+meta.color+'">'
          + '<div class="kpi-card-lbl" title="'+esc(label)+'">'+esc(label)+'</div>'
          + '<div class="kpi-card-val" style="color:'+meta.color+'">'+last.toFixed(dec)+'</div>'
          + '<div class="kpi-card-sub">'
          + '  <span>avg <b>'+avg.toFixed(dec)+'</b></span>'
          + '  <span class="kpi-sub-mn">&#8595;'+mn.toFixed(dec)+'</span>'
          + '  <span class="kpi-sub-mx">&#8593;'+mx.toFixed(dec)+'</span>'
          + '</div></div>';
  }
  document.getElementById('kpiCards').innerHTML = html ||
    '<div style="color:var(--muted);font-size:12px;padding:6px">좌측에서 태그를 선택하세요</div>';
}

/* ── 메인 차트 ── */
function buildMainChart() {
  var keys = selectedKeys();
  if (!keys.length) {
    if (mainChart) { mainChart.destroy(); mainChart = null; }
    document.getElementById('mainChart').innerHTML = '<div class="no-data-msg">좌측에서 태그를 선택하세요</div>';
    return;
  }
  document.getElementById('mainChart').innerHTML = '';

  var series = [];
  keys.forEach(function(key) {
    var meta = TAG_MAP[key];
    series.push({
      name: meta.label, data: seriesPoints(key), color: meta.color, lineWidth: 2,
      yAxis: meta.group === 'cp' ? 1 : 0, dashStyle: 'Solid',
      dec: meta.group === 'cp' ? 3 : 0,
      marker: { enabled: false }, states: { hover: { lineWidth: 3 } }
    });
    if (showSp) {
      var sk = spKey(key);
      var svPts = seriesPoints(sk);
      if (svPts.length) {
        series.push({
          name: meta.label + ' SV', data: svPts, color: meta.color, lineWidth: 1.5,
          yAxis: meta.group === 'cp' ? 1 : 0, dashStyle: 'ShortDash',
          dec: meta.group === 'cp' ? 3 : 0,
          marker: { enabled: false }, opacity: 0.85, states: { hover: { lineWidth: 2.5 } }
        });
      }
    }
  });

  document.getElementById('btnZoomReset').classList.remove('visible');

  var yAxisCfg = [
    { min: 0, max: 1000, tickInterval: 100, endOnTick:false, maxPadding:0,
      title: { text: null }, gridLineColor: '#1a2840',
      labels: { format:'{value}', style:{ fontSize:'10px', color:'#8899bb' } } },
    { min: 0, max: 2, tickInterval: 0.2, endOnTick:false, maxPadding:0, opposite:true,
      title: { text: null }, gridLineColor: 'transparent',
      labels: { format:'{value:.1f}', style:{ fontSize:'10px', color:'#4ADE80' } } }
  ];

  mainChart = Highcharts.chart('mainChart', {
    chart: {
      type: 'spline', animation: false, zoomType: 'x',
      backgroundColor: '#141c2e', plotBackgroundColor: '#0e1623',
      panning: { enabled: true, type: 'x' }, panKey: 'shift',
      style: { fontFamily: "Pretendard,'Malgun Gothic',sans-serif" },
      events: { selection: function(){ document.getElementById('btnZoomReset').classList.add('visible'); } },
      resetZoomButton: { theme: { display: 'none' } }
    },
    title: { text: null },
    xAxis: {
      type: 'datetime', lineColor: '#2d3d5a', tickColor: '#2d3d5a', gridLineColor: '#1a2840',
      labels: { format: '{value:%m/%d %H:%M}', style: { fontSize:'11px', color:'#8899bb' } },
      crosshair: { color: 'rgba(96,165,250,.4)' }
    },
    yAxis: yAxisCfg,
    tooltip: {
      shared: true, backgroundColor: '#0d1628', borderColor: '#2d3d5a', borderRadius: 8,
      style: { color: '#d0ddf0' },
      formatter: function() {
        var s = '<span style="font-size:13px;color:#ffffff;font-weight:700">'
              + Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '</span><br/>';
        this.points.forEach(function(p) {
          s += '<span style="color:'+p.series.color+'">&#9679;</span> '
             + p.series.name + ': <b>' + p.y.toFixed(p.series.options.dec) + '</b><br/>';
        });
        return s;
      }
    },
    legend: { enabled: true, backgroundColor: 'transparent', itemStyle: { fontSize:'12px', fontWeight:'700', color:'#c0cde0' }, itemHoverStyle: { color:'#ffffff' } },
    plotOptions: { spline: { turboThreshold: 10000 } },
    exporting: {
      enabled: true, fallbackToExportServer: false,
      buttons: { contextButton: { menuItems: ['downloadSVG','separator','downloadCSV','downloadXLS'] } }
    },
    credits: { enabled: false },
    series: series
  });

  attachAltDragAvg();
  setTimeout(function(){ if (mainChart) mainChart.reflow(); }, 50);
}

/* ── KPI 카드 접기/펼치기 ── */
var kpiOpen = false;
function toggleKpi() {
  kpiOpen = !kpiOpen;
  document.getElementById('kpiWrap').style.display = kpiOpen ? 'block' : 'none';
  document.getElementById('kpiToggleBtn').innerHTML = kpiOpen ? '&#9650; KPI 접기' : '&#9660; KPI 펼치기';
  if (mainChart) mainChart.reflow();
}

/* ── 줌 초기화 ── */
function resetZoom() {
  if (mainChart) mainChart.zoomOut();
  document.getElementById('btnZoomReset').classList.remove('visible');
}

/* ── Alt+드래그 구간 평균 ── */
var avgOverlay = null;
var avgDrag = { active:false, x0:0, x1:0 };

function attachAltDragAvg() {
  var chartEl = document.getElementById('mainChart');
  chartEl.onmousedown = function(e) {
    if (!e.altKey) return;
    e.preventDefault(); e.stopPropagation();
    clearAvgOverlay();
    avgDrag.active = true;
    var rect = chartEl.getBoundingClientRect();
    avgDrag.x0 = e.clientX - rect.left;
    avgDrag.x1 = avgDrag.x0;
    avgOverlay = document.createElement('div');
    avgOverlay.className = 'avg-overlay';
    chartEl.style.position = 'relative';
    chartEl.appendChild(avgOverlay);
    updateAvgOverlayPos();
  };
  document.onmousemove = function(e) {
    if (!avgDrag.active) return;
    var rect = chartEl.getBoundingClientRect();
    avgDrag.x1 = e.clientX - rect.left;
    updateAvgOverlayPos();
  };
  document.onmouseup = function() {
    if (!avgDrag.active) return;
    avgDrag.active = false;
    if (!mainChart) return;
    var x0px = Math.min(avgDrag.x0, avgDrag.x1);
    var x1px = Math.max(avgDrag.x0, avgDrag.x1);
    if (x1px - x0px < 5) { clearAvgOverlay(); return; }
    var t0 = mainChart.xAxis[0].toValue(x0px - mainChart.plotLeft);
    var t1 = mainChart.xAxis[0].toValue(x1px - mainChart.plotLeft);
    showAvgResult(t0, t1);
  };
}

function updateAvgOverlayPos() {
  if (!avgOverlay || !mainChart) return;
  var pt = mainChart.plotTop, ph = mainChart.plotHeight;
  var x0 = Math.min(avgDrag.x0, avgDrag.x1);
  var x1 = Math.max(avgDrag.x0, avgDrag.x1);
  avgOverlay.style.cssText = 'position:absolute;background:rgba(49,130,206,.12);border:1px solid rgba(49,130,206,.4);pointer-events:none;z-index:10;'
    + 'left:'+x0+'px;top:'+pt+'px;width:'+(x1-x0)+'px;height:'+ph+'px';
}

function clearAvgOverlay() { if (avgOverlay) { avgOverlay.remove(); avgOverlay = null; } }

function showAvgResult(t0, t1) {
  if (!avgOverlay) return;
  var keys = selectedKeys();
  var results = [];
  keys.forEach(function(key) {
    var meta = TAG_MAP[key];
    var vals = seriesPoints(key).filter(function(p){ return p[0] >= t0 && p[0] <= t1; }).map(function(p){ return p[1]; });
    if (!vals.length) return;
    var sum = vals.reduce(function(a,b){return a+b;},0);
    results.push({ name: meta.label, color: meta.color, avg: sum/vals.length, dec: meta.group==='cp'?3:0, cnt: vals.length });
  });
  if (!results.length) { clearAvgOverlay(); return; }
  var cnt = results[0].cnt;
  var html = '<div class="avg-tooltip"><div style="font-weight:700;margin-bottom:6px;font-size:12px">Alt-드래그 평균 ('+cnt+'pts)</div>';
  results.forEach(function(r) {
    html += '<div class="avg-tooltip-row">'
      + '<div style="width:8px;height:8px;border-radius:50%;background:'+r.color+';flex-shrink:0"></div>'
      + '<span style="flex:1;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-size:11px">'+esc(r.name)+'</span>'
      + '<span style="font-weight:700;margin-left:8px;font-family:monospace">'+r.avg.toFixed(r.dec)+'</span></div>';
  });
  html += '<div style="font-size:10px;color:var(--muted);margin-top:6px;border-top:1px solid var(--border);padding-top:4px">'
    + '<span style="cursor:pointer;color:var(--primary)" onclick="clearAvgOverlay()">닫기</span></div></div>';
  avgOverlay.style.pointerEvents = 'auto';
  avgOverlay.innerHTML = html;
}

/* ── 차트 PNG 캡쳐 (오프라인: SVG→Canvas 변환, 외부 라이브러리 불필요) ── */
function saveChartPng() {
  if (!mainChart) { alert('차트가 없습니다.'); return; }
  var svg = mainChart.getSVG();
  var svgBlob = new Blob([svg], { type: 'image/svg+xml;charset=utf-8' });
  var url = URL.createObjectURL(svgBlob);
  var img = new Image();
  img.onload = function() {
    var scale = 2;
    var canvas = document.createElement('canvas');
    canvas.width = mainChart.chartWidth * scale;
    canvas.height = mainChart.chartHeight * scale;
    var ctx = canvas.getContext('2d');
    ctx.fillStyle = '#141c2e';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
    URL.revokeObjectURL(url);
    canvas.toBlob(function(blob) {
      var now = new Date();
      var fname = 'trend2_'+now.getFullYear()+pad(now.getMonth()+1)+pad(now.getDate())
                +'_'+pad(now.getHours())+pad(now.getMinutes())+pad(now.getSeconds())+'.png';
      var a = document.createElement('a');
      a.href = URL.createObjectURL(blob);
      a.download = fname;
      a.click();
    });
  };
  img.onerror = function() { URL.revokeObjectURL(url); alert('캡쳐 실패'); };
  img.src = url;
}

/* ── 엑셀 저장 (Highcharts export-data, 로컬 처리) ── */
function saveChartXls() {
  if (!mainChart) { alert('차트가 없습니다.'); return; }
  mainChart.downloadXLS();
}

/* ── 초기화 ── */
$(function(){
  if (typeof userInfoList === 'function') {
      userInfoList(now_page_code);
  }
  initRange();
  renderTagList();
  reloadChart();
});
window.addEventListener('resize', function(){ if (mainChart) mainChart.reflow(); });
</script>
</body>
</html>
