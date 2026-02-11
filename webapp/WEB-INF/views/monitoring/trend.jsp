<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>트렌드</title>
    <link rel="stylesheet" href="/tkheat/css/monitoring/monitoring.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
    <%@include file="../include/pluginpage.jsp" %> 
    
    <style>
        /* 전체 컨테이너 */
        .main-container {
            width: 98%;
            margin: 0 auto;
            padding: 20px;
        }
        
        /* 버튼 컨테이너 */
        .button-container {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            background: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        /* 라벨 */
        .daylabel {
            margin-right: 10px;
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
        
        /* Select 박스 */
        #hogiSelect {
            height: 38px;
            font-size: 15px;
            padding: 0 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            background: white;
            cursor: pointer;
            transition: border 0.3s;
        }
        
        #hogiSelect:focus {
            outline: none;
            border-color: #007bff;
        }
        
        /* 날짜 입력 영역 */
        .date_input {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .datetimeSet {
            height: 38px;
            font-size: 15px;
            padding: 0 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            background: white;
            text-align: center;
            transition: border 0.3s;
        }
        
        .datetimeSet:focus {
            outline: none;
            border-color: #007bff;
        }
        
        .mid {
            margin: 0 5px;
            font-size: 18px;
            font-weight: bold;
            color: #555;
        }
        
        /* 조회 버튼 */
        .select-button {
            display: flex;
            align-items: center;
            gap: 6px;
            height: 38px;
            padding: 0 16px;
            border-radius: 6px;
            border: 1px solid #007bff;
            background: #007bff;
            color: white;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.2s;
        }
        
        .select-button:hover {
            background: #0056b3;
            border-color: #0056b3;
        }
        
        .button-image {
            width: 18px;
            height: 18px;
            filter: brightness(0) invert(1);
        }
        
        /* 모드 버튼 */
        .mode-buttons {
            display: flex;
            gap: 8px;
            margin-left: 20px;
        }
        
        .mode-btn {
            height: 38px;
            padding: 0 16px;
            border: 1px solid #007bff;
            background: white;
            color: #007bff;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.2s;
        }
        
        .mode-btn:hover {
            background: #007bff;
            color: white;
        }
        
        .mode-btn.active {
            background: #007bff;
            color: white;
        }
        
        .mode-btn.realtime-btn.active {
            background: #28a745;
            border-color: #28a745;
            color: white;
        }
        
        .mode-btn.realtime-btn:hover {
            background: #28a745;
            border-color: #28a745;
            color: white;
        }
        
        /* 체크박스 옵션 */
        .trend-option {
            margin-left: auto;
        }
        
        .trend-option label {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 15px;
            cursor: pointer;
            color: #333;
        }
        
        .trend-option input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }
        
        /* 차트 컨테이너 */
        #container {
            width: 100%;
            height: 600px;
            margin-top: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            background: white;
            padding: 10px;
        }
    </style>
</head>
<body>

<div class="main-container">
    <div class="button-container">
        <label class="daylabel">검색 날짜 :</label>
        
        <select id="hogiSelect">
            <option value="BCF1" selected>BCF1</option>
            <option value="BCF2">BCF2</option>
            <option value="BCF3">BCF3</option>
            <option value="BCF4">BCF4</option>
            <option value="BCF5">BCF5</option>
            <option value="TF1">TF1</option>
        </select>
        
        <div class="date_input" id="dateInputArea">
            <input type="text" autocomplete="off" class="datetimeSet" id="startDate">
            <span class="mid"> ~ </span>
            <input type="text" autocomplete="off" class="datetimeSet" id="endDate">
        </div>
        
        <button class="select-button" id="btnSearch">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
            조회
        </button>
        
        <div class="mode-buttons">
            <!-- <button class="mode-btn active" id="btnHistorical">히스토리컬</button> -->
            <!-- <button class="mode-btn realtime-btn" id="btnRealtime">🔴 실시간</button> -->
        </div>
        
        <div class="trend-option">
            <label>
                <input type="checkbox" id="toggleMarker">
                포인트 표시
            </label>
        </div>
    </div>

    <div id="container"></div>
</div>

<script>
let now_page_code = "d04";

/* 전역 변수 */
let chart = null;
let markerEnabled = false;
let hogi = "BCF1";
let seriesArray = [];

/* 날짜 유틸 */
function pad(n){ return n < 10 ? "0"+n : n; }

function now(){
    const d = new Date();
    return d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate())+" "
         + pad(d.getHours())+":"+pad(d.getMinutes());
}

function before12Hours(){
    const d = new Date();
    d.setHours(d.getHours()-12);
    return d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate())+" "
         + pad(d.getHours())+":"+pad(d.getMinutes());
}

/* 범례 상태 저장/복원 */
function saveLegendState(){
    if(!chart) return;
    const state = {};
    chart.series.forEach(s => {
        state[s.name] = s.visible;
    });
    localStorage.setItem('trendLegendState_' + hogi, JSON.stringify(state));
}

function loadLegendState(){
    const saved = localStorage.getItem('trendLegendState_' + hogi);
    return saved ? JSON.parse(saved) : null;
}

/* 데이터 범위에 따른 최적 tick interval 및 레이블 형식 계산 */
function getOptimalSettings(rangeMillis) {
    const rangeMinutes = rangeMillis / (60 * 1000);
    const rangeHours = rangeMinutes / 60;
    const rangeDays = rangeHours / 24;
    
    let tickInterval, labelFormat;
    
    if (rangeDays > 30) {
        tickInterval = 24 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d", this.value);
        };
    } else if (rangeDays > 14) {
        tickInterval = 12 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeDays > 7) {
        tickInterval = 6 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeDays > 3) {
        tickInterval = 3 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeDays > 1) {
        tickInterval = 2 * 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours >= 12) {
        // ✅ 12시간 범위: 1시간 간격
        tickInterval = 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours > 6) {
        tickInterval = 30 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours > 3) {
        tickInterval = 15 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    } else if (rangeHours > 1) {
        tickInterval = 10 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    } else {
        tickInterval = 5 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%H:%M", this.value);
        };
    }
    
    return { tickInterval, labelFormat };
}

/* X축 업데이트 */
function updateXAxis(tickInterval, labelFormat) {
    if(!chart) return;
    chart.xAxis[0].update({
        tickInterval: tickInterval,
        labels: {
            formatter: labelFormat
        }
    });
}

/* 마우스 휠 줌 기능 */
function enableMouseWheelZoom() {
    $('#container').off('wheel').on('wheel', function(e) {
        if (!chart) return;
        
        e.preventDefault();
        
        const chartObj = chart;
        const xAxis = chartObj.xAxis[0];
        const extremes = xAxis.getExtremes();
        const dataMin = extremes.dataMin;
        const dataMax = extremes.dataMax;
        const currentMin = extremes.min;
        const currentMax = extremes.max;
        const range = currentMax - currentMin;
        
        const zoomFactor = e.originalEvent.deltaY > 0 ? 1.1 : 0.9;
        const newRange = range * zoomFactor;
        
        if (newRange > (dataMax - dataMin)) {
            xAxis.setExtremes(dataMin, dataMax);
            const settings = getOptimalSettings(dataMax - dataMin);
            updateXAxis(settings.tickInterval, settings.labelFormat);
            return;
        }
        
        if (newRange < 60000) {
            return;
        }
        
        const mouseX = e.originalEvent.offsetX;
        const chartWidth = chartObj.chartWidth;
        const mouseRatio = mouseX / chartWidth;
        
        const center = currentMin + (range * mouseRatio);
        const newMin = center - (newRange * mouseRatio);
        const newMax = center + (newRange * (1 - mouseRatio));
        
        const finalMin = Math.max(dataMin, newMin);
        const finalMax = Math.min(dataMax, newMax);
        
        xAxis.setExtremes(finalMin, finalMax);
        
        const settings = getOptimalSettings(finalMax - finalMin);
        updateXAxis(settings.tickInterval, settings.labelFormat);
    });
}

/* 차트 생성 */
function createChart(series, dataRange){
    const legendState = loadLegendState();
    
    if(legendState){
        series.forEach(s => {
            if(legendState.hasOwnProperty(s.name)){
                s.visible = legendState[s.name];
            }
        });
    }
    
    const settings = getOptimalSettings(dataRange);
    
    // TF1인 경우 단일 Y축, 아니면 이중 Y축
    const yAxisConfig = (hogi === "TF1") 
        ? {
            title: { text: '온도(℃)' },
            min: 0,
            max: 1200,
            tickInterval: 100
        }
        : [
            {
                title: { text: '온도(℃)' },
                min: 0,
                max: 1200,
                tickInterval: 100
            },
            {
                title: { text: 'CP' },
                opposite: true,
                min: 0,
                max: 2.5,
                tickInterval: 0.1 
            }
        ];
    
    chart = Highcharts.chart("container",{
        chart:{
            type:"line",
            zoomType:"x",
            panning:true,
            panKey:"shift",
            events: {
                selection: function(event) {
                    if (event.xAxis) {
                        const min = event.xAxis[0].min;
                        const max = event.xAxis[0].max;
                        const range = max - min;
                        
                        const settings = getOptimalSettings(range);
                        setTimeout(function() {
                            updateXAxis(settings.tickInterval, settings.labelFormat);
                        }, 100);
                    }
                }
            }
        },
        title:{ 
            text: hogi + " 설비 트렌드"
        },
        plotOptions:{
            series:{
                marker:{
                    enabled: markerEnabled
                },
                states:{
                    hover:{
                        lineWidthPlus:0
                    }
                },
                events: {
                    legendItemClick: function() {
                        setTimeout(saveLegendState, 100);
                    }
                }
            }
        },
        xAxis:{
            type:"datetime",
            tickInterval: settings.tickInterval,
            labels:{
                formatter: settings.labelFormat,
                rotation: -45
            }
        },
        yAxis: yAxisConfig,
        tooltip:{
            shared:true,
            crosshairs:true,
            xDateFormat:"%Y-%m-%d %H:%M:%S"
        },
        legend: { 
            enabled: true,
            align: 'center',
            verticalAlign: 'bottom'
        },
        exporting:{
            enabled:true,
            buttons:{
                contextButton:{
                    menuItems:[
                        {
                            text: 'PNG 다운로드',
                            onclick: function() {
                                this.exportChart({
                                    type: 'image/png',
                                    filename: getExportFilename('png')
                                });
                            }
                        },
                        {
                            text: 'CSV 다운로드',
                            onclick: function() {
                                downloadCSV();
                            }
                        }
                    ]
                }
            },
            csv: {
                dateFormat: '%Y-%m-%d %H:%M:%S'
            }
        },
        series: series
    });
    
    enableMouseWheelZoom();
}

/* 파일명 생성 */
function getExportFilename(extension) {
    const now = new Date();
    const year = now.getFullYear();
    const month = pad(now.getMonth() + 1);
    const day = pad(now.getDate());
    const hour = pad(now.getHours());
    const minute = pad(now.getMinutes());
    const second = pad(now.getSeconds());
    
    return year + month + day + hour + minute + second + "_" + hogi + "_트렌드." + extension;
}

/* CSV 다운로드 */
function downloadCSV() {
    if (!chart) {
        alert('차트 데이터가 없습니다.');
        return;
    }
    
    const csv = chart.getCSV();
    
    if (!csv || csv.trim() === '') {
        alert('CSV 데이터가 비어있습니다.');
        return;
    }
    
    const filename = getExportFilename('csv');
    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement("a");
    const url = URL.createObjectURL(blob);
    
    link.setAttribute("href", url);
    link.setAttribute("download", filename);
    link.style.visibility = 'hidden';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

/* 차트 Clear */
function clearChart(){
    if(!chart) return;
    while(chart.series.length){
        chart.series[0].remove(false);
    }
    chart.redraw();
}

/* 트렌드 조회 */
function loadHistory(){
    const startDate = $("#startDate").val();
    const endDate = $("#endDate").val();
    hogi = $("#hogiSelect").val();
    
    console.log("📊 트렌드 조회:", { startDate, endDate, hogi });
    
    $.ajax({
        type: "POST",
        url: "/tkheat/monitoring/trend/trendList",
        data: { startDate, endDate },
        success: function (result) {
            console.log("✅ 데이터 수신:", result.length + "개");
            
            if(!result || result.length === 0){
                clearChart();
                alert('조회된 데이터가 없습니다.');
                return;
            }

            let cfArr = [];
            let oilArr = [];
            let cpArr = [];

            result.forEach(function(data){
                const t = new Date(data.tdatetime).getTime();

                if(hogi === "BCF1"){						
                    cfArr.push([t, +data.bcf1_cf_pv]);
                    oilArr.push([t, +data.bcf1_oil_pv]);
                    cpArr.push([t, +data.bcf1_cp_pv * 1000]);
                }else if(hogi === "BCF2"){
                    cfArr.push([t, +data.bcf2_cf_pv]);
                    oilArr.push([t, +data.bcf2_oil_pv]);
                    cpArr.push([t, +data.bcf2_cp_pv * 1000]);
                }else if(hogi === "BCF3"){
                    cfArr.push([t, +data.bcf3_cf_pv]);
                    oilArr.push([t, +data.bcf3_oil_pv]);
                    cpArr.push([t, +data.bcf3_cp_pv * 1000]);
                }else if(hogi === "BCF4"){
                    cfArr.push([t, +data.bcf4_cf_pv]);
                    oilArr.push([t, +data.bcf4_oil_pv]);
                    cpArr.push([t, +data.bcf4_cp_pv * 1000]);
                }else if(hogi === "BCF5"){
                    cfArr.push([t, +data.bcf5_cf_pv]);
                    oilArr.push([t, +data.bcf5_oil_pv]);
                    cpArr.push([t, +data.bcf5_cp_pv * 1000]);
                }else if(hogi === "TF1"){
                    cfArr.push([t, +data.tf1_zone1]);
                    oilArr.push([t, +data.tf1_zone2]);
                    cpArr.push([t, +data.tf1_zone3]);
                }
            });
            
            const categories = result.map(r => new Date(r.tdatetime).getTime());
            const dataMin = Math.min(...categories);
            const dataMax = Math.max(...categories);
            const dataRange = dataMax - dataMin;

            // ✅ 설비에 따른 시리즈별 이름 처리
            if(hogi === "TF1"){
                seriesArray = [
                    { name: "TF1 ZONE1", data: cfArr, color: "red" },
                    { name: "TF1 ZONE2", data: oilArr, color: "green" },
                    { name: "TF1 ZONE3", data: cpArr, color: "blue"}
                ];
            } else {
                seriesArray = [
                    { name: hogi + " CF(PV)", data: cfArr, color: "red" },
                    { name: hogi + " OIL(PV)", data: oilArr, color: "green" },
                    { name: hogi + " CP(PV)", data: cpArr, color: "blue", yAxis: 1 }
                ];
            }

            if(chart){
                clearChart();
            }
            createChart(seriesArray, dataRange);
        },
        error: function (xhr, status, error) {
            console.error("❌ 에러:", error);
            alert("데이터 조회 중 오류가 발생했습니다.");
        }
    });
}

/* 이벤트 핸들러 */
$("#btnSearch").on("click", loadHistory);

$("#toggleMarker").on("change",function(){
    markerEnabled = this.checked;
    if(chart){
        chart.update({
            plotOptions:{
                series:{
                    marker:{ enabled: markerEnabled }
                }
            }
        });
    }
});

/* 초기화 */
$(document).ready(function () {
    Highcharts.setOptions({
        time: { useUTC: false }
    });

    $(".datetimeSet").datepicker({
        language: 'ko',
        timepicker: true,
        dateFormat: 'yyyy-mm-dd',
        timeFormat: 'hh:ii',
        autoClose: true
    });

    // ✅ 최초 로딩시 12시간 전 ~ 현재 시간
    $("#startDate").val(before12Hours());
    $("#endDate").val(now());
    
    loadHistory();
});
</script>
</body>
</html>