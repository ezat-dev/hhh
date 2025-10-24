<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일일매출현황</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
    <style>
    
        .main{
            width:98%;
        }
        .container {
            display: flex;
            justify-content: space-between;
        }
        .tabulator {
            width: 100%;
            max-width: 100%;
            max-height: 900px;
            overflow-x: hidden !important;  
        }
        .tabulator .tabulator-cell {
            white-space: normal !important;
            word-break: break-word; 
            text-align: center;
        }
        .row_select{
            background-color:#9ABCEA !important;
        }
        .box1 {
            display: flex;
            justify-content: right;
            align-items: center;
            width: 1500px;
            margin-left: -760px;
        }
        .box1 input{
            width: 150px;
            padding: 5px 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f9f9f9;
            color: #333;
            outline: none;
            transition: border 0.3s ease;
        }
        .box1 input:focus {
            border: 1px solid #007bff;
            background-color: #fff;
        }  
        .box1 label,
        .box1 input {
            margin-right: 10px; /* 요소 사이 간격 */
        }     
        .button-container {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="tab">
    <div class="box1">
        <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>

        <label class="daylabel">조회기간 : </label>
        <input type="date" class="sdate" id="sdate" autocomplete="off">
        <label>~</label>
        <input type="date" class="edate" id="edate" autocomplete="off">

        <label class="daylabel">거래처 :</label>
        <input type="text" class="corp_name" id="corp_name" autocomplete="off">
    </div>

    <div class="button-container">
        <button class="select-button" onclick="getDaySaleList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image"> 조회
        </button>
        <button class="insert-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image"> 입력 
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image"> 엑셀    
        </button>
        <button class="printer-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image"> 보고서출력     
        </button>
    </div>
</div>

<main class="main">
    <div class="container">
        <div id="tab1" class="tabulator"></div>
    </div>
</main>

<script>
var dayTable;

//페이지 로드 시
$(function(){
 var tdate = todayDate();       // 오늘
 var ydate = yesterDate();      // 어제
 $("#sdate").val(ydate);
 $("#edate").val(tdate);

 getDaySaleList();
});

function getDaySaleList(){
 dayTable = new Tabulator("#tab1", {
     height:"650px",
     layout:"fitColumns",
     selectable:true,
     tooltips:true,
     selectableRangeMode:"click",
     reactiveData:true,
     headerHozAlign:"center",
     ajaxConfig:"POST",
     ajaxLoader:false,
     ajaxURL:"/tkheat/operation/daySale/getDaySaleList",
     ajaxParams:{
         "sdate": $("#sdate").val(),
         "edate": $("#edate").val(),
         "corp_name": $("#corp_name").val()
     },
     placeholder:"조회된 데이터가 없습니다.",
     paginationSize:20,
     ajaxResponse:function(url, params, response){
    	    if(response && Array.isArray(response)){
    	        return response;  // 이미 배열이면 그대로 사용
    	    } else if(response && response.data && Array.isArray(response.data)){
    	        return response.data;  // 서버가 {data:[...]} 구조면 이걸 사용
    	    } else if(response && response.result && Array.isArray(response.result)){
    	        return response.result;  // 서버가 {result:[...]} 구조면 이걸 사용
    	    } else {
    	        console.warn("서버에서 받은 데이터가 배열이 아닙니다:", response);
    	        return []; // Tabulator 오류 방지
    	    }
    	},

     groupBy: "och_date", // 일별 그룹
     columns:[
         {title:"NO", field:"idx", sorter:"int", width:80, hozAlign:"center"},
         {title:"출고일", field:"och_date", sorter:"string", width:120, hozAlign:"center"},
         {title:"거래처", field:"corp_name", sorter:"string", width:140, hozAlign:"center", headerFilter:"input"},
         {title:"품명", field:"prod_name", sorter:"string", width:160, hozAlign:"center", headerFilter:"input"},
         {title:"품번", field:"prod_no", sorter:"string", width:160, hozAlign:"center", headerFilter:"input"},
         {title:"수량", field:"och_su", sorter:"int", width:110, hozAlign:"center",
             formatter: "money",
             formatterParams: { decimal: ".", thousand: ",", precision: 0 },
             bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
         },
         {title:"단가", field:"och_dang", sorter:"int", width:110, hozAlign:"center",
             formatter: "money",
             formatterParams: { decimal: ".", thousand: ",", precision: 0 }
         },
         {title:"합계금액", field:"och_mon_total", sorter:"int", width:130, hozAlign:"center",
             formatter: "money",
             formatterParams: { decimal: ".", thousand: ",", precision: 0 },
             bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal: ".", thousand: ",", precision: 0}
         }
     ],
     rowFormatter:function(row){
         row.getElement().style.fontWeight = "700";
         row.getElement().style.backgroundColor = "#FFFFFF";
     },
     rowClick:function(e, row){
         $("#tab1 .tabulator-row.row_select").removeClass("row_select");
         row.getElement().className += " row_select";
     },
 });
}

</script>


</body>
</html>
