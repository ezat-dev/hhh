<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>4M 변경관리</title>
<%@include file="../include/pluginpage.jsp" %>
<style>
:root{--bg:#eef1f5;--sf:#fff;--ink:#17202e;--mut:#5d6877;--ln:#d6dce4;--pri:#1d3f72;--prit:#fff;--bad:#b3261e;--badbg:#fbe3e0;--ok:#1e7a46;--okbg:#dcf1e5;--wn:#80550a;--wnbg:#fcebc8;--m1:#2a6fdb;--m2:#0f8b8d;--m3:#c77700;--m4:#7a4cc2;--hd:#14213d}
*{box-sizing:border-box}
html,body{height:100%;margin:0;overflow:hidden}
body{background:var(--bg);color:var(--ink);font:14px/1.5 "Noto Sans KR","Malgun Gothic",sans-serif;display:flex;flex-direction:column}
.topbar{background:var(--hd);color:#fff;padding:10px 20px;display:flex;flex-wrap:wrap;gap:10px 16px;align-items:center;justify-content:space-between;flex-shrink:0}
.topbar h1{margin:0;font-size:18px}
.topbar small{color:#aeb9ca;display:block;font-size:12px}
main{flex:1;min-height:0;overflow:auto;max-width:1280px;width:100%;margin:0 auto;padding:16px 20px 40px}
button,input,select,textarea{font:inherit;color:inherit}
.btn{border:1px solid var(--ln);background:var(--sf);border-radius:6px;padding:7px 14px;cursor:pointer}
.btn.pri{background:var(--pri);color:var(--prit);border-color:var(--pri);font-weight:700}
.btn.del{color:var(--bad);border-color:var(--bad)}
.btn:disabled{opacity:.45;cursor:not-allowed}
.kpis{display:grid;grid-template-columns:repeat(auto-fit,minmax(130px,1fr));gap:10px;margin-bottom:14px}
.kpi{background:var(--sf);border:1px solid var(--ln);border-left:4px solid var(--pri);border-radius:6px;padding:8px 12px}
.kpi b{font-size:22px;display:block;line-height:1.2}
.kpi span{color:var(--mut);font-size:12px}
.kpi.bad{border-left-color:var(--bad)}.kpi.ok{border-left-color:var(--ok)}
.bar{display:flex;flex-wrap:wrap;gap:8px;margin-bottom:10px}
.bar input,.bar select{border:1px solid var(--ln);background:var(--sf);border-radius:6px;padding:7px 10px}
.bar input{flex:1 1 200px}
.tw{overflow-x:auto;background:var(--sf);border:1px solid var(--ln);border-radius:6px}
table{border-collapse:collapse;width:100%;min-width:980px}
th{background:var(--hd);color:#fff;text-align:left;font-weight:500;padding:8px 10px;white-space:nowrap}
td{padding:8px 10px;border-top:1px solid var(--ln);vertical-align:top}
tbody tr{cursor:pointer}tbody tr:hover{background:var(--bg)}
.chip{display:inline-block;padding:1px 8px;border-radius:10px;font-size:12px;white-space:nowrap}
.m{border:1px solid currentColor;font-weight:500}
.m1{color:var(--m1)}.m2{color:var(--m2)}.m3{color:var(--m3)}.m4{color:var(--m4)}
.bad{background:var(--badbg);color:var(--bad);font-weight:700}.ok{background:var(--okbg);color:var(--ok)}.wn{background:var(--wnbg);color:var(--wn)}.nt{background:var(--bg);color:var(--mut)}
.sub{color:var(--mut);font-size:12px}
.empty{padding:36px 16px;text-align:center;color:var(--mut)}
.ov{position:fixed;inset:0;background:rgba(0,0,0,.5);display:none;align-items:flex-start;justify-content:center;overflow-y:auto;padding:20px 10px;z-index:1000}
.ov.on{display:flex}
.md{background:var(--sf);border-radius:8px;width:100%;max-width:820px;padding:18px 20px}
.md h2{margin:0 0 4px;font-size:17px}
fieldset{border:1px solid var(--ln);border-radius:6px;margin:12px 0;padding:8px 12px 12px}
legend{font-weight:700;padding:0 6px}
.g{display:grid;grid-template-columns:repeat(auto-fit,minmax(210px,1fr));gap:10px}
.g label{display:flex;flex-direction:column;gap:3px;font-size:12px;color:var(--mut);position:relative}
.g input,.g select,.g textarea{border:1px solid var(--ln);background:var(--bg);border-radius:5px;padding:6px 8px;font-size:14px;color:var(--ink)}
.g .w{grid-column:1/-1}
.auto{background:var(--bg);border-radius:6px;padding:8px 12px;display:flex;flex-wrap:wrap;gap:6px 22px;font-size:13px}
.act{display:flex;gap:8px;justify-content:flex-end;align-items:center;margin-top:12px}
.err{color:var(--bad);margin-right:auto}
.tipbox{background:var(--bg);border-radius:6px;padding:8px 12px;font-size:13px;margin-top:8px}
.pnlist{position:absolute;top:100%;left:0;right:0;background:var(--sf);border:1px solid var(--ln);border-radius:6px;max-height:180px;overflow:auto;z-index:50;box-shadow:0 4px 14px rgba(0,0,0,.15);display:none}
.pnlist.on{display:block}
.pnlist div{padding:6px 10px;cursor:pointer;font-size:13px;border-bottom:1px solid var(--ln)}
.pnlist div:hover{background:var(--bg)}
#rpov,#gdov{z-index:1001}
#rpov.on{display:block;overflow:auto}
#rpov>div{width:max-content;max-width:100%;margin:0 auto}
.rpbar{background:var(--sf);border:1px solid var(--ln);border-radius:6px;padding:8px 12px;display:flex;flex-wrap:wrap;gap:8px;align-items:center;margin-bottom:8px}
.md ol{margin:0;padding-left:20px}.md p{margin:6px 0}
@page{size:A4;margin:0}
@media print{body>*:not(#rpov.on){display:none!important}#rpov.on{display:block!important;position:static;background:none;padding:0}#rpov>div{width:auto}.rpbar{display:none}}
#toast{position:fixed;left:50%;bottom:20px;transform:translateX(-50%);background:var(--hd);color:#fff;padding:8px 16px;border-radius:6px;display:none;z-index:2000}
.sheetCss{display:none}
</style>
</head>
<body>
<div class="topbar">
  <div><h1>4M 변경관리</h1><small>사내·사외 변경 접수부터 고객 신고, 검증, 적용, 종결까지</small></div>
  <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap">
    <button class="btn" id="gd">4M 작성 가이드</button>
    <button class="btn" id="exp">CSV 내보내기</button>
    <button class="btn pri insert-button" id="add">+ 변경 등록</button>
  </div>
</div>
<main>
  <div class="kpis" id="kpis"></div>
  <div class="bar">
    <input id="q" type="search" placeholder="관리번호, 품번, 품명, 발생처 검색" aria-label="검색">
    <select id="fs" aria-label="변경구분"><option value="">변경구분 전체</option><option>사내</option><option>사외</option></select>
    <select id="fm" aria-label="4M 구분"></select>
    <select id="ft" aria-label="진행상태"></select>
    <select id="fd" aria-label="지연여부"><option value="">지연여부 전체</option><option>지연만</option><option>진행중만</option></select>
  </div>
  <div class="tw"><table><thead><tr><th>관리번호</th><th>접수일</th><th>구분</th><th>4M</th><th>품번 / 품명</th><th>변경 내용</th><th>등급</th><th>진행상태</th><th>지연</th><th>경과일</th></tr></thead><tbody id="tb"></tbody></table><div class="empty" id="empty" hidden></div></div>
  <p class="sub">변경등급 A 사전승인 · B 사후통보 · C 내부관리는 임시 기준입니다. 승인지연은 신고 후 14일, 초기유동관리 기본 기간은 90일로 계산합니다. 귀사 SQ 절차서에 맞게 확인하세요.</p>
</main>
<div class="ov" id="ov"><form class="md" id="fm_" autocomplete="off"><h2 id="mt"></h2><div id="body"></div>
  <div class="tipbox" id="tip"></div><div class="auto" id="auto" style="margin-top:8px"></div>
  <div class="act"><span class="err" id="err" role="alert"></span><button type="button" class="btn del delete" id="del" hidden>삭제</button><button type="button" class="btn" id="cx">닫기</button><button type="button" class="btn" id="rpb">신고서 미리보기</button><button type="submit" class="btn pri">저장</button><button type="button" class="btn pri" id="svp">저장 후 신고서 출력</button></div>
</form></div>
<div class="ov" id="gdov"><div class="md"><div class="act" style="margin:0 0 8px"><h2 style="margin:0 auto 0 0">4M 변경 작성 가이드</h2><button type="button" class="btn" id="gdx">닫기</button></div><div id="gdb"></div></div></div>
<div class="ov" id="rpov"><div><div class="rpbar"><label>업체명 <input id="co" placeholder="회사명 입력"></label><button type="button" class="btn pri" id="pr">인쇄 (A4, PDF로 저장 가능)</button><button type="button" class="btn" id="rdl">HTML 저장</button><button type="button" class="btn" id="rpx">닫기</button><span class="sub">인쇄 대화상자에서 '대상: PDF로 저장'을 선택하면 PDF로 저장됩니다.</span></div><div id="sheet"></div></div></div>
<div id="toast" role="status"></div>
<script>
let now_page_code = "e11";
const M4=['Man(인)','Machine(설비)','Material(자재)','Method(공법)'],MC={'Man(인)':'m1','Machine(설비)':'m2','Material(자재)':'m3','Method(공법)':'m4'};
const ST=['접수','검토중','고객신고/승인대기','검증중','적용완료','초기유동관리중','종결','반려'];
const GR={A:'사전승인',B:'사후통보',C:'내부관리'},APPR_DAYS=14,FLOW_DEF=90;
const SEC=[['기본 정보',[['no','관리번호','text'],['recv','접수일','date'],['scope','변경구분','sel',['사내','사외']],['m4','4M 구분','sel',M4],['origin','변경 발생처 (부서/협력사명)','text'],['dept','담당부서','text'],['owner','담당자','text']]],
['품목 · 변경 내용',[['cust','고객사','text'],['model','적용차종','text'],['pn','품번(입력 시 기존 품번 검색)','pnsearch'],['pname','품명','text'],['target','대상 공정/설비/자재/작업자','text','w'],['before','변경 전','area'],['after','변경 후','area'],['why','변경 사유','area','w']]],
['고객 신고 · 검증',[['grade','변경등급 (A/B/C)','sel',['A','B','C']],['rep','고객 신고일','date'],['appr','고객 승인(확인)일','date'],['vitem','검증 항목','sel',['초도품 검증','치수/외관','성능/내구','재질/성분','해당없음']],['vres','검증 결과','sel',['진행중','합격','불합격','해당없음']]]],
['적용 · 종결',[['plan','적용 예정일','date'],['start','최초 적용일 (적용 LOT)','date'],['flow','초기유동관리 기간(일)','num'],['status','진행상태','sel',ST],['end','종결일','date'],['memo','비고','area','w']]]];
const F=SEC.flatMap(s=>s[1]);
const gid=id=>document.getElementById(id),esc=s=>String(s??'').replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));
const pd=s=>s?new Date(s+'T00:00:00'):null,iso=d=>d.getFullYear()+'-'+String(d.getMonth()+1).padStart(2,'0')+'-'+String(d.getDate()).padStart(2,'0');
const today=()=>{const d=new Date();return new Date(d.getFullYear(),d.getMonth(),d.getDate())};
function calc(r){const T=today(),resp=GR[r.grade]||'';let flowEnd='';
  if(r.start&&r.flow!==''&&r.flow!=null){const d=pd(r.start);d.setDate(d.getDate()+Number(r.flow));flowEnd=iso(d)}
  let delay='';
  if(r.recv){if(r.end)delay='종결';else if(r.plan&&!r.start&&T>pd(r.plan))delay='적용지연';else if(resp==='사전승인'&&r.rep&&!r.appr&&(T-pd(r.rep))/864e5>APPR_DAYS)delay='승인지연';else delay='정상'}
  const days=r.recv?Math.round(((r.end?pd(r.end):T)-pd(r.recv))/864e5):'';
  return{resp,flowEnd,delay,days}}
let rows=[],editing=null,wantRp=false,cur={};
const toast=m=>{const t=gid('toast');t.textContent=m;t.style.display='block';clearTimeout(toast.t);toast.t=setTimeout(()=>t.style.display='none',2200)};

jQuery(function(){
  if (typeof userInfoList === 'function') userInfoList(now_page_code);
  buildForm();
  fillSel(gid('fm'),'4M 전체',M4);fillSel(gid('ft'),'진행상태 전체',ST);
  loadList();
  ['q','fs','fm','ft','fd'].forEach(i=>gid(i).addEventListener('input',render));
});

async function loadList(){
  jQuery.ajax({url:'/tkheat/change4m/getChange4mList',type:'post',dataType:'json',
    success:function(result){ rows = result.data || []; render(); }});
}
function canWrite(level){
  const permission = (typeof userPermissions!=='undefined') ? userPermissions?.[now_page_code] : null;
  if(level==='create') return ['I','U','D'].includes(permission);
  if(level==='update') return ['U','D'].includes(permission);
  if(level==='delete') return permission==='D';
  return true;
}
async function persist(r){
  const permOk = r._isNew ? canWrite('create') : canWrite('update');
  if(!permOk){ toast('권한이 없습니다.'); return false; }
  const data = Object.assign({}, r); delete data._isNew;
  data.mode = r._isNew ? 'insert' : 'update';
  return new Promise(resolve=>{
    jQuery.ajax({url:'/tkheat/change4m/save',type:'post',dataType:'json',data:data,
      success:function(result){
        if(result.status!=='success'){ toast('저장하지 못했습니다: '+(result.message||'')); resolve(false); return; }
        loadList(); resolve(true);
      },
      error:function(){ toast('저장하지 못했습니다.'); resolve(false); }
    });
  });
}
async function removeRow(r){
  if(!canWrite('delete')){ toast('삭제 권한이 없습니다.'); return false; }
  return new Promise(resolve=>{
    jQuery.ajax({url:'/tkheat/change4m/delete',type:'post',dataType:'json',data:{c4m_idx:r.c4m_idx},
      success:function(result){
        if(result.status!=='success'){ toast('삭제하지 못했습니다: '+(result.message||'')); resolve(false); return; }
        loadList(); resolve(true);
      },
      error:function(){ toast('삭제하지 못했습니다.'); resolve(false); }
    });
  });
}
function nextNo(y){let n=0;rows.forEach(r=>{const m=String(r.c4m_no||'').match(new RegExp('^4M-'+y+'-(\\d+)$'));if(m)n=Math.max(n,+m[1])});return '4M-'+y+'-'+String(n+1).padStart(3,'0')}
function fillSel(el,all,items){el.innerHTML='<option value="">'+all+'</option>'+items.map(i=>'<option>'+esc(i)+'</option>').join('')}

function toRow(r){
  return {c4m_idx:r.c4m_idx, no:r.c4m_no, recv:r.c4m_recv, scope:r.c4m_scope, m4:r.c4m_m4, origin:r.c4m_origin, dept:r.c4m_dept, owner:r.c4m_owner,
    cust:r.c4m_cust, model:r.c4m_model, pn:r.c4m_pn, pname:r.c4m_pname, prod_code:r.c4m_prod_code, target:r.c4m_target, before:r.c4m_before, after:r.c4m_after, why:r.c4m_why,
    grade:r.c4m_grade, rep:r.c4m_rep, appr:r.c4m_appr, vitem:r.c4m_vitem, vres:r.c4m_vres,
    plan:r.c4m_plan, start:r.c4m_start, flow:r.c4m_flow, status:r.c4m_status, end:r.c4m_end, memo:r.c4m_memo};
}
function fromRow(v){
  return {c4m_idx:v.c4m_idx, c4m_no:v.no, c4m_recv:v.recv, c4m_scope:v.scope, c4m_m4:v.m4, c4m_origin:v.origin, c4m_dept:v.dept, c4m_owner:v.owner,
    c4m_cust:v.cust, c4m_model:v.model, c4m_pn:v.pn, c4m_pname:v.pname, c4m_prod_code:v.prod_code||'', c4m_target:v.target, c4m_before:v.before, c4m_after:v.after, c4m_why:v.why,
    c4m_grade:v.grade, c4m_rep:v.rep, c4m_appr:v.appr, c4m_vitem:v.vitem, c4m_vres:v.vres,
    c4m_plan:v.plan, c4m_start:v.start, c4m_flow:v.flow===''?'':v.flow, c4m_status:v.status, c4m_end:v.end, c4m_memo:v.memo};
}

function render(){
  const list0=rows.map(toRow);
  const k=list0.map(r=>({r,c:calc(r)})),late=k.filter(x=>x.c.delay==='적용지연'||x.c.delay==='승인지연').length,done=k.filter(x=>x.r.end).length;
  gid('kpis').innerHTML=[['전체 접수',rows.length,''],['진행중',rows.length-done,''],['지연',late,late?'bad':''],['종결',done,'ok']].map(a=>'<div class="kpi '+a[2]+'"><b>'+a[1]+'</b><span>'+a[0]+'</span></div>').join('');
  const q=gid('q').value.trim().toLowerCase(),fs=gid('fs').value,fm=gid('fm').value,ft=gid('ft').value,fd=gid('fd').value;
  const list=k.filter(({r,c})=>(!q||[r.no,r.pn,r.pname,r.origin,r.target].join(' ').toLowerCase().includes(q))&&(!fs||r.scope===fs)&&(!fm||r.m4===fm)&&(!ft||r.status===ft)&&(!fd||(fd==='지연만'?/지연/.test(c.delay):!r.end))).sort((a,b)=>(b.r.recv||'').localeCompare(a.r.recv||'')||String(b.r.no).localeCompare(String(a.r.no)));
  gid('tb').innerHTML=list.map(({r,c})=>{const dc=/지연/.test(c.delay)?'bad':c.delay==='종결'?'ok':c.delay==='정상'?'nt':'';
    return '<tr data-idx="'+esc(r.c4m_idx)+'"><td>'+esc(r.no)+'</td><td>'+esc(r.recv)+'</td><td>'+esc(r.scope)+'</td><td><span class="chip m '+(MC[r.m4]||'')+'">'+esc(r.m4)+'</span></td><td>'+esc(r.pn)+'<div class="sub">'+esc(r.pname)+'</div></td><td>'+esc(r.target)+'<div class="sub">'+esc(r.before)+' → '+esc(r.after)+'</div></td><td>'+esc(r.grade)+'<div class="sub">'+esc(c.resp)+'</div></td><td>'+esc(r.status)+'</td><td><span class="chip '+dc+'">'+esc(c.delay)+'</span></td><td>'+esc(c.days)+'</td></tr>'}).join('');
  const e=gid('empty');e.hidden=!!list.length;e.textContent=rows.length?'조건에 맞는 변경 건이 없습니다. 검색어나 필터를 바꿔 보세요.':'등록된 변경 건이 없습니다. 오른쪽 위 "변경 등록"으로 첫 건을 추가하세요.';
  gid('tb').querySelectorAll('tr').forEach(tr=>tr.addEventListener('click',()=>{
    const idx = tr.dataset.idx; const found = list0.find(r=>String(r.c4m_idx)===idx); if(found) open(found);
  }));
}

function buildForm(){
  gid('body').innerHTML=SEC.map(s=>'<fieldset><legend>'+s[0]+'</legend><div class="g">'+s[1].map(f=>{
    const id='f_'+f[0],w=f[3]==='w'?' class="w"':'',o=f[2]==='sel'?f[3]:null;
    let inp;
    if(f[2]==='sel') inp='<select id="'+id+'"><option value=""></option>'+o.map(x=>'<option>'+esc(x)+'</option>').join('')+'</select>';
    else if(f[2]==='area') inp='<textarea id="'+id+'" rows="2"></textarea>';
    else if(f[2]==='pnsearch') inp='<input id="'+id+'" type="text" autocomplete="off"><div class="pnlist" id="'+id+'_list"></div>';
    else inp='<input id="'+id+'" type="'+(f[2]==='num'?'number':f[2])+'"'+(f[2]==='num'?' min="0"':'')+'>';
    return '<label'+w+'>'+f[1]+inp+'</label>';
  }).join('')+'</div></fieldset>').join('');
  gid('body').addEventListener('input',auto);

  let pnTimer=null;
  gid('f_pn').addEventListener('input',function(){
    clearTimeout(pnTimer);
    const v=this.value.trim();
    if(!v){ gid('f_pn_list').classList.remove('on'); return; }
    pnTimer=setTimeout(function(){
      jQuery.ajax({url:'/tkheat/change4m/getProductOptionList',type:'post',dataType:'json',data:{value:v},
        success:function(result){
          const list=(result.data||[]).filter(p=>p.c4m_pn);
          if(!list.length){ gid('f_pn_list').classList.remove('on'); return; }
          gid('f_pn_list').innerHTML=list.map(p=>'<div data-pn="'+esc(p.c4m_pn)+'" data-pname="'+esc(p.c4m_pname)+'" data-cust="'+esc(p.c4m_cust)+'" data-prod="'+esc(p.c4m_prod_code)+'">'+esc(p.c4m_pn)+' — '+esc(p.c4m_pname)+(p.c4m_cust?' <span class="sub">['+esc(p.c4m_cust)+']</span>':'')+'</div>').join('');
          gid('f_pn_list').classList.add('on');
        }});
    },250);
  });
  gid('f_pn_list').addEventListener('click',function(e){
    const d=e.target.closest('div[data-pn]'); if(!d) return;
    gid('f_pn').value=d.dataset.pn; gid('f_pname').value=d.dataset.pname;
    if(d.dataset.cust) gid('f_cust').value=d.dataset.cust;
    gid('f_pn').dataset.prodCode=d.dataset.prod;
    gid('f_pn_list').classList.remove('on');
    auto();
  });
  document.addEventListener('click',function(e){
    if(!e.target.closest('#f_pn') && !e.target.closest('#f_pn_list')) gid('f_pn_list').classList.remove('on');
  });
}
function vals(){const r={...editing};F.forEach(f=>{r[f[0]]=(gid('f_'+f[0]).value||'').trim()});r.prod_code=gid('f_pn').dataset.prodCode||r.prod_code||'';return r}
function auto(){tip();const c=calc(vals());gid('auto').innerHTML='<span>고객 대응: <b>'+(c.resp||'-')+'</b></span><span>초기유동관리 종료일: <b>'+(c.flowEnd||'-')+'</b></span><span>지연여부: <b>'+(c.delay||'-')+'</b></span><span>경과일: <b>'+(c.days===''?'-':c.days)+'</b></span>'}
function open(r){
  editing=r?Object.assign({},r):{c4m_idx:null,_isNew:true,recv:iso(today()),status:'접수',flow:FLOW_DEF};
  if(!r) editing._isNew=true;
  if(!editing.no)editing.no=nextNo((editing.recv||iso(today())).slice(0,4));
  F.forEach(f=>{gid('f_'+f[0]).value=editing[f[0]]??''});
  gid('f_pn').dataset.prodCode=editing.prod_code||'';
  const canEdit = editing._isNew ? canWrite('create') : canWrite('update');
  gid('mt').textContent=r?'변경 건 수정':'변경 등록';
  gid('del').hidden=!r||!canWrite('delete');gid('del').textContent='삭제';gid('err').textContent='';
  gid('fm_').querySelectorAll('input,select,textarea').forEach(el=>el.disabled=!canEdit);
  gid('fm_').querySelector('button[type=submit]').disabled=!canEdit;
  gid('svp').disabled=!canEdit;
  auto();gid('ov').classList.add('on');gid('f_recv').focus();
}
const close=()=>gid('ov').classList.remove('on');
gid('add').onclick=()=>{ if(!canWrite('create')){ toast('등록 권한이 없습니다.'); return; } open(); };
gid('cx').onclick=close;
gid('ov').addEventListener('mousedown',e=>{if(e.target===gid('ov'))close()});
document.addEventListener('keydown',e=>{if(e.key==='Escape'){if(gid('rpov').classList.contains('on'))gid('rpov').classList.remove('on');else if(gid('gdov').classList.contains('on'))gid('gdov').classList.remove('on');else close()}});
gid('fm_').addEventListener('submit',async e=>{e.preventDefault();const w=wantRp;wantRp=false;const v=vals(),miss=[['recv','접수일'],['scope','변경구분'],['m4','4M 구분'],['pn','품번'],['status','진행상태']].filter(x=>!v[x[0]]).map(x=>x[1]);
  if(miss.length){gid('err').textContent='필수 입력: '+miss.join(', ');return}
  if(v.status==='종결'&&!v.end){v.end=iso(today())}
  const r=fromRow(v); r._isNew=editing._isNew;
  if(await persist(r)){close();toast('저장했습니다.');if(w)showRp(v)}});
gid('del').onclick=async()=>{const b=gid('del');if(b.textContent==='삭제'){b.textContent='삭제 확인';return}
  if(await removeRow(editing)){close();toast('삭제했습니다.')}};
gid('exp').onclick=()=>{
  const head=F.map(f=>f[1]).concat(['고객 대응','초기유동관리 종료일','지연여부','경과일']);
  const qv=v=>'"'+String(v??'').replace(/"/g,'""')+'"';
  const list=rows.map(toRow);
  const lines=[head.map(qv).join(',')].concat(list.slice().sort((a,b)=>String(a.no).localeCompare(String(b.no))).map(r=>{const c=calc(r);return F.map(f=>qv(r[f[0]])).concat([c.resp,c.flowEnd,c.delay,c.days].map(qv)).join(',')}));
  downloadBlob('4M_변경관리대장.csv','﻿'+lines.join('\r\n'),'text/csv');
};
function downloadBlob(name,data,type){
  const blob=new Blob([data],{type:type+';charset=utf-8'});
  const a=document.createElement('a'); a.href=URL.createObjectURL(blob); a.download=name;
  document.body.appendChild(a); a.click(); document.body.removeChild(a);
  setTimeout(()=>URL.revokeObjectURL(a.href),2000);
}

const TIPS={
'Man(인)':{d:'작업자·검사원·관리감독자 등 사람이 바뀌는 변경',ex:'신규·교체 작업자 투입, 작업 인원 증감, 장기 부재 후 복귀, 파견·외주 인력 변경, 검사원 변경',wr:'공정명과 인원수·자격·경력을 변경 전/후로 적고, 교육·인증 실시일을 사유 또는 비고에 남기세요. 개인 이름보다 직무와 자격 기준으로 적는 것이 좋습니다.',docs:['교육 이력(훈련일지)','자격·인증서','작업자 숙련도 평가표','초도품 검사성적서']},
'Machine(설비)':{d:'설비·금형·치공구·검사장비·프로그램이 바뀌는 변경',ex:'설비 신규·교체·이설, 금형 수리·개조·신작, 장기 휴지 후 재가동, 설비 프로그램·조건값 변경, 지그·검사구 변경',wr:'설비명·관리번호·제조사·모델·사양을 변경 전/후로 비교하고, 압력·온도·속도·전류 같은 조건값은 수치로 적으세요. 동일 사양 교체라도 교체 사실은 기록합니다.',docs:['설비 사양서','초도품 검사성적서','공정능력(Cpk) 자료','설비 점검표']},
'Material(자재)':{d:'원자재·부품·부자재의 재질, 규격, 공급업체, 제조 장소가 바뀌는 변경',ex:'소재 변경, 부품 공급업체(2차 협력사) 변경, 원료 제조사·등급 변경, 도금·도장 약품 변경, 협력사 공장 이전',wr:'자재명·규격·공급사·제조 장소를 변경 전/후로 적으세요. 사외 변경은 협력사명과 통보받은 날짜를 변경 발생처·비고에 남기고, 당사에서 검증한 뒤 고객에 신고합니다.',docs:['재질 시험성적서','협력사 변경 신고서·승인서','초도품 검사성적서','신뢰성 시험 결과']},
'Method(공법)':{d:'작업 방법·공정 순서·조건·검사 방법이 바뀌는 변경',ex:'공정 순서 변경·추가·생략, 가공·용접 조건 변경, 작업표준서 개정, 검사 방법·기준 변경, 포장·운반 방법 변경, 공정 외주화',wr:'공정번호와 작업표준서 번호, 개정 차수를 변경 전/후로 적고 달라진 조건값을 수치로 쓰세요. 관리계획서와 FMEA에 반영했는지도 함께 확인합니다.',docs:['공정흐름도','관리계획서(Control Plan)','P-FMEA','작업표준서 개정본']}};
const GEN=['변경 전/후는 "무엇이 어떻게 바뀌는지"를 모델·번호·수치로 구체적으로 적습니다. (예: 용접전류 8.0kA → 8.5kA)','변경 사유는 품질 개선, 노후 교체, 원가, 생산성, 고객 요청처럼 목적이 드러나게 적습니다.','사내 변경은 당사에서 일어난 변경, 사외 변경은 2차 협력사 등 외부에서 일어난 변경입니다. 사외 건은 통보받은 날짜를 기록하세요.','사전승인 대상은 고객 승인 전에 양산에 적용하지 않습니다. 대상 여부와 신고 시기는 현대·기아 SQ 기준과 귀사 규정을 따르세요.','최초 적용일에는 적용 LOT를 식별할 수 있게 LOT 번호나 라벨 기준을 함께 남기고, 초기유동관리 기간에는 강화 검사를 합니다.','여러 M이 동시에 바뀌면 M별로 따로 등록하는 것이 추적하기 쉽습니다.','변경등급이 애매하면 임의로 낮추지 말고 고객 담당자에게 먼저 확인하세요.'];
function tip(){const m=gid('f_m4').value,t=TIPS[m];gid('tip').innerHTML=t?'<b>'+esc(m)+' 작성 방법</b> '+esc(t.wr)+' <span class="sub">첨부 서류 예: '+esc(t.docs.join(', '))+'</span>':'4M 구분을 선택하면 작성 방법이 표시됩니다. 전체 설명은 상단 "4M 작성 가이드"를 보세요.'}
function guide(){gid('gdb').innerHTML='<p>4M은 사람(Man), 설비(Machine), 자재(Material), 공법(Method) 네 가지 생산 요소입니다. 이 중 하나라도 바뀌면 품질에 영향을 줄 수 있어 변경 내용을 기록하고, 필요하면 고객에 신고·승인받은 뒤 적용합니다.</p>'+M4.map(m=>{const t=TIPS[m];return '<fieldset><legend><span class="chip m '+MC[m]+'">'+esc(m)+'</span></legend><p><b>해당 변경</b> '+esc(t.d)+'</p><p><b>예시</b> '+esc(t.ex)+'</p><p><b>작성 방법</b> '+esc(t.wr)+'</p><p><b>첨부 서류 예</b> '+esc(t.docs.join(', '))+'</p></fieldset>'}).join('')+'<fieldset><legend>공통 작성 요령</legend><ol>'+GEN.map(g=>'<li>'+esc(g)+'</li>').join('')+'</ol></fieldset><p class="sub">일반적인 관리 관행을 정리한 설명입니다. 실제 신고 대상, 시기, 제출 서류는 현대·기아 SQ와 귀사 규정이 우선합니다.</p>'}
const RPCSS='.rp{flex:none;width:210mm;min-height:297mm;padding:12mm;background:#fff;color:#000;font:11px/1.45 "Noto Sans KR","Malgun Gothic",sans-serif;box-sizing:border-box}.rp h1{margin:0;font-size:24px;letter-spacing:6px}.rp .rh{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:10px}.rp table{border-collapse:collapse;width:100%;min-width:0}.rp th,.rp td{border:1px solid #000;padding:4px 6px;vertical-align:top;text-align:left;white-space:pre-wrap;color:#000}.rp th{background:#eee;width:19%;font-weight:700}.rp .ap{width:auto}.rp .ap th{width:52px;text-align:center;white-space:normal}.rp .ap td{height:40px;width:52px}.rp .tall td{height:24mm}.rp .ft{margin-top:14px;text-align:center}';
document.head.insertAdjacentHTML('beforeend','<style>'+RPCSS+'</style>');
function reportHtml(r,co){const c=calc(r),t=TIPS[r.m4],ck=(a,b)=>(a===b?'☑':'☐')+' '+esc(b),line=(k,v)=>'<tr><th>'+k+'</th><td colspan="3">'+v+'</td></tr>',tall=(k,v)=>'<tr class="tall"><th>'+k+'</th><td colspan="3">'+esc(v)+'</td></tr>',two=(a,b,c2,d)=>'<tr><th>'+a+'</th><td>'+b+'</td><th>'+c2+'</th><td>'+d+'</td></tr>';
  const day=r.rep||iso(today()),docs=(t?t.docs:['변경 관련 증빙 서류']).map(x=>'☐ '+esc(x)).join('　')+'　☐ 기타';
  return '<div class="rp"><div class="rh"><h1>4M 변경 신고서</h1><table class="ap"><tr><th rowspan="2">결재</th><th>담당</th><th>검토</th><th>승인</th></tr><tr><td></td><td></td><td></td></tr></table></div><table>'
  +two('업체명',esc(co),'관리번호',esc(r.no))+two('고객사',esc(r.cust),'적용차종',esc(r.model))+two('품번',esc(r.pn),'품명',esc(r.pname))
  +two('변경구분',ck(r.scope,'사내')+'　'+ck(r.scope,'사외'),'변경등급',esc(r.grade)+(c.resp?' ('+esc(c.resp)+')':''))
  +line('4M 구분',M4.map(m=>ck(r.m4,m)).join('　'))+line('대상 공정/설비/자재/작업자',esc(r.target))+two('변경 발생처',esc(r.origin),'담당부서 / 담당자',esc(r.dept)+(r.owner?' / '+esc(r.owner):''))
  +tall('변경 전',r.before)+tall('변경 후',r.after)+tall('변경 사유',r.why)
  +two('적용 예정일',esc(r.plan),'최초 적용일',esc(r.start))+two('초기유동관리',(r.flow!==''&&r.flow!=null?esc(r.flow)+'일':'')+(c.flowEnd?' (~ '+esc(c.flowEnd)+')':''),'검증 항목 / 결과',esc(r.vitem)+(r.vres?' / '+esc(r.vres):''))
  +line('첨부 서류',docs)+line('비고',esc(r.memo))
  +'<tr class="tall"><th>고객 확인</th><td colspan="3">신고일: '+esc(r.rep)+'　　승인(확인)일: '+esc(r.appr)+'<br>☐ 승인　☐ 조건부 승인　☐ 반려<br>의견:</td></tr></table>'
  +'<div class="ft">위와 같이 4M 변경을 신고합니다.<br><br>'+esc(day)+'<br><br>'+esc(co)+'　　작성자: '+esc(r.owner)+'　(서명)</div></div>'}
function showRp(r){cur=r;let c='';try{c=localStorage.getItem('4m_co')||''}catch(e){}gid('co').value=c;gid('sheet').innerHTML=reportHtml(r,c);gid('rpov').classList.add('on')}
gid('co').addEventListener('input',()=>{try{localStorage.setItem('4m_co',gid('co').value)}catch(e){}gid('sheet').innerHTML=reportHtml(cur,gid('co').value)});
gid('rpb').onclick=()=>showRp(vals());
gid('svp').onclick=()=>{wantRp=true;gid('fm_').requestSubmit()};
gid('rpx').onclick=()=>gid('rpov').classList.remove('on');
gid('gd').onclick=()=>{guide();gid('gdov').classList.add('on')};gid('gdx').onclick=()=>gid('gdov').classList.remove('on');
gid('pr').onclick=()=>{try{window.print()}catch(e){toast('인쇄하지 못했습니다. HTML 저장 후 인쇄하세요.')}};
gid('rdl').onclick=()=>{const h='<!doctype html><html lang="ko"><head><meta charset="utf-8"><title>4M 변경 신고서</title><style>@page{size:A4;margin:0}body{margin:0}'+RPCSS+'</style></head><body>'+reportHtml(cur,gid('co').value)+'</body></html>';
  downloadBlob('4M변경신고서_'+(cur.no||'')+'.html',h,'text/html');};
</script>
</body>
</html>
