<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>차량 관리 일지</title>
<%@include file="../include/pluginpage.jsp" %>
<style>
:root{--bg:#f4f6f8;--card:#fff;--tx:#1b1f24;--mu:#66707b;--bd:#dde1e6;--ac:#1f6feb;--ac2:#fff;--wn:#c2410c;--ok:#15803d}
*{box-sizing:border-box}
html,body{height:100%;margin:0;overflow:hidden}
body{background:var(--bg);color:var(--tx);font:15px/1.5 "Noto Sans KR","Apple SD Gothic Neo","Malgun Gothic",sans-serif;display:flex;flex-direction:column}
header{padding:12px 16px 0;max-width:1100px;margin:auto;width:100%;flex-shrink:0}
h1{font-size:20px;margin:0 0 2px}
.sub{color:var(--mu);font-size:12px}
nav{display:flex;gap:4px;margin:12px 0;overflow-x:auto}
nav button{flex:1;min-width:80px;padding:9px 6px;border:1px solid var(--bd);background:var(--card);color:var(--tx);border-radius:8px;font:inherit;cursor:pointer}
nav button.on{background:var(--ac);color:var(--ac2);border-color:var(--ac);font-weight:600}
main{flex:1;min-height:0;overflow:auto;max-width:1100px;margin:auto;width:100%;padding:0 16px 40px}
.bar{display:flex;gap:8px;align-items:center;justify-content:space-between;margin-bottom:10px;flex-wrap:wrap}
.btn{padding:8px 14px;border-radius:8px;border:1px solid var(--ac);background:var(--ac);color:var(--ac2);font:inherit;cursor:pointer}
.btn.g{background:transparent;color:var(--tx);border-color:var(--bd)}
.btn.s{padding:3px 8px;font-size:12px}
.btn:disabled{opacity:.4;cursor:not-allowed}
select,input{font:inherit;padding:8px;border:1px solid var(--bd);border-radius:8px;background:var(--card);color:var(--tx);width:100%}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(270px,1fr));gap:10px}
.card{background:var(--card);border:1px solid var(--bd);border-radius:12px;padding:14px}
.card h3{margin:0 0 4px;font-size:16px}
.row{display:flex;justify-content:space-between;gap:8px;font-size:13px;padding:3px 0;border-top:1px dashed var(--bd)}
.row span:first-child{color:var(--mu)}
.warn{color:var(--wn);font-weight:600}.okc{color:var(--ok)}
.stats{display:grid;grid-template-columns:repeat(auto-fit,minmax(140px,1fr));gap:10px;margin-bottom:12px}
.stat b{display:block;font-size:20px}
.tw{overflow-x:auto;background:var(--card);border:1px solid var(--bd);border-radius:12px}
table{border-collapse:collapse;width:100%;font-size:13px;white-space:nowrap}
th,td{padding:8px 10px;border-bottom:1px solid var(--bd);text-align:left}
th{color:var(--mu);font-weight:500}
.empty{padding:28px;text-align:center;color:var(--mu)}
dialog{border:1px solid var(--bd);border-radius:14px;background:var(--card);color:var(--tx);width:min(440px,94vw);padding:16px}
dialog::backdrop{background:rgba(0,0,0,.45)}
label{display:block;font-size:12px;color:var(--mu);margin:8px 0 3px}
.tag{font-size:11px;padding:1px 7px;border-radius:99px;border:1px solid var(--bd);color:var(--mu)}
.rep h3{margin:16px 0 6px;font-size:15px}.rep .stats{margin:8px 0}
@media print{header,.noprint{display:none!important}body{overflow:visible}main{overflow:visible}:root{--bg:#fff;--card:#fff;--tx:#000;--mu:#444;--bd:#999;--ok:#000;--wn:#000}main{max-width:none;padding:0}body{background:#fff;font-size:12px}.tw{overflow:visible;border-radius:0}table{white-space:normal;font-size:11px}tr{break-inside:avoid}h3{break-after:avoid}}
</style></head><body>
<header><h1>🚚 차량 관리 일지</h1><div class="sub" id="st">불러오는 중…</div>
<nav id="nav"></nav></header>
<main id="app"></main>
<dialog id="dlg"><form id="f" method="dialog"></form></dialog>
<script>
let now_page_code = "e12";
const qs=s=>document.querySelector(s);
const esc=s=>String(s??'').replace(/[&<>"]/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[c]));
const D={vehicles:[],repairs:[],fuel:[]};
let tab='dash',filt='',q='',cf='',fm='';
const TABS=[['dash','현황'],['vehicles','차량등록'],['repairs','수리이력'],['fuel','주유일지'],['rep','월마감']];
const FIELDS={
 vehicles:[['v_no','차량번호','text',1],['v_type','구분','sel',['트럭','지게차']],['v_model','차명/모델'],['v_year','연식'],['v_vin','차대번호'],['v_fueltype','연료','sel',['경유','LPG','휘발유','전기']],['v_regdate','등록일','date'],['v_insp','검사 만료일','date'],['v_ins','보험 만료일','date'],['v_memo','비고']],
 repairs:[['vr_date','수리일','date',1],['v_idx','차량','veh',1],['vr_item','수리 내용','text',1],['vr_shop','정비업체'],['vr_cost','비용(원)','number'],['vr_odo','주행거리(km) / 가동시간(h)','number'],['vr_memo','비고']],
 fuel:[['vf_date','주유일','date',1],['v_idx','차량','veh',1],['vf_liter','주유량(L)','number'],['vf_cost','금액(원)','number'],['vf_card','카드 뒷자리 (숫자 4자리)','card'],['vf_odo','주행거리(km)','number'],['vf_station','주유소'],['vf_memo','비고']]
};
const TITLE={vehicles:'차량',repairs:'수리',fuel:'주유'};
const today=()=>{const d=new Date();return new Date(d.getFullYear(),d.getMonth(),d.getDate())};
const iso=d=>d.getFullYear()+'-'+String(d.getMonth()+1).padStart(2,'0')+'-'+String(d.getDate()).padStart(2,'0');
let rm=iso(today()).slice(0,7);
const diff=s=>s?Math.round((new Date(s+'T00:00:00')-today())/864e5):null;
const won=n=>n===''||n==null?'-':Number(n).toLocaleString('ko-KR')+'원';
const num=n=>n===''||n==null?'-':Number(n).toLocaleString('ko-KR');
const vname=id=>{const v=D.vehicles.find(x=>x.v_idx==id);return v?v.v_no:'(삭제된 차량)'};
const byDate=(a,b)=>(b._date||'').localeCompare(a._date||'');

function canWrite(level){
  const permission = (typeof userPermissions!=='undefined') ? userPermissions?.[now_page_code] : null;
  if(level==='create') return ['I','U','D'].includes(permission);
  if(level==='update') return ['U','D'].includes(permission);
  if(level==='delete') return permission==='D';
  return true;
}
function downloadBlob(name,data,type){
  const blob=new Blob([data],{type:type+';charset=utf-8'});
  const a=document.createElement('a'); a.href=URL.createObjectURL(blob); a.download=name;
  document.body.appendChild(a); a.click(); document.body.removeChild(a);
  setTimeout(()=>URL.revokeObjectURL(a.href),2000);
}

const EP={vehicles:{list:'getVehicleList',save:'vehicleSave',del:'vehicleDelete',pk:'v_idx'},
          repairs:{list:'getVehicleRepairList',save:'vehicleRepairSave',del:'vehicleRepairDelete',pk:'vr_idx'},
          fuel:{list:'getVehicleFuelList',save:'vehicleFuelSave',del:'vehicleFuelDelete',pk:'vf_idx'}};
function dateField(c){return c==='vehicles'?'v_regdate':c==='repairs'?'vr_date':'vf_date'}
function loadAll(cb){
  let left=3;
  function done(){ left--; if(left===0){ D.vehicles.forEach(v=>v._date=v.v_regdate); D.repairs.forEach(r=>r._date=r.vr_date); D.fuel.forEach(r=>r._date=r.vf_date); if(cb)cb(); render(); } }
  $.ajax({url:'/tkheat/vehicleLog/getVehicleList',type:'post',dataType:'json',data:{},success:function(r){D.vehicles=r.data||[];done();}});
  $.ajax({url:'/tkheat/vehicleLog/getVehicleRepairList',type:'post',dataType:'json',data:{},success:function(r){D.repairs=r.data||[];done();}});
  $.ajax({url:'/tkheat/vehicleLog/getVehicleFuelList',type:'post',dataType:'json',data:{},success:function(r){D.fuel=r.data||[];done();}});
}
async function save(c,rec,id){
  const permOk = id ? canWrite('update') : canWrite('create');
  if(!permOk){ alert('권한이 없습니다.'); return; }
  const data=Object.assign({},rec); data.mode = id?'update':'insert'; if(id) data[EP[c].pk]=id;
  return new Promise((resolve,reject)=>{
    $.ajax({url:'/tkheat/vehicleLog/'+EP[c].save,type:'post',dataType:'json',data:data,
      success:function(result){ if(result.status!=='success'){ reject(new Error(result.message||'저장 실패')); return; } loadAll(); resolve(); },
      error:function(){ reject(new Error('저장 실패')); }
    });
  });
}
async function del(c,id){
  if(!confirm('삭제할까요?'))return;
  if(!canWrite('delete')){ alert('삭제 권한이 없습니다.'); return; }
  const data={}; data[EP[c].pk]=id;
  $.ajax({url:'/tkheat/vehicleLog/'+EP[c].del,type:'post',dataType:'json',data:data,
    success:function(result){ if(result.status!=='success'){ alert('삭제하지 못했습니다: '+(result.message||'')); return; } loadAll(); },
    error:function(){ alert('삭제하지 못했습니다.'); }
  });
}
function dd(s,label){
  const n=diff(s); if(n===null||!s)return '<span class="sub">미입력</span>';
  const t=n<0?'만료 '+(-n)+'일 지남':n===0?'오늘 만료':'D-'+n;
  return '<span class="'+(n<=30?'warn':'okc')+'">'+esc(s)+' ('+t+')</span>';
}
function openForm(c,id){
  const rec=id?D[c].find(x=>x[EP[c].pk]==id):{};
  if(c!=='vehicles'&&!D.vehicles.length){alert('먼저 차량등록 탭에서 차량을 등록해 주세요.');return}
  const canEdit = id ? canWrite('update') : canWrite('create');
  if(!canEdit){ alert(id?'수정 권한이 없습니다.':'등록 권한이 없습니다.'); return; }
  let h='<h3 style="margin:0 0 4px">'+TITLE[c]+(id?' 수정':' 추가')+'</h3>';
  FIELDS[c].forEach(([k,l,t,r])=>{
    let v=rec[k]??(k===dateField(c)?iso(today()):'');
    h+='<label>'+l+(r===1?' *':'')+'</label>';
    if(t==='sel')h+='<select name="'+k+'">'+r.map(o=>'<option'+(o===v?' selected':'')+'>'+o+'</option>').join('')+'</select>';
    else if(t==='veh')h+='<select name="'+k+'" required>'+D.vehicles.map(x=>'<option value="'+esc(x.v_idx)+'"'+(String(x.v_idx)===String(v||filt)?' selected':'')+'>'+esc(x.v_no)+' ('+esc(x.v_type)+')</option>').join('')+'</select>';
    else h+='<input name="'+k+'" type="'+(t==='card'?'text':(t||'text'))+'" value="'+esc(v)+'"'+(r===1?' required':'')+(t==='number'?' step="any" inputmode="decimal"':'')+(t==='card'?' maxlength="4" pattern="[0-9]{4}" inputmode="numeric" placeholder="예: 1234" title="숫자 4자리"':'')+'>';
  });
  h+='<div class="bar" style="margin:14px 0 0"><button type="button" class="btn g" onclick="dlg.close()">취소</button><button class="btn">저장</button></div>';
  f.innerHTML=h;
  f.onsubmit=async e=>{
    e.preventDefault();
    const fd=new FormData(f),o={};
    FIELDS[c].forEach(([k,,t])=>{let v=fd.get(k)??'';o[k]=t==='number'&&v!==''?Number(v):v});
    try{await save(c,o,id)}catch(err){alert('저장하지 못했어요: '+(err.message||err));return}
    dlg.close();
  };
  dlg.showModal();
}
const dlg=qs('#dlg'),f=qs('#f');
function setTab(t){tab=t;filt='';q='';cf='';fm='';render()}
function vsel(){
  return '<select style="width:auto;min-width:150px" onchange="filt=this.value;render()"><option value="">전체 차량</option>'+D.vehicles.map(v=>'<option value="'+esc(v.v_idx)+'"'+(String(v.v_idx)===String(filt)?' selected':'')+'>'+esc(v.v_no)+'</option>').join('')+'</select>';
}
function dash(){
  const ym=iso(today()).slice(0,7);
  const sum=(a,dk,k)=>a.filter(x=>(x[dk]||'').startsWith(ym)).reduce((s,x)=>s+(Number(x[k])||0),0);
  let h='<div class="stats"><div class="card stat"><span class="sub">등록 차량</span><b>'+D.vehicles.length+'대</b></div>'
   +'<div class="card stat"><span class="sub">이번 달 주유비</span><b>'+won(sum(D.fuel,'vf_date','vf_cost'))+'</b></div>'
   +'<div class="card stat"><span class="sub">이번 달 수리비</span><b>'+won(sum(D.repairs,'vr_date','vr_cost'))+'</b></div></div>';
  if(!D.vehicles.length)return h+'<div class="card empty">아직 등록된 차량이 없어요.<br><br><button class="btn" onclick="setTab(\'vehicles\')">차량 등록하러 가기</button></div>';
  h+='<div class="grid">';
  D.vehicles.slice().sort((a,b)=>(a.v_type+a.v_no).localeCompare(b.v_type+b.v_no)).forEach(v=>{
    const fdate=v.last_fuel_date,rdate=v.last_repair_date,ritem=v.last_repair_item;
    const fd=fdate?-diff(fdate):null;
    h+='<div class="card"><h3>'+esc(v.v_no)+' <span class="tag">'+esc(v.v_type)+'</span></h3><div class="sub" style="margin-bottom:6px">'+esc(v.v_model||'')+(v.v_year?' · '+esc(v.v_year)+'년식':'')+'</div>'
     +'<div class="row"><span>마지막 주유</span><span>'+(fdate?esc(fdate)+' ('+(fd===0?'오늘':fd+'일 전')+')':'-')+'</span></div>'
     +'<div class="row"><span>마지막 수리</span><span>'+(rdate?esc(rdate)+' · '+esc(ritem||''):'-')+'</span></div>'
     +'<div class="row"><span>검사 만료</span><span>'+dd(v.v_insp)+'</span></div>'
     +'<div class="row"><span>보험 만료</span><span>'+dd(v.v_ins)+'</span></div></div>';
  });
  return h+'</div>';
}
function acts(c,id){
  const canU=canWrite('update'),canD=canWrite('delete');
  return '<td><button class="btn g s" '+(canU?'':'disabled')+' onclick="openForm(\''+c+'\',\''+id+'\')">수정</button> <button class="btn g s" '+(canD?'':'disabled')+' onclick="del(\''+c+'\',\''+id+'\')">삭제</button></td>';
}
function table(c,heads,rows){
  if(!rows.length)return '<div class="card empty">기록이 없어요. 오른쪽 위 ＋ 버튼으로 추가해 보세요.</div>';
  return '<div class="tw"><table><tr>'+heads.map(x=>'<th>'+x+'</th>').join('')+'<th></th></tr>'+rows.join('')+'</table></div>';
}
function vehicles(){
  const rows=D.vehicles.slice().sort((a,b)=>(a.v_type+a.v_no).localeCompare(b.v_type+b.v_no)).map(v=>'<tr><td><b>'+esc(v.v_no)+'</b></td><td>'+esc(v.v_type)+'</td><td>'+esc(v.v_model)+'</td><td>'+esc(v.v_year)+'</td><td>'+esc(v.v_fueltype)+'</td><td>'+esc(v.v_vin)+'</td><td>'+esc(v.v_regdate)+'</td><td>'+dd(v.v_insp)+'</td><td>'+dd(v.v_ins)+'</td><td>'+esc(v.v_memo)+'</td>'+acts('vehicles',v.v_idx)+'</tr>');
  return table('vehicles',['차량번호','구분','모델','연식','연료','차대번호','등록일','검사 만료','보험 만료','비고'],rows);
}
function rfilter(){const k=q.trim().toLowerCase();return D.repairs.filter(x=>(!filt||String(x.v_idx)===String(filt))&&(!fm||(x.vr_date||'').startsWith(fm))&&(!k||[vname(x.v_idx),x.vr_item,x.vr_shop,x.vr_memo,x.vr_date].join(' ').toLowerCase().includes(k)))}
function rs(v){q=v;qs('#rl').innerHTML=repairs()}
function repairs(){
  const rows=rfilter().sort(byDate).map(r=>'<tr><td>'+esc(r.vr_date)+'</td><td>'+esc(vname(r.v_idx))+'</td><td>'+esc(r.vr_item)+'</td><td>'+esc(r.vr_shop)+'</td><td>'+won(r.vr_cost)+'</td><td>'+num(r.vr_odo)+'</td><td>'+esc(r.vr_memo)+'</td>'+acts('repairs',r.vr_idx)+'</tr>');
  const tot=rfilter().reduce((s,x)=>s+(Number(x.vr_cost)||0),0);
  return table('repairs',['수리일','차량','수리 내용','정비업체','비용','주행/가동','비고'],rows)+(rows.length?'<p class="sub">검색 결과 '+rows.length+'건 · 수리비 합계: <b>'+won(tot)+'</b></p>':'');
}
function ffilter(){const k=q.trim().toLowerCase();return D.fuel.filter(x=>(!filt||String(x.v_idx)===String(filt))&&(!cf||x.vf_card===cf)&&(!fm||(x.vf_date||'').startsWith(fm))&&(!k||[vname(x.v_idx),x.vf_station,x.vf_memo,x.vf_card,x.vf_date].join(' ').toLowerCase().includes(k)))}
function fs(v){q=v;qs('#fl').innerHTML=fuel()}
function fbar(){
  const cs=[...new Set(D.fuel.map(x=>x.vf_card).filter(Boolean))].sort();
  return '<select style="width:auto;min-width:130px" onchange="cf=this.value;render()"><option value="">전체 카드</option>'+cs.map(c=>'<option value="'+esc(c)+'"'+(c===cf?' selected':'')+'>카드 ****'+esc(c)+'</option>').join('')+'</select>'
   +'<input type="month" value="'+esc(fm)+'" onchange="fm=this.value;render()" style="width:auto" title="월별 조회">'
   +'<input type="search" placeholder="🔍 카드번호·주유소·메모" value="'+esc(q)+'" oninput="fs(this.value)" style="flex:1;min-width:160px;width:auto">'
   +'<button type="button" class="btn g s" onclick="filt=\'\';cf=\'\';fm=\'\';q=\'\';render()">초기화</button>';
}
function fuel(){
  const list=ffilter().sort(byDate);
  const rows=list.map(r=>'<tr><td>'+esc(r.vf_date)+'</td><td>'+esc(vname(r.v_idx))+'</td><td>'+(r.gap_days!=null?r.gap_days+'일':'-')+'</td><td>'+num(r.vf_liter)+'</td><td>'+won(r.vf_cost)+'</td><td>'+(r.vf_card?'****'+esc(r.vf_card):'-')+'</td><td>'+num(r.vf_odo)+'</td><td>'+esc(r.vf_station)+'</td><td>'+esc(r.vf_memo)+'</td>'+acts('fuel',r.vf_idx)+'</tr>');
  const L=list.reduce((s,x)=>s+(Number(x.vf_liter)||0),0),C=list.reduce((s,x)=>s+(Number(x.vf_cost)||0),0);
  const bc={};list.forEach(x=>{const k=x.vf_card||'';const b=bc[k]=bc[k]||{c:0,n:0,l:0};b.c+=Number(x.vf_cost)||0;b.n++;b.l+=Number(x.vf_liter)||0});
  const chips=Object.keys(bc).sort().map(k=>'<div class="card stat" style="padding:10px 12px"><span class="sub">'+(k?'카드 ****'+esc(k):'카드 미입력')+'</span><b>'+won(bc[k].c)+'</b><span class="sub">'+bc[k].n+'회 · '+num(bc[k].l)+'L</span></div>').join('');
  return (rows.length?'<div class="sub" style="margin-bottom:6px">검색 결과 '+rows.length+'건 · 총 금액 <b>'+won(C)+'</b> · 주유량 <b>'+num(L)+'L</b></div><div class="stats">'+chips+'</div>':'')+table('fuel',['주유일','차량','이전 주유 후','주유량(L)','금액','카드','주행거리(km)','주유소','비고'],rows);
}
function rdata(){
  const inM=x=>(x._date||'').startsWith(rm)&&(!filt||String(x.v_idx)===String(filt));
  const srt=(a,b)=>(a._date||'').localeCompare(b._date||'');
  return {R:D.repairs.filter(inM).sort(srt),F:D.fuel.filter(inM).sort(srt),vs:D.vehicles.filter(v=>!filt||String(v.v_idx)===String(filt)).sort((a,b)=>(a.v_type+a.v_no).localeCompare(b.v_type+b.v_no))};
}
const sm=(a,k)=>a.reduce((s,x)=>s+(Number(x[k])||0),0);
function rtitle(){const p=rm.split('-');return p[0]+'년 '+Number(p[1])+'월'}
function repbar(){
  return '<div class="bar noprint"><div style="display:flex;gap:8px;flex-wrap:wrap;flex:1"><input type="month" value="'+esc(rm)+'" onchange="rm=this.value||rm;render()" style="width:auto" title="마감 월">'+vsel()+'</div><div style="display:flex;gap:6px;flex-wrap:wrap"><button class="btn" onclick="doPrint()">🖨 출력</button><button class="btn g" onclick="saveHtml()">보고서 저장</button><button class="btn g" onclick="saveCsv()">CSV 저장</button></div></div>';
}
function report(){
  const d=rdata(),R=d.R,F=d.F,vs=d.vs,fc=sm(F,'vf_cost'),rc=sm(R,'vr_cost');
  const T=(heads,rows)=>rows.length?'<div class="tw"><table><tr>'+heads.map(x=>'<th>'+x+'</th>').join('')+'</tr>'+rows.join('')+'</table></div>':'<div class="sub" style="padding:4px 0">해당 월 기록 없음</div>';
  const vrows=vs.map(v=>{const f=F.filter(x=>String(x.v_idx)===String(v.v_idx)),r=R.filter(x=>String(x.v_idx)===String(v.v_idx));return '<tr><td><b>'+esc(v.v_no)+'</b></td><td>'+esc(v.v_type)+'</td><td>'+f.length+'회</td><td>'+num(sm(f,'vf_liter'))+'</td><td>'+won(sm(f,'vf_cost'))+'</td><td>'+r.length+'건</td><td>'+won(sm(r,'vr_cost'))+'</td><td><b>'+won(sm(f,'vf_cost')+sm(r,'vr_cost'))+'</b></td></tr>'});
  if(vrows.length)vrows.push('<tr><td colspan="2"><b>합계</b></td><td>'+F.length+'회</td><td>'+num(sm(F,'vf_liter'))+'</td><td>'+won(fc)+'</td><td>'+R.length+'건</td><td>'+won(rc)+'</td><td><b>'+won(fc+rc)+'</b></td></tr>');
  const cd={};F.forEach(x=>{const k=x.vf_card||'';const b=cd[k]=cd[k]||{n:0,c:0,l:0};b.n++;b.c+=Number(x.vf_cost)||0;b.l+=Number(x.vf_liter)||0});
  const crows=Object.keys(cd).sort().map(k=>'<tr><td>'+(k?'****'+esc(k):'카드 미입력')+'</td><td>'+cd[k].n+'회</td><td>'+num(cd[k].l)+'</td><td>'+won(cd[k].c)+'</td></tr>');
  const rrows=R.map(r=>'<tr><td>'+esc(r.vr_date)+'</td><td>'+esc(vname(r.v_idx))+'</td><td>'+esc(r.vr_item)+'</td><td>'+esc(r.vr_shop)+'</td><td>'+won(r.vr_cost)+'</td><td>'+esc(r.vr_memo)+'</td></tr>');
  const frows=F.map(r=>'<tr><td>'+esc(r.vf_date)+'</td><td>'+esc(vname(r.v_idx))+'</td><td>'+num(r.vf_liter)+'</td><td>'+won(r.vf_cost)+'</td><td>'+(r.vf_card?'****'+esc(r.vf_card):'-')+'</td><td>'+num(r.vf_odo)+'</td><td>'+esc(r.vf_station)+'</td></tr>');
  const st=(l,v)=>'<div class="card stat"><span class="sub">'+l+'</span><b>'+v+'</b></div>';
  return '<div id="rep" class="rep"><h2 style="margin:6px 0 2px">'+rtitle()+' 차량 월마감 보고서</h2><div class="sub">대상: '+esc(filt?vname(filt):'전체 차량')+' · 출력일 '+iso(today())+'</div>'
   +'<div class="stats">'+st('주유금액',won(fc))+st('주유량',num(sm(F,'vf_liter'))+'L')+st('수리비',won(rc))+st('마감 합계',won(fc+rc))+'</div>'
   +'<h3>1. 차량별 요약</h3>'+T(['차량','구분','주유횟수','주유량(L)','주유금액','수리건수','수리비','합계'],vrows)
   +'<h3>2. 카드별 주유 사용금액</h3>'+T(['카드(뒷자리)','횟수','주유량(L)','사용금액'],crows)
   +'<h3>3. 수리이력</h3>'+T(['수리일','차량','수리 내용','정비업체','비용','비고'],rrows)
   +'<h3>4. 주유일지</h3>'+T(['주유일','차량','주유량(L)','금액','카드','주행거리(km)','주유소'],frows)
   +'<div style="display:flex;justify-content:flex-end;margin-top:22px"><table style="width:auto"><tr><th style="width:90px;text-align:center">담당</th><th style="width:90px;text-align:center">검토</th><th style="width:90px;text-align:center">승인</th></tr><tr><td style="height:56px"></td><td></td><td></td></tr></table></div></div>';
}
function doPrint(){try{window.print()}catch(e){alert('이 화면에서는 인쇄가 막혀 있어요. [보고서 저장] 후 파일을 열어 인쇄해 주세요.')}}
function saveHtml(){
  downloadBlob('차량월마감_'+rm+'.html','<!DOCTYPE html><html lang="ko"><head><meta charset="utf-8"><title>'+rtitle()+' 차량 월마감 보고서</title><style>body{font:13px/1.5 sans-serif;padding:20px;color:#000}table{border-collapse:collapse;width:100%}th,td{border:1px solid #999;padding:4px 8px;text-align:left}h3{margin:16px 0 6px}.stats{display:flex;gap:12px;flex-wrap:wrap}.card{border:1px solid #999;padding:6px 12px}.stat b{display:block}.sub{color:#555}</style></head><body>'+qs('#rep').innerHTML+'</body></html>','text/html');
}
function saveCsv(){
  const d=rdata(),c=v=>'"'+String(v==null?'':v).replace(/"/g,'""')+'"',ln=a=>a.map(c).join(',');
  const o=['[수리이력] '+rtitle(),ln(['수리일','차량','수리 내용','정비업체','비용(원)','주행/가동','비고'])];
  d.R.forEach(r=>o.push(ln([r.vr_date,vname(r.v_idx),r.vr_item,r.vr_shop,r.vr_cost,r.vr_odo,r.vr_memo])));
  o.push('','[주유일지] '+rtitle(),ln(['주유일','차량','주유량(L)','금액(원)','카드 뒷자리','주행거리(km)','주유소','비고']));
  d.F.forEach(r=>o.push(ln([r.vf_date,vname(r.v_idx),r.vf_liter,r.vf_cost,r.vf_card?'****'+r.vf_card:'',r.vf_odo,r.vf_station,r.vf_memo])));
  downloadBlob('차량월마감_'+rm+'.csv','﻿'+o.join('\r\n'),'text/csv');
}
function render(){
  qs('#nav').innerHTML=TABS.map(([k,l])=>'<button class="'+(k===tab?'on':'')+'" onclick="setTab(\''+k+'\')">'+l+'</button>').join('');
  qs('#st').textContent='저장소 연결됨 · 실시간은 새로고침 기준으로 반영됩니다';
  let h='';
  const addBtn=canWrite('create')?'':' disabled';
  if(tab==='rep')h+=repbar();else if(tab!=='dash'){
    h+='<div class="bar"><div style="display:flex;gap:8px;flex-wrap:wrap;flex:1">'+(tab==='vehicles'?'':vsel())+(tab==='repairs'?'<input type="month" value="'+esc(fm)+'" onchange="fm=this.value;render()" style="width:auto" title="년/월별 조회"><input type="search" placeholder="🔍 차량번호·수리내용·업체·메모 검색" value="'+esc(q)+'" oninput="rs(this.value)" style="flex:1;min-width:200px;width:auto"><button type="button" class="btn g s" onclick="filt=\'\';fm=\'\';q=\'\';render()">초기화</button>':'')+(tab==='fuel'?fbar():'')+'</div><button class="btn insert-button"'+addBtn+' onclick="openForm(\''+tab+'\')">＋ '+TITLE[tab]+' 추가</button></div>';
  }
  h+=tab==='repairs'?'<div id="rl">'+repairs()+'</div>':tab==='fuel'?'<div id="fl">'+fuel()+'</div>':({dash,vehicles,repairs,fuel,rep:report})[tab]();
  qs('#app').innerHTML=h;
}
$(function(){
  if (typeof userInfoList === 'function') userInfoList(now_page_code);
  loadAll();
});
</script></body></html>
