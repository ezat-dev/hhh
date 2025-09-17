<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>통합모니터링</title>
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
	$(document).ready(function() {
	    setInterval(alarmList1, 1000);
	});

	function alarmList1() {
	    $.ajax({
	        url: "/tkheat/monitoring/alarm/alarmList1",
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
