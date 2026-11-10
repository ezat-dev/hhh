<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>납기준수율</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %>
    <style>
/* ========== 기본 스타일 ========== */
.main { width: 98%; }
.tabulator { width: 100%; max-width: 100%; overflow-x: hidden !important; }
.tabulator .tabulator-cell { white-space: normal !important; word-break: break-word; text-align: center; }
.row_select { background-color: #9ABCEA !important; }

.box1 {
    display: flex; justify-content: right; align-items: center;
    width: 1500px; margin-left: -610px; gap: 10px;
}
.box1 input[type="date"] {
    width: 150px; padding: 5px 10px; font-size: 16px;
    border: 1px solid #ccc; border-radius: 6px;
    background-color: #f9f9f9; color: #333;
    outline: none; transition: border 0.3s ease;
}
.box1 input[type="text"] {
    width: 160px; padding: 5px 10px; font-size: 16px;
    border: 1px solid #ccc; border-radius: 6px;
    background-color: #f9f9f9; color: #333;
    outline: none; transition: border 0.3s ease;
}
.box1 input:focus { border: 1px solid #007bff; background-color: #fff; }
.box1 label, .box1 input { margin-right: 10px; }

/* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
html, body { height: 100%; margin: 0; }
body { display: flex; flex-direction: column; overflow: hidden; }
.tab { flex-shrink: 0; }
.main {
    flex: 1;
    min-height: 0;
    display: flex;
    flex-direction: column;
    padding: 8px;
    overflow: hidden;
}

/* ========== 상단 도구바 ========== */
.tab {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 0 14px;
}
.button-container .select-button,
.button-container .excel-button {
    height: 34px;
    border: 1px solid #E2E8F0;
    border-radius: 8px;
    background: #F0F4F8;
    transition: background-color .13s, border-color .13s;
}
.button-container .select-button:hover,
.button-container .excel-button:hover {
    background: #EBF8FF;
    border-color: #BEE3F8;
}

/* ========== 리스트 영역(다른 현황 페이지와 동일한 카드 스타일) ========== */
h4 { margin: 10px 0 6px 4px; color: #2D3748; }
h4 .sub { font-size: 12px; font-weight: 400; color: #718096; margin-left: 8px; }
.container,
.container2 {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 8px;
    overflow: hidden;
}
.container { flex: 0.5; min-height: 0; margin-bottom: 4px; }
.container2 { flex: 1.5; min-height: 0; }
#tab1, #tab2 { height: 100%; }
    </style>
</head>

    <body>

    <div class="tab">
     <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>

        <label class="daylabel">기간(입고일) : </label>
        <input type="date" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off"> ~
        <input type="date" class="edate" id="edate" style="font-size: 16px;" autocomplete="off">

        <label class="daylabel">거래처 : </label>
        <input type="text" id="s_corp_name" placeholder="거래처명 검색" autocomplete="off">

    </div>
    <div class="button-container">
        <button class="select-button" onclick="getDeliveryRateList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
        엑셀
        </button>
    </div>
</div>
    <main class="main">
        <h4>납기준수율 요약<span class="sub">납기준수율(%)=납기이행건수÷(출고완료+기한초과미출고)×100 — 출고예정일이 아직 안 지난 미출고(진행중) 건은 분모에서 제외(정상 진행중인 주문이 준수율을 끌어내리지 않도록) | 지연건수=늦게 출고된 건+기한초과 미출고 | 전량 출고되기 전까지는 미완료로 집계</span></h4>
        <div class="container">
            <div id="tab1" class="tabulator"></div>
        </div>
        <h4>거래처별 납기현황<span class="sub">입고일 기준으로 대상을 선정하고, 실제 출고일은 기간과 무관하게 반영</span></h4>
        <div class="container2">
            <div id="tab2" class="tabulator"></div>
        </div>
    </main>


<script>
    let now_page_code = "f09";
    var deliverySummaryTable;
    var deliveryCorpTable;

    $(function(){
        if (typeof userInfoList === 'function') {
            userInfoList(now_page_code);
        }

        var today = new Date();
        var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
        $("#sdate").val(formatDateYMD(firstDay));
        $("#edate").val(formatDateYMD(today));

        getDeliveryRateList();

        //엔터키로 바로 조회
        $("#s_corp_name").on("keydown", function(e){
            if(e.key === "Enter"){ e.preventDefault(); getDeliveryRateList(); }
        });
    });

    function formatDateYMD(d){
        if(!d){ d = new Date(); }
        var y = d.getFullYear();
        var m = ("0" + (d.getMonth()+1)).slice(-2);
        var day = ("0" + d.getDate()).slice(-2);
        return y + "-" + m + "-" + day;
    }

    //시간(hour) 값을 "N일 M시간" 형식으로 표시(부호는 그대로 유지)
    function formatHours(value){
        var h = Number(value);
        if (isNaN(h)) { return "-"; }
        var sign = h < 0 ? "-" : "";
        var abs = Math.abs(h);
        var days = Math.floor(abs / 24);
        var rem = Math.round(abs % 24);
        if (days > 0) {
            return sign + days + "일 " + rem + "시간";
        }
        return sign + rem + "시간";
    }

    //납기준수율(%) 배지 — 준수율은 높을수록 좋으므로 지연율과 반대 방향 색상
    function complianceRateCellFormatter(cell){
        const el = cell.getElement();
        const value = Number(cell.getValue());
        el.style.fontWeight = "bold";

        if (isNaN(value)) { return ""; }

        if (value < 70) {
            el.style.backgroundColor = "#e74c3c";
            el.style.color = "#fff";
        } else if (value < 90) {
            el.style.backgroundColor = "#f1c40f";
            el.style.color = "#000";
        } else {
            el.style.backgroundColor = "#2ecc71";
            el.style.color = "#fff";
        }

        return value.toLocaleString() + "%";
    }

    //불량현황의 PPM 배지와 동일한 톤으로 지연율 심각도 표시(지연율이 높을수록 경고색)
    function lateRateCellFormatter(cell){
        const el = cell.getElement();
        const value = Number(cell.getValue());
        el.style.fontWeight = "bold";

        if (isNaN(value)) { return ""; }

        if (value >= 30) {
            el.style.backgroundColor = "#e74c3c"; // 빨간색
            el.style.color = "#fff";
        } else if (value >= 10) {
            el.style.backgroundColor = "#f1c40f"; // 노란색
            el.style.color = "#000";
        } else {
            el.style.backgroundColor = "#ffffff";
            el.style.color = "#000";
        }

        return value.toLocaleString() + "%";
    }

    function getDeliveryRateList(){
        getDeliverySummaryList();
        getDeliveryCorpList();
    }

    // ========== 납기준수율 요약(단일 행) ==========
    function getDeliverySummaryList(){
        if (deliverySummaryTable) { deliverySummaryTable.destroy(); deliverySummaryTable = null; }
        $('#tab1').empty();

        deliverySummaryTable = new Tabulator("#tab1", {
            height:"100%",
            layout:"fitColumns",
            tooltips:true,
            reactiveData:true,
            headerSort:false,
            headerHozAlign:"center",
            ajaxConfig:"POST",
            ajaxLoader:false,
            ajaxURL:"/tkheat/quality/deliveryRate/getDeliverySummary",
            ajaxParams:{
                "sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
                "corp_name": $("#s_corp_name").val(),
            },
            placeholder:"조회된 데이터가 없습니다.",
            ajaxResponse:function(url, params, response){
                return response.data ? response.data : [];
            },
            columns:[
                {title:"대상 주문건수", field:"total_cnt", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}},
                {title:"출고완료", field:"shipped_cnt", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}},
                {title:"미출고(진행중)", field:"not_shipped_cnt", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}},
                {title:"기한초과 미출고", field:"overdue_unshipped_cnt", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}},
                {title:"평균 납기편차", field:"avg_gap_hours", hozAlign:"center",
                    formatter:function(cell){ return formatHours(cell.getValue()); }},
                {title:"지연 건수", field:"late_cnt", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}},
                {title:"지연율(%)", field:"late_rate", hozAlign:"center", formatter:lateRateCellFormatter},
                {title:"납기준수율(%)", field:"compliance_rate", hozAlign:"center", formatter:complianceRateCellFormatter},
                {title:"정시/조기 건수", field:"ontime_cnt", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}},
                {title:"지연건 평균 지연시간", field:"avg_late_hours", hozAlign:"center",
                    formatter:function(cell){ return formatHours(cell.getValue()); }},
            ],
        });
    }

    // ========== 거래처별 납기현황 ==========
    function getDeliveryCorpList(){
        if (deliveryCorpTable) { deliveryCorpTable.destroy(); deliveryCorpTable = null; }
        $('#tab2').empty();

        deliveryCorpTable = new Tabulator("#tab2", {
            height:"100%",
            layout:"fitColumns",
            tooltips:true,
            reactiveData:true,
            headerSort:false,
            headerHozAlign:"center",
            ajaxConfig:"POST",
            ajaxLoader:false,
            ajaxURL:"/tkheat/quality/deliveryRate/getDeliveryCorpList",
            ajaxParams:{
                "sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
                "corp_name": $("#s_corp_name").val(),
            },
            placeholder:"조회된 데이터가 없습니다.",
            ajaxResponse:function(url, params, response){
                return response.data ? response.data : [];
            },
            columns:[
                {title:"NO", field:"row_num", width:55, hozAlign:"center"},
                {title:"거래처", field:"corp_name", hozAlign:"center", minWidth:140},
                {title:"대상건수", field:"total_cnt", hozAlign:"center", width:100,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"출고완료", field:"shipped_cnt", hozAlign:"center", width:100,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"미출고(진행중)", field:"not_shipped_cnt", hozAlign:"center", width:100,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"기한초과 미출고", field:"overdue_unshipped_cnt", hozAlign:"center", width:110,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"지연건수", field:"late_cnt", hozAlign:"center", width:90,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"지연율(%)", field:"late_rate", hozAlign:"center", width:100, formatter:lateRateCellFormatter},
                {title:"납기준수율(%)", field:"compliance_rate", hozAlign:"center", width:110, formatter:complianceRateCellFormatter},
                {title:"평균 납기편차", field:"avg_gap_hours", hozAlign:"center", minWidth:130,
                    formatter:function(cell){ return formatHours(cell.getValue()); }},
            ],
            rowClick:function(e, row){
                $("#tab2 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
                row.getElement().classList.add("row_select");
            },
        });
    }

    // ========== 엑셀 다운로드(두 표 한 파일에 시트로) ==========
    $(".excel-button").click(function () {
        if (!deliverySummaryTable || !deliveryCorpTable) return;
        const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");

        const ws1 = XLSX.utils.aoa_to_sheet([]);
        const cols1 = deliverySummaryTable.getColumnDefinitions().filter(c => c.visible !== false);
        XLSX.utils.sheet_add_aoa(ws1, [cols1.map(c => c.title)], { origin: 0 });
        const rows1 = deliverySummaryTable.getData().map(row => cols1.map(c => row[c.field]));
        XLSX.utils.sheet_add_aoa(ws1, rows1, { origin: 1 });

        const ws2 = XLSX.utils.aoa_to_sheet([]);
        const cols2 = deliveryCorpTable.getColumnDefinitions().filter(c => c.visible !== false);
        XLSX.utils.sheet_add_aoa(ws2, [cols2.map(c => c.title)], { origin: 0 });
        const rows2 = deliveryCorpTable.getData().map(row => cols2.map(c => row[c.field]));
        XLSX.utils.sheet_add_aoa(ws2, rows2, { origin: 1 });

        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws1, "납기준수율요약");
        XLSX.utils.book_append_sheet(wb, ws2, "거래처별납기현황");
        XLSX.writeFile(wb, "납기준수율_" + today + ".xlsx");
    });

</script>

    </body>
</html>
