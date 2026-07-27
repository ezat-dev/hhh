<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LOT 보고서</title>
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
	<%@include file="../include/pluginpage.jsp" %>
</head>
    <style>
        /* ========== 레이아웃 (세로 스크롤 방지, 여백 축소) ========== */
        html, body { height: 100%; margin: 0; }
        body { display: flex; flex-direction: column; overflow: hidden; }
        .tab { flex-shrink: 0; }
        .main {
            width: 100%;
            flex: 1;
            min-height: 0;
            display: flex;
            padding: 8px;
            overflow: hidden;
        }

        /* ========== 상단 도구바 (다른 페이지와 동일한 톤) ========== */
        .tab {
            background: #ffffff;
            border: 1px solid #E2E8F0;
            border-radius: 10px;
            box-shadow: 0 1px 4px rgba(0,0,0,.06);
            padding: 0 14px;
        }
        .box1 {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 8px;
        }
        .daylabel {
            font-size: 12px;
            font-weight: 600;
            color: #495057;
            white-space: nowrap;
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

        /* ========== 리스트 카드 영역 (.view 가 실제 리스트 래퍼) ========== */
        .view {
            display: flex;
            flex: 1;
            min-height: 0;
            flex-direction: column;
            background: #ffffff;
            border: 1px solid #E2E8F0;
            border-radius: 10px;
            box-shadow: 0 1px 4px rgba(0,0,0,.06);
            padding: 8px;
            overflow: hidden;
        }

        /* ========== Tabulator 리스트 ========== */
        #dataTable.tabulator {
            flex: 1;
            min-height: 0;
            width: 100%;
            min-width: 0;
            border: none;
            font-size: 12px;
        }
        #dataTable .tabulator-header {
            background: linear-gradient(135deg, #2B6CB0, #3182CE);
            border-bottom: none;
        }
        #dataTable .tabulator-col {
            background: transparent;
            border-right: 1px solid rgba(255,255,255,.15);
        }
        #dataTable .tabulator-col.tabulator-sortable:hover {
            background: rgba(255,255,255,.08);
        }
        #dataTable .tabulator-col-title {
            color: #ffffff;
            font-weight: 700;
        }
        #dataTable .tabulator-row {
            border-bottom: 1px solid #EDF2F7;
            transition: background-color .12s;
        }
        #dataTable .tabulator-row.tabulator-row-even {
            background-color: #F7FAFC;
        }
        #dataTable .tabulator-row:hover {
    background-color: #EBF8FF !important;
    box-shadow: inset 0 0 0 1px #3182CE;
}
        #dataTable .tabulator-row.row_select,
        #dataTable .tabulator-row.tabulator-selected {
    background-color: #BEE3F8 !important;
    box-shadow: inset 0 0 0 2px #2B6CB0;
}
        #dataTable .tabulator-cell {
            border: 1px solid #E2E8F0;
            color: #2D3748;
        }

        /* ========== 페이지네이션 ========== */
        #dataTable .tabulator-footer {
            background: #F7FAFC;
            border-top: 1px solid #E2E8F0;
            padding: 8px 12px;
        }
        #dataTable .tabulator-paginator {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        #dataTable .tabulator-page-size {
            border: 1px solid #E2E8F0;
            border-radius: 6px;
            padding: 4px 8px;
            font-size: 12px;
            background: #ffffff;
            color: #2D3748;
            cursor: pointer;
            margin: 0;
        }
        #dataTable .tabulator-page-size:focus {
            outline: none;
            border-color: #3182CE;
        }
        #dataTable .tabulator-pages {
            display: flex;
            gap: 4px;
            margin: 0;
        }
        #dataTable .tabulator-page {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #E2E8F0;
            border-radius: 6px;
            background: #ffffff;
            color: #2D3748;
            min-width: 30px;
            height: 28px;
            padding: 0 8px;
            font-size: 12px;
            font-weight: 600;
            margin: 0;
            transition: background-color .13s, border-color .13s, color .13s;
        }
        #dataTable .tabulator-page.active {
            background: #3182CE;
            border-color: #2B6CB0;
            color: #ffffff;
        }
        #dataTable .tabulator-page:not(:disabled):hover {
            background: #EBF8FF;
            border-color: #BEE3F8;
            color: #2B6CB0;
            cursor: pointer;
        }
        #dataTable .tabulator-page:disabled {
            opacity: .4;
            cursor: not-allowed;
        }

        .dayselect,
        .monthSet {
            height: 30px;
            padding: 0 8px;
            font-size: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #f9f9f9;
            color: #333;
            outline: none;
            box-sizing: border-box;
            transition: border-color .2s ease, background-color .2s ease;
        }
        .dayselect:focus,
        .monthSet:focus {
            border-color: #3182CE;
            background-color: #fff;
        }
         .mid{
        margin-right: 9px;
	    font-size: 20px;
	    font-weight: bold;

	    height: 42px;
	    margin-left: 9px;
        }
        .row_select {
	    background-color: #ffeeba !important;
	    }
	    .excel-upload-button {
  		  height: 40px;
  		  background-color: white;
   		 border: 1px solid black;
   		 border-radius: 4px;
   		 padding: 4px 10px;
   		 display: flex;
  		  align-items: center;
  		  gap: 5px;
  		  cursor: pointer;
}

.button-image {
    width: 16px;
    height: 16px;
}

        .btn-print {
		    background: none;
		    border: none;
		    padding: 0;
		    cursor: pointer;
		    font-size: 1.2rem;
		    outline: none;
		}

		.btn-print:hover {
		    opacity: 0.7;
		}
    </style>

<body>
    <div class="tab">
        <div class="box1">
            <!-- <label class="daylabel">설비명 :</label>
            <select id="fac_no" class="machine_select">
            <option value="" selected>전체</option>
            <option value="BCF1">BCF1</option>
            <option value="BCF2">BCF2</option>
            <option value="BCF3">BCF3</option>
            <option value="BCF4">BCF4</option>
            <option value="BCF4">BCF5</option>
            </select> -->

            <label class="daylabel">월 선택 :</label>
            <input type="month" id="lotno_date" class="dayselect monthSet"/>
        </div>

        <div class="button-container">
            <button class="select-button">
                <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">조회
            </button>

            <button class="excel-button">
                <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">엑셀
            </button>
        </div>
    </div>

    <main class="main">
        <div class="view">
            <div id="dataTable"></div>
        </div>
    </main>
    
<script>
let now_page_code = "b07";
var dataTable;
var selectedRowData = null;
var lotno_date;
var date = new Date();

$(function() {
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var thisMonthFormatted = year + '-' + month;
    $('#lotno_date').val(thisMonthFormatted);
    
    getList();
});

// 이벤트
$('.select-button').click(function() {
    getList();
});

// 엑셀 다운로드
$('.excel-button').click(function() {
    if (dataTable) {
        dataTable.download("xlsx", "LOT보고서.xlsx", {
            sheetName: "LOT 보고서",
            visibleColumnsOnly: false
        });
    }
});

	// 함수
	function getList() {
    $.ajax({
        url: "/tkheat/production/lotReport/getLotList",
        type: "POST",
        data: {
            lotno_date: $('#lotno_date').val()
        },
        success: function(response) {
            console.log("✅ 서버 응답:", response);
            
            
            if (dataTable) {
                dataTable.destroy();
            }
            
            dataTable = new Tabulator('#dataTable', {
                height: '100%',
                layout: 'fitDataFill',
                headerSort: false,
                reactiveData: true,
                columnHeaderVertAlign: "middle",
                headerHozAlign: 'center',
                data: response.data,
                placeholder: "조회된 데이터가 없습니다.",
                pagination: "local",
                paginationSize: 20,
                paginationSizeSelector: [20, 50, 100, 500, 1000],
                paginationCounter: "rows",
                rowFormatter: function (row) {
                    row.getElement().style.fontWeight = "600";
                },
                columns: [
                    { title: "LOT 번호", field: "ilbo_lot", width: 230, hozAlign: "center" },
                    { title: "시작 시간", field: "ilbo_strt", width: 200, hozAlign: "center" },
                    { title: "종료 시간", field: "ilbo_end", width: 200, hozAlign: "center" },
                    { 
                        title: "작업구분", 
                        field: "ilbo_gubn", 
                        width: 100, 
                        hozAlign: "center",
                        formatter: function(cell) {
                            const val = cell.getValue();
                            if (val === 'J') return '단취';
                            if (val === 'A') return '열처리';
                            if (val === 'R') return '템퍼링';
                            return val;
                        }
                    },
                    { title: "설비", field: "fac_name", width: 150, hozAlign: "center" },
                    { title: "거래처", field: "corp_name", width: 150, hozAlign: "center" },
                    { title: "품명", field: "prod_name", width: 250, hozAlign: "center" },
                    { title: "품번", field: "prod_no", width: 180, hozAlign: "center" },
                    {
                        title: "LOT보고서 저장",
                        field: "print",
                        width: 150,
                        hozAlign: "center",
                        headerSort: false,
                        formatter: function(cell, formatterParams, onRendered) {
                            return "<button class='btn-print'>💾</button>";
                        },
                        cellClick: function(e, cell) {
                            var rowData = cell.getRow().getData();
                            printLotReport(rowData);
                        }
                    }
                ]
            });
            
            $("#dataTable .tabulator-col.tabulator-sortable").css("height", "55px");
        },
        error: function(xhr, status, error) {
            console.error("❌ AJAX 에러:", status, error);
            console.error("❌ 응답 상태:", xhr.status);
            console.error("❌ 응답 내용:", xhr.responseText);
            
            alert("데이터 조회 중 오류가 발생했습니다.\n상태: " + xhr.status + "\n내용: " + xhr.responseText);
        }
    });

    function printLotReport(rowData){
        if(rowData){
            console.log("저장할 LOT:", rowData.ilbo_lot);

            $.ajax({
                url: "/tkheat/production/lotReport/lotPrint",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({ 
                	ilbo_lot: rowData.ilbo_lot,
                    ilbo_strt: rowData.ilbo_strt,
                    fac_no: rowData.fac_no }), 
                xhrFields: {
                    responseType: 'blob' // PDF 바이너리 처리
                },
                success: function(blob){
                    // PDF 다운로드
                    var link = document.createElement('a');
                    link.href = window.URL.createObjectURL(blob);
                    link.download = rowData.lot_no + ".pdf";
                    document.body.appendChild(link);
                    link.click();
                    document.body.removeChild(link);
                    window.URL.revokeObjectURL(link.href);
                },
                error: function(xhr, status, error){
                    console.error("PDF 생성 실패:", error);
                }
            });

        } else {
            console.log("rowData가 없습니다.");
        }
		  };
}

</script>

</body>
</html>