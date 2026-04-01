<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 제이쿼리홈페이지 js -->
<script type="text/javascript" src="/tkheat/js/jquery-3.7.1.min.js"></script>

<!-- Tabulator 테이블 -->
<script type="text/javascript" src="/tkheat/js/tabulator/tabulator.js"></script>
<link rel="stylesheet" href="/tkheat/css/tabulator/tabulator_simple.css"> 

<!-- moment -->
<script type="text/javascript" src="/tkheat/js/moment/moment.min.js"></script>

<!-- 화면캡쳐용 -->
<script type="text/javascript" src="/tkheat/js/html2canvas.js"></script>

<!-- 하이차트 -->
<script type="text/javascript" src="/tkheat/js/highchart/highcharts.js"></script>
<script type="text/javascript" src="/tkheat/js/highchart/exporting.js"></script>
<script type="text/javascript" src="/tkheat/js/highchart/export-data.js"></script>
<script type="text/javascript" src="/tkheat/js/highchart/data.js"></script>

<!-- Air Datepicker -->
<script type="text/javascript" src="/tkheat/js/airdatepicker/datepicker.min.js"></script>
<script type="text/javascript" src="/tkheat/js/airdatepicker/datepicker.ko.js"></script>
<link rel="stylesheet" href="/tkheat/css/airdatepicker/datepicker.min.css"> 

<!-- datetimepicker 라이브러리 -->
<script type="text/javascript" src="/tkheat/js/datetimepicker/datetimepicker.js"></script>
<link rel="stylesheet" href="/tkheat/css/datetimepicker/datetimepicker.css"> 

<style>
	.tabulator {
		font-size: 10px;
	}


.xdsoft_datetimepicker {
    z-index: 30020 !important;
}

</style>

<script>

$(function(){
	rpImagePopup();
	
	//airDatePicker 설정
	//날짜 : 일
	$(".daySet").datepicker({
		language: 'ko',
		autoClose: true,
	}); 
		
	//날짜 : 월
	$(".monthSet").datepicker({
		language: 'ko',
		view: 'months',
		minView: 'months',
		dateFormat: 'yyyy-mm',
		autoClose: true,
	});

	//날짜 : 년
	$(".yearSet").datepicker({
		language: 'ko',
		view: 'years',
		minView: 'years',
		dateFormat: 'yyyy',
		autoClose: true,
		language: 'ko'
	});
	
	//날짜 : 년-월-일 시:분
	$(".ymdHmSet").datepicker({
		language: 'ko',
		dateFormat: 'yyyy-mm-dd hh:mm',
		autoClose: true,
		language: 'ko'
	});
		
	$.datetimepicker.setLocale("ko");
	datePickerDate();
	datePickerDateTime();
});

function datePickerDate(){
	$(".datetimepicker_date").datetimepicker({
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		format:'Y-m-d',
		step: 1,
		timepicker:false,
		defaultSelect: false,
		defaultDate: false,
		onClose: function(ct, $i) {
			let endDateInput = $("#dateEnd");
			if($("#dateEnd").val() != ''){
				let tempStartDate = new Date(ct);
				let tempEndDate = new Date(endDateInput.val());
				if(tempStartDate > tempEndDate){
					endDateInput.val(getFormatDateTime(ct));
				}
			}else {
				endDateInput.val(getFormatDateTime(ct));
			}
		},
		onSelectDate: function(ct, $i){
			$("#dateEnd").datetimepicker('setOptions', { minDate: ct });
			$("#dateEnd").datetimepicker('setOptions', { minTime: ct });
		},
		onSelectTime: function(ct, $i){
			$("#dateEnd").datetimepicker('setOptions', { minDate: ct });
			$("#dateEnd").datetimepicker('setOptions', { minTime: ct });
		}		
	});
}

function datePickerDateTime(){
	$(".datetimepicker_datetime").datetimepicker({
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		format:'Y-m-d H:i',
		step: 1,
		defaultSelect: false,
		defaultDate: false,
		onClose: function(ct, $i) {
			let endDateInput = $("#dateEnd");
			if($("#dateEnd").val() != ''){
				let tempStartDate = new Date(ct);
				let tempEndDate = new Date(endDateInput.val());
				if(tempStartDate > tempEndDate){
					endDateInput.val(getFormatDateTime(ct));
				}
			}else {
				endDateInput.val(getFormatDateTime(ct));
			}
		},
		onSelectDate: function(ct, $i){
			$("#dateEnd").datetimepicker('setOptions', { minDate: ct });
			$("#dateEnd").datetimepicker('setOptions', { minTime: ct });
		},
		onSelectTime: function(ct, $i){
			$("#dateEnd").datetimepicker('setOptions', { minDate: ct });
			$("#dateEnd").datetimepicker('setOptions', { minTime: ct });
		}		
	});
}

function datePickerMonth(){
	$(".datetimepicker_month").datetimepicker({
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	    format:'Y-m',
	    step: 1,
	    timepicker:false,
	    defaultSelect: false,
	    defaultDate: false,
	    onClose: function(ct, $i) {
	        let endDateInput = $("#dateEnd");
	        if($("#dateEnd").val() != ''){
	            let tempStartDate = new Date(ct);
	            let tempEndDate = new Date(endDateInput.val());
	            if(tempStartDate > tempEndDate){
	                endDateInput.val(getFormatDateTime(ct));
	            }
	        }else {
	            endDateInput.val(getFormatDateTime(ct));
	        }
	    },
	    onSelectDate: function(ct, $i){
	        $("#dateEnd").datetimepicker('setOptions', { minDate: ct });
	        $("#dateEnd").datetimepicker('setOptions', { minTime: ct });
	    },
	    onSelectTime: function(ct, $i){
	        $("#dateEnd").datetimepicker('setOptions', { minDate: ct });
	        $("#dateEnd").datetimepicker('setOptions', { minTime: ct });
	    }		
	});

}

function thisYear() {
    var now = new Date();
    return now.getFullYear();
}

//오늘날짜 년-월-일
function todayDate(){
	var now = new Date();
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d; 
}

//어제날짜 년-월-일
function yesterDate(){
	var now = new Date();
	now.setDate(now.getDate()-1);
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d; 	
}

//일주일전날짜 년-월-일
function beforeWeekDate(){
	var now = new Date();
	now.setDate(now.getDate() - 7);
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d; 	
}

//한달전날짜 년-월-일
function beforeMonthDate(){
	var now = new Date();
	now.setMonth(now.getMonth() - 1);
	var y = now.getFullYear();
	var m = paddingZero(now.getMonth()+1);
	var d = paddingZero(now.getDate());
		
	return y+"-"+m+"-"+d; 	
}

//현재시간
function nowTime(){
	var now = new Date();
	var h = paddingZero(now.getHours());
	var m = paddingZero(now.getMinutes());
	var s = paddingZero(now.getSeconds());
		
	return h+":"+m+":"+s; 
}

//현재시간 +1
function nowTimeAfterOne(){
	var now = new Date();
	now.setHours(now.getHours()+1);
	var h = paddingZero(now.getHours());
	var m = paddingZero(now.getMinutes());
	var s = paddingZero(now.getSeconds());
		
	return h+":"+m+":"+s; 
}

//왼쪽 0채우기
function paddingZero(value){
	var rtn = "";

	if(value < 10){
		rtn = "0"+value;
	}else{
		rtn = value;
	}

	return rtn;
}

function trendStime(){
	var now = new Date();
	now.setHours(now.getHours() - 8);
	
	var ye = now.getFullYear();
	var mo = paddingZero(now.getMonth()+1);
	var da = paddingZero(now.getDate());
	
	var ho = paddingZero(now.getHours());
	var mi = paddingZero(now.getMinutes());
		
	return ye+"-"+mo+"-"+da+" "+ho+":"+mi; 
}

function trendEtime(){
	var now = new Date();
	var ye = now.getFullYear();
	var mo = paddingZero(now.getMonth()+1);
	var da = paddingZero(now.getDate());
	
	var ho = paddingZero(now.getHours());
	var mi = paddingZero(now.getMinutes());
		
	return ye+"-"+mo+"-"+da+" "+ho+":"+mi; 
}

function rpImagePopup() {
	var img = document.createElement("img");
	
	$(img).css("width", "600");
	$(img).css("height", "500");
	
	var div = document.createElement("div");
	$(div).css("position", "absolute");
	$(div).css("display", "none");
	$(div).css("z-index", "24999");
	$(div).append(img);
	$(div).hide();
	$("body").append(div);

	$(document).on("mouseover", ".rp-img-popup > img", function(){
			$(img).attr("src", $(this).attr("src"));
			$(div).show();
			var iHeight = (document.body.clientHeight / 2) - $(img).height() / 2 + document.body.scrollTop;
			var iWidth = (document.body.clientWidth / 2) - $(img).width() / 2 + document.body.scrollLeft;
			$(div).css("left", iWidth);
			$(div).css("top", 100);
		})
		.on("mouseout", ".rp-img-popup > img", function(){
			$(div).hide();
		});
	
	$(document).on("mouseover", ".rp-img-popup", function(){
		$(img).attr("src", $(this).attr("src"));
		$(div).show();
		var iHeight = (document.body.clientHeight / 2) - $(img).height() / 2 + document.body.scrollTop;
		var iWidth = (document.body.clientWidth / 2) - $(img).width() / 2 + document.body.scrollLeft;
		$(div).css("left", iWidth);
		$(div).css("top", 100);
	})
	.on("mouseout", ".rp-img-popup", function(){
		$(div).hide();
	});
}

function pageObject(paramKey){
	var obj = {
		"a01":["/tkheat/product/ipgo","입고관리"],
		"a02":["/tkheat/product/chulgo","출고관리"],
		"a03":["/tkheat/product/pJaegoStatus","제품별재고현황"],
		"a04":["/tkheat/product/chulgoWaiting","출고대기현황"],
		"a05":["/tkheat/product/workStatus","공정작업현황"],
		"a06":["/tkheat/product/jaegoStatus","재고현황(상세정보)"],
		"a07":["/tkheat/product/ipChulDelete","입출고삭제현황"],
		
		"b01":["/tkheat/production/workInstruction","작업지시"],
		"b02":["/tkheat/production/workStatus","작업현황"],
		"b03":["/tkheat/production/prodWaitingStatus","생산대기현황"],
		"b04":["/tkheat/production/lotIpgo","LOT추적관리(입고)"],
		"b05":["/tkheat/production/lotHeat","LOT추적관리(열처리LOT)"],
		"b06":["/tkheat/production/workInstructionTk","작업지시NEW"],
		"b07":["/tkheat/production/lotReport","LOT보고서"],
		
		"c01":["/tkheat/process/cleanSiljuk","전세정작업실적"],
		"c02":["/tkheat/process/chimSiljuk","침탄작업실적"],
		"c03":["/tkheat/process/temSiljuk","템퍼링작업실적"],
		"c04":["/tkheat/process/cleanRwSiljuk","후세정작업실적"],
		"c05":["/tkheat/process/shortSiljuk","쇼트/샌딩작업실적"],
		"c06":["/tkheat/process/facSiljuk","설비별작업실적"],
		"c07":["/tkheat/process/readySiljuk","준비작업실적"],
		
		"d01":["/tkheat/monitoring/overView","설비모니터링"],
		"d02":["/tkheat/monitoring/alarm1","실시간알람현황"],
		"d03":["/tkheat/monitoring/trend","트렌드"],
		"d04":["/tkheat/monitoring/alarmHistory","알람내역"],
		"d05":["/tkheat/monitoring/alarmRanking","알람랭킹"],
		
		"e01":["/tkheat/preservation/sparePart","SparePart관리"],
		"e02":["/tkheat/preservation/begaInsert","설비비가동등록"],
		"e03":["/tkheat/preservation/begaAnaly","설비가동율분석"],
		"e04":["/tkheat/preservation/suriHistory","설비수리이력관리"],
		"e05":["/tkheat/preservation/jeomgeomInsert","설비점검기준등록"],
		"e06":["/tkheat/preservation/dayJeomgeom","설비별점검현황(일별)"],
		"e07":["/tkheat/preservation/monthJeomgeom","설비별점검현황(월별)"],
		"e08":["/tkheat/preservation/gigiGojang","측정기기고장이력"],
		
		"f01":["/tkheat/quality/suip","수입검사"],
		"f02":["/tkheat/quality/nonInsert","부적합등록"],
		"f03":["/tkheat/quality/xBar","Xbar-R관리도"],
		"f04":["/tkheat/quality/jajuStatus","자주검사불량현황"],
		"f05":["/tkheat/quality/queHard","소입경도현황"],
		"f06":["/tkheat/quality/temHard","템퍼링경도현황"],
		
		"g01":["/tkheat/operation/pIpgoStatus","제품별입고현황"],
		"g02":["/tkheat/operation/pChulgoStatus","제품별출고현황"],
		"g03":["/tkheat/operation/prodSiljuk","제품별작업실적"],
		"g04":["/tkheat/operation/cuIpgoStatus","거래처별입고현황"],
		"g05":["/tkheat/operation/cuChulgoStatus","거래처별출고현황"],
		"g06":["/tkheat/operation/monthSale","월매출현황(마감)"],
		"g07":["/tkheat/operation/monthBul","월별불량현황"],
		"g08":["/tkheat/operation/yearSale","년간매출현황"],
		"g09":["/tkheat/operation/notice","공지사항"],
		"g10":["/tkheat/operation/cuMonthBul","월별거래처별불량현황"],
		
		"h01":["/tkheat/management/productInsert","제품등록"],
		"h02":["/tkheat/management/cutumInsert","거래처등록"],
		"h03":["/tkheat/management/facInsert","설비등록"],
		"h04":["/tkheat/management/chimStandard","침탄로작업표준"],
		"h05":["/tkheat/management/userinsert","작업자등록"],
		"h06":["/tkheat/management/authority","사원별권한등록"],
		"h07":["/tkheat/management/measurement","측정기기관리"],
		
		"i01":["/tkheat/workilbo/danch","적재"],
		"i02":["/tkheat/workilbo/preWash","전세척"],
		"i03":["/tkheat/workilbo/heat","열처리"],
		"i04":["/tkheat/workilbo/rearWash","후세정"],
		"i05":["/tkheat/workilbo/shot","쇼트"],
		"i06":["/tkheat/workilbo/tempering","템퍼링"],
		"i07":["/tkheat/workilbo/final","최종검사"],
		"i08":["/tkheat/workilbo/bang","방청"],
		"i09":["/tkheat/workilbo/pojang","포장"],
	};
	
	return obj[paramKey];
}

//권한부여로직

let userPermissions = {};

// 등록 사용자 권한 조회
function userInfoList(now_page_code) {
	console.log("권한 체크 시작 - 페이지 코드:", now_page_code);
	
	$.ajax({
		url: '/tkheat/user/info',
		type: 'POST',
		contentType: 'application/json',
		dataType: 'json',
		success: function(response) {
			console.log("권한 조회 성공:", response);
			
			const loginUserPage = response.loginUserPage;
			userPermissions = loginUserPage || {};
			
			console.log("전체 권한 정보:", userPermissions);
			console.log("현재 페이지 권한:", userPermissions[now_page_code]);
			
			
			controlButtonPermissions(now_page_code);
		},
		error: function(xhr, status, error) {
			console.error("권한 조회 실패:", error);
			console.error("응답:", xhr.responseText);
		}
	});
}


function controlButtonPermissions(now_page_code) {
	const permission = userPermissions?.[now_page_code];
	console.log("현재 페이지 권한:", permission);

	
	// N: 없음 (페이지 안보임)
	// R: 조회만
	// I: 저장까지
	// U: 수정까지
	// D: 삭제까지 (최고등급)

	const canRead = ['R', 'I', 'U', 'D'].includes(permission);
	const canCreate = ['I', 'U', 'D'].includes(permission);
	const canUpdate = ['U', 'D'].includes(permission);
	const canDelete = ['D'].includes(permission);

	console.log("권한 체크 결과:", {
		permission: permission,
		canRead: canRead,
		canCreate: canCreate,
		canUpdate: canUpdate,
		canDelete: canDelete
	});

	//조회
	if (!canRead) {
		console.log("조회 권한 없음");
		$(".select-button").prop("disabled", true)
			.css({
				"pointer-events": "none",
				"background-color": "#ced4da",
				"opacity": "0.5",
				"cursor": "not-allowed"
			});
	} else {
		console.log("조회 권한 있음");
	}

	//저장
	if (!canCreate) {
		console.log("등록 권한 없음");
		$(".insert-button").prop("disabled", true)
			.css({
				"pointer-events": "none",
				"background-color": "#ced4da",
				"opacity": "0.5",
				"cursor": "not-allowed"
			});
	} else {
		console.log("등록 권한 있음");
	}

	//삭제
	if (!canDelete) {
		console.log("삭제 권한 없음");
		$(".delete, .btn-delete").prop("disabled", true)
			.css({
				"pointer-events": "none",
				"background-color": "#ced4da",
				"opacity": "0.5",
				"cursor": "not-allowed"
			});
	} else {
		console.log("삭제 권한 있음");
	}

	//수정 (더블클릭)
	if (!canUpdate) {
		window.disableRowDblClick = true;
		console.log("더블클릭(수정) 기능 비활성화");
	} else {
		window.disableRowDblClick = false;
		console.log("더블클릭(수정) 기능 활성화");
	}

	//버튼별 알림
	// 조회 버튼
	$(".select-button").off("click.permission").on("click.permission", function (e) {
		if (!canRead) {
			alert("조회 권한이 없습니다.");
			e.preventDefault();
			e.stopImmediatePropagation();
			return false;
		}
	});

	// 등록 버튼
	$(".insert-button").off("click.permission").on("click.permission", function (e) {
		if (!canCreate) {
			alert("등록 권한이 없습니다.");
			e.preventDefault();
			e.stopImmediatePropagation();
			return false;
		}
	});

	// 삭제 버튼
	$(".delete, .btn-delete").off("click.permission").on("click.permission", function (e) {
		if (!canDelete) {
			alert("삭제 권한이 없습니다.");
			e.preventDefault();
			e.stopImmediatePropagation();
			return false;
		}
	});
}

//최초 로드시
$(document).ready(function() {
	if (typeof now_page_code !== 'undefined' && now_page_code !== '') {
		console.log("페이지 로드 - 현재 페이지 코드:", now_page_code);
		userInfoList(now_page_code);
	} else {
		console.warn("now_page_code 추가필요.");
	}
});

</script>