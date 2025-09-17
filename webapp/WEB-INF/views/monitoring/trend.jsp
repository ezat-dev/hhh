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
    .button-container {
        display: flex;
        align-items: center;
        gap: 10px;
        margin: 40px auto 0 20px;
        width: fit-content;
    }

    .daylabel {
        font-size: 16px;
        margin-right: 8px;
        white-space: nowrap;
    }

    #hogiSelect, .datetimeSet {
        height: 34px;
        font-size: 14px;
        padding: 0 8px;
        border-radius: 4px;
        border: 1px solid #ccc;
    }

    .date_input {
        display: flex;
        align-items: center;
    }

    .mid {
        margin: 0 6px;
        font-size: 18px;
        font-weight: bold;
    }

    .select-button {
        height: 36px;
        padding: 4px 12px;
        background-color: #007bff;
        border: none;
        border-radius: 4px;
        color: white;
        display: flex;
        align-items: center;
        cursor: pointer;
    }

    .select-button:hover {
        background-color: #0056b3;
    }

    .button-image {
        width: 18px;
        height: 18px;
        margin-right: 6px;
    }
  </style>
  <title>Trend Chart</title>
</head>
<body>

	<div class="button-container">
	    <label class="daylabel">검색 날짜 :</label>
	    <select id="hogiSelect" style="height:30px; font-size:16px; margin-right:10px; border-radius:4px;">
	        <option value="BCF1" selected>BCF1</option>
	        <option value="BCF2">BCF2</option>
	        <option value="BCF3">BCF3</option>
	        <option value="BCF4">BCF4</option>
	        <option value="BCF5">BCF5</option>
	        <option value="TF1">TF1</option>
	    </select>
	
	    <div class="date_input" style="text-align: center;">
	        <input type="text" autocomplete="off" class="datetimeSet" id="startDate"
	            style="font-size: 16px; margin: 5px; border-radius: 4px; border: 1px solid #ccc; text-align: center; height: 30px;">
	
	        <span class="mid" style="font-size: 20px; font-weight: bold; margin-bottom:10px;"> ~ </span>
	
	        <input type="text" autocomplete="off" class="datetimeSet" id="endDate"
	            style="font-size: 16px; margin: 5px; border-radius: 4px; border: 1px solid #ccc; text-align: center; height: 30px;">
	    </div>
	
	    <button class="select-button">
	        <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">조회
	    </button>
	</div>
	
	<div id="container" style="width: 100%; height: 600px; margin-top:100px;"></div>
			
			
			
			
<script>
$(document).ready(function () {
    $(".datetimeSet").datepicker({
        language: 'ko',
        timepicker: true,
        dateFormat: 'yyyy-mm-dd',
        timeFormat: 'hh:ii',
        autoClose: true
    });

    
    $("#startDate").val(trendStime());
    $("#endDate").val(trendEtime());

    var hogi = "";
    var seriesArray = [];

    
    function fetchData() {
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();
        hogi = $("#hogiSelect").val();

        $.ajax({
            type: "POST",
            url: "/tkheat/monitoring/trend/trendList",
            data: { startDate, endDate },
            success: function (result) {
                console.log("result:", result);

                
                var t1_pv_save = [];
                var t2_pv_save = [];
                var t3_pv_save = [];
                var t1_sv_save = [];
                var t2_sv_save = [];
                var t3_sv_save = [];

                result.forEach(function(data){
                   
                    var tdate_val = new Date(data.tdatetime).getTime();

                    var t1_val = 0, t2_val = 0, t3_val = 0, t4_val = 0, t5_val = 0, t6_val = 0;

                    
                    if(hogi === "BCF1"){						
                        t1_val = data.bcf1_cf_pv;
                        t2_val = data.bcf1_oil_pv;
                        t3_val = data.bcf1_cp_pv;
                        t4_val = data.bcf1_cf_sv;
                        t5_val = data.bcf1_oil_sv;
                        t6_val = data.bcf1_cp_sv;
                    }else if(hogi === "BCF2"){
                        t1_val = data.bcf2_cf_pv;
                        t2_val = data.bcf2_oil_pv;
                        t3_val = data.bcf2_cp_pv;
                        t4_val = data.bcf2_cf_sv;
                        t5_val = data.bcf2_oil_sv;
                        t6_val = data.bcf2_cp_sv;
                    }else if(hogi === "BCF3"){
                        t1_val = data.bcf3_cf_pv;
                        t2_val = data.bcf3_oil_pv;
                        t3_val = data.bcf3_cp_pv;
                        t4_val = data.bcf3_cf_sv;
                        t5_val = data.bcf3_oil_sv;
                        t6_val = data.bcf3_cp_sv;
                    }else if(hogi === "BCF4"){
                        t1_val = data.bcf4_cf_pv;
                        t2_val = data.bcf4_oil_pv;
                        t3_val = data.bcf4_cp_pv;
                        t4_val = data.bcf4_cf_sv;
                        t5_val = data.bcf4_oil_sv;
                        t6_val = data.bcf4_cp_sv;
                    }else if(hogi === "BCF5"){
                        t1_val = data.bcf5_cf_pv;
                        t2_val = data.bcf5_oil_pv;
                        t3_val = data.bcf5_cp_pv;
                    }else if(hogi === "TF1"){
                        t1_val = data.tf1_zone1;
                        t2_val = data.tf1_zone2;
                        t3_val = data.tf1_zone3;
                    }

                    
                    t1_pv_save.push([tdate_val, t1_val]);
                    t2_pv_save.push([tdate_val, t2_val]);
                    t3_pv_save.push([tdate_val, t3_val]);
                    t1_sv_save.push([tdate_val, t4_val]);
                    t2_sv_save.push([tdate_val, t5_val]);
                    t3_sv_save.push([tdate_val, t6_val]);
                });

                
                seriesArray = [
                    { name: "t1_pv", data: t1_pv_save, color: "red" },
                    { name: "t2_pv", data: t2_pv_save, color: "blue" },
                    { name: "t3_pv", data: t3_pv_save, color: "green" },
                    { name: "t1_sv", data: t1_sv_save, color: "red", dashStyle: "ShortDash" },
                    { name: "t2_sv", data: t2_sv_save, color: "blue", dashStyle: "ShortDash" },
                    { name: "t3_sv", data: t3_sv_save, color: "green", dashStyle: "ShortDash" }
                ];

                getTrendView();
            },
            error: function (xhr, status, error) {
                console.error("❌ 에러:", error);
                alert("데이터 조회 중 오류가 발생했습니다.");
            }
        });
    }

    
    function getTrendView(){
        Highcharts.chart('container', {
            chart: { type: 'line' },
            title: { text: '온도 트렌드' },
            xAxis: {
                type: 'datetime',  
                title: { text: '시간' },
                labels: { rotation: -45 }
            },
            yAxis: {
                title: { text: '값' }
            },
            tooltip: {
                shared: true,
                crosshairs: true,
                xDateFormat: '%Y-%m-%d %H:%M:%S'
            },
            series: seriesArray
        });
    }

    $('.select-button').click(fetchData);

    fetchData();
});
</script>


	</body>
</html>
