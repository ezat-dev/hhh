<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통합모니터링</title>
    <link rel="stylesheet" href="/tkheat/css/monitoring/monitoring.css">
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
div{
	text-align : center;
}
    
    
    </style>
    
    
    <body>
    
   
    <main class="main">
    <div class="rectangle_12" style="font-size:40px; font-weight:550; display: flex; align-items: center; justify-content: center; ">설비명</div>
    <div class="rectangle_2" style="font-size:40px; font-weight:550; display: flex; align-items: center; justify-content: center; ">고객사</div>
    <div class="rectangle_3" style="font-size:40px; font-weight:550; display: flex; align-items: center; justify-content: center;">품명</div>
    <div class="rectangle_4" style="font-size:40px; font-weight:550; display: flex; align-items: center; justify-content: center;">LOT NO</div>
    <div class="rectangle_6" style="font-size:25px; font-weight:550; display: flex; align-items: center; justify-content: center;">공정현황</div>
    <div class="rectangle_7" style="font-size:20px; font-weight:550; display: flex; align-items: center; justify-content: center;">승온</div>
    <div class="rectangle_8" style="font-size:20px; font-weight:550; display: flex; align-items: center; justify-content: center;">본처리</div>
    <div class="rectangle_9" style="font-size:20px; font-weight:550; display: flex; align-items: center; justify-content: center;">강온</div>
    <div class="rectangle_10" style="font-size:20px; font-weight:550; display: flex; align-items: center; justify-content: center;">냉각</div>
    <div class="rectangle_11" style="font-size:20px; font-weight:550; display: flex; align-items: center; justify-content: center;">공로</div>
    <div class="rectangle_13" style="font-size:40px; font-weight:550; display: flex; align-items: center; justify-content: center;">침탄1호기</div>
    <div class="rectangle_14" style="font-size:40px; font-weight:550; display: flex; align-items: center; justify-content: center;">침탄2호기</div>
    <div class="rectangle_15" style="font-size:40px; font-weight:550; display: flex; align-items: center; justify-content: center;">침탄3호기</div>
    <div class="rectangle_16" style="font-size:40px; font-weight:550; display: flex; align-items: center; justify-content: center;">침탄4호기</div>
    <div class="rectangle_17" style="font-size:40px; font-weight:550; display: flex; align-items: center; justify-content: center;">침탄5호기</div>
    <div class="rectangle_58" style="font-size:35px; font-weight:550; display: flex; align-items: center; justify-content: center;">템퍼링 1호기</div>
    <div class="rectangle_61" style="font-size:35px; font-weight:550; display: flex; align-items: center; justify-content: center;">템퍼링 2호기</div>
    <div class="rectangle_63" style="font-size:35px; font-weight:550; display: flex; align-items: center; justify-content: center;">변성로 1호기</div>
    <div class="rectangle_65" style="font-size:35px; font-weight:550; display: flex; align-items: center; justify-content: center;">변성로 2호기</div>
    <div class="rectangle_67" style="font-size:45px; font-weight:550; display: flex; align-items: center; justify-content: center;">세정기</div>
    <div class="chim_1_heat"></div>
    <div class="chim_1_bon"></div>
    <div class="chim_1_gangon"></div>
    <div class="chim_1_cool"></div>
    <div class="chim_1_gonglo"></div>
    <div class="chim_2_heat"></div>
    <div class="chim_2_bon"></div>
    <div class="chim_2_gangon"></div>
    <div class="chim_2_cool"></div>
    <div class="chim_2_gonglo"></div>
    <div class="chim_3_heat"></div>
    <div class="chim_3_bon"></div>
    <div class="chim_3_gangon"></div>
    <div class="chim_3_cool"></div>
    <div class="chim_3_gonglo"></div>
    <div class="chim_4_heat"></div>
    <div class="chim_4_bon"></div>
    <div class="chim_4_gangon"></div>
    <div class="chim_4_cool"></div>
    <div class="chim_4_gonglo"></div>
    <div class="chim_5_heat"></div>
    <div class="chim_5_bon"></div>
    <div class="chim_5_gangon"></div>
    <div class="chim_5_cool"></div>
    <div class="chim_5_gonglo"></div>
    <div class="tem_1_gong"></div>
    <div class="chim_1_cutum"></div>
    <div class="chim_1_pum"></div>
    <div class="chim_1_lot"></div>
    <div class="chim_2_cutum"></div>
    <div class="chim_2_pum"></div>
    <div class="chim_2_lot"></div>
    <div class="chim_3_cutum"></div>
    <div class="chim_3_pum"></div>
    <div class="chim_3_lot"></div>
    <div class="chim_4_cutum"></div>
    <div class="chim_4_pum"></div>
    <div class="chim_4_lot"></div>
    <div class="chim_5_cutum"></div>
    <div class="chim_5_pum"></div>
    <div class="chim_5_lot"></div>
    <div class="tem_1_cutum"></div>
    <div class="tem_1_pum"></div>
    <div class="tem_1_lot"></div>
    <div class="tem_2_gong"></div>
    <div class="tem_2_cutum"></div>
    <div class="tem_2_pum"></div>
    <div class="tem_2_lot"></div>
    <div class="byun_1_gong"></div>
    <div class="byun_1_cutum"></div>
    <div class="byun_1_pum"></div>
    <div class="byun_1_lot"></div>
    <div class="byun_2_gong"></div>
    <div class="byun_2_cutum"></div>
    <div class="byun_2_pum"></div>
    <div class="byun_2_lot"></div>
    <div class="clean_gong"></div>
    <div class="clean_cutum"></div>
    <div class="clean_pum"></div>
    <div class="clean_lot"></div>
	</main>
	    
	    
<script>

	//로드
	$(function(){
		getMonitoringList();
		
	});
	


	function getMonitoringList(){
		$.ajax({
			url: "/tkheat/monitoring/getMonitoringList",
			type: "post",
			dataType: "json",
			success: function(result){
				var data = result.data;
				
				data.forEach(function(monitoring){
					let gb = monitoring.gb;
					console.log(monitoring);
					if(monitoring.pum) {
						$("." +gb+"pum").html(monitoring.pum);
					}
					if(monitoring.heat) {
						$("." +gb+"heat").html(monitoring.heat);
					}
					if(monitoring.cutum) {
						$("." +gb+"cutum").html(monitoring.cutum);
					}
					if(monitoring.lot) {
						$("." +gb+"lot").html(monitoring.lot);
					}
					if(monitoring.bon) {
						$("." +gb+"bon").html(monitoring.bon);
					}
					if(monitoring.gangon) {
						$("." +gb+"gangon").html(monitoring.gangon);
					}
					if(monitoring.cool) {
						$("." +gb+"cool").html(monitoring.cool);
					}
					if(monitoring.gonglo) {
						$("." +gb+"gonglo").html(monitoring.gonglo);
					}
					if(monitoring.gong) {
						$("." +gb+"gong").html(monitoring.gong);
					}
				});
			}
		});
	}

	

	

    </script>

	</body>
</html>
