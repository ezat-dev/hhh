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
    	boby{
    		overflow: hidden;
    	}
        /* 전체 컨테이너 */
        .main-container {
            width: 98%;
            margin: 0 auto;
            padding: 20px;
        }
        
        /* 통합 컨트롤 영역 (검색 + 호기 버튼) */
        .button-container {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            gap: 15px;
            padding: 2px 20px;
            background: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        /* 호기 선택 버튼 */
        .hogi-selector {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-left: auto;
        }
        
        .hogi-btn {
            min-width: 80px;
            height: 38px;
            padding: 0 16px;
            border: 2px solid #007bff;
            background: white;
            color: #007bff;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.2s;
        }
        
        .hogi-btn:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
            box-shadow: 0 2px 6px rgba(0, 123, 255, 0.3);
        }
        
        .hogi-btn.active {
            background: #007bff;
            color: white;
            box-shadow: 0 2px 8px rgba(0, 123, 255, 0.4);
        }
        
        .hogi-btn.integrated {
            border-color: #28a745;
            color: #28a745;
            min-width: 110px;
        }
        
        .hogi-btn.integrated:hover {
            background: #e8f5e9;
        }
        
        .hogi-btn.integrated.active {
            background: #28a745;
            border-color: #28a745;
            color: white;
        }
        
        /* 라벨 */
        .daylabel {
            margin-right: 10px;
            font-size: 16px;
            font-weight: bold;
            color: #333;
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
        
        /* 통합 트렌드 그리드 */
        .integrated-container {
            display: none;
            grid-template-columns: repeat(3, 1fr);
            grid-template-rows: repeat(2, 1fr);
            gap: 15px;
            margin-top: 20px;
        }
        
        .integrated-container.active {
            display: grid;
        }
        
        .mini-chart {
            height: 350px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            background: white;
            padding: 10px;
        }
        
        /* 반응형 */
        @media (max-width: 1400px) {
            .integrated-container {
                grid-template-columns: repeat(2, 1fr);
                grid-template-rows: repeat(3, 1fr);
            }
        }
        
        @media (max-width: 900px) {
            .integrated-container {
                grid-template-columns: 1fr;
                grid-template-rows: repeat(6, 1fr);
            }
            
            .hogi-selector {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>

<div class="main-container">
    <!-- 통합 컨트롤 영역 (검색 + 호기 버튼) -->
    <div class="button-container">
        <label class="daylabel">검색 날짜 :</label>
        
        <div class="date_input" id="dateInputArea">
            <input type="text" autocomplete="off" class="datetimeSet datetimepicker_datetime" id="startDate">
            <span class="mid"> ~ </span>
            <input type="text" autocomplete="off" class="datetimeSet datetimepicker_datetime" id="endDate">
        </div>
        
        <button class="select-button" id="btnSearch">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
            조회
        </button>
        
        <div class="trend-option">
            <label>
                <input type="checkbox" id="toggleMarker">
                포인트 표시
            </label>
        </div>
        
        <!-- 호기 선택 버튼 -->
        <div class="hogi-selector">
            <button class="hogi-btn active" data-hogi="BCF1">BCF1</button>
            <button class="hogi-btn" data-hogi="BCF2">BCF2</button>
            <button class="hogi-btn" data-hogi="BCF3">BCF3</button>
            <button class="hogi-btn" data-hogi="BCF4">BCF4</button>
            <button class="hogi-btn" data-hogi="BCF5">BCF5</button>
            <button class="hogi-btn" data-hogi="TF1">TF1</button>
            <button class="hogi-btn integrated" data-hogi="INTEGRATED">📊 통합</button>
        </div>
    </div>

    <!-- 단일 차트 컨테이너 -->
    <div id="container"></div>
    
    <!-- 통합 트렌드 컨테이너 -->
    <div class="integrated-container" id="integratedContainer">
        <div class="mini-chart" id="chart-BCF1"></div>
        <div class="mini-chart" id="chart-BCF2"></div>
        <div class="mini-chart" id="chart-BCF3"></div>
        <div class="mini-chart" id="chart-BCF4"></div>
        <div class="mini-chart" id="chart-BCF5"></div>
        <div class="mini-chart" id="chart-TF1"></div>
    </div>
</div>

<script>
let now_page_code = "d03";

/* 전역 변수 */
let chart = null;
let miniCharts = {};
let markerEnabled = false;
let hogi = "BCF1";
let viewMode = "single"; // "single" or "integrated"
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
        tickInterval = 60 * 60 * 1000;
        labelFormat = function() {
            return Highcharts.dateFormat("%m-%d<br>%H:%M", this.value);
        };
    } else if (rangeHours > 6) {
        tickInterval = 60 * 60 * 1000; // ✅ 6시간 초과 시에도 1시간 간격
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
function updateXAxis(targetChart, tickInterval, labelFormat) {
    if(!targetChart) return;
    targetChart.xAxis[0].update({
        tickInterval: tickInterval,
        labels: {
            formatter: labelFormat
        }
    });
}

/* 마우스 휠 줌 기능 */
function enableMouseWheelZoom(containerId) {
    $('#' + containerId).off('wheel').on('wheel', function(e) {
        const targetChart = containerId === 'container' ? chart : miniCharts[containerId.replace('chart-', '')];
        if (!targetChart) return;
        
        e.preventDefault();
        
        const xAxis = targetChart.xAxis[0];
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
            updateXAxis(targetChart, settings.tickInterval, settings.labelFormat);
            return;
        }
        
        if (newRange < 60000) {
            return;
        }
        
        const mouseX = e.originalEvent.offsetX;
        const chartWidth = targetChart.chartWidth;
        const mouseRatio = mouseX / chartWidth;
        
        const center = currentMin + (range * mouseRatio);
        const newMin = center - (newRange * mouseRatio);
        const newMax = center + (newRange * (1 - mouseRatio));
        
        const finalMin = Math.max(dataMin, newMin);
        const finalMax = Math.min(dataMax, newMax);
        
        xAxis.setExtremes(finalMin, finalMax);
        
        const settings = getOptimalSettings(finalMax - finalMin);
        updateXAxis(targetChart, settings.tickInterval, settings.labelFormat);
    });
}

/* 차트 생성 */
function createChart(series, dataRange, targetHogi, containerId = "container"){
    const isIntegrated = containerId !== "container";
    const legendState = isIntegrated ? null : loadLegendState();
    
    if(legendState){
        series.forEach(s => {
            if(legendState.hasOwnProperty(s.name)){
                s.visible = legendState[s.name];
            }
        });
    }
    
    const settings = getOptimalSettings(dataRange);
    
    
    const yAxisConfig = (targetHogi === "TF1") 
    ? {
        title: { text: '온도(℃)', style: { fontSize: isIntegrated ? '10px' : '12px' } },
        min: 0,
        max: 500,
        endOnTick: false, // ✅ 최대값 고정
        tickInterval: 50,
        labels: { style: { fontSize: isIntegrated ? '9px' : '11px' } }
    }
    : [
        {
            title: { text: '온도(℃)', style: { fontSize: isIntegrated ? '10px' : '12px' } },
            min: 0,
            max: 1200,
            endOnTick: false, // ✅ 최대값 고정
            tickInterval: 100,
            labels: { style: { fontSize: isIntegrated ? '9px' : '11px' } }
        },
        {
            title: { text: 'CP', style: { fontSize: isIntegrated ? '10px' : '12px' } },
            opposite: true,
            min: 0,
            max: 2.5,
            endOnTick: false, // ✅ 최대값 고정
            tickInterval: 0.2,
            gridLineWidth: 0,
            labels: { 
                style: { fontSize: isIntegrated ? '9px' : '11px' },
                formatter: function() {
                    return this.value % 1 === 0 ? this.value : this.value.toFixed(1);
                }
            }
        }
    ];
    
    const chartConfig = {
        chart:{
            type:"line",
            zoomType:"x",
            panning:true,
            panKey:"shift",
            height: isIntegrated ? 350 : 600,
            events: {
                selection: function(event) {
                    if (event.xAxis) {
                        const min = event.xAxis[0].min;
                        const max = event.xAxis[0].max;
                        const range = max - min;
                        
                        const settings = getOptimalSettings(range);
                        const self = this;
                        setTimeout(function() {
                            updateXAxis(self, settings.tickInterval, settings.labelFormat);
                        }, 100);
                    }
                }
            }
        },
        title:{ 
            text: targetHogi + " 설비 트렌드",
            style: { fontSize: isIntegrated ? '14px' : '16px' }
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
                        if(!isIntegrated){
                            setTimeout(saveLegendState, 100);
                        }
                    }
                }
            }
        },
        xAxis:{
            type:"datetime",
            reversed: true,
            tickInterval: isIntegrated ? settings.tickInterval * 2 : settings.tickInterval, // ✅ 통합 트렌드는 2배 간격
            labels:{
                formatter: settings.labelFormat,
                rotation: 0,
                style: { fontSize: isIntegrated ? '9px' : '11px' }
            }
        },
        yAxis: yAxisConfig,
        tooltip:{
            shared:true,
            crosshairs:true,
            xDateFormat:"%Y-%m-%d %H:%M:%S",
            style: { fontSize: isIntegrated ? '10px' : '12px' },
            valueDecimals: 3, // CP값 소수점 3자리 표시
            pointFormatter: function() {
                let value;
                if (this.series.name.includes('CP')) {
                    value = this.y.toFixed(3); // CP는 소수점 3자리
                } else if (this.series.name.includes('ZONE')) {
                    value = Math.round(this.y); // TF1 ZONE은 정수
                } else {
                    value = Math.round(this.y); // CF, OIL은 정수
                }
                return '<span style="color:' + this.color + '">\u25CF</span> ' + this.series.name + ': <b>' + value + '</b><br/>';
            }
        },
        legend: { 
            enabled: true,
            align: 'center',
            verticalAlign: 'bottom',
            itemStyle: { fontSize: isIntegrated ? '10px' : '12px' }
        },
        exporting:{
            enabled: !isIntegrated,
            buttons:{
                contextButton:{
                    menuItems:[
                        {
                            text: 'PNG 다운로드',
                            onclick: function() {
                                this.exportChart({
                                    type: 'image/png',
                                    filename: getExportFilename('png', targetHogi)
                                });
                            }
                        },
                        {
                            text: 'CSV 다운로드',
                            onclick: function() {
                                downloadCSV(this, targetHogi);
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
    };
    
    const newChart = Highcharts.chart(containerId, chartConfig);
    enableMouseWheelZoom(containerId);
    
    return newChart;
}

/* 파일명 생성 */
function getExportFilename(extension, targetHogi) {
    const now = new Date();
    const year = now.getFullYear();
    const month = pad(now.getMonth() + 1);
    const day = pad(now.getDate());
    const hour = pad(now.getHours());
    const minute = pad(now.getMinutes());
    const second = pad(now.getSeconds());
    
    return year + month + day + hour + minute + second + "_" + targetHogi + "_트렌드." + extension;
}

/* CSV 다운로드 */
function downloadCSV(targetChart, targetHogi) {
    if (!targetChart) {
        alert('차트 데이터가 없습니다.');
        return;
    }
    
    const csv = targetChart.getCSV();
    
    if (!csv || csv.trim() === '') {
        alert('CSV 데이터가 비어있습니다.');
        return;
    }
    
    const filename = getExportFilename('csv', targetHogi);
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

/* 미니 차트 Clear */
function clearMiniChart(targetHogi){
    const miniChart = miniCharts[targetHogi];
    if(!miniChart) return;
    while(miniChart.series.length){
        miniChart.series[0].remove(false);
    }
    miniChart.redraw();
}

/* 데이터 처리 함수 */
function processDataForHogi(result, targetHogi) {
    let cfArr = [];
    let oilArr = [];
    let cpArr = [];

    result.forEach(function(data){
        const t = new Date(data.tdatetime).getTime();

        if(targetHogi === "BCF1"){                        
            cfArr.push([t, +data.bcf1_cf_pv]);
            oilArr.push([t, +data.bcf1_oil_pv]);
            cpArr.push([t, +data.bcf1_cp_pv * 1000]);
        }else if(targetHogi === "BCF2"){
            cfArr.push([t, +data.bcf2_cf_pv]);
            oilArr.push([t, +data.bcf2_oil_pv]);
            cpArr.push([t, +data.bcf2_cp_pv * 1000]);
        }else if(targetHogi === "BCF3"){
            cfArr.push([t, +data.bcf3_cf_pv]);
            oilArr.push([t, +data.bcf3_oil_pv]);
            cpArr.push([t, +data.bcf3_cp_pv * 1000]);
        }else if(targetHogi === "BCF4"){
            cfArr.push([t, +data.bcf4_cf_pv]);
            oilArr.push([t, +data.bcf4_oil_pv]);
            cpArr.push([t, +data.bcf4_cp_pv * 1000]);
        }else if(targetHogi === "BCF5"){
            cfArr.push([t, +data.bcf5_cf_pv]);
            oilArr.push([t, +data.bcf5_oil_pv]);
            cpArr.push([t, +data.bcf5_cp_pv]);
        }else if(targetHogi === "TF1"){
            cfArr.push([t, +data.tf1_zone1]);
            oilArr.push([t, +data.tf1_zone2]);
            cpArr.push([t, +data.tf1_zone3]);
        }
    });
    
    // 설비에 따른 시리즈별 이름 처리
    if(targetHogi === "TF1"){
        return [
            { name: "TF1 ZONE1", data: cfArr, color: "red" },
            { name: "TF1 ZONE2", data: oilArr, color: "green" },
            { name: "TF1 ZONE3", data: cpArr, color: "blue"}
        ];
    } else {
        return [
            { name: targetHogi + " CF(PV)", data: cfArr, color: "red" },
            { name: targetHogi + " OIL(PV)", data: oilArr, color: "green" },
            { name: targetHogi + " CP(PV)", data: cpArr, color: "blue", yAxis: 1 }
        ];
    }
}

/* 트렌드 조회 */
function loadHistory(){
    const startDate = $("#startDate").val();
    const endDate = $("#endDate").val();
    
    console.log("📊 트렌드 조회:", { startDate, endDate, hogi, viewMode });
    
    $.ajax({
        type: "POST",
        url: "/tkheat/monitoring/trend/trendList",
        data: { startDate, endDate },
        success: function (result) {
            console.log("✅ 데이터 수신:", result.length + "개");
            
            if(!result || result.length === 0){
                if(viewMode === "single"){
                    clearChart();
                } else {
                    Object.keys(miniCharts).forEach(h => clearMiniChart(h));
                }
                alert('조회된 데이터가 없습니다.');
                return;
            }

            const categories = result.map(r => new Date(r.tdatetime).getTime());
            const dataMin = Math.min(...categories);
            const dataMax = Math.max(...categories);
            const dataRange = dataMax - dataMin;

            if(viewMode === "single"){
                // 단일 차트 모드
                const series = processDataForHogi(result, hogi);
                if(chart){
                    clearChart();
                }
                chart = createChart(series, dataRange, hogi, "container");
            } else {
                // 통합 트렌드 모드
                const hogis = ["BCF1", "BCF2", "BCF3", "BCF4", "BCF5", "TF1"];
                hogis.forEach(h => {
                    const series = processDataForHogi(result, h);
                    const containerId = "chart-" + h;
                    if(miniCharts[h]){
                        clearMiniChart(h);
                    }
                    miniCharts[h] = createChart(series, dataRange, h, containerId);
                });
            }
        },
        error: function (xhr, status, error) {
            console.error("❌ 에러:", error);
            alert("데이터 조회 중 오류가 발생했습니다.");
        }
    });
}

/* 뷰 모드 전환 */
function switchViewMode(mode, selectedHogi){
    viewMode = mode;
    
    if(mode === "single"){
        hogi = selectedHogi;
        $("#container").show();
        $("#integratedContainer").removeClass("active");
        loadHistory();
    } else {
        $("#container").hide();
        $("#integratedContainer").addClass("active");
        loadHistory();
    }
}

/* 이벤트 핸들러 */
$("#btnSearch").on("click", loadHistory);

$("#toggleMarker").on("change",function(){
    markerEnabled = this.checked;
    if(viewMode === "single" && chart){
        chart.update({
            plotOptions:{
                series:{
                    marker:{ enabled: markerEnabled }
                }
            }
        });
    } else if(viewMode === "integrated"){
        Object.values(miniCharts).forEach(mc => {
            if(mc){
                mc.update({
                    plotOptions:{
                        series:{
                            marker:{ enabled: markerEnabled }
                        }
                    }
                });
            }
        });
    }
});

/* 호기 버튼 클릭 */
$(".hogi-btn").on("click", function(){
    const selectedHogi = $(this).data("hogi");
    
    $(".hogi-btn").removeClass("active");
    $(this).addClass("active");
    
    if(selectedHogi === "INTEGRATED"){
        switchViewMode("integrated", null);
    } else {
        switchViewMode("single", selectedHogi);
    }
});

/* 초기화 */
$(document).ready(function () {
    Highcharts.setOptions({
        time: { useUTC: false }
    });

    // 최초 로딩시 12시간 전 ~ 현재 시간
    $("#startDate").val(before12Hours());
    $("#endDate").val(now());
    
    loadHistory();
});
</script>
</body>
</html>
