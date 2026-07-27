<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 제이쿼리홈페이지 js -->
<script type="text/javascript" src="/tkheat/js/jquery-3.7.1.min.js"></script>

<!-- Tabulator 테이블 -->
<script type="text/javascript" src="/tkheat/js/tabulator/tabulator.js"></script>
<link rel="stylesheet" href="/tkheat/css/tabulator/tabulator_simple.css">

<script>
//등록/수정/삭제 후 리스트를 다시 그릴 때(new Tabulator(...)로 재생성) 사용자가 설정한 페이지 크기/현재 페이지가
//초기화되던 문제 -> Tabulator 자체 내장 persistence 기능을 모든 로컬 페이징 테이블에 자동으로 적용해서
//페이지를 새로고침하지 않는 한(같은 브라우저 세션 내) 항상 마지막 설정을 기억하도록 함.
//(개별 페이지 JSP 코드는 전혀 수정하지 않고, Tabulator 생성자를 감싸는 방식으로 전체 앱에 일괄 적용)
//날짜/시간 표시가 "년-월-일 시:분:초"(또는 ISO 형식)로 그대로 나와 불필요하게 길어보이던 문제 ->
//커스텀 formatter가 없는(=서버값을 그대로 보여주는) 컬럼에 한해, 화면 표시만 "년-월-일 시:분"까지로 잘라줌
//(정렬/getData() 등 실제 데이터 값 자체는 그대로 유지 - 순수 표시상의 문제만 해결)
function tkheatTruncateSeconds(text){
	if(typeof text !== 'string'){ return text; }
	return text.replace(/(\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}):\d{2}(\.\d+)?(Z|[+-]\d{2}:?\d{2})?/g, '$1');
}

function tkheatWrapColumnsForDateTruncation(columns){
	if(!columns){ return; }
	columns.forEach(function(col){
		if(col.columns){
			tkheatWrapColumnsForDateTruncation(col.columns);
			return;
		}
		//이미 커스텀 formatter가 지정된 컬럼은 작성자의 의도를 존중해 건드리지 않음
		//editor:true(불리언) 컬럼은 Tabulator가 "커스텀 formatter가 없을 때만" 에디터를 자동 매칭하므로,
		//여기서 formatter를 넣어버리면 클릭해도 편집모드가 전혀 시작되지 않게 됨 -> 이런 컬럼은 건드리지 않음
		if(typeof col.formatter === 'undefined' && col.editor !== true){
			col.formatter = function(cell){
				return tkheatTruncateSeconds(cell.getValue());
			};
		}
	});
}

(function(){
	if(typeof Tabulator === 'undefined'){ return; }
	var OriginalTabulator = Tabulator;

	function TabulatorWithPagingMemory(element, options){
		options = options || {};
		//로컬 페이징(사용자가 페이지 크기를 직접 선택하는 목록)만 대상 - 서버사이드/스크롤 로딩 방식은 건드리지 않음
		if(options.pagination === "local" && typeof options.persistence === 'undefined'){
			var elId = (typeof element === 'string') ? element.replace(/^#/, '') : ((element && element.id) || '');
			if(elId){
				options.persistence = { page: true };
				options.persistenceID = "tkheat_pg_" + location.pathname.replace(/[^a-zA-Z0-9]/g, '_') + "_" + elId;
			}
		}
		if(options.columns){
			tkheatWrapColumnsForDateTruncation(options.columns);
		}
		return new OriginalTabulator(element, options);
	}

	TabulatorWithPagingMemory.prototype = OriginalTabulator.prototype;
	for(var k in OriginalTabulator){
		if(Object.prototype.hasOwnProperty.call(OriginalTabulator, k)){
			TabulatorWithPagingMemory[k] = OriginalTabulator[k];
		}
	}

	Tabulator = TabulatorWithPagingMemory;
	window.Tabulator = TabulatorWithPagingMemory;
})();
</script>

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

/* ========== 전역 조회중 로딩 오버레이 (ajaxStart/ajaxStop으로 자동 표시) ========== */
#globalLoadingOverlay {
	display: none;
	position: fixed;
	top: 0; left: 0; right: 0; bottom: 0;
	background: rgba(255,255,255,.55);
	z-index: 99999;
	align-items: center;
	justify-content: center;
	flex-direction: column;
}
#globalLoadingOverlay .spinner {
	width: 42px;
	height: 42px;
	border: 4px solid #BEE3F8;
	border-top-color: #3182CE;
	border-radius: 50%;
	animation: globalLoadingSpin .7s linear infinite;
}
#globalLoadingOverlay .loading-text {
	margin-top: 12px;
	font-size: 14px;
	font-weight: 700;
	color: #2B6CB0;
}
@keyframes globalLoadingSpin {
	to { transform: rotate(360deg); }
}

</style>

<script>

$(function(){
	rpImagePopup();

	//전역 조회중 오버레이: <head> 안에서 include되므로 정적 HTML 대신 body에 동적으로 추가
	if($("#globalLoadingOverlay").length === 0){
		$("body").prepend('<div id="globalLoadingOverlay"><div class="spinner"></div><div class="loading-text"></div></div>');
	}

	//전역 ajax 로딩 표시: 어떤 페이지든 조회/등록/수정/삭제 등 ajax 호출 중엔 자동으로 오버레이 표시
	var globalLoadingTimer = null;
	$(document).ajaxStart(function(){
		clearTimeout(globalLoadingTimer);
		//아주 빠르게 끝나는 요청은 깜빡임만 생기므로 살짝 지연 후 표시
		globalLoadingTimer = setTimeout(function(){
			$("#globalLoadingOverlay").css("display","flex");
		}, 150);
	});
	$(document).ajaxStop(function(){
		clearTimeout(globalLoadingTimer);
		$("#globalLoadingOverlay").css("display","none");
	});
	
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

//현재 편집중인 날짜입력칸과 짝을 이루는 종료일 입력칸을 DOM상 위치로 찾음.
//전체 앱에서 <input>~<input> 처럼 시작~종료 필드 사이에 물결(~) 텍스트가 있는 관례를 이용해서,
//중간에 다른 라벨/입력칸이 끼어있는 "서로 무관한 다음 날짜쌍"과 혼동되지 않도록 정확히 짝을 찾음.
//(페이지마다 id 이름이 달라도 항상 동작함)
function tkheatFindPairedDateEl(inputEl, direction){
	var node = direction === 'next' ? inputEl.nextSibling : inputEl.previousSibling;
	var sawTilde = false;
	while(node){
		if(node.nodeType === 3){ //텍스트 노드
			if(node.textContent.indexOf('~') !== -1){
				sawTilde = true;
			}else if(node.textContent.trim() !== ''){
				break; //물결(~) 없이 다른 텍스트가 나오면 짝이 아님
			}
		}else if(node.nodeType === 1){ //엘리먼트 노드
			if(sawTilde){
				return node;
			}
			break; //물결(~) 전에 다른 엘리먼트가 나오면 짝이 아님
		}
		node = direction === 'next' ? node.nextSibling : node.previousSibling;
	}
	return null;
}

//짝을 이루는 날짜입력칸에 제약을 건다 - 네이티브 <input type="date">의 min/max 속성과
//xdsoft 위젯이 붙어있다면 그 내부 옵션(minDate/minTime, maxDate/maxTime)을 동시에 갱신함.
//(일부 페이지는 <input type="date">에 xdsoft 클래스도 같이 붙어있어 실제로 어느 쪽 달력 UI가
// 뜨는지 확실치 않으므로, 두 메커니즘을 전부 갱신해서 어느 쪽이든 항상 정확히 막히도록 함)
//Date 객체나 문자열 어느 쪽이 들어와도 네이티브 <input type="date">의 min/max 속성에 쓸 수 있는
//"YYYY-MM-DD" 문자열로 정규화
function tkheatToDateAttrString(val){
	var d = (val instanceof Date) ? val : new Date(val);
	if(isNaN(d.getTime())){
		return (typeof val === 'string') ? val.substring(0,10) : '';
	}
	var mm = ('0' + (d.getMonth()+1)).slice(-2);
	var dd = ('0' + d.getDate()).slice(-2);
	return d.getFullYear() + '-' + mm + '-' + dd;
}

//val: xdsoft 콜백에서는 Date 객체, 네이티브 change 이벤트에서는 "YYYY-MM-DD" 문자열
function tkheatConstrainPairedDate(sourceEl, direction, val){
	var targetEl = tkheatFindPairedDateEl(sourceEl, direction);
	if(!targetEl || targetEl.tagName !== 'INPUT'){ return; }

	var $target = $(targetEl);
	var isNativeDate = targetEl.type === 'date';
	var isXdsoft = !!$target.data('xdsoft_datetimepicker');
	var attrVal = tkheatToDateAttrString(val);

	if(direction === 'next'){
		//대상은 "종료일" 쪽 -> 이 값보다 이전 날짜를 선택하지 못하게 최소값 제한
		if(isNativeDate && attrVal){
			targetEl.min = attrVal;
			if(targetEl.value && targetEl.value < attrVal){ targetEl.value = attrVal; }
		}
		if(isXdsoft){
			$target.datetimepicker('setOptions', { minDate: val, minTime: val });
		}
	}else{
		//대상은 "시작일" 쪽 -> 이 값보다 이후 날짜를 선택하지 못하게 최대값 제한
		if(isNativeDate && attrVal){
			targetEl.max = attrVal;
			if(targetEl.value && targetEl.value > attrVal){ targetEl.value = attrVal; }
		}
		if(isXdsoft){
			$target.datetimepicker('setOptions', { maxDate: val, maxTime: val });
		}
	}
}

//전체 앱의 <input type="date"> 네이티브 달력 입력칸(및 xdsoft가 겹쳐 붙은 하이브리드 입력칸 포함):
//시작일 선택시 짝을 이루는 종료일의 최소값을, 종료일 선택시 짝을 이루는 시작일의 최대값을
//자동으로 걸어서 서로 어긋난 날짜를 아예 선택 못하게 막음
$(document).on('change', 'input[type="date"]', function(){
	var val = this.value;
	if(!val){ return; }
	tkheatConstrainPairedDate(this, 'next', val);
	tkheatConstrainPairedDate(this, 'prev', val);
});

function datePickerDate(){
	$(".datetimepicker_date").datetimepicker({
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		format:'Y-m-d',
		mask: true,
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
			tkheatConstrainPairedDate($i.get(0), 'next', ct);
		},
		onSelectTime: function(ct, $i){
			tkheatConstrainPairedDate($i.get(0), 'next', ct);
		}
	});
}

function datePickerDateTime(){
	$(".datetimepicker_datetime").datetimepicker({
		changeMonth: true,
		changeYear: true,
		showButtonPanel: true,
		format:'Y-m-d H:i',
		mask: true,
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
			tkheatConstrainPairedDate($i.get(0), 'next', ct);
		},
		onSelectTime: function(ct, $i){
			tkheatConstrainPairedDate($i.get(0), 'next', ct);
		}
	});
}

function datePickerMonth(){
	$(".datetimepicker_month").datetimepicker({
	    changeMonth: true,
	    changeYear: true,
	    showButtonPanel: true,
	    format:'Y-m',
	    mask: true,
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