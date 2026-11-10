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
            gap: 10px;
            padding: 2px 16px;
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
            width: 128px;
            height: 34px;
            font-size: 13px;
            padding: 0 6px;
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

        /* 빠른 시간범위 버튼 */
        .quick-range-selector {
            display: flex;
            align-items: center;
            gap: 5px;
            padding-left: 6px;
            border-left: 1px solid #ccc;
        }

        .range-btn {
            min-width: 44px;
            height: 34px;
            padding: 0 8px;
            border: 1px solid #007bff;
            background: white;
            color: #007bff;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            font-weight: bold;
            transition: all 0.2s;
        }

        .range-btn:hover {
            background: #e3f2fd;
            transform: translateY(-1px);
            box-shadow: 0 2px 6px rgba(0, 123, 255, 0.3);
        }

        .range-btn.active {
            background: #007bff;
            color: white;
            box-shadow: 0 2px 8px rgba(0, 123, 255, 0.4);
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

        /* ========== 트렌드 메모 ========== */
        .memo-modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.4);
            z-index: 9999;
            align-items: center;
            justify-content: center;
        }
        .memo-modal-overlay.active { display: flex; }
        .memo-modal {
            background: #fff;
            width: 360px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            padding: 18px 20px;
        }
        .memo-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 16px;
            font-weight: 700;
            color: #2D3748;
            margin-bottom: 4px;
        }
        .memo-modal-close {
            border: none;
            background: none;
            font-size: 20px;
            line-height: 1;
            cursor: pointer;
            color: #A0AEC0;
        }
        .memo-modal-close:hover { color: #4A5568; }
        .memo-modal-time {
            font-size: 12px;
            color: #718096;
            margin-bottom: 10px;
        }
        .memo-modal textarea {
            width: 100%;
            height: 90px;
            resize: none;
            border: 1px solid #ccc;
            border-radius: 6px;
            padding: 8px;
            font-size: 14px;
            box-sizing: border-box;
            outline: none;
        }
        .memo-modal textarea:focus { border-color: #007bff; }
        .memo-modal-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 8px;
            margin-top: 12px;
        }
        .memo-modal-buttons button {
            height: 34px;
            padding: 0 14px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            border: 1px solid transparent;
        }
        .memo-btn-save { background: #007bff; border-color: #007bff; color: #fff; }
        .memo-btn-save:hover { background: #0056b3; border-color: #0056b3; }
        .memo-btn-cancel { background: #F0F4F8; border-color: #E2E8F0; color: #4A5568; }
        .memo-btn-cancel:hover { background: #E2E8F0; }
        .memo-btn-delete { background: #fff; border-color: #e74c3c; color: #e74c3c; margin-right: auto; }
        .memo-btn-delete:hover { background: #e74c3c; color: #fff; }
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

        <div class="quick-range-selector" id="quickRangeArea">
            <button class="range-btn" data-hours="12">12시간</button>
            <button class="range-btn" data-hours="6">6시간</button>
            <button class="range-btn" data-hours="24">24시간</button>
            <button class="range-btn" data-hours="7">7시간</button>
            <button class="range-btn" data-hours="5">5시간</button>
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

<!-- 트렌드 메모 모달 -->
<div class="memo-modal-overlay" id="memoModalOverlay">
    <div class="memo-modal">
        <div class="memo-modal-header">
            <span id="memoModalTitle">메모 작성</span>
            <button class="memo-modal-close" onclick="closeMemoModal()">&times;</button>
        </div>
        <div class="memo-modal-time" id="memoModalTime"></div>
        <textarea id="memoModalText" placeholder="메모 내용을 입력하세요" maxlength="500"></textarea>
        <div class="memo-modal-buttons">
            <button class="memo-btn-delete" id="memoBtnDelete" onclick="deleteMemo()">삭제</button>
            <button class="memo-btn-cancel" onclick="closeMemoModal()">취소</button>
            <button class="memo-btn-save" onclick="saveMemo()">저장</button>
        </div>
    </div>
</div>

<script>
//트렌드 화면은 전역 조회중 오버레이(pluginpage.jsp)를 끔
window.disableGlobalLoadingOverlay = true;

let now_page_code = "d03";

/* 전역 변수 */
let chart = null;
let miniCharts = {};
let markerEnabled = false;
let hogi = "BCF1";
let viewMode = "single"; // "single" or "integrated"
let seriesArray = [];

/* 트렌드 메모 전역 변수 */
let memoEditingCode = null;      // null이면 신규 작성, 값이 있으면 수정 모드
let memoJustClickedPoint = false; // 메모 포인트를 클릭했을 때 차트 click(신규작성)이 중복 실행되지 않도록

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

/* "YYYY-MM-DD HH:mm" 문자열에 시간(hours)을 더한 동일 형식 문자열 반환 */
function addHoursToDateStr(dateStr, hours){
    const parts = dateStr.split(" ");
    const dateParts = parts[0].split("-").map(Number);
    const timeParts = parts[1].split(":").map(Number);
    const d = new Date(dateParts[0], dateParts[1]-1, dateParts[2], timeParts[0], timeParts[1]);
    d.setHours(d.getHours() + hours);
    return d.getFullYear()+"-"+pad(d.getMonth()+1)+"-"+pad(d.getDate())+" "
         + pad(d.getHours())+":"+pad(d.getMinutes());
}

/* 빠른 시간범위 선택: 현재 시각부터 N시간 전까지의 데이터 조회 */
function selectQuickRange(hours){
    const nowStr = now();

    $("#startDate").val(addHoursToDateStr(nowStr, -hours));
    $("#endDate").val(nowStr);

    $(".range-btn").removeClass("active");
    $('.range-btn[data-hours="' + hours + '"]').addClass("active");

    loadHistory();
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
    } else {
        //6시간 이하 구간은 전부 20분 간격으로 통일(요청사항) - 기존엔 3h/1h 경계로 15분·10분·5분으로
        //잘게 나뉘어 있어서 짧게 확대할수록 라벨이 촘촘해졌는데, 20분 고정이면 가장 좁은 구간(1시간)에서도
        //라벨이 3개뿐이라 겹칠 일이 없음
        tickInterval = 20 * 60 * 1000;
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
        gridLineWidth: 3,
        labels: { style: { fontSize: isIntegrated ? '9px' : '11px' } }
    }
    : [
        {
            title: { text: '온도(℃)', style: { fontSize: isIntegrated ? '10px' : '12px' } },
            min: 0,
            //CP를 0.2 간격으로 쓰면서 눈금 수를 맞추려고 온도 최대값을 1200으로 늘림(요청사항)
            //1200을 100씩 12등분 = CP(0~2.4)를 0.2씩 12등분과 눈금 개수가 정확히 같아서
            //온도 500도 = CP 1.0, 400도 = CP 0.8 비율이 다시 정확히 맞음
            max: 1200,
            endOnTick: false, // ✅ 최대값 고정
            tickInterval: 100,
            //가로 기준선을 더 두껍게(요청사항) - 세로 기준선(연하게)과 구분되도록
            gridLineWidth: 3,
            labels: { style: { fontSize: isIntegrated ? '9px' : '11px' } }
        },
        {
            title: { text: 'CP', style: { fontSize: isIntegrated ? '10px' : '12px' } },
            opposite: true,
            min: 0,
            max: 2.4,
            endOnTick: false, // ✅ 최대값 고정
            tickInterval: 0.2,
            //기준선은 온도축 쪽에서 그리고(기본값), CP축은 중복으로 그리지 않도록 숨김
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
                },
                //트렌드 메모: CF/OIL/CP 선 중 마우스가 가리키고 있던(호버 중이던) 지점에 메모 추가
                //(통합 모드의 작은 미니차트에서는 공간이 좁아 혼동될 수 있어 메인 큰 차트에서만 지원)
                click: function(e){
                    if (isIntegrated) return;
                    if (memoJustClickedPoint) { memoJustClickedPoint = false; return; }

                    const nearest = findNearestLinePoint(this, e);
                    if(!nearest){
                        alert("온도/CP 선 위에 마우스를 올린 상태에서 클릭해주세요.");
                        return;
                    }
                    openMemoModalForAdd(nearest, targetHogi);
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
            //세로 기준선 추가(이전엔 없었음) - 가로선보다 연한 색으로, 굵기는 가로선이 두꺼워지기 전 수준(1)
            gridLineWidth: 1,
            gridLineColor: "#e2e2e2",
            labels:{
                formatter: settings.labelFormat,
                rotation: 0,
                style: { fontSize: isIntegrated ? '9px' : '11px' }
            },
            events: {
                //휠 줌/드래그 확대 등 축 범위가 바뀌는 모든 경우를 한곳에서 확실히 잡아서
                //getOptimalSettings 기준(20분 단위)으로 다시 맞춤 - 개별 줌 핸들러에만 의존하면
                //놓치는 경우가 있어 afterSetExtremes로 한번 더 보강
                afterSetExtremes: function(e){
                    if(e.min == null || e.max == null) return;
                    const settings2 = getOptimalSettings(e.max - e.min);
                    updateXAxis(this.chart, settings2.tickInterval, settings2.labelFormat);
                }
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

/* ========================= 트렌드 메모 ========================= */

/* 현재 저장 대기중인 메모 위치 정보(클릭한 선 위의 실제 값) */
let memoPendingPoint = null; // { x, y, yAxisIndex, seriesName }

/* 클릭 지점에서 CF/OIL/CP 선 중 가장 가까운 선의 포인트를 찾음(메모 시리즈 자신은 제외) */
function findNearestLinePoint(chartObj, e){
    const plotX = e.chartX - chartObj.plotLeft;
    const plotY = e.chartY - chartObj.plotTop;
    if(plotX < 0 || plotY < 0 || plotX > chartObj.plotWidth || plotY > chartObj.plotHeight){
        return null;
    }

    const xValue = chartObj.xAxis[0].toValue(e.chartX);

    let best = null;
    let bestDist = Infinity;

    chartObj.series.forEach(function(s){
        if((s.options.id && s.options.id.indexOf("memoSeries") === 0) || !s.visible || !s.points || s.points.length === 0) return;

        let closestPoint = null;
        let closestXDiff = Infinity;
        for(let i=0; i<s.points.length; i++){
            const p = s.points[i];
            if(p.x == null || p.y == null) continue;
            const diff = Math.abs(p.x - xValue);
            if(diff < closestXDiff){
                closestXDiff = diff;
                closestPoint = p;
            }
        }
        if(!closestPoint || closestPoint.plotY == null) return;

        //실제 화면 픽셀 기준 클릭 위치와 수직 거리가 가장 가까운 선을 선택
        //(온도축/CP축처럼 축이 달라도 plotY는 화면상 실제 높이라 그대로 비교 가능)
        const dist = Math.abs(closestPoint.plotY - plotY);
        if(dist < bestDist){
            bestDist = dist;
            best = {
                x: closestPoint.x,
                y: closestPoint.y,
                yAxisIndex: chartObj.yAxis.indexOf(s.yAxis),
                seriesName: s.name
            };
        }
    });

    //선에서 너무 멀리 떨어진 곳을 클릭하면 무시(차트 여백 등에서 엉뚱하게 찍히는 것 방지)
    if(!best || bestDist > 70){
        return null;
    }
    return best;
}

/* 메모 목록을 불러와 차트에 포인트로 표시 */
function loadAndRenderMemos(targetChart, targetHogi){
    if(!targetChart) return;

    const startDate = $("#startDate").val();
    const endDate = $("#endDate").val();
    if(!startDate || !endDate) return;

    $.ajax({
        type:"POST",
        url:"/tkheat/monitoring/trend/getMemoList",
        data:{
            hogi_code: targetHogi,
            sdate: startDate + ":00",
            edate: endDate + ":59"
        },
        success:function(list){
            renderMemoSeries(targetChart, list || []);
        },
        error:function(){
            console.error("❌ 메모 목록 조회 실패");
        }
    });
}

function renderMemoSeries(targetChart, list){
    const existing = targetChart.get("memoSeries");
    if(existing){ existing.remove(false); }

    const points = list
        .filter(function(m){ return m.memo_value != null; }) //값이 없는 과거 메모는 선 위에 찍을 좌표가 없어 표시 제외
        .map(function(m){
            return {
                x: new Date(m.memo_time.replace(" ", "T")).getTime(),
                y: m.memo_value,
                yAxis: m.yaxis_index || 0,
                memo_code: m.memo_code,
                memo_text: m.memo_text,
                memo_time: m.memo_time,
                reg_user: m.reg_user,
                series_name: m.series_name
            };
        });

    //yAxis는 포인트 단위가 아니라 시리즈 단위 속성이라, 축별로 시리즈를 나눠서 추가
    //(TF1처럼 축이 1개뿐인 차트는 존재하지 않는 축 인덱스로 추가하면 안 되므로 실제 축 개수만큼만)
    targetChart.yAxis.forEach(function(axisObj, axisIdx){
        const axisPoints = points.filter(function(p){ return p.yAxis === axisIdx; });
        targetChart.addSeries({
            id: "memoSeries" + axisIdx,
            name: "메모",
            type: "scatter",
            data: axisPoints,
            yAxis: axisIdx,
            color: "#ff6600",
            marker: { symbol: "triangle", radius: 6, lineWidth: 1, lineColor: "#a84300" },
            zIndex: 10,
            showInLegend: false,
            enableMouseTracking: true,
            tooltip: {
                pointFormatter: function(){
                    return "<b>📝 " + this.memo_text + "</b><br/>" + this.memo_time +
                        (this.series_name ? " · " + this.series_name : "");
                }
            },
            point: {
                events: {
                    click: function(){
                        memoJustClickedPoint = true;
                        openMemoModalForEdit(this);
                    }
                }
            }
        }, false);
    });

    //이전 코드에서 id 없이 "memoSeries" 하나로 추가하던 잔재가 있으면 같이 정리
    const legacy = targetChart.get("memoSeries");
    if(legacy){ legacy.remove(false); }

    targetChart.redraw();
}

/* 신규 작성 모달 열기(클릭한 선 위의 실제 좌표를 그대로 사용) */
function openMemoModalForAdd(nearest, targetHogi){
    memoEditingCode = null;
    memoPendingPoint = nearest;

    $("#memoModalTitle").text("메모 작성");
    $("#memoModalTime").text(
        Highcharts.dateFormat("%Y-%m-%d %H:%M", nearest.x) + " · " + nearest.seriesName
    );
    $("#memoModalText").val("");
    $("#memoBtnDelete").hide();
    $("#memoModalOverlay").addClass("active");
    $("#memoModalText").focus();
}

/* 수정/삭제 모달 열기(메모 포인트 클릭 시) */
function openMemoModalForEdit(point){
    memoEditingCode = point.memo_code;
    memoPendingPoint = null;

    $("#memoModalTitle").text("메모 수정");
    $("#memoModalTime").text(point.memo_time + (point.reg_user ? " · " + point.reg_user : ""));
    $("#memoModalText").val(point.memo_text);
    $("#memoBtnDelete").show();
    $("#memoModalOverlay").addClass("active");
    $("#memoModalText").focus();
}

function closeMemoModal(){
    $("#memoModalOverlay").removeClass("active");
    memoEditingCode = null;
    memoPendingPoint = null;
}

function getCurrentTargetChart(){
    return viewMode === "single" ? chart : null;
}

function saveMemo(){
    const text = $("#memoModalText").val().trim();
    if(!text){
        alert("메모 내용을 입력하세요.");
        return;
    }

    if(memoEditingCode){
        // 수정
        $.ajax({
            type:"POST",
            url:"/tkheat/monitoring/trend/updateMemo",
            data:{ memo_code: memoEditingCode, memo_text: text },
            success:function(){
                closeMemoModal();
                loadAndRenderMemos(getCurrentTargetChart(), hogi);
            },
            error:function(){ alert("메모 수정 중 오류가 발생했습니다."); }
        });
    }else{
        // 신규 등록(클릭 시 찾은 선 위의 실제 좌표를 그대로 저장)
        if(!memoPendingPoint){
            alert("선 위의 위치 정보를 찾을 수 없습니다. 다시 클릭해주세요.");
            return;
        }
        const memoTime = Highcharts.dateFormat("%Y-%m-%d %H:%M:%S", memoPendingPoint.x);
        $.ajax({
            type:"POST",
            url:"/tkheat/monitoring/trend/saveMemo",
            data:{
                hogi_code: hogi,
                memo_time: memoTime,
                memo_text: text,
                memo_value: memoPendingPoint.y,
                yaxis_index: memoPendingPoint.yAxisIndex,
                series_name: memoPendingPoint.seriesName
            },
            success:function(){
                closeMemoModal();
                loadAndRenderMemos(getCurrentTargetChart(), hogi);
            },
            error:function(){ alert("메모 저장 중 오류가 발생했습니다."); }
        });
    }
}

function deleteMemo(){
    if(!memoEditingCode) return;
    if(!confirm("이 메모를 삭제하시겠습니까?")) return;

    $.ajax({
        type:"POST",
        url:"/tkheat/monitoring/trend/deleteMemo",
        data:{ memo_code: memoEditingCode },
        success:function(){
            closeMemoModal();
            loadAndRenderMemos(getCurrentTargetChart(), hogi);
        },
        error:function(){ alert("메모 삭제 중 오류가 발생했습니다."); }
    });
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
                loadAndRenderMemos(chart, hogi);
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

/* 빠른 시간범위 버튼 클릭 */
$(".range-btn").on("click", function(){
    const hours = parseInt($(this).data("hours"), 10);
    selectQuickRange(hours);
});

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
