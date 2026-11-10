<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>급여관리 · 명세서 발송</title>
<%@include file="../include/pluginpage.jsp" %>
<style>
:root{--bg:#f3f5f4;--sf:#fff;--tx:#17211e;--mu:#667570;--ln:#d9dfdc;--ac:#0e6b57;--ac2:#e3f1ed;--wn:#b4372b}
*{box-sizing:border-box}
html,body{height:100%;margin:0;overflow:hidden}
body{margin:0;background:var(--bg);color:var(--tx);font:14px/1.55 "Noto Sans KR",system-ui,sans-serif;display:flex;flex-direction:column}
header{background:var(--sf);border-bottom:1px solid var(--ln);padding:10px 20px;display:flex;gap:16px;align-items:center;flex-wrap:wrap;flex-shrink:0}
h1{font-size:17px;margin:0;font-weight:600}
nav{display:flex;gap:4px;flex-wrap:wrap}
nav button{border:0;background:none;color:var(--mu);padding:8px 14px;border-radius:6px;font:inherit;cursor:pointer}
nav button.on{background:var(--ac2);color:var(--ac);font-weight:600}
main{flex:1;min-height:0;overflow:auto;max-width:1100px;margin:0 auto;padding:16px;width:100%}
.bar{display:flex;gap:8px;align-items:center;flex-wrap:wrap;margin-bottom:14px}
.bar h2{font-size:15px;margin:0 auto 0 0}
button.b{border:1px solid var(--ln);background:var(--sf);color:var(--tx);padding:7px 13px;border-radius:6px;font:inherit;cursor:pointer}
button.p{background:var(--ac);border-color:var(--ac);color:#fff}
button.b:disabled{opacity:.45;cursor:not-allowed}
button.b:focus-visible,nav button:focus-visible,input:focus-visible,select:focus-visible{outline:2px solid var(--ac);outline-offset:1px}
input,select,textarea{font:inherit;padding:7px 9px;border:1px solid var(--ln);border-radius:6px;background:var(--sf);color:var(--tx);width:100%}
.tw{overflow-x:auto;background:var(--sf);border:1px solid var(--ln);border-radius:8px}
table{border-collapse:collapse;width:100%;min-width:760px}
th,td{padding:9px 12px;text-align:left;border-bottom:1px solid var(--ln);white-space:nowrap}
th{font-weight:500;color:var(--mu);font-size:12.5px}td.n,th.n{text-align:right;font-variant-numeric:tabular-nums}
tr:last-child td{border-bottom:0}td input{padding:4px 6px;width:96px;text-align:right}
.tot td{font-weight:600;background:var(--ac2)}
.empty{padding:40px;text-align:center;color:var(--mu)}
.sum{display:flex;gap:12px;margin-bottom:14px;flex-wrap:wrap}
.sum div{background:var(--sf);border:1px solid var(--ln);border-radius:8px;padding:10px 16px;min-width:150px}
.sum b{display:block;font-size:19px;font-variant-numeric:tabular-nums}.sum span{color:var(--mu);font-size:12.5px}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(170px,1fr));gap:12px}
label{display:block;font-size:12.5px;color:var(--mu)}label input,label select{margin-top:3px;color:var(--tx)}
dialog{border:1px solid var(--ln);border-radius:10px;background:var(--sf);color:var(--tx);padding:20px;max-width:640px;width:94%}
dialog::backdrop{background:#0008}
.card{background:var(--sf);border:1px solid var(--ln);border-radius:8px;padding:16px;margin-bottom:14px}
.slip h3{text-align:center;margin:0 0 4px;font-size:18px}.slip .c{text-align:center;color:var(--mu);margin-bottom:12px}
.slip table{min-width:0;margin-bottom:10px}.slip th{width:25%}
.note{color:var(--mu);font-size:12.5px;margin:8px 0}.kw{display:block;color:var(--ac);font-size:12px;min-height:18px}
.ok{color:var(--ac)}.sent{font-size:12px;color:var(--ac)}
@media print{body>*:not(#printArea){display:none!important}#printArea{display:block!important}dialog{border:0}}
</style></head><body>
<header><h1>급여관리 · 명세서 발송</h1>
<nav id="nav"></nav></header>
<main id="app"></main>
<dialog id="dlg"></dialog>
<dialog id="cdlg" style="max-width:380px"></dialog>
<div id="printArea" style="display:none"></div>
<script>
let now_page_code = "h08";
const gid=s=>document.getElementById(s),W=n=>(Math.round(n)||0).toLocaleString('ko-KR');
let S={emps:[],pay:{},sent:{},set:{co:'',from:'',fn:'',mode:'gmail',bcc:'n',meal:200000}};
let curSlipEmp=null;
let tab='emp',ym=new Date().toISOString().slice(0,7);
const tabs={emp:'직원 관리',pay:'급여 계산',slip:'명세서 발송',set:'설정'};

function canWrite(level){
  const permission = (typeof userPermissions!=='undefined') ? userPermissions?.[now_page_code] : null;
  if(level==='view') return ['R','I','U','D'].includes(permission);
  if(level==='edit') return ['I','U','D'].includes(permission);
  return false;
}
function calc(e,m){
 const p=(S.pay[m]||{})[e.worker_no]||{},s=S.set,N=k=>(p[k]!==undefined&&p[k]!=='' && p[k]!=null)?+p[k]:(+e[k]||0),P=k=>+p[k]||0;
 const gross=N('base')+N('meal')+N('pos')+N('car')+P('ot')+P('night')+P('sat')+P('spec')+P('bonus');
 const free=Math.min(N('meal'),+s.meal||0);
 const tb=Math.max(0,gross-free);
 const A=(k,v)=>(p[k]!==undefined&&p[k]!=='' && p[k]!=null)?+p[k]:v;
 const np=A('npa',0),hi=A('hia',0),lt=A('lta',0),ei=A('eia',0);
 const tax=A('tax',0),loc=A('loca',0),oth=P('yj')+P('hs')+P('ded');
 const ded=np+hi+lt+ei+tax+loc+oth;
 return{yj:P('yj'),hs:P('hs'),od:P('ded'),base:N('base'),meal:N('meal'),pos:N('pos'),car:N('car'),night:P('night'),sat:P('sat'),spec:P('spec'),gross,free,tb,np,hi,lt,ei,tax,loc,oth,ded,net:gross-ded,ot:P('ot'),bonus:P('bonus')};
}
function render(){
 gid('nav').innerHTML=Object.entries(tabs).map(([k,v])=>`<button class="${k==tab?'on':''}" data-t="${k}">${v}</button>`).join('');
 gid('app').innerHTML=({emp:vEmp,pay:vPay,slip:vSlip,set:vSet})[tab]();
}
const mp=()=>`<label style="width:150px">귀속월<input type="month" id="ym" value="${ym}"></label>`;

/* ===================== 데이터 로드/저장 ===================== */
function loadAll(cb){
 let left=2;
 function done(){ left--; if(left===0){ loadMonth(ym, function(){ render(); if(cb)cb(); }); } }
 $.ajax({url:'/tkheat/payroll/getEmpList',type:'post',dataType:'json',success:function(r){S.emps=r.data||[];done();}});
 $.ajax({url:'/tkheat/payroll/getSet',type:'post',dataType:'json',success:function(r){S.set=Object.assign({co:'',fn:'',bcc:'n',meal:200000,smtpHost:'',smtpPort:587,smtpUser:'',smtpPass:''},r.data||{});S.set.meal=S.set.mealLimit||S.set.meal||200000;done();}});
}
function loadMonth(m, cb){
 let left=2;
 function done(){ left--; if(left===0 && cb) cb(); }
 $.ajax({url:'/tkheat/payroll/getMonthList',type:'post',dataType:'json',data:{ym:m},success:function(r){
   const o={}; (r.data||[]).forEach(x=>o[x.worker_no]=x); S.pay[m]=o; done();
 }});
 $.ajax({url:'/tkheat/payroll/getSentList',type:'post',dataType:'json',data:{ym:m},success:function(r){
   (r.data||[]).forEach(x=>S.sent[m+'|'+x.worker_no]=x.sentDate); done();
 }});
}

/* ===================== 직원 관리(작업자등록 재사용 + 급여 기본값만 편집) ===================== */
function vEmp(){
 const r=S.emps.map(e=>`<tr><td>${e.worker_no}</td><td>${e.name}</td><td>${e.dept||''}</td><td>${e.rank||''}</td><td>${e.email||''}</td><td class="n">${W(e.base)}</td><td class="n">${W((+e.meal||0)+(+e.pos||0)+(+e.car||0))}</td><td><button class="b" data-ed="${e.worker_no}">급여정보 수정</button></td></tr>`).join('');
 return `<div class="bar"><h2>직원 ${S.emps.length}명</h2><span class="note" style="margin:0">사번·이름·부서·직급은 [기준정보 &gt; 작업자등록]에서 관리됩니다.</span><button class="b" data-a="expe">CSV 내보내기</button></div>
 <div class="tw">${S.emps.length?`<table><tr><th>사번</th><th>이름</th><th>부서</th><th>직급</th><th>이메일</th><th class="n">기본급</th><th class="n">수당합계</th><th></th></tr>${r}</table>`:'<div class="empty">작업자등록에 등록된 직원이 없습니다.</div>'}</div>`;
}
function empForm(worker_no){
 const e=S.emps.find(x=>x.worker_no==worker_no);
 const d=gid('dlg');d.dataset.worker=worker_no;
 d.innerHTML=`<h2 style="margin-top:0;font-size:16px">${e.name} (${e.worker_no}) · 급여 기본값</h2>
 <div class="grid">
 <label>이메일(명세서 발송용)<input id="ef_email" type="email" value="${e.email||''}" placeholder="name@company.com"></label>
 <label>기본급<input id="ef_base" type="number" value="${e.base||0}"></label>
 <label>식대<input id="ef_meal" type="number" value="${e.meal||0}"></label>
 <label>직책수당<input id="ef_pos" type="number" value="${e.pos||0}"></label>
 <label>차량유지비<input id="ef_car" type="number" value="${e.car||0}"></label>
 </div>
 <p class="note" style="margin-top:14px">여기서 입력한 금액은 급여 계산 탭에서 월별 입력이 비어 있을 때 기본값으로 쓰입니다.</p>
 <div class="bar" style="margin:16px 0 0;justify-content:flex-end"><button class="b" data-a="x">취소</button><button class="b p" data-a="esv">저장</button></div>`;
 d.showModal();
}

/* ===================== 급여 계산 ===================== */
const PF=[['지급',[['base','기본급'],['meal','식대'],['pos','직책수당'],['car','차량유지비'],['ot','연장수당'],['night','야간수당'],['sat','토요수당'],['spec','특근수당'],['bonus','상여금']]],['공제 금액(원)',[['npa','국민연금'],['hia','건강보험'],['lta','장기요양'],['eia','고용보험'],['tax','소득세'],['loca','지방소득세']]],['기타 공제(원)',[['yj','연말정산'],['hs','건강보험정산'],['ded','기타공제']]]];
function vPay(){
 const m=S.emps.map(e=>{const c=calc(e,ym),done=(S.pay[ym]||{})[e.worker_no];return `<tr><td><b>${e.name}</b></td><td>${e.dept||''}</td><td class="n">${W(c.gross)}</td><td class="n">${W(c.ded)}</td><td class="n"><b>${W(c.net)}</b></td><td>${done?'<span class="sent">입력됨</span>':'미입력'}</td><td><button class="b p" data-pf="${e.worker_no}">급여 입력</button></td></tr>`}).join('');
 const t=S.emps.map(e=>calc(e,ym)),sm=k=>t.reduce((a,c)=>a+c[k],0);
 return `<div class="bar">${mp()}<button class="b p" data-a="expp">급여대장 CSV</button></div>
 <div class="sum"><div><span>총 지급액</span><b>${W(sm('gross'))}원</b></div><div><span>총 공제액</span><b>${W(sm('ded'))}원</b></div><div><span>총 실수령액</span><b>${W(sm('net'))}원</b></div></div>
 <div class="tw">${S.emps.length?`<table><tr><th>이름</th><th>부서</th><th class="n">지급합계</th><th class="n">공제합계</th><th class="n">실수령액</th><th>상태</th><th></th></tr>${m}</table>`:'<div class="empty">작업자등록에 등록된 직원이 없습니다.</div>'}</div>
 <p class="note">직원별 "급여 입력"을 누르면 한 창에서 지급·공제 항목을 모두 입력할 수 있습니다. 빈칸은 흐린 숫자(지급 항목은 직원 기본값, 공제 항목은 0)가 적용됩니다. 지방소득세는 비워두면 소득세의 10%가 자동 적용됩니다.</p>`;
}
function payForm(worker_no){
 const e=S.emps.find(x=>x.worker_no==worker_no),p=(S.pay[ym]||{})[worker_no]||{},i=S.emps.indexOf(e);
 const ph=k=>['base','meal','pos','car'].includes(k)?(e[k]||0):0;
 const sec=PF.map(([t,fs])=>`<p class="note" style="margin:14px 0 6px"><b>${t}</b></p><div class="grid">${fs.map(([k,l])=>`<label>${l}<input type="text" inputmode="decimal" data-n="1" data-q="${k}" value="${fmt(p[k])}" placeholder="${W(ph(k))}"><small class="kw"></small></label>`).join('')}</div>`).join('');
 const d=gid('dlg');d.dataset.worker=worker_no;
 d.innerHTML=`<h2 style="margin-top:0;font-size:16px">${e.name} · ${ym.replace('-','년 ')}월 급여 입력 (${i+1}/${S.emps.length})</h2>${sec}<div class="card" id="pv" style="margin:14px 0 0"></div><div class="bar" style="margin:14px 0 0;justify-content:flex-end"><button class="b" data-a="x">닫기</button><button class="b" data-a="sv2">저장</button>${i<S.emps.length-1?'<button class="b p" data-a="svn">저장 후 다음 직원</button>':''}</div>`;
 d.showModal();pv();kwAll();
}
function qv(){const o={};gid('dlg').querySelectorAll('[data-q]').forEach(i=>{const v=num(i.value);if(v!==''&&!isNaN(+v))o[i.dataset.q]=+v});return o}
function pv(){
 const worker_no=gid('dlg').dataset.worker,e=S.emps.find(x=>x.worker_no==worker_no),pm=S.pay[ym]=S.pay[ym]||{},old=pm[worker_no];
 pm[worker_no]=qv();const c=calc(e,ym);old===undefined?delete pm[worker_no]:pm[worker_no]=old;
 gid('pv').innerHTML=`지급합계 <b>${W(c.gross)}</b> · 4대보험 ${W(c.np+c.hi+c.lt+c.ei)} · 소득세 ${W(c.tax)} · 지방소득세 ${W(c.loc)} · 공제합계 <b>${W(c.ded)}</b><br><span style="font-size:17px">실수령액 <b class="ok">${W(c.net)}원</b></span>`;
}
function pvSave(next){
 if(!canWrite('edit')){ toast2('권한이 없습니다.'); return; }
 const worker_no=gid('dlg').dataset.worker,o=qv();
 const data=Object.assign({ym:ym,worker_no:worker_no},o);
 $.ajax({url:'/tkheat/payroll/monthSave',type:'post',dataType:'json',data:data,success:function(result){
   if(result.status!=='success'){ toast2('저장하지 못했습니다.'); return; }
   loadMonth(ym, function(){
     render();
     if(next){const i=S.emps.findIndex(x=>x.worker_no==worker_no);if(S.emps[i+1])payForm(S.emps[i+1].worker_no);else gid('dlg').close();}
     else gid('dlg').close();
   });
 }});
}

/* ===================== 명세서 발송 ===================== */
function vSlip(){
 const r=S.emps.map(e=>{const c=calc(e,ym),k=ym+'|'+e.worker_no;return `<tr><td>${e.name}</td><td>${e.email||'<span class="note">미등록</span>'}</td><td class="n">${W(c.net)}</td><td>${S.sent[k]?`<span class="sent">발송됨 ${S.sent[k]}</span>`:'미발송'}</td><td><button class="b" data-v="${e.worker_no}">미리보기</button> <button class="b p" data-m="${e.worker_no}" ${e.email?'':'disabled'}>메일 발송</button></td></tr>`}).join('');
 return `<div class="bar">${mp()}<h2></h2><button class="b p" data-a="all">전체 순차 발송</button></div>
 <div class="tw">${S.emps.length?`<table><tr><th>이름</th><th>이메일</th><th class="n">실수령액</th><th>상태</th><th></th></tr>${r}</table>`:'<div class="empty">직원이 없습니다.</div>'}</div>
 <p class="note">"메일 발송"을 누르면 설정 탭의 SMTP 서버를 통해 명세서가 해당 이메일로 바로 발송됩니다(별도 메일창이 뜨지 않습니다). 이메일 주소는 직원 관리 탭의 "급여정보 수정"에서, SMTP 서버 정보는 설정 탭에서 등록하세요.</p>`;
}
function vSet(){
 const s=S.set;
 return `<div class="card"><div class="grid"><label>회사명<input data-s="co" value="${s.co||''}"></label><label>보내는 사람 이름<input data-s="fn" value="${s.fn||''}" placeholder="인사팀"></label><label>보낸 사본을 나에게(숨은참조)<select data-s="bcc"><option value="n" ${s.bcc!='y'?'selected':''}>받지 않음</option><option value="y" ${s.bcc=='y'?'selected':''}>받음</option></select></label><label>식대 비과세 한도(원)<input type="number" data-s="meal" value="${s.meal||200000}"></label></div>
 <p class="note">4대보험·소득세 등 공제 금액은 급여 입력 창에서 직원별·월별로 직접 입력합니다.</p></div>
 <div class="card"><p class="note" style="margin:0 0 10px"><b>SMTP 메일 발송 설정</b> — 입력한 계정으로 직접 로그인해 메일을 보냅니다. Gmail은 일반 비밀번호가 아니라 "앱 비밀번호"를 발급받아 입력해야 합니다.</p>
 <div class="grid"><label>SMTP 서버<input id="st_host" value="${s.smtpHost||''}" placeholder="smtp.gmail.com"></label><label>포트<input id="st_port" type="number" value="${s.smtpPort||587}"></label><label>계정(전체 이메일 주소 - 로그인 아이디만 넣지 마세요)<input id="st_user" type="email" value="${s.smtpUser||''}" placeholder="예: th816@naver.com"></label><label>비밀번호(앱 비밀번호)<input id="st_pass" type="password" value="${s.smtpPass||''}"></label></div>
 <div class="bar" style="margin:12px 0 0;justify-content:flex-end"><button class="b p" data-a="savesmtp">메일발송설정 저장</button></div></div>`;
}

function toast2(m){ alert(m); }

/* ===================== 명세서 HTML/텍스트/메일 ===================== */
function slipHTML(e){
 const c=calc(e,ym),[y,m]=ym.split('-'),row=(a,b,x,z)=>`<tr><th>${a}</th><td class="n">${b}</td><th>${x}</th><td class="n">${z}</td></tr>`;
 return `<div class="slip"><h3>${y}년 ${+m}월 급여명세서</h3><div class="c">${S.set.co}</div>
 <table><tr><th>성명</th><td>${e.name}</td><th>사번 / 부서</th><td>${e.worker_no} / ${e.dept||'-'}</td></tr></table>
 <table>${row('기본급',W(c.base),'국민연금',W(c.np))}${row('식대',W(c.meal),'건강보험',W(c.hi))}${row('직책수당',W(c.pos),'장기요양',W(c.lt))}${row('차량유지비',W(c.car),'고용보험',W(c.ei))}${row('연장수당',W(c.ot),'소득세',W(c.tax))}${row('야간수당',W(c.night),'지방소득세',W(c.loc))}${row('토요수당',W(c.sat),'연말정산',W(c.yj))}${row('특근수당',W(c.spec),'건강보험정산',W(c.hs))}${row('상여금',W(c.bonus),'기타공제',W(c.od))}
 <tr class="tot"><th>지급합계</th><td class="n">${W(c.gross)}</td><th>공제합계</th><td class="n">${W(c.ded)}</td></tr></table>
 <table><tr class="tot"><th style="width:50%">실수령액</th><td class="n" style="font-size:17px">${W(c.net)} 원</td></tr></table></div>`;
}
function slipText(e){
 const c=calc(e,ym),[y,m]=ym.split('-'),l=(a,b)=>`${a}: ${W(b)}원`;
 return `${e.name}님, 안녕하세요.\n${y}년 ${+m}월 급여명세서를 보내드립니다.\n\n[지급]\n${l('기본급',c.base)}\n${l('식대',c.meal)}\n${l('직책수당',c.pos)}\n${l('차량유지비',c.car)}\n${l('연장수당',c.ot)}\n${l('야간수당',c.night)}\n${l('토요수당',c.sat)}\n${l('특근수당',c.spec)}\n${l('상여금',c.bonus)}\n${l('지급합계',c.gross)}\n\n[공제]\n${l('국민연금',c.np)}\n${l('건강보험',c.hi)}\n${l('장기요양',c.lt)}\n${l('고용보험',c.ei)}\n${l('소득세',c.tax)}\n${l('지방소득세',c.loc)}\n${l('연말정산',c.yj)}\n${l('건강보험정산',c.hs)}\n${l('기타공제',c.od)}\n${l('공제합계',c.ded)}\n\n${l('실수령액',c.net)}\n\n※ 본 메일은 본인에게만 발송된 개인정보입니다.\n${S.set.co}`;
}
const esc=x=>String(x).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/"/g,'&quot;');
function showErrDialog(title, msg){
 const d=gid('dlg');
 d.innerHTML=`<h2 style="margin-top:0;font-size:16px">${esc(title)}</h2>
 <label>에러 내용(복사해서 공유)<textarea id="errtxt" rows="14" readonly>${esc(msg)}</textarea></label>
 <div class="bar" style="margin:10px 0 0;justify-content:flex-end"><button class="b" data-a="x">닫기</button><button class="b p" data-cf="errtxt">복사</button></div>`;
 d.showModal();
}
function sendMailNow(e, btn){
 if(!e.email){ alert('이메일이 등록되지 않았습니다. 직원 관리 탭에서 먼저 등록하세요.'); return Promise.resolve(false); }
 const [y,m]=ym.split('-');
 const s=S.set,sub=`[${s.co}] ${y}년 ${+m}월 급여명세서 - ${e.name}`,c=calc(e,ym);
 const slip={ym,workerNo:e.worker_no,name:e.name,dept:e.dept||'',base:c.base,meal:c.meal,pos:c.pos,car:c.car,ot:c.ot,night:c.night,sat:c.sat,spec:c.spec,bonus:c.bonus,gross:c.gross,np:c.np,hi:c.hi,lt:c.lt,ei:c.ei,tax:c.tax,loc:c.loc,yj:c.yj,hs:c.hs,od:c.od,ded:c.ded,net:c.net};
 if(btn){ btn.disabled=true; btn.textContent='발송 중…'; }
 return new Promise(resolve=>{
  $.ajax({url:'/tkheat/payroll/sendMail',type:'post',dataType:'json',
   data:Object.assign({to:e.email,subject:sub},slip),
   success:function(result){
     if(result.status!=='success'){ showErrDialog('발송 실패', result.message||'(메시지 없음)'); if(btn){btn.disabled=false;btn.textContent='메일 발송';} resolve(false); return; }
     S.sent[ym+'|'+e.worker_no]=new Date().toLocaleDateString('ko-KR');
     resolve(true);
   },
   error:function(xhr){ showErrDialog('발송 실패', (xhr&&xhr.responseText)||'알 수 없는 오류'); if(btn){btn.disabled=false;btn.textContent='메일 발송';} resolve(false); }
  });
 });
}
const dl=(n,t,mime='text/csv')=>{const a=document.createElement('a');a.href=URL.createObjectURL(new Blob(['﻿'+t],{type:mime+';charset=utf-8'}));a.download=n;a.click()};

const cd=()=>gid('cdlg');
function ask(msg){return new Promise(r=>{const d=cd();d._r=r;d.innerHTML=`<p style="margin:0 0 16px;font-size:15px">${msg}</p><div class="bar" style="margin:0;justify-content:flex-end"><button class="b" data-y="0">아니요</button><button class="b p" data-y="1">예</button></div>`;d.showModal()})}
cd().addEventListener('close',()=>{const d=cd(),r=d._r;d._r=null;r&&r(false)});

document.addEventListener('click',async ev=>{
 const t=ev.target.closest('button');if(!t)return;const D=t.dataset,E=id=>S.emps.find(e=>e.worker_no==id);
 if(D.y!==undefined){const d=cd(),r=d._r;d._r=null;d.close();r&&r(D.y=='1')}
 else if(D.t){tab=D.t;if(tab==='pay'||tab==='slip')loadMonth(ym,render);else render()}
 else if(D.pf){ if(!canWrite('edit')){alert('권한이 없습니다.');return;} payForm(D.pf); }
 else if(D.ed){ if(!canWrite('edit')){alert('권한이 없습니다.');return;} empForm(D.ed); }
 else if(D.v){const e=E(D.v);curSlipEmp=e;gid('dlg').innerHTML=`${slipHTML(e)}<div class="bar" style="margin:12px 0 0;justify-content:flex-end"><button class="b" data-a="x">닫기</button><button class="b" data-a="pr">인쇄 / PDF 저장</button><button class="b" data-cp="${e.worker_no}">본문 복사</button><button class="b p" data-m="${e.worker_no}" ${e.email?'':'disabled'}>메일 발송</button></div>`;gid('dlg').showModal()}
 else if(D.m){ if(!canWrite('edit')){alert('권한이 없습니다.');return;} sendMailNow(E(D.m), t).then(()=>render()); }
 else if(D.cf){const el=gid(D.cf);el.select();document.execCommand('copy');t.textContent='복사됨'}
 else if(D.cp){navigator.clipboard.writeText(slipText(E(D.cp))).then(()=>t.textContent='복사됨')}
 else if(D.a){const a=D.a;
  if(a=='sv2')pvSave(false);
  else if(a=='svn')pvSave(true);
  else if(a=='x')gid('dlg').close();
  else if(a=='pr'){ if(curSlipEmp){ gid('printArea').innerHTML=slipHTML(curSlipEmp); } print(); }
  else if(a=='esv'){
   if(!canWrite('edit')){alert('권한이 없습니다.');return;}
   const worker_no=gid('dlg').dataset.worker;
   const data={worker_no:worker_no,email:gid('ef_email').value.trim(),base:+gid('ef_base').value||0,meal:+gid('ef_meal').value||0,pos:+gid('ef_pos').value||0,car:+gid('ef_car').value||0};
   $.ajax({url:'/tkheat/payroll/empSave',type:'post',dataType:'json',data:data,success:function(result){
     if(result.status!=='success'){alert('저장하지 못했습니다: '+(result.message||''));return}
     gid('dlg').close();loadAll();
   }});
  }
  else if(a=='expe')dl('직원목록.csv','사번,이름,부서,직급,이메일,기본급,식대,직책수당,차량유지비\n'+S.emps.map(e=>[e.worker_no,e.name,e.dept||'',e.rank||'',e.email||'',e.base||0,e.meal||0,e.pos||0,e.car||0].join(',')).join('\n'));
  else if(a=='expp')dl(`급여대장_${ym}.csv`,'사번,이름,지급합계,국민연금,건강보험,장기요양,고용보험,소득세,지방소득세,기타공제,공제합계,실수령액\n'+S.emps.map(e=>{const c=calc(e,ym);return [e.worker_no,e.name,c.gross,c.np,c.hi,c.lt,c.ei,c.tax,c.loc,c.oth,c.ded,c.net].join(',')}).join('\n'));
  else if(a=='all'){
   if(!canWrite('edit')){alert('권한이 없습니다.');return;}
   const q=[...S.emps].filter(e=>e.email);
   if(!q.length){alert('이메일이 등록된 직원이 없습니다.');return}
   if(!confirm(`${q.length}명에게 순차로 메일을 발송합니다. 계속할까요?`))return;
   (async()=>{ for(const e of q){ await sendMailNow(e); } render(); alert('전체 발송을 마쳤습니다.'); })();
  }
  else if(a=='savesmtp'){
   if(!canWrite('edit')){alert('권한이 없습니다.');return;}
   S.set.smtpHost=gid('st_host').value.trim();
   S.set.smtpPort=+gid('st_port').value||587;
   S.set.smtpUser=gid('st_user').value.trim();
   S.set.smtpPass=gid('st_pass').value;
   const data={co:S.set.co,fromEmail:S.set.smtpUser,fn:S.set.fn,mode:'smtp',bcc:S.set.bcc,mealLimit:S.set.meal,
     np:S.set.np||0,hi:S.set.hi||0,lt:S.set.lt||0,ei:S.set.ei||0,tx:S.set.tx||0,
     smtpHost:S.set.smtpHost,smtpPort:S.set.smtpPort,smtpUser:S.set.smtpUser,smtpPass:S.set.smtpPass};
   $.ajax({url:'/tkheat/payroll/setSave',type:'post',dataType:'json',data:data,success:function(result){
     if(result.status!=='success'){alert('저장하지 못했습니다: '+(result.message||''));return}
     alert('메일발송설정을 저장했습니다.');
   },error:function(){alert('저장하지 못했습니다.')}});
  }
 }
});
document.addEventListener('change',ev=>{
 const t=ev.target;
 if(t.id=='ym'){ym=t.value||ym;loadMonth(ym,render)}
 else if(t.dataset.s){
   if(!canWrite('edit')){alert('권한이 없습니다.');render();return;}
   const key=t.dataset.s, val=t.type=='number'?+t.value:t.value;
   S.set[key]=val;
   const data={co:S.set.co,fromEmail:S.set.smtpUser,fn:S.set.fn,mode:S.set.mode||'smtp',bcc:S.set.bcc,mealLimit:S.set.meal,
     np:S.set.np||0,hi:S.set.hi||0,lt:S.set.lt||0,ei:S.set.ei||0,tx:S.set.tx||0,
     smtpHost:S.set.smtpHost,smtpPort:S.set.smtpPort||587,smtpUser:S.set.smtpUser,smtpPass:S.set.smtpPass};
   $.ajax({url:'/tkheat/payroll/setSave',type:'post',dataType:'json',data:data});
 }
});
const num=v=>String(v??'').replace(/,/g,'').trim();
function fmt(v){if(v===undefined||v===null||v==='')return '';const t=num(v).replace(/[^\d.\-]/g,''),ng=t[0]=='-'?'-':'',b=t.replace(/-/g,'').split('.');return ng+b[0].replace(/\B(?=(\d{3})+(?!\d))/g,',')+(b.length>1?'.'+b.slice(1).join(''):'')}
function kwUpd(i){const s=i.nextElementSibling;if(s&&s.classList.contains('kw'))s.textContent=''}
function kwAll(){gid('dlg').querySelectorAll('input[data-n]').forEach(kwUpd)}
document.addEventListener('input',ev=>{const t=ev.target;if(t.dataset.n!==undefined){const b=t.value.length,p=t.selectionStart;t.value=fmt(t.value);const q=Math.max(0,p+t.value.length-b);try{t.setSelectionRange(q,q)}catch(x){}}if(t.dataset.q!==undefined)pv()});

$(function(){
  if (typeof userInfoList === 'function') userInfoList(now_page_code);
  loadAll();
});
</script></body></html>
