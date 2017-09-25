<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.float_left_menu {
	padding: 0px;
	margin: 0px;
	float: left;
	border: 1px solid #aaa;
	width: 150px;
	height: inherit;	
}
.float_left {
	padding: 0px;
	margin: 0 0 0 10px;
	float: left;
	border: 1px solid #aaa;
	width: 650px;
	height: inherit;	
}

#arView{
	width: inherit-15;
	height: inherit;
}

#ar_table {
	width: 100%;
	border: 1px solid #aaa;
}
#ar_table th {
	height: 30px;
}

.display-none{
	display: none;
}
</style>
<script type="text/javascript">
	$(function(){
		// 올해 이번달 기본선택
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		var day = date.getDate();
		
		$("#y_opt").val(year).prop("selected", true);
		$("#m_opt").val(month).prop("selected", true);
		
		function getLastDay(year, month){
			var date = new Date(year, month, 0);
			return date.getDate();
		}
		
		$("#arView").load('goARView2.do');
		
		$(".inDept").click(function(){
			//alert($(this).attr("id"));
			
			$("#arView").load('goARView2.do', {id:$(this).attr("id")}, function(){});

			$("#date_select_div_dept").addClass("display-none");
			$("#date_select_div_my").removeClass("display-none");
		});
		
		
	});
	
	function showMyAR(){
		$("#arView").load('goARView2.do');
		$("#date_select_div_dept").addClass("display-none");
		$("#date_select_div_my").removeClass("display-none");
	}
	
	function showDeptAR(){
		$("#arView").load('goDeptARView.do',function(responseTxt, statusTxt, xhr){
			if(statusTxt == "success")
	            //alert(responseTxt);
	        if(statusTxt == "error")
	            alert("Error: " + xhr.status + ": " + xhr.statusText);
		});
		$("#date_select_div_dept").removeClass("display-none");
		$("#date_select_div_my").addClass("display-none");
		
		
	}
	
	function showSelectdate(){		
		//alert($("#y_opt").val()+'/'+$("#m_opt").val());
		//var id = ;
		
		$("#arView").load('goARView2.do', {year:$("#y_opt").val(), month:$("#m_opt").val(), id:$("#receiveID").val()}, function(){});
	}
	
	function showSelectdateDept(){
		//alert($("#input-date").val());
		$("#arView").load('goDeptARView.do', {inputdate:$("#input-date").val()}, function(){});
	}
	
	

</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div class="float_left_menu">
				<a href="#" onclick="showMyAR()">내 근태 현황</a>
				<hr>
				<c:if test="${!empty deptSuper }">
					<a href="#" onclick="showDeptAR()">부서 근태 현황</a>
					<br>	
					<c:forEach var="k" items="${empList}">
						&nbsp;&nbsp;&nbsp;<a href="#" class="inDept" id="${k.id}"> - ${k.name}</a><br>										
					</c:forEach>
					<input type="hidden" name="" id="selectedID">
					<hr>
				</c:if>
				<c:if test="${empDeptID == 'PRMT' } ">
				<!-- 인사관리팀이면 보여줄 페이지 -->
					<a href="#" onclick="showDeptAR()">전 사원 근태 현황</a>
				</c:if>
			</div>
			<div class="float_left use-scroll" >
				<div class="align-center" id="date_select_div_my">
					<select name="year" id="y_opt">
						<option id="y_opt_2016" value="2016">2016</option>
						<option id="y_opt_2017" value="2017">2017</option>
					</select> 년 <select name="month" id="m_opt">
						<c:forEach begin="1" end="12" var="k">
							<option id="m_opt_${k}">${k }</option>
						</c:forEach>
					</select> 월 
					<input type="button" onclick="showSelectdate()" value="이동">
				</div>
				<div class="align-center display-none" id="date_select_div_dept">
					<input type="date" name="date" id="input-date">
					<input type="button" onclick="showSelectdateDept()" value="이동">
				</div>
				<div id="arView">
				
				</div>
			</div>
			
		</div>
	</form>
</body>
</html>