<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>통합모니터링</title>
<link rel="stylesheet" href="/tkheat/css/monitoring/alarm2.css">
<link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp"%>
<style>
.main {
	width: 98%;
}

.container {
	display: flex;
	justify-content: space-between;
}

div {
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	font-size: 12px;
	padding: 2px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	box-sizing: border-box;
	border: 1px solid #ccc; /* 경계 확인용 */
	height: 28px; /* 고정 높이로 정렬 유지 */
}
</style>

<body>
	
	
	  <div class="alarm_big-box-5"></div>
		<div class="alarm_167">종합 이상</div>
		<div class="alarm_168">세척실 입구문 이상</div>
		<div class="alarm_169">세척실 출구문 이상</div>
		<div class="alarm_170">건조실 입구문 이상</div>
		<div class="alarm_171">건조실 출구문 이상</div>
		<div class="alarm_172">열매채유 온도 과열</div>
		<div class="alarm_173">질소 고압</div>
		<div class="alarm_174">세척실 비상 레벨</div>
		<div class="alarm_175">세척액 T 비상 레벨</div>
		<div class="alarm_176">오액 T 비상 레벨</div>
		<div class="alarm_177">재생액 T 비상 레벨</div>
		<div class="alarm_178">비상 정지</div>
		<div class="alarm_179">진공펌프 #1 이상</div>
		<div class="alarm_180">진공펌프 #2 이상</div>
		<div class="alarm_181">열매채유 펌프 이상</div>
		<div class="alarm_182">세척액 펌프 이상</div>
		<div class="alarm_183">투입 #1 CONV. 이상</div>
		<div class="alarm_184">투입 #2 CONV. 이상</div>
		<div class="alarm_185">투입 UNIT 이상</div>
		<div class="alarm_186">취출 CONV. 이상</div>
		<div class="alarm_187">취출 UNIT 이상</div>
		<div class="alarm_188">투입 OP EPB ON</div>
		<div class="alarm_189">취출 OP EPB ON</div>
		<div class="alarm_190">세척실 입구문 상승</div>
		<div class="alarm_191">세척실 입구문 하강</div>
		<div class="alarm_192">세척실 출구문 상승</div>
		<div class="alarm_193">세척실 출구문 하강</div>
		<div class="alarm_194">건조실 입구문 상승</div>
		<div class="alarm_195">건조실 입구문 하강</div>
		<div class="alarm_196">건조실 출구문 상승</div>
		<div class="alarm_197">건조실 출구문 하강</div>
		<div class="alarm_198">폐액 드럼 상한 레벨</div>
		<div class="alarm_199">신액 탱크 하한 레벨</div>
		<div class="alarm_200">재생액 DRAIN 이상</div>
		<div class="alarm_201">FILTER 상한 이상</div>
		<div class="alarm_202">공정 이상</div>
		<div class="alarm_203">투입 리트리버 이상</div>
		<div class="alarm_204">취출 리트리버 이상</div>
		<div class="alarm_big-box-6"></div>
		<div class="alarm_205">종합이상</div>
		<div class="alarm_206">입구문 SENSOR 이상</div>
		<div class="alarm_207">입구문 상승 이상</div>
		<div class="alarm_208">입구문 하강 이상</div>
		<div class="alarm_209">출구문 SENSOR 이상</div>
		<div class="alarm_210">출구문 상승 이상</div>
		<div class="alarm_211">출구문 하강 이상</div>
		<div class="alarm_212">PLC 이상</div>
		<div class="alarm_213">PLC 밧데리 이상</div>
		<div class="alarm_214">1 ZONE 과열</div>
		<div class="alarm_215">2 ZONE 과열</div>
		<div class="alarm_216">3 ZONE 과열</div>
		<div class="alarm_217">MOTOR 이상</div>
		<div class="alarm_218">인버터 이상</div>
		<div class="alarm_219">FAN 이상</div>
		<div class="alarm_220">비상정지</div>
		<div class="wm" style="font-size : 16px;">WM</div>
		<div class="tf" style="font-size : 16px;">TF</div>
	
	  



	<script>
    // 1초로인터벌줌
    $(document).ready(function() {
        setInterval(alarmList2, 1000);
    });

    // OPC조회함수
    function alarmList2() {
        $.ajax({
            url: "/tkheat/monitoring/alarm/alarmList2",
            type: "post",
            dataType: "json",
            success: function(result) {
                var data = result.multiValues;
                for (let key in data) {
                    for (let keys in data[key]) {
                        var d = data[key];
                        if (d[keys].action === "c") {
                            updateAlarm(keys, d[keys].value);
                        }
                    }
                }
            }
        });
    }

    // 알람색지정 테스트
    function updateAlarm(keys, value) {
        var s = "." + keys;
        if (value === true) {
            $(s).css({"background-color": "red", "color": "white"});
        } else {
            $(s).css({"background-color": "#f1f1f1", "color": "black"});
        }
    }
</script>

	

	

	

   

</body>
</html>
