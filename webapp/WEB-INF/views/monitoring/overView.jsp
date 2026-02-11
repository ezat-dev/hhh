<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>설비모니터링</title>
<link rel="stylesheet" href="/tkheat/css/monitoring/overView.css">
<link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp"%>
<style>
.tkMain{
    	width: 1351px;
  height: 360px;
  position: absolute;
  left: 160px;
  top: 160px;
  object-fit: cover;
  aspect-ratio: 1724/460;
    	
    	}
    	main{
    	overflow: hidden;
    	}
    	


.bcf_table_wrap {
    position: absolute;
    left: 42px;
    top: 660px;
}

.bcf_table {
    border-collapse: collapse;
    width: 1600px;
}

.bcf_table th {
    background: #f3f6fb;
    border: 1px solid #d0d3d8;
    text-align: center;
    font-size: 13px;
    font-weight: bold;
    color: #0b63ce;
    height: 25px;
}

.bcf_table td {
    border: 1px solid #d0d3d8;
    text-align: center;
    font-size: 15px;
    font-weight: bold;
    color: #333;
    height: 28px;
}

/* 회전 애니메이션 */
.rotating {
    animation: rotateAnim 2s linear infinite;
}

@keyframes rotateAnim {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

/* 점멸 애니메이션 */
.blink {
    animation: blinkAnim 1s infinite;
}

@keyframes blinkAnim {
    0% { opacity: 1; }
    50% { opacity: 0; }
    100% { opacity: 1; }
}



</style>

<body>


	<main class="main">
      <div class="group_58">
      <img class="background" src="/tkheat/image/tkimg/background0.png" />
    <img class="rail" src="/tkheat/image/tkimg/rail0.png" />
    <img class="rail_2" src="/tkheat/image/tkimg/rail-20.png" />
    <div class="group_57">
      <div class="bcf_1">
        <div class="group_13">
          <img class="bcf_1_pan" src="/tkheat/image/tkimg/bcf-1-pan0.png" />
          <img class="bcf_1_belt_1" src="/tkheat/image/tkimg/bcf-1-belt-10.png" />
          <img class="bcf_1_belt_2" src="/tkheat/image/tkimg/bcf-1-belt-20.png" />
        </div>
        <div class="group_4">
          <img class="bcf_1_red_box_1" src="/tkheat/image/tkimg/bcf-1-red-box-10.png" />
          <img class="bcf_1_red_box_2" src="/tkheat/image/tkimg/bcf-1-red-box-20.png" />
          <img class="bcf_1_red_box_3" src="/tkheat/image/tkimg/bcf-1-red-box-30.png" />
          <img class="bcf_1_red_box_4" src="/tkheat/image/tkimg/bcf-1-red-box-40.png" />
          <img class="bcf_1_yellow_box_1" src="/tkheat/image/tkimg/bcf-1-yellow-box-10.png" />
          <img class="bcf_1_yellow_box_2" src="/tkheat/image/tkimg/bcf-1-yellow-box-20.png" />
          <img class="bcf_1_yellow_box_3" src="/tkheat/image/tkimg/bcf-1-yellow-box-30.png" />
          <img class="bcf_1_yellow_box_4" src="/tkheat/image/tkimg/bcf-1-yellow-box-40.png" />
        </div>
        <div class="group_5">
          <img class="bcf_1_tray_2" src="/tkheat/image/tkimg/bcf-1-tray-20.png" />
          <img class="bcf_1_tray_3" src="/tkheat/image/tkimg/bcf-1-tray-30.png" />
          <img class="bcf_1_tray_1" src="/tkheat/image/tkimg/bcf-1-tray-10.png" />
          <img class="bcf_1_tray_4" src="/tkheat/image/tkimg/bcf-1-tray-40.png" />
          <img class="bcf_1_tray_5" src="/tkheat/image/tkimg/bcf-1-tray-50.png" />
        </div>
        <div class="group_2">
          <div class="bcf_1_door_1_chul_close">출구문 닫힘</div>
          <div class="bcf_1_door_1_chul_open">출구문 열림</div>
          <div class="bcf_1_door_1_drain">드레인</div>
          <div class="bcf_1_door_1_que">소입</div>
          <div class="bcf_1_door_1_out">처리품 추출중</div>
          <div class="bcf_1_door_1_in">처리품 장입중</div>
          <div class="bcf_1_door_1_mid_open">중간문 열림</div>
          <div class="bcf_1_door_1_mid_close">중간문 닫힘</div>
        </div>
        <div class="group_6">
          <div class="bcf_1_down">DW</div>
          <div class="bcf_1_up">UP</div>
        </div>
        <div class="group_12">
          <img class="bcf_1_ring_off" src="/tkheat/image/tkimg/bcf-1-ring-off0.png" />
          <img class="bcf_1_ring_on" src="/tkheat/image/tkimg/bcf-1-ring-on0.png" />
        </div>
        <div class="group_11">
          <div class="bcf_1_close_1">닫힘</div>
          <div class="bcf_1_open_1">열림</div>
          <div class="bcf_1_close_2">닫힘</div>
          <div class="bcf_1_open_2">열림</div>
        </div>
        <div class="group_3">
          <div class="bcf_1_door_3_jang_wait">처리품 장입대기</div>
          <div class="bcf_1_door_3_chu_wait">처리품 추출대기</div>
          <div class="bcf_1_door_3_gang">강온</div>
          <div class="bcf_1_door_3_diff">확산</div>
          <div class="bcf_1_door_3_chim">침탄</div>
          <div class="bcf_1_door_3_yae">예열</div>
          <div class="bcf_1_door_3_crack">균열</div>
          <div class="bcf_1_door_3_seong">승온</div>
          <div class="bcf_1_door_3_open">입구문 열림</div>
          <div class="bcf_1_door_3_close">입구문 닫힘</div>
          <div class="bcf_1_door_3_jang">처리품 장입중</div>
          <div class="bcf_1_door_3_rc">RC 팬정지</div>
        </div>
        <div class="group_9">
          <div class="bcf_1_door_2_close">닫힘</div>
          <div class="bcf_1_door_2_open">열림</div>
        </div>
        <div class="group_8">
          <img class="bcf_1_sensor_off_4" src="/tkheat/image/tkimg/bcf-1-sensor-off-40.png" />
          <img class="bcf_1_sensor_on_4" src="/tkheat/image/tkimg/bcf-1-sensor-on-40.png" />
          <img class="bcf_1_sensor_off_3" src="/tkheat/image/tkimg/bcf-1-sensor-off-30.png" />
          <img class="bcf_1_sensor_on_3" src="/tkheat/image/tkimg/bcf-1-sensor-on-30.png" />
          <img class="bcf_1_sensor_off_2" src="/tkheat/image/tkimg/bcf-1-sensor-off-20.png" />
          <img class="bcf_1_sensor_on_2" src="/tkheat/image/tkimg/bcf-1-sensor-on-20.png" />
          <img class="bcf_1_sensor_off_1" src="/tkheat/image/tkimg/bcf-1-sensor-off-10.png" />
          <img class="bcf_1_sensor_on_1" src="/tkheat/image/tkimg/bcf-1-sensor-on-10.png" />
        </div>
        <div class="group_7">
          <img class="bcf_1_pen_1" src="/tkheat/image/tkimg/bcf-1-pen-10.png" />
          <img class="bcf_1_pen_2" src="/tkheat/image/tkimg/bcf-1-pen-20.png" />
          <img class="bcf_1_pen_3" src="/tkheat/image/tkimg/bcf-1-pen-30.png" />
          <img class="bcf_1_pen_4" src="/tkheat/image/tkimg/bcf-1-pen-40.png" />
          <img class="bcf_1_pen_5" src="/tkheat/image/tkimg/bcf-1-pen-50.png" />
        </div>
        <div class="group_1">
          <img class="bcf_1_right_1" src="/tkheat/image/tkimg/bcf-1-right-10.png" />
          <img class="bcf_1_right_2" src="/tkheat/image/tkimg/bcf-1-right-20.png" />
          <img class="bcf_1_right_3" src="/tkheat/image/tkimg/bcf-1-right-30.png" />
          <img class="bcf_1_right_4" src="/tkheat/image/tkimg/bcf-1-right-40.png" />
          <img class="bcf_1_right_5" src="/tkheat/image/tkimg/bcf-1-right-50.png" />
        </div>
        <div class="group_44">
          <div class="bcf_1_auto_run">수동운전</div>
          <div class="bcf_1_manual_run">자동운전</div>
          <img class="bcf_1_alarm" src="/tkheat/image/tkimg/bcf-1-alarm0.png" />
        </div>
      </div>
      <div class="bcf_2">
        <div class="group_14">
          <img class="bcf_2_pan" src="/tkheat/image/tkimg/bcf-2-pan0.png" />
          <img class="bcf_2_belt_1" src="/tkheat/image/tkimg/bcf-2-belt-10.png" />
          <img class="bcf_2_belt_2" src="/tkheat/image/tkimg/bcf-2-belt-20.png" />
        </div>
        <div class="group_15">
          <img class="bcf_2_red_box_1" src="/tkheat/image/tkimg/bcf-2-red-box-10.png" />
          <img class="bcf_2_red_box_2" src="/tkheat/image/tkimg/bcf-2-red-box-20.png" />
          <img class="bcf_2_red_box_3" src="/tkheat/image/tkimg/bcf-2-red-box-30.png" />
          <img class="bcf_2_red_box_4" src="/tkheat/image/tkimg/bcf-2-red-box-40.png" />
          <img class="bcf_2_yellow_box_1" src="/tkheat/image/tkimg/bcf-2-yellow-box-10.png" />
          <img class="bcf_2_yellow_box_2" src="/tkheat/image/tkimg/bcf-2-yellow-box-20.png" />
          <img class="bcf_2_yellow_box_3" src="/tkheat/image/tkimg/bcf-2-yellow-box-30.png" />
          <img class="bcf_2_yellow_box_4" src="/tkheat/image/tkimg/bcf-2-yellow-box-40.png" />
        </div>
        <div class="group_16">
          <img class="bcf_2_tray_2" src="/tkheat/image/tkimg/bcf-2-tray-20.png" />
          <img class="bcf_2_tray_3" src="/tkheat/image/tkimg/bcf-2-tray-30.png" />
          <img class="bcf_2_tray_1" src="/tkheat/image/tkimg/bcf-2-tray-10.png" />
          <img class="bcf_2_tray_4" src="/tkheat/image/tkimg/bcf-2-tray-40.png" />
          <img class="bcf_2_tray_5" src="/tkheat/image/tkimg/bcf-2-tray-50.png" />
        </div>
        <div class="group_17">
          <div class="bcf_2_door_1_chul_close">출구문 닫힘</div>
          <div class="bcf_2_door_1_chul_open">출구문 열림</div>
          <div class="bcf_2_door_1_drain">드레인</div>
          <div class="bcf_2_door_1_que">소입</div>
          <div class="bcf_2_door_1_out">처리품 추출중</div>
          <div class="bcf_2_door_1_in">처리품 장입중</div>
          <div class="bcf_2_door_1_mid_open">중간문 열림</div>
          <div class="bcf_2_door_1_mid_close">중간문 닫힘</div>
        </div>
        <div class="group_18">
          <div class="bcf_2_down">DW</div>
          <div class="bcf_2_up">UP</div>
        </div>
        <div class="group_19">
          <img class="bcf_2_ring_off" src="/tkheat/image/tkimg/bcf-2-ring-off0.png" />
          <img class="bcf_2_ring_on" src="/tkheat/image/tkimg/bcf-2-ring-on0.png" />
        </div>
        <div class="group_22">
          <div class="bcf_2_door_2_close">닫힘</div>
          <div class="bcf_2_door_2_open">열림</div>
        </div>
        <div class="group_23">
          <img class="bcf_2_sensor_off_4" src="/tkheat/image/tkimg/bcf-2-sensor-off-40.png" />
          <img class="bcf_2_sensor_on_4" src="/tkheat/image/tkimg/bcf-2-sensor-on-40.png" />
          <img class="bcf_2_sensor_off_3" src="/tkheat/image/tkimg/bcf-2-sensor-off-30.png" />
          <img class="bcf_2_sensor_on_3" src="/tkheat/image/tkimg/bcf-2-sensor-on-30.png" />
          <img class="bcf_2_sensor_off_2" src="/tkheat/image/tkimg/bcf-2-sensor-off-20.png" />
          <img class="bcf_2_sensor_on_2" src="/tkheat/image/tkimg/bcf-2-sensor-on-20.png" />
          <img class="bcf_2_sensor_off_1" src="/tkheat/image/tkimg/bcf-2-sensor-off-10.png" />
          <img class="bcf_2_sensor_on_1" src="/tkheat/image/tkimg/bcf-2-sensor-on-10.png" />
        </div>
        <div class="group_24">
          <img class="bcf_2_pen_1" src="/tkheat/image/tkimg/bcf-2-pen-10.png" />
          <img class="bcf_2_pen_2" src="/tkheat/image/tkimg/bcf-2-pen-20.png" />
          <img class="bcf_2_pen_3" src="/tkheat/image/tkimg/bcf-2-pen-30.png" />
          <img class="bcf_2_pen_4" src="/tkheat/image/tkimg/bcf-2-pen-40.png" />
          <img class="bcf_2_pen_5" src="/tkheat/image/tkimg/bcf-2-pen-50.png" />
        </div>
        <div class="group_25">
          <img class="bcf_2_right_1" src="/tkheat/image/tkimg/bcf-2-right-10.png" />
          <img class="bcf_2_right_2" src="/tkheat/image/tkimg/bcf-2-right-20.png" />
          <img class="bcf_2_right_3" src="/tkheat/image/tkimg/bcf-2-right-30.png" />
          <img class="bcf_2_right_4" src="/tkheat/image/tkimg/bcf-2-right-40.png" />
          <img class="bcf_2_right_5" src="/tkheat/image/tkimg/bcf-2-right-50.png" />
        </div>
        <div class="group_45">
          <div class="bcf_2_auto_run">수동운전</div>
          <div class="bcf_2_manual_run">자동운전</div>
          <img class="bcf_2_alarm" src="/tkheat/image/tkimg/bcf-2-alarm0.png" />
        </div>
        <div class="group_21">
          <div class="bcf_2_door_3_jang_wait">처리품 장입대기</div>
          <div class="bcf_2_door_3_chu_wait">처리품 추출대기</div>
          <div class="bcf_2_door_3_gang">강온</div>
          <div class="bcf_2_door_3_diff">확산</div>
          <div class="bcf_2_door_3_chim">침탄</div>
          <div class="bcf_2_door_3_yae">예열</div>
          <div class="bcf_2_door_3_crack">균열</div>
          <div class="bcf_2_door_3_seong">승온</div>
          <div class="bcf_2_door_3_open">입구문 열림</div>
          <div class="bcf_2_door_3_close">입구문 닫힘</div>
          <div class="bcf_2_door_3_jang">처리품 장입중</div>
          <div class="bcf_2_door_3_rc">RC 팬정지</div>
        </div>
        <div class="group_20">
          <div class="bcf_2_close_1">닫힘</div>
          <div class="bcf_2_open_1">열림</div>
          <div class="bcf_2_close_2">닫힘</div>
          <div class="bcf_2_open_2">열림</div>
        </div>
      </div>
      <div class="bcf_3">
        <div class="group_10">
          <img class="bcf_3_floor_1" src="/tkheat/image/tkimg/bcf-3-floor-10.png" />
          <img class="bcf_3_floor_2" src="/tkheat/image/tkimg/bcf-3-floor-20.png" />
          <img class="bcf_3_floor_3" src="/tkheat/image/tkimg/bcf-3-floor-30.png" />
          <img class="bcf_3_floor_4" src="/tkheat/image/tkimg/bcf-3-floor-40.png" />
          <img class="bcf_3_floor_5" src="/tkheat/image/tkimg/bcf-3-floor-50.png" />
        </div>
        <div class="group_26">
          <img class="bcf_3_pan" src="/tkheat/image/tkimg/bcf-3-pan0.png" />
          <img class="bcf_3_belt_1" src="/tkheat/image/tkimg/bcf-3-belt-10.png" />
        </div>
        <div class="group_27">
          <img class="bcf_3_red_box_1" src="/tkheat/image/tkimg/bcf-3-red-box-10.png" />
          <img class="bcf_3_red_box_2" src="/tkheat/image/tkimg/bcf-3-red-box-20.png" />
          <img class="bcf_3_red_box_3" src="/tkheat/image/tkimg/bcf-3-red-box-30.png" />
          <img class="bcf_3_red_box_4" src="/tkheat/image/tkimg/bcf-3-red-box-40.png" />
          <img class="bcf_3_yellow_box_1" src="/tkheat/image/tkimg/bcf-3-yellow-box-10.png" />
          <img class="bcf_3_yellow_box_2" src="/tkheat/image/tkimg/bcf-3-yellow-box-20.png" />
          <img class="bcf_3_yellow_box_3" src="/tkheat/image/tkimg/bcf-3-yellow-box-30.png" />
          <img class="bcf_3_yellow_box_4" src="/tkheat/image/tkimg/bcf-3-yellow-box-40.png" />
        </div>
        <div class="group_28">
          <img class="bcf_3_tray_2" src="/tkheat/image/tkimg/bcf-3-tray-20.png" />
          <img class="bcf_3_tray_3" src="/tkheat/image/tkimg/bcf-3-tray-30.png" />
          <img class="bcf_3_tray_1" src="/tkheat/image/tkimg/bcf-3-tray-10.png" />
          <img class="bcf_3_tray_4" src="/tkheat/image/tkimg/bcf-3-tray-40.png" />
        </div>
        <div class="group_29">
          <div class="bcf_3_door_1_chul_close">처리품 추출중</div>
          <div class="bcf_3_door_1_drain">드레인</div>
          <div class="bcf_3_door_1_elv_down">엘리베이터 하강</div>
          <div class="bcf_3_door_1_elv_up">엘리베이터 상승</div>
          <div class="bcf_3_door_1_que">소입</div>
          <div class="bcf_3_door_1_midclose">중간문 닫힘</div>
          <div class="bcf_3_door_1_mid_open">중간문 열림</div>
          <div class="bcf_3_door_1_jang_wait">처리품 장입대기</div>
          <div class="bcf_3_door_1_pork_back">추출포크 후진</div>
          <div class="bcf_3_door_1_pork_for">추출포크 전진</div>
          <div class="bcf_3_door_1_close">출구문 닫힘</div>
          <div class="bcf_3_door_1_open">출구문 열림</div>
        </div>
        <div class="group_30">
          <div class="bcf_3_down">DW</div>
          <div class="bcf_3_up">UP</div>
        </div>
        <div class="group_33">
          <div class="bcf_3_door_3_pork_back">장입포크 후진</div>
          <div class="bcf_3_door_3_pork_for">장입포크 전진</div>
          <div class="bcf_3_door_3_gang">강온</div>
          <div class="bcf_3_door_3_open">입구문 열림</div>
          <div class="bcf_3_door_3_close">입구문 닫힘</div>
          <div class="bcf_3_door_3_fan_stop">팬 정지</div>
          <div class="bcf_3_door_3_ga">가열</div>
          <div class="bcf_3_door_3_crack">균열</div>
          <div class="bcf_3_door_3_seong">승온</div>
          <div class="bcf_3_door_3_seong_wait">승온 대기</div>
          <div class="bcf_3_door_3_jang_wait">처리품 장입대기</div>
        </div>
        <div class="group_34">
          <div class="bcf_3_door_2_close">닫힘</div>
          <div class="bcf_3_door_2_open">열림</div>
        </div>
        <div class="group_35">
          <img class="bcf_3_sensor_off_3" src="/tkheat/image/tkimg/bcf-3-sensor-off-30.png" />
          <img class="bcf_3_sensor_on_3" src="/tkheat/image/tkimg/bcf-3-sensor-on-30.png" />
          <img class="bcf_3_sensor_off_2" src="/tkheat/image/tkimg/bcf-3-sensor-off-20.png" />
          <img class="bcf_3_sensor_on_2" src="/tkheat/image/tkimg/bcf-3-sensor-on-20.png" />
          <img class="bcf_3_sensor_off_1" src="/tkheat/image/tkimg/bcf-3-sensor-off-10.png" />
          <img class="bcf_3_sensor_on_1" src="/tkheat/image/tkimg/bcf-3-sensor-on-10.png" />
        </div>
        <div class="group_36">
          <img class="bcf_3_pen_1" src="/tkheat/image/tkimg/bcf-3-pen-10.png" />
          <img class="bcf_3_pen_2" src="/tkheat/image/tkimg/bcf-3-pen-20.png" />
          <img class="bcf_3_pen_3" src="/tkheat/image/tkimg/bcf-3-pen-30.png" />
          <img class="bcf_3_pen_4" src="/tkheat/image/tkimg/bcf-3-pen-40.png" />
          <img class="bcf_3_pen_5" src="/tkheat/image/tkimg/bcf-3-pen-50.png" />
        </div>
        <div class="group_37">
          <img class="bcf_3_right_1" src="/tkheat/image/tkimg/bcf-3-right-10.png" />
          <img class="bcf_3_right_2" src="/tkheat/image/tkimg/bcf-3-right-20.png" />
          <img class="bcf_3_right_3" src="/tkheat/image/tkimg/bcf-3-right-30.png" />
          <img class="bcf_3_right_4" src="/tkheat/image/tkimg/bcf-3-right-40.png" />
          <img class="bcf_3_right_5" src="/tkheat/image/tkimg/bcf-3-right-50.png" />
        </div>
        <div class="group_46">
          <div class="bcf_3_auto_run">수동운전</div>
          <div class="bcf_3_manual_run">자동운전</div>
          <img class="bcf_3_alarm" src="/tkheat/image/tkimg/bcf-3-alarm0.png" />
        </div>
        <div class="group_32">
          <div class="bcf_3_close_1">닫힘</div>
          <div class="bcf_3_open_1">열림</div>
          <div class="bcf_3_close_2">닫힘</div>
          <div class="bcf_3_open_2">열림</div>
        </div>
      </div>
      <div class="bcf_4">
        <div class="group_10">
          <img class="bcf_4_floor_1" src="/tkheat/image/tkimg/bcf-4-floor-10.png" />
          <img class="bcf_4_floor_2" src="/tkheat/image/tkimg/bcf-4-floor-20.png" />
          <img class="bcf_4_floor_3" src="/tkheat/image/tkimg/bcf-4-floor-30.png" />
          <img class="bcf_4_floor_4" src="/tkheat/image/tkimg/bcf-4-floor-40.png" />
          <img class="bcf_4_floor_5" src="/tkheat/image/tkimg/bcf-4-floor-50.png" />
        </div>
        <div class="group_26">
          <img class="bcf_4_pan" src="/tkheat/image/tkimg/bcf-4-pan0.png" />
          <img class="bcf_4_belt_1" src="/tkheat/image/tkimg/bcf-4-belt-10.png" />
        </div>
        <div class="group_27">
          <img class="bcf_4_red_box_1" src="/tkheat/image/tkimg/bcf-4-red-box-10.png" />
          <img class="bcf_4_red_box_2" src="/tkheat/image/tkimg/bcf-4-red-box-20.png" />
          <img class="bcf_4_red_box_3" src="/tkheat/image/tkimg/bcf-4-red-box-30.png" />
          <img class="bcf_4_red_box_4" src="/tkheat/image/tkimg/bcf-4-red-box-40.png" />
          <img class="bcf_4_yellow_box_1" src="/tkheat/image/tkimg/bcf-4-yellow-box-10.png" />
          <img class="bcf_4_yellow_box_2" src="/tkheat/image/tkimg/bcf-4-yellow-box-20.png" />
          <img class="bcf_4_yellow_box_3" src="/tkheat/image/tkimg/bcf-4-yellow-box-30.png" />
          <img class="bcf_4_yellow_box_4" src="/tkheat/image/tkimg/bcf-4-yellow-box-40.png" />
        </div>
        <div class="group_28">
          <img class="bcf_4_tray_2" src="/tkheat/image/tkimg/bcf-4-tray-20.png" />
          <img class="bcf_4_tray_3" src="/tkheat/image/tkimg/bcf-4-tray-30.png" />
          <img class="bcf_4_tray_1" src="/tkheat/image/tkimg/bcf-4-tray-10.png" />
          <img class="bcf_4_tray_4" src="/tkheat/image/tkimg/bcf-4-tray-40.png" />
        </div>
        <div class="group_34">
          <div class="bcf_4_door_2_close">닫힘</div>
          <div class="bcf_4_door_2_open">열림</div>
        </div>
        <div class="group_35">
          <img class="bcf_4_sensor_off_3" src="/tkheat/image/tkimg/bcf-4-sensor-off-30.png" />
          <img class="bcf_4_sensor_on_3" src="/tkheat/image/tkimg/bcf-4-sensor-on-30.png" />
          <img class="bcf_4_sensor_off_2" src="/tkheat/image/tkimg/bcf-4-sensor-off-20.png" />
          <img class="bcf_4_sensor_on_2" src="/tkheat/image/tkimg/bcf-4-sensor-on-20.png" />
          <img class="bcf_4_sensor_off_1" src="/tkheat/image/tkimg/bcf-4-sensor-off-10.png" />
          <img class="bcf_4_sensor_on_1" src="/tkheat/image/tkimg/bcf-4-sensor-on-10.png" />
        </div>
        <div class="group_47">
          <div class="bcf_4_down">DW</div>
          <div class="bcf_4_up">UP</div>
        </div>
        <div class="group_36">
          <img class="bcf_4_pen_1" src="/tkheat/image/tkimg/bcf-4-pen-10.png" />
          <img class="bcf_4_pen_2" src="/tkheat/image/tkimg/bcf-4-pen-20.png" />
          <img class="bcf_4_pen_3" src="/tkheat/image/tkimg/bcf-4-pen-30.png" />
          <img class="bcf_4_pen_4" src="/tkheat/image/tkimg/bcf-4-pen-40.png" />
          <img class="bcf_4_pen_5" src="/tkheat/image/tkimg/bcf-4-pen-50.png" />
        </div>
        <div class="group_37">
          <img class="bcf_4_right_1" src="/tkheat/image/tkimg/bcf-4-right-10.png" />
          <img class="bcf_4_right_2" src="/tkheat/image/tkimg/bcf-4-right-20.png" />
          <img class="bcf_4_right_3" src="/tkheat/image/tkimg/bcf-4-right-30.png" />
          <img class="bcf_4_right_4" src="/tkheat/image/tkimg/bcf-4-right-40.png" />
          <img class="bcf_4_right_5" src="/tkheat/image/tkimg/bcf-4-right-50.png" />
        </div>
        <div class="group_46">
          <div class="bcf_4_auto_run">수동운전</div>
          <div class="bcf_4_manual_run">자동운전</div>
          <img class="bcf_4_alarm" src="/tkheat/image/tkimg/bcf-4-alarm0.png" />
        </div>
        <div class="group_32">
          <div class="bcf_4_close_1">닫힘</div>
          <div class="bcf_4_open_1">열림</div>
          <div class="bcf_4_close_2">닫힘</div>
          <div class="bcf_4_open_2">열림</div>
        </div>
        <div class="group_29">
          <div class="bcf_4_door_1_chul_close">처리품 추출중</div>
          <div class="bcf_4_door_1_drain">드레인</div>
          <div class="bcf_4_door_1_elv_down">엘리베이터 하강</div>
          <div class="bcf_4_door_1_elv_up">엘리베이터 상승</div>
          <div class="bcf_4_door_1_que">소입</div>
          <div class="bcf_4_door_1_midclose">중간문 닫힘</div>
          <div class="bcf_4_door_1_mid_open">중간문 열림</div>
          <div class="bcf_4_door_1_jang_wait">처리품 장입대기</div>
          <div class="bcf_4_door_1_pork_back">추출포크 후진</div>
          <div class="bcf_4_door_1_pork_for">추출포크 전진</div>
          <div class="bcf_4_door_1_close">출구문 닫힘</div>
          <div class="bcf_4_door_1_open">출구문 열림</div>
        </div>
        <div class="group_33">
          <div class="bcf_4_door_3_pork_back">장입포크 후진</div>
          <div class="bcf_4_door_3_pork_for">장입포크 전진</div>
          <div class="bcf_4_door_3_gang">강온</div>
          <div class="bcf_4_door_3_open">입구문 열림</div>
          <div class="bcf_4_door_3_close">입구문 닫힘</div>
          <div class="bcf_4_door_3_fan_stop">팬 정지</div>
          <div class="bcf_4_door_3_ga">가열</div>
          <div class="bcf_4_door_3_crack">균열</div>
          <div class="bcf_4_door_3_seong">승온</div>
          <div class="bcf_4_door_3_seong_wait">승온대기</div>
          <div class="bcf_4_door_3_jang_wait">처리품 장입대기</div>
        </div>
      </div>
      <div class="bcf_5">
        <div class="group_43">
          <img class="bcf_5_back" src="/tkheat/image/tkimg/bcf-5-back0.png" />
          <img class="bcf_5_pan" src="/tkheat/image/tkimg/bcf-5-pan0.png" />
          <img class="bcf_5_back_2" src="/tkheat/image/tkimg/bcf-5-back-20.png" />
        </div>
        <div class="group_38">
          <img class="bcf_5_red_box_1" src="/tkheat/image/tkimg/bcf-5-red-box-10.png" />
          <img class="bcf_5_red_box_2" src="/tkheat/image/tkimg/bcf-5-red-box-20.png" />
          <img class="bcf_5_red_box_3" src="/tkheat/image/tkimg/bcf-5-red-box-30.png" />
          <img class="bcf_5_red_box_4" src="/tkheat/image/tkimg/bcf-5-red-box-40.png" />
          <img class="bcf_5_yellow_box_1" src="/tkheat/image/tkimg/bcf-5-yellow-box-10.png" />
          <img class="bcf_5_yellow_box_2" src="/tkheat/image/tkimg/bcf-5-yellow-box-20.png" />
          <img class="bcf_5_yellow_box_3" src="/tkheat/image/tkimg/bcf-5-yellow-box-30.png" />
          <img class="bcf_5_yellow_box_4" src="/tkheat/image/tkimg/bcf-5-yellow-box-40.png" />
        </div>
        <div class="group_382">
          <img class="bcf_5_floor_1" src="/tkheat/image/tkimg/bcf-5-floor-10.png" />
          <img class="bcf_5_floor_2" src="/tkheat/image/tkimg/bcf-5-floor-20.png" />
          <img class="bcf_5_floor_3" src="/tkheat/image/tkimg/bcf-5-floor-30.png" />
          <img class="bcf_5_floor_4" src="/tkheat/image/tkimg/bcf-5-floor-40.png" />
          <img class="bcf_5_floor_5" src="/tkheat/image/tkimg/bcf-5-floor-50.png" />
        </div>
        <div class="group_42">
          <img class="bcf_5_tray_3" src="/tkheat/image/tkimg/bcf-5-tray-20.png" />
          <img class="bcf_5_tray_2" src="/tkheat/image/tkimg/bcf-5-tray-21.png" />
          <img class="bcf_5_tray_1" src="/tkheat/image/tkimg/bcf-5-tray-22.png" />
        </div>
        <div class="group_41">
          <div class="bcf_5_down">DW</div>
          <div class="bcf_5_up">UP</div>
        </div>
        <div class="group_40">
          <img class="bcf_5_sensor_off_2" src="/tkheat/image/tkimg/bcf-5-sensor-off-30.png" />
          <img class="bcf_5_sensor_on_2" src="/tkheat/image/tkimg/bcf-5-sensor-on-30.png" />
          <img class="bcf_5_sensor_off_1" src="/tkheat/image/tkimg/bcf-5-sensor-off-20.png" />
          <img class="bcf_5_sensor_on_1" src="/tkheat/image/tkimg/bcf-5-sensor-on-20.png" />
        </div>
        <div class="group_39">
          <img class="bcf_5_pen_1" src="/tkheat/image/tkimg/bcf-5-pen-10.png" />
          <img class="bcf_5_pen_2" src="/tkheat/image/tkimg/bcf-5-pen-20.png" />
          <img class="bcf_5_pen_3" src="/tkheat/image/tkimg/bcf-5-pen-30.png" />
          <img class="bcf_5_pen_4" src="/tkheat/image/tkimg/bcf-5-pen-40.png" />
          <img class="bcf_5_pen_5" src="/tkheat/image/tkimg/bcf-5-pen-50.png" />
        </div>
        <div class="group_383">
          <!-- <div class="bcf_5_door_1_close">닫힘</div>
          <div class="bcf_5_door_1_open">열림</div> -->
        </div>
        <div class="group_46">
          <div class="bcf_5_auto_run">수동운전</div>
          <div class="bcf_5_manual_run">자동운전</div>
          <img class="bcf_5_alarm" src="/tkheat/image/tkimg/bcf-5-alarm0.png" />
        </div>
        <div class="group_322">
          <!-- <div class="bcf_5_close_1">닫힘</div>
          <div class="bcf_5_open_1">열림</div> -->
        </div>
      </div>
      <div class="tf">
        <div class="group_46">
          <div class="tf_auto_run">수동운전</div>
          <div class="tf_manual_run">자동운전</div>
          <img class="tf_alarm" src="/tkheat/image/tkimg/tf-alarm0.png" />
        </div>
        <div class="group_51">
          <img class="tf_pan_1" src="/tkheat/image/tkimg/tf-pan-10.png" />
          <img class="tf_pan_2" src="/tkheat/image/tkimg/tf-pan-20.png" />
          <img class="tf_pan_3" src="/tkheat/image/tkimg/tf-pan-30.png" />
          <img class="tf_belt_1" src="/tkheat/image/tkimg/tf-belt-10.png" />
          <img class="tf_belt_2" src="/tkheat/image/tkimg/tf-belt-20.png" />
          <img class="tf_cold_pen_1" src="/tkheat/image/tkimg/cold-pen.png" />
          <img class="tf_cold_pen_2" src="/tkheat/image/tkimg/cold-pen.png" />
        </div>
        <div class="group_50">
          <img class="tf_sensor_off_1" src="/tkheat/image/tkimg/tf-sensor-off-10.png" />
          <img class="tf_sensor_on_1" src="/tkheat/image/tkimg/tf-sensor-on-10.png" />
          <img class="tf_sensor_off_2" src="/tkheat/image/tkimg/tf-sensor-off-20.png" />
          <img class="tf_sensor_on_2" src="/tkheat/image/tkimg/tf-sensor-on-20.png" />
          <img class="tf_sensor_off_3" src="/tkheat/image/tkimg/tf-sensor-off-30.png" />
          <img class="tf_sensor_on_3" src="/tkheat/image/tkimg/tf-sensor-on-30.png" />
          <img class="tf_sensor_off_4" src="/tkheat/image/tkimg/tf-sensor-off-40.png" />
          <img class="tf_sensor_on_4" src="/tkheat/image/tkimg/tf-sensor-on-40.png" />
          <img class="tf_sensor_off_5" src="/tkheat/image/tkimg/tf-sensor-off-50.png" />
          <img class="tf_sensor_on_5" src="/tkheat/image/tkimg/tf-sensor-on-50.png" />
        </div>
        <div class="group_49">
          <img class="tf_tray_1" src="/tkheat/image/tkimg/tf-tray-10.png" />
          <img class="tf_tray_2" src="/tkheat/image/tkimg/tf-tray-20.png" />
          <img class="tf_tray_3" src="/tkheat/image/tkimg/tf-tray-30.png" />
          <img class="tf_tray_4" src="/tkheat/image/tkimg/tf-tray-40.png" />
          <img class="tf_tray_5" src="/tkheat/image/tkimg/tf-tray-50.png" />
        </div>
        <div class="group_52">
          <img class="tf_pen_1" src="/tkheat/image/tkimg/tf-pen-10.png" />
          <img class="tf_pen_2" src="/tkheat/image/tkimg/tf-pen-20.png" />
        </div>
        <div class="group_53">
          <div class="tf_door_4_close">입구문 닫힘</div>
          <div class="tf_door_4_open">입구문 열림</div>
          <div class="tf_door_4_1_clear">1실 공정 완료</div>
          <div class="tf_door_4_1_tem">1실 템퍼링</div>
          <div class="tf_door_4_jang">처리품 장입중</div>
          <div class="tf_door_4_jang_wait">처리품 장입대기</div>
        </div>
        <div class="group_56">
          <div class="tf_door_3_1_to_2">1실->2실 이송중</div>
          <div class="tf_door_3_2_tem">2실 템퍼링</div>
          <div class="tf_door_3_2_clear">2실 공정 완료</div>
        </div>
        <div class="group_55">
          <div class="tf_door_2_close">출구문 닫힘</div>
          <div class="tf_door_2_open">출구문 열림</div>
          <div class="tf_door_2_out">처리품 추출중</div>
          <div class="tf_door_2_2_to_3">2실->3실 이동중</div>
          <div class="tf_door_2_3_clear">3실 공정 완료</div>
          <div class="tf_door_2_3_tem">3실 템퍼링</div>
        </div>
        <div class="group_54">
          <div class="tf_door_1_cold_wait">냉각팬 기동대기</div>
          <div class="tf_door_1_cold_on">냉각팬 기동</div>
          <div class="tf_door_1_jang">처리품 장입중</div>
          <div class="tf_door_1_ipchul_close">입/출구문 닫힘</div>
          <div class="tf_door_1_ipchul_open">입/출구문 열림</div>
          <div class="tf_door_1_ipchul_wait">입/출구문 열림대기</div>
        </div>
        <div class="group_323">
          <div class="tf_close_2">닫힘</div>
          <div class="tf_open_2">열림</div>
          <div class="tf_close_1">닫힘</div>
          <div class="tf_open_1">열림</div>
        </div>
      </div>
    </div>
  </div>
  
  
  <div class="bcf_table_wrap">
    <table class="bcf_table">
        <thead>
            <tr>
                <th>온도</th>
                <th>CF #1</th>
                <th>QT #1</th>
                <th>CP #1</th>
                <th>CF #2</th>
                <th>QT #2</th>
                <th>CP #2</th>
                <th>CF #3</th>
                <th>QT #3</th>
                <th>CP #3</th>
                <th>CF #4</th>
                <th>QT #4</th>
                <th>CP #4</th>
                <th>소입 #5</th>
                <th>가열 #5</th>
                <th>CP #5</th>
                <th>소려1존</th>
                <th>소려2존</th>
                <th>소려3존</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style="background: #f3f6fb; border: 1px solid #d0d3d8; color: #0b63ce;">현재값</td>
                <td class="bcf_1_cf_pv"></td>
                <td class="bcf_1_qt_pv"></td>
                <td class="bcf_1_cp_pv"></td>
                <td class="bcf_2_cf_pv"></td>
                <td class="bcf_2_qt_pv"></td>
                <td class="bcf_2_cp_pv"></td>
                <td class="bcf_3_cf_pv"></td>
                <td class="bcf_3_qt_pv"></td>
                <td class="bcf_3_cp_pv"></td>
                <td class="bcf_4_cf_pv"></td>
                <td class="bcf_4_qt_pv"></td>
                <td class="bcf_4_cp_pv"></td>
                <td class="bcf_5_cf_pv"></td>
                <td class="bcf_5_qt_pv"></td>
                <td class="bcf_5_cp_pv"></td>
                <td class="tf_1_pv"></td>
                <td class="tf_2_pv"></td>
                <td class="tf_3_pv"></td>
            </tr>
            <tr>
                <td style="background: #f3f6fb; border: 1px solid #d0d3d8; color: #0b63ce;">설정값</td>
                <td class="bcf_1_cf_sv"></td>
                <td class="bcf_1_qt_sv"></td>
                <td class="bcf_1_cp_sv"></td>
                <td class="bcf_2_cf_sv"></td>
                <td class="bcf_2_qt_sv"></td>
                <td class="bcf_2_cp_sv"></td>
                <td class="bcf_3_cf_sv"></td>
                <td class="bcf_3_qt_sv"></td>
                <td class="bcf_3_cp_sv"></td>
                <td class="bcf_4_cf_sv"></td>
                <td class="bcf_4_qt_sv"></td>
                <td class="bcf_4_cp_sv"></td>
                <td class="bcf_5_cf_sv"></td>
                <td class="bcf_5_qt_sv"></td>
                <td class="bcf_5_cp_sv"></td>
                <td class="tf_1_sv"></td>
                <td class="tf_2_sv"></td>
                <td class="tf_3_sv"></td>
            </tr>
        </tbody>
    </table>
</div>
  
  
      
	</main>
	
	
<script>
$(function(){
    updateOverview();
    setInterval(updateOverview, 30000);
});

function updateOverview() {

    $.ajax({
        url: '/tkheat/monitoring/getOverviewData',
        type: 'POST',
        dataType: 'json',
        success: function(data) {

            Object.keys(data).forEach(function(key){

                const $el = $("." + key);
                if($el.length === 0) return;   // 해당 클래스 없으면 스킵

                const value = Number(data[key]);

                /* =========================================
                   1️⃣ PV / SV 공통 처리 (BCF + TF 공통)
                ========================================= */
                if(key.includes("_pv") || key.includes("_sv")){

                    const num = Number(data[key]);

                    $el.text(
                        isNaN(num) ? "0" :
                        key.includes("cp") ? num.toFixed(3) :  // cp → 소수 3자리
                        Math.floor(num)                        // 나머지 → 정수
                    );

                    return;
                }

                /* =========================================
                   2️⃣ ALARM 처리 (기본 none → 1일 때만 표시 + blink)
                ========================================= */
                if(key.endsWith("_alarm")){

                    $el.css("display", value === 1 ? "block" : "none")
                       .toggleClass("blink", value === 1);

                    return;
                }

                /* =========================================
                   3️⃣ BCF 처리
                ========================================= */
                if(key.startsWith("bcf_")){

                    // 🔹 정확한 pen 처리
                    if(key.endsWith("_pen_2") || 
                       key.endsWith("_pen_4") || 
                       key.endsWith("_pen_5")){

                        if(value === 1){
                            $el.css("display","block")
                               .addClass("rotating");
                        }else{
                            $el.css("display","none")
                               .removeClass("rotating");
                        }
                        return;
                    }

                    // 🔹 cold_pen (항상 표시 + 회전만 제어)
                    if(key.includes("cold_pen")){
                        $el.css("display","block")
                           .toggleClass("rotating", value === 1);
                        return;
                    }

                    // 🔹 일반 비트 (open/close 등)
                    $el.css("display", value === 1 ? "block" : "none");
                    return;
                }

                /* =========================================
                   4️⃣ TF 처리
                ========================================= */
                if(key.startsWith("tf_")){

                    if(key.endsWith("_pen_1") || key.endsWith("_pen_2")){

                        if(value === 1){
                            $el.css("display","block")
                               .addClass("rotating");
                        }else{
                            $el.css("display","none")
                               .removeClass("rotating");
                        }
                        return;
                    }

                    // 일반 TF 비트
                    $el.css("display", value === 1 ? "block" : "none");
                }

            });

        },
        error: function(xhr, status, error) {
            console.error("Overview 데이터 조회 실패:", error);
        }
    });
}
</script>


</body>
</html>
