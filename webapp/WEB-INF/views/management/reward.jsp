<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>포상관리제 통합 관리대장</title>
<%@include file="../include/pluginpage.jsp" %>
<style>
:root{--bg:#eef1ef;--card:#fff;--ink:#17262e;--mut:#5d6d74;--line:#d5dcd9;--acc:#1d6b57;--accbg:#dcefe8;--pt:#8f5400;--ptbg:#fbeccd;--warn:#a33a2a;--warnbg:#f6dcd7;--btn:#1d6b57;--btnt:#fff}
*{box-sizing:border-box}
html,body{height:100%;margin:0;overflow:hidden}
body{margin:0;background:var(--bg);color:var(--ink);font:14px/1.5 "Noto Sans KR",system-ui,-apple-system,"Malgun Gothic",sans-serif;display:flex;flex-direction:column}
.wrap{max-width:1120px;margin:0 auto;padding:16px;flex:1;min-height:0;overflow:auto;width:100%}
h1{font-size:20px;margin:0 0 2px;letter-spacing:-.02em}
.sub{color:var(--mut);margin:0 0 14px}
.stats{display:grid;grid-template-columns:repeat(4,1fr);background:var(--card);border:1px solid var(--line);border-radius:10px;margin-bottom:14px}
.stats div{padding:14px 16px;border-left:1px solid var(--line)}
.stats div:first-child{border-left:0}
.stats b{display:block;font-size:22px;font-variant-numeric:tabular-nums;letter-spacing:-.02em}
.stats span{color:var(--mut);font-size:12.5px}
.bar{display:flex;flex-wrap:wrap;gap:8px;align-items:center;margin-bottom:12px}
.tabs{display:flex;gap:4px;border-bottom:1px solid var(--line);margin-bottom:14px}
.tabs button{background:none;border:0;border-bottom:3px solid transparent;padding:9px 14px;font:inherit;font-weight:500;color:var(--mut);cursor:pointer;margin-bottom:-1px}
.tabs button[aria-selected=true]{color:var(--ink);border-color:var(--acc)}
input,select,textarea{font:inherit;color:var(--ink);background:var(--card);border:1px solid var(--line);border-radius:7px;padding:7px 10px;min-width:0}
input:focus-visible,select:focus-visible,textarea:focus-visible,button:focus-visible{outline:2px solid var(--acc);outline-offset:1px}
.btn{background:var(--btn);color:var(--btnt);border:0;border-radius:7px;padding:8px 14px;font:inherit;font-weight:500;cursor:pointer}
.btn:disabled{opacity:.45;cursor:not-allowed}
.ghost{background:none;color:var(--ink);border:1px solid var(--line)}
.sm{padding:3px 9px;font-size:12.5px}
.sp{flex:1}
.tw{background:var(--card);border:1px solid var(--line);border-radius:10px;overflow-x:auto}
table{border-collapse:collapse;width:100%;min-width:860px}
th,td{padding:10px 12px;text-align:left;border-bottom:1px solid var(--line);vertical-align:top}
th{font-size:12.5px;color:var(--mut);font-weight:500;white-space:nowrap}
tr:last-child td{border-bottom:0}
tfoot td{font-weight:700;background:var(--bg)}
.n{text-align:right;font-variant-numeric:tabular-nums;white-space:nowrap}
.m{color:var(--mut);font-size:12.5px}
.chip{display:inline-block;border-radius:99px;padding:1px 9px;font-size:12.5px;font-weight:500;white-space:nowrap}
.c-i{background:var(--accbg);color:var(--acc)}.c-p{background:var(--ptbg);color:var(--pt)}.c-w{background:var(--warnbg);color:var(--warn)}
.meter{height:5px;background:var(--line);border-radius:3px;margin-top:4px;width:110px;margin-left:auto}
.meter i{display:block;height:100%;background:var(--pt);border-radius:3px}
.empty{padding:36px 16px;text-align:center;color:var(--mut)}
.acts{white-space:nowrap;text-align:right}
.acts button{margin-left:4px}
.arm{background:var(--warnbg);color:var(--warn);border-color:var(--warn)}
dialog{border:1px solid var(--line);border-radius:12px;background:var(--card);color:var(--ink);padding:0;width:min(520px,calc(100% - 24px))}
dialog::backdrop{background:rgba(0,0,0,.45)}
dialog form{padding:20px;display:grid;grid-template-columns:1fr 1fr;gap:12px}
dialog h2{grid-column:1/-1;margin:0;font-size:18px}
label{display:flex;flex-direction:column;gap:4px;font-size:12.5px;color:var(--mut)}
label input,label select,label textarea{font-size:14px}
.full{grid-column:1/-1}
.err{grid-column:1/-1;color:var(--warn);min-height:1em;margin:0;font-size:13px}
.sec{font-size:15px;margin:20px 0 8px}.flash{margin:-8px 0 12px;padding:9px 14px;border-radius:8px;background:var(--warnbg);color:var(--warn)}.flash:empty{display:none}.hint{grid-column:1/-1;margin:-4px 0 0;font-size:12.5px;color:var(--mut)}.foot{display:flex;gap:8px;justify-content:flex-end;grid-column:1/-1}
.note{margin-top:22px;color:var(--mut);font-size:12.5px}
@media(max-width:640px){.stats{grid-template-columns:1fr 1fr}.stats div:nth-child(3){border-left:0}.stats div:nth-child(n+3){border-top:1px solid var(--line)}dialog form{grid-template-columns:1fr}}
</style>
</head>
<body>
<div class="wrap">
<h1>포상관리제 통합 관리대장</h1>
<p class="sub">임직원 전체 포상 지급과 포인트 적립을 기록하고, 포상 항목 기준과 사원별 누적 현황을 관리합니다.</p>
<div class="stats" id="stats"></div>
<div class="flash" id="flash" role="status"></div>
<div class="tabs" role="tablist">
<button role="tab" data-tab="ledger" aria-selected="true">포상 관리대장</button>
<button role="tab" data-tab="summary" aria-selected="false">사원별 누적 현황</button>
<button role="tab" data-tab="items" aria-selected="false">포상 항목·기준</button>
</div>
<section id="p-ledger">
<div class="bar">
<input id="q" type="search" placeholder="성명, 사번, 항목 검색" aria-label="검색">
<select id="ft" aria-label="포상 구분"><option value="">구분 전체</option><option>즉시 포상</option><option>포인트 적립</option></select>
<select id="fs" aria-label="지급 상태"><option value="">상태 전체</option><option>지급완료</option><option>승인대기</option></select>
<span class="sp"></span>
<button class="btn" data-act="newl">포상 등록</button>
</div>
<div class="tw"><table><thead><tr><th>NO</th><th>지급/적립일</th><th>사원</th><th>구분</th><th>포상 항목 / 공적 사항</th><th class="n">보상</th><th>승인/담당 주체</th><th>상태</th><th></th></tr></thead><tbody id="lb"></tbody></table></div>
</section>
<section id="p-summary" hidden>
<div class="bar"><input id="q2" type="search" placeholder="성명, 사번, 부서 검색" aria-label="검색"><span class="sp"></span><span class="m">사원 명부는 [기준정보 &gt; 작업자등록]에서 관리됩니다.</span></div>
<div class="tw"><table><thead><tr><th>사원번호</th><th>성명</th><th>부서 / 직책</th><th class="n">즉시포상 누적액</th><th class="n">누적 포인트</th><th class="n">상품권 교환 가능</th><th class="n">잔여 포인트</th></tr></thead><tbody id="sb"></tbody><tfoot id="sf"></tfoot></table></div>
<p class="note">포인트 30,000p마다 상품권 1장(3만원)으로 교환할 수 있고, 남은 포인트는 다음 교환으로 이월됩니다.</p>
</section>
<section id="p-items" hidden>
<div class="bar"><span class="m">대장에 포상을 등록할 때 이 항목을 선택하면 담당 주체와 기준 금액이 자동으로 채워집니다.</span><span class="sp"></span><button class="btn" data-act="newi">항목 등록</button></div>
<div id="ib"></div>
</section>
</div>

<dialog id="dlg"><form id="fm">
<h2 id="dt">포상 등록</h2>
<label class="full">사원<select id="emp" required></select></label>
<label>부서<input id="dept" required></label>
<label>직책<input id="title" required></label>
<label class="full">포상 항목<select id="item"></select></label>
<p class="hint" id="hint"></p>
<label>지급/적립일<input id="date" type="date" required></label>
<label><span id="vl">보상액(원)</span><input id="val" type="number" min="0" step="1"></label>
<label class="full">세부 포상 내용 / 공적 사항<textarea id="detail" rows="2"></textarea></label>
<label>승인/담당 주체<input id="appr"></label>
<label>지급 상태<select id="status"><option>지급완료</option><option>승인대기</option></select></label>
<p class="err" id="err"></p>
<div class="foot"><button type="button" class="btn ghost" data-act="close">취소</button><button class="btn" type="submit">저장</button></div>
</form></dialog>

<dialog id="di"><form id="fi">
<h2 id="dit">포상 항목 등록</h2>
<label>구분<select id="it"><option>즉시 포상</option><option>포인트 적립</option></select></label>
<label>포상 항목명<input id="in" required></label>
<label class="full"><span id="l1"></span><textarea id="i1" rows="2"></textarea></label>
<label class="full"><span id="l2"></span><input id="i2"></label>
<label class="full"><span id="l3"></span><input id="i3"></label>
<label class="full"><span id="l4"></span><input id="i4"></label>
<label><span id="lmin"></span><input id="imin" type="number" min="0" step="1"></label>
<label><span id="lmax"></span><input id="imax" type="number" min="0" step="1"></label>
<p class="err" id="ierr"></p>
<div class="foot"><button type="button" class="btn ghost" data-act="close">취소</button><button class="btn" type="submit">저장</button></div>
</form></dialog>

<script>
let now_page_code = "h09";
const V=30000;
const G="30,000p 도달 시 ➔ 3만원 상품권 교환";
let S={roster:[],items:[],ledger:[]};
const gid=s=>document.getElementById(s),fmt=n=>(+n||0).toLocaleString("ko-KR");
const esc=s=>String(s??"").replace(/[&<>"]/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[c]));
const LB={"즉시 포상":["포상 대상 / 조건","포상 주기 및 시기","보상 내용","담당/승인 주체","원"],"포인트 적립":["적립 요건 및 기준","지급 포인트","누적 보상 안내","관리 방식","p"]};
const rng=i=>i.max>0?(i.min===i.max?fmt(i.min):fmt(i.min)+" ~ "+fmt(i.max))+LB[i.type][4]:"";
const today=()=>new Date(Date.now()-new Date().getTimezoneOffset()*6e4).toISOString().slice(0,10);
let tab="ledger",armed=null,ft;
const flash=t=>{gid("flash").textContent=t;clearTimeout(ft);ft=setTimeout(()=>gid("flash").textContent="",6000)};

function canWrite(level){
  const permission = (typeof userPermissions!=='undefined') ? userPermissions?.[now_page_code] : null;
  if(level==='edit') return ['I','U','D'].includes(permission);
  if(level==='delete') return permission==='D';
  return false;
}
const btns=(k,id)=>{const a=armed===k+id;
  const canE=canWrite('edit'),canD=canWrite('delete');
  return `<button class="btn ghost sm" ${canE?'':'disabled'} data-act="edit" data-k="${k}" data-id="${esc(id)}">수정</button><button class="btn ghost sm ${a?"arm":""}" ${canD?'':'disabled'} data-act="del" data-k="${k}" data-id="${esc(id)}">${a?"삭제 확인":"삭제"}</button>`;
};

function loadAll(cb){
  let left=2;
  function done(){ left--; if(left===0){ render(); if(cb)cb(); } }
  $.ajax({url:'/tkheat/reward/getRoster',type:'post',dataType:'json',success:function(r){S.roster=r.data||[];done();}});
  $.ajax({url:'/tkheat/reward/getItemList',type:'post',dataType:'json',success:function(r){S.items=r.data||[];done();}});
  loadLedger();
}
function loadLedger(cb){
  $.ajax({url:'/tkheat/reward/getLedgerList',type:'post',dataType:'json',success:function(r){S.ledger=r.data||[];render();if(cb)cb();}});
}

function stats(){
const L=S.ledger,amt=L.filter(r=>r.type==="즉시 포상").reduce((a,r)=>a+(r.amount||0),0),pt=L.filter(r=>r.type==="포인트 적립").reduce((a,r)=>a+(r.points||0),0),w=L.filter(r=>r.status==="승인대기").length;
gid("stats").innerHTML=`<div><b>${fmt(L.length)}건</b><span>총 지급 건수</span></div><div><b>${fmt(amt)}원</b><span>즉시 포상 지급액 합계</span></div><div><b>${fmt(pt)}p</b><span>포인트 적립 총합</span></div><div><b>${fmt(w)}건</b><span>승인 대기</span></div>`;
}
function ledger(){
const q=gid("q").value.trim(),t=gid("ft").value,s=gid("fs").value;
const rows=[...S.ledger].sort((a,b)=>a.date<b.date?-1:a.date>b.date?1:a.rl_idx-b.rl_idx).map((r,i)=>({...r,no:i+1})).filter(r=>(!t||r.type===t)&&(!s||r.status===s)&&(!q||[r.name,r.worker_no,r.dept,r.item,r.detail].join(" ").includes(q))).reverse();
gid("lb").innerHTML=rows.length?rows.map(r=>`<tr><td class="m">${r.no}</td><td class="n">${esc(r.date)}</td><td><b>${esc(r.name)}</b><div class="m">${esc(r.worker_no)} · ${esc(r.dept)} ${esc(r.title)}</div></td><td><span class="chip ${r.type==="즉시 포상"?"c-i":"c-p"}">${r.type}</span></td><td>${esc(r.item)}<div class="m">${esc(r.detail)}</div></td><td class="n">${r.type==="즉시 포상"?fmt(r.amount)+"원":fmt(r.points)+"p"}</td><td>${esc(r.approver)}</td><td><span class="chip ${r.status==="지급완료"?"c-i":"c-w"}">${r.status}</span></td><td class="acts">${btns("l",r.rl_idx)}</td></tr>`).join(""):`<tr><td colspan="9" class="empty">조건에 맞는 기록이 없습니다. 검색 조건을 바꾸거나 새 포상을 등록하세요.</td></tr>`;
}
function summary(){
const q=gid("q2").value.trim();let ta=0,tp=0,tv=0,tr=0;
const rows=S.roster.map(e=>{const l=S.ledger.filter(r=>r.worker_no===e.worker_no),a=l.reduce((x,r)=>x+(r.amount||0),0),p=l.reduce((x,r)=>x+(r.points||0),0);return{...e,a,p,v:Math.floor(p/V),rem:p%V}}).filter(e=>!q||[e.name,e.worker_no,e.dept,e.title].join(" ").includes(q));
rows.forEach(e=>{ta+=e.a;tp+=e.p;tv+=e.v;tr+=e.rem});
gid("sb").innerHTML=rows.length?rows.map(e=>`<tr><td>${esc(e.worker_no)}</td><td><b>${esc(e.name)}</b></td><td>${esc(e.dept)} ${esc(e.title)}</td><td class="n">${fmt(e.a)}원</td><td class="n">${fmt(e.p)}p</td><td class="n">${e.v}장</td><td class="n">${fmt(e.rem)}p<div class="meter" title="다음 상품권까지 ${fmt(V-e.rem)}p"><i style="width:${e.rem/V*100}%"></i></div></td></tr>`).join(""):`<tr><td colspan="7" class="empty">${S.roster.length?"검색 결과가 없습니다.":"작업자등록에 등록된 사원이 없습니다."}</td></tr>`;
gid("sf").innerHTML=`<tr><td colspan="3">합 계 (${rows.length}명)</td><td class="n">${fmt(ta)}원</td><td class="n">${fmt(tp)}p</td><td class="n">${tv}장</td><td class="n">${fmt(tr)}p</td></tr>`;
}
function items(){
gid("ib").innerHTML=["즉시 포상","포인트 적립"].map(t=>{const L=LB[t],rows=S.items.filter(i=>i.type===t);
return `<h3 class="sec">${t==="즉시 포상"?"1. 즉시 포상 항목":"2. 포인트 적립형 포상 항목"}</h3><div class="tw"><table style="min-width:980px"><thead><tr><th>포상 항목명</th><th>${L[0]}</th><th>${L[1]}</th><th>${L[2]}</th><th>${L[3]}</th><th class="n">기준 ${t==="즉시 포상"?"금액":"포인트"}</th><th></th></tr></thead><tbody>${rows.length?rows.map(i=>`<tr><td><b>${esc(i.name)}</b></td><td>${esc(i.c1)}</td><td>${esc(i.c2)}</td><td>${esc(i.c3)}</td><td>${esc(i.c4)}</td><td class="n">${rng(i)||"-"}</td><td class="acts">${btns("i",i.ri_idx)}</td></tr>`).join(""):`<tr><td colspan="7" class="empty">등록된 항목이 없습니다. 항목 등록 버튼으로 추가하세요.</td></tr>`}</tbody></table></div>`}).join("");
}
function render(){stats();ledger();summary();items()}

document.querySelectorAll(".tabs button").forEach(b=>b.onclick=()=>{tab=b.dataset.tab;document.querySelectorAll(".tabs button").forEach(x=>x.setAttribute("aria-selected",x===b));["ledger","summary","items"].forEach(n=>gid("p-"+n).hidden=n!==tab)});
["#q","#ft","#fs"].forEach(s=>gid(s.slice(1)).oninput=ledger);gid("q2").oninput=summary;

/* 포상 등록 */
let editL=null,legacy=null;
const cur=()=>S.items.find(i=>String(i.ri_idx)===gid("item").value)||(gid("item").value==="legacy"?legacy:null);
function hint(){
const it=cur(),h=gid("hint");if(!it){h.textContent="";gid("vl").textContent="보상액(원) / 포인트(p)";return}
gid("vl").textContent=it.type==="즉시 포상"?"즉시 보상액(원)":"적립 포인트(p)";
const r=rng(it),v=+gid("val").value||0,out=it.max>0&&v>0&&(v<it.min||v>it.max);
h.textContent=out?`기준 범위(${r})를 벗어났습니다. ${it.c3}`:(r?`기준 ${r} · `:"")+(it.c3||"");h.style.color=out?"var(--warn)":"";
}
gid("item").onchange=()=>{const it=cur();if(it){gid("appr").value=it.c4||"";gid("val").value=it.min>0?it.min:""}hint()};
gid("val").oninput=hint;
gid("emp").onchange=()=>{const e=S.roster.find(x=>x.worker_no===gid("emp").value);if(e){gid("dept").value=e.dept||"";gid("title").value=e.title||""}};
function openL(r){
if(!canWrite('edit')){alert('등록 권한이 없습니다.');return}
editL=r?r.rl_idx:null;legacy=null;gid("dt").textContent=r?"포상 수정":"포상 등록";gid("err").textContent="";
gid("emp").innerHTML=`<option value="">사원 선택</option>`+S.roster.map(e=>`<option value="${esc(e.worker_no)}">${esc(e.name)} (${esc(e.worker_no)})</option>`).join("");
const g=t=>`<optgroup label="${t}">`+S.items.filter(i=>i.type===t).map(i=>`<option value="${i.ri_idx}">${esc(i.name)}</option>`).join("")+"</optgroup>";
let m=r&&S.items.find(i=>i.name===r.item&&i.type===r.type),lo="";
if(r&&!m){legacy={type:r.type,name:r.item,c3:"",c4:r.approver,min:0,max:0};lo=`<option value="legacy">${esc(r.item)} (항목 목록에 없음)</option>`}
gid("item").innerHTML=`<option value="">항목 선택</option>${lo}${g("즉시 포상")}${g("포인트 적립")}`;
gid("item").value=r?(m?String(m.ri_idx):"legacy"):"";
gid("emp").value=r?r.worker_no:"";gid("dept").value=r?r.dept:"";gid("title").value=r?r.title:"";
gid("date").value=r?r.date:today();gid("status").value=r?r.status:"지급완료";
gid("val").value=r?(r.type==="즉시 포상"?r.amount:r.points):"";gid("detail").value=r?r.detail:"";gid("appr").value=r?r.approver:"";
hint();gid("dlg").showModal();
}
gid("fm").onsubmit=ev=>{
ev.preventDefault();
const e0=S.roster.find(x=>x.worker_no===gid("emp").value),it=cur(),v=+gid("val").value||0;
if(!e0){gid("err").textContent="사원을 선택하세요.";return}
if(!it){gid("err").textContent="포상 항목을 선택하세요.";return}
if(it.type==="포인트 적립"&&v<=0){gid("err").textContent="적립 포인트를 1 이상으로 입력하세요.";return}
const t=it.type,rec={date:gid("date").value,worker_no:e0.worker_no,name:e0.name,dept:gid("dept").value.trim(),title:gid("title").value.trim(),type:t,item:it.name,detail:gid("detail").value.trim(),amount:t==="즉시 포상"?v:0,points:t==="포인트 적립"?v:0,approver:gid("appr").value.trim(),status:gid("status").value};
rec.mode = editL!==null ? "update" : "insert";
if(editL!==null) rec.rl_idx = editL;
$.ajax({url:'/tkheat/reward/ledgerSave',type:'post',dataType:'json',data:rec,success:function(result){
  if(result.status!=='success'){ gid("err").textContent='저장하지 못했습니다: '+(result.message||''); return; }
  gid("dlg").close();loadLedger();
}});
};

/* 포상 항목 등록 */
let editI=null;
function lbl(){const L=LB[gid("it").value],u=L[4];gid("l1").textContent=L[0];gid("l2").textContent=L[1];gid("l3").textContent=L[2];gid("l4").textContent=L[3];gid("lmin").textContent=`기준 최소 ${u==="원"?"금액(원)":"포인트(p)"}`;gid("lmax").textContent=`기준 최대 ${u==="원"?"금액(원)":"포인트(p)"}`}
gid("it").onchange=lbl;
function openI(i){
if(!canWrite('edit')){alert('등록 권한이 없습니다.');return}
editI=i?i.ri_idx:null;gid("dit").textContent=i?"포상 항목 수정":"포상 항목 등록";gid("ierr").textContent="";gid("it").value=i?i.type:"즉시 포상";gid("in").value=i?i.name:"";gid("i1").value=i?i.c1:"";gid("i2").value=i?i.c2:"";gid("i3").value=i?i.c3:"";gid("i4").value=i?i.c4:"";gid("imin").value=i&&i.min?i.min:"";gid("imax").value=i&&i.max?i.max:"";lbl();gid("di").showModal();
}
gid("fi").onsubmit=ev=>{
ev.preventDefault();
const o={type:gid("it").value,name:gid("in").value.trim(),c1:gid("i1").value.trim(),c2:gid("i2").value.trim(),c3:gid("i3").value.trim(),c4:gid("i4").value.trim(),min:+gid("imin").value||0,max:+gid("imax").value||0};
if(!o.max)o.max=o.min;
if(o.max<o.min){gid("ierr").textContent="최소 기준이 최대 기준보다 클 수 없습니다.";return}
if(S.items.some(x=>x.type===o.type&&x.name===o.name&&x.ri_idx!==editI)){gid("ierr").textContent="같은 구분에 이미 있는 항목명입니다.";return}
o.mode = editI!==null ? "update" : "insert";
if(editI!==null) o.ri_idx = editI;
$.ajax({url:'/tkheat/reward/itemSave',type:'post',dataType:'json',data:o,success:function(result){
  if(result.status!=='success'){ gid("ierr").textContent='저장하지 못했습니다: '+(result.message||''); return; }
  gid("di").close();
  $.ajax({url:'/tkheat/reward/getItemList',type:'post',dataType:'json',success:function(r){S.items=r.data||[];render();}});
}});
};

document.addEventListener("click",e=>{
const b=e.target.closest("[data-act]");
if(!b){if(armed){armed=null;render()}return}
const a=b.dataset.act,k=b.dataset.k,id=b.dataset.id;
if(a!=="del"&&armed){armed=null;render()}
if(a==="close")b.closest("dialog").close();
else if(a==="newl")openL();
else if(a==="newi")openI();
else if(a==="edit"){
if(k==="l")openL(S.ledger.find(x=>String(x.rl_idx)===id));
else openI(S.items.find(x=>String(x.ri_idx)===id));
}else if(a==="del"){
if(!canWrite('delete')){alert('삭제 권한이 없습니다.');return}
const key=k+id;
if(armed!==key){armed=key;render();return}
armed=null;
if(k==="l"){
  $.ajax({url:'/tkheat/reward/ledgerDelete',type:'post',dataType:'json',data:{rl_idx:id},success:function(result){
    if(result.status!=='success'){flash('삭제하지 못했습니다.');return}
    loadLedger();
  }});
}else{
  $.ajax({url:'/tkheat/reward/itemDelete',type:'post',dataType:'json',data:{ri_idx:id},success:function(result){
    if(result.status!=='success'){flash('삭제하지 못했습니다.');return}
    $.ajax({url:'/tkheat/reward/getItemList',type:'post',dataType:'json',success:function(r){S.items=r.data||[];render();}});
  }});
}
}
});

$(function(){
  if (typeof userInfoList === 'function') userInfoList(now_page_code);
  loadAll();
});
</script>
</body>
</html>
