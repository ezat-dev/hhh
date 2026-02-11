<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LOT 보고서</title>
	<%@include file="../include/pluginpage.jsp" %> 
</head>
    <style>
        .container {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            margin-left: 1008px;
            margin-top: 200px;
        }
        .view {
            display: flex;
            justify-content: center;
            margin-top: 1%;
        }
        .tab {
            width: 95%;
            margin-bottom: 37px;
            margin-top: 5px;
            height: 45px;
            border-radius: 6px 6px 0px 0px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .button-container {
    		display: flex;
		    gap: 10px;
		    margin-left: auto;
		    margin-right: 10px;
		    margin-top: 40px;
		}
		.box1 {
		    display: flex;
		    justify-content: right;
		    align-items: center;
		    width: 800px;
		    margin-right: 20px;
		    margin-top:4px;
		}
        .dayselect {
            width: 20%;
            text-align: center;
            font-size: 15px;
        }
        .daySet {
        	width: 20%;
      		text-align: center;
            height: 16px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
        .daylabel {
            margin-right: 10px;
            margin-bottom: 13px;
            font-size: 18px;
            margin-left: 20px;
        }
        button-container.button{
        height: 16px;
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
	    .excel-download-button,
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

        .monthSet {
        	width: 20%;
      		text-align: center;
            height: 17px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }
         .machine_select {
        	width: 20%;
      		text-align: center;
            height: 35px;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
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
    <main class="main">
        <div class="tab">
            <div class="button-container">
            
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
				
                <button class="select-button">
                    <img src="/tkheat/image/search-icon.png" alt="select" class="button-image">조회
                </button>
                
                <button class="excel-download-button">
                    <img src="/tkheat/image/excel-icon.png" alt="excel" class="button-image">엑셀
                </button>
                
            </div>
        </div>

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
$('.excel-download-button').click(function() {
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
                height: '720px',
                layout: 'fitDataFill',
                headerSort: false,
                reactiveData: true,
                columnHeaderVertAlign: "middle",
                headerHozAlign: 'center',
                data: response.data,
                placeholder: "조회된 데이터가 없습니다.",
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