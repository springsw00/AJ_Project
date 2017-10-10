<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
<script type="text/javascript" src="resources/fullcalendar/moment.min.js"></script>
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
.border-btm{
	border-bottom: 1px solid #aaa;
}

</style>
<script type="text/javascript">
	$(function(){
		var id = '${id}';
		var year = '${year}';
		var month = '${month}';
		if(id != ""){
			//alert(id);
			$("#receiveID").val(id);
		}
		
		if(year != "" && month != ""){
			//alert(year + "/" + month);
			$("#y_opt_${year}").attr("selected","selected");
		}
		
		var firstDay = '20${arList[0].ar_Date}';
		var weekChk = moment(firstDay).day();
		$(".dlist").each(function(index){
			if((weekChk +index)%7 == 0 || (weekChk +index)%7 == 6){
				$(this).css('color','red');
			}
			if((weekChk +index)%7 == 0){
				$(this).children().css('border-bottom','1px solid #aaa');
			}
		});
	});
	
	
</script>
</head>
<body>
	<input type="hidden" id="receiveID">
	<table id="ar_table">
		<thead>
			<tr>
				<th>날짜</th>
				<th>출근</th>
				<th>퇴근</th>
				<th>IP</th>
				<th>근무시간</th>
			</tr>
		</thead>
		<tbody>
			
			<c:forEach var="vo" items="${arList }" varStatus="i">
				<tr class="dlist">
					<td>20${vo.ar_Date }</td>
					<td>
						<c:choose>
							<c:when test="${empty vo.startTime }">-</c:when>
							<c:otherwise> ${vo.startTime }</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
								<c:when test="${empty vo.endTime }">-</c:when>
								<c:otherwise> ${vo.endTime }</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
								<c:when test="${empty vo.ip }">-</c:when>
								<c:otherwise> ${vo.ip }</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
								<c:when test="${empty vo.workTime }">-</c:when>
								<c:otherwise> ${vo.workTime }</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot></tfoot>
	</table>
			
</body>
</html>