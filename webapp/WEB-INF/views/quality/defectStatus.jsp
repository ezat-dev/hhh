<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>불량현황</title>
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
.box1 select {
    padding: 5px 10px; font-size: 16px;
    border: 1px solid #ccc; border-radius: 6px;
    background-color: #f9f9f9; color: #333;
}
.box1 input:focus, .box1 select:focus { border: 1px solid #007bff; background-color: #fff; }
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
.container0 {
    background: #ffffff;
    border: 1px solid #E2E8F0;
    border-radius: 10px;
    box-shadow: 0 1px 4px rgba(0,0,0,.06);
    padding: 8px;
    overflow: hidden;
    flex: 0.6;
    min-height: 0;
    margin-bottom: 4px;
}
.container { flex: 1.4; min-height: 0; margin-bottom: 4px; }
.container2 { flex: 1; min-height: 0; }
#tab0, #tab1, #tab2 { height: 100%; }
    </style>
</head>

    <body>

    <div class="tab">
     <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>

        <label class="daylabel">기간 : </label>
        <input type="date" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off"> ~
        <input type="date" class="edate" id="edate" style="font-size: 16px;" autocomplete="off">

        <label class="daylabel">거래처 : </label>
        <input type="text" id="s_corp_name" placeholder="거래처명 검색" autocomplete="off">

        <label class="daylabel">구분 : </label>
        <select id="s_inoutgubn" autocomplete="off">
            <option value="">전체</option>
            <option value="사내">사내</option>
            <option value="사외">사외</option>
        </select>

    </div>
    <div class="button-container">
        <button class="select-button" onclick="getDefectStatusList();">
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
        <h4>전체 불량현황 요약<span class="sub">회사 전체(조회조건 거래처 전체) 출고수량 기준 PPM — 거래처별 표의 합계와는 분모가 다릅니다</span></h4>
        <div class="container0">
            <div id="tab0" class="tabulator"></div>
        </div>
        <h4>거래처별 불량현황<span class="sub">PPM = 불량수량 ÷ 납품수량 × 1,000,000</span></h4>
        <div class="container">
            <div id="tab1" class="tabulator"></div>
        </div>
        <h4>불량구분별 현황<span class="sub">조회조건(기간·거래처·구분) 기준 전체 합계</span></h4>
        <div class="container2">
            <div id="tab2" class="tabulator"></div>
        </div>
    </main>


<script>
    let now_page_code = "f08";
    var defectSummaryTable;
    var defectCorpTable;
    var defectGubnTable;

    $(function(){
        if (typeof userInfoList === 'function') {
            userInfoList(now_page_code);
        }

        var today = new Date();
        var firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
        $("#sdate").val(formatDateYMD(firstDay));
        $("#edate").val(formatDateYMD(today));

        getDefectStatusList();

        //엔터키로 바로 조회
        $("#s_corp_name").on("keydown", function(e){
            if(e.key === "Enter"){ e.preventDefault(); getDefectStatusList(); }
        });
    });

    function formatDateYMD(d){
        if(!d){ d = new Date(); }
        var y = d.getFullYear();
        var m = ("0" + (d.getMonth()+1)).slice(-2);
        var day = ("0" + d.getDate()).slice(-2);
        return y + "-" + m + "-" + day;
    }

    //다른 품질관리 현황 페이지(소입경도현황 등)와 동일한 배지 스타일(배경색 채움)로 PPM 심각도 표시
    function ppmCellFormatter(cell){
        const el = cell.getElement();
        const value = Number(cell.getValue());
        el.style.fontWeight = "bold";

        if (isNaN(value)) { return ""; }

        if (value >= 1000) {
            el.style.backgroundColor = "#e74c3c"; // 빨간색
            el.style.color = "#fff";
        } else if (value >= 300) {
            el.style.backgroundColor = "#f1c40f"; // 노란색
            el.style.color = "#000";
        } else {
            el.style.backgroundColor = "#ffffff";
            el.style.color = "#000";
        }

        return value.toLocaleString();
    }

    function getDefectStatusList(){
        getDefectStatusSummaryTable();
        getDefectStatusCorpList();
        getDefectStatusGubnList();
    }

    // ========== 전체 불량현황 요약(회사 전체 PPM) ==========
    function getDefectStatusSummaryTable(){
        if (defectSummaryTable) { defectSummaryTable.destroy(); defectSummaryTable = null; }
        $('#tab0').empty();

        defectSummaryTable = new Tabulator("#tab0", {
            height:"100%",
            layout:"fitColumns",
            tooltips:true,
            reactiveData:true,
            headerSort:false,
            headerHozAlign:"center",
            ajaxConfig:"POST",
            ajaxLoader:false,
            ajaxURL:"/tkheat/quality/defectStatus/getDefectStatusSummary",
            ajaxParams:{
                "sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
                "inoutgubn": $("#s_inoutgubn").val(),
                "corp_name": $("#s_corp_name").val(),
            },
            placeholder:"조회된 데이터가 없습니다.",
            ajaxResponse:function(url, params, response){
                return response.data ? response.data : [];
            },
            columns:[
                {title:"전체 출고수량", field:"och_su", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"전체 불량수량", field:"werr_su", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"전체 PPM", field:"ppm_total", hozAlign:"center", formatter:ppmCellFormatter},
                {title:"전체 납품금액", field:"och_mon", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"전체 불량금액", field:"werr_mon", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"전체 불량금액률(%)", field:"ppm_mon", hozAlign:"center",
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:2}
                },
            ],
        });
    }

    // ========== 거래처별 불량현황(PPM) ==========
    function getDefectStatusCorpList(){
        if (defectCorpTable) { defectCorpTable.destroy(); defectCorpTable = null; }
        $('#tab1').empty();

        defectCorpTable = new Tabulator("#tab1", {
            height:"100%",
            layout:"fitColumns",
            tooltips:true,
            reactiveData:true,
            headerSort:false,
            headerHozAlign:"center",
            ajaxConfig:"POST",
            ajaxLoader:false,
            ajaxURL:"/tkheat/quality/defectStatus/getDefectStatusCorpList",
            ajaxParams:{
                "sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
                "inoutgubn": $("#s_inoutgubn").val(),
                "corp_name": $("#s_corp_name").val(),
            },
            placeholder:"조회된 불량 데이터가 없습니다.",
            ajaxResponse:function(url, params, response){
                return response.data ? response.data : [];
            },
            columns:[
                {title:"NO", field:"row_num", width:55, hozAlign:"center"},
                {title:"거래처", field:"corp_name", hozAlign:"center", minWidth:140},
                {title:"납품수량", field:"och_su", hozAlign:"center", width:110,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"불량수량", field:"werr_su", hozAlign:"center", width:110,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"PPM", field:"ppm", hozAlign:"center", width:100, formatter:ppmCellFormatter},
                {title:"납품금액", field:"och_mon", hozAlign:"center", width:130,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"불량금액", field:"werr_mon", hozAlign:"center", width:130,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"불량금액률(%)", field:"ppm_mon", hozAlign:"center", width:110,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:2}
                },
                {title:"불량내역", field:"werr_detail", hozAlign:"left", minWidth:220, tooltip:true},
            ],
            rowClick:function(e, row){
                $("#tab1 .tabulator-tableHolder > .tabulator-table > .tabulator-row").removeClass('row_select');
                row.getElement().classList.add("row_select");
            },
        });
    }

    // ========== 불량구분별 현황 ==========
    function getDefectStatusGubnList(){
        if (defectGubnTable) { defectGubnTable.destroy(); defectGubnTable = null; }
        $('#tab2').empty();

        defectGubnTable = new Tabulator("#tab2", {
            height:"100%",
            layout:"fitColumns",
            tooltips:true,
            reactiveData:true,
            headerSort:false,
            headerHozAlign:"center",
            ajaxConfig:"POST",
            ajaxLoader:false,
            ajaxURL:"/tkheat/quality/defectStatus/getDefectStatusGubnList",
            ajaxParams:{
                "sdate": $("#sdate").val(),
                "edate": $("#edate").val(),
                "inoutgubn": $("#s_inoutgubn").val(),
                "corp_name": $("#s_corp_name").val(),
            },
            placeholder:"조회된 불량 데이터가 없습니다.",
            ajaxResponse:function(url, params, response){
                var data = response.data ? response.data : [];
                //전체 대비 비율(%)은 화면에서 직접 계산(불량수량 합계 기준)
                var total = data.reduce(function(acc, r){
                    var v = Number(r.werr_su);
                    return acc + (isNaN(v) ? 0 : v);
                }, 0);
                data.forEach(function(r){
                    var v = Number(r.werr_su);
                    r.ratio = total > 0 ? Math.round((isNaN(v) ? 0 : v) / total * 1000) / 10 : 0;
                });
                return data;
            },
            columns:[
                {title:"NO", field:"row_num", width:55, hozAlign:"center"},
                {title:"불량구분", field:"werr_gubn", hozAlign:"center", minWidth:140},
                {title:"불량수량", field:"werr_su", hozAlign:"center", width:120,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"불량금액", field:"werr_mon", hozAlign:"center", width:140,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:0},
                    bottomCalc:"sum", bottomCalcFormatter:"money", bottomCalcFormatterParams:{decimal:".", thousand:",", precision:0}
                },
                {title:"비율(%)", field:"ratio", hozAlign:"center", width:110,
                    formatter:"money", formatterParams:{decimal:".", thousand:",", precision:1}
                },
            ],
        });
    }

    // ========== 엑셀 다운로드(두 표 한 파일에 시트로) ==========
    $(".excel-button").click(function () {
        if (!defectSummaryTable || !defectCorpTable || !defectGubnTable) return;
        const today = new Date().toISOString().slice(0, 10).replace(/-/g, "");

        const ws0 = XLSX.utils.aoa_to_sheet([]);
        const cols0 = defectSummaryTable.getColumnDefinitions().filter(c => c.visible !== false);
        XLSX.utils.sheet_add_aoa(ws0, [cols0.map(c => c.title)], { origin: 0 });
        const rows0 = defectSummaryTable.getData().map(row => cols0.map(c => row[c.field]));
        XLSX.utils.sheet_add_aoa(ws0, rows0, { origin: 1 });

        const ws1 = XLSX.utils.aoa_to_sheet([]);
        const cols1 = defectCorpTable.getColumnDefinitions().filter(c => c.visible !== false);
        XLSX.utils.sheet_add_aoa(ws1, [cols1.map(c => c.title)], { origin: 0 });
        const rows1 = defectCorpTable.getData().map(row => cols1.map(c => row[c.field]));
        XLSX.utils.sheet_add_aoa(ws1, rows1, { origin: 1 });

        const ws2 = XLSX.utils.aoa_to_sheet([]);
        const cols2 = defectGubnTable.getColumnDefinitions().filter(c => c.visible !== false);
        XLSX.utils.sheet_add_aoa(ws2, [cols2.map(c => c.title)], { origin: 0 });
        const rows2 = defectGubnTable.getData().map(row => cols2.map(c => row[c.field]));
        XLSX.utils.sheet_add_aoa(ws2, rows2, { origin: 1 });

        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws0, "전체요약");
        XLSX.utils.book_append_sheet(wb, ws1, "거래처별불량현황");
        XLSX.utils.book_append_sheet(wb, ws2, "불량구분별현황");
        XLSX.writeFile(wb, "불량현황_" + today + ".xlsx");
    });

</script>

    </body>
</html>
