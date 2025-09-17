<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>KPI 현황</title>
    <%@include file="../include/pluginpage.jsp" %>
    <style>
        .main { width: 98%; margin: auto; }
        .tabulator .tabulator-header .tabulator-col {
            font-size: 16px; font-weight: 700; background-color: #B2EBF4;
            text-align: center;
        }
        .tabulator .tabulator-cell {
            font-size: 14px; text-align: center;
        }
        h3 { margin: 20px 0 10px; }
    </style>
</head>
<body>
<main class="main">
    <h3>시간당 생산량 향상률</h3>
    <div id="prodTable"></div>

    <h3>공정불량률 (PPM)</h3>
    <div id="ppmTable"></div>
</main>

<script>
    //시간당생산
    var prodTable = new Tabulator("#prodTable", {
        height:"250px",
        layout:"fitColumns",
        data:[{
            field:"생산성",
            kpi:"시간당 생산량",
            unit:"원",
            prev:0, current:0, target:0, improve:"", achieve:"", note:""
        }],
        columns:[
            {title:"분야", field:"field", width:100},
            {title:"핵심지표", field:"kpi", width:150},
            {title:"단위", field:"unit", width:100},
            {title:"이전값", field:"prev", editor:"number"},
            {title:"현재값", field:"current", editor:"number"},
            {title:"목표값", field:"target", editor:"number"},
            {title:"향상률(%)", field:"improve"},
            {title:"목표달성률(%)", field:"achieve"},
            {title:"비고", field:"note", editor:"input"}
        ],
        cellEdited:function(cell){
            let row = cell.getRow().getData();

            
            if(row.prev && row.current){
                let improve = ((row.current - row.prev) / row.prev * 100).toFixed(1);
                row.improve = improve + " %";
            }

           
            if(row.target && row.current){
                let achieve = (row.current / row.target * 100).toFixed(1);
                row.achieve = achieve + " %";
            }

            cell.getRow().update(row);
        }
    });

    //공정불량ppm
    var ppmTable = new Tabulator("#ppmTable", {
        height:"250px",
        layout:"fitColumns",
        data:[{
            field:"품질",
            kpi:"공정불량률",
            unit:"ppm",
            prod:0, defect:0, target:0, ppm:"", achieve:"", note:""
        }],
        columns:[
            {title:"분야", field:"field", width:100},
            {title:"핵심지표", field:"kpi", width:150},
            {title:"단위", field:"unit", width:100},
            {title:"생산수량", field:"prod", editor:"number"},
            {title:"불량수량", field:"defect", editor:"number"},
            {title:"목표(ppm)", field:"target", editor:"number"},
            {title:"현재(ppm)", field:"ppm"},
            {title:"목표달성률(%)", field:"achieve"},
            {title:"비고", field:"note", editor:"input"}
        ],
        cellEdited:function(cell){
            let row = cell.getRow().getData();

           
            if(row.prod && row.defect){
                let ppm = (row.defect / row.prod * 1000000).toFixed(1);
                row.ppm = ppm + " ppm";

                
                if(row.target){
                    let achieve = ((row.target / ppm) * 100).toFixed(1);
                    row.achieve = achieve + " %";
                }
            }

            cell.getRow().update(row);
        }
    });
</script>
</body>
</html>
