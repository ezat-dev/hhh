<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통합모니터링</title>
    <!-- 
    <link rel="stylesheet" href="/tkheat/css/monitoring/monitoring2.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
     -->
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

.tabulator-header > .tabulator-headers > .tabulator-col > .tabulator-col-content > .tabulator-col-title-holder > .tabulator-col-title{
	font-size: 20pt !important;
}

.tabulator .tabulator-row {
    display: flex !important;
    align-items: stretch !important; /* 모든 셀의 높이를 동일하게 확장 */
    height: 90px !important;         /* 고정 높이 대신 내용에 맞춤 */
}

.tabulator .tabulator-row .tabulator-cell {
    height: auto !important;         /* 고정값 해제 */
    display: flex;                   /* 내용물 중앙 정렬을 위함 */
    align-items: center;             /* 세로 중앙 정렬 */
    border-right: 1px solid #ddd !important; /* 세로선이 확실히 보이게 설정 */
}

/*타뷸레이터 선 설정*/
.tabulator, 
.tabulator-header .tabulator-col, 
.tabulator-row .tabulator-cell {
    border: 1px solid #444 !important; /* 1px만 해도 색상을 진하게(#444) 하면 훨씬 굵어 보입니다 */
}

/* 셀 내부 텍스트 위치 조정 */
.tabulator .tabulator-row .tabulator-cell {
    padding: 8px !important;
    display: flex;
    align-items: center;
}

/*타뷸레이터 헤더 색상*/
.tabulator-header {
   /* background-color: #bde295 !important;  연두색 계열 */
    color: #000000 !important;           /* 글자색 검정색 */
    /*border-bottom: 1px solid #2c3e50 !important;*/
}

.tabulator-header .tabulator-col {
    background-color: #bde295 !important;
}

.col-hogi {
	color: #000000 !important;
    background-color: #bde295 !important; /* 연두색 */
}

.col-corpname {
	color: #000000 !important;
    background-color: #e9f5dd !important; /* 연두색 */
}

.col-prodname {
	color: #000000 !important;
    background-color: #e9f5dd !important; /* 연두색 */
}

.col-lot {
	color: #000000 !important;
    background-color: #e9f5dd !important; /* 연두색 */
}


  </style>
    
    
<body>
	<div class="container">
		<div id="workTabu"></div>
	</div>
<script>

/*전역변수*/
var serachInterval;

/*로드*/
$(function(){
	getWorkData();
	getWorkDataList();
	serachInterval = setInterval("getWorkDataList()",2000);
});

/*함수*/
	//작업지시관리NEW 전체이력 조회
	function getWorkDataList(){
		
		$.ajax({
			url:"/tkheat/monitoring/monitoringDataList",
			type:"post",
			dataType:"json",
			data:{
			},
			success:function(result){
				workDataTable.setData(result.data);
			}
		});
	}
	
	
	function statusFormatter(cell){
		var value = cell.getValue();
	    var el = cell.getElement(); // 셀의 DOM 요소 가져오기

	    if (value == 1) {
	        el.style.backgroundColor = "#ebf5fb"; // 연한 파랑
	        el.style.color = "#000000";           /* 글자색 검정 */
	    } else if (value == 0) {
	        el.style.backgroundColor = "#e0e0e0"; // 회색
	        el.style.color = "#888888";           /* 글자색 흐리게 */
	    }
	    
	    return value; // 화면에는 원래 값(1 또는 0) 표시		
	}
	
	var workDataTable;
	function getWorkData(){
		
		workDataTable = new Tabulator("#workTabu", {
		    height:"950px",
		    layout:"fitColumns",
//		    selectable:true,	//로우 선택설정
//		    tooltips:true,
		    selectableRangeMode:"click",
		    reactiveData:true,
		    headerHozAlign:"center",
		    placeholder:"조회된 데이터가 없습니다.",
		    paginationSize:20,
		    headerSort:false,
		    ajaxResponse:function(url, params, response){
				$("#workTabu .tabulator-col.tabulator-sortable").css("height","30px");
		        return response; //return the response data to tabulator
		    },
		    columns:[	 		    	
		        {title:"설비", field:"fac_name_view", sorter:"string", width:80,
		        	hozAlign:"center", cssClass:"col-hogi",
	        		// 커스텀 포맷터 함수
	        	    formatter: function(cell, formatterParams, onRendered) {
	        	        var value = cell.getValue();
	        	        if (value) {
	        	            // 모든 세미콜론(;)을 <br> 태그로 변경
	        	            return value.split(";").join("<br>");
	        	        }
	        	        return value;
	        	    }
		       	},
		        {title:"구분", field:"proc_gb_view", sorter:"string", width:70,
		        	hozAlign:"center",cssClass:"col-lot"},
		        {title:"고객사", field:"corp_name", sorter:"string", width:200,
			        hozAlign:"left", cssClass:"col-corpname",
			     // 커스텀 포맷터 함수
	        	    formatter: function(cell, formatterParams, onRendered) {
	        	        var value = cell.getValue();
	        	        if (value) {
	        	            // 모든 세미콜론(;)을 <br> 태그로 변경
	        	            return value.split(";").join("<br>");
	        	        }
	        	        return value;
	        	    }},	
		        {title:"품명", field:"prod_name", sorter:"string", width:300,
		        	hozAlign:"left", cssClass:"col-prodname",
		        	// 커스텀 포맷터 함수
	        	    formatter: function(cell, formatterParams, onRendered) {
	        	        var value = cell.getValue();
	        	        if (value) {
	        	            // 모든 세미콜론(;)을 <br> 태그로 변경
	        	            return value.split(";").join("<br>");
	        	        }
	        	        return value;
	        	    }},		        
		        {title:"LOT", field:"ilbo_lot", sorter:"string", width:150,
		        	hozAlign:"center",cssClass:"col-lot"},
		        {title:"설비온도", field:"temp_view", sorter:"string", width:140,
		        	hozAlign:"center",cssClass:"col-lot",
		        	formatter: function(cell, formatterParams, onRendered) {
	        	        var value = cell.getValue();
	        	        if (value) {
//	        	            cell.getElement().style.backgroundColor = "#cbeffc";
	        	            // 모든 세미콜론(;)을 <br> 태그로 변경
	        	            return value.split(";").join("<br>");
	        	        }else{
//	        	        	cell.getElement().style.backgroundColor = "#e0e0e0";
	        	        }
	        	        return value;
	        	    }
		       	},
		        {title:"승온", field:"bcf_up_view", sorter:"string", width:160,
		        		hozAlign:"left",
		        		// 커스텀 포맷터 함수
		        	    formatter: function(cell, formatterParams, onRendered) {
		        	        var value = cell.getValue();
		        	        if (value) {
		        	            cell.getElement().style.backgroundColor = "#cbeffc";
		        	            // 모든 세미콜론(;)을 <br> 태그로 변경
		        	            return value.split(";").join("<br>");
		        	        }else{
		        	        	cell.getElement().style.backgroundColor = "#e0e0e0";
		        	        }
		        	        return value;
		        	    }},
		        {title:"예열", field:"bcf_pre_view", sorter:"string", width:160,
		        		hozAlign:"left",
		        		// 커스텀 포맷터 함수
		        	    formatter: function(cell, formatterParams, onRendered) {
		        	        var value = cell.getValue();
		        	        if (value) {
		        	            cell.getElement().style.backgroundColor = "#cbeffc";
		        	            // 모든 세미콜론(;)을 <br> 태그로 변경
		        	            return value.split(";").join("<br>");
		        	        }else{
		        	        	cell.getElement().style.backgroundColor = "#e0e0e0";
		        	        }
		        	        return value;
		        	    }
		        },		        	
		        {title:"침탄", field:"bcf_chim_view", sorter:"string", width:160,
		        	hozAlign:"left",
	        		// 커스텀 포맷터 함수
	        	    formatter: function(cell, formatterParams, onRendered) {
	        	        var value = cell.getValue();
	        	        if (value) {
	        	        	cell.getElement().style.backgroundColor = "#cbeffc";
	        	            // 모든 세미콜론(;)을 <br> 태그로 변경
	        	            return value.split(";").join("<br>");
	        	        }else{
	        	        	cell.getElement().style.backgroundColor = "#e0e0e0";
	        	        }
	        	        return value;
	        	    }},
		        {title:"확산", field:"bcf_diff_view", sorter:"string", width:160,
	        	    	hozAlign:"left",
		        		// 커스텀 포맷터 함수
		        	    formatter: function(cell, formatterParams, onRendered) {
		        	        var value = cell.getValue();
		        	        if (value) {
		        	        	cell.getElement().style.backgroundColor = "#cbeffc";
		        	            // 모든 세미콜론(;)을 <br> 태그로 변경
		        	            return value.split(";").join("<br>");
		        	        }else{
		        	        	cell.getElement().style.backgroundColor = "#e0e0e0";
		        	        }
		        	        return value;
		        	    }},
		        {title:"강온", field:"bcf_gang_view", sorter:"string", width:160,
		        	    	hozAlign:"left",
			        		// 커스텀 포맷터 함수
			        	    formatter: function(cell, formatterParams, onRendered) {
			        	        var value = cell.getValue();
			        	        if (value) {
			        	        	cell.getElement().style.backgroundColor = "#cbeffc";
			        	            // 모든 세미콜론(;)을 <br> 태그로 변경
			        	            return value.split(";").join("<br>");
			        	        }else{
			        	        	cell.getElement().style.backgroundColor = "#e0e0e0";
			        	        }
			        	        return value;
			        	    }},
		        {title:"냉각", field:"bcf_cold_view", sorter:"string", width:160,
			        	    	hozAlign:"left",
				        		// 커스텀 포맷터 함수
				        	    formatter: function(cell, formatterParams, onRendered) {
				        	        var value = cell.getValue();
				        	        if (value) {
				        	        	cell.getElement().style.backgroundColor = "#cbeffc";
				        	            // 모든 세미콜론(;)을 <br> 태그로 변경
				        	            return value.split(";").join("<br>");
				        	        }else{
				        	        	cell.getElement().style.backgroundColor = "#e0e0e0";
				        	        }
				        	        return value;
				        	    }
			     },
/*			     
		        {title:"템퍼링", field:"bcf_cold_view", sorter:"string", width:140,
			        	    	hozAlign:"left",
				        		// 커스텀 포맷터 함수
				        	    formatter: function(cell, formatterParams, onRendered) {
				        	        var value = cell.getValue();
				        	        if (value) {
				        	        	cell.getElement().style.backgroundColor = "#cbeffc";
				        	            // 모든 세미콜론(;)을 <br> 태그로 변경
				        	            return value.split(";").join("<br>");
				        	        }else{
				        	        	cell.getElement().style.backgroundColor = "#e0e0e0";
				        	        }
				        	        return value;
				        	    }
			     },
*/
		    ],
		    rowFormatter:function(row){
			    var data = row.getData();
			    
			    row.getElement().style.fontWeight = "700";
				row.getElement().style.backgroundColor = "#FFFFFF";
				row.getElement().style.fontSize = "14pt";
			},
			rowClick:function(e, row){

				$("#workTabu .tabulator-tableHolder > .tabulator-table > .tabulator-row").each(function(index, item){
						
					if($(this).hasClass("row_select")){							
						$(this).removeClass('row_select');
						row.getElement().className += " row_select";
					}else{
						$("#workTabu div.row_select").removeClass("row_select");
						row.getElement().className += " row_select";	
					}
				});
			}
		});		

	}

</script>
</body>
</html>
