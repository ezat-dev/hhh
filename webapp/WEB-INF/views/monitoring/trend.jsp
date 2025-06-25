<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통합모니터링</title>
    <link rel="stylesheet" href="/tkheat/css/monitoring/monitoring.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
    <style>
.main {
	width: 98%;
}

.topTrend{
	display:flex;
}

.bottomTrend{
	display:flex;
}

.container {
	display: flex;
	justify-content: space-between;
}

.begaInsertModal {
	position: fixed; /* 화면에 고정 */
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 1000; /* 다른 요소 위에 표시 */
}

.header {
	display: flex; /* 플렉스 박스 사용 */
	justify-content: center; /* 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	margin-bottom: 10px; /* 상단 여백 */
	background-color: #33363d; /* 배경색 */
	height: 50px; /* 높이 */
	color: white; /* 글자색 */
	font-size: 20px; /* 글자 크기 */
	text-align: center; /* 텍스트 정렬 */
}

.detail {
	background: #ffffff;
	border: 1px solid #000000;
	width: 800px; /* 가로 길이 고정 */
	height: 630px; /* 세로 길이 고정 */
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.7);
	margin: 20px auto; /* 중앙 정렬 */
	padding: 20px;
	border-radius: 5px; /* 모서리 둥글게 */
	overflow-y: auto; /* 세로 스크롤 추가 */
}

.insideTable {
	width: 100%; /* 테이블 너비 100% */
	border-collapse: collapse; /* 테두리 겹침 제거 */
}

.insideTable th, .insideTable td {
	padding: 8px; /* 셀 패딩 */
	border: 1px solid #ccc; /* 셀 경계선 */
	vertical-align: middle; /* 수직 정렬 */
}

.insideTable th {
	background: #f0f0f0; /* 헤더 배경색 */
}

.basic, .rp-input, .form-control {
	width: calc(100% - 12px); /* 너비 조정 */
	padding: 5px; /* 내부 여백 */
	border: 1px solid #949494; /* 경계선 색상 */
	border-radius: 3px; /* 둥근 모서리 */
}

.basic[readonly] {
	background-color: #f9f9f9; /* 읽기 전용 필드 색상 */
}

textarea {
	width: 100%; /* 너비 100% */
	padding: 5px; /* 내부 여백 */
	border: 1px solid #949494; /* 경계선 색상 */
	border-radius: 3px; /* 둥근 모서리 */
}

.findImage {
	display: flex; /* 플렉스 박스 사용 */
	align-items: center; /* 수직 정렬 */
}

.findImage input[type="file"] {
	margin-right: 10px; /* 오른쪽 여백 */
}

.imgArea {
	width: 200px; /* 이미지 영역 너비 */
	height: 150px; /* 이미지 영역 높이 */
	border: 1px solid #ddd; /* 경계선 */
	margin-bottom: 10px; /* 하단 여백 */
}

.imgArea img {
	width: 100%; /* 이미지 너비 */
	height: 100%; /* 이미지 높이 */
	object-fit: cover; /* 이미지 비율 유지 */
}

.btnSaveClose {
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	gap: 20px; /* 버튼 사이 여백 */
	margin-top: 30px; /* 모달 내용과의 간격 */
	margin-bottom: 20px; /* 모달 하단과 버튼 사이 간격  */
}
.btnSaveClose button {
	width: 100px;
	height: 35px;
	background-color: #FFD700; /* 기본 배경 - 노란색 */
	color: black;
	border: 2px solid #FFC107; /* 노란 테두리 */
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	line-height: 35px;
	margin: 0 10px;
	margin-top: 10px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

/* 저장 버튼 호버 시 */
.btnSaveClose .save:hover {
	background-color: #FFC107;
	transform: scale(1.05);
}

/* 닫기 버튼 - 회색 톤 */
.btnSaveClose .close {
	background-color: #A9A9A9;
	color: black;
	border: 2px solid #808080;
}

/* 닫기 버튼 호버 시 */
.btnSaveClose .close:hover {
	background-color: #808080;
	transform: scale(1.05);
}
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -700px;
}

.box1 select{
	width: 5%
}  
.box1 input[type="date"] {
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
.box1 input[type="time"] {
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

.box1 input[type="date"]:focus {
	border: 1px solid #007bff;
	background-color: #fff;
}  
.box1 input[type="time"]:focus {
	border: 1px solid #007bff;
	background-color: #fff;
}  
.box1 label,
.box1 input {
	margin-right: 10px; /* 요소 사이 간격 */
}  
th{
	font-size:14px;
}


.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.modal-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  width: 90%;
  max-width: 1000px;
  position: relative;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  font-weight: bold;
  font-size: 18px;
  margin-bottom: 10px;
}

.modal-close {
  cursor: pointer;
  font-size: 24px;
}
  </style>
  <title>Trend Chart</title>
</head>
<body>
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>        
		<label class="daylabel">기간 : </label>
		<input type="date" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off">  
		<input type="time" class="stime" id="stime" style="font-size: 16px;" autocomplete="off"> ~ 
		<input type="date" class="edate" id="edate" style="font-size: 16px;" autocomplete="off">
		<input type="time" class="etime" id="etime" style="font-size: 16px;" autocomplete="off">
	</div>

    <div class="button-container">
        <button class="select-button">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           
        </button>
        <button class="insert-button" style="pointer-events: none; opacity: 0.5; cursor: not-allowed; filter: grayscale(100%); ">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
          
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
            
        </button>
        <button class="printer-button">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
            
        </button>
    </div>
</div>
    <main class="main">
    	<div class="topTrend">
			<div id="bcf1"></div>
			<div id="bcf2"></div>
			<div id="bcf3"></div>    	
    	</div>
    	<div class="bottomTrend">
			<div id="bcf4"></div>
			<div id="bcf5"></div>
			<div id="tf1"></div>    	
    	</div>
	</main>
	<input type="text" id="startDate" name="startDate" style="display:none;"/>
	<input type="text" id="endDate" name="endDate" style="display:none;"/>
<script>
//전역변수
let bcf1Array = new Array();
let bcf2Array = new Array();
let bcf3Array = new Array();
let bcf4Array = new Array();
let bcf5Array = new Array();
let tf1Array = new Array();

//로드
$(function(){
	$("#sdate").val(todayDate());
	$("#stime").val(nowTimeBeforefour());
	$("#edate").val(todayDate());
	$("#etime").val(nowTime());

	var sdate = $("#sdate").val();
	var stime = $("#stime").val();
	var edate = $("#edate").val();
	var etime = $("#etime").val();

	$("#startDate").val(sdate+" "+stime);
	$("#endDate").val(edate+" "+etime);

	getChartData();

//	getBcf1();
});

//이벤트
$(".select-button").on("click",function(){
	var sdate = $("#sdate").val();
	var stime = $("#stime").val();
	var edate = $("#edate").val();
	var etime = $("#etime").val();

	$("#startDate").val(sdate+" "+stime);
	$("#endDate").val(edate+" "+etime);

	getChartData();
	
});

//함수
function getChartData(){
    $.ajax({
        url: "/tkheat/monitoring/trend/list",
        type: "post",
        dataType: "json",
        data: {
            "startDate": $("#startDate").val(),
            "endDate": $("#endDate").val()
        },
        success: function (result) {
            var tdatetime = result.tdatetime;

            var bcf1_cf = result.bcf1_cf_pv;
            var bcf1_oil = result.bcf1_oil_pv;
            var bcf1_cp = result.bcf1_cp_pv;
            var bcf2_cf = result.bcf2_cf_pv;
            var bcf2_oil = result.bcf2_oil_pv;
            var bcf2_cp = result.bcf2_cp_pv;
            var bcf3_cf = result.bcf3_cf_pv;
            var bcf3_oil = result.bcf3_oil_pv;
            var bcf3_cp = result.bcf3_cp_pv;
            var bcf4_cf = result.bcf4_cf_pv;
            var bcf4_oil = result.bcf4_oil_pv;
            var bcf4_cp = result.bcf4_cp_pv;
            var bcf5_cf = result.bcf5_cf_pv;
            var bcf5_oil = result.bcf5_oil_pv;
            var bcf5_cp = result.bcf5_cp_pv;
            var tf1_zone1 = result.tf1_zone1;
            var tf1_zone2 = result.tf1_zone2;
            var tf1_zone3 = result.tf1_zone3;

			
            bcf1Array[0] = bcf1_cf;
            bcf1Array[1] = bcf1_oil;
            bcf1Array[2] = bcf1_cp;
            bcf2Array[0] = bcf2_cf;
            bcf2Array[1] = bcf2_oil;
            bcf2Array[2] = bcf2_cp;
            bcf3Array[0] = bcf3_cf;
            bcf3Array[1] = bcf3_oil;
            bcf3Array[2] = bcf3_cp;
            bcf4Array[0] = bcf4_cf;
            bcf4Array[1] = bcf4_oil;
            bcf4Array[2] = bcf4_cp;
            bcf5Array[0] = bcf5_cf;
            bcf5Array[1] = bcf5_oil;
            bcf5Array[2] = bcf5_cp;
            tf1Array[0] = tf1_zone1;
            tf1Array[1] = tf1_zone2;
            tf1Array[2] = tf1_zone3;

            var bcf1Chart = $("#bcf1").highcharts();
            var bcf2Chart = $("#bcf2").highcharts();
            var bcf3Chart = $("#bcf3").highcharts();
            var bcf4Chart = $("#bcf4").highcharts();
            var bcf5Chart = $("#bcf5").highcharts();
            var tf1Chart = $("#tf1").highcharts();
            getBcf1();       
            getBcf2();       
            getBcf3();       
            getBcf4();       
            getBcf5();       
            getTf1();
/*
            if (typeof bcf1Chart != "undefined") {
                
            	bcf1Chart.series[0].update(bcf1_cf,false);
            	bcf1Chart.series[1].update(bcf1_oil,false);
            	bcf1Chart.series[2].update(bcf1_cp,false);

            	bcf1Chart.redraw();
            }else{
    			getBcf1();
                
            }
            if (typeof bcf2Chart != "undefined") {
                
            	bcf2Chart.series[0].update(bcf2_cf,false);
            	bcf2Chart.series[1].update(bcf2_oil,false);
            	bcf2Chart.series[2].update(bcf2_cp,false);

            	bcf2Chart.redraw();
            }else{
            	getBcf2();
                
            }
            if (typeof bcf3Chart != "undefined") {
                
            	bcf3Chart.series[0].update(bcf3_cf,false);
            	bcf3Chart.series[1].update(bcf3_oil,false);
            	bcf3Chart.series[2].update(bcf3_cp,false);

            	bcf3Chart.redraw();
            }else{
    			getBcf3();
                
            }
            if (typeof bcf4Chart != "undefined") {
                
            	bcf4Chart.series[0].update(bcf4_cf,false);
            	bcf4Chart.series[1].update(bcf4_oil,false);
            	bcf4Chart.series[2].update(bcf4_cp,false);

            	bcf4Chart.redraw();
            }else{
    			getBcf4();
                
            }
            if (typeof bcf5Chart != "undefined") {
                
            	bcf5Chart.series[0].update(bcf5_cf,false);
            	bcf5Chart.series[1].update(bcf5_oil,false);
            	bcf5Chart.series[2].update(bcf5_cp,false);

            	bcf5Chart.redraw();
            }else{
    			getBcf5();
                
            }
            if (typeof tf1Chart != "undefined") {
                
            	tf1Chart.series[0].update(tf1_zone1,false);
            	tf1Chart.series[1].update(tf1_zone2,false);
            	tf1Chart.series[2].update(tf1_zone3,false);

            	tf1Chart.redraw();
            }else{
    			getTf1();
                
            }
*/
        }
    });
	
}

function getBcf1(){
    const chart = Highcharts.chart('bcf1', {
        title:{
            text:"BCF1"
        },
        chart: {
            type: "spline",
            panning: true,
            panKey: "shift",
            zoomType: "x",
            styleMode: true,
            height:400,  // 차트 높이 설정
            width: 500   // 차트 너비 설정
        },
        time: {
            timezone: "Asia/Seoul",
            useUTC: false
        },
        yAxis: [
            {
                min:0,
                max:1000,
                crosshair: {
                    width: 3,
                    color: '#5D5D5D',
                    zIndex: 5
                },
                title: {
                    text: 'Temper(℃)'
                },
                labels: {
              /*   	format: '{value} (℃)', */
                    style: {
                        fontSize: "14pt"
                    }
                }
            }
            
            ],
        xAxis: {
            crosshair: {
                width: 3,
                color: '#5D5D5D',
                zIndex: 5
            },
            labels: {
                formatter: function() {
                    return unix_timestamp(this.value);
                },
                style: {
                    fontSize: "11pt"
                }
            },
            allowDecimals: false
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },
        plotOptions: {
            series: {
                selected: true,
                marker: {
                    radius: 1
                }
            }
        },
        series: bcf1Array,
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 1500
                },
                chartOptions: {
                    legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    }
                }
            }]
        },
/*
        tooltip: {
            useHTML: true,
            shared: true, // 여러 시리즈의 데이터를 보여줌
            positioner: function(labelWidth, labelHeight, point) {
            		//maxWidth : 1500으로 설정되어 있음.
            		var xValue = 0;
        			var yValue = 0;
            		if((1500-200) < (point.plotX + this.chart.plotLeft + 15)){
            			xValue = (1500-200);
            		}else{
            			xValue = (point.plotX + this.chart.plotLeft + 15);
            		}
            		var obj = {"x":point.plotX, "plotX":this.chart.plotLeft, 
            					"y":point.plotY, "plotY":this.chart.plotTop};
            		console.log(obj);
            		
              return { x: 900, y: 60 }; // 툴팁 위치 조정
            },
            formatter: function() {
          	  $("#value0_v").text(Highcharts.dateFormat('%m-%d %H:%M',this.x));
              var s = '<b style="font-size:14pt;">' + cursorSetDateTime(this.x) + '</b><br/>'; // 시간 표시
              this.points.forEach(function(point) {
              	var point_y = point.y;
              	var point_name = point.series.name;
              	if(point_name.indexOf("CP") != -1){
              		point_y = (point.y).toFixed(3);
              	}
              	
              	$("#value"+(point.series.index+1)+"_h").css("color",point.series.color);
              	$("#value"+(point.series.index+1)+"_v").text(point_y);
              	//color:' + point.series.color + '
              	
                s += '<span style="font-weight:bold; font-size:14pt; ">' + point.series.name + ':</span> <span style="font-size:14pt;">' + point_y + '</span><br/>'; // 각 시리즈의 데이터 표시
              });
              return s;
            },
            borderColor: '#333333',
            shadow: false
          },
*/
        exporting: {
            menuItemDefinitions: {
                label: {
                    onclick: function () {
                        this.renderer.label(
                            'You just clicked a custom menu item',
                            100,
                            100
                        )
                        .attr({
                            fill: '#a4edba',
                            r: 5,
                            padding: 10,
                            zIndex: 10
                        })
                        .css({
                            fontSize: '1.5em'
                        })
                        .add();
                    },
                    text: 'Show label'
                }
            },
            buttons: {
                contextButton: {
                    menuItems: ['downloadPNG', 'downloadPDF', 'downloadXLS', 'separator']
                }
            }
        },
        legend: {
            itemStyle: {
                fontSize: "11pt"
            }
        }
    });
}
function getBcf2(){
    const chart = Highcharts.chart('bcf2', {
        title:{
            text:"BCF2"
        },
        chart: {
            type: "spline",
            panning: true,
            panKey: "shift",
            zoomType: "x",
            styleMode: true,
            height:400,  // 차트 높이 설정
            width: 500   // 차트 너비 설정
        },
        time: {
            timezone: "Asia/Seoul",
            useUTC: false
        },
        yAxis: [
            {
                min:0,
                max:1000,
                crosshair: {
                    width: 3,
                    color: '#5D5D5D',
                    zIndex: 5
                },
                title: {
                    text: 'Temper(℃)'
                },
                labels: {
              /*   	format: '{value} (℃)', */
                    style: {
                        fontSize: "14pt"
                    }
                }
            }
            
            ],
        xAxis: {
            crosshair: {
                width: 3,
                color: '#5D5D5D',
                zIndex: 5
            },
            labels: {
                formatter: function() {
                    return unix_timestamp(this.value);
                },
                style: {
                    fontSize: "11pt"
                }
            },
            allowDecimals: false
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },
        plotOptions: {
            series: {
                selected: true,
                marker: {
                    radius: 1
                }
            }
        },
        series: bcf2Array,
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 1500
                },
                chartOptions: {
                    legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    }
                }
            }]
        },
/*
        tooltip: {
            useHTML: true,
            shared: true, // 여러 시리즈의 데이터를 보여줌
            positioner: function(labelWidth, labelHeight, point) {
            		//maxWidth : 1500으로 설정되어 있음.
            		var xValue = 0;
        			var yValue = 0;
            		if((1500-200) < (point.plotX + this.chart.plotLeft + 15)){
            			xValue = (1500-200);
            		}else{
            			xValue = (point.plotX + this.chart.plotLeft + 15);
            		}
            		var obj = {"x":point.plotX, "plotX":this.chart.plotLeft, 
            					"y":point.plotY, "plotY":this.chart.plotTop};
            		console.log(obj);
            		
              return { x: 900, y: 60 }; // 툴팁 위치 조정
            },
            formatter: function() {
          	  $("#value0_v").text(Highcharts.dateFormat('%m-%d %H:%M',this.x));
              var s = '<b style="font-size:14pt;">' + cursorSetDateTime(this.x) + '</b><br/>'; // 시간 표시
              this.points.forEach(function(point) {
              	var point_y = point.y;
              	var point_name = point.series.name;
              	if(point_name.indexOf("CP") != -1){
              		point_y = (point.y).toFixed(3);
              	}
              	
              	$("#value"+(point.series.index+1)+"_h").css("color",point.series.color);
              	$("#value"+(point.series.index+1)+"_v").text(point_y);
              	//color:' + point.series.color + '
              	
                s += '<span style="font-weight:bold; font-size:14pt; ">' + point.series.name + ':</span> <span style="font-size:14pt;">' + point_y + '</span><br/>'; // 각 시리즈의 데이터 표시
              });
              return s;
            },
            borderColor: '#333333',
            shadow: false
          },
*/
        exporting: {
            menuItemDefinitions: {
                label: {
                    onclick: function () {
                        this.renderer.label(
                            'You just clicked a custom menu item',
                            100,
                            100
                        )
                        .attr({
                            fill: '#a4edba',
                            r: 5,
                            padding: 10,
                            zIndex: 10
                        })
                        .css({
                            fontSize: '1.5em'
                        })
                        .add();
                    },
                    text: 'Show label'
                }
            },
            buttons: {
                contextButton: {
                    menuItems: ['downloadPNG', 'downloadPDF', 'downloadXLS', 'separator']
                }
            }
        },
        legend: {
            itemStyle: {
                fontSize: "11pt"
            }
        }
    });
}
function getBcf3(){
    const chart = Highcharts.chart('bcf3', {
        title:{
            text:"BCF3"
        },
        chart: {
            type: "spline",
            panning: true,
            panKey: "shift",
            zoomType: "x",
            styleMode: true,
            height:400,  // 차트 높이 설정
            width: 500   // 차트 너비 설정
        },
        time: {
            timezone: "Asia/Seoul",
            useUTC: false
        },
        yAxis: [
            {
                min:0,
                max:1000,
                crosshair: {
                    width: 3,
                    color: '#5D5D5D',
                    zIndex: 5
                },
                title: {
                    text: 'Temper(℃)'
                },
                labels: {
              /*   	format: '{value} (℃)', */
                    style: {
                        fontSize: "14pt"
                    }
                }
            }
            
            ],
        xAxis: {
            crosshair: {
                width: 3,
                color: '#5D5D5D',
                zIndex: 5
            },
            labels: {
                formatter: function() {
                    return unix_timestamp(this.value);
                },
                style: {
                    fontSize: "11pt"
                }
            },
            allowDecimals: false
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },
        plotOptions: {
            series: {
                selected: true,
                marker: {
                    radius: 1
                }
            }
        },
        series: bcf3Array,
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 1500
                },
                chartOptions: {
                    legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    }
                }
            }]
        },
/*
        tooltip: {
            useHTML: true,
            shared: true, // 여러 시리즈의 데이터를 보여줌
            positioner: function(labelWidth, labelHeight, point) {
            		//maxWidth : 1500으로 설정되어 있음.
            		var xValue = 0;
        			var yValue = 0;
            		if((1500-200) < (point.plotX + this.chart.plotLeft + 15)){
            			xValue = (1500-200);
            		}else{
            			xValue = (point.plotX + this.chart.plotLeft + 15);
            		}
            		var obj = {"x":point.plotX, "plotX":this.chart.plotLeft, 
            					"y":point.plotY, "plotY":this.chart.plotTop};
            		console.log(obj);
            		
              return { x: 900, y: 60 }; // 툴팁 위치 조정
            },
            formatter: function() {
          	  $("#value0_v").text(Highcharts.dateFormat('%m-%d %H:%M',this.x));
              var s = '<b style="font-size:14pt;">' + cursorSetDateTime(this.x) + '</b><br/>'; // 시간 표시
              this.points.forEach(function(point) {
              	var point_y = point.y;
              	var point_name = point.series.name;
              	if(point_name.indexOf("CP") != -1){
              		point_y = (point.y).toFixed(3);
              	}
              	
              	$("#value"+(point.series.index+1)+"_h").css("color",point.series.color);
              	$("#value"+(point.series.index+1)+"_v").text(point_y);
              	//color:' + point.series.color + '
              	
                s += '<span style="font-weight:bold; font-size:14pt; ">' + point.series.name + ':</span> <span style="font-size:14pt;">' + point_y + '</span><br/>'; // 각 시리즈의 데이터 표시
              });
              return s;
            },
            borderColor: '#333333',
            shadow: false
          },
*/
        exporting: {
            menuItemDefinitions: {
                label: {
                    onclick: function () {
                        this.renderer.label(
                            'You just clicked a custom menu item',
                            100,
                            100
                        )
                        .attr({
                            fill: '#a4edba',
                            r: 5,
                            padding: 10,
                            zIndex: 10
                        })
                        .css({
                            fontSize: '1.5em'
                        })
                        .add();
                    },
                    text: 'Show label'
                }
            },
            buttons: {
                contextButton: {
                    menuItems: ['downloadPNG', 'downloadPDF', 'downloadXLS', 'separator']
                }
            }
        },
        legend: {
            itemStyle: {
                fontSize: "11pt"
            }
        }
    });
}
function getBcf4(){
    const chart = Highcharts.chart('bcf4', {
        title:{
            text:"BCF4"
        },
        chart: {
            type: "spline",
            panning: true,
            panKey: "shift",
            zoomType: "x",
            styleMode: true,
            height:400,  // 차트 높이 설정
            width: 500   // 차트 너비 설정
        },
        time: {
            timezone: "Asia/Seoul",
            useUTC: false
        },
        yAxis: [
            {
                min:0,
                max:1000,
                crosshair: {
                    width: 3,
                    color: '#5D5D5D',
                    zIndex: 5
                },
                title: {
                    text: 'Temper(℃)'
                },
                labels: {
              /*   	format: '{value} (℃)', */
                    style: {
                        fontSize: "14pt"
                    }
                }
            }
            
            ],
        xAxis: {
            crosshair: {
                width: 3,
                color: '#5D5D5D',
                zIndex: 5
            },
            labels: {
                formatter: function() {
                    return unix_timestamp(this.value);
                },
                style: {
                    fontSize: "11pt"
                }
            },
            allowDecimals: false
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },
        plotOptions: {
            series: {
                selected: true,
                marker: {
                    radius: 1
                }
            }
        },
        series: bcf4Array,
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 1500
                },
                chartOptions: {
                    legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    }
                }
            }]
        },
/*
        tooltip: {
            useHTML: true,
            shared: true, // 여러 시리즈의 데이터를 보여줌
            positioner: function(labelWidth, labelHeight, point) {
            		//maxWidth : 1500으로 설정되어 있음.
            		var xValue = 0;
        			var yValue = 0;
            		if((1500-200) < (point.plotX + this.chart.plotLeft + 15)){
            			xValue = (1500-200);
            		}else{
            			xValue = (point.plotX + this.chart.plotLeft + 15);
            		}
            		var obj = {"x":point.plotX, "plotX":this.chart.plotLeft, 
            					"y":point.plotY, "plotY":this.chart.plotTop};
            		console.log(obj);
            		
              return { x: 900, y: 60 }; // 툴팁 위치 조정
            },
            formatter: function() {
          	  $("#value0_v").text(Highcharts.dateFormat('%m-%d %H:%M',this.x));
              var s = '<b style="font-size:14pt;">' + cursorSetDateTime(this.x) + '</b><br/>'; // 시간 표시
              this.points.forEach(function(point) {
              	var point_y = point.y;
              	var point_name = point.series.name;
              	if(point_name.indexOf("CP") != -1){
              		point_y = (point.y).toFixed(3);
              	}
              	
              	$("#value"+(point.series.index+1)+"_h").css("color",point.series.color);
              	$("#value"+(point.series.index+1)+"_v").text(point_y);
              	//color:' + point.series.color + '
              	
                s += '<span style="font-weight:bold; font-size:14pt; ">' + point.series.name + ':</span> <span style="font-size:14pt;">' + point_y + '</span><br/>'; // 각 시리즈의 데이터 표시
              });
              return s;
            },
            borderColor: '#333333',
            shadow: false
          },
*/
        exporting: {
            menuItemDefinitions: {
                label: {
                    onclick: function () {
                        this.renderer.label(
                            'You just clicked a custom menu item',
                            100,
                            100
                        )
                        .attr({
                            fill: '#a4edba',
                            r: 5,
                            padding: 10,
                            zIndex: 10
                        })
                        .css({
                            fontSize: '1.5em'
                        })
                        .add();
                    },
                    text: 'Show label'
                }
            },
            buttons: {
                contextButton: {
                    menuItems: ['downloadPNG', 'downloadPDF', 'downloadXLS', 'separator']
                }
            }
        },
        legend: {
            itemStyle: {
                fontSize: "11pt"
            }
        }
    });
}
function getBcf5(){
    const chart = Highcharts.chart('bcf5', {
        title:{
            text:"BCF5"
        },
        chart: {
            type: "spline",
            panning: true,
            panKey: "shift",
            zoomType: "x",
            styleMode: true,
            height:400,  // 차트 높이 설정
            width: 500   // 차트 너비 설정
        },
        time: {
            timezone: "Asia/Seoul",
            useUTC: false
        },
        yAxis: [
            {
                min:0,
                max:1000,
                crosshair: {
                    width: 3,
                    color: '#5D5D5D',
                    zIndex: 5
                },
                title: {
                    text: 'Temper(℃)'
                },
                labels: {
              /*   	format: '{value} (℃)', */
                    style: {
                        fontSize: "14pt"
                    }
                }
            }
            
            ],
        xAxis: {
            crosshair: {
                width: 3,
                color: '#5D5D5D',
                zIndex: 5
            },
            labels: {
                formatter: function() {
                    return unix_timestamp(this.value);
                },
                style: {
                    fontSize: "11pt"
                }
            },
            allowDecimals: false
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },
        plotOptions: {
            series: {
                selected: true,
                marker: {
                    radius: 1
                }
            }
        },
        series: bcf5Array,
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 1500
                },
                chartOptions: {
                    legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    }
                }
            }]
        },
/*
        tooltip: {
            useHTML: true,
            shared: true, // 여러 시리즈의 데이터를 보여줌
            positioner: function(labelWidth, labelHeight, point) {
            		//maxWidth : 1500으로 설정되어 있음.
            		var xValue = 0;
        			var yValue = 0;
            		if((1500-200) < (point.plotX + this.chart.plotLeft + 15)){
            			xValue = (1500-200);
            		}else{
            			xValue = (point.plotX + this.chart.plotLeft + 15);
            		}
            		var obj = {"x":point.plotX, "plotX":this.chart.plotLeft, 
            					"y":point.plotY, "plotY":this.chart.plotTop};
            		console.log(obj);
            		
              return { x: 900, y: 60 }; // 툴팁 위치 조정
            },
            formatter: function() {
          	  $("#value0_v").text(Highcharts.dateFormat('%m-%d %H:%M',this.x));
              var s = '<b style="font-size:14pt;">' + cursorSetDateTime(this.x) + '</b><br/>'; // 시간 표시
              this.points.forEach(function(point) {
              	var point_y = point.y;
              	var point_name = point.series.name;
              	if(point_name.indexOf("CP") != -1){
              		point_y = (point.y).toFixed(3);
              	}
              	
              	$("#value"+(point.series.index+1)+"_h").css("color",point.series.color);
              	$("#value"+(point.series.index+1)+"_v").text(point_y);
              	//color:' + point.series.color + '
              	
                s += '<span style="font-weight:bold; font-size:14pt; ">' + point.series.name + ':</span> <span style="font-size:14pt;">' + point_y + '</span><br/>'; // 각 시리즈의 데이터 표시
              });
              return s;
            },
            borderColor: '#333333',
            shadow: false
          },
*/
        exporting: {
            menuItemDefinitions: {
                label: {
                    onclick: function () {
                        this.renderer.label(
                            'You just clicked a custom menu item',
                            100,
                            100
                        )
                        .attr({
                            fill: '#a4edba',
                            r: 5,
                            padding: 10,
                            zIndex: 10
                        })
                        .css({
                            fontSize: '1.5em'
                        })
                        .add();
                    },
                    text: 'Show label'
                }
            },
            buttons: {
                contextButton: {
                    menuItems: ['downloadPNG', 'downloadPDF', 'downloadXLS', 'separator']
                }
            }
        },
        legend: {
            itemStyle: {
                fontSize: "11pt"
            }
        }
    });
}
function getTf1(){
    const chart = Highcharts.chart('tf1', {
        title:{
            text:"TF1"
        },
        chart: {
            type: "spline",
            panning: true,
            panKey: "shift",
            zoomType: "x",
            styleMode: true,
            height:400,  // 차트 높이 설정
            width: 500   // 차트 너비 설정
        },
        time: {
            timezone: "Asia/Seoul",
            useUTC: false
        },
        yAxis: [
            {
                min:0,
                max:1000,
                crosshair: {
                    width: 3,
                    color: '#5D5D5D',
                    zIndex: 5
                },
                title: {
                    text: 'Temper(℃)'
                },
                labels: {
              /*   	format: '{value} (℃)', */
                    style: {
                        fontSize: "14pt"
                    }
                }
            }
            
            ],
        xAxis: {
            crosshair: {
                width: 3,
                color: '#5D5D5D',
                zIndex: 5
            },
            labels: {
                formatter: function() {
                    return unix_timestamp(this.value);
                },
                style: {
                    fontSize: "11pt"
                }
            },
            allowDecimals: false
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },
        plotOptions: {
            series: {
                selected: true,
                marker: {
                    radius: 1
                }
            }
        },
        series: tf1Array,
        responsive: {
            rules: [{
                condition: {
                    maxWidth: 1500
                },
                chartOptions: {
                    legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    }
                }
            }]
        },
/*
        tooltip: {
            useHTML: true,
            shared: true, // 여러 시리즈의 데이터를 보여줌
            positioner: function(labelWidth, labelHeight, point) {
            		//maxWidth : 1500으로 설정되어 있음.
            		var xValue = 0;
        			var yValue = 0;
            		if((1500-200) < (point.plotX + this.chart.plotLeft + 15)){
            			xValue = (1500-200);
            		}else{
            			xValue = (point.plotX + this.chart.plotLeft + 15);
            		}
            		var obj = {"x":point.plotX, "plotX":this.chart.plotLeft, 
            					"y":point.plotY, "plotY":this.chart.plotTop};
            		console.log(obj);
            		
              return { x: 900, y: 60 }; // 툴팁 위치 조정
            },
            formatter: function() {
          	  $("#value0_v").text(Highcharts.dateFormat('%m-%d %H:%M',this.x));
              var s = '<b style="font-size:14pt;">' + cursorSetDateTime(this.x) + '</b><br/>'; // 시간 표시
              this.points.forEach(function(point) {
              	var point_y = point.y;
              	var point_name = point.series.name;
              	if(point_name.indexOf("CP") != -1){
              		point_y = (point.y).toFixed(3);
              	}
              	
              	$("#value"+(point.series.index+1)+"_h").css("color",point.series.color);
              	$("#value"+(point.series.index+1)+"_v").text(point_y);
              	//color:' + point.series.color + '
              	
                s += '<span style="font-weight:bold; font-size:14pt; ">' + point.series.name + ':</span> <span style="font-size:14pt;">' + point_y + '</span><br/>'; // 각 시리즈의 데이터 표시
              });
              return s;
            },
            borderColor: '#333333',
            shadow: false
          },
*/
        exporting: {
            menuItemDefinitions: {
                label: {
                    onclick: function () {
                        this.renderer.label(
                            'You just clicked a custom menu item',
                            100,
                            100
                        )
                        .attr({
                            fill: '#a4edba',
                            r: 5,
                            padding: 10,
                            zIndex: 10
                        })
                        .css({
                            fontSize: '1.5em'
                        })
                        .add();
                    },
                    text: 'Show label'
                }
            },
            buttons: {
                contextButton: {
                    menuItems: ['downloadPNG', 'downloadPDF', 'downloadXLS', 'separator']
                }
            }
        },
        legend: {
            itemStyle: {
                fontSize: "11pt"
            }
        }
    });
}



function unix_timestamp(t) {
//	console.log(t);	

    var date = new Date(t*1000);
    var year = date.getFullYear();

    var month = paddingZero(date.getMonth()+1);
    var day = paddingZero(date.getDate());
    var hour = paddingZero(date.getHours());
    var minute = paddingZero(date.getMinutes());
    
//    return month.substr(-2) + "-" + day.substr(-2) + "<br/> " + hour.substr(-2) + ":" + minute.substr(-2);
    return month + "-" + day + "<br/> " + hour + ":" + minute;
}


function cursorSetDateTime(t) {
//	console.log(t);	

    var date = new Date(t*1000);
    var year = date.getFullYear();

    var month = paddingZero(date.getMonth()+1);
    var day = paddingZero(date.getDate());
    var hour = paddingZero(date.getHours());
    var minute = paddingZero(date.getMinutes());
    
    return year+"-"+month.substr(-2) + "-" + day.substr(-2) + " " + hour.substr(-2) + ":" + minute.substr(-2);
}

</script>

	</body>
</html>
