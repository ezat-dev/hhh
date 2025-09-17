<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통합모니터링</title>
    <link rel="stylesheet" href="/tkheat/css/monitoring/monitoring2.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
<style>
    html, body {
  height: 100%;
  margin: 0;
  padding: 0;
  font-family: sans-serif;
  font-size: 14pt;
  font-weight: 800;
}

body {
  display: flex;
  flex-direction: column;
}

table {
  flex: 1;
  width: 100%;
  border-collapse: collapse;
  table-layout: fixed;
}

tbody > tr{
	height:150px;
}

th, td {
  border: 1px solid #333;
  padding: 8px;
  text-align: center;
  word-wrap: break-word;
}
td{
  
  min-height: 50px;            /* 최소 높이 유지 */
  height: 50px;                /* 고정 높이 (필요 시 조정) */
  line-height: 1.2;            /* 줄 간격 */
  white-space: nowrap;         /* 줄바꿈 방지 */
  vertical-align: middle;      /* 수직 정렬 */
  empty-cells: show;           /* 비어 있는 셀도 테두리 표시 */
}

th.header {
  background-color: #bde295;
}

td#cbeffc {
  background-color: #cbeffc;
}

td#e9f5dd {
  background-color: #e9f5dd;
}

td#bde295 {
  background-color: #bde295;
}
#cutum{
  background-color: #e9f5dd;
  
}
#prod{
  background-color: #cbeffc;
}
  </style>
    
    
    <body>
  <table>
    <thead>
      <tr>
        <th class="header" style="width: 120px;">구분</th>
        <th class="header" style="width: 160px;">고객사</th>
        <th class="header" style="width: 280px;">품명</th>
        <th class="header" style="width: 140px;">LOT</th>
<!--          <th class="header">승온</th>-->
        <th class="header" style="width: 170px;">예열</th>
        <th class="header" style="width: 170px;">침탄</th>
        <th class="header" style="width: 170px;">확산</th>
        <th class="header" style="width: 170px;">강온</th>
        <th class="header" style="width: 170px;">냉각</th>
        <th class="header" style="width: 170px;">출구</th>
<!--          <th class="header">대기</th>-->
      </tr>
    </thead>
    <tbody>
    
    
      
    <tr>
      <th class="header">열처리 1호기</th>
      <td class="bcf1-cutum-1" id="cutum"></td>
      <td class="bcf1-pum-1" id="cutum"></td>
      <td class="bcf1-lot-1" id="cutum"></td>
<!--       <td class="bcf1-heat-1" id="prod"></td> -->
      <td class="bcf1-pre-1" id="prod"></td>
      <td class="bcf1-chim-1" id="prod"></td>
      <td class="bcf1-diff-1" id="prod"></td>
      <td class="bcf1-gang-1" id="prod"></td>
      <td class="bcf1-cold-1" id="prod"></td>
      <td class="bcf1-chul-1" id="prod"></td>
<!--        <td class="bcf1-spare-1" id="prod"></td>-->
    </tr>

    <tr>
      <th class="header">열처리 2호기</th>
      <td class="bcf2-cutum-1" id="cutum"></td>
      <td class="bcf2-pum-1" id="cutum"></td>
      <td class="bcf2-lot-1" id="cutum"></td>
<!--        <td class="bcf2-heat-1" id="prod"></td>-->
      <td class="bcf2-pre-1" id="prod"></td>
      <td class="bcf2-chim-1" id="prod"></td>
      <td class="bcf2-diff-1" id="prod"></td>
      <td class="bcf2-gang-1" id="prod"></td>
      <td class="bcf2-cold-1" id="prod"></td>
      <td class="bcf2-chul-1" id="prod"></td>
<!--       <td class="bcf2-spare-1" id="prod"></td> -->
    </tr>
    

    <tr>
      <th class="header">열처리 3호기</th>
      <td class="bcf3-cutum-1" id="cutum"></td>
      <td class="bcf3-pum-1" id="cutum"></td>
      <td class="bcf3-lot-1" id="cutum"></td>
<!--        <td class="bcf3-heat-1" id="prod"></td>-->
      <td class="bcf3-pre-1" id="prod"></td>
      <td class="bcf3-chim-1" id="prod"></td>
      <td class="bcf3-diff-1" id="prod"></td>
      <td class="bcf3-gang-1" id="prod"></td>
      <td class="bcf3-cold-1" id="prod"></td>
      <td class="bcf3-chul-1" id="prod"></td>
<!--       <td class="bcf3-spare-1" id="prod"></td> -->
    </tr>

    <tr>
      <th class="header">열처리 4호기</th>
      <td class="bcf4-cutum-1" id="cutum"></td>
      <td class="bcf4-pum-1" id="cutum"></td>
      <td class="bcf4-lot-1" id="cutum"></td>
<!--        <td class="bcf4-heat-1" id="prod"></td>-->
      <td class="bcf4-pre-1" id="prod"></td>
      <td class="bcf4-chim-1" id="prod"></td>
      <td class="bcf4-diff-1" id="prod"></td>
      <td class="bcf4-gang-1" id="prod"></td>
      <td class="bcf4-cold-1" id="prod"></td>
      <td class="bcf4-chul-1" id="prod"></td>
<!--       <td class="bcf4-spare-1" id="prod"></td> -->
    </tr>

    <tr>
      <th class="header">열처리 5호기</th>
      <td class="bcf5-cutum-1" id="cutum"></td>
      <td class="bcf5-pum-1" id="cutum"></td>
      <td class="bcf5-lot-1" id="cutum"></td>
<!--       <td class="bcf5-heat-1" id="prod"></td> -->
      <td class="bcf5-pre-1" id="prod"></td>
      <td class="bcf5-chim-1" id="prod"></td>
      <td class="bcf5-diff-1" id="prod"></td>
      <td class="bcf5-gang-1" id="prod"></td>
      <td class="bcf5-cold-1" id="prod"></td>
      <td class="bcf5-chul-1" id="prod"></td>
<!--       <td class="bcf5-spare-1" id="prod"></td> -->
    </tr>
    <tr>
      <th class="header"  rowspan="2">템퍼링 1호기</th>
      <td  id="cutum">고객사</td>
      <td  id="cutum">품명</td>
      <td  id="cutum">LOT</td>
      <td  id="prod" colspan="2.67">대기</td>
      <td  id="prod" colspan="2.67">템퍼링1존</td>
      <td  id="prod" colspan="2.67">템퍼링2존</td>
      <td  id="prod" colspan="2">템퍼링3존</td>
    </tr>
    

    <tr>
      <td class="tf1-cutum-1" id="cutum"></td>
      <td class="tf1-pum-1" id="cutum"></td>
      <td class="tf1-lot-1" id="cutum"></td>
      <td class="tf1-spare-1" id="prod" colspan="2.67"></td>
      <td class="tf1-zone-1" id="prod" colspan="2.67"></td>
      <td class="tf1-zone-2" id="prod" colspan="2.67"></td>
      <td class="tf1-zone-3" id="prod" colspan="2"></td>
    </tr>


    <tr>
      <th class="header"  rowspan="2">세정기</th>
      <td  id="cutum">고객사</td>
      <td  id="cutum">품명</td>
      <td  id="cutum">LOT</td>
      <td  id="prod" colspan="2.67">대기</td>
      <td  id="prod" colspan="6">시간</td>
    </tr>


    <tr>
      <td class="wm1-cutum-1" id="cutum"></td>
      <td class="wm1-pum-1" id="cutum"></td>
      <td class="wm1-lot-1" id="cutum"></td>
      <td class="wm1-spare-1" id="prod" colspan="2.67"></td>
      <td class="wm1-time-1" id="prod" colspan="6"></td>
    </tr>
    
    </tbody>
  </table>
<script>

/*전역변수*/
var serachInterval;

/*로드*/
$(function(){
	getMonitoringData();
	serachInterval = setInterval("getMonitoringData()",2000);
});


/*함수*/
function getMonitoringData(){
	$.ajax({
		url:"/tkheat/monitoring/monitoringDataList",
		type:"post",
		dataType:"json",
		success:function(result){			
			var data = result.data;
			
			for(var d in data){
				
				var i=0;
				
				var cutum_ = "";
				var pum_ = "";
				var pre_ = "";
				var chim_ = "";
				var diff_ = "";
				var gang_ = "";
				var cold_ = "";
				var chul_ = "";
				
				var cutumSplit, pumSplit, preSplit, chimSplit, diffSplit, gangSplit;
				var coldSplit, chulSplit;
				
				if(data[d].cutum != null){
					cutumSplit = data[d].cutum.split(";");
					
					if(cutumSplit != null){
						for(var i1=0; i1<cutumSplit.length; i1++){
							cutum_ += "<span>"+cutumSplit[i1]+"</span>";
							
							if(i1 < cutumSplit.length){
								cutum_ += "<br/>";
							}
						}
					}
				}
				
				if(data[d].pum != null){
					pumSplit = data[d].pum.split(";");
					
					if(pumSplit != null){
						for(var i2=0; i2<pumSplit.length; i2++){
							pum_ += "<span>"+pumSplit[i2]+"</span>";
							
							if(i2 < pumSplit.length){
								pum_ += "<br/>";
							}
						}
					}
				}
				
				
				//예열
				if(data[d].pre != null){
					preSplit = data[d].pre.split(";");
					
					if(preSplit != null){
						for(var i3=0; i3<preSplit.length; i3++){
							pre_ += "<span>"+preSplit[i3]+"</span>";
							
							if(i3 < preSplit.length){
								pre_ += "<br/>";
							}
						}
					}
				}
				
				//침탄
				if(data[d].chim != null){
					chimSplit = data[d].chim.split(";");
					
					if(chimSplit != null){
						for(var i4=0; i4<chimSplit.length; i4++){
							chim_ += "<span>"+chimSplit[i4]+"</span>";
							
							if(i4 < chimSplit.length){
								chim_ += "<br/>";
							}
						}
					}
				}
				
				//확산
				if(data[d].diff != null){
					diffSplit = data[d].diff.split(";");
					
					if(diffSplit != null){
						for(var i5=0; i5<diffSplit.length; i5++){
							diff_ += "<span>"+diffSplit[i5]+"</span>";
							
							if(i5 < diffSplit.length){
								diff_ += "<br/>";
							}
						}
					}
				}
				
				//강온
				if(data[d].gang != null){
					gangSplit = data[d].gang.split(";");
					
					if(gangSplit != null){
						for(var i6=0; i6<gangSplit.length; i6++){
							gang_ += "<span>"+gangSplit[i6]+"</span>";
							
							if(i6 < gangSplit.length){
								gang_ += "<br/>";
							}
						}
					}
				}
				
				//냉각
				if(data[d].cold != null){
					coldSplit = data[d].cold.split(";");
					
					if(coldSplit != null){
						for(var i7=0; i7<coldSplit.length; i7++){
							cold_ += "<span>"+coldSplit[i7]+"</span>";
							
							if(i7 < coldSplit.length){
								cold_ += "<br/>";
							}
						}
					}
				}
				
				//출구
				if(data[d].chul != null){
					chulSplit = data[d].chul.split(";");
					
					if(chulSplit != null){
						for(var i8=0; i8<chulSplit.length; i8++){
							chul_ += "<span>"+chulSplit[i8]+"</span>";
							
							if(i8 < chulSplit.length){
								chul_ += "<br/>";
							}
						}
					}
				}
				
				$("."+data[d].hogi+"-cutum-"+data[d].hogi_idx).empty().append(cutum_);
				$("."+data[d].hogi+"-pum-"+data[d].hogi_idx).empty().append(pum_);
				$("."+data[d].hogi+"-lot-"+data[d].hogi_idx).text(data[d].lot);
				$("."+data[d].hogi+"-pre-"+data[d].hogi_idx).empty().append(pre_);
				$("."+data[d].hogi+"-chim-"+data[d].hogi_idx).empty().append(chim_);
				$("."+data[d].hogi+"-diff-"+data[d].hogi_idx).empty().append(diff_);
				$("."+data[d].hogi+"-gang-"+data[d].hogi_idx).empty().append(gang_);
				$("."+data[d].hogi+"-cold-"+data[d].hogi_idx).empty().append(cold_);
				$("."+data[d].hogi+"-chul-"+data[d].hogi_idx).empty().append(chul_);
				
			}
		}
	});
}


</script>
</body>
</html>
