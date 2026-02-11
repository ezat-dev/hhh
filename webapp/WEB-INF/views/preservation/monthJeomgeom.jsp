<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>설비점검현황(월별)</title>
    <link rel="stylesheet" href="/tkheat/css/management/productInsert.css">
    <link rel="stylesheet" href="/tkheat/css/tabBar/tabBar.css">
<%@include file="../include/pluginpage.jsp" %> 
    <style>
    
.main{
	width:98%;
}
.container {
	display: flex;
	justify-content: space-between;
}
.tabulator {
	width: 100%;
	max-width: 100%;
	max-height: 900px;
	overflow-x: hidden !important;  
}
        
.tabulator .tabulator-cell {
	white-space: normal !important;
	word-break: break-word; 
	text-align: center;
}
        
.row_select{
	background-color:#9ABCEA !important;
}


.btnSaveClose {
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	gap: 20px; /* 버튼 사이 여백 */
	margin-top: 30px; /* 모달 내용과의 간격 */
	margin-bottom: 20px; /* 모달 하단과 버튼 사이 간격  */
}
.btnSaveClose button {
	width: 100px;
	height: 35px;
	background-color: #FFD700; /* 기본 배경 - 노란색 */
	color: black;
	border: 2px solid #FFC107; /* 노란 테두리 */
	border-radius: 5px;
	font-weight: bold;
	text-align: center;
	cursor: pointer;
	line-height: 35px;
	margin: 0 10px;
	margin-top: 10px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

/* 저장 버튼 호버 시 */
.btnSaveClose .save:hover {
	background-color: #FFC107;
	transform: scale(1.05);
}

/* 닫기 버튼 - 회색 톤 */
.btnSaveClose .close {
	background-color: #A9A9A9;
	color: black;
	border: 2px solid #808080;
}

/* 닫기 버튼 호버 시 */
.btnSaveClose .close:hover {
	background-color: #808080;
	transform: scale(1.05);
}
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -400px;
}

.box1 select{
	width: 5%
}  
.box1 input[type="text"] {
	width: 100px;
	padding: 5px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	color: #333;
	outline: none;
	transition: border 0.3s ease;
}

.box1 input[type="text"]:focus {
	border: 1px solid #007bff;
	background-color: #fff;
}  
.box1 label,
.box1 input {
	margin-right: 10px; /* 요소 사이 간격 */
} 

.dayJeomgeomModal {
	position: fixed; /* 화면에 고정 */
	top: 50%; /* 수직 중앙 */
	left: 50%; /* 수평 중앙 */
	display: none;
	transform: translate(-50%, -50%); /* 정확한 중앙 정렬 */
	z-index: 1000; /* 다른 요소 위에 표시 */
}
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}

.modal-content {
  background: white;
  padding: 20px 30px;
  border-radius: 10px;
  width: 90%;
  position: relative;
  box-shadow: 0 0 15px rgba(0, 0, 0, 0.3);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
  font-size: 20px;
  margin-bottom: 20px;
}

.modal-close {
  cursor: pointer;
  font-size: 28px;
}

.modal-form {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 15px 30px;
  margin-bottom: 20px;
}

.form-row {
  display: flex;
  flex-direction: column;
}

.form-row label {
  font-weight: bold;
  margin-bottom: 6px;
  font-size: 14px;
}

.modal-form-inline {
  display: flex;
  flex-wrap: wrap; /* 혹시 너비 넘치면 줄바꿈 */
  align-items: center;
  gap: 10px;
  margin-bottom: 15px;
  flex-wrap: nowrap; /* 가능한 한 줄 유지 */
  overflow-x: auto;
}

.modal-form-inline label {
  font-size: 14px;
  font-weight: bold;
}

.input-field {
  font-size: 14px;
  padding: 5px 8px;
  width: 150px;
  min-width: 130px;
  max-width: 180px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
    
    .subSearch {
  padding: 6px 14px;
  font-size: 14px;
  background-color: #3498db;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  white-space: nowrap;
  transition: background-color 0.2s ease;
}

.subSearch:hover {
  background-color: #2980b9;
}
.box1 {
	display: flex;
	justify-content: right;
	align-items: center;
	width: 1500px;
	margin-left: -1170px;
}

.box1 select{
	width: 5%
}  
.box1 input[type="date"] {
	width: 150px;
	padding: 5px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	color: #333;
	outline: none;
	transition: border 0.3s ease;
}

.box1 input[type="date"]:focus {
	border: 1px solid #007bff;
	background-color: #fff;
}
.box1 input[type="month"] {
	width: 150px;
	padding: 5px 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 6px;
	background-color: #f9f9f9;
	color: #333;
	outline: none;
	transition: border 0.3s ease;
}

.box1 input[type="month"]:focus {
	border: 1px solid #007bff;
	background-color: #fff;
}    
.box1 label,
.box1 input {
	margin-right: 10px; /* 요소 사이 간격 */
} 
    </style>
    
    
    <body>
    
    <div class="tab">
    <div class="box1">
         <p class="tabP" style="font-size: 20px; margin-left: 40px; color: white; font-weight: 800;"></p>        
		<label class="daylabel">날짜선택 : </label>
		<input type="month" class="sdate" id="sdate" style="font-size: 16px;" autocomplete="off">
				
	</div>
    <div class="button-container">
        <button class="select-button" onclick="getMonthJeomgeomList();">
            <img src="/tkheat/css/image/search-icon.png" alt="select" class="button-image">
           조회
        </button>
        <button class="insert-button">
            <img src="/tkheat/css/image/insert-icon.png" alt="insert" class="button-image">
         입력 
        </button>
        <button class="excel-button">
            <img src="/tkheat/css/image/excel-icon.png" alt="excel" class="button-image">
        엑셀    
        </button>
        <button class="printer-button">
            <img src="/tkheat/css/image/printer-icon.png" alt="printer" class="button-image">
       보고서출력     
        </button>
    </div>
</div>
    <main class="main">
		<div class="container">
			<div id="tab1" class="tabulator"></div>
		</div>
	</main>
	
	
	
	
	
<script>
let now_page_code = "e07";
  var userTable;

  $(function () {
    // 현재 날짜를 yyyy-MM 형식으로 포맷
    const today = new Date();
    const year = today.getFullYear();
    const month = String(today.getMonth() + 1).padStart(2, "0"); // 01~12
    const todayYM = `${year}-${month}`;

    // input type="month"에 기본값 설정
    $("#sdate").val(todayYM);

    // 기본값 기준으로 리스트 조회 실행
    getMonthJeomgeomList();

    // sdate 변경 시 재조회
    $("#sdate").on("change", function () {
      getMonthJeomgeomList();
    });
  });

  function getMonthJeomgeomList() {
    const sdate = $("#sdate").val();
    console.log("현재 sdate:", sdate);

    if (!sdate) {
      console.warn("sdate가 비어있음");
      return;
    }

    const [year, month] = sdate.split("-").map(Number);
    const lastDay = new Date(year, month, 0).getDate();

    let dayColumns = [];
    for (let day = 1; day <= lastDay; day++) {
      const date = new Date(year, month - 1, day);
      const weekday = ["일", "월", "화", "수", "목", "금", "토"][date.getDay()];
      const field = "mm" + day;

      dayColumns.push({
        title: weekday,
        headerHozAlign: "center",
        headerSort: false,
        columns: [{
          title: String(day),
          field: field,
          width: 20,
          hozAlign: "center",
          headerSort: false,
        }]
      });
    }

    let columns = [
      {
        title: "설비공정종류",
        field: "tech_ht",
        sorter: "string",
        width: 80,
        hozAlign: "center",
        headerSort: false,
        headerFilter: "select",
        headerFilterParams: {
          values: {
            "": "all",
            "이온질화": "이온질화",
            "진공로": "진공로",
            "템퍼링로": "템퍼링로",
            "Box Type": "Box Type",
            "PQ": "PQ",
            "Salt": "Salt"
          }
        }
      },
      {
        title: "설비",
        field: "fac_name",
        sorter: "string",
        width: 80,
        hozAlign: "center",
        headerSort: false,
        headerFilter: "select",
        headerFilterParams: {
          values: {
            "": "all",
            "고주파 1호기(폐기)": "고주파 1호기(폐기)",
            "고주파 2호기 (폐기)": "고주파 2호기 (폐기)",
            "고주파 5호기": "고주파 5호기",
            "급수시설": "급수시설",
            "변성로 1호기": "변성로 1호기",
            "변성로 2호기": "변성로 2호기",
            "쇼트 1호기": "쇼트 1호기",
            "쇼트 2호기": "쇼트 2호기",
            "쇼트 3호기": "쇼트 3호기",
            "쇼트 4호기": "쇼트 4호기",
            "전기시설": "전기시설",
            "진공세정기 2호기": "진공세정기 2호기",
            "침탄로 1호기": "침탄로 1호기",
            "침탄로 2호기": "침탄로 2호기",
            "침탄로 3호기": "침탄로 3호기",
            "침탄로 4호기": "침탄로 4호기",
            "침탄로 5호기": "침탄로 5호기",
            "콤프레샤": "콤프레샤",
            "템퍼링기 1호기": "템퍼링기 1호기",
            "템퍼링기 2호기": "템퍼링기 2호기"
          }
        }
      },
      { title: "점검주기", field: "chs_gubn", sorter: "string", width: 40, hozAlign: "center", headerSort: false },
      { title: "구분", field: "chs_gubn_detail", sorter: "string", width: 40, hozAlign: "center", headerSort: false },
      { title: "순번", field: "chs_sort", sorter: "string", width: 40, hozAlign: "center", headerSort: false },
      { title: "점검항목", field: "chs_hang", sorter: "string", width: 90, hozAlign: "center", headerSort: false },
      { title: "기준방법", field: "chs_kijun", sorter: "string", width: 90, hozAlign: "center", headerSort: false },
      ...dayColumns,
      { title: "비고", field: "che_bigo", sorter: "string", width: 60, hozAlign: "center", headerSort: false },
      // { title: "사진", field: "chs_img", sorter: "string", width: 60, hozAlign: "center", headerSort: false },
    ];

    if (userTable) {
      userTable.destroy();
    }

    userTable = new Tabulator("#tab1", {
      height: "750px",
      layout: "fitColumns",
      selectable: true,
      tooltips: true,
      selectableRangeMode: "click",
      reactiveData: true,
      headerHozAlign: "center",
      ajaxURL: "/tkheat/preservation/monthJeomgeom/getMonthJeomgeomList",
      ajaxConfig: "POST",
      ajaxParams: { sdate: sdate },
      ajaxLoader: false,
      ajaxProgressiveLoad: "scroll",
      paginationSize: 20,
      headerFilterPlaceholder: "",
      placeholder: "조회된 데이터가 없습니다.",
      columns: columns,
      groupBy: "fac_name",
      groupStartOpen: true,
      groupHeader: function (value, count, data) {
        return `${value} (${count} 항목)`;
      },
      ajaxResponse: function (url, params, response) {
        $("#tab1 .tabulator-col.tabulator-sortable").css("height", "50px");
        console.log("📦 조회된 데이터:", response);
        return response;
      },
      rowFormatter: function (row) {
        row.getElement().style.fontWeight = "700";
        row.getElement().style.backgroundColor = "#FFFFFF";
      },
      rowClick: function (e, row) {
        $("#tab1 .tabulator-tableHolder .tabulator-row").removeClass("row_select");
        row.getElement().classList.add("row_select");
        const rowData = row.getData();
        console.log("🟩 클릭한 행 데이터:", rowData);
      },
    });
  }
</script>
	


	</body>
</html>
