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

#ar_table {
	width: 100%;
	border: 1px solid #aaa;
}
#ar_table th {
	height: 30px;
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
	});
	

</script>
</head>
<body>
	<form id="main_form">
		<jsp:include page="../layout.jsp" />
		<div id="main_board">
			<div class="float_left_menu">
				<a href="#">내 근태 현황</a>
				<hr>
			</div>
			<div class="float_left use-scroll">
				<table id="ar_table">
					<thead>
						<tr>
							<th colspan="5" class="align-center">
								<select name="year" id="y_opt">
									<option id="y_opt_2016" value="2016">2016</option>
									<option id="y_opt_2017" value="2017">2017</option>
								</select>
								년
								<select name="month" id="m_opt">
									<c:forEach begin="1" end="12" var="k">
										<option id="m_opt_${k}">${k }</option>
									</c:forEach>
								</select>
								월
							</th>
						</tr>
						<tr>
							<th>날짜</th>
							<th>출근</th>
							<th>퇴근</th>
							<th>IP</th>
							<th>근무시간</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach begin="1" end="${lastDay}" var="k">
							<tr>
								<td>${year }/${month }/${k}</td>
								<td>출근 </td>
								<td>퇴근</td>
								<td>IP</td>
								<td>근무시간</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot></tfoot>
				</table>
			</div>
			
		</div>
	</form>
</body>
</html>