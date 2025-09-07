<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>KPI현황</title>
    <%@include file="../include/pluginpage.jsp" %>
    <style>
        .main { width: 98%; margin: auto; }
        .tabulator .tabulator-header .tabulator-col {
            font-size: 18px; font-weight: 700; background-color: #B2EBF4;
            text-align: center;
        }
        .tabulator .tabulator-cell {
            font-size: 16px; text-align: center;
        }
    </style>
</head>
<body>
<main class="main">
    <div id="kpiTable"></div>
</main>

<script>
    var kpiTable = new Tabulator("#kpiTable", {
        height:"700px",
        layout:"fitColumns",
        reactiveData:true,
        selectable:true,
        columns:[
            {title:"No", field:"no", width:80, hozAlign:"center"},
            {title:"분야", field:"field", width:120, hozAlign:"center"},
            {title:"핵심지표(KPI)", field:"kpi", width:300, editor:"input"},
            {title:"단위", field:"unit", width:100},
            {title:"현재", field:"current", width:120, editor:"number"},
            {title:"목표", field:"target", width:120, editor:"number"},
            {title:"결과", field:"result", width:120, editor:"number"},
            {title:"개선율(%)", field:"improve", width:150, mutator:function(value,data){
                if(data.current && data.target){
                    return ((data.result - data.current)/data.current*100).toFixed(1);
                }
                return "";
            }},
            {title:"목표달성율(%)", field:"achieve", width:150, mutator:function(value,data){
                if(data.target && data.result){
                    return ((data.result/data.target)*100).toFixed(1);
                }
                return "";
            }},
            {title:"비고", field:"note", width:200, editor:"input"}
        ],
        data:[
            {no:1, field:"Q", unit:"%", current:0.14, target:0.059},
            {no:2, field:"Q", unit:"%", current:0.07, target:0.01},
            {no:3, field:"Q", unit:"횟수", current:3, target:1},
            {no:4, field:"P", unit:"hr", current:14.5, target:11}
        ],
        rowClick:function(e,row){
            row.toggleSelect();
        }
    });

    
</script>
</body>
</html>
