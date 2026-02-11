<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>알람-1</title>
<link rel="stylesheet" href="/tkheat/css/monitoring/alarm1.css">
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
.alarm-on {
    background-color: red; /* 알람 발생 시 빨간색 */
    color: white;
    font-weight: bold;
    transition: background-color 0.3s;
}
</style>

<body>


	<main class="main">
		<div class="alarm_big_box_1"></div>
		<div class="alarm_1">로내 SCR이상</div>
		<div class="alarm_2">로내롤러 INV.TRIP</div>
		<div class="alarm_3">아지테이터 INV.TRIP</div>
		<div class="alarm_4">입구테이블 모터-1 TRIP</div>
		<div class="alarm_5">입구테이블 모터-2 TRIP</div>
		<div class="alarm_6">추출테이블 모터-1 TRIP</div>
		<div class="alarm_7">순환펌프 TRIP</div>
		<div class="alarm_8">RC-FAN 모터 TRIP</div>
		<div class="alarm_9">로내 온도 과승(TIC)</div>
		<div class="alarm_10">로내 온도 하한(LNG차단)</div>
		<div class="alarm_11">로내 온도 하한(RX차단)</div>
		<div class="alarm_12">로내 절대 과승(히터 완전 OFF)</div>
		<div class="alarm_13">유조 온도 과승(TIC)</div>
		<div class="alarm_14">유조 온도 하한(TIC)</div>
		<div class="alarm_15">입구 PILOT 화염 미감지</div>
		<div class="alarm_16">입구 커튼버너 화염 미감지</div>
		<div class="alarm_17">출구 PILOT 화염 미감지</div>
		<div class="alarm_18">배기 PILOT 화염 미감지</div>
		<div class="alarm_19">출구 커튼버너 화염 미감지</div>
		<div class="alarm_20">로내 분위기 CP 이상</div>
		<div class="alarm_21">LPG 압력 이상</div>
		<div class="alarm_22">NH3 압력 이상</div>
		<div class="alarm_23">냉각수 압력 이상</div>
		<div class="alarm_24">유조 액면 LEVEL HI</div>
		<div class="alarm_25">유조 액면 LEVEL LOW</div>
		<div class="alarm_26">입구문 상승 이상</div>
		<div class="alarm_27">입구문 하강 이상</div>
		<div class="alarm_28">중간문 상승 이상</div>
		<div class="alarm_29">중간문 하강 이상</div>
		<div class="alarm_30">출구문 상승 이상</div>
		<div class="alarm_31">출구문 하강 이상</div>
		<div class="alarm_32">유조 E/V상승 이상</div>
		<div class="alarm_33">유조 E/V하강 이상</div>
		<div class="alarm_34">입구문 L/S 이상</div>
		<div class="alarm_35">중간문 L/S 이상</div>
		<div class="alarm_36">유조E/V L/S 이상</div>
		<div class="alarm_37">출구문L/S 이상</div>
		<div class="alarm_38">입구 제품-1 미감지</div>
		<div class="alarm_39">입구 제품-2 미감지</div>
		<div class="alarm_40">입구->로내 장입사이클 이상</div>
		<div class="alarm_41">로내->유조 추출사이클 이상</div>
		<div class="alarm_42">유조->추출 추출사이클 이상</div>
		<div class="alarm_43">비상정지[제어반]</div>
		<div class="alarm_44">비상정지[입구조작반]</div>
		<div class="alarm_45">비상정지[출구조작반]</div>
		<div class="alarm_46">RC->FAN회전감지 이상</div>
		<div class="alarm_47">아지테이터(좌) 회전감지 이상</div>
		<div class="alarm_48">아지테이터(우) 회전감지 이상</div>
		<div class="alarm_49">로내 조깅 전진 이상</div>
		<div class="alarm_50">추출 테이블 제품감지 이상</div>
		<div class="alarm_51">유조 진출 이상</div>
		<div class="alarm_52">RX GAS 유량 이상</div>
		<div class="alarm_53">LPG GAS 입력 이상</div>
		<div class="alarm_big_box_12"></div>
		<div class="alarm_54">로내 SCR이상</div>
		<div class="alarm_55">로내롤러 INV.TRIP</div>
		<div class="alarm_56">아지테이터 INV.TRIP</div>
		<div class="alarm_57">입구테이블 모터-1 TRIP</div>
		<div class="alarm_58">입구테이블 모터-2 TRIP</div>
		<div class="alarm_59">추출테이블 모터-1 TRIP</div>
		<div class="alarm_60">순환펌프 TRIP</div>
		<div class="alarm_61">RC-FAN 모터 TRIP</div>
		<div class="alarm_62">로내 온도 과승(TIC)</div>
		<div class="alarm_63">로내 온도 하한(LNG차단)</div>
		<div class="alarm_64">로내 온도 하한(RX차단)</div>
		<div class="alarm_65">로내 절대 과승(히터 완전 OFF)</div>
		<div class="alarm_66">유조 온도 과승(TIC)</div>
		<div class="alarm_67">유조 온도 하한(TIC)</div>
		<div class="alarm_68">입구 PILOT 화염 미감지</div>
		<div class="alarm_69">입구 커튼버너 화염 미감지</div>
		<div class="alarm_70">출구 PILOT 화염 미감지</div>
		<div class="alarm_71">배기 PILOT 화염 미감지</div>
		<div class="alarm_72">출구 커튼버너 화염 미감지</div>
		<div class="alarm_73">로내 분위기 CP 이상</div>
		<div class="alarm_74">LPG 압력 이상</div>
		<div class="alarm_75">NH3 압력 이상</div>
		<div class="alarm_76">냉각수 압력 이상</div>
		<div class="alarm_77">유조 액면 LEVEL HI</div>
		<div class="alarm_78">유조 액면 LEVEL LOW</div>
		<div class="alarm_79">입구문 상승 이상</div>
		<div class="alarm_80">입구문 하강 이상</div>
		<div class="alarm_81">중간문 상승 이상</div>
		<div class="alarm_82">중간문 하강 이상</div>
		<div class="alarm_83">출구문 상승 이상</div>
		<div class="alarm_84">출구문 하강 이상</div>
		<div class="alarm_85">유조 E/V상승 이상</div>
		<div class="alarm_86">유조 E/V하강 이상</div>
		<div class="alarm_87">입구문 L/S 이상</div>
		<div class="alarm_88">중간문 L/S 이상</div>
		<div class="alarm_89">유조E/V L/S 이상</div>
		<div class="alarm_90">출구문L/S 이상</div>
		<div class="alarm_91">입구 제품-1 미감지</div>
		<div class="alarm_92">입구 제품-2 미감지</div>
		<div class="alarm_93">입구->로내 장입사이클 이상</div>
		<div class="alarm_94">로내->유조 추출사이클 이상</div>
		<div class="alarm_95">유조->추출 추출사이클 이상</div>
		<div class="alarm_96">비상정지[제어반]</div>
		<div class="alarm_97">비상정지[입구조작반]</div>
		<div class="alarm_98">비상정지[출구조작반]</div>
		<div class="alarm_99">RC->FAN회전감지 이상</div>
		<div class="alarm_100">아지테이터(좌) 회전감지 이상</div>
		<div class="alarm_101">아지테이터(우) 회전감지 이상</div>
		<div class="alarm_102">로내 조깅 전진 이상</div>
		<div class="alarm_103">추출 테이블 제품감지 이상</div>
		<div class="alarm_104">유조 진출 이상</div>
		<div class="alarm_105">RX GAS 유량 이상</div>
		<div class="alarm_106">LPG GAS 입력 이상</div>
		<div class="alarm_big_box_3"></div>
		<div class="alarm_107">PLC 이상</div>
		<div class="alarm_108">PLC 밧데리 이상</div>
		<div class="alarm_109">비상 정지</div>
		<div class="alarm_110">CP 이상</div>
		<div class="alarm_111">본체 온도 이상</div>
		<div class="alarm_112">유조 온도 이상</div>
		<div class="alarm_113">N2 GAS 이상</div>
		<div class="alarm_114">LPG GAS 이상</div>
		<div class="alarm_115">팬 정지</div>
		<div class="alarm_116">오일 냉각 펌프 이상</div>
		<div class="alarm_117">아지테이터 이상</div>
		<div class="alarm_118">모터 트립</div>
		<div class="alarm_119">입구 도어 이상</div>
		<div class="alarm_120">중간 도어 이상</div>
		<div class="alarm_121">RX GAS 유량 이상</div>
		<div class="alarm_122">냉각수 이상</div>
		<div class="alarm_123">장입 포크 이상</div>
		<div class="alarm_124">축출 포크 이상</div>
		<div class="alarm_125">포크 테이블 이상</div>
		<div class="alarm_126">입구 체인 이상</div>
		<div class="alarm_127">엘리베이터 이상</div>
		<div class="alarm_128">엘리베이터 체인이상</div>
		<div class="alarm_129">출구 콘베어 이상</div>
		<div class="alarm_130">유조 제품 추출 이상</div>
		<div class="alarm_131">입구 프레임 디텍터 이상</div>
		<div class="alarm_132">출구 프레임 디텍터 이상</div>
		<div class="alarm_133">댐퍼 프레임 디텍터 이상</div>
		<div class="alarm_134">유조 레벨 이상</div>
		<div class="alarm_135">출구 도어 이상</div>
		<div class="alarm_136">LPG GAS 압력 이상</div>
		<div class="alarm_big_box_4"></div>
		<div class="alarm_137">PLC 이상</div>
		<div class="alarm_138">PLC 밧데리 이상</div>
		<div class="alarm_139">비상 정지</div>
		<div class="alarm_140">CP 이상</div>
		<div class="alarm_141">본체 온도 이상</div>
		<div class="alarm_142">유조 온도 이상</div>
		<div class="alarm_143">N2 GAS 이상</div>
		<div class="alarm_144">LPG GAS 이상</div>
		<div class="alarm_145">팬 정지</div>
		<div class="alarm_146">오일 냉각 펌프 이상</div>
		<div class="alarm_147">아지테이터 이상</div>
		<div class="alarm_148">모터 트립</div>
		<div class="alarm_149">입구 도어 이상</div>
		<div class="alarm_150">중간 도어 이상</div>
		<div class="alarm_151">RX GAS 유량 이상</div>
		<div class="alarm_152">냉각수 이상</div>
		<div class="alarm_153">장입 포크 이상</div>
		<div class="alarm_154">축출 포크 이상</div>
		<div class="alarm_155">포크 테이블 이상</div>
		<div class="alarm_156">입구 체인 이상</div>
		<div class="alarm_157">엘리베이터 이상</div>
		<div class="alarm_158">엘리베이터 체인이상</div>
		<div class="alarm_159">출구 콘베어 이상</div>
		<div class="alarm_160">유조 제품 추출 이상</div>
		<div class="alarm_161">입구 프레임 디텍터 이상</div>
		<div class="alarm_162">출구 프레임 디텍터 이상</div>
		<div class="alarm_163">댐퍼 프레임 디텍터 이상</div>
		<div class="alarm_164">유조 레벨 이상</div>
		<div class="alarm_165">출구 도어 이상</div>
		<div class="alarm_166">LPG GAS 압력 이상</div>
		<div class="bcf-1" style="font-size : 16px;">NO.1 BCF</div>
		<div class="bcf-2" style="font-size : 16px;">NO.2 BCF</div>
		<div class="bcf-3" style="font-size : 16px;">NO.3 BCF</div>
		<div class="bcf-4" style="font-size : 16px;">NO.4 BCF</div>
	</main>


	<script>

	let now_page_code = "d02";

	$(document).ready(function () {
	var alarmMap = {
		    "BCF1.ALARM.M4000": "alarm_1",
		    "BCF1.ALARM.M4001": "alarm_2",
		    "BCF1.ALARM.M4002": "alarm_3",
		    "BCF1.ALARM.M4003": "alarm_4",
		    "BCF1.ALARM.M4004": "alarm_5",
		    "BCF1.ALARM.M4005": "alarm_6",
		    "BCF1.ALARM.M4006": "alarm_7",
		    "BCF1.ALARM.M4007": "alarm_8",
		    "BCF1.ALARM.M4008": "alarm_9",
		    "BCF1.ALARM.M4009": "alarm_10",
		    "BCF1.ALARM.M4010": "alarm_11",
		    "BCF1.ALARM.M4011": "alarm_12",
		    "BCF1.ALARM.M4012": "alarm_13",
		    "BCF1.ALARM.M4013": "alarm_14",
		    "BCF1.ALARM.M4014": "alarm_15",
		    "BCF1.ALARM.M4015": "alarm_16",
		    "BCF1.ALARM.M4016": "alarm_17",
		    "BCF1.ALARM.M4017": "alarm_18",
		    "BCF1.ALARM.M4018": "alarm_19",
		    "BCF1.ALARM.M4019": "alarm_20",
		    "BCF1.ALARM.M4020": "alarm_21",
		    "BCF1.ALARM.M4021": "alarm_22",
		    "BCF1.ALARM.M4022": "alarm_23",
		    "BCF1.ALARM.M4023": "alarm_24",
		    "BCF1.ALARM.M4024": "alarm_25",
		    "BCF1.ALARM.M4025": "alarm_26",
		    "BCF1.ALARM.M4026": "alarm_27",
		    "BCF1.ALARM.M4027": "alarm_28",
		    "BCF1.ALARM.M4028": "alarm_29",
		    "BCF1.ALARM.M4029": "alarm_30",
		    "BCF1.ALARM.M4030": "alarm_31",
		    "BCF1.ALARM.M4031": "alarm_32",
		    "BCF1.ALARM.M4032": "alarm_33",
		    "BCF1.ALARM.M4033": "alarm_34",
		    "BCF1.ALARM.M4034": "alarm_35",
		    "BCF1.ALARM.M4035": "alarm_36",
		    "BCF1.ALARM.M4036": "alarm_37",
		    "BCF1.ALARM.M4037": "alarm_38",
		    "BCF1.ALARM.M4038": "alarm_39",
		    "BCF1.ALARM.M4039": "alarm_40",
		    "BCF1.ALARM.M4040": "alarm_41",
		    "BCF1.ALARM.M4041": "alarm_42",
		    "BCF1.ALARM.M4042": "alarm_43",
		    "BCF1.ALARM.M4043": "alarm_44",
		    "BCF1.ALARM.M4044": "alarm_45",
		    "BCF1.ALARM.M4045": "alarm_46",
		    "BCF1.ALARM.M4046": "alarm_47",
		    "BCF1.ALARM.M4047": "alarm_48",
		    "BCF1.ALARM.M4048": "alarm_49",
		    "BCF1.ALARM.M4049": "alarm_50",
		    "BCF1.ALARM.M4050": "alarm_51",
		    "BCF1.ALARM.M4052": "alarm_52",
		    "BCF1.ALARM.M4054": "alarm_53",

		    "BCF2.ALARM.M4000": "alarm_54",
		    "BCF2.ALARM.M4001": "alarm_55",
		    "BCF2.ALARM.M4002": "alarm_56",
		    "BCF2.ALARM.M4003": "alarm_57",
		    "BCF2.ALARM.M4004": "alarm_58",
		    "BCF2.ALARM.M4005": "alarm_59",
		    "BCF2.ALARM.M4006": "alarm_60",
		    "BCF2.ALARM.M4007": "alarm_61",
		    "BCF2.ALARM.M4008": "alarm_62",
		    "BCF2.ALARM.M4009": "alarm_63",
		    "BCF2.ALARM.M4010": "alarm_64",
		    "BCF2.ALARM.M4011": "alarm_65",
		    "BCF2.ALARM.M4012": "alarm_66",
		    "BCF2.ALARM.M4013": "alarm_67",
		    "BCF2.ALARM.M4014": "alarm_68",
		    "BCF2.ALARM.M4015": "alarm_69",
		    "BCF2.ALARM.M4016": "alarm_70",
		    "BCF2.ALARM.M4017": "alarm_71",
		    "BCF2.ALARM.M4018": "alarm_72",
		    "BCF2.ALARM.M4019": "alarm_73",
		    "BCF2.ALARM.M4020": "alarm_74",
		    "BCF2.ALARM.M4021": "alarm_75",
		    "BCF2.ALARM.M4022": "alarm_76",
		    "BCF2.ALARM.M4023": "alarm_77",
		    "BCF2.ALARM.M4024": "alarm_78",
		    "BCF2.ALARM.M4025": "alarm_79",
		    "BCF2.ALARM.M4026": "alarm_80",
		    "BCF2.ALARM.M4027": "alarm_81",
		    "BCF2.ALARM.M4028": "alarm_82",
		    "BCF2.ALARM.M4029": "alarm_83",
		    "BCF2.ALARM.M4030": "alarm_84",
		    "BCF2.ALARM.M4031": "alarm_85",
		    "BCF2.ALARM.M4032": "alarm_86",
		    "BCF2.ALARM.M4033": "alarm_87",
		    "BCF2.ALARM.M4034": "alarm_88",
		    "BCF2.ALARM.M4035": "alarm_89",
		    "BCF2.ALARM.M4036": "alarm_90",
		    "BCF2.ALARM.M4037": "alarm_91",
		    "BCF2.ALARM.M4038": "alarm_92",
		    "BCF2.ALARM.M4039": "alarm_93",
		    "BCF2.ALARM.M4040": "alarm_94",
		    "BCF2.ALARM.M4041": "alarm_95",
		    "BCF2.ALARM.M4042": "alarm_96",
		    "BCF2.ALARM.M4043": "alarm_97",
		    "BCF2.ALARM.M4044": "alarm_98",
		    "BCF2.ALARM.M4045": "alarm_99",
		    "BCF2.ALARM.M4046": "alarm_100",
		    "BCF2.ALARM.M4047": "alarm_101",
		    "BCF2.ALARM.M4048": "alarm_102",
		    "BCF2.ALARM.M4049": "alarm_103",
		    "BCF2.ALARM.M4050": "alarm_104",
		    "BCF2.ALARM.M4052": "alarm_105",
		    "BCF2.ALARM.M4054": "alarm_106",

		    "BCF3.ALARM.L1447": "alarm_107",
		    "BCF3.ALARM.L1442": "alarm_108",
		    "BCF3.ALARM.L1430": "alarm_109",
		    "BCF3.ALARM.L1448": "alarm_110",
		    "BCF3.ALARM.X5A":   "alarm_111",
		    "BCF3.ALARM.X5B":   "alarm_112",
		    "BCF3.ALARM.X9B":   "alarm_113",
		    "BCF3.ALARM.XA0":   "alarm_114",
		    "BCF3.ALARM.L1443": "alarm_115",
		    "BCF3.ALARM.L1437": "alarm_116",
		    "BCF3.ALARM.L1435": "alarm_117",
		    "BCF3.ALARM.L1446": "alarm_118",
		    "BCF3.ALARM.L1423": "alarm_119",

		    "BCF3.ALARM.M636": "alarm_121",
		    "BCF3.ALARM.M80":  "alarm_122",
		    "BCF3.ALARM.L1420":"alarm_123",
		    "BCF3.ALARM.L1421":"alarm_124",
		    "BCF3.ALARM.L1422":"alarm_125",
		    "BCF3.ALARM.L1429":"alarm_126",
		    "BCF3.ALARM.L1426":"alarm_127",
		    "BCF3.ALARM.L1425":"alarm_128",
		    "BCF3.ALARM.L1428":"alarm_129",
		    "BCF3.ALARM.M35":  "alarm_130",
		    "BCF3.ALARM.L1441":"alarm_131",
		    "BCF3.ALARM.L1444":"alarm_132",
		    "BCF3.ALARM.L1445":"alarm_133",
		    "BCF3.ALARM.L1449":"alarm_134",

		    "BCF3.ALARM.M638": "alarm_136",

		    "BCF4.ALARM.L1447": "alarm_137",
		    "BCF4.ALARM.L1442": "alarm_138",
		    "BCF4.ALARM.L1430": "alarm_139",
		    "BCF4.ALARM.L1448": "alarm_140",
		    "BCF4.ALARM.X5A":   "alarm_141",
		    "BCF4.ALARM.X5B":   "alarm_142",
		    "BCF4.ALARM.X9B":   "alarm_143",
		    "BCF4.ALARM.XA0":   "alarm_144",
		    "BCF4.ALARM.L1443": "alarm_145",
		    "BCF4.ALARM.L1437": "alarm_146",
		    "BCF4.ALARM.L1435": "alarm_147",
		    "BCF4.ALARM.L1446": "alarm_148",
		    "BCF4.ALARM.L1423": "alarm_149",

		    "BCF4.ALARM.M636": "alarm_151",
		    "BCF4.ALARM.M80":  "alarm_152",
		    "BCF4.ALARM.L1420":"alarm_153",
		    "BCF4.ALARM.L1421":"alarm_154",
		    "BCF4.ALARM.L1422":"alarm_155",
		    "BCF4.ALARM.L1429":"alarm_156",
		    "BCF4.ALARM.L1426":"alarm_157",
		    "BCF4.ALARM.L1425":"alarm_158",
		    "BCF4.ALARM.L1428":"alarm_159",
		    "BCF4.ALARM.M35":  "alarm_160",
		    "BCF4.ALARM.L1441":"alarm_161",
		    "BCF4.ALARM.L1444":"alarm_162",
		    "BCF4.ALARM.L1445":"alarm_163",
		    "BCF4.ALARM.L1449":"alarm_164",

		    "BCF4.ALARM.M638": "alarm_166"
		};

	var alarmTimer = null;

	function alarmOn() {
        $.ajax({
            url: "/tkheat/monitoring/currentAlarmList",
            type: "POST",
            dataType: "json",
            success: function(res) {
                var alarms = res.data;
                
                if (!alarms || alarms.length === 0) {
                    console.warn("⚠️ 알람 데이터 없음");
                    return;
                }

                console.log("📊 전체 알람 데이터:", alarms.length + "개");

                // ✅ Step 1: regtime 기준으로 내림차순 정렬 (최신이 먼저)
                alarms.sort(function(a, b) {
                    return new Date(b.regtime) - new Date(a.regtime);
                });

                // ✅ Step 2: a_addr별로 최신 데이터만 선택
                var latestAlarms = {};
                alarms.forEach(function(row) {
                    if (!latestAlarms[row.a_addr]) {
                        latestAlarms[row.a_addr] = row;
                    }
                });

                console.log("✅ 최신 알람 개수:", Object.keys(latestAlarms).length + "개");

                // ✅ Step 3: 모든 알람 초기화
                $(".main > div[class^='alarm_']").removeClass("alarm-on");

                // ✅ Step 4: 값이 1인 알람만 켜기
                var activeCount = 0;
                Object.values(latestAlarms).forEach(function(row) {
                    var cls = alarmMap[row.a_addr];
                    var value = Number(row.a_value);
                    
                    if (cls) {
                        if (value === 1) {
                            $("." + cls).addClass("alarm-on");
                            activeCount++;
                            console.log(`🔴 ON: ${row.a_addr} (${cls})`);
                        } else {
                            console.log(`⚪ OFF: ${row.a_addr} (${cls})`);
                        }
                    }
                });

                console.log(`🔔 활성 알람: ${activeCount}개`);
            },
            error: function(xhr, status, error) {
                console.error("❌ 알람 조회 실패:", error);
            },
            complete: function() {
                clearTimeout(alarmTimer);
                alarmTimer = setTimeout(alarmOn, 5000);
            }
        });
    }

    // 최초 호출
    alarmOn();
});
</script>
</body>
</html>
