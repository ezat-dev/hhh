<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>알람 현황</title>
<link rel="stylesheet" href="/tkheat/css/monitoring/alarm1.css">
<link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp"%>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.main {
    width: 98%;
    margin: 20px auto;
    padding: 20px;
}

/* 설비들을 가로로 나열 */
.equipment-grid {
    display: flex;
    flex-direction: row;
    gap: 15px;
    height: calc(100vh - 100px);
}

/* 각 설비 영역 - 세로로 길게 */
.equipment-section {
    flex: 1;
    border: 2px solid #333;
    border-radius: 8px;
    padding: 15px;
    background: #f9f9f9;
    display: flex;
    flex-direction: column;
    min-width: 150px;
}

/* 설비 헤더 */
.equipment-header {
    font-size: 16px;
    font-weight: bold;
    color: white;
    background: #34495e;
    padding: 15px 10px;
    border-radius: 6px;
    text-align: center;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    margin-bottom: 15px;
    flex-shrink: 0;
}

/* 알람 리스트 영역 - 세로 스크롤 */
.alarm-list {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 8px;
    padding: 10px;
    background: white;
    border-radius: 6px;
    border: 1px solid #ddd;
    overflow-y: auto;
}

/* 알람 아이템 */
.alarm-item {
    padding: 10px 12px;
    background: #ff4444;
    color: white;
    border-radius: 5px;
    font-size: 13px;
    font-weight: bold;
    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    animation: blink 1s infinite;
    display: flex;
    align-items: center;
    gap: 8px;
    flex-shrink: 0;
}

/* 깜빡임 애니메이션 */
@keyframes blink {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.7; }
}

/* 알람 아이콘 */
.alarm-icon {
    width: 14px;
    height: 14px;
    background: white;
    border-radius: 50%;
    display: inline-block;
    flex-shrink: 0;
}

/* 알람 없음 메시지 */
.no-alarm {
    color: #27ae60;
    font-size: 14px;
    font-weight: bold;
    padding: 10px;
    text-align: center;
}

/* WM 영역 (준비중) */
.wm-section .alarm-list {
    justify-content: center;
    align-items: center;
    color: #7f8c8d;
    font-size: 14px;
    font-weight: bold;
}

/* 세로 스크롤바 스타일 */
.alarm-list::-webkit-scrollbar {
    width: 6px;
}

.alarm-list::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 3px;
}

.alarm-list::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 3px;
}

.alarm-list::-webkit-scrollbar-thumb:hover {
    background: #555;
}
</style>
</head>
<body>
<main class="main">
    <div class="equipment-grid">
        <!-- BCF1 -->
        <div class="equipment-section">
            <div class="equipment-header bcf1">BCF1 설비</div>
            <div class="alarm-list" id="bcf1-alarms">
                <div class="no-alarm">알람 없음</div>
            </div>
        </div>
        
        <!-- BCF2 -->
        <div class="equipment-section">
            <div class="equipment-header bcf2">BCF2 설비</div>
            <div class="alarm-list" id="bcf2-alarms">
                <div class="no-alarm">알람 없음</div>
            </div>
        </div>
        
        <!-- BCF3 -->
        <div class="equipment-section">
            <div class="equipment-header bcf3">BCF3 설비</div>
            <div class="alarm-list" id="bcf3-alarms">
                <div class="no-alarm">알람 없음</div>
            </div>
        </div>
        
        <!-- BCF4 -->
        <div class="equipment-section">
            <div class="equipment-header bcf4">BCF4 설비</div>
            <div class="alarm-list" id="bcf4-alarms">
                <div class="no-alarm">알람 없음</div>
            </div>
        </div>
        
        <!-- BCF5 -->
        <div class="equipment-section">
            <div class="equipment-header bcf5">BCF5 설비</div>
            <div class="alarm-list" id="bcf5-alarms">
                <div class="no-alarm">알람 없음</div>
            </div>
        </div>
        
        <!-- TF1 -->
        <div class="equipment-section">
            <div class="equipment-header tf">TF1 설비</div>
            <div class="alarm-list" id="tf1-alarms">
                <div class="no-alarm">알람 없음</div>
            </div>
        </div>
        
        <!-- WM (준비중) -->
        <div class="equipment-section wm-section">
            <div class="equipment-header wm">WM 설비</div>
            <div class="alarm-list">
                준비중
            </div>
        </div>
    </div>
</main>

<script type="text/javascript">
let now_page_code = "d02";

/* 알람 매핑 테이블 */
const alarmMapping = {
    "alarm_101": "로내 SCR이상",
    "alarm_102": "로내롤러 INV.TRIP",
    "alarm_103": "아지테이터 INV.TRIP",
    "alarm_104": "입구테이블 모터-1 TRIP",
    "alarm_105": "입구테이블 모터-2 TRIP",
    "alarm_106": "추출테이블 모터-1 TRIP",
    "alarm_107": "순환펌프 TRIP",
    "alarm_108": "RC-FAN 모터 TRIP",
    "alarm_109": "로내 온도 과승(TIC)",
    "alarm_110": "로내 온도 하한(LNG차단)",
    "alarm_111": "로내 온도 하한(RX차단)",
    "alarm_112": "로내 절대 과승(히터 완전 OFF)",
    "alarm_113": "유조 온도 과승(TIC)",
    "alarm_114": "유조 온도 하한(TIC)",
    "alarm_115": "입구 PILOT 화염 미감지",
    "alarm_116": "입구 커튼버너 화염 미감지",
    "alarm_117": "출구 PILOT 화염 미감지",
    "alarm_118": "배기 PILOT 화염 미감지",
    "alarm_119": "출구 커튼버너 화염 미감지",
    "alarm_120": "로내 분위기 CP 이상",
    "alarm_121": "LPG 압력 이상",
    "alarm_122": "NH3 압력 이상",
    "alarm_123": "냉각수 유량 이상",
    "alarm_124": "유조 액면 LEVEL HI",
    "alarm_125": "유조 액면 LEVEL LOW",
    "alarm_126": "입구문 상승 이상",
    "alarm_127": "입구문 하강 이상",
    "alarm_128": "중간문 상승 이상",
    "alarm_129": "중간문 하강 이상",
    "alarm_130": "출구문 상승 이상",
    "alarm_131": "출구문 하강 이상",
    "alarm_132": "유조 E/V상승 이상",
    "alarm_133": "유조 E/V하강 이상",
    "alarm_134": "입구문 L/S 이상",
    "alarm_135": "중간문 L/S 이상",
    "alarm_136": "유조E/V L/S 이상",
    "alarm_137": "출구문L/S 이상",
    "alarm_138": "입구 제품-1 미감지",
    "alarm_139": "입구 제품-2 미감지",
    "alarm_140": "입구->로내 장입사이클 이상",
    "alarm_141": "로내->유조 추출사이클 이상",
    "alarm_142": "유조->추출 추출사이클 이상",
    "alarm_143": "비상정지[제어반]",
    "alarm_144": "비상정지[입구조작반]",
    "alarm_145": "비상정지[출구조작반]",
    "alarm_146": "RC->FAN회전감지 이상",
    "alarm_147": "아지테이터(좌) 회전감지 이상",
    "alarm_148": "아지테이터(우) 회전감지 이상",
    "alarm_149": "로내 조깅 전진 이상",
    "alarm_150": "추출 테이블 제품감지 이상",
    "alarm_151": "유조 진출 이상",
    "alarm_152": "RX GAS 유량 상한",
    "alarm_153": "RX GAS 유량 하한",
    "alarm_154": "LPG GAS 압력 하한",
    "alarm_155": "LPG GAS 압력 하한",
    "alarm_156": "로 온도 상한",
    "alarm_157": "로 온도 하한",
    "alarm_158": "유조 온도 상한",
    "alarm_159": "유조 온도 하한",
    "alarm_201": "로내 SCR이상",
    "alarm_202": "로내롤러 INV.TRIP",
    "alarm_203": "아지테이터 INV.TRIP",
    "alarm_204": "입구테이블 모터-1 TRIP",
    "alarm_205": "입구테이블 모터-2 TRIP",
    "alarm_206": "추출테이블 모터-1 TRIP",
    "alarm_207": "순환펌프 TRIP",
    "alarm_208": "RC-FAN 모터 TRIP",
    "alarm_209": "로내 온도 과승(TIC)",
    "alarm_210": "로내 온도 하한(LNG차단)",
    "alarm_211": "로내 온도 하한(RX차단)",
    "alarm_212": "로내 절대 과승(히터 완전 OFF)",
    "alarm_213": "유조 온도 과승(TIC)",
    "alarm_214": "유조 온도 하한(TIC)",
    "alarm_215": "입구 PILOT 화염 미감지",
    "alarm_216": "입구 커튼버너 화염 미감지",
    "alarm_217": "출구 PILOT 화염 미감지",
    "alarm_218": "배기 PILOT 화염 미감지",
    "alarm_219": "출구 커튼버너 화염 미감지",
    "alarm_220": "로내 분위기 CP 이상",
    "alarm_221": "LPG 압력 이상",
    "alarm_222": "NH3 압력 이상",
    "alarm_223": "냉각수 압력 이상",
    "alarm_224": "유조 액면 LEVEL HI",
    "alarm_225": "유조 액면 LEVEL LOW",
    "alarm_226": "입구문 상승 이상",
    "alarm_227": "입구문 하강 이상",
    "alarm_228": "중간문 상승 이상",
    "alarm_229": "중간문 하강 이상",
    "alarm_230": "출구문 상승 이상",
    "alarm_231": "출구문 하강 이상",
    "alarm_232": "유조 E/V상승 이상",
    "alarm_233": "유조 E/V하강 이상",
    "alarm_234": "입구문 L/S 이상",
    "alarm_235": "중간문 L/S 이상",
    "alarm_236": "유조E/V L/S 이상",
    "alarm_237": "출구문L/S 이상",
    "alarm_238": "입구 제품-1 미감지",
    "alarm_239": "입구 제품-2 미감지",
    "alarm_240": "입구->로내 장입사이클 이상",
    "alarm_241": "로내->유조 추출사이클 이상",
    "alarm_242": "유조->추출 추출사이클 이상",
    "alarm_243": "비상정지[제어반]",
    "alarm_244": "비상정지[입구조작반]",
    "alarm_245": "비상정지[출구조작반]",
    "alarm_246": "RC->FAN회전감지 이상",
    "alarm_247": "아지테이터(좌) 회전감지 이상",
    "alarm_248": "아지테이터(우) 회전감지 이상",
    "alarm_249": "로내 조깅 전진 이상",
    "alarm_250": "추출 테이블 제품감지 이상",
    "alarm_251": "유조 진출 이상",
    "alarm_252": "RX GAS 유량 상한",
    "alarm_253": "RX GAS 유량 하한",
    "alarm_254": "LPG GAS 압력 하한",
    "alarm_255": "LPG GAS 압력 하한",
    "alarm_256": "로 온도 상한",
    "alarm_257": "로 온도 하한",
    "alarm_258": "유조 온도 상한",
    "alarm_259": "유조 온도 하한",
    "alarm_301": "PLC 이상",
    "alarm_302": "PLC 밧데리 이상",
    "alarm_303": "비상 정지",
    "alarm_304": "CP 이상",
    "alarm_305": "본체 온도 이상",
    "alarm_306": "유조 온도 이상",
    "alarm_307": "N2 GAS 이상",
    "alarm_308": "LPG GAS 이상",
    "alarm_309": "팬 정지",
    "alarm_310": "오일 냉각 펌프 이상",
    "alarm_311": "아지테이터 이상",
    "alarm_312": "모터 트립",
    "alarm_313": "입구 도어 이상",
    "alarm_314": "중간 도어 이상",
    "alarm_315": "냉각수 이상",
    "alarm_316": "장입 포크 이상",
    "alarm_317": "축출 포크 이상",
    "alarm_318": "포크 테이블 이상",
    "alarm_319": "입구 체인 이상",
    "alarm_320": "엘리베이터 이상",
    "alarm_321": "엘리베이터 체인이상",
    "alarm_322": "출구 콘베어 이상",
    "alarm_323": "유조 제품 추출 이상",
    "alarm_324": "입구 프레임 디텍터 이상",
    "alarm_325": "출구 프레임 디텍터 이상",
    "alarm_326": "댐퍼 프레임 디텍터 이상",
    "alarm_327": "유조 레벨 이상",
    "alarm_328": "출구 도어 이상",
    "alarm_329": "RX 유량 상한",
    "alarm_330": "RX 유량 하한",
    "alarm_331": "LPG 압력 상한",
    "alarm_332": "LPG 압력 하한",
    "alarm_401": "PLC 이상",
    "alarm_402": "PLC 밧데리 이상",
    "alarm_403": "비상 정지",
    "alarm_404": "CP 이상",
    "alarm_405": "본체 온도 이상",
    "alarm_406": "유조 온도 이상",
    "alarm_407": "N2 GAS 이상",
    "alarm_408": "LPG GAS 이상",
    "alarm_409": "팬 정지",
    "alarm_410": "오일 냉각 펌프 이상",
    "alarm_411": "아지테이터 이상",
    "alarm_412": "모터 트립",
    "alarm_413": "입구 도어 이상",
    "alarm_414": "중간 도어 이상",
    "alarm_415": "냉각수 이상",
    "alarm_416": "장입 포크 이상",
    "alarm_417": "축출 포크 이상",
    "alarm_418": "포크 테이블 이상",
    "alarm_419": "입구 체인 이상",
    "alarm_420": "엘리베이터 이상",
    "alarm_421": "엘리베이터 체인이상",
    "alarm_422": "출구 콘베어 이상",
    "alarm_423": "유조 제품 추출 이상",
    "alarm_424": "입구 프레임 디텍터 이상",
    "alarm_425": "출구 프레임 디텍터 이상",
    "alarm_426": "댐퍼 프레임 디텍터 이상",
    "alarm_427": "유조 레벨 이상",
    "alarm_428": "출구 도어 이상",
    "alarm_429": "RX 유량 상한",
    "alarm_430": "RX 유량 하한",
    "alarm_431": "LPG 압력 상한",
    "alarm_432": "LPG 압력 하한",
    "alarm_501": "가열실 SCR PAULT",
    "alarm_502": "가열실 RC-FAN FAULT",
    "alarm_503": "쿨링펌프 FAULT",
    "alarm_504": "교반기 인버터 FAULT",
    "alarm_505": "교반기 L모터 FAULT",
    "alarm_506": "교반기 R모터 FAULT",
    "alarm_507": "핸들러 FAULT",
    "alarm_508": "판넬 지락검출 이상",
    "alarm_509": "로내온도 540 이하 이상",
    "alarm_510": "가열실 온도 하한이상",
    "alarm_511": "가열실 온도 상한이상",
    "alarm_512": "가열실 과승온도 상한이상",
    "alarm_513": "CP 상한 이상",
    "alarm_514": "CP 하한 이상",
    "alarm_515": "소입조 온도 상한 이상",
    "alarm_516": "냉각수 압력 이상",
    "alarm_517": "고압공기 압력 이상",
    "alarm_518": "커텐버터 압력 이상",
    "alarm_519": "RX-GAS 압력 이상",
    "alarm_520": "R/C FAN 회전 이상",
    "alarm_521": "가열실 트랜스 온도 이상",
    "alarm_522": "핸들러 위치 이상",
    "alarm_523": "핸들러 전진 이상",
    "alarm_524": "핸들러 후진 이상",
    "alarm_525": "입구문 위치 이상",
    "alarm_526": "E/V 위치 이상",
    "alarm_527": "E/V 상승 이상",
    "alarm_528": "E/V 하강 이상",
    "alarm_529": "중간도어 위치 이상",
    "alarm_530": "중간도어 열림 이상",
    "alarm_531": "중간도어 닫힘 이상",
    "alarm_532": "소입조 레벨 상한 이상",
    "alarm_533": "소입조 레벨 하한 이상",
    "alarm_534": "커텐버너 화염검출 이상",
    "alarm_535": "링버너 화염검출 이상",
    "alarm_536": "처리제 가열실 추출 이상",
    "alarm_537": "처리제 가열실 장입 이상",
    "alarm_538": "소입조 히터 '좌' TRIP 이상",
    "alarm_539": "소입조 히터 '우' TRIP 이상",
    "alarm_540": "로내 CP도달 지연 이상",
    "alarm_541": "LPG GAS 압력 이상",
    "alarm_542": "NH3 GAS 압력 이상",
    "alarm_601": "PLC 이상",
    "alarm_602": "PLC 배터리 이상",
    "alarm_603": "종합 이상",
    "alarm_604": "입구문 SENSOR 이상",
    "alarm_605": "입구문 상승 이상",
    "alarm_606": "입구문 하강 이상",
    "alarm_607": "출구문 SENSOR 이상",
    "alarm_608": "출구문 상승 이상",
    "alarm_609": "출구문 하강 이상",
    "alarm_610": "1 ZONE 과열",
    "alarm_611": "2 ZONE 과열",
    "alarm_612": "3 ZONE 과열",
    "alarm_613": "MOTOR 이상",
    "alarm_614": "인버터 이상",
    "alarm_615": "FAN 이상",
    "alarm_616": "비상 정지"
};

const equipmentRanges = {
    "BCF1": { start: 101, end: 159, containerId: "bcf1-alarms" },
    "BCF2": { start: 201, end: 259, containerId: "bcf2-alarms" },
    "BCF3": { start: 301, end: 332, containerId: "bcf3-alarms" },
    "BCF4": { start: 401, end: 432, containerId: "bcf4-alarms" },
    "BCF5": { start: 501, end: 542, containerId: "bcf5-alarms" },
    "TF1": { start: 601, end: 616, containerId: "tf1-alarms" }
};

function loadAlarms() {
    $.ajax({
        type: "POST",
        url: "/tkheat/monitoring/alarm/currentAlarms",
        dataType: "json",
        success: function(result) {
            console.log("알람 데이터:", result);
            
            if (!result) {
                console.warn("알람 데이터 없음");
                return;
            }
            
            for (const equipment in equipmentRanges) {
                displayAlarmsForEquipment(result, equipment, equipmentRanges[equipment]);
            }
        },
        error: function(xhr, status, error) {
            console.error("알람 조회 실패:", error);
        }
    });
}

function displayAlarmsForEquipment(alarmData, equipment, range) {
    const container = document.getElementById(range.containerId);
    const activeAlarms = [];
    
    console.log(equipment + " 알람 체크 시작");
    console.log("받은 데이터:", alarmData);
    
    for (let i = range.start; i <= range.end; i++) {
        const alarmKey = "alarm_" + i;
        const alarmValue = alarmData[alarmKey];
        
        console.log("  - " + alarmKey + ": " + alarmValue + " (타입: " + typeof alarmValue + ")");
        
        if (alarmValue === true || alarmValue === 1 || alarmValue === "1" || alarmValue === "true") {
            const alarmName = alarmMapping[alarmKey];
            
            if (alarmName) {
                activeAlarms.push({
                    code: alarmKey,
                    name: alarmName
                });
                console.log("    알람 발생! " + alarmKey + ' = "' + alarmName + '"');
            } else {
                console.warn("    " + alarmKey + "에 대한 알람명 없음");
            }
        }
    }
    
    console.log(equipment + " 총 활성 알람: " + activeAlarms.length + "개");
    console.log("---");
    
    if (activeAlarms.length === 0) {
        container.innerHTML = '<div class="no-alarm">알람 없음</div>';
    } else {
        let html = '';
        for (let j = 0; j < activeAlarms.length; j++) {
            const alarm = activeAlarms[j];
            html += '<div class="alarm-item">';
            html += '<span class="alarm-icon"></span>';
            html += '<span>' + alarm.name + '</span>';
            html += '</div>';
        }
        container.innerHTML = html;
    }
}

let alarmTimer = null;

function startAlarmMonitoring() {
    loadAlarms();
    
    alarmTimer = setInterval(function() {
        loadAlarms();
    }, 5000);
}

$(document).ready(function() {
    startAlarmMonitoring();
});

$(window).on('beforeunload', function() {
    if (alarmTimer) {
        clearInterval(alarmTimer);
    }
});
</script>
</body>
</html>